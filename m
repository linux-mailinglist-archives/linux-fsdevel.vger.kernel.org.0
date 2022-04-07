Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08E4F8170
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiDGOVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiDGOVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:21:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D21252A9;
        Thu,  7 Apr 2022 07:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C0F61C43;
        Thu,  7 Apr 2022 14:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0763EC385A4;
        Thu,  7 Apr 2022 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649341176;
        bh=ItNyLV5CcuttOOB13cRLgkLSUXjOBtYIX53rNJAl6Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyetfJESBxDICQ0YIvZ9S698EXLSj+TlCVLw7W0CQHuYEkch3vxayfHMUWhBzo6Y4
         YWHdV2nz7bsBR4d4CrLf8VqT5kPAuLA9FNYrHzK9CY17smmBoeP9nzlCSN20Q5NHLr
         B4hgmPdZvxntqbPnhfsrP4+iqpIepKpzkF9/BIvR1LUcwVT/+FAFXfbeO8K71e7Urk
         Aff12yjW1U8HZ2es06eMpjki321FaBLMfzqPiFLq4nITSZyr9g+THO23+0YUtqkIl1
         8n76AbxVqbwbGKEvgthA+Y6K9qomF0NgVPQiqZFVcqgj2RbN4lYRq7jFm25kd8YlUA
         +UnufuhthJoyQ==
Date:   Thu, 7 Apr 2022 22:19:28 +0800
From:   Gao Xiang <xiang@kernel.org>
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
Subject: Re: [PATCH v8 16/20] erofs: implement fscache-based metadata read
Message-ID: <Yk7y8FuBosbtAY3l@debian>
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
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-17-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-17-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:08PM +0800, Jeffle Xu wrote:
> Implement the data plane of reading metadata from primary data blob
> over fscache.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/data.c     | 20 ++++++++++++++++++--
>  fs/erofs/fscache.c  | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h |  9 +++++++++
>  3 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 14b64d960541..cb8fe299ad67 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -31,15 +31,26 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>  void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  		  erofs_blk_t blkaddr, enum erofs_kmap_type type)
>  {
> -	struct address_space *const mapping = inode->i_mapping;
>  	erofs_off_t offset = blknr_to_addr(blkaddr);
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	struct page *page = buf->page;
>  
>  	if (!page || page->index != index) {
>  		erofs_put_metabuf(buf);
> -		page = read_cache_page_gfp(mapping, index,
> +		if (buf->sb) {
> +			struct folio *folio;
> +
> +			folio = erofs_fscache_get_folio(buf->sb, index);
> +			if (IS_ERR(folio))
> +				page = ERR_CAST(folio);
> +			else
> +				page = folio_page(folio, 0);
> +		} else {
> +			struct address_space *const mapping = inode->i_mapping;
> +
> +			page = read_cache_page_gfp(mapping, index,
>  				mapping_gfp_constraint(mapping, ~__GFP_FS));
> +		}
>  		if (IS_ERR(page))
>  			return page;
>  		/* should already be PageUptodate, no need to lock page */
> @@ -63,6 +74,11 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
>  void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>  			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
>  {
> +	if (erofs_is_fscache_mode(sb)) {
> +		buf->sb = sb;
> +		return erofs_bread(buf, NULL, blkaddr, type);
> +	}
> +
>  	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
>  }
>  
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index d38a6efc8e50..158cc273f8fb 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -34,9 +34,47 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
>  	return ret;
>  }
>  
> +static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
> +{
> +	int ret;
> +	struct super_block *sb = (struct super_block *)data;
> +	struct folio *folio = page_folio(page);
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
> +			folio_file_mapping(folio), folio_pos(folio),
> +			folio_size(folio), mdev.m_pa);
> +	if (ret)
> +		goto out;
> +
> +	folio_mark_uptodate(folio);
> +out:
> +	folio_unlock(folio);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
> +	.readpage = erofs_fscache_meta_readpage,
>  };
>  
> +/*
> + * Get the page cache of data blob at the index offset.
> + * Return: up to date page on success, ERR_PTR() on failure.
> + */

Unnecessary comment and even unnecessary helper.

Thanks,
Gao Xiang

> +struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index)
> +{
> +	struct erofs_fscache *ctx = EROFS_SB(sb)->s_fscache;
> +
> +	return read_mapping_folio(ctx->inode->i_mapping, index, (void *)sb);
> +}
> +
>  /*
>   * Create an fscache context for data blob.
>   * Return: 0 on success and allocated fscache context is assigned to @fscache,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 90f7d6286a4f..e186051f0640 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -276,6 +276,7 @@ enum erofs_kmap_type {
>  };
>  
>  struct erofs_buf {
> +	struct super_block *sb;
>  	struct page *page;
>  	void *base;
>  	enum erofs_kmap_type kmap_type;
> @@ -639,6 +640,8 @@ int erofs_fscache_register_cookie(struct super_block *sb,
>  				  struct erofs_fscache **fscache,
>  				  char *name, bool need_inode);
>  void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache);
> +
> +struct folio *erofs_fscache_get_folio(struct super_block *sb, pgoff_t index);
>  #else
>  static inline int erofs_fscache_register_fs(struct super_block *sb) { return 0; }
>  static inline void erofs_fscache_unregister_fs(struct super_block *sb) {}
> @@ -653,6 +656,12 @@ static inline int erofs_fscache_register_cookie(struct super_block *sb,
>  static inline void erofs_fscache_unregister_cookie(struct erofs_fscache **fscache)
>  {
>  }
> +
> +static inline struct folio *erofs_fscache_get_folio(struct super_block *sb,
> +						    pgoff_t index)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
>  #endif
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> -- 
> 2.27.0
> 
