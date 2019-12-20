Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9C2127489
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 05:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfLTEXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 23:23:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfLTEXi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:23:38 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172B0206EF;
        Fri, 20 Dec 2019 04:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576815817;
        bh=y/iK21hfpjuMVRFNNNAz1r8hb/bYZke2x5UNUn7S49A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsRRSQurhykKFwcgdxe8QuKP66ppKwTHhcjCGLygC5WmSQBrpSueGPMbfDQNB2hVd
         HjDai/DJL40x0ttXkFkzgyVQGQCsJwb/0GNNK1fODi0BWua113KVVMajG7tPZ37D9I
         T3cSqLr/WjvQPy4ChCzIRkgUek8p8aH896fSKpC4=
Date:   Thu, 19 Dec 2019 20:23:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 8/9] f2fs: add inline encryption support
Message-ID: <20191220042335.GC718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-9-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-9-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:35AM -0800, Satya Tangirala wrote:
> Wire up f2fs to support inline encryption via the helper functions which
> fs/crypto/ now provides.  This includes:
> 
> - Adding a mount option 'inlinecrypt' which enables inline encryption
>   on encrypted files where it can be used.
> 
> - Setting the bio_crypt_ctx on bios that will be submitted to an
>   inline-encrypted file.
> 
> - Not adding logically discontiguous data to bios that will be submitted
>   to an inline-encrypted file.
> 
> - Not doing filesystem-layer crypto on inline-encrypted files.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/f2fs/data.c  | 65 +++++++++++++++++++++++++++++++++++++++++++------
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c | 41 +++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a034cd0ce021..ad63aa30d0c7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -308,6 +308,33 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>  	return bio;
>  }
>  
> +static void f2fs_set_bio_crypt_ctx(struct bio *bio, const struct inode *inode,
> +				  pgoff_t first_idx,
> +				  const struct f2fs_io_info *fio,
> +				  gfp_t gfp_mask)
> +{
> +	/*
> +	 * The f2fs garbage collector sets ->encrypted_page when it wants to
> +	 * read/write raw data without encryption.
> +	 */
> +	if (!fio || !fio->encrypted_page)
> +		fscrypt_set_bio_crypt_ctx(bio, inode, first_idx, gfp_mask);
> +}
> +
> +static bool f2fs_crypt_mergeable_bio(struct bio *bio, const struct inode *inode,
> +				     pgoff_t next_idx,
> +				     const struct f2fs_io_info *fio)
> +{
> +	/*
> +	 * The f2fs garbage collector sets ->encrypted_page when it wants to
> +	 * read/write raw data without encryption.
> +	 */
> +	if (fio && fio->encrypted_page)
> +		return !bio_has_crypt_ctx(bio);
> +
> +	return fscrypt_mergeable_bio(bio, inode, next_idx);
> +}
> +
>  static inline void __submit_bio(struct f2fs_sb_info *sbi,
>  				struct bio *bio, enum page_type type)
>  {
> @@ -491,6 +518,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	/* Allocate a new bio */
>  	bio = __bio_alloc(fio, 1);
>  
> +	f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
> +			       fio->page->index, fio, GFP_NOIO);
> +
>  	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>  		bio_put(bio);
>  		return -EFAULT;
> @@ -678,12 +708,18 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  	trace_f2fs_submit_page_bio(page, fio);
>  	f2fs_trace_ios(fio, 0);
>  
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				       fio->new_blkaddr) ||
> +		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
> +					      fio->page->index, fio))) {
>  		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
> +}

Unnecessary (and wrongly formatted) braces here.

>  alloc_new:
>  	if (!bio) {
>  		bio = __bio_alloc(fio, BIO_MAX_PAGES);
> +		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
> +				       fio->page->index, fio,
> +				       GFP_NOIO);
>  		bio_set_op_attrs(bio, fio->op, fio->op_flags);

Nit: GFP_NOIO can be joined with the previous line.

>  
>  		add_bio_entry(fio->sbi, bio, page, fio->temp);
> @@ -735,8 +771,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  
>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
>  
> -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> -			io->last_block_in_bio, fio->new_blkaddr))
> +	if (io->bio &&
> +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
> +			      fio->new_blkaddr) ||
> +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
> +				       fio->page->index, fio)))
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> @@ -748,6 +787,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  			goto skip;
>  		}
>  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
> +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
> +				       fio->page->index, fio,
> +				       GFP_NOIO);
>  		io->fio = *fio;

Likewise.

- Eric
