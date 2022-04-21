Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D84509E60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 13:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388761AbiDULRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 07:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388767AbiDULRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:17:37 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC33D25E82;
        Thu, 21 Apr 2022 04:14:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VAeULot_1650539681;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VAeULot_1650539681)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 19:14:43 +0800
Date:   Thu, 21 Apr 2022 19:14:40 +0800
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
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 19/21] erofs: implement fscache-based data read for
 inline layout
Message-ID: <YmE8oHQiIF1IJAkr@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <20220415123614.54024-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-20-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 08:36:12PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for inline layout.
> 
> For the heading non-inline part, the data plane for non-inline layout is
> reused, while only the tail packing part needs special handling.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index b799b0fe1b67..08849c15500f 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -84,6 +84,33 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage_inline(struct folio *folio,
> +					 struct erofs_map_blocks *map)
> +{
> +	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> +	erofs_blk_t blknr;
> +	size_t offset, len;
> +	void *src, *dst;
> +
> +	/* For tail packing layout, the offset may be non-zero. */
> +	offset = erofs_blkoff(map->m_pa);
> +	blknr = erofs_blknr(map->m_pa);
> +	len = map->m_llen;
> +
> +	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
> +	if (IS_ERR(src))
> +		return PTR_ERR(src);
> +
> +	dst = kmap_local_folio(folio, 0);
> +	memcpy(dst, src + offset, len);
> +	memset(dst + len, 0, PAGE_SIZE - len);
> +	kunmap_local(dst);
> +
> +	erofs_put_metabuf(&buf);
> +	return 0;
> +}
> +
>  static int erofs_fscache_readpage(struct file *file, struct page *page)
>  {
>  	struct folio *folio = page_folio(page);
> @@ -109,6 +136,11 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
>  		goto out_uptodate;
>  	}
>  
> +	if (map.m_flags & EROFS_MAP_META) {
> +		ret = erofs_fscache_readpage_inline(folio, &map);
> +		goto out_uptodate;
> +	}
> +
>  	mdev = (struct erofs_map_dev) {
>  		.m_deviceid = map.m_deviceid,
>  		.m_pa = map.m_pa,
> -- 
> 2.27.0
