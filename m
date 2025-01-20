Return-Path: <linux-fsdevel+bounces-39686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AEEA16F50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDE3164028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7969F1E8855;
	Mon, 20 Jan 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E56mUz61"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4971E8824
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737387478; cv=none; b=ZR3w2TcX7qHHKjI7uqB742HFvApvA88USj6/0hUXnOfmIabVdW729dpSkfvYP/xYmmSjn3gy/5Kbnwf3Owa7Akr8E0vxPbHUPJ9vscxdqkWfMBT2QRu714KdQDffNEFLHoDpktrJdGMuUe/7y0Y+1Cgy05qWlUYLUKFqq3pUFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737387478; c=relaxed/simple;
	bh=2x0EOTV2m/p7FsKzV0ZPtIaLhg7S8pMXED1YozmhD5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP4h3HXYM6iR9/gSVvt2r7VTCQdcg6bxHYjqhKzENiAag+VY0r2A/7MEEunWkOc/q96xsNL0rattDK/PwvDTVj8WoGK9rt15hyUApWNmHk9BpZiXLHAHeTj9LXRhTRYerU80aFZd5LSs1s2eEbOLFImRvs4WT5prBfMmyQd7ZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E56mUz61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EC5C4CEE2;
	Mon, 20 Jan 2025 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737387478;
	bh=2x0EOTV2m/p7FsKzV0ZPtIaLhg7S8pMXED1YozmhD5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E56mUz61ilS5Hn0cd204AIJPDBDGSl0Scdo1asvTe8rO9XyMEteS53qVAGA4sdOt3
	 SZOE7aWZOIWUqP0B8SZt0RwW3sAgtKH35cNNgcM6ksshLwEt7cHwZ2hX6glxGj+AKb
	 3Beih4WvP8eph70oowwXA6hStyiY9XwdlfjDgajWnVX9WRr1GuuC7hVGlgfOW9i412
	 eAQSrKrg8x3eW53wRSbQX73PRDSypVxvYXOevHHS937SNH+lBIJ+LLNoqTBS59QgmT
	 tF9KnF29pJ9v3t/cuSaCAeZsB894TlyQJbLZgIdmjfab5BcrERDcT+4KsTSQ1M0Bbl
	 DBK4N+mFqoa3A==
Date: Mon, 20 Jan 2025 16:37:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, linux-fsdevel@vger.kernel.org, 
	daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250120-sparsam-maden-d2e02080360a@brauner>
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
 <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>

On Fri, Jan 17, 2025 at 07:39:09AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/1/16 21:16, Christian Brauner 写道:
> > On Wed, Jan 15, 2025 at 10:56:08AM -0800, Boris Burkov wrote:
> > > Hello,
> > > 
> > > If we run the following C code:
> > > 
> > > unshare(CLONE_NEWNS);
> > > int fd = open("/dev/loop0", O_RDONLY)
> > > unshare(CLONE_NEWNS);
> > > 
> > > Then after the second unshare, the mount hierarchy created by the first
> > > unshare is fully dereferenced and gets torn down, leaving the file
> > > pointed to by fd with a broken dentry.
> > > 
> > > Specifically, subsequent calls to d_path on its path resolve to
> > > "/loop0". I was able to confirm this with drgn, and it has caused an
> > > unexpected failure in mkosi/systemd-repart attempting to mount a btrfs
> > > filesystem through such an fd, since btrfs uses d_path to resolve the
> > > source device file path fully.
> > > 
> > > I confirmed that this is definitely due to the first unshare mount
> > > namespace going away by:
> > > 1. printks/bpftrace the copy_root path in the kernel
> > > 2. rewriting my test program to fork after the first unshare to keep
> > > that namespace referenced. In this case, the fd is not broken after the
> > > second unshare.
> > > 
> > > 
> > > My question is:
> > > Is this expected behavior with respect to mount reference counts and
> > > namespace teardown?
> > > 
> > > If I mount a filesystem and have a running program with an open file
> > > descriptor in that filesystem, I would expect unmounting that filesystem
> > > to fail with EBUSY, so it stands to reason that the automatic unmount
> > > that happens from tearing down the mount namespace of the first unshare
> > > should respect similar semantics and either return EBUSY or at least
> > > have the lazy umount behavior and not wreck the still referenced mount
> > > objects.
> > > 
> > > If this behavior seems like a bug to people better versed in the
> > > expected behavior of namespaces, I would be happy to work on a fix.
> > 
> > It's expected as Al already said. And is_good_dev_path()
> > looks pretty hacky...
> > 
> > Wouldn't something like:
> > 
> > bool is_devtmpfs(const struct super_block *sb)
> > {
> >          return sb->s_type == &dev_fs_type;
> > }
> > 
> > and then:
> > 
> >          ret = kern_path(dev_path, 0, &path);
> >          if (ret)
> >                  goto out;
> > 
> > 	if (is_devtmpfs(path->mnt->mnt_sb))
> > 		// something something
> > 
> > be enough? Or do you specifically need to care where devtmpfs is
> > mounted? The current check means that anything that mounts devtmpfs
> > somewhere other than /dev would fail that check.
> 
> That above checks looks good.
> 
> > 
> > Of course, any standard Linux distribution will mount devtmpfs at /dev
> > so it probably won't matter in practice. And contains may make /dev a
> > tmpfs mount and bind-mount device nodes in from the host's devtmpfs so
> > that would work too with this check.
> > 
> > In other words, I don't get why the /dev prefix check gets you anything?
> > If you just verify that the device node is located on devtmpfs you
> > should be good.
> 
> The original problem is that we can get very weird device path, like
> '/proc/<pid>/<fd>' or any blockdev node created by the end user, as
> mount source, which can cause various problems in mount_info for end users.
> 
> Although after v6.8 it looks like there are some other black magics
> involved to prevent such block device being passed in.
> I tried the same custom block device node, it always resolves to
> "/dev/mapper/test-scratch1" in my case (and not even "/dev/dm-3").
> 
> 
> However there is still another problem, related to get_canonical_dev_path().
> 
> As it still goes d_path(), it will return the path inside the namespace.
> Which can be very different from root namespace.

I consider the source device as shown in mountinfo a hint and not more.
It's entirely possible that someone does:

mount /dev/sdd4 /mnt
mv /dev/sdd4 /dev/foo
mv /dev/sdd3 /dev/sdd4

That just usually doesn't happen because userspace isn't generally
stupid and devtmpfs device nodes are mostly managed by the kernel.

But in containers you can easily have an equivalent scenario and
whatever shows up in /dev in the container can be something completely
different than what you see in mountinfo.

So really, relying on the path name is overall pretty useless.

These mismatches between mountinfo and whatever is in /dev isn't
anything new. Containers may use devpts devices that belong to the host
devpts instance while also having a separate devpts instance mounted in
the container. And the device names just accidently match.

The container/host needs to take care to validate that the provided pty
device it uses does actually belong to the devpts instance of the
container/host and not to another instance to avoid being tricked into
opening and allocating device nodes in another devpts instance.

> 
> So I'm wondering if we should even bother the device path resolution at
> all inside btrfs?

I think that's misguided and will always lead to weird issues.

> Or the latest fsconfig API is already resolving the path correctly?

It wouldn't help with the above examples.

