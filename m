Return-Path: <linux-fsdevel+bounces-29818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011B97E519
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 05:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA2C1C21183
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 03:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA2C13D;
	Mon, 23 Sep 2024 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RJzk2GuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F38BE5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063257; cv=none; b=jkfXePuPK2lmcyJc8nnSUMznNoSyZjhChiwwHNPsgz6DVH8n0JoKRASfW9uUF87jvwrH1sDk/Hm0mr7Xvbl6H7JJz0IiHo6k8gltcldYjsSgUZqxZABDfLo56te1N8uYievVh9wPYNzjeUs+x7xuUqxkhOAvMKx4J2JG5F/4D9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063257; c=relaxed/simple;
	bh=Sv/jD0fZCSwkcUwFZdGymClVqS4fpXg6kENcSrpO3ig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pXv4vqFozehx032tYn8uGMK3kDZcInrWe2wMvcbAtyDeH/YhrTxXImgCk31ru4KDBLZROQdoHyvu1G3lM4VRzUVQ5j6YJxn6mkuIQiYqoIeLltjVp2bOvuwxAQCf4p4d2W6YgPBYNPNtTziMPTjZ2MD6fn6SJKbuHzD9yGV/n3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RJzk2GuE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9pCDagEez+9lI4kdXZalDF4XXF5uPrfqKLYWacXGsVQ=; b=RJzk2GuEwjYuKQRcT5tboI6f9e
	dzG5vu7bQHvFI0rXN6ZT0IC3dxofmg6zl43Rn5RP0WkeM0stiMR98N5mMIpP9T7A7+Ay9c2L3LP2m
	LXODTTN8q/t6BtY3n30RpoM3ze4BlEsUZTHnhAFxpyS4xWEp4M1M/SO2RGwrQEBRL7w7LP2Yrb+cF
	drxvy2RBQ+qqSgABOYk0UqYGb8M1QqpMoAb7N81owTI7QorrYW07v03DagB1pZRe0+fyYi0B4jPj7
	l202fGeOxCIsUmY20bt3h9wUP7BJnaH/LcNowYTWIJxAtEePKAQOXoI8dm2Wh2Cg85nKQePqOpVTY
	MabV5QEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ssa2t-0000000EmYj-3zrw;
	Mon, 23 Sep 2024 03:47:31 +0000
Date: Mon, 23 Sep 2024 04:47:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] struct fd layout changes
Message-ID: <20240923034731.GF3413968@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Just the layout change and conversion to accessors (invariable
branch in vfs.git#stable-struct_fd).

	One textual conflict (fs/coda/inode.c, resolved by using the current
mainline variant) and two conflicts that are not caught by merge - one in
fs/namespace.c, another - fs/xfs/xfs_exchrange.c; both resolved by replacing
if (!f.file) with if (fd_empty(f)) and other f.file with fd_file(f).

	Proposed conflict resolution in 
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #merge-candidate

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-stable-struct_fd

for you to fetch changes up to de12c3391bce10504c0e7bd767516c74110cfce1:

  add struct fd constructors, get rid of __to_fd() (2024-08-12 22:01:15 -0400)

----------------------------------------------------------------
struct fd layout change (and conversion to accessor helpers)

----------------------------------------------------------------
Al Viro (3):
      introduce fd_file(), convert all accessors to it.
      struct fd: representation change
      add struct fd constructors, get rid of __to_fd()

 arch/alpha/kernel/osf_sys.c                |   4 +-
 arch/arm/kernel/sys_oabi-compat.c          |  10 +--
 arch/powerpc/kvm/book3s_64_vio.c           |   4 +-
 arch/powerpc/kvm/powerpc.c                 |  12 +--
 arch/powerpc/platforms/cell/spu_syscalls.c |   8 +-
 arch/x86/kernel/cpu/sgx/main.c             |   4 +-
 arch/x86/kvm/svm/sev.c                     |  16 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |   8 +-
 drivers/gpu/drm/drm_syncobj.c              |   6 +-
 drivers/infiniband/core/ucma.c             |   6 +-
 drivers/infiniband/core/uverbs_cmd.c       |  10 +--
 drivers/media/mc/mc-request.c              |   6 +-
 drivers/media/rc/lirc_dev.c                |   8 +-
 drivers/vfio/group.c                       |   6 +-
 drivers/vfio/virqfd.c                      |   6 +-
 drivers/virt/acrn/irqfd.c                  |   6 +-
 drivers/xen/privcmd.c                      |  10 +--
 fs/btrfs/ioctl.c                           |   4 +-
 fs/coda/inode.c                            |   4 +-
 fs/eventfd.c                               |   4 +-
 fs/eventpoll.c                             |  30 ++++----
 fs/ext4/ioctl.c                            |   6 +-
 fs/f2fs/file.c                             |   6 +-
 fs/fcntl.c                                 |  38 +++++-----
 fs/fhandle.c                               |   4 +-
 fs/file.c                                  |  26 +++----
 fs/fsopen.c                                |   6 +-
 fs/fuse/dev.c                              |   6 +-
 fs/ioctl.c                                 |  30 ++++----
 fs/kernel_read_file.c                      |   4 +-
 fs/locks.c                                 |  14 ++--
 fs/namei.c                                 |  10 +--
 fs/namespace.c                             |  12 +--
 fs/notify/fanotify/fanotify_user.c         |  12 +--
 fs/notify/inotify/inotify_user.c           |  12 +--
 fs/ocfs2/cluster/heartbeat.c               |   6 +-
 fs/open.c                                  |  24 +++---
 fs/overlayfs/file.c                        |  68 +++++++++--------
 fs/quota/quota.c                           |   8 +-
 fs/read_write.c                            | 118 ++++++++++++++---------------
 fs/readdir.c                               |  20 ++---
 fs/remap_range.c                           |   2 +-
 fs/select.c                                |   8 +-
 fs/signalfd.c                              |   6 +-
 fs/smb/client/ioctl.c                      |   8 +-
 fs/splice.c                                |  22 +++---
 fs/stat.c                                  |   8 +-
 fs/statfs.c                                |   4 +-
 fs/sync.c                                  |  14 ++--
 fs/timerfd.c                               |   8 +-
 fs/utimes.c                                |   4 +-
 fs/xattr.c                                 |  36 ++++-----
 fs/xfs/xfs_exchrange.c                     |   4 +-
 fs/xfs/xfs_handle.c                        |   6 +-
 fs/xfs/xfs_ioctl.c                         |  28 +++----
 include/linux/cleanup.h                    |   2 +-
 include/linux/file.h                       |  53 ++++++-------
 io_uring/sqpoll.c                          |  10 +--
 ipc/mqueue.c                               |  50 ++++++------
 kernel/bpf/bpf_inode_storage.c             |  14 ++--
 kernel/bpf/btf.c                           |   6 +-
 kernel/bpf/syscall.c                       |  42 +++++-----
 kernel/bpf/token.c                         |  10 +--
 kernel/cgroup/cgroup.c                     |   4 +-
 kernel/events/core.c                       |  14 ++--
 kernel/module/main.c                       |   2 +-
 kernel/nsproxy.c                           |  12 +--
 kernel/pid.c                               |  10 +--
 kernel/signal.c                            |   6 +-
 kernel/sys.c                               |  10 +--
 kernel/taskstats.c                         |   4 +-
 kernel/watch_queue.c                       |   4 +-
 mm/fadvise.c                               |   4 +-
 mm/filemap.c                               |   6 +-
 mm/memcontrol-v1.c                         |  12 +--
 mm/readahead.c                             |  10 +--
 net/core/net_namespace.c                   |   6 +-
 net/socket.c                               |  14 ++--
 security/integrity/ima/ima_main.c          |   4 +-
 security/landlock/syscalls.c               |  22 +++---
 security/loadpin/loadpin.c                 |   4 +-
 sound/core/pcm_native.c                    |   6 +-
 virt/kvm/eventfd.c                         |   6 +-
 virt/kvm/vfio.c                            |   8 +-
 84 files changed, 559 insertions(+), 556 deletions(-)

