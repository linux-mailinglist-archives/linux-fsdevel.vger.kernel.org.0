Return-Path: <linux-fsdevel+bounces-41170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712AA2BEBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DE97A2EBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA0F234978;
	Fri,  7 Feb 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCXsqTKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142931D5CFF;
	Fri,  7 Feb 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919140; cv=none; b=ljCSk47oneGAD9CzBjssK26LoSKIip+4+35o1awwQ4/oXYTQKYbhoRyyBgN69ZYuZWuFZ3OnQaky2uKoOry4VBXwZotinatkRcOMNDhCKTsiOQwwRRW9We5/EGPBYfffsrF7Xx8FdJnS1A1TxIrJueBiVPxM+0/Nj614wlJch4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919140; c=relaxed/simple;
	bh=IgByweI1gQxM5fdrkwHJV0fnw7YYouZy18piG/OIGyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtJ3QhQ0hAISunlLwZu7s0L0urjgf2CjIbHfFg2JWoqyeXMu3szfdOJ5OchYB0TSU7ZIMF/dUNUARUMQLppxBW2HjGO4Dp6LzyuhsKOMJ9qqoWqexp8FykYq1LLS7OhopyiFJmz15QOQIEdKUg86fNdoWstvi5vmQwgeqNdweho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCXsqTKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54DEC4CED1;
	Fri,  7 Feb 2025 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738919139;
	bh=IgByweI1gQxM5fdrkwHJV0fnw7YYouZy18piG/OIGyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RCXsqTKM1S4AYJJXtYdduHVxDWsRmEjHvgT+2HyqqsIc7I6NIAfv8+w9Qy1vf9Ryq
	 +X3E7amyZzr72hMvlLsIuR5gwDI/w03eG6b9D52WisunAdtUY/avjwwMAbv5mIBMfQ
	 h8EeOcJmKfHdOvYwj8j+X5NoBZqwKzEipxip6PHDsmjlKg3MFmLxFWcScTlmOAO7cI
	 WNLPori5QmTfpMDmGKrk1/NPVqL4aGpfpXL0b7FY+zxSXBNwsz27kP43pkevmSUxOL
	 Qi+mVRuil54nNkHUf2asNVE3Yuj+rgK81kzykyFHsoGzhfhSoOZsomztEMt5AABHzR
	 yLGqYmiBxF0XQ==
Date: Fri, 7 Feb 2025 10:05:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, 
	"cgzones@googlemail.com" <cgzones@googlemail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat()
 syscalls
Message-ID: <20250207-bildhaft-hallen-9870a5d1f8fa@brauner>
References: <20250205204628.49607-1-me@yhndnzj.com>
 <20250206-uhrwerk-faultiere-7a308565e2d3@brauner>
 <Kn-2tlpxN8YNmh0j0udjQ8YIFNZMVVJYJh-LyBoYNBfpax28PNUkXuH6gnod7if2eX3NRVs3Ey8uCHRpwg_S5hPX_ADtrgMZbDTWFpHd_uU=@yhndnzj.com>
 <20250206-erbauen-ornament-26f338d98f13@brauner>
 <cfnfHaahrrXJJOgvNjb5hFbU0qh8gVXJ62R9uP9AItBEywyNH9vNBRzJbPR8xTv-LtFaUJYTHvyuLBfkznwJPt3fEcqNBFxf_yKJeZKwL3I=@yhndnzj.com>
 <20250206-wisst-rangieren-d59f7882761a@brauner>
 <Ah2vDyFwRPpHngjgEblSFQWijS6qnrD_LSbpUrdefKpgTotaT4CyzL4RqaWM7axQamVuGi3hPdIzuXl9qBlfHZ9m4-hcUWaWuaoc35Gt8D8=@yhndnzj.com>
 <20250206-steril-raumplanung-733224062432@brauner>
 <xTJWqaYffvXfz-lTQmt2HHs8ryqde0VIbhIlW0DFCW3wxft7WfIDCRm03BsB4Gz4IgWHXwarpkIE880mjL63DVRfU-p1sGJGUFSQBmp_CXY=@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xTJWqaYffvXfz-lTQmt2HHs8ryqde0VIbhIlW0DFCW3wxft7WfIDCRm03BsB4Gz4IgWHXwarpkIE880mjL63DVRfU-p1sGJGUFSQBmp_CXY=@yhndnzj.com>

On Thu, Feb 06, 2025 at 03:19:03PM +0000, Mike Yuan wrote:
> On 2025-02-06 at 15:54, Christian Brauner <brauner@kernel.org> wrote:
> > 
> > On Thu, Feb 06, 2025 at 02:26:51PM +0000, Mike Yuan wrote:
> > 
> > > On 2025-02-06 at 14:35, Christian Brauner brauner@kernel.org wrote:
> > > 
> > > > On Thu, Feb 06, 2025 at 01:25:19PM +0000, Mike Yuan wrote:
> > > > 
> > > > > On 2/6/25 11:03, Christian Brauner brauner@kernel.org wrote:
> > > > > 
> > > > > > On Thu, Feb 06, 2025 at 09:51:33AM +0000, Mike Yuan wrote:
> > > > > > 
> > > > > > > On 2/6/25 10:31, Christian Brauner brauner@kernel.org wrote:
> > > > > > > 
> > > > > > > > On Wed, Feb 05, 2025 at 08:47:23PM +0000, Mike Yuan wrote:
> > > > > > > > 
> > > > > > > > > Cited from commit message of original patch [1]:
> > > > > > > > > 
> > > > > > > > > > One use case will be setfiles(8) setting SELinux file contexts
> > > > > > > > > > ("security.selinux") without race conditions and without a file
> > > > > > > > > > descriptor opened with read access requiring SELinux read permission.
> > > > > > > > > 
> > > > > > > > > Also, generally all at() syscalls operate on O_PATH fds, unlike
> > > > > > > > > f() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
> > > > > > > > > in the final version merged into tree. Instead, let's switch things
> > > > > > > > > to CLASS(fd_raw).
> > > > > > > > > 
> > > > > > > > > Note that there's one side effect: f*xattr() starts to work with
> > > > > > > > > O_PATH fds too. It's not clear to me whether this is desirable
> > > > > > > > > (e.g. fstat() accepts O_PATH fds as an outlier).
> > > > > > > > > 
> > > > > > > > > [1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@seltendoof.de/
> > > > > > > > > 
> > > > > > > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > > > > > > Signed-off-by: Mike Yuan me@yhndnzj.com
> > > > > > > > > Cc: Al Viro viro@zeniv.linux.org.uk
> > > > > > > > > Cc: Christian Göttsche cgzones@googlemail.com
> > > > > > > > > Cc: Christian Brauner brauner@kernel.org
> > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > ---
> > > > > > > > 
> > > > > > > > I expanded on this before. O_PATH is intentionally limited in scope and
> > > > > > > > it should not allow to perform operations that are similar to a read or
> > > > > > > > write which getting and setting xattrs is.
> > > > > > > > 
> > > > > > > > Patches that further weaken or dilute the semantics of O_PATH are not
> > > > > > > > acceptable.
> > > > > > > 
> > > > > > > But the at() variants really should be able to work with O_PATH fds, otherwise they're basically useless? I guess I just need to keep f() as-is?
> > > > > > 
> > > > > > I'm confused. If you have:
> > > > > > 
> > > > > > filename = getname_maybe_null(pathname, at_flags);
> > > > > > if (!filename) {
> > > > > > CLASS(fd, f)(dfd);
> > > > > > if (fd_empty(f))
> > > > > > error = -EBADF;
> > > > > > else
> > > > > > error = file_setxattr(fd_file(f), &ctx);
> > > > > > 
> > > > > > Then this branch ^^ cannot use fd_raw because you're allowing operations
> > > > > > directly on the O_PATH file descriptor.
> > > > > > 
> > > > > > Using the O_PATH file descriptor for lookup is obviously fine which is
> > > > > > why the other branch exists:
> > > > > > 
> > > > > > } else {
> > > > > > error = filename_setxattr(dfd, filename, lookup_flags, &ctx);
> > > > > > }
> > > > > > 
> > > > > > IOW, your patch makes AT_EMPTY_PATH work with an O_PATH file descriptor
> > > > > > which isn't acceptable. However, it is already perfectly fine to use an
> > > > > > O_PATH file descriptor for lookup.
> > > > > 
> > > > > Well, again, [1] clearly stated the use case:
> > > > > 
> > > > > > Those can be used to operate on extended attributes,
> > > > > > especially security related ones, either relative to a pinned directory
> > > > > > or [on a file descriptor without read access, avoiding a
> > > > > > /proc/<pid>/fd/<fd> detour, requiring a mounted procfs].
> > > > > 
> > > > > And this surfaced in my PR to systemd:
> > > > > 
> > > > > https://github.com/systemd/systemd/pull/36228/commits/34fe16fb177d2f917570c5f71dfa8f5b9746b9a7
> > > > > 
> > > > > How are xattrat() syscalls different from e.g. fchmodat2(AT_EMPTY_PATH) in that regard? I can agree that the semantics of fxattr() ought to be left untouched, yet I fail to grok the case for _at variants.
> > > > 
> > > > man openat:
> > > > 
> > > > O_PATH (since Linux 2.6.39)
> > > > Obtain a file descriptor that can be used for two purposes: to indicate a location in the filesystem tree and to perform operations that act purely at the file descriptor level.
> > > > The file itself is not opened, and other file operations (e.g., read(2), write(2), fchmod(2), fchown(2), fgetxattr(2), ioctl(2), mmap(2)) fail with the error EBADF.
> > > > 
> > > > The following operations can be performed on the resulting file descriptor:
> > > > 
> > > > • close(2).
> > > > 
> > > > • fchdir(2), if the file descriptor refers to a directory (since Linux 3.5).
> > > > 
> > > > • fstat(2) (since Linux 3.6).
> > > > 
> > > > • fstatfs(2) (since Linux 3.12).
> > > > 
> > > > • Duplicating the file descriptor (dup(2), fcntl(2) F_DUPFD, etc.).
> > > > 
> > > > • Getting and setting file descriptor flags (fcntl(2) F_GETFD and F_SETFD).
> > > > 
> > > > • Retrieving open file status flags using the fcntl(2) F_GETFL operation: the returned flags will include the bit O_PATH.
> > > > 
> > > > • Passing the file descriptor as the dirfd argument of openat() and the other "*at()" system calls. This includes linkat(2) with AT_EMPTY_PATH (or via procfs using AT_SYM‐
> > > > LINK_FOLLOW) even if the file is not a directory.
> > > > 
> > > > • Passing the file descriptor to another process via a UNIX domain socket (see SCM_RIGHTS in unix(7)).
> > > > 
> > > > Both fchownat() and fchmodat() variants have had this behavior which
> > > > is a bug. And not a great one because it breaks O_PATH guarantees.
> > > > That's no reason to now also open up further holes such as getting and
> > > > setting xattrs.
> > > 
> > > AFAICS that's not really what the kernel development has been after.
> > > fchmodat2(2) in particular was added fairly recently (6.6,
> > > https://github.com/torvalds/linux/commit/09da082b07bbae1c11d9560c8502800039aebcea).
> > > One of the highlights was to add support for O_PATH + AT_EMPTY_PATH).
> > 
> > 
> > These system calls had pre-existing inconsistency. And allowing
> > fchownat() but then not fchmodat2() seemd asymmetric. But given the
> > discussion now I wish I hadn't even allowed that.
> > 
> > > And to me the semantics seem reasonably OK really: O_PATH fds are a way to
> > > pin the inode (i.e. still within the boundry of getting a reference to
> > > a file system object (without opening it) if I shall put it). All the calls
> > > mentioned above operate on the file system object metadata, not the actual data,
> > > hence O_PATH is just providing a file location.
> > > 
> > > The separation of at() and regular f() versions have remained pretty consistent too
> > > (of cource, not with this patch, which is mostly an RFC) - fchmod() and fchown()
> > > refuse O_PATH fds while the at() counterparts accept them. Did all these suddenly
> > > change overnight?
> > > 
> > > > If you want to perform read/write like operations you need a proper file
> > > > descriptor for that and not continue to expand the meaning of O_PATH
> > > > until it is indistinguishable from a regular file descriptor.
> > > 
> > > I definitely agree. But xattr is metadata, not data. listxattr() does not even
> > > do any POSIX permission check...
> > 
> > 
> > That it's metadata is an interesting difference but really not that
> > important. Plus, the manpage also doesn't care about this distinction.
> > Ownership and mode changes are bad enough, setting and getting random
> > xattrs seems like a terrible idea.
> > 
> > If I sent an O_PATH file descriptor around today in a sandbox without
> > procfs mounted then I know no one can suddenly set posix acls using that
> > file descriptor. With this change they suddenly can.
> > 
> > This won't be enabled.
> 
> OK, so I see the previous discussions now:
> 
> https://lore.kernel.org/all/20220622025715.upflevvao3ttaekj@senku/
> 
> > Since the current functionality cannot be retroactively disabled as it
> > is being used already through /proc/self/fd/$n, adding *xattrat(AT_EMPTY_PATH)
> > doesn't really change what is currently possible by userspace.
> >
> > I would say we should add *xattrat(2) and then we can add an upgrade
> > mask blocking it (and other operations) later.
> 
> I suppose some of these points shifted over the years, which is also fine.
> It's unfortunate though that the commit message would remain misleading forever.

I'm tempted to do some light-hearted trolling. I always marvel at the
precise and detailed systemd commit and merge messages. ;)

On a serious note, we often have stuff in commit messages that doesn't
age well. That's just a fact of development.

