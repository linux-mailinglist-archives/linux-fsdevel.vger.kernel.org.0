Return-Path: <linux-fsdevel+bounces-20237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731F28D01E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A21287ED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B1E15EFBF;
	Mon, 27 May 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGp+ZBcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC58E13A250;
	Mon, 27 May 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817201; cv=none; b=OZMc9tDnxk/VTdXXp34Ds4MI9T4db1RbqkcCrc4DJn/VtestzPxP8mmBQ6CpbM75cFYWEw8BPAdAAygmZ8atvs3iV03KEtxLZVo0wVJu4bRBTjL3yELCFL4Qps/a0K3QAD6b48etQJZhOY0RANBxKi8L2w11fIhqNc1tYNS0BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817201; c=relaxed/simple;
	bh=dF2ZzgaKg2vMrKZIaefq9VEnRZs4KJRRMNz57D6zwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAtXs4IKUjW3mhG7oe+OO1zUGafqH2oJz1equl8weS7KNC7ad810voFtZcy8ThwffUuyy/cIkal8m1jtDl12YiV2tSoKCphaoccFP7RYIklyQ2yTgvhxJnorzWI12n6HKHy8XycG3pxz07/l1PPwWPHuiAMhzHTbYY9i8O1DRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGp+ZBcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D5DC2BBFC;
	Mon, 27 May 2024 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716817201;
	bh=dF2ZzgaKg2vMrKZIaefq9VEnRZs4KJRRMNz57D6zwKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dGp+ZBcNyK7f+t1nE7TeiScwZzH5IFtX+LazgSy4P1qj+gppbSaDt3V0+g+sew8Jr
	 xhZAoyJhGJ55b03eIvmbJnKaQZT2SmbnR69f0uChcDZd9LiV1I2VU74A4qL1Q7t27N
	 CbhImB7hi5lTKV4VDIP0noMG+BBekBlhyXR3qvHa9Bz+ezWVvBT8FIyEtosupQCeLw
	 lvazQ4PPAXO9lpTBFMpYagaZaBpF/2FwNdcyWTV9tpevfEjqrGLE/ZgVPQoUQpRRTf
	 CeanqsWwlk8HzX+smLgLzG6aS5b+GfvM0suLa+RNcxtEo9GOifE44MIImCIsk5NsxD
	 UljyDXVsD30CA==
Date: Mon, 27 May 2024 15:39:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240527-paare-holzhammer-8c3a32eaf6b1@brauner>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
 <20240524-ahnden-danken-02a2e9b87190@brauner>
 <ZlPOd0p7AUn7JqLu@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlPOd0p7AUn7JqLu@dread.disaster.area>

On Mon, May 27, 2024 at 10:06:15AM +1000, Dave Chinner wrote:
> On Fri, May 24, 2024 at 02:25:30PM +0200, Christian Brauner wrote:
> > On Thu, May 23, 2024 at 09:52:20AM -0600, Aleksa Sarai wrote:
> > > On 2024-05-21, Christian Brauner <brauner@kernel.org> wrote:
> > > > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > > > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > > > > provide a file handle and corresponding mount without needing to worry
> > > > > about racing with /proc/mountinfo parsing.
> > > > > 
> > > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > > > > that doesn't make sense for name_to_handle_at(2).
> > > > > 
> > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > ---
> > > > 
> > > > So I think overall this is probably fine (famous last words). If it's
> > > > just about being able to retrieve the new mount id without having to
> > > > take the hit of another statx system call it's indeed a bit much to
> > > > add a revised system call for this. Althoug I did say earlier that I
> > > > wouldn't rule that out.
> > > > 
> > > > But if we'd that then it'll be a long discussion on the form of the new
> > > > system call and the information it exposes.
> > > > 
> > > > For example, I lack the grey hair needed to understand why
> > > > name_to_handle_at() returns a mount id at all. The pitch in commit
> > > > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
> > > > the (old) mount id can be used to "lookup file system specific
> > > > information [...] in /proc/<pid>/mountinfo".
> > > 
> > > The logic was presumably to allow you to know what mount the resolved
> > > file handle came from. If you use AT_EMPTY_PATH this is not needed
> > > because you could just fstatfs (and now statx(AT_EMPTY_PATH)), but if
> > > you just give name_to_handle_at() almost any path, there is no race-free
> > > way to make sure that you know which filesystem the file handle came
> > > from.
> > > 
> > > I don't know if that could lead to security issues (I guess an attacker
> > > could find a way to try to manipulate the file handle you get back, and
> > > then try to trick you into operating on the wrong filesystem with
> > > open_by_handle_at()) but it is definitely something you'd want to avoid.
> > 
> > So the following paragraphs are prefaced with: I'm not an expert on file
> > handle encoding and so might be totally wrong.
> > 
> > Afaiu, the uniqueness guarantee of the file handle mostly depends on:
> > 
> > (1) the filesystem
> > (2) the actual file handling encoding
> > 
> > Looking at file handle encoding to me it looks like it's fairly easy to
> > fake them in userspace (I guess that's ok if you think about them like a
> > path but with a weird permission model built around them.) for quite a
> > few filesystems.
> 
> This is a feature specifically used by XFS utilities like xfs_fsr
> and xfsdump to take pathless inode information retrieved by bulkstat
> operations to a file handle to enable arbitrary inodes in the
> filesystem to be opened.
> 
> i.e. they scan the filesystem by walking the filesystem's internal
> inode index, not by walking paths to scan the filesytsem. This is
> *much* faster than path walking, especially on seek-limited storage
> hardware.
> 
> Knowing the inode number, generation and fs uuid, we can
> construct a valid filehandle for that inode, and then do whatever
> operations we need to do (defrag, backup, move offline (HSM), etc)
> without needing to know the path to that inode....

Yeah, I think you mentioned this in another context before.

> > The problem is with what name_to_handle_at() returns imho. A mnt_id
> > doesn't pin the filesystem and the old mnt_id isn't unique. That means
> > the filesystem can be unmounted and go away and the mnt_id can be
> > recycled almost immediately for another mount but the file handle is
> > still there.
> 
> This is no different to the NFS server unexporting a filesystem -
> all attempts to resolve the file handle the client holds for that
> export must now fail. Hence the filehandle itself must have a
> superblock specific identifier in it.
> 
> > So to guarantee that a (weakly encoded) file handle is interpreted in
> > the right filesystem the file handle must either be accompanied by a
> > file descriptor that pins the relevant mount or have any other guarantee
> > that the filesystem doesn't go away (Or of course, the file handle
> > encodes the uuid of the filesystem or something or uses some sort of
> > hashing scheme.).
> 
> Yes, it does, and that's the superblock based identifier, not
> something that is mount based. i.e.  the handle is valid regardless
> of where the filesystem is mounted, even if the application does not
> have visibility or permitted access to the given mount. And the
> filehandle is persistent - it must work across unmount/mount,
> reboots, change of mount location, etc.

Agreed, and no one is disputing that. The old mount id as exposed by
name_to_handle_at() is one means to get to a persisent identifier and
that is racy. But we do have a 64bit non-recyled mount id and
statmount() since v6.7 now which allow to get a persistent identifier
for the filesystem in a race-free manner.

