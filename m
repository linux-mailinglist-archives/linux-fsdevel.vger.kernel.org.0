Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE044E92D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 12:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiC1K50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiC1K50 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:57:26 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF01C24F1C;
        Mon, 28 Mar 2022 03:55:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8R4iF-_1648464938;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8R4iF-_1648464938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 18:55:40 +0800
Date:   Mon, 28 Mar 2022 18:55:38 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v6 21/22] erofs: implement fscache-based data readahead
Message-ID: <YkGUKlCstdl9TnY+@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-22-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-22-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:22:22PM +0800, Jeffle Xu wrote:
> Implements fscache-based data readahead. Also registers an individual
> bdi for each erofs instance to enable readahead.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/super.c   |   4 ++
>  2 files changed, 118 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index cbb39657615e..589d1e7c2b1b 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -191,12 +191,126 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> +static inline size_t erofs_fscache_calc_len(struct erofs_map_blocks *map,
> +					    size_t len, size_t done)
> +{
> +	/*
> +	 * 1) For CHUNK_BASED layout, the output m_la is rounded down to the
> +	 * nearest chunk boundary, and the output m_llen actually starts from
> +	 * the start of the containing chunk.
> +	 * 2) For other cases, the output m_la is equal to o_la.
> +	 */
> +	size_t length = map->m_llen - (map->o_la - map->m_la);
> +
> +	return min_t(size_t, length, len - done);

This helper can be folded too.

> +}
> +
> +static inline void erofs_fscache_unlock_folios(struct readahead_control *rac,
> +					       size_t len)
> +{
> +	while (len) {
> +		struct folio *folio = readahead_folio(rac);
> +
> +		len -= folio_size(folio);
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +	}
> +}
> +
> +static void erofs_fscache_readahead(struct readahead_control *rac)
> +{
> +	struct inode *inode = rac->mapping->host;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	size_t len, done = 0;
> +	loff_t start;
> +	int ret;
> +
> +	if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +		erofs_info(sb, "compressed layout not supported yet");
> +		return;
> +	}

Redundant check.

> +
> +	if (!readahead_count(rac))
> +		return;
> +
> +	start = readahead_pos(rac);
> +	len = readahead_length(rac);
> +
> +	do {
> +		struct erofs_map_blocks map;
> +
> +		map.m_la = map.o_la = start + done;
> +
> +		ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +		if (ret)
> +			return;
> +
> +		/* Read-ahead Hole
> +		 * Two cases will hit this:
> +		 * 1) EOF. Imposibble in readahead routine;
> +		 * 2) hole. Only CHUNK_BASED layout supports hole.
> +		 */

/*
 *
 */

and typo `Imposibble'. Also I think this comment may not be useful
though.

> +		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +			struct iov_iter iter;
> +			loff_t offset = start + done;
> +			size_t count = erofs_fscache_calc_len(&map, len, done);
> +
> +			iov_iter_xarray(&iter, READ, &rac->mapping->i_pages, offset, count);
> +			iov_iter_zero(count, &iter);
> +
> +			erofs_fscache_unlock_folios(rac, count);
> +			ret = count;
> +			continue;
> +		}
> +
> +		ret = erofs_fscache_get_map(&map, sb);
> +		if (ret)
> +			return;
> +
> +		/* Read-ahead Inline */
> +		if (map.m_flags & EROFS_MAP_META) {
> +			struct folio *folio = readahead_folio(rac);
> +
> +			ret = erofs_fscache_readpage_inline(folio, &map);
> +			if (!ret) {
> +				folio_mark_uptodate(folio);
> +				ret = folio_size(folio);
> +			}
> +
> +			folio_unlock(folio);
> +			continue;
> +		}
> +
> +		/* Read-ahead No-inline */
> +		if (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
> +		    vi->datalayout == EROFS_INODE_FLAT_INLINE ||
> +		    vi->datalayout == EROFS_INODE_CHUNK_BASED) {
> +			struct fscache_cookie *cookie = map.m_fscache->cookie;
> +			loff_t offset = start + done;
> +			size_t count = erofs_fscache_calc_len(&map, len, done);

You could promote `offset' and `count' to the outer block. So another
`offset' and `count' in !EROFS_MAP_MAPPED can be dropped then.

Thanks,
Gao Xiang
