Return-Path: <linux-fsdevel+bounces-50245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FBAC96CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A223ACCC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB74321ABAE;
	Fri, 30 May 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OYl3Y3gX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9F1C8638
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748638597; cv=none; b=t3TjEvno95F/cK1sPCw2qvjY6xQMZsefqeWyW7TLsL5TZgmaFzA24sRe4g9L3rnzQt53Vc+37C8Y9kVFg+mE4w6kYRfoiygrF8ml3DAD0HnppcSPjfBE12M6FZbjFE13F3L2ssMT587KBpdfMoo243uTt5ebJ6p1fgGWmQ8H7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748638597; c=relaxed/simple;
	bh=aTMZOoEonO6Reh8/a9H2cF5EpK+6MF06CgxI9S7d5PU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s9qCLG55rJRnG4E51rPthywFZHxPdXf2VYim+tGo/YyWqOwE8/RXEQdaVceM7bMH5z/jfvieBzKKCE1bsNOdFqxlcFA2fB6wEJWZp6hybr4SKSIfgF2K4OL+bO7/bZ+exrWmlcETpdpwVbhPG7MQh/I2ZFlW+xvJ2gx+uCcUwL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OYl3Y3gX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=j+ZyF493nKzVKuPrM4d400cja4iHVOdXy45r/oWWXqs=; b=OYl3Y3gXyIkmn5fQnJ0v73q8LR
	UXPQWorvoEv/oBpLHEpz2Pile3+C312+qJ4GyhKXkT1bZ7l4u0HJjteJbWfz6aXCiWu/t29xdG3F4
	grGgbN9NFxIUprm40K0i8GyQwFtuOt9/8p71pWkycrWf2Zkc9VySiRczis7n5+bYRFn31Tj85IIFr
	q95SW/furOS8tFDQWqGzhVRtsRbjSDE8wfcz4NeTkaAX6HypdWGf3nYQRl+MIaMtpIsEd7PhyMDGD
	NKu3ZuTFNHmI1Wbd/TEZnRTIk6y3PHKQAAjU6vTZsCcZfSWQP74ICkCP4TXf9HTmiSQqgrscqSLaS
	cQEdquXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL6mE-0000000G4qr-0nqx;
	Fri, 30 May 2025 20:56:30 +0000
Date: Fri, 30 May 2025 21:56:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [git pull] ->d_automount() pile
Message-ID: <20250530205630.GC3574388@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Trivial conflict in Documentation/filesystems/porting.rst - a chunk added
at the end (as always), with other additions from already merged branches.

A bunch of odd boilerplate gone from instances - the reason for those was
the need to protect yet-to-be-attched mount from mark_mounts_for_expiry()
deciding to take it out.  That's easy to detect and take care about in
mark_mounts_for_expiry() itself; no need to have every instance similate
mount being busy by grabbing an extra reference to it, with finish_automount()
undoing that once it attaches that mount.  Should've done it that way from
the very beginning...  It's a flagday change, thankfully there are very few
instances.

The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-automount

for you to fetch changes up to 2dbf6e0df447d1542f8fd158b17a06d2e8ede15e:

  kill vfs_submount() (2025-05-06 12:49:07 -0400)

----------------------------------------------------------------
automount wart removal

Calling conventions of ->d_automount() made saner (flagday change)
vfs_submount() is gone - its sole remaining user (trace_automount) had
been switched to saner primitives.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      saner calling conventions for ->d_automount()
      kill vfs_submount()

 Documentation/filesystems/porting.rst |  7 +++++++
 Documentation/filesystems/vfs.rst     |  4 +---
 fs/afs/mntpt.c                        |  1 -
 fs/fuse/dir.c                         |  3 ---
 fs/namespace.c                        | 24 +++---------------------
 fs/nfs/namespace.c                    |  1 -
 fs/smb/client/namespace.c             |  1 -
 fs/super.c                            |  9 +--------
 include/linux/fs.h                    |  1 -
 include/linux/mount.h                 |  3 ---
 kernel/trace/trace.c                  | 19 +++++++++++++++----
 11 files changed, 27 insertions(+), 46 deletions(-)

