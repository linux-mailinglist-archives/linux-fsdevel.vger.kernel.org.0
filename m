Return-Path: <linux-fsdevel+bounces-30471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9398B95D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77EA1F2362B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B52192D74;
	Tue,  1 Oct 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM9h8C/G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD23209;
	Tue,  1 Oct 2024 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778098; cv=none; b=KxC99NppsSPvU7nOddkRvO5sAGpnjLDtLBJRF39KMxz+uxMOfYezXvAjQ/TWdnKrhHi8NS/U6qwpQiTvGCoeHCBkLE+aJmBUbuaoYNfYQLpiWiIfTeZ1UK40mo6tBAUOxXqcUMVYhlG12HdnyMoJBB+yY53Pw7f0Ah2eoSKG7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778098; c=relaxed/simple;
	bh=wluuHAc01SS7mkJT/FzCZ0xt1SHsHqpNeSN0BbjLliM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb4jRs3g5Fb6mXo+ItfEB707Mq26zF/Ho2myPV/w/jgAoSryJNZF0+SwxyK6Vom4kbOLi9dEkNDQqPRP7iln2WeauEkhIm4XNu8owj8+42vvEbvGmDf9WzwhoNZSBZ405CzwR0cbCO4vLVzW2yAi6AhQhKKvvZE1faN53p4H5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM9h8C/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CD6C4CEC6;
	Tue,  1 Oct 2024 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727778097;
	bh=wluuHAc01SS7mkJT/FzCZ0xt1SHsHqpNeSN0BbjLliM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QM9h8C/GJ9l7//lxMgAEa90ssI+3WGddnIEmrHtARmkQEtO56Uxd/uLcbM4n5/EP+
	 AYhGc4Uf2yuqbeDqUsMbushkHpWyS4KRnmevv0iE8zk4zXVZtDSq6qu+6obXHdnCG3
	 P2Bji66wBL1ymFhNLHlP6Y1aeFWNseR88fv7dSLzChRJUhOgnIirqqZoUnlWozHkTy
	 ZBgjJvOCjLWlhLJgj0EYIcF5+eajsgMUqC6Km3HpYTrTUTuWsgII5SCdX261eRHiVN
	 8CnoT2556iVH08CoKr5RvwyWiHdBw6DNU+qGEfKLGVZWCcbRBzWPAXvTgK3PEqB7Wt
	 98SQtQRTWEKMA==
Date: Tue, 1 Oct 2024 12:21:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Florian Weimer <fweimer@redhat.com>, Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <20241001-stapfen-darfst-5fe2a8b2c6ec@brauner>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
 <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
 <cdd24e6d-4300-4afe-b2ef-1b8ee528bccc@lucifer.local>
 <20240930.141721-salted.birth.growing.forges-5Z29YNO700C@cyphar.com>
 <8b1b376b-3c4f-409a-b8e4-8faf3efecdc8@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b1b376b-3c4f-409a-b8e4-8faf3efecdc8@lucifer.local>

On Mon, Sep 30, 2024 at 03:32:25PM GMT, Lorenzo Stoakes wrote:
> On Mon, Sep 30, 2024 at 04:21:23PM GMT, Aleksa Sarai wrote:
> > On 2024-09-30, Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > On Mon, Sep 30, 2024 at 02:34:33PM GMT, Christian Brauner wrote:
> > > > On Mon, Sep 30, 2024 at 11:39:49AM GMT, Lorenzo Stoakes wrote:
> > > > > On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> > > > > > * Lorenzo Stoakes:
> > > > > >
> > > > > > > If you wish to utilise a pidfd interface to refer to the current process
> > > > > > > (from the point of view of userland - from the kernel point of view - the
> > > > > > > thread group leader), it is rather cumbersome, requiring something like:
> > > > > > >
> > > > > > > 	int pidfd = pidfd_open(getpid(), 0);
> > > > > > >
> > > > > > > 	...
> > > > > > >
> > > > > > > 	close(pidfd);
> > > > > > >
> > > > > > > Or the equivalent call opening /proc/self. It is more convenient to use a
> > > > > > > sentinel value to indicate to an interface that accepts a pidfd that we
> > > > > > > simply wish to refer to the current process.
> > > > > >
> > > > > > The descriptor will refer to the current thread, not process, right?
> > > > >
> > > > > No it refers to the current process (i.e. thread group leader from kernel
> > > > > perspective). Unless you specify PIDFD_THREAD, this is the same if you did the above.
> > > > >
> > > > > >
> > > > > > The distinction matters for pidfd_getfd if a process contains multiple
> > > > > > threads with different file descriptor tables, and probably for
> > > > > > pidfd_send_signal as well.
> > > > >
> > > > > You mean if you did a strange set of flags to clone()? Otherwise these are
> > > > > shared right?
> > > > >
> > > > > Again, we are explicitly looking at process not thread from userland
> > > > > perspective. A PIDFD_SELF_THREAD might be possible, but this series doesn't try
> > > > > to implement that.
> > > >
> > > > Florian raises a good point. Currently we have:
> > > >
> > > > (1) int pidfd_tgid = pidfd_open(getpid(), 0);
> > > > (2) int pidfd_thread = pidfd_open(getpid(), PIDFD_THREAD);
> > > >
> > > > and this instructs:
> > > >
> > > > pidfd_send_signal()
> > > > pidfd_getfd()
> > > >
> > > > to do different things. For pidfd_send_signal() it's whether the
> > > > operation has thread-group scope or thread-scope for pidfd_send_signal()
> > > > and for pidfd_getfd() it determines the fdtable to use.
> > > >
> > > > The thing is that if you pass:
> > > >
> > > > pidfd_getfd(PDIFD_SELF)
> > > >
> > > > and you have:
> > > >
> > > > TGID
> > > >
> > > > T1 {
> > > >     clone(CLONE_THREAD)
> > > >     unshare(CLONE_FILES)
> > > > }
> > > >
> > > > T2 {
> > > >     clone(CLONE_THREAD)
> > > >     unshare(CLONE_FILES)
> > > > }
> > > >
> > > > You have 3 threads in the same thread-group that all have distinct file
> > > > descriptor tables from each other.
> > > >
> > > > So if T1 did:
> > > >
> > > > pidfd_getfd(PIDFD_SELF, ...)
> > > >
> > > > and we mirror the PIDTYPE_TGID behavior then T1 will very likely expect
> > > > to get the fd from its file descriptor table. IOW, its reasonable to
> > > > expect that T1 is interested in their very own resource, not someone
> > > > else's even if it is the thread-group leader.
> > > >
> > > > But what T1 will get in reality is an fd from TGID's file descriptor
> > > > table (and similar for T2).
> > > >
> > > > Iirc, yes that confusion exists already with /proc/self. But the
> > > > question is whether we should add the same confusion to the pidfd api or
> > > > whether we make PIDFD_SELF actually mean PIDTYPE_PID aka the actual
> > > > calling thread.
> > > >
> > > > My thinking is that if you have the reasonable suspicion that you're
> > > > multi-threaded and that you're interested in the thread-group resource
> > > > then you should be using:
> > > >
> > > > int pidfd = pidfd_open(getpid(), 0)
> > > >
> > > > and hand that thread-group leader pidfd around since you're interested
> > > > in another thread. But if you're really just interested in your own
> > > > resource then pidfd_open(getpid(), 0) makes no sense and you would want
> > > > PIDFD_SELF.
> > > >
> > > > Thoughts?
> > >
> > > I mean from my perspective, my aim is to get current->mm for
> > > process_madvise() so both work for me :) however you both raise a very good
> > > point here (sorry Florian, perhaps I was a little too dismissive as to your
> > > point, you're absolutely right).
> > >
> > > My intent was for PIDFD_SELF to simply mirror the pidfd_open(getpid(), 0)
> > > behaviour, but you and Florian make a strong case that you'd _probably_
> > > find this very confusing had you unshared in this fashion.
> > >
> > > I mean in general this confusion already exists, and is for what
> > > PIDFD_THREAD was created, but I suspect ideally if you could go back you
> > > might actually do this by default Christian + let the TGL behaviour be the
> > > optional thing?
> > >
> > > For most users this will not be an issue, but for those they'd get the same
> > > result whichever they used, but yes actually I think you're both right -
> > > PIDFD_SELF should in effect imply PIDFD_THREAD.
> >
> > Funnily enough we ran into issues with this when running Go code in runc
> > that did precisely this -- /proc/self gave you the wrong fd table in
> > very specific circumstances that were annoying to debug. For languages
> > with green-threading you can't turn off (like Go) these kinds of issues
> > pop up surprisingly often.
> 
> Yeah, damn, useful insight that such things do happen in the wild.
> 
> >
> > > We can adjust the pidfd_send_signal() call to infer the correct scope
> > > (actually nicely we can do that without any change there, by having
> > > __pidfd_get_pid() set f_flags accordingly).
> > >
> > > So TL;DR: I agree, I will respin with PIDFD_SELF referring to the thread.
> > >
> > > My question in return here then is - should we introduce PIDFD_SELF_PROCESS
> > > also (do advise if you feel this naming isn't quite right) - to provide
> > > thread group leader behaviour?
> >
> > Sorry to bike-shed, but to match /proc/self and /proc/thread-self, maybe
> > they should be called PIDFD_SELF (for tgid) and PIDFD_THREAD_SELF (for
> > current's tid)? In principle I guess users might use PIDFD_SELF by
> > accident but if we mirror the naming with /proc/{,thread-}self that
> > might not be that big of an issue?
> 
> Lol, you know I wasn't even aware /proc/thread-self existed...

Wait until you learn that /proc/$TID thread entries exist but aren't
shown when you do ls -al /proc, only when you explicitly access them.

> 
> Yeah, that actually makes sense and is consistent, though obviously the
> concern is people will reflexively use PIDFD_SELF and end up with
> potentially confusing results.
> 
> I will obviously be doing a manpage patch for this so we can spell it out
> there very clearly and also in the header - so I'd actually lean towards
> doing this myself.
> 
> Christian, Florian? Thoughts?

I think adding both would be potentially useful. How about:

#define PIDFD_SELF		-100
#define PIDFD_THREAD_GROUP	-200

This will make PIDFD_SELF mean current and PIDFD_THREAD_GROUP mean
current->pid_links[PIDTYPE_TGID]. I don't think we need to or should
mirror procfs in any way. pidfds are intended to be usable without
procfs at all.

I want to leave one comment on a bit of quirkiness in the api when we
add this. I don't consider it a big deal but it should be pointed out.

It can be useful to allow PIDFD_SELF or PIDFD_THREAD_GROUP to refer to
the calling thread even for pidfd_open() to avoid an additional getpid()
system call:

(1) pidfd_open(PIDFD_SELF, PIDFD_THREAD)
(2) pidfd_open(PIDFD_SELF, 0)

So if we allow this (Should we allow it?) then (1) is just redundant but
whathever. But (2) is at least worth discussing: Should we reject (2) on
the grounds of contradictory requests or allow it and document that it's
equivalent to pidfd_open(getpid(), PIDFD_THREAD)? It feels like the
latter would be ok.

Similar for pidfd_send_signal():

// redundant but ok:
(1) pidfd_send_signal(PIDFD_SELF,         PIDFD_SIGNAL_THREAD)

// redundant but ok:
(2) pidfd_send_signal(PIDFD_THREAD_GROUP, PIDFD_SIGNAL_THREAD_GROUP)

// weird way to spell pidfd_send_signal(PIDFD_THREAD_GROUP, 0)
(3) pidfd_send_signal(PIDFD_SELF,         PIDFD_SIGNAL_THREAD_GROUP)

// weird way to spell pidfd_send_signal(PIDFD_SELF, 0)
(4) pidfd_send_signal(PIDFD_THREAD_GROUP, PIDFD_SIGNAL_THREAD)

I think all of this is ok but does anyone else have a strong opinion?

