Return-Path: <linux-fsdevel+bounces-39807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7112A188DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 01:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE2D7A3C34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 00:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B74EACD;
	Wed, 22 Jan 2025 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Dt+UqwcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1178EBE4F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505328; cv=none; b=kOsMu3vEfQhnDGyjb3F9uJGvJGrIvN4p/rXx+h34mNOZyg1k6V9FuSxdYneQinfHCAE5LgUHtxFUUFBu+RxRe+Du/JtCQV/tFrCIs/iIXe3hbgYeWq6nZUORcEVtPk+d5X9q25hOIYMMv4fmi884934tbVf/5OxXH++RJ+CRk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505328; c=relaxed/simple;
	bh=+KuLylpFcjYIjwKuNqNOwcqfwohJ82fuUTCPXq6xVxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fypB3bvK7l5prFOQheVju9ryaOTLMBJ3wm5CireAcnS+WSjhfULCb0iGLWiL4n3HyTdvE83XZ5XfSsdC15iBPPodtU1laSFziwpibDVmEQ+q4X7JTvxe3nbcHE08E0MhLLIpruIrHyGCDfByfrHIBbUbnykacbTUw9kl0uSaCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Dt+UqwcK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21669fd5c7cso112885265ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 16:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737505326; x=1738110126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR7n4KskjSTuOYRkxgE7MFfrptNyS9LAKXIiGx5Bmt4=;
        b=Dt+UqwcKVlc4cgqAJmS7JEGDPCfZIvkk47YZCVEYwPC5AiCaGtIgGkwXT5dW/kBgbk
         IirBRapqS2WbN58OT0ti72CjsGVujAA0AI683H5QYlucrAD3ReqMcObnuBcqB74nIktx
         xvKkZZhtx7zG3kY6ngQ9CUPx5P1kvKGsOPmqQ9FYnXU4CXHJTrEuFSN/ob3NFBylCdtn
         qXIgiE9gmF1i1W7JEOY10Ra11WrDnUs4EikO0lxxlSwd+T+vzjITtfZtVbPUjR3upFhz
         CmETv7mqMVFZkARO8UGSph3h2i0jn28sXOVx17YSzMKfa1Qcx9qy+P3AQtP2/tK34UXQ
         hKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737505326; x=1738110126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR7n4KskjSTuOYRkxgE7MFfrptNyS9LAKXIiGx5Bmt4=;
        b=uI1gJJm3YYo0PnK6hsZFPPmhp6doSbMEKaOvkhx+CbvQWEq3S9oUWNT11ddIuuZXmO
         X8h8psN/ScmPmdcyGq3KeucLWyPHKJII4n1/DnPmSgdr3UwEper7Bg3jJUddnrhTX1eJ
         zYxPi/B+ZfMUAJjK+/A1lyxCCyEZEOnazZbx0WLnFuY8e0OHqzWat33wg5lihoa2kflM
         mIc4XB73geBYeo9tlUEpK5A3JEHQ3JJJ2gVQpiGM9JUO/mEHP1ONUz7001fPG67pXL5H
         oBdlz++E1J2jy/vkUpm1CVhKfeKnTReHn2Q2ASwDr8XxC9ZaA+aulqHx9r22ulZ+MpsV
         yrIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTV78m9BCZ+w2GYs5Fz70caQR1KBZnn8Jn6eLeo5fHwv1bhbkr+N0kP14rbkkLiVVS1y38Ck9wwmoyr3bI@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFpEYk47DQzdvqfQuKaL+ie0esj9LzfToe0ODPoRpsroZh7c6
	DADYEd8rIQu95kqQwBM76GRq2t1Br+blmnXUxWXkhBGovV+7mZK6pO8G6t8tJXY=
X-Gm-Gg: ASbGncshIeDJ/mwbGodUVI2qNj7j1xuexjJGm/a0Lpc+LB2ZBeYq2CI3su7HjlH30+s
	gNAFq5XZ8pLM69o8LvxTI5/vaJJaDFuPHBETCnc9edG7QAeaOId4lvGGCeo4+oIgWDiVWmWwHIf
	ETmi8HJQS5QUfxsLXGPLPGsMu1TFezTaY+cbxfrpMYzsjgKKbltrahIu0S2Jk72iCOXLFeMogIr
	tEEMne3y6yldyI3kmIhx+RyYgI+kwunf1VhHmbo1xvo6S7+gavsIjnfO6VKDlCIrtYQWLHbOtAf
	cdR92yUJJDVL/H2ksgLofJM/bPGYLbauYyDYuFLGjmRFSw==
X-Google-Smtp-Source: AGHT+IHt9XgKKUgtNwhFp8SV1V8qVjA2QyMa0i7SAcFMmofUC3lb1VUV5kC5/gPBYmxldXhYGmzCHA==
X-Received: by 2002:a05:6a20:3943:b0:1e1:c03c:b420 with SMTP id adf61e73a8af0-1eb21587174mr33209594637.31.1737505326090;
        Tue, 21 Jan 2025 16:22:06 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8173d0sm10087925b3a.58.2025.01.21.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 16:22:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taOVO-00000008rtC-1ZIb;
	Wed, 22 Jan 2025 11:22:02 +1100
Date: Wed, 22 Jan 2025 11:22:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, lsf-pc@lists.linuxfoundation.org,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
Message-ID: <Z5A6KtmOMoWk20xM@dread.disaster.area>
References: <>
 <Z41z9gKyyVMiRZnB@dread.disaster.area>
 <173732553757.22054.12851849131700067664@noble.neil.brown.name>
 <Z472VjIvT78DskGv@dread.disaster.area>
 <2aa2cea5a36dd1250134706e31fd0fa42cdf0fd4.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa2cea5a36dd1250134706e31fd0fa42cdf0fd4.camel@kernel.org>

On Tue, Jan 21, 2025 at 08:04:46AM -0500, Jeff Layton wrote:
> On Tue, 2025-01-21 at 12:20 +1100, Dave Chinner wrote:
> > On Mon, Jan 20, 2025 at 09:25:37AM +1100, NeilBrown wrote:
> > > On Mon, 20 Jan 2025, Dave Chinner wrote:
> > > > On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > > > > 
> > > > > My question to fs-devel is: is anyone willing to convert their fs (or
> > > > > advice me on converting?) to use the new interface and do some testing
> > > > > and be open to exploring any bugs that appear?
> > > > 
> > > > tl;dr: You're asking for people to put in a *lot* of time to convert
> > > > complex filesystems to concurrent directory modifications without
> > > > clear indication that it will improve performance. Hence I wouldn't
> > > > expect widespread enthusiasm to suddenly implement it...
> > > 
> > > Thanks Dave!
> > > Your point as detailed below seems to be that, for xfs at least, it may
> > > be better to reduce hold times for exclusive locks rather than allow
> > > concurrent locks.  That seems entirely credible for a local fs but
> > > doesn't apply for NFS as we cannot get a success status before the
> > > operation is complete.
> > 
> > How is that different from a local filesystem? A local filesystem
> > can't return from open(O_CREAT) with a struct file referencing a
> > newly allocated inode until the VFS inode is fully instantiated (or
> > failed), either...
> > 
> > i.e. this sounds like you want concurrent share-locked dirent ops so
> > that synchronously processed operations can be issued concurrently.
> > 
> > Could the NFS client implement asynchronous directory ops, keeping
> > track of the operations in flight without needing to hold the parent
> > i_rwsem across each individual operation? This basically what I've
> > been describing for XFS to minimise parent dir lock hold times.
> > 
> 
> Yes, basically. The protocol and NFS client have no requirement to
> serialize directory operations. We'd be happy to spray as many at the
> server in parallel as we can get away with. We currently don't do that
> today, largely because the VFS prohibits it.
>
> The NFS server, or exported filesystem may have requirements that
> serialize these operations though.

Sure, 
> 
> > What would VFS support for that look like? Is that of similar
> > complexity to implementing shared locking support so that concurrent
> > blocking directory operations can be issued? Is async processing a
> > better model to move the directory ops towards so we can tie
> > userspace directly into it via io_uring?
> 
> Given that the VFS requires an exclusive lock today for directory
> morphing ops, moving to a model where we can take a shared lock on the
> directory instead seems like a nice, incremental approach to dealing
> with this problem.

I understand this, but it's not really "incremental" in that it
entrenches the "concurrency is only possible for synchronous
processing models" that shared locking across the entire operation
entails.

i.e. we can't hand the shared lock to another thread to release on
completion (e.g. an async processing pipeline) because lockdep will
get upset about that and {down,up}_read_non_owner() is very much
discouraged and {down,up}_write_non_owner() doesn't even exist.

> That said, I get your objection. Not being able to upgrade a rwsem
> makes that shared lock kind of nasty for filesystems that actually do
> rely on it for some parts of their work today.

It's more than that - the use of a rwsem for exclusion basically
forces us into "task that takes the lock must release the lock"
model, and so if the VFS expects the entire operation to be done
under a down_read() context then we must complete the entire
operation before handing back the completion to the original task.

That's why I'm pushing back against a "whole task" centric shared
locking model as it is ultimately unfriendly to efficient async
dispatch and completion of background tasks.

> The usual method of dealing with that would be to create a new XFS-only
> per-inode lock that would take over that serialization. The nice thing
> there is that you could (over time) reduce its scope.

As I've already said: we already have an internal per-inode rwsem in
XFS for protecting physical directory operations against races.
Suggesting this is the solution is missing the point I was trying to
make: that it doesn't actually solve anything and the better
solution for filesystems like XFS is to decouple the front end VFS
serialisation requirements from the back end filesystem
implementation.

That's kinda my point: this isn't an "XFS-only" problem - it's
something that almost every filesystem we have is going to have
problems with. I very much doubt btrfs will be able to do concurrent
directory mods due to it's namespace btree exclusion model, and I
suspect that bcachefs is going to have the same issues, too.

Hence I think shared locking is fundamentally the wrong model here -
the problem that we need to address is the excessive latency of
synchronous back end FS ops, not the lack of concurrency in
processing directory modifications. Yes, a lack of back end
filesytsem concurrency contributes to the excessive latency of
synchronous directory modification, but that doesn't mean that the
best solution to the problem is to change the concurrency model.

i.e. If we have to make the same mods to every filesystem to do
background async processing to take any sort of advantage of shared
locking, and those background processing mods don't actually require
a shared locking model to realise the performance benefits, then why
add the complexity of a "shared lock for modification" model in the
first place?

[snip stuff about how to decouple VFS/fs serialisation]

> So maybe we'd have something like:
> 
> struct mkdir_context {
> 	struct mnt_idmap	*idmap;	// current args to mkdir op
> 	struct inode		*dir;
> 	struct dentry		*dentry;
> 	umode_t			mode;
> 	int			status		// return status
> 	struct completion	complete;	// when done -- maybe this would be completion callback function?
> };
> 
> ...and an inode operation like:
> 
> 	int (*mkdir_begin)(struct mkdir_context *ctx);
> 
> Then the fs could just pass a pointer to that around, and when the
> operation is done, complete the variable, which would make the original
> task that called mkdir() finalize the results of the op?

That's still serial/synchronous task processing of the entire
operation and does nothing to hide the latency of the operation from
the user.

As I've already explained, this is not the model I've been talking
about.

Yes, we'd need a dynamically allocated control structure that
defines the inode instantiation task that needs completing, but
there's no need for completions within it as the caller can call
wait_on_inode() to wait for the async inode instantiation to
complete.

If the instantiation fails, then we mark the inode bad, stash the
errno somewhere in the inode, and the waiter then grabs the errno
and tears down the inode to clean up the mess.

> My worry here would be that dealing with the workqueue and context
> switching would be a performance killer in the simple cases that do it
> all in a single thread today.

Catch-22.

The premise behind shared locking is that mkdir operations block
(i.e. context switch multiple times) and so have high latency and
long lock hold times. Therefore we need shared locking to be able to
issue lots of them concurrently to get bulk directory performance.

The argument now being made is that adding context switches to mkdir
operations that -don't block- (i.e. the opposite behaviour that
shared locking is trying to adress) will cause performance problems.

i.e. The "simple cases that do it all in a single thread today" are
blocking and taking multiple context switches on every operation.
e.g. nfs client submits to the server, has to wait for reply, so
there's two context switches per operation.

This misses the point of doing async background processing: it
removes the blocking from the foreground task until it is absolutely
necessary, hence helping the foreground process *not block* whilst
holding the parent directory lock and so reduce lock hold times and
increase the number of ops that can be done under that exclusive
lock.

Using shared locking doesn't change the context switch overhead.
Using async processing doesn't make the context switch overhead
worse.  What changes is where those context switches occur and how
much foreground task and lock latency they result in. And in some
cases, async processing drastically reduces context switch overhead
because it allows for subsystems to batch process pending
operations.

Anyone who has been following io_uring development should know all
these things about async processing already. There's a reason that
that infrastructure exists: async processing is more efficient and
faster than the concurrent synchronous processing model being
proposed here....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

