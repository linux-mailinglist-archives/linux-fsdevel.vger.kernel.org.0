Return-Path: <linux-fsdevel+bounces-69279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96742C76801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84C364E21DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84D28B7D7;
	Thu, 20 Nov 2025 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Gkg9du"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81132AF1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677937; cv=none; b=jc74Oe/neTCqMuLNQFvTQfzoi+tZFzkzPi6lh7yaeWuLjWVjapuSJCbIbU5EOTq0ObUy9swlpomjzLPU3hM+5p4P/EVoyzri4xO6SlkO4TVUjcFO7pcPK0XByYwO12maRtTKp/4hjYoHp55+LfIynOWrLsys/xhhYhVbsX7JVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677937; c=relaxed/simple;
	bh=QxFIMexraG2wL1vfa/l1lWVokBp/78n2Uiv5gBw/xSc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=prNojWbanDRH1oxjyxwfA8Im48Fd8wdl226iL2h1CBTSeklRbt6HdPq6UMg198hcswqx/7cjWPXvCeVzOd4M6RQBFQ14vpcctakQaaEgQYjIanQ8KYBkcwIwPlzWn69HFgYDUQS7GhTiDDE5qMvG4drVE0midd8Te+zL6FIiEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Gkg9du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBC7C4CEF1;
	Thu, 20 Nov 2025 22:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677937;
	bh=QxFIMexraG2wL1vfa/l1lWVokBp/78n2Uiv5gBw/xSc=;
	h=From:Subject:Date:To:Cc:From;
	b=D5Gkg9dugJUWrtHT8P6OrhD4DXMbr5jD2f2BLLCYjq9xzKjdmz605XYfTyAqAHmwl
	 xynYDcYa0w0Pak2FrYXkH1L2h3/r+Mbg16+/oAGBSCbq45l2RRdj6RuJKGy0H2HX3C
	 YDBeL92mWY1oC51lg0L6j3mUR218V8+xhzUtRebDtgIKWVc9i+XnHz0p3Iybb9BNbb
	 twWyfxVCAzKziZ5aunKUDjqKvXPn7lD+V5ESeI6ouFvzINrVF4qUxQ0HvT4Q9Avgi8
	 tVicH5cXtOGkFJiICiQ6mLcXtVbqQ7UbUig+0sNDURQa79ia8yNG7WAUQC3TuSCw/I
	 U5weWO+kQ50oA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 00/48] file: add and convert to FD_PREPARE()
Date: Thu, 20 Nov 2025 23:31:57 +0100
Message-Id: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2WH2kC/3XOTQrCMBAF4KvIrJ3atAZ/VoLgAdxKF2kzaYdKI
 hOtivTupsWty/eG+XgfiCRMEfaLDwgNHDn4FIrlAprO+JaQbcpQ5IVWSm3xGaRHZ/EmdDNC6NZ
 Km7J22lkD6Sv1jl+zeIHz6QhVKmsTCWsxvukmLAi37LHle/eoV9Mxm9jM2ezHTlLH8R7kPU8b1
 Oz9XTEozLEpcp2v7W5TbvShJ/F0zYK0UI3j+AXpD3ZL6QAAAA==
X-Change-ID: 20251118-work-fd-prepare-f415a3bf5fda
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8417; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QxFIMexraG2wL1vfa/l1lWVokBp/78n2Uiv5gBw/xSc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3t9Z436qdRs1T+Gd2cuvKnz+WdQUbKveJZW/JazZ
 sulbc4wd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkSTLDX8kjrrPLFPfrPl5q
 IPDlyrt5O+Tm/SwSb7aUqHRbx/Uu7SLDP61zvi6vebTu7f35u3iZzJR9N4KqK59HX+vOvbkoLMe
 PmQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

I've been playing with this to allow for moderately flexible usage of
the get_unused_fd_flags() + create file + fd_install() pattern that's
used quite extensively.

How callers allocate files is really heterogenous so it's not really
convenient to fold them into a single class. It's possibe to split them
into subclasses like for anon inodes. I think that's not necessarily
nice as well.

My take is to add a scope-based FD_PREPARE() primitive that work as
follows:

FD_PREPARE(fdprep, open_flag, file_open_handle(&path, open_flag)) {
        if (fd_prepare_failed(fdprep))
                return fd_prepare_error(fdprep);

        return fd_publish(fdprep);
}

The scope based variant not just makes the lifetime very clear and
allows allows to easily jump over the guard without issues.

That's somewhat modeled after how we use wait_event() to allow for
arbitrary things to be used as a condition in it. Here we obviously
expect a struct file that we will own once FD_PREPARE was successful.

It's centered around struct fd_prepare. FD_PREPARE() encapsulates all of
allocation and cleanup logic and must be followed by a call to
fd_publish() which associates the fd with the file and installs it into
the callers fdtable. If fd_publish() isn't called both are deallocated.

It mandates a specific order namely that first we allocate the fd and
then instantiate the file. But that shouldn't be a problem nearly
everyone I've converted uses this exact pattern anyway.

I've converted all of the easy cases over to it and it gets rid of a lot
of convoluted cleanup logic.

There's a bunch of other cases where it would be easy to convert them to
this pattern. For example, the whole sync file stuff in dma currently
retains the containing structure of the file instead of the file itself
even though it's only used to allocate files. Changing that would make
it fall into the FD_PREPARE() pattern easily. I've not done that work
yet.

There's room for extending this in a way that wed'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

Anyway, I'm not a macro wizard per se so maybe I missed some very
obvious bugs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Make FD_PREPARE() use a separate scope.
- Convert most easy cases.
- Link to v1: https://patch.msgid.link/20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org

---
Christian Brauner (48):
      file: add FD_PREPARE()
      anon_inodes: convert __anon_inode_getfd() to FD_PREPARE()
      eventfd: convert do_eventfd() to FD_PREPARE()
      fhandle: convert do_handle_open() to FD_PREPARE()
      namespace: convert open_tree() to FD_PREPARE()
      namespace: convert open_tree_attr() to FD_PREPARE()
      namespace: convert fsmount() to FD_PREPARE()
      fanotify: convert fanotify_init() to FD_PREPARE()
      nsfs: convert open_namespace() to FD_PREPARE()
      nsfs: convert ns_ioctl() to FD_PREPARE()
      autofs: convert autofs_dev_ioctl_open_mountpoint() to FD_PREPARE()
      eventpoll: convert do_epoll_create() to FD_PREPARE()
      open: convert do_sys_openat2() to FD_PREPARE()
      signalfd: convert do_signalfd4() to FD_PREPARE()
      timerfd: convert timerfd_create() to FD_PREPARE()
      userfaultfd: convert new_userfaultfd() to FD_PREPARE()
      xfs: convert xfs_open_by_handle() to FD_PREPARE()
      drm: convert drm_mode_create_lease_ioctl() to FD_PREPARE()
      dma: convert dma_buf_fd() to FD_PREPARE()
      af_unix: convert unix_file_open() to FD_PREPARE()
      dma: convert sync_file_ioctl_merge() to FD_PREPARE()
      exec: convert begin_new_exec() to FD_PREPARE()
      ipc: convert do_mq_open() to FD_PREPARE()
      bpf: convert bpf_iter_new_fd() to FD_PREPARE()
      bpf: convert bpf_token_create() to FD_PREPARE()
      memfd: convert memfd_create() to FD_PREPARE()
      secretmem: convert memfd_secret() to FD_PREPARE()
      net/handshake: convert handshake_nl_accept_doit() to FD_PREPARE()
      net/kcm: convert kcm_ioctl() to FD_PREPARE()
      net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()
      net/socket: convert sock_map_fd() to FD_PREPARE()
      net/socket: convert __sys_accept4_file() to FD_PREPARE()
      spufs: convert spufs_context_open() to FD_PREPARE()
      papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()
      spufs: convert spufs_gang_open() to FD_PREPARE()
      pseries: convert papr_platform_dump_create_handle() to FD_PREPARE()
      pseries: port papr_rtas_setup_file_interface() to FD_PREPARE()
      dma: port sw_sync_ioctl_create_fence() to FD_PREPARE()
      gpio: convert linehandle_create() to FD_PREPARE()
      hv: convert mshv_ioctl_create_partition() to FD_PREPARE()
      media: convert media_request_alloc() to FD_PREPARE()
      ntsync: convert ntsync_obj_get_fd() to FD_PREPARE()
      tty: convert ptm_open_peer() to FD_PREPARE()
      vfio: convert vfio_group_ioctl_get_device_fd() to FD_PREPARE()
      file: convert replace_fd() to FD_PREPARE()
      io_uring: convert io_create_mock_file() to FD_PREPARE()
      kvm: convert kvm_arch_supports_gmem_init_shared() to FD_PREPARE()
      kvm: convert kvm_vcpu_ioctl_get_stats_fd() to FD_PREPARE()

 arch/powerpc/platforms/cell/spufs/inode.c          |  40 ++----
 arch/powerpc/platforms/pseries/papr-hvpipe.c       |  58 ++++-----
 .../powerpc/platforms/pseries/papr-platform-dump.c |  46 +++----
 arch/powerpc/platforms/pseries/papr-rtas-common.c  |  30 ++---
 drivers/dma-buf/dma-buf.c                          |  13 +-
 drivers/dma-buf/sw_sync.c                          |  45 +++----
 drivers/dma-buf/sync_file.c                        |  55 +++-----
 drivers/gpio/gpiolib-cdev.c                        |  48 +++----
 drivers/gpu/drm/drm_lease.c                        |  83 +++++-------
 drivers/hv/mshv_root_main.c                        |  24 ++--
 drivers/media/mc/mc-request.c                      |  35 ++---
 drivers/misc/ntsync.c                              |  19 +--
 drivers/tty/pty.c                                  |  35 ++---
 drivers/vfio/group.c                               |  27 +---
 fs/anon_inodes.c                                   |  24 +---
 fs/autofs/dev-ioctl.c                              |  31 ++---
 fs/eventfd.c                                       |  30 ++---
 fs/eventpoll.c                                     |  34 ++---
 fs/exec.c                                          |  14 +-
 fs/fhandle.c                                       |  31 ++---
 fs/file.c                                          |  24 ++--
 fs/namespace.c                                     | 123 +++++++-----------
 fs/notify/fanotify/fanotify_user.c                 |  18 +--
 fs/nsfs.c                                          |  34 ++---
 fs/open.c                                          |  20 +--
 fs/signalfd.c                                      |  26 ++--
 fs/timerfd.c                                       |  27 ++--
 fs/userfaultfd.c                                   |  32 ++---
 fs/xfs/xfs_handle.c                                |  33 ++---
 include/linux/cleanup.h                            |  32 +++++
 include/linux/file.h                               | 141 +++++++++++++++++++++
 io_uring/mock_file.c                               |  53 +++-----
 ipc/mqueue.c                                       |  40 +++---
 kernel/bpf/bpf_iter.c                              |  32 ++---
 kernel/bpf/token.c                                 |  80 +++++-------
 mm/memfd.c                                         |  30 ++---
 mm/secretmem.c                                     |  21 +--
 net/handshake/netlink.c                            |  27 ++--
 net/kcm/kcmsock.c                                  |  24 ++--
 net/sctp/socket.c                                  |  36 ++----
 net/socket.c                                       |  35 ++---
 net/unix/af_unix.c                                 |  17 +--
 virt/kvm/guest_memfd.c                             |  81 +++++-------
 virt/kvm/kvm_main.c                                |  23 ++--
 44 files changed, 737 insertions(+), 994 deletions(-)
---
base-commit: c8e00cdc7425d5c60fd1ce6e7f71e5fb1b236991
change-id: 20251118-work-fd-prepare-f415a3bf5fda


