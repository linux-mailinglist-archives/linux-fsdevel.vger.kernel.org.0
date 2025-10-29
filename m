Return-Path: <linux-fsdevel+bounces-65980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEAC17924
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9699A4E1FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B782D028A;
	Wed, 29 Oct 2025 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUMGscVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F073A1CD;
	Wed, 29 Oct 2025 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698354; cv=none; b=U9Udg8FdVLediAJ9soxVVEL/p0Rsh9a/jNYKckb++PD2DW5Xd6wdJUsVCAw+8Si3q9Xqp7+w6QEEnruled/Pn1uPVl9m5XAzSL6Mh/ZjW9SSFXDhHuPirQyqR8YqA7oJYUOzeEaKJ2FmB0K5/mxIUjmuJGDvR3Ibmj6qeJbcVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698354; c=relaxed/simple;
	bh=0Gj5nLbrERJqoY7X0WsDX57UjQ1XBnV+oDmvw1vrYz0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDmW3yIZINKdhQrk/3hVRPbepFJr62ogxKUFVWbnMKbjP/oiTn2KwlpQurorgbfgGCiKOBHCuJv1xdpNIiAiUsOZFoTtKQlpiBYPU2lS0mtdLs0DEMaTvQ/5qnkMyENwoei3TLwHS2zIG8iD1sX2wwQZ9vFH8/giThfGfmz75Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUMGscVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39699C4CEE7;
	Wed, 29 Oct 2025 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698354;
	bh=0Gj5nLbrERJqoY7X0WsDX57UjQ1XBnV+oDmvw1vrYz0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bUMGscVgCgMfv7QA2dJQ5w3hQXec9G9YEBWoQmTT0psrTIwIcQ4sgjpGxevEH81f9
	 AQdwZig8u3lLvOVWGFCiOrqCELU/gKxKpoP9YG409pEsOT4ilOjdbdMEnzG4bMqhnn
	 SA0gZqcxnq9O8XuEzMvm8qmc+n2na7JZBO3bdBeqtqfOSgEZrOIiBNWa4csUxjVhq4
	 37c4Nl+oNLYoE+9NjDfGuRkLoCt1YDEh3iy24cZeQEetRKvDPtMSkyH95ryY24b3OT
	 x0fUX/JQvAJtLVTWNd+mU/e3dRRnfI8KqNxut4O/FU1pLiPtQ6wHJB+lj2XZjzAQaH
	 +SrmtQBrdiN1g==
Date: Tue, 28 Oct 2025 17:39:13 -0700
Subject: [PATCHSET v6 6/8] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
In-Reply-To: <20251029002755.GK6174@frogsfrogsfrogs>
References: <20251029002755.GK6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * fuse: enable caching of timestamps
 * fuse: force a ctime update after a fileattr_set call when in iomap mode
 * fuse: allow local filesystems to set some VFS iflags
 * fuse_trace: allow local filesystems to set some VFS iflags
 * fuse: cache atime when in iomap mode
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
 * fuse: always cache ACLs when using iomap
---
 fs/fuse/fuse_i.h          |    1 +
 fs/fuse/fuse_trace.h      |   87 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |    8 ++++
 fs/fuse/acl.c             |   29 +++++++++++++--
 fs/fuse/dir.c             |   38 ++++++++++++++++----
 fs/fuse/file.c            |   18 ++++++---
 fs/fuse/file_iomap.c      |    6 +++
 fs/fuse/inode.c           |   27 +++++++++++---
 fs/fuse/ioctl.c           |   68 +++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c         |    3 +-
 10 files changed, 261 insertions(+), 24 deletions(-)


