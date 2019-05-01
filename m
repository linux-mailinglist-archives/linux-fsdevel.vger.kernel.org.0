Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB21090A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEAOYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 10:24:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726790AbfEAOYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 10:24:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41EM9E9005883
        for <linux-fsdevel@vger.kernel.org>; Wed, 1 May 2019 10:24:44 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7cypre51-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 10:24:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Wed, 1 May 2019 15:24:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 May 2019 15:24:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x41EOclk42467340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 May 2019 14:24:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DB5152050;
        Wed,  1 May 2019 14:24:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.136])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37B1D5204F;
        Wed,  1 May 2019 14:24:36 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V2 07/13] Add decryption support for sub-pagesized blocks
Date:   Wed, 01 May 2019 19:10:32 +0530
Organization: IBM
In-Reply-To: <20190430003817.GC251866@gmail.com>
References: <20190428043121.30925-1-chandan@linux.ibm.com> <20190428043121.30925-8-chandan@linux.ibm.com> <20190430003817.GC251866@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19050114-4275-0000-0000-000003304E9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050114-4276-0000-0000-0000383FAAEC
Message-Id: <5473968.ZdFUMrgSOT@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905010092
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On Tuesday, April 30, 2019 6:08:18 AM IST Eric Biggers wrote:
> On Sun, Apr 28, 2019 at 10:01:15AM +0530, Chandan Rajendra wrote:
> > To support decryption of sub-pagesized blocks this commit adds code to,
> > 1. Track buffer head in "struct read_callbacks_ctx".
> > 2. Pass buffer head argument to all read callbacks.
> > 3. In the corresponding endio, loop across all the blocks mapped by the
> >    page, decrypting each block in turn.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/buffer.c                    | 83 +++++++++++++++++++++++++---------
> >  fs/crypto/bio.c                | 50 +++++++++++++-------
> >  fs/crypto/crypto.c             | 19 +++++++-
> >  fs/f2fs/data.c                 |  2 +-
> >  fs/mpage.c                     |  2 +-
> >  fs/read_callbacks.c            | 53 ++++++++++++++--------
> >  include/linux/buffer_head.h    |  1 +
> >  include/linux/read_callbacks.h |  5 +-
> >  8 files changed, 154 insertions(+), 61 deletions(-)
> > 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index ce357602f471..f324727e24bb 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -45,6 +45,7 @@
> >  #include <linux/bit_spinlock.h>
> >  #include <linux/pagevec.h>
> >  #include <linux/sched/mm.h>
> > +#include <linux/read_callbacks.h>
> >  #include <trace/events/block.h>
> >  
> >  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
> > @@ -245,11 +246,7 @@ __find_get_block_slow(struct block_device *bdev, sector_t block)
> >  	return ret;
> >  }
> >  
> > -/*
> > - * I/O completion handler for block_read_full_page() - pages
> > - * which come unlocked at the end of I/O.
> > - */
> > -static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
> > +void end_buffer_page_read(struct buffer_head *bh)
> 
> I think __end_buffer_async_read() would be a better name, since the *page* isn't
> necessarily done yet.
> 
> >  {
> >  	unsigned long flags;
> >  	struct buffer_head *first;
> > @@ -257,17 +254,7 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
> >  	struct page *page;
> >  	int page_uptodate = 1;
> >  
> > -	BUG_ON(!buffer_async_read(bh));
> > -
> >  	page = bh->b_page;
> > -	if (uptodate) {
> > -		set_buffer_uptodate(bh);
> > -	} else {
> > -		clear_buffer_uptodate(bh);
> > -		buffer_io_error(bh, ", async page read");
> > -		SetPageError(page);
> > -	}
> > -
> >  	/*
> >  	 * Be _very_ careful from here on. Bad things can happen if
> >  	 * two buffer heads end IO at almost the same time and both
> > @@ -305,6 +292,44 @@ static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
> >  	local_irq_restore(flags);
> >  	return;
> >  }
> > +EXPORT_SYMBOL(end_buffer_page_read);
> 
> No need for EXPORT_SYMBOL() here, as this is only called by built-in code.
> 
> > +
> > +/*
> > + * I/O completion handler for block_read_full_page() - pages
> > + * which come unlocked at the end of I/O.
> > + */
> 
> This comment is no longer correct.  Change to something like:
> 
> /*
>  * I/O completion handler for block_read_full_page().  Pages are unlocked after
>  * the I/O completes and the read callbacks (if any) have executed.
>  */
> 
> > +static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
> > +{
> > +	struct page *page;
> > +
> > +	BUG_ON(!buffer_async_read(bh));
> > +
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +	if (uptodate && bh->b_private) {
> > +		struct read_callbacks_ctx *ctx = bh->b_private;
> > +
> > +		read_callbacks(ctx);
> > +		return;
> > +	}
> > +
> > +	if (bh->b_private) {
> > +		struct read_callbacks_ctx *ctx = bh->b_private;
> > +
> > +		WARN_ON(uptodate);
> > +		put_read_callbacks_ctx(ctx);
> > +	}
> > +#endif
> 
> These details should be handled in read_callbacks code, not here.  AFAICS, all
> you need is a function read_callbacks_end_bh() that returns a bool indicating
> whether it handled the buffer_head or not:
> 
> static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
> {
> 	BUG_ON(!buffer_async_read(bh));
> 
> 	if (read_callbacks_end_bh(bh, uptodate))
> 		return;
> 
> 	page = bh->b_page;
> 	...
> }
> 
> Then read_callbacks_end_bh() would check ->b_private and uptodate, and call
> read_callbacks() or put_read_callbacks_ctx() as appropriate.  When
> CONFIG_FS_READ_CALLBACKS=n it would be a stub that always returns false.
> 
> > +	page = bh->b_page;
> [...]
> 
> >  	}
> > @@ -2292,11 +2323,21 @@ int block_read_full_page(struct page *page, get_block_t *get_block)
> >  	 * the underlying blockdev brought it uptodate (the sct fix).
> >  	 */
> >  	for (i = 0; i < nr; i++) {
> > -		bh = arr[i];
> > -		if (buffer_uptodate(bh))
> > +		bh = arr[i].bh;
> > +		if (buffer_uptodate(bh)) {
> >  			end_buffer_async_read(bh, 1);
> > -		else
> > +		} else {
> > +#if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > +			struct read_callbacks_ctx *ctx;
> > +
> > +			ctx = get_read_callbacks_ctx(inode, NULL, bh, arr[i].blk_nr);
> > +			if (WARN_ON(IS_ERR(ctx))) {
> > +				end_buffer_async_read(bh, 0);
> > +				continue;
> > +			}
> > +#endif
> >  			submit_bh(REQ_OP_READ, 0, bh);
> > +		}
> >  	}
> >  	return 0;
> 
> Similarly here.  This level of detail doesn't need to be exposed outside of the
> read_callbacks code.  Just call read_callbacks_setup_bh() or something, make it
> return an 'err' rather than the read_callbacks_ctx, and make read_callbacks.h
> stub it out when !CONFIG_FS_READ_CALLBACKS.  There should be no #ifdef here.
> 
> > diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> > index 27f5618174f2..856f4694902d 100644
> > --- a/fs/crypto/bio.c
> > +++ b/fs/crypto/bio.c
> > @@ -24,44 +24,62 @@
> >  #include <linux/module.h>
> >  #include <linux/bio.h>
> >  #include <linux/namei.h>
> > +#include <linux/buffer_head.h>
> >  #include <linux/read_callbacks.h>
> >  
> >  #include "fscrypt_private.h"
> >  
> > -static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
> > +static void fscrypt_decrypt(struct bio *bio, struct buffer_head *bh)
> >  {
> > +	struct inode *inode;
> > +	struct page *page;
> >  	struct bio_vec *bv;
> > +	sector_t blk_nr;
> > +	int ret;
> >  	int i;
> >  	struct bvec_iter_all iter_all;
> >  
> > -	bio_for_each_segment_all(bv, bio, i, iter_all) {
> > -		struct page *page = bv->bv_page;
> > -		int ret = fscrypt_decrypt_page(page->mapping->host, page,
> > -				PAGE_SIZE, 0, page->index);
> > +	WARN_ON(!bh && !bio);
> >  
> > +	if (bh) {
> > +		page = bh->b_page;
> > +		inode = page->mapping->host;
> > +
> > +		blk_nr = page->index << (PAGE_SHIFT - inode->i_blkbits);
> > +		blk_nr += (bh_offset(bh) >> inode->i_blkbits);
> > +
> > +		ret = fscrypt_decrypt_page(inode, page, i_blocksize(inode),
> > +					bh_offset(bh), blk_nr);
> >  		if (ret) {
> >  			WARN_ON_ONCE(1);
> >  			SetPageError(page);
> > -		} else if (done) {
> > -			SetPageUptodate(page);
> >  		}
> > -		if (done)
> > -			unlock_page(page);
> > +	} else if (bio) {
> > +		bio_for_each_segment_all(bv, bio, i, iter_all) {
> > +			unsigned int blkbits;
> > +
> > +			page = bv->bv_page;
> > +			inode = page->mapping->host;
> > +			blkbits = inode->i_blkbits;
> > +			blk_nr = page->index << (PAGE_SHIFT - blkbits);
> > +			blk_nr += (bv->bv_offset >> blkbits);
> > +			ret = fscrypt_decrypt_page(page->mapping->host,
> > +						page, bv->bv_len,
> > +						bv->bv_offset, blk_nr);
> > +			if (ret) {
> > +				WARN_ON_ONCE(1);
> > +				SetPageError(page);
> > +			}
> > +		}
> >  	}
> >  }
> 
> For clarity, can you make these two different functions?
> fscrypt_decrypt_bio() and fscrypt_decrypt_bh().
> 
> FYI, the WARN_ON_ONCE() here was removed in the latest fscrypt tree.
> 
> >  
> > -void fscrypt_decrypt_bio(struct bio *bio)
> > -{
> > -	__fscrypt_decrypt_bio(bio, false);
> > -}
> > -EXPORT_SYMBOL(fscrypt_decrypt_bio);
> > -
> >  void fscrypt_decrypt_work(struct work_struct *work)
> >  {
> >  	struct read_callbacks_ctx *ctx =
> >  		container_of(work, struct read_callbacks_ctx, work);
> >  
> > -	fscrypt_decrypt_bio(ctx->bio);
> > +	fscrypt_decrypt(ctx->bio, ctx->bh);
> >  
> >  	read_callbacks(ctx);
> >  }
> > diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> > index ffa9302a7351..4f0d832cae71 100644
> > --- a/fs/crypto/crypto.c
> > +++ b/fs/crypto/crypto.c
> > @@ -305,11 +305,26 @@ EXPORT_SYMBOL(fscrypt_encrypt_page);
> >  int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
> >  			unsigned int len, unsigned int offs, u64 lblk_num)
> >  {
> > +	int i, page_nr_blks;
> > +	int err = 0;
> > +
> >  	if (!(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES))
> >  		BUG_ON(!PageLocked(page));
> >  
> > -	return fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num, page, page,
> > -				      len, offs, GFP_NOFS);
> > +	page_nr_blks = len >> inode->i_blkbits;
> > +
> > +	for (i = 0; i < page_nr_blks; i++) {
> > +		err = fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num,
> > +					page, page, i_blocksize(inode), offs,
> > +					GFP_NOFS);
> > +		if (err)
> > +			break;
> > +
> > +		++lblk_num;
> > +		offs += i_blocksize(inode);
> > +	}
> > +
> > +	return err;
> >  }
> >  EXPORT_SYMBOL(fscrypt_decrypt_page);
> 
> I was confused by the code calling this until I saw you updated it to handle
> multiple blocks.  Can you please rename it to fscrypt_decrypt_blocks()?  The
> function comment also needs to be updated to clarify what it does now (decrypt a
> contiguous sequence of one or more filesystem blocks in the page).  Also,
> 'lblk_num' should be renamed to 'starting_lblk_num' or similar.
>

fscrypt_decrypt_page() has the same semantics as fscrypt_encrypt_page()
i.e. they decrypt/encrypt contiguous blocks mapped by a page. This was the
reason behind leaving the names unchanged. Please let me know if you still think
that the names of both the functions need to be renamed to
fscrypt_[decrypt|encrypt]_blocks().

> Please also rename fscrypt_do_page_crypto() to fscrypt_crypt_block().

Sure, I will make the change.

> 
> Also, there should be a check that the len and offset are block-aligned:
> 
> 	const unsigned int blocksize = i_blocksize(inode);
> 
>         if (!IS_ALIGNED(len | offs, blocksize))
>                 return -EINVAL;
> 
> >  
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 05430d3650ab..ba437a2085e7 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -527,7 +527,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
> >  	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
> >  
> >  #if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > -	ctx = get_read_callbacks_ctx(inode, bio, first_idx);
> > +	ctx = get_read_callbacks_ctx(inode, bio, NULL, first_idx);
> >  	if (IS_ERR(ctx)) {
> >  		bio_put(bio);
> >  		return (struct bio *)ctx;
> > diff --git a/fs/mpage.c b/fs/mpage.c
> > index e342b859ee44..0557479fdca4 100644
> > --- a/fs/mpage.c
> > +++ b/fs/mpage.c
> > @@ -348,7 +348,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
> >  			goto confused;
> >  
> >  #if defined(CONFIG_FS_ENCRYPTION) || defined(CONFIG_FS_VERITY)
> > -		ctx = get_read_callbacks_ctx(inode, args->bio, page->index);
> > +		ctx = get_read_callbacks_ctx(inode, args->bio, NULL, page->index);
> >  		if (IS_ERR(ctx)) {
> >  			bio_put(args->bio);
> >  			args->bio = NULL;
> > diff --git a/fs/read_callbacks.c b/fs/read_callbacks.c
> > index 6dea54b0baa9..b3881c525720 100644
> > --- a/fs/read_callbacks.c
> > +++ b/fs/read_callbacks.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/bio.h>
> > +#include <linux/buffer_head.h>
> >  #include <linux/fscrypt.h>
> >  #include <linux/fsverity.h>
> >  #include <linux/read_callbacks.h>
> > @@ -24,26 +25,41 @@ enum read_callbacks_step {
> >  	STEP_VERITY,
> >  };
> >  
> > -void end_read_callbacks(struct bio *bio)
> > +void end_read_callbacks(struct bio *bio, struct buffer_head *bh)
> >  {
> > +	struct read_callbacks_ctx *ctx;
> >  	struct page *page;
> >  	struct bio_vec *bv;
> >  	int i;
> >  	struct bvec_iter_all iter_all;
> >  
> > -	bio_for_each_segment_all(bv, bio, i, iter_all) {
> > -		page = bv->bv_page;
> > +	if (bh) {
> > +		if (!PageError(bh->b_page))
> > +			set_buffer_uptodate(bh);
> >  
> > -		BUG_ON(bio->bi_status);
> > +		ctx = bh->b_private;
> >  
> > -		if (!PageError(page))
> > -			SetPageUptodate(page);
> > +		end_buffer_page_read(bh);
> >  
> > -		unlock_page(page);
> > +		put_read_callbacks_ctx(ctx);
> > +	} else if (bio) {
> > +		bio_for_each_segment_all(bv, bio, i, iter_all) {
> > +			page = bv->bv_page;
> > +
> > +			WARN_ON(bio->bi_status);
> > +
> > +			if (!PageError(page))
> > +				SetPageUptodate(page);
> > +
> > +			unlock_page(page);
> > +		}
> > +		WARN_ON(!bio->bi_private);
> > +
> > +		ctx = bio->bi_private;
> > +		put_read_callbacks_ctx(ctx);
> > +
> > +		bio_put(bio);
> >  	}
> > -	if (bio->bi_private)
> > -		put_read_callbacks_ctx(bio->bi_private);
> > -	bio_put(bio);
> >  }
> >  EXPORT_SYMBOL(end_read_callbacks);
> 
> To make this easier to read, can you split this into end_read_callbacks_bio()
> and end_read_callbacks_bh()?

Sure, I will make the change.
> 
> >  
> > @@ -70,18 +86,21 @@ void read_callbacks(struct read_callbacks_ctx *ctx)
> >  		ctx->cur_step++;
> >  		/* fall-through */
> >  	default:
> > -		end_read_callbacks(ctx->bio);
> > +		end_read_callbacks(ctx->bio, ctx->bh);
> >  	}
> >  }
> >  EXPORT_SYMBOL(read_callbacks);
> >  
> >  struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> >  						struct bio *bio,
> > +						struct buffer_head *bh,
> >  						pgoff_t index)
> >  {
> >  	unsigned int read_callbacks_steps = 0;
> >  	struct read_callbacks_ctx *ctx = NULL;
> >  
> > +	WARN_ON(!bh && !bio);
> > +
> 
> If this condition is true, return an error code; don't continue on.
> 
> >  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
> >  		read_callbacks_steps |= 1 << STEP_DECRYPT;
> >  #ifdef CONFIG_FS_VERITY
> > @@ -95,11 +114,15 @@ struct read_callbacks_ctx *get_read_callbacks_ctx(struct inode *inode,
> >  		ctx = mempool_alloc(read_callbacks_ctx_pool, GFP_NOFS);
> >  		if (!ctx)
> >  			return ERR_PTR(-ENOMEM);
> > +		ctx->bh = bh;
> >  		ctx->bio = bio;
> >  		ctx->inode = inode;
> >  		ctx->enabled_steps = read_callbacks_steps;
> >  		ctx->cur_step = STEP_INITIAL;
> > -		bio->bi_private = ctx;
> > +		if (bio)
> > +			bio->bi_private = ctx;
> > +		else if (bh)
> > +			bh->b_private = ctx;
> 
> ... and if doing that, then you don't need to check 'else if (bh)' here.

I agree.

> 
> >  	}
> >  	return ctx;
> >  }
> > @@ -111,12 +134,6 @@ void put_read_callbacks_ctx(struct read_callbacks_ctx *ctx)
> >  }
> >  EXPORT_SYMBOL(put_read_callbacks_ctx);
> >  
> > -bool read_callbacks_required(struct bio *bio)
> > -{
> > -	return bio->bi_private && !bio->bi_status;
> > -}
> > -EXPORT_SYMBOL(read_callbacks_required);
> > -
> 
> It's unexpected that the patch series introduces this function,
> only to delete it later.

I had replaced bio_post_read_required() with read_callbacks_required(). I will
remove this since the requirement for post read checking will need to work for
buffer heads as well.

-- 
chandan



