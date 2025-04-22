Return-Path: <linux-fsdevel+bounces-46923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA770A96940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957E93BB804
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5761FDA94;
	Tue, 22 Apr 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A3buqNfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B461F09B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324718; cv=none; b=pj9Hu/5LQuvmzeQcU9OGwhYBMhbYyDM5WVzxB+iqWg40v96HTMiVAfU+VwBsOZ6uu+0DSJZZ5a4j82o92/FxgwrTPm9dKlz0uffLOa9OWrkSagbJHrq+sBp/WzuuLz+hC9pmXcNVLOWfWVOkPJKWY5F8ZqtYLLuzskDwrDVTN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324718; c=relaxed/simple;
	bh=CWoyTh+Q/6W8Nv8gddun+uEr0UT8coD1FmH1Wj/0rko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOEGSlTTwN925eYNDbmR9V850fGNvqyirbgBachraz8Vn/w2hatgGEk1Sn7dzg3TCJe96pXpBbNjuFabRX6UXVBEdmQPR7Fx8Da1PICl+sH2U1JIL6E3PUzIykIHxlbLBoygis+YRbwOvnW7b6ALIsk6fW3UMrqvdLUgVx+NdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A3buqNfp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YtHQfcU0ujBCHdSccsLsNycAHDtNC5m4+Ufos9psphw=; b=A3buqNfpqr91yH4pCEoe04vU7q
	uu79vgiWtkqRMYnzOj+3uFz/HQZUAm/CN/WQvuFrrR8q410PjCq3VnOUol8pNOvwOEDp1nCjdRzsk
	H1Je5VIBELlbWxcWSCdQuVTK8Ay+Ee/E5lPhPp4dHUhLlXz1M32/7D4LP0OrEVlPXaOIcTSQBQ3u9
	MXBY8zFHQOjWRMtbap3PPSPX7M6hdESi/bxcjzttcscneyt4hibK4V2Rjh0Fhf43N1c0sod6StQCc
	Iiej39MQfsgUzA4bAc51HCyJAg9zRm0IX0IHclObpbXVRwZ+qQsQCsCgbzVxFAPY9YVM80g13up3N
	vPj5ZNGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Cgc-00000005tqA-141B;
	Tue, 22 Apr 2025 12:25:14 +0000
Date: Tue, 22 Apr 2025 13:25:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250422122514.GZ2023217@ZenIV>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250422-erbeten-ambiente-f6b13eab8a29@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-erbeten-ambiente-f6b13eab8a29@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 22, 2025 at 09:31:14AM +0200, Christian Brauner wrote:
> On Mon, Apr 21, 2025 at 05:29:47PM +0100, Al Viro wrote:
> > On Mon, Apr 21, 2025 at 09:56:20AM +0200, Christian Brauner wrote:
> > > On Mon, Apr 21, 2025 at 04:35:09AM +0100, Al Viro wrote:
> > > > Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
> > > > back in 2018.  Get rid of the dead checks...
> > > >     
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > ---
> > > 
> > > Good idea. Fwiw, I've put this into vfs-6.16.mount with some other minor
> > > stuff. If you're keeping it yourself let me know.
> > 
> > Not sure...  I'm going through documenting the struct mount lifecycle/locking/etc.
> > and it already looks like there will be more patches, but then some are going
> > to be #fixes fodder.
> > 
> > Example caught just a couple of minutes ago: do_lock_mount()
> >                 if (beneath) {
> >                         m = real_mount(mnt);
> >                         read_seqlock_excl(&mount_lock);
> >                         dentry = dget(m->mnt_mountpoint);
> >                         read_sequnlock_excl(&mount_lock);
> >                 } else {
> >                         dentry = path->dentry;
> >                 }
> > 
> >                 inode_lock(dentry->d_inode);
> > What's to prevent the 'beneath' case from getting mnt mount --move'd
> > away *AND* the ex-parent from getting unmounted while we are blocked
> > in inode_lock?  At this point we are not holding any locks whatsoever
> > (and all mount-related locks nest inside inode_lock(), so we couldn't
> > hold them there anyway).
> > 
> > Hit that race and watch a very unhappy umount...
> 
> If it gets unmounted or moved we immediately detect this in the next line:
> 
> if (beneath && (!is_mounted(mnt) || m->mnt_mountpoint != dentry)) {

Sure, we would - *AFTER* we get through that inode_lock().

Consider the following setup:

mkdir foo
mkdir bar
mkdir splat
mount -t tmpfs none foo		# mount 1
mount -t tmpfs none bar		# mount 2
mkdir bar/baz
mount -t tmpfs none bar/baz	# mount 3

then

A: move_mount(AT_FDCWD, "foo", AT_FDCWD, "bar/baz", MOVE_MOUNT_BENEATH)
gets to do_move_mount() and into do_lock_mount() called by it.

path->mnt points to mount 3, path->dentry - to its root.  Both are pinned.
do_lock_mount() goes into the first iteration of loop.  beneath is true,
so it picks dentry - that of #3 mountpoint, i.e. "/baz" on #2 tmpfs instance.

At that point refcount of that dentry is 3 - one from being a positive on
tmpfs, one from being a mountpoint and one more just grabbed by do_lock_mount().

Now we enter inode_lock(dentry->d_inode).  Note that at that point A is not
holding any locks.  Suppose it gets preempted at this moment for whatever reason.

B: mount --move bar/baz splat
Proceeds without any problems, mount #3 gets moved to "splat".  Now refcount
of mount #2 is not pinned by anything and refcount of "/baz" on it is 2, since
it's no longer a mountpoint.

B: umount bar
... and now it hits the fan, since the refcount of mount #2 is not elevated by
anything, so we do not hit -EBUSY and proceed through umount(2) all the way to
kill_litter_super(), which drops the refcount of "/baz" to 1 and calls kill_anon_super().
Which gets to shrink_dcache_for_umount() and from there - to umount_check() on
that dentry.  You get yelled at, then you get yelled at again for busy inodes
after umount (that dentry is pinning the inode down), etc.  Superblock of #2
is freed.

A: regains CPU.  is_mounted() is true (now at splat instead of bar/baz, but still
mounted), ->mnt_mountpoint does not match.
All right, inode_unlock(dentry->d_inode), then dput(dentry) and now the refcount
of that dentry finally hits zero.  We get iput() on its inode, followed by
shmem_evict_inode() which is where we finally oops.

As for the second issue...  Normal callers of unlock_mount() do have a struct path
somewhere that pins the location we are dealing with.  However, 'beneath' case
of do_move_mount() does not - it relies upon the sucker being a mountpoint all
along.  Which is fine until you drop namespace_sem.  As soon as namespace_unlock()
has been called, there's no warranty that it will _stay_ a mountpoint.  Moving
that inode_unlock() before the namespace_unlock() avoids that scenario.

