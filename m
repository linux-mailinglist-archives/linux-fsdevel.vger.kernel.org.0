Return-Path: <linux-fsdevel+bounces-72547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24BCFB1A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 22:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877533062165
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A7314A80;
	Tue,  6 Jan 2026 21:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoRCVqd7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02421420B;
	Tue,  6 Jan 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767735353; cv=none; b=d+IAAB4A3aARo6t0aNBVWmHiO4SjOB1p5EcD2RW98ca/E90q/V+PLlpf6OTs7H1r+4ky36th0NaUdvdMHtR7Sx49TZ/7PE6Ikj8JDjNQgGaJdNmEsyhAPrCMvLwN9Ud8e/PqJI/p14WhGe9565whK6ZgL+RpaowsbMEvMN0v5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767735353; c=relaxed/simple;
	bh=X5IcB1/U9Xekz2JospLkvN1xulR11rFesSjYjgTEeVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3K+tzgvJWdzIxtw0JVP3Am2f4L7+BP56zr9CIHfYluchNSskKQXdnYAlKhqU/JK71KzoBemHee4okIegEmrubq+9qX6olahEhOqYX+Pcb2zbm85ThBvQNX0Fl6HvWznCwaiMz2mXtotryK5Ic02rXwBa69slSNoLTlC57Afui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PoRCVqd7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F4hCKf7paaYEHKBHCWWN44xar04oNZYgrJCMWr62Fuk=; b=PoRCVqd7r/p4lSRp1eOkAVL87v
	so6gXYX/XHJ8TuYaCyoz5blR9eR0Dqe0H8I/04A80OofFfUYPdVDF0RJlxAaeZP4y0ikwm7+KTOYJ
	83BbJPlUhzaefJxa1yi1l7DrZ2i/PhTb4SAtw4J9NXRCQKcc4mxvPcwYO1eq7V3nmxoo14jWZ+Es2
	6nv+0BfdkpuwvH32xtGQpy3mnHmWCBRUuwfp8GM+G1geqnVGVevWvsMITUTB9h+z/BO703Z0gwY3e
	vCZDWJyLv14m0v85JNFurf9rdxSD5ilny/jgJ6MX/GCDhh+e6R9iuo3pwlqIEk7WlUAdH5qoRKdwr
	VOnlz13w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdEiK-0000000CW5U-3QL9;
	Tue, 06 Jan 2026 21:35:40 +0000
Date: Tue, 6 Jan 2026 21:35:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v4 07/14] ntfs: update iomap and address space operations
Message-ID: <aV2ALM3uLrd7C3Nm@casper.infradead.org>
References: <20260106131110.46687-1-linkinjeon@kernel.org>
 <20260106131110.46687-8-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106131110.46687-8-linkinjeon@kernel.org>

On Tue, Jan 06, 2026 at 10:11:03PM +0900, Namjae Jeon wrote:
> +++ b/fs/ntfs/aops.c
> @@ -1,354 +1,36 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * aops.c - NTFS kernel address space operations and page cache handling.
> +/**

Why did you turn this into a kernel-doc comment?

> +static s64 ntfs_convert_folio_index_into_lcn(struct ntfs_volume *vol, struct ntfs_inode *ni,
> +		unsigned long folio_index)

This is a pretty bad function name.  lcn_from_index() would be better.
It's also better to wrap at 80 columns if reasonable.

> @@ -358,8 +40,8 @@ static int ntfs_read_block(struct folio *folio)
>   *
>   * For non-resident attributes, ntfs_read_folio() fills the @folio of the open
>   * file @file by calling the ntfs version of the generic block_read_full_folio()
> - * function, ntfs_read_block(), which in turn creates and reads in the buffers
> - * associated with the folio asynchronously.
> + * function, which in turn creates and reads in the buffers associated with
> + * the folio asynchronously.

Is this comment still true?

> +static int ntfs_write_mft_block(struct ntfs_inode *ni, struct folio *folio,
> +		struct writeback_control *wbc)
>  {
> +	struct inode *vi = VFS_I(ni);
> +	struct ntfs_volume *vol = ni->vol;
> +	u8 *kaddr;
> +	struct ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
> +	int nr_locked_nis = 0, err = 0, mft_ofs, prev_mft_ofs;
> +	struct bio *bio = NULL;
> +	unsigned long mft_no;
> +	struct ntfs_inode *tni;
> +	s64 lcn;
> +	s64 vcn = NTFS_PIDX_TO_CLU(vol, folio->index);
> +	s64 end_vcn = NTFS_B_TO_CLU(vol, ni->allocated_size);
> +	unsigned int folio_sz;
> +	struct runlist_element *rl;
> +
> +	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, folio index 0x%lx.",
> +			vi->i_ino, ni->type, folio->index);
> +
> +	lcn = ntfs_convert_folio_index_into_lcn(vol, ni, folio->index);
> +	if (lcn <= LCN_HOLE) {
> +		folio_start_writeback(folio);
> +		folio_unlock(folio);
> +		folio_end_writeback(folio);
> +		return -EIO;
>  	}
>
> +	/* Map folio so we can access its contents. */
> +	kaddr = kmap_local_folio(folio, 0);
> +	/* Clear the page uptodate flag whilst the mst fixups are applied. */
> +	folio_clear_uptodate(folio);
> +
> +	for (mft_ofs = 0; mft_ofs < PAGE_SIZE && vcn < end_vcn;
> +	     mft_ofs += vol->mft_record_size) {
> +		/* Get the mft record number. */
> +		mft_no = (((s64)folio->index << PAGE_SHIFT) + mft_ofs) >>
> +			vol->mft_record_size_bits;
> +		vcn = NTFS_MFT_NR_TO_CLU(vol, mft_no);
> +		/* Check whether to write this mft record. */
> +		tni = NULL;
> +		if (ntfs_may_write_mft_record(vol, mft_no,
> +					(struct mft_record *)(kaddr + mft_ofs), &tni)) {
> +			unsigned int mft_record_off = 0;
> +			s64 vcn_off = vcn;
>  
> +			 * Skip $MFT extent mft records and let them being written
> +			 * by writeback to avioid deadlocks. the $MFT runlist
> +			 * lock must be taken before $MFT extent mrec_lock is taken.
>  			 */
> +			if (tni && tni->nr_extents < 0 &&
> +				tni->ext.base_ntfs_ino == NTFS_I(vol->mft_ino)) {
> +				mutex_unlock(&tni->mrec_lock);
> +				atomic_dec(&tni->count);
> +				iput(vol->mft_ino);
>  				continue;
>  			}
>  			/*
> +			 * The record should be written.  If a locked ntfs
> +			 * inode was returned, add it to the array of locked
> +			 * ntfs inodes.
>  			 */
> +			if (tni)
> +				locked_nis[nr_locked_nis++] = tni;
>  
> +			if (bio && (mft_ofs != prev_mft_ofs + vol->mft_record_size)) {
> +flush_bio:
> +				flush_dcache_folio(folio);
> +				submit_bio_wait(bio);

Do you really need to wait for the bio to complete synchronously?
That seems like it'll stall writeback unnecessarily.  Can't you just
fire it off and move on to the next bio?

> +				bio_put(bio);
> +				bio = NULL;
> +			}
>  
> +			if (vol->cluster_size < folio_size(folio)) {
> +				down_write(&ni->runlist.lock);
> +				rl = ntfs_attr_vcn_to_rl(ni, vcn_off, &lcn);
> +				up_write(&ni->runlist.lock);
> +				if (IS_ERR(rl) || lcn < 0) {
> +					err = -EIO;
> +					goto unm_done;
> +				}
>  
> +				if (bio &&
> +				   (bio_end_sector(bio) >> (vol->cluster_size_bits - 9)) !=
> +				    lcn) {
> +					flush_dcache_folio(folio);
> +					submit_bio_wait(bio);
> +					bio_put(bio);
> +					bio = NULL;
> +				}
> +			}
>  
> +			if (!bio) {
> +				unsigned int off;
>  
> +				off = ((mft_no << vol->mft_record_size_bits) +
> +				       mft_record_off) & vol->cluster_size_mask;
> +
> +				bio = bio_alloc(vol->sb->s_bdev, 1, REQ_OP_WRITE,
> +						GFP_NOIO);
> +				bio->bi_iter.bi_sector =
> +					NTFS_B_TO_SECTOR(vol, NTFS_CLU_TO_B(vol, lcn) + off);
>  			}
> +
> +			if (vol->cluster_size == NTFS_BLOCK_SIZE &&
> +			    (mft_record_off ||
> +			     rl->length - (vcn_off - rl->vcn) == 1 ||
> +			     mft_ofs + NTFS_BLOCK_SIZE >= PAGE_SIZE))
> +				folio_sz = NTFS_BLOCK_SIZE;
> +			else
> +				folio_sz = vol->mft_record_size;
> +			if (!bio_add_folio(bio, folio, folio_sz,
> +					   mft_ofs + mft_record_off)) {
> +				err = -EIO;
> +				bio_put(bio);
> +				goto unm_done;
>  			}
> +			mft_record_off += folio_sz;
> +
> +			if (mft_record_off != vol->mft_record_size) {
> +				vcn_off++;
> +				goto flush_bio;
>  			}
> +			prev_mft_ofs = mft_ofs;
>  
>  			if (mft_no < vol->mftmirr_size)
>  				ntfs_sync_mft_mirror(vol, mft_no,
> +						(struct mft_record *)(kaddr + mft_ofs));
>  		}
> +
>  	}
> +
> +	if (bio) {
> +		flush_dcache_folio(folio);
> +		submit_bio_wait(bio);
> +		bio_put(bio);
>  	}
> +	flush_dcache_folio(folio);
>  unm_done:
> +	folio_mark_uptodate(folio);
> +	kunmap_local(kaddr);
> +
> +	folio_start_writeback(folio);
> +	folio_unlock(folio);
> +	folio_end_writeback(folio);
> +
>  	/* Unlock any locked inodes. */
>  	while (nr_locked_nis-- > 0) {
> +		struct ntfs_inode *base_tni;
> +
>  		tni = locked_nis[nr_locked_nis];
> +		mutex_unlock(&tni->mrec_lock);
> +
>  		/* Get the base inode. */
>  		mutex_lock(&tni->extent_lock);
>  		if (tni->nr_extents >= 0)
>  			base_tni = tni;
> +		else
>  			base_tni = tni->ext.base_ntfs_ino;
>  		mutex_unlock(&tni->extent_lock);
>  		ntfs_debug("Unlocking %s inode 0x%lx.",
>  				tni == base_tni ? "base" : "extent",
>  				tni->mft_no);
>  		atomic_dec(&tni->count);
>  		iput(VFS_I(base_tni));
>  	}
> +
> +	if (unlikely(err && err != -ENOMEM))
>  		NVolSetErrors(vol);
>  	if (likely(!err))
>  		ntfs_debug("Done.");
>  	return err;
>  }

Woof, that's a long function.  I'm out of time now.

