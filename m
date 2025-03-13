Return-Path: <linux-fsdevel+bounces-43861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA58A5EAD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 05:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2564618990A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D721F8EF7;
	Thu, 13 Mar 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjhDgtxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917C1F4C82;
	Thu, 13 Mar 2025 04:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841484; cv=none; b=cjj2x4+SWnNpJGfiWCsnnJDUuOT0Lx+bqtNmRxeLDEnESoxh0+A7cIqE6UHRuKAd5zyzvjBWsFHdN00W+rRvPp20AQ8s4k13vCLg1zBGWbY3PDC1ohQmMQ6Qb1hEoL0rkftH252qcVZMaTjG+CrwXb0OVONrcmBvb4gFdbyKbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841484; c=relaxed/simple;
	bh=g94ckHt4QIvCGFSc/IwsUr93C1kmGO+oudRBAJEWurA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5F2atmLZTQOJ0XYgQB5IAlO8+/n2ptjUiha+pvCzZ3ECmYrbXfwVLXYwNnLWpw/nd96cvvgi0uPOjD6W3UeOZvEN2luWwHn4Id0082KLz0GaTfd36OaPsovr4r/THFlL98dwnhLyhW/zoz6rT4w8AzqnvHGIHA7sa9VDV84cNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjhDgtxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8285DC4CEDD;
	Thu, 13 Mar 2025 04:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741841483;
	bh=g94ckHt4QIvCGFSc/IwsUr93C1kmGO+oudRBAJEWurA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjhDgtxWipr6dqxjtmPjWoTJM7Q3n5irmX0rRs/d/58Q8H2MaZerTR8/LI7rG2ZnE
	 pdwsBol/t3r7u9I4jg65Gr7fKDCF5tblUPxehbYJoP5ooIfQURtIfCiMIV2tyfYPB9
	 8kcglrPA9hXy+qe7pW3TrWNcBN3hZrLxxIdu2e8b9glW+TUFsArAVc1EnSKWC5GEMJ
	 6uAyXdWYAKGoY1T9scZ5TWg5/uEsFTiQn6cCJmr9YtbzG8/wBupkJssxd1ffq/D/ft
	 KIpWYQ13fPufpMnTxx6cHMRG5w/KiRV2RXEdh/Lj1iejevF1wYgzKBaJciBOKP4H+g
	 fRvyMqxxTkwxA==
Date: Wed, 12 Mar 2025 21:51:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>, brauner@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v5 03/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250313045121.GE2803730@frogsfrogsfrogs>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-4-john.g.garry@oracle.com>
 <Z9E2kSQs-wL2a074@infradead.org>
 <589f2ce0-2fd8-47f6-bbd3-28705e306b68@oracle.com>
 <Z9FHSyZ7miJL7ZQM@infradead.org>
 <20250312154636.GX2803749@frogsfrogsfrogs>
 <Z9I0Ab5TyBEdkC32@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9I0Ab5TyBEdkC32@dread.disaster.area>

On Thu, Mar 13, 2025 at 12:25:21PM +1100, Dave Chinner wrote:
> On Wed, Mar 12, 2025 at 08:46:36AM -0700, Darrick J. Wong wrote:
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
> > > The resblks calculated there are the reserved disk blocks
> 
> Used for btree block allocations that might be needed during the
> processing of the transaction.
> 
> > > and have
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
> That doesn't sound right. The number of intents we can log is not
> dependent on the aggregated size of all intent types. We do not log
> all those intent types in a single transaction, nor do we process
> more than one type of intent in a given transaction. Also, we only
> log the inode once per transaction, so that is not a per-extent
> overhead.
> 
> Realistically, the tr_write transaction is goign to be at least a
> 100kB because it has to be big enough to log full splits of multiple
> btrees (e.g. BMBT + both free space trees). Yeah, a small 4kB
> filesystem spits out:
> 
> xfs_trans_resv_calc:  dev 7:0 type 0 logres 193528 logcount 5 flags 0x4
> 
> About 190kB.
> 
> However, intents are typically very small - around 32 bytes in size
> plus another 12 bytes for the log region ophdr.
> 
> This implies that we can fit thousands of individual intents in a
> single tr_write log reservation on any given filesystem, and the
> number of loop iterations in a transaction is therefore dependent
> largely on how many intents are logged per iteration.
> 
> Hence if we are walking a range of extents in the BMBT to unmap
> them, then we should only be generating 2 intents per loop - a BUI
> for the BMBT removal and a CUI for the shared refcount decrease.
> That means we should be able to run at least a thousand iterations
> of that loop per transaction without getting anywhere near the
> transaction reservation limits.
> 
> *However!*
> 
> We have to relog every intent we haven't processed in the deferred
> batch every-so-often to prevent the outstanding intents from pinning
> the tail of the log. Hence the larger the number of intents in the
> initial batch, the more work we have to do later on (and the more
> overall log space and bandwidth they will consume) to relog them
> them over and over again until they pop to the head of the
> processing queue.
> 
> Hence there is no real perforamce advantage to creating massive intent
> batches because we end up doing more work later on to relog those
> intents to prevent journal space deadlocks. It also doesn't speed up
> processing, because we still process the intent chains one at a time
> from start to completion before moving on to the next high level
> intent chain that needs to be processed.
> 
> Further, after the first couple of intent chains have been
> processed, the initial log space reservation will have run out, and
> we are now asking for a new resrevation on every transaction roll we
> do. i.e. we now are now doing a log space reservation on every
> transaction roll in the processing chain instead of only doing it
> once per high level intent chain.
> 
> Hence from a log space accounting perspective (the hottest code path
> in the journal), it is far more efficient to perform a single high
> level transaction per extent unmap operation than it is to batch
> intents into a single high level transaction.
> 
> My advice is this: we should never batch high level iterative
> intent-based operations into a single transaction because it's a
> false optimisation.  It might look like it is an efficiency
> improvement from the high level, but it ends up hammering the hot,
> performance critical paths in the transaction subsystem much, much
> harder and so will end up being slower than the single transaction
> per intent-based operation algorithm when it matters most....

How specifically do you propose remapping all the extents in a file
range after an untorn write?  The regular cow ioend does a single
transaction per extent across the entire ioend range and cannot deliver
untorn writes.  This latest proposal does, but now you've torn that idea
down too.

At this point I have run out of ideas and conclude that can only submit
to your superior intellect.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

