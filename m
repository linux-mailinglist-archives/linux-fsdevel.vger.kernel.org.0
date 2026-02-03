Return-Path: <linux-fsdevel+bounces-76131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIuZJraTgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:20:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0B7D5269
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E023041BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA3366546;
	Tue,  3 Feb 2026 06:20:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0CE56A;
	Tue,  3 Feb 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099628; cv=none; b=eDn7ZKlXIT388Dj37TZFQagDh6bts9jU8yZzV9wJukrgap7zweM5kXXR7vkLftGD4qH7Gx03GSDBntFoZ/uFcERDnnEnEe9OE9RHfRS6VutwiCblanh1Lh0Hr0We0+OCpJQxe35qzwMs4uBjP9Ifuhu71hUVOtacJHOM9D67HPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099628; c=relaxed/simple;
	bh=rlmMKynLDgirI7Kia8Jgk3NWjYUexPdmfWKeII4Qsvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTV2kEkeDG1ihGAQIjlc3VQ0W/7eElSYrJbOCCFixsfX5bjcRyHbfuuJLQogWVSxhyrTQXTu2GwOByFMe6eIfXbte1ePm1gpSzYNjoYwzWbwX1MWFVtc0P6Z0Ns8Csq5HIkMCqQ5CPBZJ/TQFimbBmL/gCSNCiGA6QXSYB00OlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 895B668BEB; Tue,  3 Feb 2026 07:20:19 +0100 (CET)
Date: Tue, 3 Feb 2026 07:20:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v6 09/16] ntfs: update iomap and address space
 operations
Message-ID: <20260203062018.GF16426@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-10-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-10-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-76131-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED0B7D5269
X-Rspamd-Action: no action

Suggested commit message:

Update the address space operations to use the iomap framework,
replacing legacy buffer-head based code.

> +#include <linux/mpage.h>

This include should not be needed (same in iomap.c).

> +#include <linux/uio.h>

This should not be needed either (same in iomap.c).

> -};
> +static void ntfs_readahead(struct readahead_control *rac)
> +{
> +	struct address_space *mapping = rac->mapping;
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = NTFS_I(inode);
>  
> +	if (!NInoNonResident(ni) || NInoCompressed(ni)) {
> +		/* No readahead for resident and compressed. */

As-is this comment is useless ads it states the obvious.  If you
want to make it useful add why it is not implemented.

> +static int ntfs_writepages(struct address_space *mapping,
> +		struct writeback_control *wbc)
> +{
> +	struct inode *inode = mapping->host;
> +	struct ntfs_inode *ni = NTFS_I(inode);
> +	struct iomap_writepage_ctx wpc = {
> +		.inode		= mapping->host,
> +		.wbc		= wbc,
> +		.ops		= &ntfs_writeback_ops,
> +	};
> +
> +	if (NVolShutdown(ni->vol))
> +		return -EIO;
>  
> +	if (!NInoNonResident(ni))
> +		return 0;
>  
> +	/* If file is encrypted, deny access, just like NT4. */

I don't understand this comment.

> +void mark_ntfs_record_dirty(struct folio *folio)
> +{
> +	iomap_dirty_folio(folio->mapping, folio);
> +}

Should this be in mft.c and have a mft_ compoenent in the name?

> +	if (!NInoNonResident(ni))
> +		goto out;

Split the resident handling into a helper to keep the method
simple?

> +static int __ntfs_read_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		unsigned int flags, struct iomap *iomap, struct iomap *srcmap,
> +		bool need_unwritten)
> +{
> +	struct ntfs_inode *ni = NTFS_I(inode);
> +	int ret;
> +
> +	if (NInoNonResident(ni))
> +		ret = ntfs_read_iomap_begin_non_resident(inode, offset, length,
> +				flags, iomap, need_unwritten);
> +	else
> +		ret = ntfs_read_iomap_begin_resident(inode, offset, length,
> +				flags, iomap);
> +
> +	return ret;

This could be simplified to:

	if (NInoNonResident(NTFS_I(inode)))
		return ntfs_read_iomap_begin_non_resident(inode, offset, length,
				flags, iomap, need_unwritten);
	return ntfs_read_iomap_begin_resident(inode, offset, length, flags,
			iomap);

> +int ntfs_zero_range(struct inode *inode, loff_t offset, loff_t length, bool bdirect)
> +{
> +	if (bdirect) {
> +		if ((offset | length) & (SECTOR_SIZE - 1))
> +			return -EINVAL;
> +
> +		return  blkdev_issue_zeroout(inode->i_sb->s_bdev,
> +					     offset >> SECTOR_SHIFT,
> +					     length >> SECTOR_SHIFT,
> +					     GFP_NOFS,
> +					     BLKDEV_ZERO_NOUNMAP);
> +	}
> +
> +	return iomap_zero_range(inode,
> +				offset, length,
> +				NULL,
> +				&ntfs_zero_read_iomap_ops,
> +				&ntfs_zero_iomap_folio_ops,
> +				NULL);
> +}

This really should be two separate helpers.

> +	if (NInoNonResident(ni)) {

As separate non-resident helper would be useful here.

> +		if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
> +			ret = ntfs_write_iomap_begin_non_resident(inode, offset,
> +					length, iomap);
> +		else
> +			ret = ntfs_write_da_iomap_begin_non_resident(inode,
> +					offset, length, flags, iomap,
> +					ntfs_iomap_flags);
> +	} else {
> +		mutex_lock(&ni->mrec_lock);
> +		ret = ntfs_write_iomap_begin_resident(inode, offset, iomap);
> +	}
> +
> +	return ret;

But eveven without that, direct returns would really help here:

	if (!NInoNonResident(ni)) {
		mutex_lock(&ni->mrec_lock);
		return ntfs_write_iomap_begin_resident(inode, offset, iomap);
	}

	...

	if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
		return ntfs_write_iomap_begin_non_resident(inode, offset,
				length, iomap);
	return ntfs_write_da_iomap_begin_non_resident(inode, offset, length,
			flags, iomap,

> +static int ntfs_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
> +		ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +	if (iomap->type == IOMAP_INLINE) {

A separate inline helper would help here as well.


