Return-Path: <linux-fsdevel+bounces-68959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A01E2C6A6C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B45E035255C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E233587A1;
	Tue, 18 Nov 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mk9TBIFO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF2021FF25
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480978; cv=none; b=UHLNeJErAgKS1eSg+uNWYEMOQkO0dcROnptpxMpwom2kQgjez00/6g9RPV+VPqqTtkHZNis/JS+yu4yL3K/SoAYk8gPEGHqIVbbp+Jg5EjPZlF+97ZdlGPHuT+wZhivbd5Qr9ij5eIT3EMTNQRG84vENopn8tP3lbtPxxBJROn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480978; c=relaxed/simple;
	bh=Pl9ndB1Hzxig78Gp8xcHs2aJ7D3UOYiI+1jyXX5hrz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gi5M7l5q5WrbTanpehFxNS7ae4G9p86djGAXEZrBl/uFL2k1PVCgV1bcHbttMwlHSbVJ/5a6DhsKwFVuQ/qtBDYHg/9lN1HtWdqt9BGS7mfV0kesC6w/yY4HvSoOsiRd0fPyzvvvn5kTdfs58gfaIcGzQ6buqIp89VHv0R491Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mk9TBIFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3025EC2BCC4;
	Tue, 18 Nov 2025 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480977;
	bh=Pl9ndB1Hzxig78Gp8xcHs2aJ7D3UOYiI+1jyXX5hrz8=;
	h=From:Subject:Date:To:Cc:From;
	b=Mk9TBIFOdvG4PiozbjqM0vdUcZRDfiMotht2U5XTxeRcO4v2dO9jcVRwwv7Nv6u0e
	 9GepMpSMGwhOIkZ2PsZbAgw1bhIJSYhxuqmox0HWg8upihIxdN1pTYPKmeUrkMknvS
	 eI7wIUVUdJ8PjwgrzIUgtnNsXsEBWRUHWRIkeQdwRet15+gCWa7lhF2FwFqZRSwdjf
	 rIahjhxEKwV/vk4zCDZM4UEPEt5/BuMqP5X+WsBXkQrAYZ1ygOQu18Pk2TR/pg23UX
	 mB7d0khDQVxxXYoL5vO6kWoR1khfGsdDiNr2U/WKK3IFlbOwaP4BxjpZvU+J0PdIYj
	 Ckos/T6P5BaYQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH DRAFT RFC UNTESTED 00/18] file: FD_PREPARE()
Date: Tue, 18 Nov 2025 16:48:40 +0100
Message-Id: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFiVHGkC/y2Nyw6CMBBFf6WZtUWLkhh3hsfSBeLKuGjpFCYmh
 Ux9JYR/txiX93XuBAGZMMBBTMD4okCDj0KtBLS99h1KslFDukkzpdRevge+S2flyDhqRul2KtN
 b4zJnNcRV9B19fsQrFPWxakRd5eJyaspzUxZwix2jA0rD2rf9wh6YOvKyo0f/NOslTJaXxNnk/
 wLz/AViSrjcqgAAAA==
X-Change-ID: 20251118-work-fd-prepare-f415a3bf5fda
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3744; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Pl9ndB1Hzxig78Gp8xcHs2aJ7D3UOYiI+1jyXX5hrz8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO3TZom9enr7nFuKm/Zb37pS8WBnecn9gh6tRjeFI
 l02tTi5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkUKjL89/1zMXPtmcKX11a6
 i6TlStgt7hSU483ZOLvoyeY8BcHATwz/DA8k16ZceLenpl9L1nkTv8yk4OkGiudybmrq7H7lefA
 YLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I've been playing with an idea to allow for some flexible usage of the
get_unused_fd_flags() + create file + fd_install() pattern that's used
quite extensively.

How callers allocate files is really heterogenous so it's not really
convenient to fold them into a single class. It's possibe to split them
into subclasses like for anon inodes. I think that's not necessarily
nice as well so my take is:

FD_PREPARE(fdprep, open_flag, file_open_handle(&path, open_flag));
if (fd_prepare_failed(fdprep))
	return fd_prepare_error(fdprep);

return fd_publish(fdprep);

or

FD_PREPARE(fdprep, 0, dentry_open(&path, hreq->oflags, cred));
dput(dentry);
if (fd_prepare_failed(fdprep))
        return fd_prepare_error(fdprep);

if (S_ISREG(inode->i_mode)) {
        struct file *filp = fd_prepare_file(fdprep);

        filp->f_flags |= O_NOATIME;
        filp->f_mode |= FMODE_NOCMTIME;
}

return fd_publish(fdprep);

That's somewhat akin to how we use wait_event() to allow for arbitrary
things to be used as a condition in it. Here we obviously expect the
function to return a struct file.

It's centered around struct fd_prepare { int fd; struct file *file; }.
FD_PREPARE() encapsulates all of allocation and cleanup logic and must
be followed by a call to fd_publish() which consumes the fd and file
otherwise they're deallocated.

It mandates a specific order for fd and file allocation which should be
fine I think.

We won't be able to convert everything to it but most cases can be made
to work with this pattern allowing to shed a bunch of cleanup code on
the way. To me it looks like it simplifies a bunch of code but it
obviously has assumptions, e.g., that it may freely consume the
reference by the file passed to it. I didn't see this as a big issue
though.

There's room for extending this in a way that you'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

I've converted a about 17 callers to see that they can be folded into
this pattern.

I'd like to gather early feedback. It's a draft, haven't compiled it or
tested it. Just played around with this today and thought I'd better get
yelled at early.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (18):
      file: add FD_PREPARE()
      fs: anon_inodes
      fs: eventfd
      fs: fhandle
      fs: open_tree()
      fs: namespace
      fs: fanotify
      fs: nsfs
      fs: autofs
      fs: eventpoll
      fs: open_tree_attr()
      fs: nsfs2
      fs: open
      fs: signalfd64
      fs: timerfd
      fs: userfaultfd
      fs: xfs
      drivers: drm_lease

 drivers/gpu/drm/drm_lease.c        |  44 ++++--------
 fs/anon_inodes.c                   |  26 ++-----
 fs/autofs/dev-ioctl.c              |  32 +++------
 fs/eventfd.c                       |  32 ++++-----
 fs/eventpoll.c                     |  33 +++------
 fs/fhandle.c                       |  30 ++++----
 fs/namespace.c                     |  87 ++++++++---------------
 fs/notify/fanotify/fanotify_user.c |  19 ++---
 fs/nsfs.c                          |  48 +++++--------
 fs/open.c                          |  18 ++---
 fs/signalfd.c                      |  28 +++-----
 fs/timerfd.c                       |  28 +++-----
 fs/userfaultfd.c                   |  29 +++-----
 fs/xfs/xfs_handle.c                |  22 ++----
 include/linux/cleanup.h            |  22 ++++++
 include/linux/file.h               | 137 +++++++++++++++++++++++++++++++++++++
 16 files changed, 321 insertions(+), 314 deletions(-)
---
base-commit: a71e4f103aed69e7a11ea913312726bb194c76ee
change-id: 20251118-work-fd-prepare-f415a3bf5fda


