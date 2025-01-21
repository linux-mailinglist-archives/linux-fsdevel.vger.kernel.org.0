Return-Path: <linux-fsdevel+bounces-39772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2FA17E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337353AC6D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC51F237E;
	Tue, 21 Jan 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXxZNqCi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870A1F191E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737464688; cv=none; b=JlnVKwjO65V0SGdtGmJGP/MBuNK1pm/vsQUwppHsewnJIgRoc9IIi0V4k1NTQTJUTOnaYPS0Dxj9axp6t/lFwFQBVtkEdspi4NNQkGQX2X/t+wcA5/+pvUi8JeJYolIWsG+taMBGBypsQGfRbYU5qBCulAYt0Ml+97vlXSVGVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737464688; c=relaxed/simple;
	bh=UruNWCT9GvYsAX7zcbH3sKs6cuHtetVD1T9BDj+quhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/JqWwZfFjmHf3qVJQE2AAnQ+4PWQ2jlWZetRgD+RlcF3mS4wYkadkvHMMMAZGwCSKktJG0NxpXQWzuPNyKrY2+Z8EJtMDz9sU0ovSZL/VmBtuQOEy5XepnuII7jZizpTufdzUY7UIblhymj9YxBacwQxMFLxzNyJYm+PLTyPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXxZNqCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86EC4CEDF;
	Tue, 21 Jan 2025 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737464688;
	bh=UruNWCT9GvYsAX7zcbH3sKs6cuHtetVD1T9BDj+quhY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lXxZNqCiRXlwW4HbbeR8bi/7VNVITsskw3/HjtP8SShW/4A83oLaGORCI9d6fiWqr
	 O58qNqrukSWONDwy3GB2qVyNHxLPCx5W1EXrC0w9LU33qcU6usdrgWdQGdd5NRYi9u
	 RfUHW/3aJ1TMbdnH3ZtX23FrO/iIjbPXDnijFpFIqhVomh2hF4La5IbCKcLIwbkc4E
	 webgFuYO1YoOeH3mmdMc6N2xp5Jc+fGejrIJUMl88Zuo9JD1+bee8I0lGGvwbBHxne
	 v00lRlnXd24EU2t4U59rSzsitUdAB2WK6SPDkMjJ4M7kT5/T7vKP6jBaY6vncei7F+
	 +9jNsa+2Tz/qw==
Message-ID: <2aa2cea5a36dd1250134706e31fd0fa42cdf0fd4.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>
Cc: lsf-pc@lists.linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 21 Jan 2025 08:04:46 -0500
In-Reply-To: <Z472VjIvT78DskGv@dread.disaster.area>
References: <> <Z41z9gKyyVMiRZnB@dread.disaster.area>
	 <173732553757.22054.12851849131700067664@noble.neil.brown.name>
	 <Z472VjIvT78DskGv@dread.disaster.area>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-21 at 12:20 +1100, Dave Chinner wrote:
> On Mon, Jan 20, 2025 at 09:25:37AM +1100, NeilBrown wrote:
> > On Mon, 20 Jan 2025, Dave Chinner wrote:
> > > On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > > >=20
> > > > My question to fs-devel is: is anyone willing to convert their fs (=
or
> > > > advice me on converting?) to use the new interface and do some test=
ing
> > > > and be open to exploring any bugs that appear?
> > >=20
> > > tl;dr: You're asking for people to put in a *lot* of time to convert
> > > complex filesystems to concurrent directory modifications without
> > > clear indication that it will improve performance. Hence I wouldn't
> > > expect widespread enthusiasm to suddenly implement it...
> >=20
> > Thanks Dave!
> > Your point as detailed below seems to be that, for xfs at least, it may
> > be better to reduce hold times for exclusive locks rather than allow
> > concurrent locks.  That seems entirely credible for a local fs but
> > doesn't apply for NFS as we cannot get a success status before the
> > operation is complete.
>=20
> How is that different from a local filesystem? A local filesystem
> can't return from open(O_CREAT) with a struct file referencing a
> newly allocated inode until the VFS inode is fully instantiated (or
> failed), either...
>=20
> i.e. this sounds like you want concurrent share-locked dirent ops so
> that synchronously processed operations can be issued concurrently.
>=20
> Could the NFS client implement asynchronous directory ops, keeping
> track of the operations in flight without needing to hold the parent
> i_rwsem across each individual operation? This basically what I've
> been describing for XFS to minimise parent dir lock hold times.
>=20

Yes, basically. The protocol and NFS client have no requirement to
serialize directory operations. We'd be happy to spray as many at the
server in parallel as we can get away with. We currently don't do that
today, largely because the VFS prohibits it.

The NFS server, or exported filesystem may have requirements that
serialize these operations though.

> What would VFS support for that look like? Is that of similar
> complexity to implementing shared locking support so that concurrent
> blocking directory operations can be issued? Is async processing a
> better model to move the directory ops towards so we can tie
> userspace directly into it via io_uring?
>=20

Given that the VFS requires an exclusive lock today for directory
morphing ops, moving to a model where we can take a shared lock on the
directory instead seems like a nice, incremental approach to dealing
with this problem.

That said, I get your objection. Not being able to upgrade a rwsem
makes that shared lock kind of nasty for filesystems that actually do
rely on it for some parts of their work today.

The usual method of dealing with that would be to create a new XFS-only
per-inode lock that would take over that serialization. The nice thing
there is that you could (over time) reduce its scope.

> > So it seems likely that different filesystems
> > will want different approaches.  No surprise.
> >=20
> > There is some evidence that ext4 can be converted to concurrent
> > modification without a lot of work, and with measurable benefits.  I
> > guess I should focus there for local filesystems.
> >=20
> > But I don't want to assume what is best for each file system which is
> > why I asked for input from developers of the various filesystems.
> >=20
> > But even for xfs, I think that to provide a successful return from mkdi=
r
> > would require waiting for some IO to complete, and that other operation=
s
>=20
> I don't see where IO enters the picture, to be honest. File creation
> does not typically require foreground IO on XFS at all (ignoring
> dirsync mode). How did you think we scale XFS to near a million file
> creates a second? :)=20
>=20
> In the case of mkdir, it does not take a direct reference to the
> inode being created so it potentially doesn't even need to wait for
> the completion of the operation. i.e. to use the new subdir it has
> to be open()d; that means going through the ->lookup path and which
> will block on I_NEW until the background creation is completed...
>=20
> That said, open(O_CREAT) would need to call wait_on_inode()
> somewhere to wait for I_NEW to clear so operations on the inode can
> proceed immediately via the persistent struct file reference it
> creates.  With the right support, that waiting can be done without
> holding the parent directory locked, as any new lookup on that
> dirent/inode pair will block until I_NEW is cleared...
>=20
> Hence my question above about what does VFS support for
> async dirops actually looks like, and whether something like this:
>=20
> > might benefit from starting before that IO completes.
> > So maybe an xfs implementation of mkdir_shared would be:
> >  - take internal exclusive lock on directory
> >  - run fast foreground part of mkdir
> >  - drop the lock
> >  - wait for background stuff, which could affect error return, to
> >   complete
> >  - return appropriate error, or success
>=20
> as natively supported functionality might be a better solution to
> the problem....
>=20
> From the XFs perspective, we already have internal exclusive locking
> for dirent mods, but that is needed for serialising the physical
> directory mods against other (shared access) readers (e.g. lookup
> and readdir).  We would not want to be sharing such an internal lock
> across the unbound fast path concurrency of lookup, create, unlink,
> readdir -and- multiple background processing threads.
>=20
> Logging a modification intent against an inode wouldn't require a
> new internal inode lock; AFAICT all it requires is exclusivity
> against lookup so that lookup can find new/unlinked dirents that
> have been logged but not yet added to or removed from the physical
> directory blocks.
>=20
> We can do that by inserting the VFS inode into cache in the
> foreground operation and leaving I_NEW set on create.  We can do a
> similar thing with unlink (I_WILL_FREE?) to make the VFS inode
> invisible to new lookups before the unlink has actually been
> processed. In this way, we can push the actual processing into
> background work queues without actually changing how the namespace
> behaves from a user perspective...
>=20
> We -might- be able to do all these operations under a shared VFS
> lock, but it is not necessary to have a shared VFS lock to enable
> such a async processing model. If the performance gains for the NFS
> client come from allowing concurrent processing of individual
> synchronous operations, then we really need to consider if there are
> other methods of hiding synchronous operation latency that might
> be more applicable to more filesystems and high performance user
> interfaces...
>=20

So maybe we'd have something like:

struct mkdir_context {
	struct mnt_idmap	*idmap;	// current args to mkdir op
	struct inode		*dir;
	struct dentry		*dentry;
	umode_t			mode;
	int			status		// return status
	struct completion	complete;	// when done -- maybe this would be completion=
 callback function?
};

...and an inode operation like:

	int (*mkdir_begin)(struct mkdir_context *ctx);

Then the fs could just pass a pointer to that around, and when the
operation is done, complete the variable, which would make the original
task that called mkdir() finalize the results of the op?

My worry here would be that dealing with the workqueue and context
switching would be a performance killer in the simple cases that do it
all in a single thread today.
--=20
Jeff Layton <jlayton@kernel.org>

