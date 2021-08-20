Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8653F325E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHTRiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhHTRiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:38:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8DCC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:37:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n12so6366090plf.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LwDCq/HUcST9zFA8UpdD2sLZKxm/r6LlymnXEim0kUM=;
        b=JgwC8zKTlF5hke09fT8K8RNhIW/2SAfRagyFOnJxcmYkQfHzvb3dWiod1QXN0xlIA5
         aTMW6BcKNex/5GEnq1sSxCCDuhWSFC2YoDTkvj8ITeZdqopb0GwrW4RQ/VO4yuWQD4y7
         GT7G266uackqMWUoZUVabEXS1XoJ/0rm7qA/k+hCeZ3EyHdtL2nLldsRROQLLH0cbb81
         loKge7FylIkX3VBJSTzGNbu5AQYxKLPvE9TqDJlaZ7d0VzBV+im4n54l0bTcmkZNULOZ
         vl19rneDj3kB9uMFXlA0qIWkdy8cfuWcWcZCyble0aIVtZpx3pJj3EWwziLOsr6zX1Ps
         qMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LwDCq/HUcST9zFA8UpdD2sLZKxm/r6LlymnXEim0kUM=;
        b=WQDjVFX9/3GDIwxrr6i38sHvIVv+FGP2goPdpSagjF7ZNruBhHGtCBEM6KEqqOmANC
         HI7Xp8k9eWAQgJfFMeGJ+PcwxEDl2cBvaoraS9AYuVrGehYFlZnoRKLA/al34ErQSYnw
         w5xay+vgY40MYcOvWSfp4Jq2JeaaSWg14dA90NR03fapXilTxM4cBW9BZTZ1hZ64Hj/N
         Y3SS/D44nfS2qtr1axaENvgzOHgx+/vrp1/Fv3RNBO+k5G8LD8rlyzJzi3vX9Yn+BpqX
         yQVQuNZcSj851KYd4eYbP8+V5D5nOX4fWFaB849c3IZiI8AKAO907PfFEliVpKta9Hgk
         O1Kw==
X-Gm-Message-State: AOAM532O/wvORHRvaN2JEgQvRrVUWUV4lBWAA2c1uIvDnb8Dn+v9UvdG
        5Cgc7OKHYfrTUJ1U7cCgPhlwPA==
X-Google-Smtp-Source: ABdhPJz3Vm6qFdm7hOcOKdw8QYZ4UH4QXE6JdteF7qLw1Mtmvo+xba8vaB5ISUFHDQP/hXOsIsEM+A==
X-Received: by 2002:a17:90b:b0e:: with SMTP id bf14mr2942660pjb.80.1629481042063;
        Fri, 20 Aug 2021 10:37:22 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id z20sm7014988pjq.14.2021.08.20.10.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:37:21 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:37:19 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 03/14] btrfs: don't advance offset for compressed
 bios in btrfs_csum_one_bio()
Message-ID: <YR/oT2dXaU3pTJE+@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <5cbd7b12d5147d7d619a5f521051e5c4ed5ce6d1.1629234193.git.osandov@fb.com>
 <b3517f65-a22b-7c08-536c-1b5fc7d68fab@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3517f65-a22b-7c08-536c-1b5fc7d68fab@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:08:41AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > btrfs_csum_one_bio() loops over each filesystem block in the bio while
> > keeping a cursor of its current logical position in the file in order to
> > look up the ordered extent to add the checksums to. However, this
> > doesn't make much sense for compressed extents, as a sector on disk does
> > not correspond to a sector of decompressed file data. It happens to work
> > because 1) the compressed bio always covers one ordered extent and 2)
> > the size of the bio is always less than the size of the ordered extent.
> > However, the second point will not always be true for encoded writes.
> > 
> > Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> > it can assume that the bio only covers one ordered extent. Since we're
> > already changing the signature, let's get rid of the contig parameter
> > and make it implied by the offset parameter, similar to the change we
> > recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> > nr_sectors to blockcount to make it clear that it's the number of
> > filesystem blocks, not the number of 512-byte sectors.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/btrfs/compression.c |  5 +++--
> >  fs/btrfs/ctree.h       |  2 +-
> >  fs/btrfs/file-item.c   | 35 ++++++++++++++++-------------------
> >  fs/btrfs/inode.c       |  8 ++++----
> >  4 files changed, 24 insertions(+), 26 deletions(-)
> > 
> > diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> > index 7869ad12bc6e..e645b3c2f09a 100644
> > --- a/fs/btrfs/compression.c
> > +++ b/fs/btrfs/compression.c
> > @@ -480,7 +480,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
> >  			BUG_ON(ret); /* -ENOMEM */
> >  
> >  			if (!skip_sum) {
> > -				ret = btrfs_csum_one_bio(inode, bio, start, 1);
> > +				ret = btrfs_csum_one_bio(inode, bio, start,
> > +							 true);
> >  				BUG_ON(ret); /* -ENOMEM */
> >  			}
> >  
> > @@ -516,7 +517,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
> >  	BUG_ON(ret); /* -ENOMEM */
> >  
> >  	if (!skip_sum) {
> > -		ret = btrfs_csum_one_bio(inode, bio, start, 1);
> > +		ret = btrfs_csum_one_bio(inode, bio, start, true);
> >  		BUG_ON(ret); /* -ENOMEM */
> >  	}
> >  
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index f07c82fafa04..be245b4b8efe 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -3111,7 +3111,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
> >  			   struct btrfs_root *root,
> >  			   struct btrfs_ordered_sum *sums);
> >  blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> > -				u64 file_start, int contig);
> > +				u64 offset, bool one_ordered);
> >  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
> >  			     struct list_head *list, int search_commit);
> >  void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
> > diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> > index 2673c6ba7a4e..844fae923340 100644
> > --- a/fs/btrfs/file-item.c
> > +++ b/fs/btrfs/file-item.c
> > @@ -614,28 +614,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
> >   * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
> >   * @inode:	 Owner of the data inside the bio
> >   * @bio:	 Contains the data to be checksummed
> > - * @file_start:  offset in file this bio begins to describe
> > - * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
> > - *		 contiguous and they begin at @file_start in the file. False/0
> > - *		 means this bio can contain potentially discontiguous bio vecs
> > - *		 so the logical offset of each should be calculated separately.
> > + * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
> > + *               file offsets are determined from the page offsets in the bio.
> > + *               Otherwise, this is the starting file offset of the bio vecs in
> > + *               @bio, which must be contiguous.
> > + * @one_ordered: If true, @bio only refers to one ordered extent.
> 
> nit: I don't have strong preference but my gut feeling tells me
> "single_ordered" might be more explicit/informative. But unless someone
> else thinks the same one_ordered would also make do
> 
> >   */
> >  blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> > -		       u64 file_start, int contig)
> > +				u64 offset, bool one_ordered)
> >  {
> >  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> >  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> >  	struct btrfs_ordered_sum *sums;
> >  	struct btrfs_ordered_extent *ordered = NULL;
> > +	const bool page_offsets = (offset == (u64)-1);
> 
> nit: Again, instead of page_offsets perhaps use_page_offsets, somewhat
> more explicit/informative.

Sure, that sounds better.

> >  	char *data;
> >  	struct bvec_iter iter;
> >  	struct bio_vec bvec;
> >  	int index;
> > -	int nr_sectors;
> > +	int blockcount;
> >  	unsigned long total_bytes = 0;
> >  	unsigned long this_sum_bytes = 0;
> >  	int i;
> > -	u64 offset;
> >  	unsigned nofs_flag;
> >  
> >  	nofs_flag = memalloc_nofs_save();
> > @@ -649,18 +649,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> >  	sums->len = bio->bi_iter.bi_size;
> >  	INIT_LIST_HEAD(&sums->list);
> >  
> > -	if (contig)
> > -		offset = file_start;
> > -	else
> > -		offset = 0; /* shut up gcc */
> > -
> >  	sums->bytenr = bio->bi_iter.bi_sector << 9;
> >  	index = 0;
> >  
> >  	shash->tfm = fs_info->csum_shash;
> >  
> >  	bio_for_each_segment(bvec, bio, iter) {
> > -		if (!contig)
> > +		if (page_offsets)
> >  			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
> >  
> >  		if (!ordered) {
> > @@ -668,13 +663,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> >  			BUG_ON(!ordered); /* Logic error */
> >  		}
> >  
> > -		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
> > +		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
> >  						 bvec.bv_len + fs_info->sectorsize
> >  						 - 1);
> >  
> > -		for (i = 0; i < nr_sectors; i++) {
> > -			if (offset >= ordered->file_offset + ordered->num_bytes ||
> > -			    offset < ordered->file_offset) {
> > +		for (i = 0; i < blockcount; i++) {
> > +			if (!one_ordered &&
> > +			    (offset >= ordered->file_offset + ordered->num_bytes ||
> > +			     offset < ordered->file_offset)) {
> 
> Since you are changing this hunk, how about using the in_range macro:
> 
> if (!one_ordered && !in_range(offset, ordered->file_offset,
> ordered->num_bytes) { foo

Will do (although I don't like that that macro evaluates b and first
twice. Someone changing the code later might not notice that.)

> Though I think the "change the ordered extent now that we are working on
> a different range" code should be factored out in a separate function
> because currently it's somewhat breaking the flow of reading.
> 
> >  				unsigned long bytes_left;
> >  
> >  				sums->len = this_sum_bytes;
> > @@ -705,7 +701,8 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> >  					    sums->sums + index);
> >  			kunmap_atomic(data);
> >  			index += fs_info->csum_size;
> > -			offset += fs_info->sectorsize;
> > +			if (!one_ordered)
> > +				offset += fs_info->sectorsize;
> 
> Instead of adding one additional conditional op can't offset always be
> incremented but in the case of one_ordered then the !in_range check
> should always be false i.e we won't be using the offset to lookup a new OE?

I did it conditionally so that it's clearer that the offset isn't needed
for the one_ordered case, but I can drop the check.

> >  			this_sum_bytes += fs_info->sectorsize;
> >  			total_bytes += fs_info->sectorsize;
> >  		}
> 
> 
> <snip>
