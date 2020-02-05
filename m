Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51013152494
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 02:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgBEB6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 20:58:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbgBEB6g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 20:58:36 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C58F14B6B979FCF636BB;
        Wed,  5 Feb 2020 09:58:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 5 Feb 2020
 09:58:30 +0800
Subject: Re: [PATCH v2] f2fs: Make f2fs_readpages readable again
To:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>
References: <20200201150807.17820-1-willy@infradead.org>
 <20200203033903.GB8731@bombadil.infradead.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <bd08bf56-f901-33b1-5151-f77fd823e343@huawei.com>
Date:   Wed, 5 Feb 2020 09:58:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200203033903.GB8731@bombadil.infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/2/3 11:39, Matthew Wilcox wrote:
> 
> Remove the horrendous ifdeffery by slipping an IS_ENABLED into
> f2fs_compressed_file().

I'd like to suggest to use

if (IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) && f2fs_compressed_file(inode))

here to clean up f2fs_readpages' codes.

Otherwise, f2fs module w/o compression support will not recognize compressed
file in most other cases if we add IS_ENABLED() condition into
f2fs_compressed_file().

Thanks,

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix compilation by adding more dummy functions
> 
>  fs/f2fs/data.c |  6 ------
>  fs/f2fs/f2fs.h | 10 +++++++++-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8bd9afa81c54..41156a8f60a7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2203,7 +2203,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  				goto next_page;
>  		}
>  
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_compressed_file(inode)) {
>  			/* there are remained comressed pages, submit them */
>  			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
> @@ -2230,14 +2229,11 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  			goto next_page;
>  		}
>  read_single_page:
> -#endif
>  
>  		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
>  					&bio, &last_block_in_bio, is_readahead);
>  		if (ret) {
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  set_error_page:
> -#endif
>  			SetPageError(page);
>  			zero_user_segment(page, 0, PAGE_SIZE);
>  			unlock_page(page);
> @@ -2246,7 +2242,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  		if (pages)
>  			put_page(page);
>  
> -#ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_compressed_file(inode)) {
>  			/* last page */
>  			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
> @@ -2257,7 +2252,6 @@ int f2fs_mpage_readpages(struct address_space *mapping,
>  				f2fs_destroy_compress_ctx(&cc);
>  			}
>  		}
> -#endif
>  	}
>  	BUG_ON(pages && !list_empty(pages));
>  	if (bio)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5355be6b6755..e90d2b3f1d2d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2706,7 +2706,8 @@ static inline int f2fs_has_inline_xattr(struct inode *inode)
>  
>  static inline int f2fs_compressed_file(struct inode *inode)
>  {
> -	return S_ISREG(inode->i_mode) &&
> +	return IS_ENABLED(CONFIG_F2FS_FS_COMPRESSION) &&
> +		S_ISREG(inode->i_mode) &&
>  		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>  }
>  
> @@ -3797,6 +3798,13 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
>  	WARN_ON_ONCE(1);
>  	return ERR_PTR(-EINVAL);
>  }
> +#define f2fs_cluster_can_merge_page(cc, index)	false
> +#define f2fs_read_multi_pages(cc, bio, nr_pages, last, is_ra) 0
> +#define f2fs_init_compress_ctx(cc) 0
> +#define f2fs_destroy_compress_ctx(cc) (void)0
> +#define f2fs_cluster_is_empty(cc) true
> +#define f2fs_compress_ctx_add_page(cc, page) (void)0
> +#define f2fs_is_compressed_cluster(cc, index) false
>  #endif
>  
>  static inline void set_compress_context(struct inode *inode)
> 
