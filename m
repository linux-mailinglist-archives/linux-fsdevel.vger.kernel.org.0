Return-Path: <linux-fsdevel+bounces-26580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4495A8B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB551C21EBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BE4405;
	Thu, 22 Aug 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eCSjSdcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D115A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286016; cv=none; b=DEBN8mGa09mryi3CidoO6jTIgCKeFBYMFjOfKsxiKEE55BlvxTGJUe70HEJ0lOAbeSiU0TEspKMVWZY2mPKdjvOEyeJjQUoMME7z71jt/xybTZZQtUnU4gLfQk+UuN896ZptCi+jrrOpox6sQZ9UC1xXYcPd4wjwd3khibPZkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286016; c=relaxed/simple;
	bh=0WVVoSSOd1km+/C1UeTllxRoa8k/APE+U6bHa8Y5g/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LyGtf4ixPZ9cUR0p68LO/xaHDj6zNuT+H/yS58kBW9kl8x5jWShZtax+m8YsalGd7+joWcyZMkUE5wu1bQ3w/vWuXLHU/PETiPO4xJiUAsIWuBK6dtayXEDfHP8V+dtyjzQIa+bnabCx110cytLW7jcBxbEs3jKvzTCV2r8WXTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eCSjSdcK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wLY7/k2dfP6+usyIVedJCWqrzVRxA2BLP23fiOnSJLc=; b=eCSjSdcK554ZiutpECDZRwpvHi
	2sg3UCTDPERyT4ycgACHdiZ7pa4qy8ylY1ZXz+tJqfASaupzrPebbpDx49V8TfVK9vLs/5v02EVlV
	2Bp/Az6UhdR1knL4I/+9fJeedt8fKgnEWGzv3Ylv1BC03dyvtplwcAkdzEpUAd79EY6LjppPmyWbk
	0DwNX4/xtU8h88Sc/1vjV+yhAHoMgwFBIfZtFuU4vzkVOUhzVnCU9njTCPWnlGO9IjYadM/HPxovB
	dzV26BbUFWMOzYT9toKSl6Co/OPpsRpA+GAYMPn/1PKhxuohaeZ4BvRK8+nCBiM0FoC/CwrtVLtSB
	zLjzTkIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvYi-00000003w4c-3yMy;
	Thu, 22 Aug 2024 00:20:13 +0000
Date: Thu, 22 Aug 2024 01:20:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCHES] fdtable series v2
Message-ID: <20240822002012.GM504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	close_range() fix added in the beginning of the series,
dup_fd() calling convention change folded into it (as requested
by Linus), the rest rebased on top of that.
	sane_fdtable_size() change is dropped, as it's obsoleted
by close_range() fix.  Several patches added at the end of
series.

	Same branch -
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fdtable
individual patches in followups.  If nobody objects, I'm adding that
pile to #for-next

Shortlog:

Al Viro (9):
      close_range(): fix the logics in descriptor table trimming
      get rid of ...lookup...fdget_rcu() family
      remove pointless includes of <linux/fdtable.h>
      close_files(): don't bother with xchg()
      move close_range(2) into fs/file.c, fold __close_range() into it
      alloc_fdtable(): change calling conventions.
      file.c: merge __{set,clear}_close_on_exec()
      make __set_open_fd() set cloexec state as well
      expand_files(): simplify calling conventions

Yu Ma (3):
      fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
      fs/file.c: conditionally clear full_fds
      fs/file.c: add fast path in find_next_fd()

Diffstat:
 arch/powerpc/platforms/cell/spufs/coredump.c |   4 +-
 fs/fcntl.c                                   |   1 -
 fs/file.c                                    | 291 ++++++++++-----------------
 fs/file_table.c                              |   1 -
 fs/gfs2/glock.c                              |  12 +-
 fs/notify/dnotify/dnotify.c                  |   5 +-
 fs/notify/fanotify/fanotify.c                |   1 -
 fs/notify/fanotify/fanotify_user.c           |   1 -
 fs/open.c                                    |  17 --
 fs/overlayfs/copy_up.c                       |   1 -
 fs/proc/base.c                               |   1 -
 fs/proc/fd.c                                 |  12 +-
 include/linux/fdtable.h                      |  13 +-
 include/linux/file.h                         |   1 +
 io_uring/io_uring.c                          |   1 -
 kernel/bpf/bpf_inode_storage.c               |   1 -
 kernel/bpf/bpf_task_storage.c                |   1 -
 kernel/bpf/task_iter.c                       |   6 +-
 kernel/bpf/token.c                           |   1 -
 kernel/exit.c                                |   1 -
 kernel/fork.c                                |  32 ++-
 kernel/kcmp.c                                |   4 +-
 kernel/module/dups.c                         |   1 -
 kernel/module/kmod.c                         |   1 -
 kernel/umh.c                                 |   1 -
 net/handshake/request.c                      |   1 -
 security/apparmor/domain.c                   |   1 -
 27 files changed, 136 insertions(+), 277 deletions(-)

