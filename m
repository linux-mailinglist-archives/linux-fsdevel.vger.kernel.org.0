Return-Path: <linux-fsdevel+bounces-43851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281DBA5E84A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 00:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC983AAD49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 23:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38431F180E;
	Wed, 12 Mar 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngsOwFCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE51F1515;
	Wed, 12 Mar 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741821731; cv=none; b=Qui1IhfpANCdTu0xIeOx6wFj410GIajP756bDZnR9kxuSv92I1jI5JfkUMWz8nfcfPBTokAJwOT2fX7GGj/RMDfcnFugm2h0pp6bsLNBuIHkM9up/p2nrI4OkBfoF4QYTZa+tVbRzHTdkXUAvzaeui05KGjIQhUM85FlQ2uzXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741821731; c=relaxed/simple;
	bh=EMf9sg4/j4jBcXvtW6xBhGZjpQXXIzxJRQwIhVs1+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k75UckC39A56jMWRrtdMhQLNK+kmK0TX9u7Zu8ZhnzfHcPHMt6gpzO2u6HzaLhsYJXLr5H+dNtVtGOk9a1fZeU58UdDdVeEZ5aPGryRAkItkI6jVJDD2bbcCpXwkaK+VBp4eVrqUnYJea4VBnaL/n28SsXv91V5rzDkMsGgRto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngsOwFCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1324C4CEDD;
	Wed, 12 Mar 2025 23:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741821731;
	bh=EMf9sg4/j4jBcXvtW6xBhGZjpQXXIzxJRQwIhVs1+EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngsOwFCe0FGH3KUSoKGDGqwb2IG1oRBThYTZLnQqe8/5ra+J5IcYTVdS+min3bRtV
	 YH8qhQPJRe+Ql9is5SVX2y0EG4x250mMvr34d1s4CRnHtpgnGSz4DgMfIapnNXWlRd
	 OuByWsII+rzDYotcH0ltsYtTHJvviJ4+8IVdwiXLJnMYVn2mgvXuw+9wn4thtG24IF
	 9+cV/J+c3x5Xh/d9zl2j13nT6A4dN0FmXy8/ceOtp6gIsADsVS1t+ZddajltnNGLg3
	 HYBpE+7nfSR42t6pSi3mywy5DzFwpl02cLtZT32L19df/GZUlx16u5kQXPkuGpiRiJ
	 UPyW6e2HmLElQ==
Date: Wed, 12 Mar 2025 16:22:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250312232210.GD2803730@frogsfrogsfrogs>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
 <20250312154636.GX2803749@frogsfrogsfrogs>
 <62f035a9-05e7-40fc-ae05-3d21255d89f4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f035a9-05e7-40fc-ae05-3d21255d89f4@oracle.com>

On Wed, Mar 12, 2025 at 10:06:11PM +0000, John Garry wrote:
> On 12/03/2025 15:46, Darrick J. Wong wrote:
> > On Wed, Mar 12, 2025 at 01:35:23AM -0700, Christoph Hellwig wrote:
> > > On Wed, Mar 12, 2025 at 08:27:05AM +0000, John Garry wrote:
> > > > On 12/03/2025 07:24, Christoph Hellwig wrote:
> > > > > On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> > > > > > Refactor xfs_reflink_end_cow_extent() into separate parts which process
> > > > > > the CoW range and commit the transaction.
> > > > > > 
> > > > > > This refactoring will be used in future for when it is required to commit
> > > > > > a range of extents as a single transaction, similar to how it was done
> > > > > > pre-commit d6f215f359637.
> > > > > 
> > > > > Darrick pointed out that if you do more than just a tiny number
> > > > > of extents per transactions you run out of log reservations very
> > > > > quickly here:
> > > > > 
> > > > > https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> > > > > 
> > > > > how does your scheme deal with that?
> > > > > 
> > > > The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
> > > > right? Or does the log reservation have a hard size limit, regardless of
> > > > that calculation?
> > > 
> > > The resblks calculated there are the reserved disk blocks and have
> > > nothing to do with the log reservations, which comes from the
> > > tr_write field passed in.  There is some kind of upper limited to it
> > > obviously by the log size, although I'm not sure if we've formalized
> > > that somewhere.  Dave might be the right person to ask about that.
> > 
> > The (very very rough) upper limit for how many intent items you can
> > attach to a tr_write transaction is:
> > 
> > per_extent_cost = (cui_size + rui_size + bui_size + efi_size + ili_size)
> > max_blocks = tr_write::tr_logres / per_extent_cost
> > 
> > (ili_size is the inode log item size)
> 
> So will it be something like this:
> 
> static size_t
> xfs_compute_awu_max_extents(
> 	struct xfs_mount	*mp)
> {
> 	struct xfs_trans_res	*resp = &M_RES(mp)->tr_write;
> 	size_t			logtotal = xfs_bui_log_format_sizeof(1)+

Might want to call it "per_extent_logres" since that's what it is.

> 				xfs_cui_log_format_sizeof(1) +
> 				xfs_efi_log_format_sizeof(1) +
> 				xfs_rui_log_format_sizeof(1) +
> 				sizeof(struct xfs_inode_log_format);

Something like that, yeah.  You should probably add
xfs_log_dinode_size(ip->i_mount) to that.

What you're really doing is summing the *nbytes output of the
->iop_size() call for each possible log item.  For the four log intent
items it's the xfs_FOO_log_format_sizeof() function like you have above.
For inode items it's:

	*nbytes += sizeof(struct xfs_inode_log_format) +
		   xfs_log_dinode_size(ip->i_mount);

> 	return rounddown_pow_of_two(resp->tr_logres / logtotal);

and like I said earlier, you should double logtotal to be on the safe
side with a 2x safety margin:

	/* 100% safety margin for safety's sake */
	return rounddown_pow_of_two(resp->tr_logres /
				    (2 * per_extent_logres));

I'm curious what number you get back from this function?  Hopefully it's
at least a few hundred blocks.

Thanks for putting that together.  :)

--D

> }
> 
> static inline void
> xfs_compute_awu_max(
> 	struct xfs_mount	*mp, int jjcount)
> {
> ....
> 	mp->m_awu_max =
> 	min_t(unsigned int, awu_max, xfs_compute_awu_max_extents(mp));
> }
> 
> > 
> > ((I would halve that for the sake of paranoia))
> > 
> > since you have to commit all those intent items into the first
> > transaction in the chain.  The difficulty we've always had is computing
> > the size of an intent item in the ondisk log, since that's a (somewhat
> > minor) layering violation -- it's xfs_cui_log_format_sizeof() for a CUI,
> > but then there' could be overhead for the ondisk log headers themselves.
> > 
> > Maybe we ought to formalize the computation of that since reap.c also
> > has a handwavy XREAP_MAX_DEFER_CHAIN that it uses to roll the scrub
> > transaction periodically... because I'd prefer we not add another
> > hardcoded limit.  My guess is that the software fallback can probably
> > support any awu_max that a hardware wants to throw at us, but let's
> > actually figure out the min(sw, hw) that we can support and cap it at
> > that.
> > 
> > --D
> 
> 

