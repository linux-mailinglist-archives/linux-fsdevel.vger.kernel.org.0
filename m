Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BBEE77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 03:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfD3Bhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 21:37:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:52700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbfD3Bhu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:37:50 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 81D219B17E838642C9A1;
        Tue, 30 Apr 2019 09:37:47 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Apr 2019 09:37:47 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 30 Apr 2019 09:37:46 +0800
Subject: Re: [PATCH V2 02/13] Consolidate "read callbacks" into a new file
To:     Chandan Rajendra <chandan@linux.ibm.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fscrypt@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <ebiggers@kernel.org>,
        <jaegeuk@kernel.org>, <hch@infradead.org>
References: <20190428043121.30925-1-chandan@linux.ibm.com>
 <20190428043121.30925-3-chandan@linux.ibm.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <840fd844-ebce-1655-309a-5794229bab3f@huawei.com>
Date:   Tue, 30 Apr 2019 09:37:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190428043121.30925-3-chandan@linux.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/4/28 12:31, Chandan Rajendra wrote:
> The "read callbacks" code is used by both Ext4 and F2FS. Hence to
> remove duplicity, this commit moves the code into
> include/linux/read_callbacks.h and fs/read_callbacks.c.
> 
> The corresponding decrypt and verity "work" functions have been moved
> inside fscrypt and fsverity sources. With these in place, the read
> callbacks code now has to just invoke enqueue functions provided by
> fscrypt and fsverity.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/Kconfig                     |   4 +
>  fs/Makefile                    |   4 +
>  fs/crypto/Kconfig              |   1 +
>  fs/crypto/bio.c                |  23 ++---
>  fs/crypto/crypto.c             |  17 +--
>  fs/crypto/fscrypt_private.h    |   3 +
>  fs/ext4/ext4.h                 |   2 -
>  fs/ext4/readpage.c             | 183 +++++----------------------------
>  fs/ext4/super.c                |   9 +-
>  fs/f2fs/data.c                 | 148 ++++----------------------
>  fs/f2fs/super.c                |   9 +-
>  fs/read_callbacks.c            | 136 ++++++++++++++++++++++++
>  fs/verity/Kconfig              |   1 +
>  fs/verity/verify.c             |  12 +++
>  include/linux/fscrypt.h        |  20 +---
>  include/linux/read_callbacks.h |  21 ++++
>  16 files changed, 251 insertions(+), 342 deletions(-)
>  create mode 100644 fs/read_callbacks.c
>  create mode 100644 include/linux/read_callbacks.h
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 97f9eb8df713..03084f2dbeaf 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -308,6 +308,10 @@ config NFS_COMMON
>  	depends on NFSD || NFS_FS || LOCKD
>  	default y
>  
> +config FS_READ_CALLBACKS
> +       bool
> +       default n
> +
>  source "net/sunrpc/Kconfig"
>  source "fs/ceph/Kconfig"
>  source "fs/cifs/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 9dd2186e74b5..e0c0fce8cf40 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -21,6 +21,10 @@ else
>  obj-y +=	no-block.o
>  endif
>  
> +ifeq ($(CONFIG_FS_READ_CALLBACKS),y)
> +obj-y +=	read_callbacks.o
> +endif
> +
>  obj-$(CONFIG_PROC_FS) += proc_namespace.o
>  
>  obj-y				+= notify/
> diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> index f0de238000c0..163c328bcbd4 100644
> --- a/fs/crypto/Kconfig
> +++ b/fs/crypto/Kconfig
> @@ -8,6 +8,7 @@ config FS_ENCRYPTION
>  	select CRYPTO_CTS
>  	select CRYPTO_SHA256
>  	select KEYS
> +	select FS_READ_CALLBACKS
>  	help
>  	  Enable encryption of files and directories.  This
>  	  feature is similar to ecryptfs, but it is more memory
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 5759bcd018cd..27f5618174f2 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -24,6 +24,8 @@
>  #include <linux/module.h>
>  #include <linux/bio.h>
>  #include <linux/namei.h>
> +#include <linux/read_callbacks.h>
> +
>  #include "fscrypt_private.h"
>  
>  static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
> @@ -54,24 +56,15 @@ void fscrypt_decrypt_bio(struct bio *bio)
>  }
>  EXPORT_SYMBOL(fscrypt_decrypt_bio);
>  
> -static void completion_pages(struct work_struct *work)
> +void fscrypt_decrypt_work(struct work_struct *work)
>  {
> -	struct fscrypt_ctx *ctx =
> -		container_of(work, struct fscrypt_ctx, r.work);
> -	struct bio *bio = ctx->r.bio;
> +	struct read_callbacks_ctx *ctx =
> +		container_of(work, struct read_callbacks_ctx, work);
>  
> -	__fscrypt_decrypt_bio(bio, true);
> -	fscrypt_release_ctx(ctx);
> -	bio_put(bio);
> -}
> +	fscrypt_decrypt_bio(ctx->bio);
>  
> -void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
> -{
> -	INIT_WORK(&ctx->r.work, completion_pages);
> -	ctx->r.bio = bio;
> -	fscrypt_enqueue_decrypt_work(&ctx->r.work);
> +	read_callbacks(ctx);
>  }
> -EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
>  
>  void fscrypt_pullback_bio_page(struct page **page, bool restore)
>  {
> @@ -87,7 +80,7 @@ void fscrypt_pullback_bio_page(struct page **page, bool restore)
>  	ctx = (struct fscrypt_ctx *)page_private(bounce_page);
>  
>  	/* restore control page */
> -	*page = ctx->w.control_page;
> +	*page = ctx->control_page;
>  
>  	if (restore)
>  		fscrypt_restore_control_page(bounce_page);
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index 3fc84bf2b1e5..ffa9302a7351 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -53,6 +53,7 @@ struct kmem_cache *fscrypt_info_cachep;
>  
>  void fscrypt_enqueue_decrypt_work(struct work_struct *work)
>  {
> +	INIT_WORK(work, fscrypt_decrypt_work);
>  	queue_work(fscrypt_read_workqueue, work);
>  }
>  EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
> @@ -70,11 +71,11 @@ void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
>  {
>  	unsigned long flags;
>  
> -	if (ctx->flags & FS_CTX_HAS_BOUNCE_BUFFER_FL && ctx->w.bounce_page) {
> -		mempool_free(ctx->w.bounce_page, fscrypt_bounce_page_pool);
> -		ctx->w.bounce_page = NULL;
> +	if (ctx->flags & FS_CTX_HAS_BOUNCE_BUFFER_FL && ctx->bounce_page) {
> +		mempool_free(ctx->bounce_page, fscrypt_bounce_page_pool);
> +		ctx->bounce_page = NULL;
>  	}
> -	ctx->w.control_page = NULL;
> +	ctx->control_page = NULL;
>  	if (ctx->flags & FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
>  		kmem_cache_free(fscrypt_ctx_cachep, ctx);
>  	} else {
> @@ -194,11 +195,11 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
>  struct page *fscrypt_alloc_bounce_page(struct fscrypt_ctx *ctx,
>  				       gfp_t gfp_flags)
>  {
> -	ctx->w.bounce_page = mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
> -	if (ctx->w.bounce_page == NULL)
> +	ctx->bounce_page = mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
> +	if (ctx->bounce_page == NULL)
>  		return ERR_PTR(-ENOMEM);
>  	ctx->flags |= FS_CTX_HAS_BOUNCE_BUFFER_FL;
> -	return ctx->w.bounce_page;
> +	return ctx->bounce_page;
>  }
>  
>  /**
> @@ -267,7 +268,7 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
>  	if (IS_ERR(ciphertext_page))
>  		goto errout;
>  
> -	ctx->w.control_page = page;
> +	ctx->control_page = page;
>  	err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
>  				     page, ciphertext_page, len, offs,
>  				     gfp_flags);
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index 7da276159593..412a3bcf9efd 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -114,6 +114,9 @@ static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
>  	return false;
>  }
>  
> +/* bio.c */
> +void fscrypt_decrypt_work(struct work_struct *work);
> +
>  /* crypto.c */
>  extern struct kmem_cache *fscrypt_info_cachep;
>  extern int fscrypt_initialize(unsigned int cop_flags);
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f2b0e628ff7b..23f8568c9b53 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3127,8 +3127,6 @@ static inline void ext4_set_de_type(struct super_block *sb,
>  extern int ext4_mpage_readpages(struct address_space *mapping,
>  				struct list_head *pages, struct page *page,
>  				unsigned nr_pages, bool is_readahead);
> -extern int __init ext4_init_post_read_processing(void);
> -extern void ext4_exit_post_read_processing(void);
>  
>  /* symlink.c */
>  extern const struct inode_operations ext4_encrypted_symlink_inode_operations;
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 0169e3809da3..e363dededc21 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -44,14 +44,10 @@
>  #include <linux/backing-dev.h>
>  #include <linux/pagevec.h>
>  #include <linux/cleancache.h>
> +#include <linux/read_callbacks.h>
>  
>  #include "ext4.h"
>  
> -#define NUM_PREALLOC_POST_READ_CTXS	128
> -
> -static struct kmem_cache *bio_post_read_ctx_cache;
> -static mempool_t *bio_post_read_ctx_pool;
> -
>  static inline bool ext4_bio_encrypted(struct bio *bio)
>  {
>  #ifdef CONFIG_FS_ENCRYPTION
> @@ -61,125 +57,6 @@ static inline bool ext4_bio_encrypted(struct bio *bio)
>  #endif
>  }
>  
> -/* postprocessing steps for read bios */
> -enum bio_post_read_step {
> -	STEP_INITIAL = 0,
> -	STEP_DECRYPT,
> -	STEP_VERITY,
> -};
> -
> -struct bio_post_read_ctx {
> -	struct bio *bio;
> -	struct work_struct work;
> -	unsigned int cur_step;
> -	unsigned int enabled_steps;
> -};
> -
> -static void __read_end_io(struct bio *bio)
> -{
> -	struct page *page;
> -	struct bio_vec *bv;
> -	int i;
> -	struct bvec_iter_all iter_all;
> -
> -	bio_for_each_segment_all(bv, bio, i, iter_all) {
> -		page = bv->bv_page;
> -
> -		/* PG_error was set if any post_read step failed */
> -		if (bio->bi_status || PageError(page)) {
> -			ClearPageUptodate(page);
> -			SetPageError(page);
> -		} else {
> -			SetPageUptodate(page);
> -		}
> -		unlock_page(page);
> -	}
> -	if (bio->bi_private)
> -		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> -	bio_put(bio);
> -}
> -
> -static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
> -
> -static void decrypt_work(struct work_struct *work)
> -{
> -	struct bio_post_read_ctx *ctx =
> -		container_of(work, struct bio_post_read_ctx, work);
> -
> -	fscrypt_decrypt_bio(ctx->bio);
> -
> -	bio_post_read_processing(ctx);
> -}
> -
> -static void verity_work(struct work_struct *work)
> -{
> -	struct bio_post_read_ctx *ctx =
> -		container_of(work, struct bio_post_read_ctx, work);
> -
> -	fsverity_verify_bio(ctx->bio);
> -
> -	bio_post_read_processing(ctx);
> -}
> -
> -static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> -{
> -	/*
> -	 * We use different work queues for decryption and for verity because
> -	 * verity may require reading metadata pages that need decryption, and
> -	 * we shouldn't recurse to the same workqueue.
> -	 */
> -	switch (++ctx->cur_step) {
> -	case STEP_DECRYPT:
> -		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> -			INIT_WORK(&ctx->work, decrypt_work);
> -			fscrypt_enqueue_decrypt_work(&ctx->work);
> -			return;
> -		}
> -		ctx->cur_step++;
> -		/* fall-through */
> -	case STEP_VERITY:
> -		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> -			INIT_WORK(&ctx->work, verity_work);
> -			fsverity_enqueue_verify_work(&ctx->work);
> -			return;
> -		}
> -		ctx->cur_step++;
> -		/* fall-through */
> -	default:
> -		__read_end_io(ctx->bio);
> -	}
> -}
> -
> -static struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
> -						       struct bio *bio,
> -						       pgoff_t index)
> -{
> -	unsigned int post_read_steps = 0;
> -	struct bio_post_read_ctx *ctx = NULL;
> -
> -	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> -		post_read_steps |= 1 << STEP_DECRYPT;
> -#ifdef CONFIG_FS_VERITY
> -	if (inode->i_verity_info != NULL &&
> -	    (index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> -		post_read_steps |= 1 << STEP_VERITY;
> -#endif
> -	if (post_read_steps) {
> -		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
> -		if (!ctx)
> -			return ERR_PTR(-ENOMEM);
> -		ctx->bio = bio;
> -		ctx->enabled_steps = post_read_steps;
> -		bio->bi_private = ctx;
> -	}
> -	return ctx;
> -}
> -
> -static bool bio_post_read_required(struct bio *bio)
> -{
> -	return bio->bi_private && !bio->bi_status;
> -}
> -
>  /*
>   * I/O completion handler for multipage BIOs.
>   *
> @@ -194,14 +71,30 @@ static bool bio_post_read_required(struct bio *bio)
>   */
>  static void mpage_end_io(struct bio *bio)
>  {
> -	if (bio_post_read_required(bio)) {
> -		struct bio_post_read_ctx *ctx = bio->bi_private;
> +	struct bio_vec *bv;
> +	int i;
> +	struct bvec_iter_all iter_all;
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +	if (read_callbacks_required(bio)) {
> +		struct read_callbacks_ctx *ctx = bio->bi_private;
>  
> -		ctx->cur_step = STEP_INITIAL;
> -		bio_post_read_processing(ctx);
> +		read_callbacks(ctx);
>  		return;
>  	}
> -	__read_end_io(bio);
> +#endif
> +	bio_for_each_segment_all(bv, bio, i, iter_all) {
> +		struct page *page = bv->bv_page;
> +
> +		if (!bio->bi_status) {
> +			SetPageUptodate(page);
> +		} else {
> +			ClearPageUptodate(page);
> +			SetPageError(page);
> +		}
> +		unlock_page(page);
> +	}
> +
> +	bio_put(bio);
>  }
>  
>  static inline loff_t ext4_readpage_limit(struct inode *inode)
> @@ -368,17 +261,19 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  			bio = NULL;
>  		}
>  		if (bio == NULL) {
> -			struct bio_post_read_ctx *ctx;
> +			struct read_callbacks_ctx *ctx = NULL;
>  
>  			bio = bio_alloc(GFP_KERNEL,
>  				min_t(int, nr_pages, BIO_MAX_PAGES));
>  			if (!bio)
>  				goto set_error_page;
> -			ctx = get_bio_post_read_ctx(inode, bio, page->index);
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +			ctx = get_read_callbacks_ctx(inode, bio, page->index);
>  			if (IS_ERR(ctx)) {
>  				bio_put(bio);
>  				goto set_error_page;
>  			}
> +#endif
>  			bio_set_dev(bio, bdev);
>  			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
>  			bio->bi_end_io = mpage_end_io;
> @@ -417,29 +312,3 @@ int ext4_mpage_readpages(struct address_space *mapping,
>  		submit_bio(bio);
>  	return 0;
>  }
> -
> -int __init ext4_init_post_read_processing(void)
> -{
> -	bio_post_read_ctx_cache =
> -		kmem_cache_create("ext4_bio_post_read_ctx",
> -				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
> -	if (!bio_post_read_ctx_cache)
> -		goto fail;
> -	bio_post_read_ctx_pool =
> -		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
> -					 bio_post_read_ctx_cache);
> -	if (!bio_post_read_ctx_pool)
> -		goto fail_free_cache;
> -	return 0;
> -
> -fail_free_cache:
> -	kmem_cache_destroy(bio_post_read_ctx_cache);
> -fail:
> -	return -ENOMEM;
> -}
> -
> -void ext4_exit_post_read_processing(void)
> -{
> -	mempool_destroy(bio_post_read_ctx_pool);
> -	kmem_cache_destroy(bio_post_read_ctx_cache);
> -}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4ae6f5849caa..aba724f82cc3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6101,10 +6101,6 @@ static int __init ext4_init_fs(void)
>  		return err;
>  
>  	err = ext4_init_pending();
> -	if (err)
> -		goto out7;
> -
> -	err = ext4_init_post_read_processing();
>  	if (err)
>  		goto out6;
>  
> @@ -6146,10 +6142,8 @@ static int __init ext4_init_fs(void)
>  out4:
>  	ext4_exit_pageio();
>  out5:
> -	ext4_exit_post_read_processing();
> -out6:
>  	ext4_exit_pending();
> -out7:
> +out6:
>  	ext4_exit_es();
>  
>  	return err;
> @@ -6166,7 +6160,6 @@ static void __exit ext4_exit_fs(void)
>  	ext4_exit_sysfs();
>  	ext4_exit_system_zone();
>  	ext4_exit_pageio();
> -	ext4_exit_post_read_processing();
>  	ext4_exit_es();
>  	ext4_exit_pending();
>  }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 038b958d0fa9..05430d3650ab 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -18,6 +18,7 @@
>  #include <linux/uio.h>
>  #include <linux/cleancache.h>
>  #include <linux/sched/signal.h>
> +#include <linux/read_callbacks.h>
>  
>  #include "f2fs.h"
>  #include "node.h"
> @@ -25,11 +26,6 @@
>  #include "trace.h"
>  #include <trace/events/f2fs.h>
>  
> -#define NUM_PREALLOC_POST_READ_CTXS	128
> -
> -static struct kmem_cache *bio_post_read_ctx_cache;
> -static mempool_t *bio_post_read_ctx_pool;
> -
>  static bool __is_cp_guaranteed(struct page *page)
>  {
>  	struct address_space *mapping = page->mapping;
> @@ -69,20 +65,6 @@ static enum count_type __read_io_type(struct page *page)
>  	return F2FS_RD_DATA;
>  }
>  
> -/* postprocessing steps for read bios */
> -enum bio_post_read_step {
> -	STEP_INITIAL = 0,
> -	STEP_DECRYPT,
> -	STEP_VERITY,
> -};
> -
> -struct bio_post_read_ctx {
> -	struct bio *bio;
> -	struct work_struct work;
> -	unsigned int cur_step;
> -	unsigned int enabled_steps;
> -};
> -
>  static void __read_end_io(struct bio *bio)
>  {
>  	struct page *page;
> @@ -104,65 +86,16 @@ static void __read_end_io(struct bio *bio)
>  		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
>  		unlock_page(page);
>  	}
> -	if (bio->bi_private)
> -		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> -	bio_put(bio);
> -}
> -
> -static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
>  
> -static void decrypt_work(struct work_struct *work)
> -{
> -	struct bio_post_read_ctx *ctx =
> -		container_of(work, struct bio_post_read_ctx, work);
> -
> -	fscrypt_decrypt_bio(ctx->bio);
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +	if (bio->bi_private) {
> +		struct read_callbacks_ctx *ctx;
>  
> -	bio_post_read_processing(ctx);
> -}
> -
> -static void verity_work(struct work_struct *work)
> -{
> -	struct bio_post_read_ctx *ctx =
> -		container_of(work, struct bio_post_read_ctx, work);
> -
> -	fsverity_verify_bio(ctx->bio);
> -
> -	bio_post_read_processing(ctx);
> -}
> -
> -static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> -{
> -	/*
> -	 * We use different work queues for decryption and for verity because
> -	 * verity may require reading metadata pages that need decryption, and
> -	 * we shouldn't recurse to the same workqueue.
> -	 */
> -	switch (++ctx->cur_step) {
> -	case STEP_DECRYPT:
> -		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> -			INIT_WORK(&ctx->work, decrypt_work);
> -			fscrypt_enqueue_decrypt_work(&ctx->work);
> -			return;
> -		}
> -		ctx->cur_step++;
> -		/* fall-through */
> -	case STEP_VERITY:
> -		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> -			INIT_WORK(&ctx->work, verity_work);
> -			fsverity_enqueue_verify_work(&ctx->work);
> -			return;
> -		}
> -		ctx->cur_step++;
> -		/* fall-through */
> -	default:
> -		__read_end_io(ctx->bio);
> +		ctx = bio->bi_private;
> +		put_read_callbacks_ctx(ctx);
>  	}
> -}
> -
> -static bool f2fs_bio_post_read_required(struct bio *bio)
> -{
> -	return bio->bi_private && !bio->bi_status;
> +#endif
> +	bio_put(bio);
>  }
>  
>  static void f2fs_read_end_io(struct bio *bio)
> @@ -173,14 +106,12 @@ static void f2fs_read_end_io(struct bio *bio)
>  		bio->bi_status = BLK_STS_IOERR;
>  	}
>  
> -	if (f2fs_bio_post_read_required(bio)) {
> -		struct bio_post_read_ctx *ctx = bio->bi_private;
> -
> -		ctx->cur_step = STEP_INITIAL;
> -		bio_post_read_processing(ctx);
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +	if (!bio->bi_status && bio->bi_private) {
> +		read_callbacks((struct read_callbacks_ctx *)(bio->bi_private));
>  		return;

Previously, in __read_end_io() we will decrease in-flight read IO count for each
page, but it looks in the case that if fscrypto or fsverity is on and there is
no IO error in end_io(), we will miss handling the count.

> @@ -104,65 +86,16 @@ static void __read_end_io(struct bio *bio)
>  		dec_page_count(F2FS_P_SB(page), __read_io_type(page));

Thanks,

>  	}
> -
> +#endif
>  	__read_end_io(bio);
>  }
>  
> @@ -582,9 +513,9 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct bio *bio;
> -	struct bio_post_read_ctx *ctx;
> -	unsigned int post_read_steps = 0;
> -
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +	struct read_callbacks_ctx *ctx;
> +#endif
>  	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC))
>  		return ERR_PTR(-EFAULT);
>  
> @@ -595,24 +526,13 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  	bio->bi_end_io = f2fs_read_end_io;
>  	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
>  
> -	if (f2fs_encrypted_file(inode))
> -		post_read_steps |= 1 << STEP_DECRYPT;
> -#ifdef CONFIG_FS_VERITY
> -	if (inode->i_verity_info != NULL &&
> -	    (first_idx < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> -		post_read_steps |= 1 << STEP_VERITY;
> -#endif
> -	if (post_read_steps) {
> -		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
> -		if (!ctx) {
> -			bio_put(bio);
> -			return ERR_PTR(-ENOMEM);
> -		}
> -		ctx->bio = bio;
> -		ctx->enabled_steps = post_read_steps;
> -		bio->bi_private = ctx;
> +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> +	ctx = get_read_callbacks_ctx(inode, bio, first_idx);
> +	if (IS_ERR(ctx)) {
> +		bio_put(bio);
> +		return (struct bio *)ctx;
>  	}
> -
> +#endif
>  	return bio;
>  }
>  
> @@ -2894,29 +2814,3 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
>  						PAGECACHE_TAG_DIRTY);
>  	xa_unlock_irqrestore(&mapping->i_pages, flags);
>  }
> -
> -int __init f2fs_init_post_read_processing(void)
> -{
> -	bio_post_read_ctx_cache =
> -		kmem_cache_create("f2fs_bio_post_read_ctx",
> -				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
> -	if (!bio_post_read_ctx_cache)
> -		goto fail;
> -	bio_post_read_ctx_pool =
> -		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
> -					 bio_post_read_ctx_cache);
> -	if (!bio_post_read_ctx_pool)
> -		goto fail_free_cache;
> -	return 0;
> -
> -fail_free_cache:
> -	kmem_cache_destroy(bio_post_read_ctx_cache);
> -fail:
> -	return -ENOMEM;
> -}
> -
> -void __exit f2fs_destroy_post_read_processing(void)
> -{
> -	mempool_destroy(bio_post_read_ctx_pool);
> -	kmem_cache_destroy(bio_post_read_ctx_cache);
> -}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 0e187f67b206..2f75f06c784a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3633,15 +3633,11 @@ static int __init init_f2fs_fs(void)
>  	err = register_filesystem(&f2fs_fs_type);
>  	if (err)
>  		goto free_shrinker;
> +
>  	f2fs_create_root_stats();
> -	err = f2fs_init_post_read_processing();
> -	if (err)
> -		goto free_root_stats;
> +
>  	return 0;
>  
> -free_root_stats:
> -	f2fs_destroy_root_stats();
> -	unregister_filesystem(&f2fs_fs_type);
>  free_shrinker:
>  	unregister_shrinker(&f2fs_shrinker_info);
>  free_sysfs:
> @@ -3662,7 +3658,6 @@ static int __init init_f2fs_fs(void)
>  
>  static void __exit exit_f2fs_fs(void)
>  {
> -	f2fs_destroy_post_read_processing();
>  	f2fs_destroy_root_stats();
>  	unregister_filesystem(&f2fs_fs_type);
>  	unregister_shrinker(&f2fs_shrinker_info);
> diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> new file mode 100644
> index 000000000000..b6d5b95e67d7
> --- /dev/null
> +++ b/fs/read_callbacks.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file tracks the state machine that needs to be executed after reading
> + * data from files that are encrypted and/or have verity metadata associated
> + * with them.
> + */
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/bio.h>
> +#include <linux/fscrypt.h>
> +#include <linux/fsverity.h>
> +#include <linux/read_callbacks.h>
> +
> +#define NUM_PREALLOC_POST_READ_CTXS	128
> +
> +static struct kmem_cache *read_callbacks_ctx_cache;
> +static mempool_t *read_callbacks_ctx_pool;
> +
> +/* Read callback state machine steps */
> +enum read_callbacks_step {
> +	STEP_INITIAL = 0,
> +	STEP_DECRYPT,
> +	STEP_VERITY,
> +};
> +
> +void end_read_callbacks(struct bio *bio)
> +{
> +	struct page *page;
> +	struct bio_vec *bv;
> +	int i;
> +	struct bvec_iter_all iter_all;
> +
> +	bio_for_each_segment_all(bv, bio, i, iter_all) {
> +		page = bv->bv_page;
> +
> +		BUG_ON(bio->bi_status);
> +
> +		if (!PageError(page))
> +			SetPageUptodate(page);
> +
> +		unlock_page(page);
> +	}
> +	if (bio->bi_private)
> +		put_read_callbacks_ctx(bio->bi_private);
> +	bio_put(bio);
> +}
> +EXPORT_SYMBOL(end_read_callbacks);
> +
> +void read_callbacks(struct read_callbacks_ctx *ctx)
> +{
> +	/*
> +	 * We use different work queues for decryption and for verity because
> +	 * verity may require reading metadata pages that need decryption, and
> +	 * we shouldn't recurse to the same workqueue.
> +	 */
> +	switch (++ctx->cur_step) {
> +	case STEP_DECRYPT:
> +		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> +			fscrypt_enqueue_decrypt_work(&ctx->work);
> +			return;
> +		}
> +		ctx->cur_step++;
> +		/* fall-through */
> +	case STEP_VERITY:
> +		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> +			fsverity_enqueue_verify_work(&ctx->work);
> +			return;
> +		}
> +		ctx->cur_step++;
> +		/* fall-through */
> +	default:
> +		end_read_callbacks(ctx->bio);
> +	}
> +}
> +EXPORT_SYMBOL(read_callbacks);
> +
> +struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> +						struct bio *bio,
> +						pgoff_t index)
> +{
> +	unsigned int read_callbacks_steps = 0;
> +	struct read_callbacks_ctx *ctx = NULL;
> +
> +	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> +		read_callbacks_steps |= 1 << STEP_DECRYPT;
> +#ifdef CONFIG_FS_VERITY
> +	if (inode->i_verity_info != NULL &&
> +		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> +		read_callbacks_steps |= 1 << STEP_VERITY;
> +#endif
> +	if (read_callbacks_steps) {
> +		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
> +		if (!ctx)
> +			return ERR_PTR(-ENOMEM);
> +		ctx->bio = bio;
> +		ctx->inode = inode;
> +		ctx->enabled_steps = read_callbacks_steps;
> +		ctx->cur_step = STEP_INITIAL;
> +		bio->bi_private = ctx;
> +	}
> +	return ctx;
> +}
> +EXPORT_SYMBOL(get_read_callbacks_ctx);
> +
> +void put_read_callbacks_ctx(struct read_callbacks_ctx *ctx)
> +{
> +	mempool_free(ctx, read_callbacks_ctx_pool);
> +}
> +EXPORT_SYMBOL(put_read_callbacks_ctx);
> +
> +bool read_callbacks_required(struct bio *bio)
> +{
> +	return bio->bi_private && !bio->bi_status;
> +}
> +EXPORT_SYMBOL(read_callbacks_required);
> +
> +static int __init init_read_callbacks(void)
> +{
> +	read_callbacks_ctx_cache = KMEM_CACHE(read_callbacks_ctx, 0);
> +	if (!read_callbacks_ctx_cache)
> +		goto fail;
> +	read_callbacks_ctx_pool =
> +		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
> +					 read_callbacks_ctx_cache);
> +	if (!read_callbacks_ctx_pool)
> +		goto fail_free_cache;
> +	return 0;
> +
> +fail_free_cache:
> +	kmem_cache_destroy(read_callbacks_ctx_cache);
> +fail:
> +	return -ENOMEM;
> +}
> +
> +fs_initcall(init_read_callbacks);
> diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
> index 563593fb42db..44784e57c99d 100644
> --- a/fs/verity/Kconfig
> +++ b/fs/verity/Kconfig
> @@ -4,6 +4,7 @@ config FS_VERITY
>  	# SHA-256 is selected as it's intended to be the default hash algorithm.
>  	# To avoid bloat, other wanted algorithms must be selected explicitly.
>  	select CRYPTO_SHA256
> +	select FS_READ_CALLBACKS
>  	help
>  	  This option enables fs-verity.  fs-verity is the dm-verity
>  	  mechanism implemented at the file level.  On supported
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index 5732453a81e7..f93bee33872d 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -13,6 +13,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/ratelimit.h>
>  #include <linux/scatterlist.h>
> +#include <linux/read_callbacks.h>
>  
>  struct workqueue_struct *fsverity_read_workqueue;
>  
> @@ -284,6 +285,16 @@ void fsverity_verify_bio(struct bio *bio)
>  EXPORT_SYMBOL_GPL(fsverity_verify_bio);
>  #endif /* CONFIG_BLOCK */
>  
> +static void fsverity_verify_work(struct work_struct *work)
> +{
> +	struct read_callbacks_ctx *ctx =
> +		container_of(work, struct read_callbacks_ctx, work);
> +
> +	fsverity_verify_bio(ctx->bio);
> +
> +	read_callbacks(ctx);
> +}
> +
>  /**
>   * fsverity_enqueue_verify_work - enqueue work on the fs-verity workqueue
>   *
> @@ -291,6 +302,7 @@ EXPORT_SYMBOL_GPL(fsverity_verify_bio);
>   */
>  void fsverity_enqueue_verify_work(struct work_struct *work)
>  {
> +	INIT_WORK(work, fsverity_verify_work);
>  	queue_work(fsverity_read_workqueue, work);
>  }
>  EXPORT_SYMBOL_GPL(fsverity_enqueue_verify_work);
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index c00b764d6b8c..a760b7bd81d4 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -68,11 +68,7 @@ struct fscrypt_ctx {
>  		struct {
>  			struct page *bounce_page;	/* Ciphertext page */
>  			struct page *control_page;	/* Original page  */
> -		} w;
> -		struct {
> -			struct bio *bio;
> -			struct work_struct work;
> -		} r;
> +		};
>  		struct list_head free_list;	/* Free list */
>  	};
>  	u8 flags;				/* Flags */
> @@ -113,7 +109,7 @@ extern int fscrypt_decrypt_page(const struct inode *, struct page *, unsigned in
>  
>  static inline struct page *fscrypt_control_page(struct page *page)
>  {
> -	return ((struct fscrypt_ctx *)page_private(page))->w.control_page;
> +	return ((struct fscrypt_ctx *)page_private(page))->control_page;
>  }
>  
>  extern void fscrypt_restore_control_page(struct page *);
> @@ -218,9 +214,6 @@ static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
>  }
>  
>  /* bio.c */
> -extern void fscrypt_decrypt_bio(struct bio *);
> -extern void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
> -					struct bio *bio);
>  extern void fscrypt_pullback_bio_page(struct page **, bool);
>  extern int fscrypt_zeroout_range(const struct inode *, pgoff_t, sector_t,
>  				 unsigned int);
> @@ -390,15 +383,6 @@ static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
>  	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
>  }
>  
> -/* bio.c */
> -static inline void fscrypt_decrypt_bio(struct bio *bio)
> -{
> -}
> -
> -static inline void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx,
> -					       struct bio *bio)
> -{
> -}
>  
>  static inline void fscrypt_pullback_bio_page(struct page **page, bool restore)
>  {
> diff --git a/include/linux/read_callbacks.h b/include/linux/read_callbacks.h
> new file mode 100644
> index 000000000000..c501cdf83a5b
> --- /dev/null
> +++ b/include/linux/read_callbacks.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _READ_CALLBACKS_H
> +#define _READ_CALLBACKS_H
> +
> +struct read_callbacks_ctx {
> +	struct bio *bio;
> +	struct inode *inode;
> +	struct work_struct work;
> +	unsigned int cur_step;
> +	unsigned int enabled_steps;
> +};
> +
> +void end_read_callbacks(struct bio *bio);
> +void read_callbacks(struct read_callbacks_ctx *ctx);
> +struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> +						struct bio *bio,
> +						pgoff_t index);
> +void put_read_callbacks_ctx(struct read_callbacks_ctx *ctx);
> +bool read_callbacks_required(struct bio *bio);
> +
> +#endif	/* _READ_CALLBACKS_H */
> 
