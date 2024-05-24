Return-Path: <linux-fsdevel+bounces-20110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E38CE54A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 14:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86F81F214DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5203512A152;
	Fri, 24 May 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkW0tr5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37E129E8C;
	Fri, 24 May 2024 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553535; cv=none; b=In3o9OG/IpI0hIV2LNanjiZzJKgIloC9+GuCdVl+/rKcMfS8g6ZbAkIbK8XG1GlaRxVUWONxnYgmTjFLQp9jDlVV45B/+cBEsjCPmhnhUpjxO/FLlTwnF2Vfi3fBT1RkFEJ5kQi8RZM46VjeoWPTR5/U3oMK2xluc0NTc9lihlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553535; c=relaxed/simple;
	bh=ZxYHa51J4F5219O37AqS4VcEPL/q/VMQFkZNaNvxL90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i09h36bHNBK+/EZcV0BhKHjTYp7vAP7KABdgm5CpaR1Lwf4GiLtPbZjiwFDvzLwY/J1HVbmj+N+8zI3L/mrR0INoq6/58h2lBoR2JDYsjyOryAKFOdVPcb91ZaFwWtYJD6yfKc0988wh5L4Zb1qUqVnETkpw9ImScsAeOUGO9uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkW0tr5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D97DC3277B;
	Fri, 24 May 2024 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716553535;
	bh=ZxYHa51J4F5219O37AqS4VcEPL/q/VMQFkZNaNvxL90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkW0tr5R8netKj3H1R0ye6wSoxVxKRlZiTiwB5ukR9z1c7TP8OAWTNPe+H9EmVF22
	 iKkCl70NzB7uaY8AfBcCaRKbTyGTfdFg1jHihFJZ5Uoy8R+aVDuz0tNO8q75mlh7us
	 Xy8VhegHlVFdHiVLAf9zzcRCH1bsnEs7SXkm37EWKHiVieSVPSCoghLYqr24+y78kR
	 38s1l2TmBykYbhZ+4vsqtYBw2j6ggNFV733hpo7KUxTw41ziOyxLOi2+wHF+Xw4hRh
	 mTzxV/l6+7NC5VCV6V/NgIBNtmyoV/WvvdqAmM9xUOaFZhSEqiakJdZ+TbeZxHQOKe
	 M1jgxSlGK77Ng==
Date: Fri, 24 May 2024 14:25:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
Message-ID: <20240524-ahnden-danken-02a2e9b87190@brauner>
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner>
 <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523.154320-nasty.dough.dark.swig-wIoXO62qiRSP@cyphar.com>

On Thu, May 23, 2024 at 09:52:20AM -0600, Aleksa Sarai wrote:
> On 2024-05-21, Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > statx, we can now provide a race-free way for name_to_handle_at(2) to
> > > provide a file handle and corresponding mount without needing to worry
> > > about racing with /proc/mountinfo parsing.
> > > 
> > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* bit
> > > that doesn't make sense for name_to_handle_at(2).
> > > 
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > 
> > So I think overall this is probably fine (famous last words). If it's
> > just about being able to retrieve the new mount id without having to
> > take the hit of another statx system call it's indeed a bit much to
> > add a revised system call for this. Althoug I did say earlier that I
> > wouldn't rule that out.
> > 
> > But if we'd that then it'll be a long discussion on the form of the new
> > system call and the information it exposes.
> > 
> > For example, I lack the grey hair needed to understand why
> > name_to_handle_at() returns a mount id at all. The pitch in commit
> > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is that
> > the (old) mount id can be used to "lookup file system specific
> > information [...] in /proc/<pid>/mountinfo".
> 
> The logic was presumably to allow you to know what mount the resolved
> file handle came from. If you use AT_EMPTY_PATH this is not needed
> because you could just fstatfs (and now statx(AT_EMPTY_PATH)), but if
> you just give name_to_handle_at() almost any path, there is no race-free
> way to make sure that you know which filesystem the file handle came
> from.
> 
> I don't know if that could lead to security issues (I guess an attacker
> could find a way to try to manipulate the file handle you get back, and
> then try to trick you into operating on the wrong filesystem with
> open_by_handle_at()) but it is definitely something you'd want to avoid.

So the following paragraphs are prefaced with: I'm not an expert on file
handle encoding and so might be totally wrong.

Afaiu, the uniqueness guarantee of the file handle mostly depends on:

(1) the filesystem
(2) the actual file handling encoding

Looking at file handle encoding to me it looks like it's fairly easy to
fake them in userspace (I guess that's ok if you think about them like a
path but with a weird permission model built around them.) for quite a
few filesystems.

For example, for anything that uses fs/libfs.c:generic_encode_ino32_fh()
it's easy to construct a file handle by retrieving the inode number via
stat and the generation number via FS_IOC_GETVERSION.

Encoding using the inode number and the inode generation number is
probably not very strong so it's not impossible to generate a file
handle that is not unique without knowing in which filesystem to
interpret it in.

The problem is with what name_to_handle_at() returns imho. A mnt_id
doesn't pin the filesystem and the old mnt_id isn't unique. That means
the filesystem can be unmounted and go away and the mnt_id can be
recycled almost immediately for another mount but the file handle is
still there.

So to guarantee that a (weakly encoded) file handle is interpreted in
the right filesystem the file handle must either be accompanied by a
file descriptor that pins the relevant mount or have any other guarantee
that the filesystem doesn't go away (Or of course, the file handle
encodes the uuid of the filesystem or something or uses some sort of
hashing scheme.).

One of the features of file handles is that they're globally usable so
they're interesting to use as handles that can be shared. IOW, one can
send around a file handle to another process without having to pin
anything or have a file descriptor open that needs to be sent via
AF_UNIX.

But as stated above that's potentially risky so one might still have to
send around an fd together with the file handle if sender and receiver
don't share the filesystem for the handle.

However, with the unique mount id things improve quite a bit. Because
now it's possible to send around the unique mount id and the file
handle. Then one can use statmount() to figure out which filesystem this
file handle needs to be interpreted in.

> 
> > Granted, that's doable but it'll mean a lot of careful checking to avoid
> > races for mount id recycling because they're not even allocated
> > cyclically. With lots of containers it becomes even more of an issue. So
> > it's doubtful whether exposing the mount id through name_to_handle_at()
> > would be something that we'd still do.
> > 
> > So really, if this is just about a use-case where you want to spare the
> > additional system call for statx() and you need the mnt_id then
> > overloading is probably ok.
> > 
> > But it remains an unpleasant thing to look at.
> > 
> 
> Yeah, I agree it's ugly.
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>



