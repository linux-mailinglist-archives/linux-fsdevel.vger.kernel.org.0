Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED74E8C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 05:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiC1DQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 23:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiC1DQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:16:36 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9D19FDA;
        Sun, 27 Mar 2022 20:14:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8KfeFt_1648437287;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8KfeFt_1648437287)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 11:14:49 +0800
Date:   Mon, 28 Mar 2022 11:14:47 +0800
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
Subject: Re: [PATCH v6 17/22] erofs: implement fscache-based data read for
 non-inline layout
Message-ID: <YkEoJ4qZidqfRPhy@B-P7TQMD6M-0146.local>
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
 <20220325122223.102958-18-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-18-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:22:18PM +0800, Jeffle Xu wrote:
> Implements the data plane of reading data from bootstrap blob file over
> fscache for non-inline layout.
> 
> Be noted that compressed layout is not supported yet.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  8 ++++-
>  fs/erofs/internal.h |  5 +++
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 91377939b4f7..4a9a4e60c15d 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -60,10 +60,93 @@ static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static inline int erofs_fscache_get_map(struct erofs_map_blocks *map,
> +					struct super_block *sb)

I wonder if m_fscache should be settled in struct erofs_map_dev

And such helper can be merged into erofs_map_dev() as well.

> +{
> +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +
> +	map->m_fscache	= sbi->bootstrap;
> +	return 0;
> +}
> +
> +static int erofs_fscache_readpage_noinline(struct folio *folio,
> +					   struct erofs_map_blocks *map)
> +{
> +	struct fscache_cookie *cookie = map->m_fscache->cookie;
> +	/*
> +	 * 1) For FLAT_PLAIN layout, the output map.m_la shall be equal to o_la,
> +	 * and the output map.m_pa is exactly the physical address of o_la.
> +	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
> +	 * nearest chunk boundary, and the output map.m_pa is actually the
> +	 * physical address of this chunk boundary. So we need to recalculate
> +	 * the actual physical address of o_la.
> +	 */
> +	loff_t start = map->m_pa + (map->o_la - map->m_la);

I think o_la can be directly replaced with "folio_pos(folio)".

Also such helper might be unneeded...

> +
> +	return erofs_fscache_read_folio(cookie, folio, start);
> +}
> +
> +static int erofs_fscache_do_readpage(struct folio *folio)

Can it fold into erofs_fscache_readpage?
Another unneeded helper...

> +{
> +	struct inode *inode = folio_file_mapping(folio)->host;
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_map_blocks map;
> +	int ret;
> +
> +	if (erofs_inode_is_data_compressed(vi->datalayout)) {

It's impossible for now. So the check above is redundant.

Thanks,
Gao Xiang

> +		erofs_info(sb, "compressed layout not supported yet");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
> +
> +	map.m_la = map.o_la = folio_pos(folio);
> +
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret)
> +		return ret;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		folio_zero_range(folio, 0, folio_size(folio));
> +		return 0;
> +	}
> +
> +	ret = erofs_fscache_get_map(&map, sb);
> +	if (ret)
> +		return ret;
> +
> +	switch (vi->datalayout) {
> +	case EROFS_INODE_FLAT_PLAIN:
> +	case EROFS_INODE_CHUNK_BASED:
> +		return erofs_fscache_readpage_noinline(folio, &map);
> +	default:
> +		DBG_BUGON(1);
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int erofs_fscache_readpage(struct file *file, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	int ret;
> +
> +	ret = erofs_fscache_do_readpage(folio);
> +	if (!ret)
> +		folio_mark_uptodate(folio);
> +
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_blob_aops = {
>  	.readpage = erofs_fscache_readpage_blob,
>  };
>  
> +const struct address_space_operations erofs_fscache_access_aops = {
> +	.readpage = erofs_fscache_readpage,
> +};
> +
>  /*
>   * erofs_fscache_get_folio - find and read page cache of blob file
>   * @ctx:	the context of the blob file
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index ff62f84f47d3..744faf3ef9f4 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -296,7 +296,13 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  		err = z_erofs_fill_inode(inode);
>  		goto out_unlock;
>  	}
> -	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +	if (erofs_is_nodev_mode(inode->i_sb))
> +		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> +#endif
> +	if (!erofs_is_nodev_mode(inode->i_sb))
> +		inode->i_mapping->a_ops = &erofs_raw_access_aops;
>  
>  out_unlock:
>  	erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index fa89a1e3012f..6537ededed51 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -442,6 +442,9 @@ struct erofs_map_blocks {
>  	unsigned short m_deviceid;
>  	char m_algorithmformat;
>  	unsigned int m_flags;
> +
> +	struct erofs_fscache *m_fscache;
> +	erofs_off_t o_la;
>  };
>  
>  /* Flags used by erofs_map_blocks_flatmode() */
> @@ -634,6 +637,8 @@ struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
>  void erofs_fscache_put(struct erofs_fscache *ctx);
>  
>  struct folio *erofs_fscache_get_folio(struct erofs_fscache *ctx, pgoff_t index);
> +
> +extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_init_fscache(void) { return 0; }
>  static inline void erofs_exit_fscache(void) {}
> -- 
> 2.27.0
