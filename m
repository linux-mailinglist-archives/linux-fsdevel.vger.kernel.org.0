Return-Path: <linux-fsdevel+bounces-75212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJjaHEsPc2ntrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:03:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DB70B67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D3F3013AAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1809353EFC;
	Fri, 23 Jan 2026 06:03:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327839DB2D;
	Fri, 23 Jan 2026 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769148220; cv=none; b=o0n/AL6j3tN0tTe7n6dwPDM4NaEZstLCKP/bt9y4HYe9h6C0pjBHwEvdKT4zd0Io0EjQNLfWyP/8GVV5xmZ6gsK9ewovFPSuvNqhfoJO+0Q/nAfwgSpwtqufL9zi3eqqpg6betCrAi5sleCWdi6j1XWYQebp3KVhStqtRWMKQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769148220; c=relaxed/simple;
	bh=8zXevHCiQlwD1YM0UVR6IlpunPXzvwjAu7tMywiNfZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL9nD/WKHSE5Zqn7iwQzjZbFUgUnxWtBXe+O2JyGEVtCoKYSNgolvwyTfM6W0wgh72pM1upe3aqW7bMUXLSS7mkXgiyAiyfWZLtwKNdyFT4xfbTiLGUE5dkVaQRaVvD18JT9AUqRpQ6+0Pa7ICeP6HSyouFIOyAIe1x45mNIa2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4C0C227AAF; Fri, 23 Jan 2026 07:03:24 +0100 (CET)
Date: Fri, 23 Jan 2026 07:03:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
Message-ID: <20260123060324.GA25239@lst.de>
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-2-hch@lst.de> <20260123000113.GF5945@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123000113.GF5945@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75212-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: F23DB70B67
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:01:13PM -0800, Darrick J. Wong wrote:
> >  /**
> >   * bio_integrity_prep - Prepare bio for integrity I/O
> >   * @bio:	bio to prepare
> > + * @action:	preparation action needed
> 
> What is @action?

Yes.

> Is it a bitset of BI_ACT_* values?  If yes, then can
> the comment please say that explicitly?

Is this good enough?

 * @action:     preparation action needed (BI_ACT_*)

> > +static bool bi_offload_capable(struct blk_integrity *bi)
> > +{
> > +	return bi->metadata_size == bi->pi_tuple_size;
> > +}
> 
> Just out of curiosity, what happens if metadata_size > pi_tuple_size?

Then we still have to provide a buffer as the automatic insert/strip
doesn't work. (I find the offload name rather confusing for this)

> Can it be the case that metadata_size < pi_tuple_size?

No.  See blk_validate_integrity_limits:

	if (bi->pi_offset + bi->pi_tuple_size > bi->metadata_size) {
		pr_warn("pi_offset (%u) + pi_tuple_size (%u) exceeds metadata_size (%u)\n",
			bi->pi_offset, bi->pi_tuple_size,
			bi->metadata_size);
		return -EINVAL;
	}


> 
> > +unsigned int __bio_integrity_action(struct bio *bio)
> 
> Hrm, this function returns a bitset of BI_ACT_* flags, doesn't it?
> 
> Would be kinda nice if a comment could say that.

Is this ok?

/**
 * bio_integrity_action - return the integrity action needed for a bio
 * @bio:        bio to operate on
 *
 * Returns the mask of integrity actions (BI_ACT_*) that need to be performed
 * for @bio.
 */


> > +		/*
> > +		 * Zero the memory allocated to not leak uninitialized kernel
> > +		 * memory to disk for non-integrity metadata where nothing else
> > +		 * initializes the memory.
> 
> Er... does someone initialize it eventually?  Such as the filesystem?
> Or maybe an io_uring caller?

For integrity metadata?  The code called later fills it out.  But it
doesn't fill non-integrity metadata, so we need to zero it.

> > +		 */
> > +		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
> > +			if (bi_offload_capable(bi))
> > +				return 0;
> > +			return BI_ACT_BUFFER | BI_ACT_ZERO;
> > +		}
> > +
> > +		if (bi->metadata_size > bi->pi_tuple_size)
> > +			return BI_ACT_BUFFER | BI_ACT_CHECK | BI_ACT_ZERO;
> > +		return BI_ACT_BUFFER | BI_ACT_CHECK;
> 
> "check" feels like a weird name for a write, where we're generating the
> PI information.  It really means "block layer takes care of PI
> generation and validation", right?  As opposed to whichever upper layer
> is using the block device?
> 
> BI_ACT_YOUDOIT <snerk>
> 
> How about BI_ACT_BDEV /* block layer checks/validates PI */

I think BI_ACT_BDEV is not very useful.  Check is supposed to
include generate and verify, but I'm not sure how we could word this
in a nice way.


