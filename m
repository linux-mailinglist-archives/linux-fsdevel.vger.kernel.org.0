Return-Path: <linux-fsdevel+bounces-69522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0133C7E399
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23CFE347C67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242F224AFB;
	Sun, 23 Nov 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6Pl6o2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803419F40A
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915614; cv=none; b=FQoX8xPmnvaX7z4oT9YEyoU5WayHnXznuNWMc6FnPDq7QFCA835MbYJA0E8UFpH11pLiC4dj1T5AXx/DgNypzVahpvM2SaYT+F3rUdLong73wkWmq8tH9c+ePHgpylV6tdObYQnNKhXW7sP5XBOrx8QpOpOJxqdNOL354wBCYLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915614; c=relaxed/simple;
	bh=dYlZyWxCMmElIBv2LMeqyxxZZSy7qe700aPdWNfQ+pY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T85Mzb7EvSmNRJfkg1fYdO1EkLW5wMFovySulflnY6yf4haK0VDkN0LQqTsPw38D9r+6t4Yt86MdPcRR63V3IhyiydiGVL3jdumLYsD9ro23df3N9Fm1env8F0LZp9GYhvxQZ/Kw0uGlF2cUiZqnQaNTLORNHHKHNdZ1+T1XruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6Pl6o2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB7FC113D0;
	Sun, 23 Nov 2025 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915614;
	bh=dYlZyWxCMmElIBv2LMeqyxxZZSy7qe700aPdWNfQ+pY=;
	h=From:Subject:Date:To:Cc:From;
	b=K6Pl6o2DQ3ho2vACL9d8ELQIjmc8ulcKIXdyPtlG2ZH6mZEdkV9U+bi6gy7/51yzW
	 dH15eiIZsLhj8EsZv/NV+NqFMygN3viZM77mvaRn6G06mnE39BKqGnc9LmjHIeBCGq
	 PhZpqiSaYgzRWvz8XEWqLEJec+CHoo2U78kd4+aIbGSR0PJtfFuQnqvWdZ3vf943Ku
	 MIYJ0tcCORchnyLzdzw9fBc4Nfo0KgAiwJY4Z8sl2H79v1x5jhn3poXYECDsHVq1Sy
	 IRHCOAJfJlyotLLnSQG5RuLqDa4I1+qUKXzcs/T8AYp/h5uw7VGPVZyz9vKsKBNgYd
	 vK8MKreThGFcQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 00/47] file: FD_{ADD,PREPARE}()
Date: Sun, 23 Nov 2025 17:33:18 +0100
Message-Id: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE43I2kC/3XOTU7DMBAF4KtUXjPBvy1lxT0QCzseJ6MiuxqXA
 Kpyd+yKRVHE8s3ofXpXUZEJq3jeXQXjQpVKbsE+7MQ4+zwhUGxZaKmdUuoJPgufIEU4M549IyS
 rnDchuRS9aK12T/R1E1/fWg6+IgT2eZy7U5gmyjDRZf4Ij/05dHFIcfgVOzJTvRT+vq1aVKf+H
 7AokDBq6aSNx4M5uJcTcsb3ofAk+oJF3wFabgHdgIRpjyF66aLZAOYeUFvANECPe2ttVAYl/gH
 Wdf0BbT1sWWYBAAA=
X-Change-ID: 20251118-work-fd-prepare-f415a3bf5fda
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dYlZyWxCMmElIBv2LMeqyxxZZSy7qe700aPdWNfQ+pY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0fcVdv4JfbmU2XlH7KLvvzvsJrjWLf/2Pw7jgoGG
 qfl1jzn7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIPg8jw/XFrRf/C6n8Vnhm
 9PiszEm5qidCS+6d8Fx07MFbC1elU0AVOwxdwlYrWxm7RL06f+T3//ayEk/ZSutrnL7Z8yV8V23
 hBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This now removes roughly double the code that it adds.

I've been playing with this to allow for moderately flexible usage of
the get_unused_fd_flags() + create file + fd_install() pattern that's
used quite extensively and requires cumbersome cleanup paths.

How callers allocate files is really heterogenous so it's not really
convenient to fold them into a single class. It's possibe to split them
into subclasses like for anon inodes. I think that's not necessarily
nice as well. This adds two primitives:

(1) FD_ADD() the simple cases a file is installed:

    fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
    if (fd < 0)
            vfio_device_put_registration(device);
    return fd;

(2) FD_PREPARE() that captures all the cases where access to fd or file
    or additional work before publishing the fd is needed:

    FD_PREPARE(fdf, O_CLOEXEC, sync_file->file);
    if (fdf.err) {
            fput(sync_file->file);
            return fdf.err;
    }

    data.fence = fd_prepare_fd(fdf);
    if (copy_to_user((void __user *)arg, &data, sizeof(data)))
            return -EFAULT;

    return fd_publish(fdf);

I've converted all of the easy cases over to it and it gets rid of an
aweful lot of convoluted cleanup logic. There are a bunch of other cases
that can also be converted after a bit of massaging.

It's centered around a simple struct. FD_PREPARE() encapsulates all of
allocation and cleanup logic and must be followed by a call to
fd_publish() which associates the fd with the file and installs it into
the callers fdtable. If fd_publish() isn't called both are deallocated.
FD_ADD() is a shorthand that does the fd_publish() and never exposes the
struct to the caller. That's often the case when they don't need access
to anything after installing the fd.

It mandates a specific order namely that first we allocate the fd and
then instantiate the file. But that shouldn't be a problem. Nearly
everyone I've converted used this order anyway.

There's a bunch of additional cases where it would be easy to convert
them to this pattern. For example, the whole sync file stuff in dma
currently returns the containing structure of the file instead of the
file itself even though it's only used to allocate files. Changing that
would make it fall into the FD_PREPARE() pattern easily. I've not done
that work yet.

There's room for extending this in a way that wed'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v4:
- Integrated error checking into FD_PREPARE() as per Linus suggestion.
- Added FD_ADD() as it's such an obvious win for a bunch of cases.
- Link to v3: https://patch.msgid.link/20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org

Changes in v3:
- Remove scope-based variant.
- Link to v2: https://patch.msgid.link/20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org

Changes in v2:
- Make FD_PREPARE() use a separate scope.
- Convert most easy cases.
- Link to v1: https://patch.msgid.link/20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org

---
Christian Brauner (47):
      file: add FD_{ADD,PREPARE}()
      anon_inodes: convert to FD_PREPARE()
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

 arch/powerpc/platforms/cell/spufs/inode.c          | 42 +++-------
 arch/powerpc/platforms/pseries/papr-hvpipe.c       | 39 +++-------
 .../powerpc/platforms/pseries/papr-platform-dump.c | 32 +++-----
 arch/powerpc/platforms/pseries/papr-rtas-common.c  | 27 ++-----
 drivers/dma-buf/dma-buf.c                          | 10 +--
 drivers/dma-buf/sw_sync.c                          | 40 ++++------
 drivers/dma-buf/sync_file.c                        | 52 ++++---------
 drivers/gpio/gpiolib-cdev.c                        | 58 ++++++--------
 drivers/hv/mshv_root_main.c                        | 29 ++-----
 drivers/media/mc/mc-request.c                      | 34 +++-----
 drivers/misc/ntsync.c                              | 20 ++---
 drivers/tty/pty.c                                  | 30 ++-----
 drivers/vfio/group.c                               | 28 ++-----
 fs/anon_inodes.c                                   | 23 +-----
 fs/autofs/dev-ioctl.c                              | 30 ++-----
 fs/eventfd.c                                       | 31 +++-----
 fs/eventpoll.c                                     | 32 +++-----
 fs/exec.c                                          |  9 ++-
 fs/fhandle.c                                       | 30 ++++---
 fs/file.c                                          | 19 ++---
 fs/namespace.c                                     | 88 +++++++--------------
 fs/notify/fanotify/fanotify_user.c                 | 60 ++++++--------
 fs/nsfs.c                                          | 46 ++++-------
 fs/open.c                                          | 17 +---
 fs/signalfd.c                                      | 29 +++----
 fs/timerfd.c                                       | 29 +++----
 fs/userfaultfd.c                                   | 30 +++----
 fs/xfs/xfs_handle.c                                | 53 ++++---------
 include/linux/cleanup.h                            |  7 ++
 include/linux/file.h                               | 91 ++++++++++++++++++++++
 io_uring/mock_file.c                               | 44 ++++-------
 ipc/mqueue.c                                       | 31 +++-----
 kernel/bpf/bpf_iter.c                              | 29 ++-----
 kernel/bpf/token.c                                 | 47 ++++-------
 mm/memfd.c                                         | 29 ++-----
 mm/secretmem.c                                     | 20 +----
 net/handshake/netlink.c                            | 37 ++++-----
 net/kcm/kcmsock.c                                  | 23 ++----
 net/sctp/socket.c                                  | 90 ++++++---------------
 net/socket.c                                       | 34 ++------
 net/unix/af_unix.c                                 | 16 +---
 virt/kvm/guest_memfd.c                             | 35 +++------
 virt/kvm/kvm_main.c                                | 20 ++---
 43 files changed, 511 insertions(+), 1009 deletions(-)
---
base-commit: c8e00cdc7425d5c60fd1ce6e7f71e5fb1b236991
change-id: 20251118-work-fd-prepare-f415a3bf5fda


