Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A48509E56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiDULQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiDULQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:16:01 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BA25E82;
        Thu, 21 Apr 2022 04:13:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VAeULO8_1650539585;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VAeULO8_1650539585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 19:13:07 +0800
Date:   Thu, 21 Apr 2022 19:13:04 +0800
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
Subject: Re: [PATCH v9 18/21] erofs: implement fscache-based data read for
 non-inline layout
Message-ID: <YmE8QG7eXrIT+TzO@B-P7TQMD6M-0146.local>
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
 <20220415123614.54024-19-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-19-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 08:36:11PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading data from data blobs over fscache
> for non-inline layout.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  4 ++++
>  fs/erofs/internal.h |  2 ++
>  3 files changed, 57 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 3f00eb34ac35..b799b0fe1b67 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -84,10 +84,61 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
>  	return ret;
>  }
>  
> +static int erofs_fscache_readpage(struct file *file, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct inode *inode = folio_mapping(folio)->host;
> +	struct super_block *sb = inode->i_sb;
> +	struct erofs_map_blocks map;
> +	struct erofs_map_dev mdev;
> +	erofs_off_t pos;
> +	loff_t pstart;
> +	int ret = 0;

Redundant assignment now?

> +
> +	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
> +
> +	pos = folio_pos(folio);
> +	map.m_la = pos;
> +
> +	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
> +		folio_zero_range(folio, 0, folio_size(folio));
> +		goto out_uptodate;
> +	}
> +
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map.m_deviceid,
> +		.m_pa = map.m_pa,
> +	};
> +
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	pstart = mdev.m_pa + (pos - map.m_la);
> +	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> +			folio_mapping(folio), folio_pos(folio),
> +			folio_size(folio), pstart);
> +
> +out_uptodate:
> +	if (!ret)
> +		folio_mark_uptodate(folio);
> +out_unlock:
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  	.readpage = erofs_fscache_meta_readpage,
>  };
>  
> +const struct address_space_operations erofs_fscache_access_aops = {
> +	.readpage = erofs_fscache_readpage,
> +};
> +
>  /*
>   * Create an fscache context for data blob.
>   * Return: 0 on success and allocated fscache context is assigned to @fscache,
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index e8b37ba5e9ad..8d3f56c6469b 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -297,6 +297,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
>  		goto out_unlock;
>  	}
>  	inode->i_mapping->a_ops = &erofs_raw_access_aops;
> +#ifdef CONFIG_EROFS_FS_ONDEMAND
> +	if (erofs_is_fscache_mode(inode->i_sb))
> +		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
> +#endif
>  
>  out_unlock:
>  	erofs_put_metabuf(&buf);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index fa488af8dfcf..c8f6ac910976 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -639,6 +639,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
> +
> +extern const struct address_space_operations erofs_fscache_access_aops;
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb)
>  {
> -- 
> 2.27.0
