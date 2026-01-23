Return-Path: <linux-fsdevel+bounces-75223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAlhGr0gc2ngsQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:18:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9117198D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF6A53010DB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBDE372B46;
	Fri, 23 Jan 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYPxJfIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448F36604B;
	Fri, 23 Jan 2026 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152404; cv=none; b=ug+91mQtK/SPHBYO2qINAKMR4sWne8PqHz4NTd1rBlm1QfatMoZH4HwbFqM/0I/Pfpe4+8UjbnvvA/EczE80GRm4XuvUW3vH5asoHaw8rSh7Fn7eHn8iabWeeaVffbhFm8fCG+dXw9vXaRT9DWwenABAF60pEzay8rStBijOED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152404; c=relaxed/simple;
	bh=ha5mOTr/dXVQ8DitXwChxWyBRHha6h4D45mwnoRyFKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDcFNI0MGcW/Dnd3s5jW82hGoggUkQu0kZuBbcxUGnL/4XXM8EcXXyUxL9wkmzoPupLWX5rVVUsvVJP6usR+lZVj1bPify7TZtgb/e/aHbmzLAldiLWCO94UuY8dN7tMFGqtvowAoM0P25EzBB3jVkrsDO/VC6B1W4YwL0EYEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYPxJfIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD0C4AF0B;
	Fri, 23 Jan 2026 07:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769152403;
	bh=ha5mOTr/dXVQ8DitXwChxWyBRHha6h4D45mwnoRyFKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYPxJfIEmOXnCtnRPoi7EPtGgrLO38cpNobwy+HgGMsVe+SoZxCHqss9MiPFXcyno
	 nxwQ8jQyzzJSi+TIZ9SQ8yidCW7948iH3e9jJlnAIe1wD5SQTQT2F7mLJtmbp088hP
	 xhdg04OyB2hiKPIzMNzwkLOxEwuqG07vuwQQEt/wvuAzUMQHapHLMm4jxPjWvscMiw
	 rbsNK5A9s0Ns9mApSo0YAYDflr4M2EFbUP47nDw5wyZkSxA25Vyff2aamgS5iGIpin
	 s0FWvXTAwf4+cTdCfpf11jDBO5rbi2PndHtGUTK6pBMk2mqlhficK2ulm5bUMX91II
	 fYL+chuHWr03Q==
Date: Thu, 22 Jan 2026 23:13:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/15] block: factor out a bio_integrity_action helper
Message-ID: <20260123071323.GU5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-2-hch@lst.de>
 <20260123000113.GF5945@frogsfrogsfrogs>
 <20260123060324.GA25239@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123060324.GA25239@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75223-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A9117198D
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 07:03:24AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 04:01:13PM -0800, Darrick J. Wong wrote:
> > >  /**
> > >   * bio_integrity_prep - Prepare bio for integrity I/O
> > >   * @bio:	bio to prepare
> > > + * @action:	preparation action needed
> > 
> > What is @action?
> 
> Yes.
> 
> > Is it a bitset of BI_ACT_* values?  If yes, then can
> > the comment please say that explicitly?
> 
> Is this good enough?
> 
>  * @action:     preparation action needed (BI_ACT_*)

Yes.

> > > +static bool bi_offload_capable(struct blk_integrity *bi)
> > > +{
> > > +	return bi->metadata_size == bi->pi_tuple_size;
> > > +}
> > 
> > Just out of curiosity, what happens if metadata_size > pi_tuple_size?
> 
> Then we still have to provide a buffer as the automatic insert/strip
> doesn't work. (I find the offload name rather confusing for this)
> 
> > Can it be the case that metadata_size < pi_tuple_size?
> 
> No.  See blk_validate_integrity_limits:
> 
> 	if (bi->pi_offset + bi->pi_tuple_size > bi->metadata_size) {
> 		pr_warn("pi_offset (%u) + pi_tuple_size (%u) exceeds metadata_size (%u)\n",
> 			bi->pi_offset, bi->pi_tuple_size,
> 			bi->metadata_size);
> 		return -EINVAL;
> 	}
> 
> 
> > 
> > > +unsigned int __bio_integrity_action(struct bio *bio)
> > 
> > Hrm, this function returns a bitset of BI_ACT_* flags, doesn't it?
> > 
> > Would be kinda nice if a comment could say that.
> 
> Is this ok?
> 
> /**
>  * bio_integrity_action - return the integrity action needed for a bio
>  * @bio:        bio to operate on
>  *
>  * Returns the mask of integrity actions (BI_ACT_*) that need to be performed
>  * for @bio.
>  */

Excellent!

> 
> > > +		/*
> > > +		 * Zero the memory allocated to not leak uninitialized kernel
> > > +		 * memory to disk for non-integrity metadata where nothing else
> > > +		 * initializes the memory.
> > 
> > Er... does someone initialize it eventually?  Such as the filesystem?
> > Or maybe an io_uring caller?
> 
> For integrity metadata?  The code called later fills it out.  But it
> doesn't fill non-integrity metadata, so we need to zero it.

Ahhh, right, the app tag or whatever?

> > > +		 */
> > > +		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
> > > +			if (bi_offload_capable(bi))
> > > +				return 0;
> > > +			return BI_ACT_BUFFER | BI_ACT_ZERO;
> > > +		}
> > > +
> > > +		if (bi->metadata_size > bi->pi_tuple_size)
> > > +			return BI_ACT_BUFFER | BI_ACT_CHECK | BI_ACT_ZERO;
> > > +		return BI_ACT_BUFFER | BI_ACT_CHECK;
> > 
> > "check" feels like a weird name for a write, where we're generating the
> > PI information.  It really means "block layer takes care of PI
> > generation and validation", right?  As opposed to whichever upper layer
> > is using the block device?
> > 
> > BI_ACT_YOUDOIT <snerk>
> > 
> > How about BI_ACT_BDEV /* block layer checks/validates PI */
> 
> I think BI_ACT_BDEV is not very useful.  Check is supposed to
> include generate and verify, but I'm not sure how we could word this
> in a nice way.

Me neither.  If nobody else here comes up with a better suggestion then
I guess BI_ACT_CHECK + its comment wins.

--D

