Return-Path: <linux-fsdevel+bounces-73455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FFED1A0A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC383027CFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4F340D82;
	Tue, 13 Jan 2026 15:57:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37927B32C;
	Tue, 13 Jan 2026 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319827; cv=none; b=Q26WyXNYtHhYJaCgKajN28GocgJyZCNmO2fnUqS/P5YNdFrmhcAIUsW8CVVnq0q7ISbl26wBWAvdEW4daHlbU7aJ2TlHnyo+1piU9d/UNLy12cfqKB20fMq9rBHAy9vDaykdKgPMpIRVvvRPSNHU8FjfytsxSlEpnuNAXTBLMOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319827; c=relaxed/simple;
	bh=qu36tlXCsNiZ1+Et9vZX+jYAnpoE9hsm0KPQEcPcwIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwaQ/w0rrdkzfSdXpCkUYm062J+3dOPirouwint42pN4w2fXhlTbRjbcmvtskU/HAWYJNHwv0BpEB52o2lcTmRiJ1adWP6mptUIVU/zBgkUBl29/9hJGM4wCrx9H8iBkNsPgy/j02dSA08xvcv1kVwK8mAgyqkjeXFwXxD/uzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 852A6227AA8; Tue, 13 Jan 2026 16:57:01 +0100 (CET)
Date: Tue, 13 Jan 2026 16:57:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/11] xfs: add media verification ioctl
Message-ID: <20260113155701.GA3489@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412941.3493441.8359506127711497025.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 04:35:25PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new privileged ioctl so that xfs_scrub can ask the kernel to
> verify the media of the devices backing an xfs filesystem, and have any
> resulting media errors reported to fsnotify and xfs_healer.

Hmm, the description is a bit sparse?

> +/* Verify the media of the underlying devices */
> +struct xfs_verify_media {
> +	__u32	dev;		/* I: XFS_VERIFY_*DEV */

This should probably use the enum xfs_device values?

> +#define XFS_VERIFY_TO_EOD	(~0ULL)	/* end of disk */

Is there much of a point in this flag?  scrub/healer really should
know the device size, shouldn't they?

> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index 1edc4ddd10cdb2..5ef4109cc062d2 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c

There's basically no overlap with the existing code in this file,
why not add a new one?

> +	const unsigned int	iosize = BIO_MAX_VECS << PAGE_SHIFT;
> +	unsigned int		bufsize = iosize;

That's a pretty gigantic buffer size.  In general a low number of
MB should max out most current devices, and for a background scrub
you generally do not want to actually max out the device..

The in the background is also a good point here - we probably want
a way to tune the size as it might put too much of a load onto the
system pretty easily, and we need a way to dial it back.

> +	folio = folio_alloc(GFP_KERNEL, get_order(bufsize));
> +	if (!folio)

That first folio_alloc will cause nasty stack traces when it fails.

> +		folio = folio_alloc(GFP_KERNEL, 0);

.. and then we fall back to just a single page.  This is what I ended
up writing for an about to submitted series elsewhere:

static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size)
{
        struct folio *folio;
                
        while (*size > PAGE_SIZE) {
                folio = folio_alloc(gfp | __GFP_NORETRY, get_order(*size));
                if (folio)
                        return folio;
                *size = rounddown_pow_of_two(*size - 1);
        }

        return folio_alloc(gfp, get_order(*size));
}               

although that is a bit more complicated as we never want to round
up the actual size.

> +		for (i = 0; i < nr_vecs; i++) {
> +			unsigned int	vec_sects =
> +				min(nr_sects, bufsize >> SECTOR_SHIFT);
> +
> +			bio_add_folio_nofail(bio, folio,
> +					vec_sects << SECTOR_SHIFT, 0);
> +
> +			bio_daddr += vec_sects;
> +			bio_bbcount -= vec_sects;
> +			bio_submitted += vec_sects;
> +		}

A single folio is always just a single vetor in the bio.  No need
for any of the looping here.

> +		/* Don't let too many IOs accumulate */
> +		if (bio_submitted > SZ_256M >> SECTOR_SHIFT) {
> +			blk_finish_plug(&plug);
> +			error = submit_bio_wait(bio);

Also the building up and chaining here seems harmful.  If you're
on SSDs you want to fire things off ASAP if you have large I/O.
On a HDD we'll take care of it below, but the bios will usually
actually be split, not merged anyway as they are beyond the
supported I/O size of the HBAs.


