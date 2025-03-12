Return-Path: <linux-fsdevel+bounces-43814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB8A5E0E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB81188CE00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44952257AF7;
	Wed, 12 Mar 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxuBq5Mw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2FC2566D5;
	Wed, 12 Mar 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794397; cv=none; b=dtACf7flFSsqMdMJQnxJn8vEhNzHfaapdq71P47lI0O/H4XqIa5Q4NASY67nj5UlIDMZyah7Ft93MH7IbOmxLI52CVxd1ERclDhmnuGA1R+zF9Q7RhFzbwaaUa0iiH6MVUrNguvuRaR5atU3lrz0bGtLPHZAePrSBoa0srT5cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794397; c=relaxed/simple;
	bh=Fwf5W2U8w03U4Cm1Q9TRhlF1mB+8QZtqhPORia13bpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+5Vz4/9lSXdEhuMAFZwV2+1QENt8Z19mtlRxmQanbUnQp1b6fQORBK+xjyRIankGu/8/vK1RyuuR0YvbLBLKspa3yj4yQi/H3DygKkPsmZK6rx7a+pF2CeQt1NuAHxcUbqlxirgfrkKeA1adEoBf2VnjKyvKGo68333l5DcBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxuBq5Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0007C4CEDD;
	Wed, 12 Mar 2025 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741794396;
	bh=Fwf5W2U8w03U4Cm1Q9TRhlF1mB+8QZtqhPORia13bpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxuBq5MwgQwST6RdrnWyUAmwz5lHtmDzC2vQxgflKGkq0Vg5CAk18DGFu524u5lKR
	 eJo/hk8NOkoAolsmngrDsge8xUfB8lMWXCqFBhTJpBJ2Zt1TThyhdSpTP3e5QoOgeS
	 xzzWexNw18OamfgTTmwIvpS0pxfRdzv7EtQKNlBZH29YhaE2G15v2B7rrE1f6UhFyY
	 uYXblI34utGwQpw0LJIqGtx+qTXJ/gG8Avvb5GB9cZVSmoJsrfIOnsqoAlnF0cuNR0
	 DOnqfxSQgnCS5XrsFB+6mjaZJXDyXdhK/iYbDQeunNjTwtlN0LZOXl02fS+bpLenu9
	 xNF94/PuNsUhg==
Date: Wed, 12 Mar 2025 08:46:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250312154636.GX2803749@frogsfrogsfrogs>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9FHSyZ7miJL7ZQM@infradead.org>

On Wed, Mar 12, 2025 at 01:35:23AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 12, 2025 at 08:27:05AM +0000, John Garry wrote:
> > On 12/03/2025 07:24, Christoph Hellwig wrote:
> > > On Mon, Mar 10, 2025 at 06:39:39PM +0000, John Garry wrote:
> > > > Refactor xfs_reflink_end_cow_extent() into separate parts which process
> > > > the CoW range and commit the transaction.
> > > > 
> > > > This refactoring will be used in future for when it is required to commit
> > > > a range of extents as a single transaction, similar to how it was done
> > > > pre-commit d6f215f359637.
> > > 
> > > Darrick pointed out that if you do more than just a tiny number
> > > of extents per transactions you run out of log reservations very
> > > quickly here:
> > > 
> > > https://urldefense.com/v3/__https://lore.kernel.org/all/20240329162936.GI6390@frogsfrogsfrogs/__;!!ACWV5N9M2RV99hQ!PWLcBof1tKimKUObvCj4vOhljWjFmjtzVHLx9apcU5Rah1xZnmp_3PIq6eSwx6TdEXzMLYYyBfmZLgvj$
> > > 
> > > how does your scheme deal with that?
> > > 
> > The resblks calculation in xfs_reflink_end_atomic_cow() takes care of this,
> > right? Or does the log reservation have a hard size limit, regardless of
> > that calculation?
> 
> The resblks calculated there are the reserved disk blocks and have
> nothing to do with the log reservations, which comes from the
> tr_write field passed in.  There is some kind of upper limited to it
> obviously by the log size, although I'm not sure if we've formalized
> that somewhere.  Dave might be the right person to ask about that.

The (very very rough) upper limit for how many intent items you can
attach to a tr_write transaction is:

per_extent_cost = (cui_size + rui_size + bui_size + efi_size + ili_size)
max_blocks = tr_write::tr_logres / per_extent_cost

(ili_size is the inode log item size)

((I would halve that for the sake of paranoia))

since you have to commit all those intent items into the first
transaction in the chain.  The difficulty we've always had is computing
the size of an intent item in the ondisk log, since that's a (somewhat
minor) layering violation -- it's xfs_cui_log_format_sizeof() for a CUI,
but then there' could be overhead for the ondisk log headers themselves.

Maybe we ought to formalize the computation of that since reap.c also
has a handwavy XREAP_MAX_DEFER_CHAIN that it uses to roll the scrub
transaction periodically... because I'd prefer we not add another
hardcoded limit.  My guess is that the software fallback can probably
support any awu_max that a hardware wants to throw at us, but let's
actually figure out the min(sw, hw) that we can support and cap it at
that.

--D

