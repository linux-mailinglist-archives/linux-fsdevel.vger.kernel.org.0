Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEC063B212
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 20:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiK1TTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiK1TSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:18:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD602BB31;
        Mon, 28 Nov 2022 11:18:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7C17B80FC9;
        Mon, 28 Nov 2022 19:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1FAC433C1;
        Mon, 28 Nov 2022 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669663101;
        bh=cSNJcLEebvWXEYQhjrIKZD9HkMS/dzw+itu/l77AXjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEcWuUNdDza2ZBlsLEWZldNX193IZe2aFS0DmXQ2RhlCwfQdEcPqa+qpluTb5boBo
         xTxkpe2TDdiAo46/ETob0JZjebaOTMTQC8UnmncaPdCOH7A4C5SHcn/L1nUE4yGMDX
         pOhAz7qrNojOmh2lZWQFOf8n7ZlywTcNaoo5Z/9w2yZTvF6wPsjQjH2wbbgWM3PpBB
         OJ0xgPe7HYj7zT6S/y/q6ONYqNbcI81nQg5jzNvCRa57OZzd2H4BMLYIZyPpZshIal
         saSImZy/xuWnG1d2Iy5HIzhQpQIz7unmTBJjKnEqBSiImXoIxB6UlId0vLvja7Xu0C
         PoCjvFfyb9v0g==
Date:   Mon, 28 Nov 2022 11:18:19 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v4] fsverity: stop using PG_error to track error status
Message-ID: <Y4UJewp0sbHZ2z9Q@google.com>
References: <20221125190642.12787-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125190642.12787-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> As a step towards freeing the PG_error flag for other uses, change ext4
> and f2fs to stop using PG_error to track verity errors.  Instead, if a
> verity error occurs, just mark the whole bio as failed.  The coarser
> granularity isn't really a problem since it isn't any worse than what
> the block layer provides, and errors from a multi-page readahead aren't
> reported to applications unless a single-page read fails too.
> 
> f2fs supports compression, which makes the f2fs changes a bit more
> complicated than desired, but the basic premise still works.
> 
> Note: there are still a few uses of PageError in f2fs, but they are on
> the write path, so they are unrelated and this patch doesn't touch them.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks,

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v4: Added a comment for decompression_attempted, added a paragraph to
>     the commit message, and added Chao's Reviewed-by.
> 
> v3: made a small simplification to the f2fs changes.  Also dropped the
>     fscrypt patch since it is upstream now.
> 
>  fs/ext4/readpage.c |  8 ++----
>  fs/f2fs/compress.c | 64 ++++++++++++++++++++++------------------------
>  fs/f2fs/data.c     | 53 +++++++++++++++++++++++---------------
>  fs/verity/verify.c | 12 ++++-----
>  4 files changed, 72 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
> index 3d21eae267fca..e604ea4e102b7 100644
> --- a/fs/ext4/readpage.c
> +++ b/fs/ext4/readpage.c
> @@ -75,14 +75,10 @@ static void __read_end_io(struct bio *bio)
>  	bio_for_each_segment_all(bv, bio, iter_all) {
>  		page = bv->bv_page;
>  
> -		/* PG_error was set if verity failed. */
> -		if (bio->bi_status || PageError(page)) {
> +		if (bio->bi_status)
>  			ClearPageUptodate(page);
> -			/* will re-read again later */
> -			ClearPageError(page);
> -		} else {
> +		else
>  			SetPageUptodate(page);
> -		}
>  		unlock_page(page);
>  	}
>  	if (bio->bi_private)
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d315c2de136f2..2b7a5cc4ed662 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1711,50 +1711,27 @@ static void f2fs_put_dic(struct decompress_io_ctx *dic, bool in_task)
>  	}
>  }
>  
> -/*
> - * Update and unlock the cluster's pagecache pages, and release the reference to
> - * the decompress_io_ctx that was being held for I/O completion.
> - */
> -static void __f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
> -				bool in_task)
> +static void f2fs_verify_cluster(struct work_struct *work)
>  {
> +	struct decompress_io_ctx *dic =
> +		container_of(work, struct decompress_io_ctx, verity_work);
>  	int i;
>  
> +	/* Verify, update, and unlock the decompressed pages. */
>  	for (i = 0; i < dic->cluster_size; i++) {
>  		struct page *rpage = dic->rpages[i];
>  
>  		if (!rpage)
>  			continue;
>  
> -		/* PG_error was set if verity failed. */
> -		if (failed || PageError(rpage)) {
> -			ClearPageUptodate(rpage);
> -			/* will re-read again later */
> -			ClearPageError(rpage);
> -		} else {
> +		if (fsverity_verify_page(rpage))
>  			SetPageUptodate(rpage);
> -		}
> +		else
> +			ClearPageUptodate(rpage);
>  		unlock_page(rpage);
>  	}
>  
> -	f2fs_put_dic(dic, in_task);
> -}
> -
> -static void f2fs_verify_cluster(struct work_struct *work)
> -{
> -	struct decompress_io_ctx *dic =
> -		container_of(work, struct decompress_io_ctx, verity_work);
> -	int i;
> -
> -	/* Verify the cluster's decompressed pages with fs-verity. */
> -	for (i = 0; i < dic->cluster_size; i++) {
> -		struct page *rpage = dic->rpages[i];
> -
> -		if (rpage && !fsverity_verify_page(rpage))
> -			SetPageError(rpage);
> -	}
> -
> -	__f2fs_decompress_end_io(dic, false, true);
> +	f2fs_put_dic(dic, true);
>  }
>  
>  /*
> @@ -1764,6 +1741,8 @@ static void f2fs_verify_cluster(struct work_struct *work)
>  void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
>  				bool in_task)
>  {
> +	int i;
> +
>  	if (!failed && dic->need_verity) {
>  		/*
>  		 * Note that to avoid deadlocks, the verity work can't be done
> @@ -1773,9 +1752,28 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
>  		 */
>  		INIT_WORK(&dic->verity_work, f2fs_verify_cluster);
>  		fsverity_enqueue_verify_work(&dic->verity_work);
> -	} else {
> -		__f2fs_decompress_end_io(dic, failed, in_task);
> +		return;
> +	}
> +
> +	/* Update and unlock the cluster's pagecache pages. */
> +	for (i = 0; i < dic->cluster_size; i++) {
> +		struct page *rpage = dic->rpages[i];
> +
> +		if (!rpage)
> +			continue;
> +
> +		if (failed)
> +			ClearPageUptodate(rpage);
> +		else
> +			SetPageUptodate(rpage);
> +		unlock_page(rpage);
>  	}
> +
> +	/*
> +	 * Release the reference to the decompress_io_ctx that was being held
> +	 * for I/O completion.
> +	 */
> +	f2fs_put_dic(dic, in_task);
>  }
>  
>  /*
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a71e818cd67b4..1ae8da259d6c5 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -116,43 +116,56 @@ struct bio_post_read_ctx {
>  	struct f2fs_sb_info *sbi;
>  	struct work_struct work;
>  	unsigned int enabled_steps;
> +	/*
> +	 * decompression_attempted keeps track of whether
> +	 * f2fs_end_read_compressed_page() has been called on the pages in the
> +	 * bio that belong to a compressed cluster yet.
> +	 */
> +	bool decompression_attempted;
>  	block_t fs_blkaddr;
>  };
>  
> +/*
> + * Update and unlock a bio's pages, and free the bio.
> + *
> + * This marks pages up-to-date only if there was no error in the bio (I/O error,
> + * decryption error, or verity error), as indicated by bio->bi_status.
> + *
> + * "Compressed pages" (pagecache pages backed by a compressed cluster on-disk)
> + * aren't marked up-to-date here, as decompression is done on a per-compression-
> + * cluster basis rather than a per-bio basis.  Instead, we only must do two
> + * things for each compressed page here: call f2fs_end_read_compressed_page()
> + * with failed=true if an error occurred before it would have normally gotten
> + * called (i.e., I/O error or decryption error, but *not* verity error), and
> + * release the bio's reference to the decompress_io_ctx of the page's cluster.
> + */
>  static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  {
>  	struct bio_vec *bv;
>  	struct bvec_iter_all iter_all;
> +	struct bio_post_read_ctx *ctx = bio->bi_private;
>  
> -	/*
> -	 * Update and unlock the bio's pagecache pages, and put the
> -	 * decompression context for any compressed pages.
> -	 */
>  	bio_for_each_segment_all(bv, bio, iter_all) {
>  		struct page *page = bv->bv_page;
>  
>  		if (f2fs_is_compressed_page(page)) {
> -			if (bio->bi_status)
> +			if (!ctx->decompression_attempted)
>  				f2fs_end_read_compressed_page(page, true, 0,
>  							in_task);
>  			f2fs_put_page_dic(page, in_task);
>  			continue;
>  		}
>  
> -		/* PG_error was set if verity failed. */
> -		if (bio->bi_status || PageError(page)) {
> +		if (bio->bi_status)
>  			ClearPageUptodate(page);
> -			/* will re-read again later */
> -			ClearPageError(page);
> -		} else {
> +		else
>  			SetPageUptodate(page);
> -		}
>  		dec_page_count(F2FS_P_SB(page), __read_io_type(page));
>  		unlock_page(page);
>  	}
>  
> -	if (bio->bi_private)
> -		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> +	if (ctx)
> +		mempool_free(ctx, bio_post_read_ctx_pool);
>  	bio_put(bio);
>  }
>  
> @@ -185,8 +198,10 @@ static void f2fs_verify_bio(struct work_struct *work)
>  			struct page *page = bv->bv_page;
>  
>  			if (!f2fs_is_compressed_page(page) &&
> -			    !fsverity_verify_page(page))
> -				SetPageError(page);
> +			    !fsverity_verify_page(page)) {
> +				bio->bi_status = BLK_STS_IOERR;
> +				break;
> +			}
>  		}
>  	} else {
>  		fsverity_verify_bio(bio);
> @@ -245,6 +260,8 @@ static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
>  		blkaddr++;
>  	}
>  
> +	ctx->decompression_attempted = true;
> +
>  	/*
>  	 * Optimization: if all the bio's pages are compressed, then scheduling
>  	 * the per-bio verity work is unnecessary, as verity will be fully
> @@ -1062,6 +1079,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>  		ctx->sbi = sbi;
>  		ctx->enabled_steps = post_read_steps;
>  		ctx->fs_blkaddr = blkaddr;
> +		ctx->decompression_attempted = false;
>  		bio->bi_private = ctx;
>  	}
>  	iostat_alloc_and_bind_ctx(sbi, bio, ctx);
> @@ -1089,7 +1107,6 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>  		bio_put(bio);
>  		return -EFAULT;
>  	}
> -	ClearPageError(page);
>  	inc_page_count(sbi, F2FS_RD_DATA);
>  	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE);
>  	__submit_bio(sbi, bio, DATA);
> @@ -2141,7 +2158,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
>  	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>  	f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
>  							F2FS_BLKSIZE);
> -	ClearPageError(page);
>  	*last_block_in_bio = block_nr;
>  	goto out;
>  out:
> @@ -2289,7 +2305,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  
>  		inc_page_count(sbi, F2FS_RD_DATA);
>  		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
> -		ClearPageError(page);
>  		*last_block_in_bio = blkaddr;
>  	}
>  
> @@ -2306,7 +2321,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  	for (i = 0; i < cc->cluster_size; i++) {
>  		if (cc->rpages[i]) {
>  			ClearPageUptodate(cc->rpages[i]);
> -			ClearPageError(cc->rpages[i]);
>  			unlock_page(cc->rpages[i]);
>  		}
>  	}
> @@ -2403,7 +2417,6 @@ static int f2fs_mpage_readpages(struct inode *inode,
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  set_error_page:
>  #endif
> -			SetPageError(page);
>  			zero_user_segment(page, 0, PAGE_SIZE);
>  			unlock_page(page);
>  		}
> diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> index bde8c9b7d25f6..961ba248021f9 100644
> --- a/fs/verity/verify.c
> +++ b/fs/verity/verify.c
> @@ -200,9 +200,8 @@ EXPORT_SYMBOL_GPL(fsverity_verify_page);
>   * @bio: the bio to verify
>   *
>   * Verify a set of pages that have just been read from a verity file.  The pages
> - * must be pagecache pages that are still locked and not yet uptodate.  Pages
> - * that fail verification are set to the Error state.  Verification is skipped
> - * for pages already in the Error state, e.g. due to fscrypt decryption failure.
> + * must be pagecache pages that are still locked and not yet uptodate.  If a
> + * page fails verification, then bio->bi_status is set to an error status.
>   *
>   * This is a helper function for use by the ->readahead() method of filesystems
>   * that issue bios to read data directly into the page cache.  Filesystems that
> @@ -244,9 +243,10 @@ void fsverity_verify_bio(struct bio *bio)
>  		unsigned long level0_ra_pages =
>  			min(max_ra_pages, params->level0_blocks - level0_index);
>  
> -		if (!PageError(page) &&
> -		    !verify_page(inode, vi, req, page, level0_ra_pages))
> -			SetPageError(page);
> +		if (!verify_page(inode, vi, req, page, level0_ra_pages)) {
> +			bio->bi_status = BLK_STS_IOERR;
> +			break;
> +		}
>  	}
>  
>  	fsverity_free_hash_request(params->hash_alg, req);
> 
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
> -- 
> 2.38.1
