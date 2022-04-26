Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90450F05E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbiDZFoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiDZFng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:43:36 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259315A35;
        Mon, 25 Apr 2022 22:40:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VBJMJAQ_1650951594;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VBJMJAQ_1650951594)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Apr 2022 13:39:57 +0800
Date:   Tue, 26 Apr 2022 13:39:54 +0800
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
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: Re: [PATCH v10 17/21] erofs: implement fscache-based metadata read
Message-ID: <YmeFqhYu5PNYu+8Z@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
 <20220425122143.56815-18-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425122143.56815-18-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:21:39PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading metadata from primary data blob
> over fscache.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c    | 19 +++++++++++++++----
>  fs/erofs/fscache.c | 25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 14b64d960541..bb9c1fd48c19 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -6,6 +6,7 @@
>   */
>  #include "internal.h"
>  #include <linux/prefetch.h>
> +#include <linux/sched/mm.h>
>  #include <linux/dax.h>
>  #include <trace/events/erofs.h>
>  
> @@ -35,14 +36,20 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  	erofs_off_t offset = blknr_to_addr(blkaddr);
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	struct page *page = buf->page;
> +	struct folio *folio;
> +	unsigned int nofs_flag;
>  
>  	if (!page || page->index != index) {
>  		erofs_put_metabuf(buf);
> -		page = read_cache_page_gfp(mapping, index,
> -				mapping_gfp_constraint(mapping, ~__GFP_FS));
> -		if (IS_ERR(page))
> -			return page;
> +
> +		nofs_flag = memalloc_nofs_save();
> +		folio = read_cache_folio(mapping, index, NULL, NULL);
> +		memalloc_nofs_restore(nofs_flag);
> +		if (IS_ERR(folio))
> +			return folio;
> +
>  		/* should already be PageUptodate, no need to lock page */
> +		page = folio_file_page(folio, index);
>  		buf->page = page;
>  	}
>  	if (buf->kmap_type == EROFS_NO_KMAP) {
> @@ -63,6 +70,10 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
>  {
> +	if (erofs_is_fscache_mode(sb))
> +		return erofs_bread(buf, EROFS_SB(sb)->s_fscache->inode,
> +				   blkaddr, type);
> +
>  	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
>  }
>  
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index ac02af8cce3e..23d7e862eed8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -59,7 +59,32 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
>  	return ret;
>  }
>  
> +static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
> +{
> +	int ret;
> +	struct folio *folio = page_folio(page);
> +	struct super_block *sb = folio_mapping(folio)->host->i_sb;
> +	struct erofs_map_dev mdev = {
> +		.m_deviceid = 0,
> +		.m_pa = folio_pos(folio),
> +	};
> +
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		goto out;
> +
> +	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
> +			folio_mapping(folio), folio_pos(folio),
> +			folio_size(folio), mdev.m_pa);
> +	if (!ret)
> +		folio_mark_uptodate(folio);
> +out:
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
> +	.readpage = erofs_fscache_meta_readpage,
>  };
>  
>  int erofs_fscache_register_cookie(struct super_block *sb,
> -- 
> 2.27.0
