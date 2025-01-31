Return-Path: <linux-fsdevel+bounces-40464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1EDA238EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 03:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B6C1889A6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 02:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7E49659;
	Fri, 31 Jan 2025 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lKUXxKpr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DB24B34
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738289884; cv=none; b=awNRu84V0FtyOSrorkABicyDMxhvLs6QLAgHi5v5tv+j0o8stHU0pFJxsKcdow+Xabatk760DHnbtw3ck9Yn4SBB/OWAJ6qPme1moNhtFuK1+ZUsVKA/+QGzG8obhOVd5+E8AxexxXF2ySe6JKLzhslQSxjbJLJWdHeiR4c8kCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738289884; c=relaxed/simple;
	bh=jjTlMo5fZQ7s/M4sNG4FSixQ5LAjd0pPtceOndDhKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJum/WgA+tj9JbGHk89UA9D87dZT/lTCK//x+mqJDlrqBfVKlROqcWHLnij9SJLsuIZwJv3izxdYeDeYsEkTO5uTTaZ9jJHE49ixwoquUFEltXtxbusznxJtJl3boQz6KxXOP/cA12me52P6cobslr37R7PiXx1LDFAN1m8B974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lKUXxKpr; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 21:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738289864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86DtWWfMiCYOtCGwpJiHkZXRwWqUSDdPye/EVpqVEiA=;
	b=lKUXxKprEt+NzvnJltInYDkdScOo+5iR98GJ4kiBPvWb48cX27o4QWWmRw1G74LnMmCQ2l
	j4tZgWdD5sjnL2kno1pSecWZ5s2GbBt0ZbeJL/9mPzprGTAoc1vesLoFfRmlkDYJCBj82u
	TAw1FN74RFwt1mzNk7PPOOkrJn7cc1U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev, miklos@szeredi.hu, 
	linux-bcachefs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <jfpaip63egujwahtp7vi7hbtgun44orbauzt5j55yjmoo2jnvv@hfop6nlpsco7>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
 <t7rjw6a462k5sm2tdviyd7sq6n44uxb3haai566m4hm7dvvlpi@btt3blanouck>
 <562e4bdc-d0f3-4a4d-8443-174c716daaa0@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562e4bdc-d0f3-4a4d-8443-174c716daaa0@intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 05:34:18PM -0800, Dave Hansen wrote:
> On 1/30/25 16:56, Kent Overstreet wrote:
> > On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:...
> >> Any suggestions for fully describing the situation? I tried to sprinkle
> >> comments liberally but I'm also painfully aware that I'm not doing a
> >> perfect job of talking about the fs code.
> > 
> > The critical thing to cover is the fact that mmap means that page faults
> > can recurse into arbitrary filesystem code, thus blowing a hole in all
> > our carefully crafted lock ordering if we allow that while holding
> > locks - you didn't mention that at all.
> 
> What I've got today is this:
> 
>               /*
>                * This needs to be atomic because actually handling page
>                * faults on 'i' can deadlock if the copy targets a
>                * userspace mapping of 'folio'.
>                */
> 	      copied = copy_folio_from_iter_atomic(...);
> 
> Are you saying you'd prefer that this be something more like:
> 
> 		/*
> 		 * Faults here on mmap()s can recurse into arbitrary
> 		 * filesystem code. Lots of locks are held that can
> 		 * deadlock. Use an atomic copy to avoid deadlocking
> 		 * in page fault handling.
> 		 */
> 
> ?

Yeah I like that better, but I would also include the bit about "redoing
the fault when locks are dropped" in the same comment, you want the
whole idea described in one place.

> >>> I do agree on moving it to the slowpath - I think we can expect the case
> >>> where the process's immediate workingset is faulted out while it's
> >>> running to be vanishingly small.
> >>
> >> Great! I'm glad we're on the same page there.
> >>
> >> For bcachefs specifically, how should we move forward? If you're happy
> >> with the concept, would you prefer that I do some manual bcachefs
> >> testing? Or leave a branch sitting there for a week and pray the robots
> >> test it?
> > 
> > No to the sit and pray. If I see one more "testing? that's something
> > other people do" conversation I'll blow another gasket.
> > 
> > xfstests supports bcachefs, and if you need a really easy way to run it
> > locally on all the various filesystems, I have a solution for that:
> > 
> > https://evilpiepirate.org/git/ktest.git/
> > 
> > If you want access to my CI that runs all that in parallel across 120
> > VMs with the nice dashboard - shoot me an email and I'll outline server
> > costs and we can work something out.
> 
> That _sounds_ a bit heavyweight to me for this patch:
> 
>  b/fs/bcachefs/fs-io-buffered.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> Is that the the kind of testing (120 VMs) that is needed to get a patch
> into bcachefs?

No - that's what CI access gets you, and it's not just for bcachefs
testing; it could have tested this series on every filesystem in
parallel for you.

> Or are you saying that running xfstests on bcachefs with this patch
> applied would be sufficient?

Correct.

> On the x86 side, I'm usually pretty happy to know that someone has
> compiled a patch and at least executed the code at runtime a time or
> two. So this process is a bit unfamiliar to me.

To me, as a filesystem guy, that sounds terrifying :)

I'm a hardass, even among filesystem people, but this really isn't just
about making my life easier, it's about getting us _all_ better tools.
If we can consolidate on a single testrunner for VM tests that people at
least don't hate, then life would get drastically easier for all sorts
of things, including cross subsystem work.

And pretty much exists now, but the younger guys (and engineers in
China) have been a lot quicker to start using it than people who are
used to "the way things have always been"...

