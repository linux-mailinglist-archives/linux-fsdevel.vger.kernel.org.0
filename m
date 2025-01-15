Return-Path: <linux-fsdevel+bounces-39214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592B6A11624
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5C4188B49B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B55182D2;
	Wed, 15 Jan 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wj1Tyfti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4A3C00
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901519; cv=none; b=EofU2IkPJAVcAPswrlgBpda+x3/4avUkuAKUEXSBs+4wm+6ceWPUCSirMjd+BOaB+mSm9JBAH2fUC73uBjzvWF18RIzDdUNnYXcNw3oamMGNfW9fnpbtIE+tEPpVRGjD9dvuOTtcyBrZ2hnxdXXE5/Uy8XhrZTT3CgN2JzERO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901519; c=relaxed/simple;
	bh=BYKIAOIueHsgVnGGTgzCWgH+7Qr++PCJqi+urNjrCJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adUoofezwshF791o4jq58QZ57+Z7xLWam9qlIXpPz0basGV1wJ83RK3V3OC9KlpqcVpFFx+HijHJD53VhUMZvlPqXwF43I1qtg0tAHTaN8vL6q0U58WDl9QGiF6XZMbXwQ+UZ1try1X4U5+zHziojEH8r8cqqhIaV+cEeoESyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wj1Tyfti; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 19:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736901500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sdTDazijDxrKaK+XRs8BNNBoItwgzQWBrEYa1CO0yhg=;
	b=wj1TyftiCxr4s0lcvyPX/NMV6+ORDpuwgKg2ecs9u198HACd3YLeB4VZEGqm2iodfRhMmP
	xc5TdP2c6F01AfcfHK6UfaVpretdKqxfveizp7IpSpTG7KpW+yRgKC4M5C6yGUOS8PZCSk
	NDZgkmTCF4Emr8BB6ZNqIpHaQonLHI8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>, 
	Jan Kara <jack@suse.cz>, Kun Hu <huk23@m.fudan.edu.cn>, jlayton@redhat.com, 
	adilger.kernel@dilger.ca, bfields@redhat.com, viro@zeniv.linux.org.uk, 
	christian.brauner@ubuntu.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brauner@kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <7uapo2ctewj3dmtja6p3bvb2tzidpb6smkq7ux4kcpylnclyei@tbkzzor4e46e>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
 <20250114135751.GB1997324@mit.edu>
 <Z4bVQEKdj4ouAGI4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4bVQEKdj4ouAGI4@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 15, 2025 at 08:21:04AM +1100, Dave Chinner wrote:
> On Tue, Jan 14, 2025 at 08:57:51AM -0500, Theodore Ts'o wrote:
> > P.S.  If you want to push back on this nonsense, Usenix program
> > committee chairs are very much looking for open source professionals
> > to participate on the program committees for Usenix ATC (Annual
> > Technical Conference) and FAST (File System and Storage Technologies)
> > conference.
> 
> The problem is that the Usenix/FAST paper committees will not reach
> out to OSS subject matter experts to review papers that they have
> been asked to review for the conference.
> 
> Let me give you a recent example of a clear failure of the FAST
> paper committee w.r.t. plagarism.
> 
> The core of this paper from FAST 2022:
> 
> https://www.usenix.org/conference/fast22/presentation/kim-dohyun
> 
> "ScaleXFS: Getting scalability of XFS back on the ring"
> 
> is based on the per-CPU CIL logging work I prototyped and posted an
> RFC for early in 2021:
> 
> https://lore.kernel.org/linux-xfs/20200512092811.1846252-1-david@fromorbit.com/
> 
> The main core of the improvements described in the ScaleXFS paper
> are the exact per-cpu CIL algorithm in that was contained in the
> above RFC patchset.
> 
> That algorithm had serious problems that meant it was unworkable in
> practice - these didn't show up until journal recovery was tested
> and it resulted in random filesystem corruptions. I didn't
> understand the root cause of the problem until months later.
> 
> These problems were all based on failures to correctly order the
> per-CPU log items in the journal due to the per-CPU CIL being
> inherently racy.  The algorithm I proposed 6 months later (and
> eventually got merged in July 2022) had significant changes to the
> way the per-CPU CIL ordered operations to address these problems.
> 
> IOWs, object ordering on the CIL is the single most important
> critical correctness citeria for the entire journalling algorithm
> and hence a fundamental algorithmic constraint for the per-CPU CIL
> implementation.
> 
> However, the ScaleXFS paper does not make any mention of this
> fundamental algorithmic constraint - I did not publish anything
> about this constraint until the November 2022 patch set....
> 
> There were more clear tell-tales in the paper that indicate
> that the "research" was based on that early per-CPU CIL RFC I
> posted, but I won't go into details.
> 
> I brought this to the FAST committee almost immediately after I was
> able to review the paper (a couple of days after the FAST conference
> itself). I provided them with all the links to public postings of
> the algorithm, detailed analysis of the paper and publicly posted
> code, etc. In response, they basically did nothing and brushed my
> concerns off. It would take weeks to get any response from the paper
> committee, and the overall response really felt like the Usenix
> people simply didn't care at all about what was obviously plagarised
> work.
> 
> IOWs, the Usenix/FAST peer review process for OSS related papers is
> broken, and they don't seem to care when experts from the OSS
> community actually bring clear cases of academic malpractice to
> them...

Yeah, that does look like misconduct, of the type that merits a
boycott...

