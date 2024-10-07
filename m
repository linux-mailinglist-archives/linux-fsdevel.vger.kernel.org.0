Return-Path: <linux-fsdevel+bounces-31227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA23993532
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C711C23446
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D391DD9DC;
	Mon,  7 Oct 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IgLvYfCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B41DD9DA
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322756; cv=none; b=F8D9tulLIbWPkn5AkSIghn1tiDN+rzQd+vlW/LxlJxyq1STf74VWPcLx1slgSrkzHG9xXwQcmIIp+yZabR34J9Z+NGbAqTnpFeTZJs6/3N/n7h8dhiZNgsklvXW/zQG5UUM5L+kkXv6a5qTGoo2ZYvLvdjhPNtp6OCqHYgDZoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322756; c=relaxed/simple;
	bh=Cmbl8Lta2l46ebBTmWhSQ0M+aRMaGu1qFAI4zj/yzPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9QXrrZ7xNbBfECWCCEWfDPlhQslNh4rPviXs0VAOOYKeCtMN6HEgdVG1d2mtU/CW80eM1N7l6+FTkb/YHpBlGqhGVE2N23ELMVcEvrDQiCkD5pgcEzW6b+kcZKNf5wgOX8LO6FYJSJsb/tDndxigCithCqB4OzOVmcognQBvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IgLvYfCl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wHThyUL3lQ0iDVKS9d4VM955JDHdGgEkqpWkq0vaX+c=; b=IgLvYfClsyxx7EuVHfuRceViDz
	pVSJGLLRFW4EBA0F7K6iKRw3/fG4wMJeqa4VEHP3YJ4HkHYyJ9VmrW9c+4qwTv+ejtNDamx/1H0C3
	X+zJ9ub9ZBKXiHMbTBEIVt6xJ5BLlRAWX7XiqwP7anIcNCIV2FvzhZshuHD2i9+7BoifWedrPpFKM
	fqOBTcLtai5fPioHxeYWXQM5Ehet0IqnWpKwPmxiob0S8ShbOJzbRYo+kvFVADLu5MZLkqKQXw7Wu
	hBATj0apB3duVRdf2qJkVm52x/oBG4HLQn2iAjucKq2qYO1zlmFexujqR4J2hwlSfDGE8eR3ARoCI
	0UiQzhvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrhQ-00000001eth-15Hz;
	Mon, 07 Oct 2024 17:39:12 +0000
Date: Mon, 7 Oct 2024 18:39:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCHES] fdtable series v3
Message-ID: <20241007173912.GR4017910@ZenIV>
References: <20240822002012.GM504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002012.GM504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Changes since v2:
	Rebased to 6.12-rc2, now that close_range() fix got into
mainline.  No more than that so far (there will be followup
cleanups, but for now I just want it posted and in -next).

Changes since v1:
 	close_range() fix added in the beginning of the series,
dup_fd() calling convention change folded into it (as requested
by Linus), the rest rebased on top of that.
 	sane_fdtable_size() change is dropped, as it's obsoleted
by close_range() fix.  Several patches added at the end of
series.

	Same branch -
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fdtable
individual patches in followups.

Christian, I can move that to vfs/vfs.git if that's more convenient
for you - we are about to step on each other's toes with that and
your ->f_count work.

Shortlog:

Al Viro (8):
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
 fs/file.c                                    | 204 ++++++++++-----------------
 fs/file_table.c                              |   1 -
 fs/gfs2/glock.c                              |  12 +-
 fs/notify/dnotify/dnotify.c                  |   5 +-
 fs/notify/fanotify/fanotify.c                |   1 -
 fs/notify/fanotify/fanotify_user.c           |   1 -
 fs/open.c                                    |  17 ---
 fs/overlayfs/copy_up.c                       |   1 -
 fs/proc/base.c                               |   1 -
 fs/proc/fd.c                                 |  12 +-
 include/linux/fdtable.h                      |   5 -
 include/linux/file.h                         |   1 +
 io_uring/io_uring.c                          |   1 -
 kernel/bpf/bpf_inode_storage.c               |   1 -
 kernel/bpf/bpf_task_storage.c                |   1 -
 kernel/bpf/task_iter.c                       |   6 +-
 kernel/bpf/token.c                           |   1 -
 kernel/exit.c                                |   1 -
 kernel/kcmp.c                                |   4 +-
 kernel/module/dups.c                         |   1 -
 kernel/module/kmod.c                         |   1 -
 kernel/umh.c                                 |   1 -
 net/handshake/request.c                      |   1 -
 security/apparmor/domain.c                   |   1 -
 26 files changed, 88 insertions(+), 198 deletions(-)

