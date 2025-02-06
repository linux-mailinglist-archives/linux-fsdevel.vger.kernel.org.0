Return-Path: <linux-fsdevel+bounces-41076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA9A2AA0E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89A53AA698
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC8199B9;
	Thu,  6 Feb 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx2rlSGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7301EA7C0;
	Thu,  6 Feb 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848906; cv=none; b=eCYsmn72DySuwLXp5CFd4IYWXX6CY50pljp8xXrWsjbB2ZtBF+2e6vTHICN7oxcJzSfoy0IrhO04/DSTAVwIVTmE/+bRCRmfEoFs8sa+/FU/AY++LRPn4K9ygruyzRmwFCiej9GK+OEanwgg/XzMblAtEzHczYmWKshcAunWm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848906; c=relaxed/simple;
	bh=tVoDQ7fDHYavMaIBf6OpSoHIN3J38dTXcwr8Ehd5Nz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRdzdwvv5hIIW5zFNyrWDAey87QaZD5Tq5Vg/dbGsNUNMwUz+pcy99KtEMAlveOE+7J79mJPUWQEHLfQnLJg3LoMOXt5P7MfVgMu7IGeiEKkr4UCgCtKyT9DFc/5O8b5U7DLXG+se610DdVAjH0iuhdDM9JVnOZuUkOB4rFJCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx2rlSGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C5FC4CEDD;
	Thu,  6 Feb 2025 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848905;
	bh=tVoDQ7fDHYavMaIBf6OpSoHIN3J38dTXcwr8Ehd5Nz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jx2rlSGh5E4lmD5Zr/uWi/14Fmj0ldgckXjrZASstnQCxiUQ/OABrw6gU7UqHBUoM
	 VQuR+Vj2wgZYYMNCPpSPEN+9c3B5QQ1dnGDkDsI+WePYhVN1s5SUXCrN8oNve7ZvIb
	 mcuhdKpHQrp+5EmMWGZkN/F6SXpx04SJO5Mwg9eRlrnW2aH/6RfxnJwFYUtSeS8NZW
	 W5SrRamk0GBtGvDRI7+JH0vuHo5lrXHk92Gp6lQL3PTWrjo69Aru995L5/NJmJCc6p
	 FI6fM4Fbn40c7OO63Hh2V61YRhvk+rhX0+SQxqa27MT87hmvDkl1TE4zPco3CGQYpO
	 3nFcegO9GoeJg==
Date: Thu, 6 Feb 2025 14:35:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat()
 syscalls
Message-ID: <20250206-wisst-rangieren-d59f7882761a@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com>
 <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
 <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com>
 <20250206-erbauen-ornament-26f338d98f13@brauner>
 <cfnfHaahrrXJJOgvNjb5hFbU0qh8gVXJ62R9uP9AItBEywyNH9vNBRzJbPR8xTv-LtFaUJYTHvyuLBfkznwJPt3fEcqNBFxf_yKJeZKwL3I=@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfnfHaahrrXJJOgvNjb5hFbU0qh8gVXJ62R9uP9AItBEywyNH9vNBRzJbPR8xTv-LtFaUJYTHvyuLBfkznwJPt3fEcqNBFxf_yKJeZKwL3I=@yhndnzj.com>

On Thu, Feb 06, 2025 at 01:25:19PM +0000, Mike Yuan wrote:
> On 2/6/25 11:03, Christian Brauner <brauner@kernel.org> wrote:
> 
> >  On Thu, Feb 06, 2025 at 09:51:33AM +0000, Mike Yuan wrote:
> >  > On 2/6/25 10:31, Christian Brauner <brauner@kernel.org> wrote:
> >  >
> >  > >  On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
> >  > >  > Cited from commit message of original patch [1]:
> >  > >  >
> >  > >  > > One use case will be setfiles(8) setting SELinux file contexts
> >  > >  > > ("security.selinux") without race conditions and without a file
> >  > >  > > descriptor opened with read access requiring SELinux read permission.
> >  > >  >
> >  > >  > Also, generally all *at() syscalls operate on O_PATH fds, unlike
> >  > >  > f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
> >  > >  > in the final version merged into tree. Instead, let's switch things
> >  > >  > to CLASS(fd_raw).
> >  > >  >
> >  > >  > Note that there's one side effect: f*xattr() starts to work with
> >  > >  > O_PATH fds too. It's not clear to me whether this is desirable
> >  > >  > (e.g. fstat() accepts O_PATH fds as an outlier).
> >  > >  >
> >  > >  > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@seltendoof.de/
> >  > >  >
> >  > >  > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> >  > >  > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> >  > >  > Cc: Al Viro <viro@zeniv.linux.org.uk>
> >  > >  > Cc: Christian Göttsche <cgzones@googlemail.com>
> >  > >  > Cc: Christian Brauner <brauner@kernel.org>
> >  > >  > Cc: <stable@vger.kernel.org>
> >  > >  > ---
> >  > >
> >  > >  I expanded on this before. O_PATH is intentionally limited in scope and
> >  > >  it should not allow to perform operations that are similar to a read or
> >  > >  write which getting and setting xattrs is.
> >  > >
> >  > >  Patches that further weaken or dilute the semantics of O_PATH are not
> >  > >  acceptable.
> >  >
> >  > But the *at() variants really should be able to work with O_PATH fds, otherwise they're basically useless? I guess I just need to keep f*() as-is?
> >  
> >  I'm confused. If you have:
> >  
> >          filename = getname_maybe_null(pathname, at_flags);
> >          if (!filename) {
> >                  CLASS(fd, f)(dfd);
> >                  if (fd_empty(f))
> >                          error = -EBADF;
> >                  else
> >                          error = file_setxattr(fd_file(f), &ctx);
> >  
> >  Then this branch ^^ cannot use fd_raw because you're allowing operations
> >  directly on the O_PATH file descriptor.
> >  
> >  Using the O_PATH file descriptor for lookup is obviously fine which is
> >  why the other branch exists:
> >  
> >          } else {
> >                  error = filename_setxattr(dfd, filename, lookup_flags, &ctx);
> >          }
> >  
> >  IOW, your patch makes AT_EMPTY_PATH work with an O_PATH file descriptor
> >  which isn't acceptable. However, it is already perfectly fine to use an
> >  O_PATH file descriptor for lookup.
> 
> Well, again, [1] clearly stated the use case:
> 
> > Those can be used to operate on extended attributes,
> especially security related ones, either relative to a pinned directory
> or [on a file descriptor without read access, avoiding a
> /proc/<pid>/fd/<fd> detour, requiring a mounted procfs].
> 
> And this surfaced in my PR to systemd:
> 
> https://github.com/systemd/systemd/pull/36228/commits/34fe16fb177d2f917570c5f71dfa8f5b9746b9a7
> 
> How are *xattrat() syscalls different from e.g. fchmodat2(AT_EMPTY_PATH) in that regard? I can agree that the semantics of f*xattr() ought to be left untouched, yet I fail to grok the case for _at variants.

man openat:

       O_PATH (since Linux 2.6.39)
              Obtain a file descriptor that can be used for two purposes: to indicate a location in the filesystem tree and to perform operations that act purely at the file descriptor level.
              The file itself is not opened, and other file operations (e.g., read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2)) fail with the error EBADF.

              The following operations can be performed on the resulting file descriptor:

              •  close(2).

              •  fchdir(2), if the file descriptor refers to a directory (since Linux 3.5).

              •  fstat(2) (since Linux 3.6).

              •  fstatfs(2) (since Linux 3.12).

              •  Duplicating the file descriptor (dup(2), fcntl(2) F_DUPFD, etc.).

              •  Getting and setting file descriptor flags (fcntl(2) F_GETFD and F_SETFD).

              •  Retrieving open file status flags using the fcntl(2) F_GETFL operation: the returned flags will include the bit O_PATH.

              •  Passing  the  file  descriptor  as the dirfd argument of openat() and the other "*at()" system calls.  This includes linkat(2) with AT_EMPTY_PATH (or via procfs using AT_SYM‐
                 LINK_FOLLOW) even if the file is not a directory.

              •  Passing the file descriptor to another process via a UNIX domain socket (see SCM_RIGHTS in unix(7)).

Both fchownat() and fchmodat() variants have had this behavior which
is a bug. And not a great one because it breaks O_PATH guarantees.
That's no reason to now also open up further holes such as getting and
setting xattrs.

If you want to perform read/write like operations you need a proper file
descriptor for that and not continue to expand the meaning of O_PATH
until it is indistinguishable from a regular file descriptor.

