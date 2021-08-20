Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74713F2820
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhHTIJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:09:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43714 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhHTIJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:09:20 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFCA51FDE6;
        Fri, 20 Aug 2021 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629446921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHDYvA/hPtFKlWviNCnSNiLYqDyVlHoUMVAkXqq/K9Y=;
        b=RWA6bFCyR91GSXQVDxBZCXJoDuMipQgx9DGkKrZBzoZGPf1sWC4gWUvwl2gpF6PbKZJI4U
        GrOjUzqdhSr4rvq/RN/d38kb5fR5hATxWs544KDecPtt4YdKTMWMO7u3cDA8//864i2GNG
        GShhhwuRdUvE3OYATZAt/zrzuvjto9M=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D4E81333E;
        Fri, 20 Aug 2021 08:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id PKsLHAljH2EDRgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 20 Aug 2021 08:08:41 +0000
Subject: Re: [PATCH v10 03/14] btrfs: don't advance offset for compressed bios
 in btrfs_csum_one_bio()
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <cover.1629234193.git.osandov@fb.com>
 <5cbd7b12d5147d7d619a5f521051e5c4ed5ce6d1.1629234193.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b3517f65-a22b-7c08-536c-1b5fc7d68fab@suse.com>
Date:   Fri, 20 Aug 2021 11:08:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5cbd7b12d5147d7d619a5f521051e5c4ed5ce6d1.1629234193.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.08.21 г. 0:06, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> btrfs_csum_one_bio() loops over each filesystem block in the bio while
> keeping a cursor of its current logical position in the file in order to
> look up the ordered extent to add the checksums to. However, this
> doesn't make much sense for compressed extents, as a sector on disk does
> not correspond to a sector of decompressed file data. It happens to work
> because 1) the compressed bio always covers one ordered extent and 2)
> the size of the bio is always less than the size of the ordered extent.
> However, the second point will not always be true for encoded writes.
> 
> Let's add a boolean parameter to btrfs_csum_one_bio() to indicate that
> it can assume that the bio only covers one ordered extent. Since we're
> already changing the signature, let's get rid of the contig parameter
> and make it implied by the offset parameter, similar to the change we
> recently made to btrfs_lookup_bio_sums(). Additionally, let's rename
> nr_sectors to blockcount to make it clear that it's the number of
> filesystem blocks, not the number of 512-byte sectors.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/btrfs/compression.c |  5 +++--
>  fs/btrfs/ctree.h       |  2 +-
>  fs/btrfs/file-item.c   | 35 ++++++++++++++++-------------------
>  fs/btrfs/inode.c       |  8 ++++----
>  4 files changed, 24 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 7869ad12bc6e..e645b3c2f09a 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -480,7 +480,8 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  			BUG_ON(ret); /* -ENOMEM */
>  
>  			if (!skip_sum) {
> -				ret = btrfs_csum_one_bio(inode, bio, start, 1);
> +				ret = btrfs_csum_one_bio(inode, bio, start,
> +							 true);
>  				BUG_ON(ret); /* -ENOMEM */
>  			}
>  
> @@ -516,7 +517,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
>  	BUG_ON(ret); /* -ENOMEM */
>  
>  	if (!skip_sum) {
> -		ret = btrfs_csum_one_bio(inode, bio, start, 1);
> +		ret = btrfs_csum_one_bio(inode, bio, start, true);
>  		BUG_ON(ret); /* -ENOMEM */
>  	}
>  
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index f07c82fafa04..be245b4b8efe 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3111,7 +3111,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct btrfs_ordered_sum *sums);
>  blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> -				u64 file_start, int contig);
> +				u64 offset, bool one_ordered);
>  int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>  			     struct list_head *list, int search_commit);
>  void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 2673c6ba7a4e..844fae923340 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -614,28 +614,28 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>   * btrfs_csum_one_bio - Calculates checksums of the data contained inside a bio
>   * @inode:	 Owner of the data inside the bio
>   * @bio:	 Contains the data to be checksummed
> - * @file_start:  offset in file this bio begins to describe
> - * @contig:	 Boolean. If true/1 means all bio vecs in this bio are
> - *		 contiguous and they begin at @file_start in the file. False/0
> - *		 means this bio can contain potentially discontiguous bio vecs
> - *		 so the logical offset of each should be calculated separately.
> + * @offset:      If (u64)-1, @bio may contain discontiguous bio vecs, so the
> + *               file offsets are determined from the page offsets in the bio.
> + *               Otherwise, this is the starting file offset of the bio vecs in
> + *               @bio, which must be contiguous.
> + * @one_ordered: If true, @bio only refers to one ordered extent.

nit: I don't have strong preference but my gut feeling tells me
"single_ordered" might be more explicit/informative. But unless someone
else thinks the same one_ordered would also make do

>   */
>  blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
> -		       u64 file_start, int contig)
> +				u64 offset, bool one_ordered)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	struct btrfs_ordered_sum *sums;
>  	struct btrfs_ordered_extent *ordered = NULL;
> +	const bool page_offsets = (offset == (u64)-1);

nit: Again, instead of page_offsets perhaps use_page_offsets, somewhat
more explicit/informative.

>  	char *data;
>  	struct bvec_iter iter;
>  	struct bio_vec bvec;
>  	int index;
> -	int nr_sectors;
> +	int blockcount;
>  	unsigned long total_bytes = 0;
>  	unsigned long this_sum_bytes = 0;
>  	int i;
> -	u64 offset;
>  	unsigned nofs_flag;
>  
>  	nofs_flag = memalloc_nofs_save();
> @@ -649,18 +649,13 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
>  	sums->len = bio->bi_iter.bi_size;
>  	INIT_LIST_HEAD(&sums->list);
>  
> -	if (contig)
> -		offset = file_start;
> -	else
> -		offset = 0; /* shut up gcc */
> -
>  	sums->bytenr = bio->bi_iter.bi_sector << 9;
>  	index = 0;
>  
>  	shash->tfm = fs_info->csum_shash;
>  
>  	bio_for_each_segment(bvec, bio, iter) {
> -		if (!contig)
> +		if (page_offsets)
>  			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
>  
>  		if (!ordered) {
> @@ -668,13 +663,14 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
>  			BUG_ON(!ordered); /* Logic error */
>  		}
>  
> -		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,
> +		blockcount = BTRFS_BYTES_TO_BLKS(fs_info,
>  						 bvec.bv_len + fs_info->sectorsize
>  						 - 1);
>  
> -		for (i = 0; i < nr_sectors; i++) {
> -			if (offset >= ordered->file_offset + ordered->num_bytes ||
> -			    offset < ordered->file_offset) {
> +		for (i = 0; i < blockcount; i++) {
> +			if (!one_ordered &&
> +			    (offset >= ordered->file_offset + ordered->num_bytes ||
> +			     offset < ordered->file_offset)) {

Since you are changing this hunk, how about using the in_range macro:

if (!one_ordered && !in_range(offset, ordered->file_offset,
ordered->num_bytes) { foo

Though I think the "change the ordered extent now that we are working on
a different range" code should be factored out in a separate function
because currently it's somewhat breaking the flow of reading.

>  				unsigned long bytes_left;
>  
>  				sums->len = this_sum_bytes;
> @@ -705,7 +701,8 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
>  					    sums->sums + index);
>  			kunmap_atomic(data);
>  			index += fs_info->csum_size;
> -			offset += fs_info->sectorsize;
> +			if (!one_ordered)
> +				offset += fs_info->sectorsize;

Instead of adding one additional conditional op can't offset always be
incremented but in the case of one_ordered then the !in_range check
should always be false i.e we won't be using the offset to lookup a new OE?

>  			this_sum_bytes += fs_info->sectorsize;
>  			total_bytes += fs_info->sectorsize;
>  		}


<snip>
