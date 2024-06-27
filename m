Return-Path: <linux-fsdevel+bounces-22678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618FA91AFD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D997A1F225F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682AF19D088;
	Thu, 27 Jun 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHE8SNVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72E719D06D;
	Thu, 27 Jun 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517604; cv=none; b=tSfwBPBQ3HFJmxbozXT2PrdloUoGRzZZIPyerE6Fsq5l2jCE+vpVxWYq3PDgkb4FOsuXj+qJ6CXskiVOae77Wra4TqgOPAth1DxzUjxkEPdYQBWjGrZHdyaCgql5cTyyB4r3plvYByVY5hKdKUjbbilbY5NOJjGAZZxb8f4PKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517604; c=relaxed/simple;
	bh=IfSpmibmopaiEUnoS5Sj1W0By6K3R/JpHzodLmPYEk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etapb7jhr4CN/waqLObtjK2y1sXL28WDfKmKYigVn0CH4osF8c5Koq9h1mbNzcH02IlJz3jdgidhiFNgUT13nr3k/LYTaaCaLDUYcNsyP3ddePER34vK4vYBVEhBwmG5MAisBo1G2u5vRr+qA9QxPy6qB7IemVzMw7I7YUPMFh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHE8SNVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46939C2BBFC;
	Thu, 27 Jun 2024 19:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719517604;
	bh=IfSpmibmopaiEUnoS5Sj1W0By6K3R/JpHzodLmPYEk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHE8SNVFwNlZ407ZHXT9e3Im2lLVpRzsiEnU3MOqwdtEA+DtbS832M2iVxCgWtqEG
	 bTE4nRyJjyaIz+mD2pRjWPnjYrITHDbeZGsJumRxEtAhczW3atejlwUPLacmMy2rhl
	 BGeqGJ7c9GiNkx606wRbnGOTZL0cH42vZ3A0GVWsDg/kdieefLBdZudd5xYUuCF3VZ
	 d2ktNgCStqYUzBiWFRpVYq73jof7qZz4/OaTvHdFF7ZbJAumg4nKUNv7HJIoyrdu4X
	 2/Qr9sI4MOvljIuvmHJKfFb0WFmkDTW0eMdBcd3gYe9reXBN4von9LmKACSwlZLKjK
	 Vfs9OA/4Ya8nQ==
Date: Thu, 27 Jun 2024 12:46:43 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <202406271240.80ED0EF358@keescook>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
 <202406270957.C0E5E8057@keescook>
 <5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4>
 <f005a7b0-ca31-4d39-b2d5-00f5546d610a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f005a7b0-ca31-4d39-b2d5-00f5546d610a@lucifer.local>

On Thu, Jun 27, 2024 at 08:31:07PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jun 27, 2024 at 02:25:36PM -0400, Liam R. Howlett wrote:
> > * Kees Cook <kees@kernel.org> [240627 12:58]:
> > > On Thu, Jun 27, 2024 at 11:39:32AM +0100, Lorenzo Stoakes wrote:
> > > > Establish a new userland VMA unit testing implementation under
> > > > tools/testing which utilises existing logic providing maple tree support in
> > > > userland utilising the now-shared code previously exclusive to radix tree
> > > > testing.
> > > >
> > > > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > > > while stubbing out superfluous functionality.
> > > >
> > > > This exists as a proof-of-concept, with the test implementation functional
> > > > and sufficient to allow userland compilation of vma.c, but containing only
> > > > cursory tests to demonstrate basic functionality.
> > >
> > > Interesting! Why do you want to have this in userspace instead of just
> > > wiring up what you have here to KUnit so testing can be performed by
> > > existing CI systems that are running all the KUnit tests?
> >
> > The primary reason we did the maple tree testing in userspace was for
> > speed of testing.  We don't need to build the kernel, but a subset of
> > APIs.  Debugging problems is also much quicker since we can instrument
> > and rebuild, iterate down faster.  Tracing every call to the maple tree
> > on boot alone is massive.
> >
> > It is also difficult to verify the vma correctness without exposing APIs
> > we don't want exported (or, I guess, parse proc files..).  On my side, I
> > have a module for testing the overall interface while I have more tests
> > on the userspace side that poke and prod on internal states, and
> > userspace rcu testing is possible.  I expect the same issues on the vma
> > side.
> >
> > Adding tests can also be made very efficient with tracepoints dumping
> > something to add to an array, for example.
> >
> > Finally, you have ultimate control on what other functions return (or
> > do) - so you can fail allocations to test error paths, for example.  Or
> > set the external function to fail after N allocations.  This comes in
> > handy when a syzbot reports a failed allocation at line X caused a
> > crash.
> >
> > This has worked out phenomenally on the maple tree side.  I've been able
> > to record boot failures and import them, syzbot tests, and fuzzer tests.
> > The result is a huge list of tests that allowed me to rewrite my node
> > replacement algorithm and have it just work, once it passed the
> > collected tests.
> >
> > I haven't used kunit as much as I have userspace testing, so I cannot
> > say if all of these points are not possible, but I didn't see a way to
> > test races like I do with rcu in userspace.
> >
> > Thanks,
> > Liam
> 
> Liam's response is excellent, and obviously I agree
> wholeheartedly. Additionally, I'm not really experienced with kunit, but
> surely it's implemented as a kernel module somehow? If so, these interfaces
> are largely not exported so it wouldn't be functional as a unit test.

(KUnit has a method for doing optional exports.)

> And also as Liam says, it'd be very difficult to test this stuff _in_ the
> kernel without unwanted side-effects triggering and it'd be very difficult
> to isolate or mock components we don't want to play a role (for instance -
> rlimits that we might not be able to control).

Yeah, this all makes good sense. Thanks for the details! I've been
looking at ways to test signals and task tree helpers[1] and avoiding
side-effects in the kernel has been quite difficult. I might have to study
your approach here and see if the same could be done for my cases. :)

-Kees

[1] https://lore.kernel.org/lkml/20230814210508.never.871-kees@kernel.org/

-- 
Kees Cook

