Return-Path: <linux-fsdevel+bounces-30350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE73798A299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922B2281C30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4F183098;
	Mon, 30 Sep 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX55u6TP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D016126C07;
	Mon, 30 Sep 2024 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699678; cv=none; b=Uzme+17lFmrAKz9cUit73Dpzye/K7oKqUz+Z/n8mQhB/heGiA+OL+QDZcNJj2Zxm1caUyVQCjPPguj0PrM/1yqnQLCgWtRKc/9ThJ0ry9mkixAVQsojtg5r6Pq3xXveWuGshRlCCGv1eSd9ZCS2UkasYJEWmqhEOb9+iv/p0JKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699678; c=relaxed/simple;
	bh=QIG50gsAuDNEdAD4sYdmyP9U9mIQ+FPqmqNXI/RmpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxGNdQrzOMtAUz3STMFmu0VA7yd2QbT+eGGeT8lQgKYSFx2AMQREf962LioA5Q/D8/B+35AabfCAjxp5gvQDsUA6q+7eyRnu4r3JP96ocSF7wpjtjeSdR7vXPjNKSBB6aaX3q+gBIslEKY90o7V5Tw3ZtPOCnNbbr/BgGd3wi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX55u6TP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580A2C4CEC7;
	Mon, 30 Sep 2024 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727699678;
	bh=QIG50gsAuDNEdAD4sYdmyP9U9mIQ+FPqmqNXI/RmpE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XX55u6TPb7v1ucI75GB0Fgvo0jazhfo5ge0LACwOmkf8sLGc2lCqH/17jcSJMT1Yg
	 /vqJ2u1yN8ATiSCDVLNWzAl+2ydsx2NA96Qx0ujDXI+D4OZ7xAuAkguamoiN1CmyOL
	 x1FJ6m1igOWyLxm8kcss9g2XRsBAwKO26K3znpgxiHbO+lel1ADtgU4jvg7JWkUA9h
	 1cH/WDYN6fP6cfCj4bCtVBgGugFFXwpZDCE53i0qkc8dz9xV72mPzpRJ3QOH/A4Wwm
	 xd/tnsbhTs/kzncbTOSqqGq/+gL4H0vrcbakHA4Hv+HqNYu67QPKXmAvl4pAF8wyk1
	 qrvNtXUe8m99w==
Date: Mon, 30 Sep 2024 14:34:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Florian Weimer <fweimer@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] introduce PIDFD_SELF
Message-ID: <20240930-verbiegen-zinspolitik-cafb730c3c84@brauner>
References: <cover.1727644404.git.lorenzo.stoakes@oracle.com>
 <87ttdxl9ch.fsf@oldenburg.str.redhat.com>
 <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42df57ac-d89c-4111-a04d-290dd2197573@lucifer.local>

On Mon, Sep 30, 2024 at 11:39:49AM GMT, Lorenzo Stoakes wrote:
> On Mon, Sep 30, 2024 at 12:33:18PM GMT, Florian Weimer wrote:
> > * Lorenzo Stoakes:
> >
> > > If you wish to utilise a pidfd interface to refer to the current process
> > > (from the point of view of userland - from the kernel point of view - the
> > > thread group leader), it is rather cumbersome, requiring something like:
> > >
> > > 	int pidfd = pidfd_open(getpid(), 0);
> > >
> > > 	...
> > >
> > > 	close(pidfd);
> > >
> > > Or the equivalent call opening /proc/self. It is more convenient to use a
> > > sentinel value to indicate to an interface that accepts a pidfd that we
> > > simply wish to refer to the current process.
> >
> > The descriptor will refer to the current thread, not process, right?
> 
> No it refers to the current process (i.e. thread group leader from kernel
> perspective). Unless you specify PIDFD_THREAD, this is the same if you did the above.
> 
> >
> > The distinction matters for pidfd_getfd if a process contains multiple
> > threads with different file descriptor tables, and probably for
> > pidfd_send_signal as well.
> 
> You mean if you did a strange set of flags to clone()? Otherwise these are
> shared right?
> 
> Again, we are explicitly looking at process not thread from userland
> perspective. A PIDFD_SELF_THREAD might be possible, but this series doesn't try
> to implement that.

Florian raises a good point. Currently we have:

(1) int pidfd_tgid = pidfd_open(getpid(), 0);
(2) int pidfd_thread = pidfd_open(getpid(), PIDFD_THREAD);

and this instructs:

pidfd_send_signal()
pidfd_getfd()

to do different things. For pidfd_send_signal() it's whether the
operation has thread-group scope or thread-scope for pidfd_send_signal()
and for pidfd_getfd() it determines the fdtable to use.

The thing is that if you pass:

pidfd_getfd(PDIFD_SELF)

and you have:

TGID

T1 {
    clone(CLONE_THREAD)
    unshare(CLONE_FILES)
}

T2 {
    clone(CLONE_THREAD)
    unshare(CLONE_FILES)
}

You have 3 threads in the same thread-group that all have distinct file
descriptor tables from each other.

So if T1 did:

pidfd_getfd(PIDFD_SELF, ...)

and we mirror the PIDTYPE_TGID behavior then T1 will very likely expect
to get the fd from its file descriptor table. IOW, its reasonable to
expect that T1 is interested in their very own resource, not someone
else's even if it is the thread-group leader.

But what T1 will get in reality is an fd from TGID's file descriptor
table (and similar for T2).

Iirc, yes that confusion exists already with /proc/self. But the
question is whether we should add the same confusion to the pidfd api or
whether we make PIDFD_SELF actually mean PIDTYPE_PID aka the actual
calling thread.

My thinking is that if you have the reasonable suspicion that you're
multi-threaded and that you're interested in the thread-group resource
then you should be using:

int pidfd = pidfd_open(getpid(), 0)

and hand that thread-group leader pidfd around since you're interested
in another thread. But if you're really just interested in your own
resource then pidfd_open(getpid(), 0) makes no sense and you would want
PIDFD_SELF.

Thoughts?

