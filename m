Return-Path: <linux-fsdevel+bounces-70293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1BC96060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 08:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE18A4E1350
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4578D29B775;
	Mon,  1 Dec 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEOKyQeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C449296BC9;
	Mon,  1 Dec 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764574559; cv=none; b=oA5ZcsPlBwWiAUM5Bv84SA3LcpIw2vp11eWjv0b10DoODvYm4RJkODs/iU4MnCE9wmt0fjFhba7PslCcaKx2eMNbkBeH2WXNnvjiAkmvo1xD2ss+msPzRPfS5wFPLNoWqYEnQMQ5qxVwHpFYZyTeTGQCwdjmssfGyCVL9HcCm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764574559; c=relaxed/simple;
	bh=FjET55jAWW8S9d6H42bktjUainZvmPkvNYutmLYIk0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haQGHL3EdM0vGysgzzyXDxR3gGC16z/zML5aVFx4Q0c6N8Vv1b4Rb7glkcDfDogDz7ND1WZAGmxgjcWmmOH897tWNEd/yY30Ig2/fmcFbyuL6y49BcjhjSHD6FYOar18nT4hADRhU7JgJwYectMdNPXyq70JrkJl4gLY2s3z2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MEOKyQeI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2R/Tcu3IoYeNiwv5L5Dob9+KJcDDt8d1mi1rRZPMrjI=; b=MEOKyQeInnSzdodGfTDKsHzkUj
	6a7PZS7K/Dl6X54qIbnA8pwtFvJD2CKx1JrBg/YbnRYW+Pw/f4Zozl3i79cf2NDgMzbeWmIiHpXfy
	Wpy/ZzJwmKc12D2c4On0Ow3rVPp7bnMKAoYwvmwQ658f8+dYGFs6hFZZ0DiioBlVGIfua9Fp3Drrq
	hBLaLErGTACSqRfikSOK7kfZtY0arKvlZQb/HkIv+kyGjBpUnlX6pM8f4cuVbtmo2XWwI/mYwH/YH
	YVViGBeQwe7V2ga04FVq9tHzlOrH3iyktSxgo0nfFEs27XjKN1fIag7Pfd7nQhNxnDlqPFWW0AR2p
	5HaTTDvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPyRo-000000033zl-3WSg;
	Mon, 01 Dec 2025 07:35:48 +0000
Date: Sun, 30 Nov 2025 23:35:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name,
	amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v2 06/11] ntfsplus: add iomap and address space operations
Message-ID: <aS1FVIfE0Ntgbr5I@infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <20251127045944.26009-7-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127045944.26009-7-linkinjeon@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +#include "ntfs_iomap.h"
> +
> +static s64 ntfs_convert_page_index_into_lcn(struct ntfs_volume *vol, struct ntfs_inode *ni,
> +		unsigned long page_index)
> +{
> +	sector_t iblock;
> +	s64 vcn;
> +	s64 lcn;
> +	unsigned char blocksize_bits = vol->sb->s_blocksize_bits;
> +
> +	iblock = (s64)page_index << (PAGE_SHIFT - blocksize_bits);
> +	vcn = (s64)iblock << blocksize_bits >> vol->cluster_size_bits;

I've seen this calculate in quite a few places, should there be a
generic helper for it?

> +struct bio *ntfs_setup_bio(struct ntfs_volume *vol, blk_opf_t opf, s64 lcn,
> +		unsigned int pg_ofs)
> +{
> +	struct bio *bio;
> +
> +	bio = bio_alloc(vol->sb->s_bdev, 1, opf, GFP_NOIO);
> +	if (!bio)
> +		return NULL;

bio_alloc never returns NULL if it can sleep.

> +	bio->bi_iter.bi_sector = ((lcn << vol->cluster_size_bits) + pg_ofs) >>
> +		vol->sb->s_blocksize_bits;

With a helper to calculate the sector the ntfs_setup_bio helper becomes
somewhat questionable.

> +static int ntfs_read_folio(struct file *file, struct folio *folio)
> +{
> +	loff_t i_size;
> +	struct inode *vi;
> +	struct ntfs_inode *ni;
> +
> +	vi = folio->mapping->host;
> +	i_size = i_size_read(vi);
> +	/* Is the page fully outside i_size? (truncate in progress) */
> +	if (unlikely(folio->index >= (i_size + PAGE_SIZE - 1) >>
> +			PAGE_SHIFT)) {
> +		folio_zero_segment(folio, 0, PAGE_SIZE);
> +		ntfs_debug("Read outside i_size - truncated?");
> +		folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +		return 0;
> +	}

iomap should be taking care of this, why do you need the extra
handling?

> +	/*
> +	 * This can potentially happen because we clear PageUptodate() during
> +	 * ntfs_writepage() of MstProtected() attributes.
> +	 */
> +	if (folio_test_uptodate(folio)) {
> +		folio_unlock(folio);
> +		return 0;
> +	}

Clearing the folio uptodate flag sounds fairly dangerous, why is that
done?

> +static int ntfs_write_mft_block(struct ntfs_inode *ni, struct folio *folio,
> +		struct writeback_control *wbc)

Just a very high-level comment here with no immediate action needed:
Is there a reall good reason to use the page cache for metadata?
Our experience with XFS is that a dedicated buffer cache is not only
much easier to use, but also allows for much better caching.

> +static void ntfs_readahead(struct readahead_control *rac)
> +{
> +	struct address_space *mapping = rac->mapping;
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = NTFS_I(inode);
> +
> +	if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> +		/* No readahead for resident and compressed. */
> +		return;
> +	}
> +
> +	if (NInoMstProtected(ni) &&
> +	    (ni->mft_no == FILE_MFT || ni->mft_no == FILE_MFTMirr))
> +		return;

Can you comment on why readahead is skipped here?

> +/**
> + * ntfs_compressed_aops - address space operations for compressed inodes
> + */
> +const struct address_space_operations ntfs_compressed_aops = {

From code in other patches is looks like ntfs never switches between
compressed and non-compressed for live inodes?  In that case the
separate aops should be fine, as switching between them at runtime
would involve races.  Is the compression policy per-directory?

> +		kaddr = kmap_local_folio(folio, 0);
> +		offset = (loff_t)idx << PAGE_SHIFT;
> +		to = min_t(u32, end - offset, PAGE_SIZE);
> +
> +		memcpy(buf + buf_off, kaddr + from, to);
> +		buf_off += to;
> +		kunmap_local(kaddr);
> +		folio_put(folio);
> +	}

Would this be a candidate for memcpy_from_folio?

> +		kaddr = kmap_local_folio(folio, 0);
> +		offset = (loff_t)idx << PAGE_SHIFT;
> +		to = min_t(u32, end - offset, PAGE_SIZE);
> +
> +		memcpy(kaddr + from, buf + buf_off, to);
> +		buf_off += to;
> +		kunmap_local(kaddr);
> +		folio_mark_uptodate(folio);
> +		folio_mark_dirty(folio);

And memcpy_to_folio?

> +++ b/fs/ntfsplus/ntfs_iomap.c

Any reason for the ntfs_ prefix here?

> +static void ntfs_iomap_put_folio(struct inode *inode, loff_t pos,
> +		unsigned int len, struct folio *folio)
> +{

This seems to basically be entirely about extra zeroing.  Can you
explain why this is needed in a comment?

> +static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct ntfs_inode *base_ni, *ni = NTFS_I(inode);
> +	struct ntfs_attr_search_ctx *ctx;
> +	loff_t i_size;
> +	u32 attr_len;
> +	int err = 0;
> +	char *kattr;
> +	struct page *ipage;
> +
> +	if (NInoNonResident(ni)) {

Can you split the resident and non-resident cases into separate
helpers to keep this easier to follow?
easier to follow?

> +	ipage = alloc_page(__GFP_NOWARN | __GFP_IO | __GFP_ZERO);
> +	if (!ipage) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy(page_address(ipage), kattr, attr_len);

Is there a reason for this being a page allocation vs a kmalloc
sized to the inline data?

> +static int ntfs_buffered_zeroed_clusters(struct inode *vi, s64 vcn)

I think this should be ntfs_buffered_zero_clusters as it
performans the action?

Also curious why this can't use the existing iomap zeroing helper?

> +int ntfs_zeroed_clusters(struct inode *vi, s64 lcn, s64 num)

ntfs_zero_clusters

Again curious why we need special zeroing code in the file system.

> +	if (NInoNonResident(ni)) {

Another case for splitting the resident/non-resident code instead
of having a giant conditional block that just returns. 


