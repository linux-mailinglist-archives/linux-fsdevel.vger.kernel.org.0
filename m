Return-Path: <linux-fsdevel+bounces-10187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5664F8487E5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 18:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AC28596E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742525FB86;
	Sat,  3 Feb 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vxbk//bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD135FB8D
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981256; cv=none; b=cfmxCUyyXiZflgiyVQhxHrMQFimALz+N/YlDiEZgTrXRc/EsTRmLRK43PmM5wJUaGm2fGnKaJqzhViFXX3UBdkU2rtQcIXSNwNCNysoojRCCYvhXiI5UVNse4/WABuXftG1nL2Cf+QTnvOla0dZaQOUb4+U0C7q4n6R2di5FeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981256; c=relaxed/simple;
	bh=riTGzsp7sDkCBJIvVKhAE9uArMQupunDnU1ITUV2NXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHNO35Qv4h1NiFjrjL5Df+47MItrGlBLdP4NrSjB4WP3Rt9XAy2RfBkFh4qu+W2PU74ShjRO6aMEPJeskjsOnDN6pD//ndc/pvMaQVkOLvdgYAR1vK9330VAzmOY4yayDfIKCZMmY560gX2/EqJjM7enYPp/my8LCtAjSACcB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vxbk//bq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 3 Feb 2024 12:27:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706981251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PNfWOtiIX9Cs1s0iRQar9DY2eJFWlkoqzcILXEBLG2w=;
	b=Vxbk//bq0QVbzqN0BHqgioxL2dabqdrTquCmMO1mINh6CExN88qnaknvQgA5eyh5jEp7kk
	/aGkV/MAANk/H/RUpo69ARWu6S6FmLKd8VsG3x+rtD7vWgMwSh+XUTL9OE0Hd1TsdOKi9O
	7wRtrJmID8149ldNUx5f4rNpLVSjNHs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, lsf-pc@lists.linux-foundation.org, 
	Matthew Wilcox <willy@infradead.org>, dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
Message-ID: <xnbhx2wbnsso2vzexs2fzit7xxzal2qriphent3pojexvwquni@gkho3q7eho6n>
References: <CAJfpegu6v1fRAyLvFLOPUSAhx5aAGvPGjBWv-TDQjugqjUA_hQ@mail.gmail.com>
 <2701318.1706863882@warthog.procyon.org.uk>
 <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
 <2704767.1706869832@warthog.procyon.org.uk>
 <2751706.1706872935@warthog.procyon.org.uk>
 <20240202162346.GB2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202162346.GB2087318@ZenIV>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 02, 2024 at 04:23:46PM +0000, Al Viro wrote:
> On Fri, Feb 02, 2024 at 11:22:15AM +0000, David Howells wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > Just making inode_lock() interruptible would break everything.
> > 
> > Why?  Obviously, you'd need to check the result of the inode_lock(), which I
> > didn't put in my very rough example code, but why would taking the lock at the
> > front of a vfs op like mkdir be a problem?
> 
> Plenty of new failure exits to maintain?

I don't currently see a reason to go around converting existing
uninterruptible sleeps; the main benefit of the proposal as I see it
would be that we could mark sleeps as either interruptible or killable
correctly, since that really depends on what syscall we're in and what
userspace is expecting. If kernel code can correctly do one it can do
both, so this is a pretty straightforward change.

But it is an interesting idea, I'd be curious to see what comes out of
playing around with some refactorings.

There's some other wait_event() related ideas kicking around too...

Willy and Dave and I were talking about the "asynchronous waits" that
io_uring is wanting to do - I believe this is currently just done in an
ad-hoc way for waiting on a folio lock.

It seemed like it might be possible to do this in a more generic way by
simply dynamically allocating the waitlist entry, and signalling via
task_struct the wait/wakeup should be delivered to a kiocb, instead of
to a thread.

Another thing I've been wanting to do is embed a sequence number in
wait_queue_head_t, which would be incremented on wakeup. This would
change prepare_to_wait() to "read current sequence number", then later
we sleep until the sequence number has changed from what we initially
read.

This would let us fix double expansion of the wait condition in the
wait_event() macros, and it would also mean we're not flipping task
state before running the cond expression...

