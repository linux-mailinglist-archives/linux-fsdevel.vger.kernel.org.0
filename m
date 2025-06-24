Return-Path: <linux-fsdevel+bounces-52789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B2AE6B57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C5817BA29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD42E6D21;
	Tue, 24 Jun 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEjxx5l8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A832DCBF6;
	Tue, 24 Jun 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778614; cv=none; b=faIw+xCON5L9P38rxnRexTVzM+9iPgYwyjf2/uzRyUbe835nULs5hGK9KPHsWHAh91UeKgwlgm3ISYjolyyBIZhPY83sXF5Fp/Li7GEDqdv+WfOvkbebhMx2VZgnz2VbtmDqWrlWpYOZuUEj/XDC4MNl+FD3cGbWfpYMFiNVpQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778614; c=relaxed/simple;
	bh=a+seGXrhPW0GahtwOj0yhRGKclunqYWrymMbDOhiSmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAz6ORID7uzfrIylcENrGIAhtIMYpqOyCmnZMfW/73D1CwwdUBgAphCjKziVAo2zteOEjJgMGCtsctzUbax/8QpB65E1zuUVYnvpOA3DSrNUnRic+1P1nMREuRa8xqjhvwqsVQAOd7GnUnp0brTi8quLowvF19oVHEpTxEv4leY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEjxx5l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7208EC4CEE3;
	Tue, 24 Jun 2025 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750778614;
	bh=a+seGXrhPW0GahtwOj0yhRGKclunqYWrymMbDOhiSmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEjxx5l8hW4pZwn4YZrH8EyQn4Ls/3VMy0UAVdZgGVojHw/j9BOR9sghplOlzBIJi
	 0+m84A1987Ege1xLzj9KltGS89T+DtOHc4Ih0QvsXqFCJgEL8cyfQWYyCn97gkdkYm
	 08r60/gHVVfhW5kSm2PY3yw23oQndTXq3R6tuJYB7hvbZqGR8FuGczvSRYYC+D3KWg
	 UsBDl18q4MRdMgMvChxBFxeSITGb9dlKMia8aoLKVU2o6OJ88FYjXiNBvaMDbmsSpe
	 7awPWW5hJMigaEWiXoZ4PCwH7vowNV9V3EEAgOnc99QBo2AfAPdu/ikvKdOjNbnJsL
	 aoW8WQWDXUIfQ==
Date: Tue, 24 Jun 2025 17:23:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250624-dankt-ruhekissen-896ff2e32821@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
 <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
 <20250624-reinreden-museen-5b07804eaffe@brauner>
 <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bqxxnyjefp5u3dzl"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>


--bqxxnyjefp5u3dzl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 24, 2025 at 05:07:59PM +0200, Amir Goldstein wrote:
> On Tue, Jun 24, 2025 at 4:51 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> > > On Tue, Jun 24, 2025 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 11:30 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > > > use-case to support opening files purely based on the handle without
> > > > > > having to require a file descriptor to another object. That's especially
> > > > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > > > zero relationship between the objects. Such filesystems are also
> > > > > > singletons that stay around for the lifetime of the system meaning that
> > > > > > they can be uniquely identified and accessed purely based on the file
> > > > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > > > object needlessly especially if they can't do that for whatever reason.
> > > > > >
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > ---
> > > > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > > > >  fs/pidfs.c   |  5 ++++-
> > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > > > index ab4891925b52..54081e19f594 100644
> > > > > > --- a/fs/fhandle.c
> > > > > > +++ b/fs/fhandle.c
> > > > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> > > > > >       return err;
> > > > > >  }
> > > > > >
> > > > > > -static int get_path_anchor(int fd, struct path *root)
> > > > > > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> > > > > >  {
> > > > > >       if (fd >= 0) {
> > > > > >               CLASS(fd, f)(fd);
> > > > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
> > > > > >               return 0;
> > > > > >       }
> > > > > >
> > > > > > +     /*
> > > > > > +      * Only autonomous handles can be decoded without a file
> > > > > > +      * descriptor.
> > > > > > +      */
> > > > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > > +             return -EOPNOTSUPP;
> > > > >
> > > > > This somewhat ties to my comment to patch 5 that if someone passed invalid
> > > > > fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> > > > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> > > > > much about it so feel free to ignore me but I think the following might be
> > > > > more sensible error codes:
> > > > >
> > > > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > > > >                 if (fd == FD_INVALID)
> > > > >                         return -EOPNOTSUPP;
> > > > >                 return -EBADF;
> > > > >         }
> > > > >
> > > > >         if (fd != FD_INVALID)
> > > > >                 return -EBADF; (or -EINVAL no strong preference here)
> > > >
> > > > FWIW, I like -EBADF better.
> > > > it makes the error more descriptive and keeps the flow simple:
> > > >
> > > > +       /*
> > > > +        * Only autonomous handles can be decoded without a file
> > > > +        * descriptor and only when FD_INVALID is provided.
> > > > +        */
> > > > +       if (fd != FD_INVALID)
> > > > +               return -EBADF;
> > > > +
> > > > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > +               return -EOPNOTSUPP;
> > > >
> > >
> > > Thinking about it some more, as I am trying to address your concerns
> > > about crafting autonomous file handles by systemd, as you already
> > > decided to define a range for kernel reserved values for fd, why not,
> > > instead of requiring FD_INVALID for autonomous file handle, that we
> > > actually define a kernel fd value that translates to "the root of pidfs":
> > >
> > > +       /*
> > > +        * Autonomous handles can be decoded with a special file
> > > +        * descriptor value that describes the filesystem.
> > > +        */
> > > +       switch (fd) {
> > > +       case FD_PIDFS_ROOT:
> > > +               pidfs_get_root(root);
> > > +               break;
> > > +       default:
> > > +               return -EBADF;
> > > +       }
> > > +
> > >
> > > Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> > > and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> > > to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> > > as before (you can also keep the existing systemd code) and when you want
> > > to open file by handle you just go
> > > open_by_handle_at(FD_PIDFS, &handle, 0)
> > > and that's it.
> > >
> > > In the end, my one and only concern with autonomous file handles is that
> > > there should be a user opt-in to request them.
> > >
> > > Sorry for taking the long road to get to this simpler design.
> > > WDYT?
> >
> > And simply place FD_PIDFS_ROOT into the -10000 range?
> > Sounds good to me.
> 
> Yes.
> 
> I mean I don't expect there will be a flood of those singleton
> filesystems, but generally speaking, a unique fd constant
> to describe the root of a singleton filesystem makes sense IMO.

Agreed. See the appended updated patches. I'm not resending completely.
I just dropped other patches.

--bqxxnyjefp5u3dzl
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-uapi-fcntl-add-FD_PIDFS_ROOT.patch"

From 3941e37f62fe2c3c8b8675c12183185f20450539 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 16:57:51 +0200
Subject: [PATCH 1/2] uapi/fcntl: add FD_PIDFS_ROOT

Add a special file descriptor indicating the root of the pidfs
filesystem.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index a5bebe7c4400..f291ab4f94eb 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -110,6 +110,7 @@
 #define PIDFD_SELF_THREAD		-10000 /* Current thread. */
 #define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
 
+#define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
 #define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
-- 
2.47.2


--bqxxnyjefp5u3dzl
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0002-fhandle-pidfs-support-open_by_handle_at-purely-based.patch"

From b95361481b1e5bd3627835b7e4b921d5a09e68a4 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:13 +0200
Subject: [PATCH 2/2] fhandle, pidfs: support open_by_handle_at() purely based
 on file handle

Various filesystems such as pidfs (and likely drm in the future) have a
use-case to support opening files purely based on the handle without
having to require a file descriptor to another object. That's especially
the case for filesystems that don't do any lookup whatsoever and there's
zero relationship between the objects. Such filesystems are also
singletons that stay around for the lifetime of the system meaning that
they can be uniquely identified and accessed purely based on the file
handle type. Enable that so that userspace doesn't have to allocate an
object needlessly especially if they can't do that for whatever reason.

Link: https://lore.kernel.org/20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 9ef35f8e8989..b1363ead6c5e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -188,6 +188,11 @@ static int get_path_anchor(int fd, struct path *root)
 		return 0;
 	}
 
+	if (fd == FD_PIDFS_ROOT) {
+		pidfs_get_root(root);
+		return 0;
+	}
+
 	return -EBADF;
 }
 
-- 
2.47.2


--bqxxnyjefp5u3dzl--

