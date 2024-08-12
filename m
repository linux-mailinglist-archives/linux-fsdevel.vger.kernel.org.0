Return-Path: <linux-fsdevel+bounces-25634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95294E6EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491FB1C21A9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3614F14F9DC;
	Mon, 12 Aug 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WI40beOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E514F9CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444939; cv=none; b=R2te5mv9iRQFK2YTXA6IoSnl0XMTQFRpzYyLgjP1HHpPKhUyAth3fWlo4DWZHBGo9F7LxWKgGSOJUggZRS7o5ACF2Pta0lhot2xoR02Z9TRFEGF5nzLLsyVFm20jem24qVXP4ljselLoQjzEn1i4gFBG6aXDzO0q/hC3UFKy5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444939; c=relaxed/simple;
	bh=FzioMDXI7UqBG1e1GjwRqNw0+o5ViuQ4KbnDQa0Ltbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m543nK8BME1t6n13QA45I+WUGEubWr9cVnRRIjZNZTdG7ofRIHKYUwziWlxBT3H0j16P96XKDfAJQF1res/DV7kvztHt/P4VjHb6CcUMYxLWCCH/ZVa++10akx+PTd0zDIV9iJJHwZPmWXkT2IeU/HVFVBP6/6zfqs8+UGnyVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WI40beOb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9DQd6kYY+EzRR2epFy5oprtTJphDc03M9a272nQMMJk=; b=WI40beObA6bgpQiWGLo1T1PBJq
	TQoPI50oRbWQAL/Y9pTiA9HEAAJaHwEMW6KqznxidwsHVQJt/LtSjvjdswQPCKMOUTA5QDla9aYf9
	WMoCbx3g1hbRMyYPYNBpMVBq/oIyjF8f9Z9JD+GEA1TJfH5i7ShLuwejqO8jEmuF8/rplD3VTtmT3
	76yrLGfDgDkSeNJ7f6pWhndoKxQXpD76kVO2t6j4pocPCiIAC7/TqUa7llDSKOEABO/MEv+PZ4TRp
	W2bk0mRmt+Io2mtVS4rI2as8kmxLEuuUF7iJE0acXUEbFpggKMAoIpP02qjPKyd/F3D14Ycaa827B
	divSbrCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOkw-000000010RN-2qhy;
	Mon, 12 Aug 2024 06:42:14 +0000
Date: Mon, 12 Aug 2024 07:42:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCHES] fs/file.c stuff
Message-ID: <20240812064214.GH13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Assorted cleanups, part from the previous cycle, part new.
Branch is in git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git #work.fdtable
Individual patches in followups.

	Appears to work; if nobody objects, into -next it goes...

Shortlog:
Al Viro (8):
      get rid of ...lookup...fdget_rcu() family
      remove pointless includes of <linux/fdtable.h>
      close_files(): don't bother with xchg()
      proc_fd_getattr(): don't bother with S_ISDIR() check
      move close_range(2) into fs/file.c, fold __close_range() into it
      sane_fdtable_size(): don't bother looking at descriptors we are not going to copy
      alloc_fdtable(): change calling conventions.
      dup_fd(): change calling conventions

Yu Ma (3):
      fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
      fs/file.c: conditionally clear full_fds
      fs/file.c: add fast path in find_next_fd()

Diffstat:
 arch/powerpc/platforms/cell/spufs/coredump.c |   4 +-
 fs/fcntl.c                                   |   1 -
 fs/file.c                                    | 195 +++++++++++----------------
 fs/file_table.c                              |   1 -
 fs/gfs2/glock.c                              |  12 +-
 fs/notify/dnotify/dnotify.c                  |   5 +-
 fs/notify/fanotify/fanotify.c                |   1 -
 fs/notify/fanotify/fanotify_user.c           |   1 -
 fs/open.c                                    |  17 ---
 fs/overlayfs/copy_up.c                       |   1 -
 fs/proc/base.c                               |   1 -
 fs/proc/fd.c                                 |  23 +---
 include/linux/fdtable.h                      |   7 +-
 include/linux/file.h                         |   1 +
 io_uring/io_uring.c                          |   1 -
 kernel/bpf/bpf_inode_storage.c               |   1 -
 kernel/bpf/bpf_task_storage.c                |   1 -
 kernel/bpf/task_iter.c                       |   6 +-
 kernel/bpf/token.c                           |   1 -
 kernel/exit.c                                |   1 -
 kernel/fork.c                                |  26 ++--
 kernel/kcmp.c                                |   4 +-
 kernel/module/dups.c                         |   1 -
 kernel/module/kmod.c                         |   1 -
 kernel/umh.c                                 |   1 -
 net/handshake/request.c                      |   1 -
 security/apparmor/domain.c                   |   1 -
 27 files changed, 104 insertions(+), 212 deletions(-)


