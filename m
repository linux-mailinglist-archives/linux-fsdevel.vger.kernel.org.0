Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4851A108FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEAOYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbfEAOYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:24:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EM8N7146512
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:24:32 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7bpuudvu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:24:32 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:24:29 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:24:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EOOp760293208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:24:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 880785204F;
        Wed,  1 May 2019 14:24:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E63952051;
        Wed,  1 May 2019 14:24:22 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ebiggers@kernel.org, jaegeuk@kernel.org,
        hch@infradead.org
Subject: Re: [PATCH V2 02/13] Consolidate "read callbacks" into a new file
Date:   Wed, 01 May 2019 18:01:51 +0530
Organization: IBM
In-Reply-To: <840fd844-ebce-1655-309a-5794229bab3f@huawei.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-3-chandan@linux.ibm.com> <840fd844-ebce-1655-309a-5794229bab3f@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050114-0020-0000-0000-000003383AA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-0021-0000-0000-0000218ABE2C
Message-Id: <1818169.fqCJa7sfke@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, April 30, 2019 7:07:28 AM IST Chao Yu wrote:
> On 2019/4/28 12:31, Chandan Rajendra wrote:
> > The "read callbacks" code is used by both Ext4 and F2FS. Hence to
> > remove duplicity, this commit moves the code into
> > include/linux/read_callbacks.h and fs/read_callbacks.c.
> > 
> > The corresponding decrypt and verity "work" functions have been moved
> > inside fscrypt and fsverity sources. With these in place, the read
> > callbacks code now has to just invoke enqueue functions provided by
> > fscrypt and fsverity.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/Kconfig                     |   4 +
> >  fs/Makefile                    |   4 +
> >  fs/crypto/Kconfig              |   1 +
> >  fs/crypto/bio.c                |  23 ++---
> >  fs/crypto/crypto.c             |  17 +--
> >  fs/crypto/fscrypt_private.h    |   3 +
> >  fs/ext4/ext4.h                 |   2 -
> >  fs/ext4/readpage.c             | 183 +++++----------------------------
> >  fs/ext4/super.c                |   9 +-
> >  fs/f2fs/data.c                 | 148 ++++----------------------
> >  fs/f2fs/super.c                |   9 +-
> >  fs/read_callbacks.c            | 136 ++++++++++++++++++++++++
> >  fs/verity/Kconfig              |   1 +
> >  fs/verity/verify.c             |  12 +++
> >  include/linux/fscrypt.h        |  20 +---
> >  include/linux/read_callbacks.h |  21 ++++
> >  16 files changed, 251 insertions(+), 342 deletions(-)
> >  create mode 100644 fs/read_callbacks.c
> >  create mode 100644 include/linux/read_callbacks.h
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 97f9eb8df713..03084f2dbeaf 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -308,6 +308,10 @@ config NFS_COMMON
> >  	depends on NFSD || NFS_FS || LOCKD
> >  	default y
> >  
> > +config FS_READ_CALLBACKS
> > +       bool
> > +       default n
> > +
> >  source "net/sunrpc/Kconfig"
> >  source "fs/ceph/Kconfig"
> >  source "fs/cifs/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 9dd2186e74b5..e0c0fce8cf40 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -21,6 +21,10 @@ else
> >  obj-y +=	no-block.o
> >  endif
> >  
> > +ifeq ($(CONFIG_FS_READ_CALLBACKS),y)
> > +obj-y +=	read_callbacks.o
> > +endif
> > +
> >  obj-$(CONFIG_PROC_FS) += proc_namespace.o
> >  
> >  obj-y				+= notify/
> > diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> > index f0de238000c0..163c328bcbd4 100644
> > --- a/fs/crypto/Kconfig
> > +++ b/fs/crypto/Kconfig
> > @@ -8,6 +8,7 @@ config FS_ENCRYPTION
> >  	select CRYPTO_CTS
> >  	select CRYPTO_SHA256
> >  	select KEYS
> > +	select FS_READ_CALLBACKS
> >  	help
> >  	  Enable encryption of files and directories.  This
> >  	  feature is similar to ecryptfs, but it is more memory
> > diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> > index 5759bcd018cd..27f5618174f2 100644
> > --- a/fs/crypto/bio.c
> > +++ b/fs/crypto/bio.c
> > @@ -24,6 +24,8 @@
> >  #include <linux/module.h>
> >  #include <linux/bio.h>
> >  #include <linux/namei.h>
> > +#include <linux/read_callbacks.h>
> > +
> >  #include "fscrypt_private.h"
> >  
> >  static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
> > @@ -54,24 +56,15 @@ void fscrypt_decrypt_bio(struct bio *bio)
> >  }
> >  EXPORT_SYMBOL(fscrypt_decrypt_bio);
> >  
> > -static void completion_pages(struct work_struct *work)
> > +void fscrypt_decrypt_work(struct work_struct *work)
> >  {
> > -	struct fscrypt_ctx *ctx =
> > -		container_of(work, struct fscrypt_ctx, r.work);
> > -	struct bio *bio = ctx->r.bio;
> > +	struct read_callbacks_ctx *ctx =
> > +		container_of(work, struct read_callbacks_ctx, work);
> >  
> > -	__fscrypt_decrypt_bio(bio, true);
> > -	fscrypt_release_ctx(ctx);
> > -	bio_put(bio);
> > -}
> > +	fscrypt_decrypt_bio(ctx->bio);
> >  
> > -void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
> > -{
> > -	INIT_WORK(&ctx->r.work, completion_pages);
> > -	ctx->r.bio = bio;
> > -	fscrypt_enqueue_decrypt_work(&ctx->r.work);
> > +	read_callbacks(ctx);
> >  }
> > -EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);
> >  
> >  void fscrypt_pullback_bio_page(struct page **page, bool restore)
> >  {
> > @@ -87,7 +80,7 @@ void fscrypt_pullback_bio_page(struct page **page, bool restore)
> >  	ctx = (struct fscrypt_ctx *)page_private(bounce_page);
> >  
> >  	/* restore control page */
> > -	*page = ctx->w.control_page;
> > +	*page = ctx->control_page;
> >  
> >  	if (restore)
> >  		fscrypt_restore_control_page(bounce_page);
> > diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> > index 3fc84bf2b1e5..ffa9302a7351 100644
> > --- a/fs/crypto/crypto.c
> > +++ b/fs/crypto/crypto.c
> > @@ -53,6 +53,7 @@ struct kmem_cache *fscrypt_info_cachep;
> >  
> >  void fscrypt_enqueue_decrypt_work(struct work_struct *work)
> >  {
> > +	INIT_WORK(work, fscrypt_decrypt_work);
> >  	queue_work(fscrypt_read_workqueue, work);
> >  }
> >  EXPORT_SYMBOL(fscrypt_enqueue_decrypt_work);
> > @@ -70,11 +71,11 @@ void fscrypt_release_ctx(struct fscrypt_ctx *ctx)
> >  {
> >  	unsigned long flags;
> >  
> > -	if (ctx->flags & FS_CTX_HAS_BOUNCE_BUFFER_FL && ctx->w.bounce_page) {
> > -		mempool_free(ctx->w.bounce_page, fscrypt_bounce_page_pool);
> > -		ctx->w.bounce_page = NULL;
> > +	if (ctx->flags & FS_CTX_HAS_BOUNCE_BUFFER_FL && ctx->bounce_page) {
> > +		mempool_free(ctx->bounce_page, fscrypt_bounce_page_pool);
> > +		ctx->bounce_page = NULL;
> >  	}
> > -	ctx->w.control_page = NULL;
> > +	ctx->control_page = NULL;
> >  	if (ctx->flags & FS_CTX_REQUIRES_FREE_ENCRYPT_FL) {
> >  		kmem_cache_free(fscrypt_ctx_cachep, ctx);
> >  	} else {
> > @@ -194,11 +195,11 @@ int fscrypt_do_page_crypto(const struct inode *inode, fscrypt_direction_t rw,
> >  struct page *fscrypt_alloc_bounce_page(struct fscrypt_ctx *ctx,
> >  				       gfp_t gfp_flags)
> >  {
> > -	ctx->w.bounce_page = mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
> > -	if (ctx->w.bounce_page == NULL)
> > +	ctx->bounce_page = mempool_alloc(fscrypt_bounce_page_pool, gfp_flags);
> > +	if (ctx->bounce_page == NULL)
> >  		return ERR_PTR(-ENOMEM);
> >  	ctx->flags |= FS_CTX_HAS_BOUNCE_BUFFER_FL;
> > -	return ctx->w.bounce_page;
> > +	return ctx->bounce_page;
> >  }
> >  
> >  /**
> > @@ -267,7 +268,7 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
> >  	if (IS_ERR(ciphertext_page))
> >  		goto errout;
> >  
> > -	ctx->w.control_page = page;
> > +	ctx->control_page = page;
> >  	err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num,
> >  				     page, ciphertext_page, len, offs,
> >  				     gfp_flags);
> > diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> > index 7da276159593..412a3bcf9efd 100644
> > --- a/fs/crypto/fscrypt_private.h
> > +++ b/fs/crypto/fscrypt_private.h
> > @@ -114,6 +114,9 @@ static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
> >  	return false;
> >  }
> >  
> > +/* bio.c */
> > +void fscrypt_decrypt_work(struct work_struct *work);
> > +
> >  /* crypto.c */
> >  extern struct kmem_cache *fscrypt_info_cachep;
> >  extern int fscrypt_initialize(unsigned int cop_flags);
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index f2b0e628ff7b..23f8568c9b53 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -3127,8 +3127,6 @@ static inline void ext4_set_de_type(struct super_block *sb,
> >  extern int ext4_mpage_readpages(struct address_space *mapping,
> >  				struct list_head *pages, struct page *page,
> >  				unsigned nr_pages, bool is_readahead);
> > -extern int __init ext4_init_post_read_processing(void);
> > -extern void ext4_exit_post_read_processing(void);
> >  
> >  /* symlink.c */
> >  extern const struct inode_operations ext4_encrypted_symlink_inode_operations;
> > diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> > index 0169e3809da3..e363dededc21 100644
> > --- a/fs/ext4/readpage.c
> > +++ b/fs/ext4/readpage.c
> > @@ -44,14 +44,10 @@
> >  #include <linux/backing-dev.h>
> >  #include <linux/pagevec.h>
> >  #include <linux/cleancache.h>
> > +#include <linux/read_callbacks.h>
> >  
> >  #include "ext4.h"
> >  
> > -#define NUM_PREALLOC_POST_READ_CTXS	128
> > -
> > -static struct kmem_cache *bio_post_read_ctx_cache;
> > -static mempool_t *bio_post_read_ctx_pool;
> > -
> >  static inline bool ext4_bio_encrypted(struct bio *bio)
> >  {
> >  #ifdef CONFIG_FS_ENCRYPTION
> > @@ -61,125 +57,6 @@ static inline bool ext4_bio_encrypted(struct bio *bio)
> >  #endif
> >  }
> >  
> > -/* postprocessing steps for read bios */
> > -enum bio_post_read_step {
> > -	STEP_INITIAL = 0,
> > -	STEP_DECRYPT,
> > -	STEP_VERITY,
> > -};
> > -
> > -struct bio_post_read_ctx {
> > -	struct bio *bio;
> > -	struct work_struct work;
> > -	unsigned int cur_step;
> > -	unsigned int enabled_steps;
> > -};
> > -
> > -static void __read_end_io(struct bio *bio)
> > -{
> > -	struct page *page;
> > -	struct bio_vec *bv;
> > -	int i;
> > -	struct bvec_iter_all iter_all;
> > -
> > -	bio_for_each_segment_all(bv, bio, i, iter_all) {
> > -		page = bv->bv_page;
> > -
> > -		/* PG_error was set if any post_read step failed */
> > -		if (bio->bi_status || PageError(page)) {
> > -			ClearPageUptodate(page);
> > -			SetPageError(page);
> > -		} else {
> > -			SetPageUptodate(page);
> > -		}
> > -		unlock_page(page);
> > -	}
> > -	if (bio->bi_private)
> > -		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> > -	bio_put(bio);
> > -}
> > -
> > -static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
> > -
> > -static void decrypt_work(struct work_struct *work)
> > -{
> > -	struct bio_post_read_ctx *ctx =
> > -		container_of(work, struct bio_post_read_ctx, work);
> > -
> > -	fscrypt_decrypt_bio(ctx->bio);
> > -
> > -	bio_post_read_processing(ctx);
> > -}
> > -
> > -static void verity_work(struct work_struct *work)
> > -{
> > -	struct bio_post_read_ctx *ctx =
> > -		container_of(work, struct bio_post_read_ctx, work);
> > -
> > -	fsverity_verify_bio(ctx->bio);
> > -
> > -	bio_post_read_processing(ctx);
> > -}
> > -
> > -static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> > -{
> > -	/*
> > -	 * We use different work queues for decryption and for verity because
> > -	 * verity may require reading metadata pages that need decryption, and
> > -	 * we shouldn't recurse to the same workqueue.
> > -	 */
> > -	switch (++ctx->cur_step) {
> > -	case STEP_DECRYPT:
> > -		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > -			INIT_WORK(&ctx->work, decrypt_work);
> > -			fscrypt_enqueue_decrypt_work(&ctx->work);
> > -			return;
> > -		}
> > -		ctx->cur_step++;
> > -		/* fall-through */
> > -	case STEP_VERITY:
> > -		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> > -			INIT_WORK(&ctx->work, verity_work);
> > -			fsverity_enqueue_verify_work(&ctx->work);
> > -			return;
> > -		}
> > -		ctx->cur_step++;
> > -		/* fall-through */
> > -	default:
> > -		__read_end_io(ctx->bio);
> > -	}
> > -}
> > -
> > -static struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
> > -						       struct bio *bio,
> > -						       pgoff_t index)
> > -{
> > -	unsigned int post_read_steps = 0;
> > -	struct bio_post_read_ctx *ctx = NULL;
> > -
> > -	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> > -		post_read_steps |= 1 << STEP_DECRYPT;
> > -#ifdef CONFIG_FS_VERITY
> > -	if (inode->i_verity_info != NULL &&
> > -	    (index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> > -		post_read_steps |= 1 << STEP_VERITY;
> > -#endif
> > -	if (post_read_steps) {
> > -		ctx = mempool_alloc(bio_post_read_ctx_pool, GFP_NOFS);
> > -		if (!ctx)
> > -			return ERR_PTR(-ENOMEM);
> > -		ctx->bio = bio;
> > -		ctx->enabled_steps = post_read_steps;
> > -		bio->bi_private = ctx;
> > -	}
> > -	return ctx;
> > -}
> > -
> > -static bool bio_post_read_required(struct bio *bio)
> > -{
> > -	return bio->bi_private && !bio->bi_status;
> > -}
> > -
> >  /*
> >   * I/O completion handler for multipage BIOs.
> >   *
> > @@ -194,14 +71,30 @@ static bool bio_post_read_required(struct bio *bio)
> >   */
> >  static void mpage_end_io(struct bio *bio)
> >  {
> > -	if (bio_post_read_required(bio)) {
> > -		struct bio_post_read_ctx *ctx = bio->bi_private;
> > +	struct bio_vec *bv;
> > +	int i;
> > +	struct bvec_iter_all iter_all;
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +	if (read_callbacks_required(bio)) {
> > +		struct read_callbacks_ctx *ctx = bio->bi_private;
> >  
> > -		ctx->cur_step = STEP_INITIAL;
> > -		bio_post_read_processing(ctx);
> > +		read_callbacks(ctx);
> >  		return;
> >  	}
> > -	__read_end_io(bio);
> > +#endif
> > +	bio_for_each_segment_all(bv, bio, i, iter_all) {
> > +		struct page *page = bv->bv_page;
> > +
> > +		if (!bio->bi_status) {
> > +			SetPageUptodate(page);
> > +		} else {
> > +			ClearPageUptodate(page);
> > +			SetPageError(page);
> > +		}
> > +		unlock_page(page);
> > +	}
> > +
> > +	bio_put(bio);
> >  }
> >  
> >  static inline loff_t ext4_readpage_limit(struct inode *inode)
> > @@ -368,17 +261,19 @@ int ext4_mpage_readpages(struct address_space *mapping,
> >  			bio = NULL;
> >  		}
> >  		if (bio == NULL) {
> > -			struct bio_post_read_ctx *ctx;
> > +			struct read_callbacks_ctx *ctx = NULL;
> >  
> >  			bio = bio_alloc(GFP_KERNEL,
> >  				min_t(int, nr_pages, BIO_MAX_PAGES));
> >  			if (!bio)
> >  				goto set_error_page;
> > -			ctx = get_bio_post_read_ctx(inode, bio, page->index);
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +			ctx = get_read_callbacks_ctx(inode, bio, page->index);
> >  			if (IS_ERR(ctx)) {
> >  				bio_put(bio);
> >  				goto set_error_page;
> >  			}
> > +#endif
> >  			bio_set_dev(bio, bdev);
> >  			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
> >  			bio->bi_end_io = mpage_end_io;
> > @@ -417,29 +312,3 @@ int ext4_mpage_readpages(struct address_space *mapping,
> >  		submit_bio(bio);
> >  	return 0;
> >  }
> > -
> > -int __init ext4_init_post_read_processing(void)
> > -{
> > -	bio_post_read_ctx_cache =
> > -		kmem_cache_create("ext4_bio_post_read_ctx",
> > -				  sizeof(struct bio_post_read_ctx), 0, 0, NULL);
> > -	if (!bio_post_read_ctx_cache)
> > -		goto fail;
> > -	bio_post_read_ctx_pool =
> > -		mempool_create_slab_pool(NUM_PREALLOC_POST_READ_CTXS,
> > -					 bio_post_read_ctx_cache);
> > -	if (!bio_post_read_ctx_pool)
> > -		goto fail_free_cache;
> > -	return 0;
> > -
> > -fail_free_cache:
> > -	kmem_cache_destroy(bio_post_read_ctx_cache);
> > -fail:
> > -	return -ENOMEM;
> > -}
> > -
> > -void ext4_exit_post_read_processing(void)
> > -{
> > -	mempool_destroy(bio_post_read_ctx_pool);
> > -	kmem_cache_destroy(bio_post_read_ctx_cache);
> > -}
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 4ae6f5849caa..aba724f82cc3 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6101,10 +6101,6 @@ static int __init ext4_init_fs(void)
> >  		return err;
> >  
> >  	err = ext4_init_pending();
> > -	if (err)
> > -		goto out7;
> > -
> > -	err = ext4_init_post_read_processing();
> >  	if (err)
> >  		goto out6;
> >  
> > @@ -6146,10 +6142,8 @@ static int __init ext4_init_fs(void)
> >  out4:
> >  	ext4_exit_pageio();
> >  out5:
> > -	ext4_exit_post_read_processing();
> > -out6:
> >  	ext4_exit_pending();
> > -out7:
> > +out6:
> >  	ext4_exit_es();
> >  
> >  	return err;
> > @@ -6166,7 +6160,6 @@ static void __exit ext4_exit_fs(void)
> >  	ext4_exit_sysfs();
> >  	ext4_exit_system_zone();
> >  	ext4_exit_pageio();
> > -	ext4_exit_post_read_processing();
> >  	ext4_exit_es();
> >  	ext4_exit_pending();
> >  }
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 038b958d0fa9..05430d3650ab 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/cleancache.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/read_callbacks.h>
> >  
> >  #include "f2fs.h"
> >  #include "node.h"
> > @@ -25,11 +26,6 @@
> >  #include "trace.h"
> >  #include <trace/events/f2fs.h>
> >  
> > -#define NUM_PREALLOC_POST_READ_CTXS	128
> > -
> > -static struct kmem_cache *bio_post_read_ctx_cache;
> > -static mempool_t *bio_post_read_ctx_pool;
> > -
> >  static bool __is_cp_guaranteed(struct page *page)
> >  {
> >  	struct address_space *mapping = page->mapping;
> > @@ -69,20 +65,6 @@ static enum count_type __read_io_type(struct page *page)
> >  	return F2FS_RD_DATA;
> >  }
> >  
> > -/* postprocessing steps for read bios */
> > -enum bio_post_read_step {
> > -	STEP_INITIAL = 0,
> > -	STEP_DECRYPT,
> > -	STEP_VERITY,
> > -};
> > -
> > -struct bio_post_read_ctx {
> > -	struct bio *bio;
> > -	struct work_struct work;
> > -	unsigned int cur_step;
> > -	unsigned int enabled_steps;
> > -};
> > -
> >  static void __read_end_io(struct bio *bio)
> >  {
> >  	struct page *page;
> > @@ -104,65 +86,16 @@ static void __read_end_io(struct bio *bio)
> >  		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
> >  		unlock_page(page);
> >  	}
> > -	if (bio->bi_private)
> > -		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> > -	bio_put(bio);
> > -}
> > -
> > -static void bio_post_read_processing(struct bio_post_read_ctx *ctx);
> >  
> > -static void decrypt_work(struct work_struct *work)
> > -{
> > -	struct bio_post_read_ctx *ctx =
> > -		container_of(work, struct bio_post_read_ctx, work);
> > -
> > -	fscrypt_decrypt_bio(ctx->bio);
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +	if (bio->bi_private) {
> > +		struct read_callbacks_ctx *ctx;
> >  
> > -	bio_post_read_processing(ctx);
> > -}
> > -
> > -static void verity_work(struct work_struct *work)
> > -{
> > -	struct bio_post_read_ctx *ctx =
> > -		container_of(work, struct bio_post_read_ctx, work);
> > -
> > -	fsverity_verify_bio(ctx->bio);
> > -
> > -	bio_post_read_processing(ctx);
> > -}
> > -
> > -static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
> > -{
> > -	/*
> > -	 * We use different work queues for decryption and for verity because
> > -	 * verity may require reading metadata pages that need decryption, and
> > -	 * we shouldn't recurse to the same workqueue.
> > -	 */
> > -	switch (++ctx->cur_step) {
> > -	case STEP_DECRYPT:
> > -		if (ctx->enabled_steps & (1 << STEP_DECRYPT)) {
> > -			INIT_WORK(&ctx->work, decrypt_work);
> > -			fscrypt_enqueue_decrypt_work(&ctx->work);
> > -			return;
> > -		}
> > -		ctx->cur_step++;
> > -		/* fall-through */
> > -	case STEP_VERITY:
> > -		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
> > -			INIT_WORK(&ctx->work, verity_work);
> > -			fsverity_enqueue_verify_work(&ctx->work);
> > -			return;
> > -		}
> > -		ctx->cur_step++;
> > -		/* fall-through */
> > -	default:
> > -		__read_end_io(ctx->bio);
> > +		ctx = bio->bi_private;
> > +		put_read_callbacks_ctx(ctx);
> >  	}
> > -}
> > -
> > -static bool f2fs_bio_post_read_required(struct bio *bio)
> > -{
> > -	return bio->bi_private && !bio->bi_status;
> > +#endif
> > +	bio_put(bio);
> >  }
> >  
> >  static void f2fs_read_end_io(struct bio *bio)
> > @@ -173,14 +106,12 @@ static void f2fs_read_end_io(struct bio *bio)
> >  		bio->bi_status = BLK_STS_IOERR;
> >  	}
> >  
> > -	if (f2fs_bio_post_read_required(bio)) {
> > -		struct bio_post_read_ctx *ctx = bio->bi_private;
> > -
> > -		ctx->cur_step = STEP_INITIAL;
> > -		bio_post_read_processing(ctx);
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +	if (!bio->bi_status && bio->bi_private) {
> > +		read_callbacks((struct read_callbacks_ctx *)(bio->bi_private));
> >  		return;
> 
> Previously, in __read_end_io() we will decrease in-flight read IO count for each
> page, but it looks in the case that if fscrypto or fsverity is on and there is
> no IO error in end_io(), we will miss handling the count.
> 

Thanks for pointing this out. I will fix this in the next version of this
patchset.

-- 
chandan



