Return-Path: <linux-fsdevel+bounces-69398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A1C7B2DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D14D3805CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE9238159;
	Fri, 21 Nov 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Axix+c8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E262E8B76
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748052; cv=none; b=eWrw7SnVmH5ZsaHe/Kd8Y7Q0jIAwBoAvfSclQaey7JBr3ukUAQDKeh8eRICuulRfV25wxnBRBkokLzSx5Ml/c2cRc4ABAcuibn8KeFrYiasMPmdoCbiWir1eHSuM36I7G3ola61f8BW50qkSyr4rgjS9JazORkPmdhNngRjOM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748052; c=relaxed/simple;
	bh=sbUQfjBToyS0st25T5fMakI2n8sTyb9aO0j2vGIQZkc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O9i6He4j1qJyC/SJwSrn09v4ZDRcuq1kbXCJEmKZR7Zu2oFjOoMSUfx1IqqiHuEEQeL210PIkXDeIywt/cytvbRFGqNdf5+DQ4cqhZhuccwDGjrca/uiEy88csvqv0rpAR8ljCLAL+wztQoaSUH+P8t58/ZiTMfk3Ed2RoKW944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Axix+c8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38738C116C6;
	Fri, 21 Nov 2025 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748051;
	bh=sbUQfjBToyS0st25T5fMakI2n8sTyb9aO0j2vGIQZkc=;
	h=From:Subject:Date:To:Cc:From;
	b=Axix+c8BnYy6aKfV7ndMNmIWaDpgo4RUwzSQqIHT+IvRkCIC3LqMoPxnkslWKf1VM
	 cW215hBjoP7G4Plbw/YJY4rsDJDDcLOPCDqGj/woVRzwfjtxhcXmEFTD5FwLSTQ1PG
	 4FAsUrekY3RsWcG8vpPaks0uayB4AIQpRk1W8247q3aON8yyRgtMXvq829QHIkjSIN
	 6NL8e681oShUpFD1nmQ3fuAZK4MGeefVzotQRYFxBm0810tpQyiM3ATx4SET3LBXv0
	 OXzg3b3tVz6pbcQiYNpu8fQ5a29Kq/drunwHXSYBmeZpfp0qtYjnlFmYuEf2JRFB/3
	 PqfalflF+6gWQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v3 00/47] file: add and convert to FD_PREPARE()
Date: Fri, 21 Nov 2025 19:00:39 +0100
Message-Id: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeoIGkC/3XOTW7CMBAF4Ksgr5lgO5ifrpCQeoBuEQs7HicjK
 huNadoK5e44EQsQYvneaD69q8jIhFl8zK6CsadMKZZQz2ei6WxsEciXLLTURim1gd/EJwgezox
 nywhhqYytXTDBW1G+Sh/obxIP4utzL46ldDYjOLax6UYsMbUUoaVL9+MW47Ea2Sr46s6OUkf5k
 vh/mtaryXu7olcgodHSyKXfruu12Z2QI35XidtpQa8fAC1fAV2AgGGFzltpfP0EDMNwA9suUdA
 qAQAA
X-Change-ID: 20251118-work-fd-prepare-f415a3bf5fda
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8223; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sbUQfjBToyS0st25T5fMakI2n8sTyb9aO0j2vGIQZkc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDjX/+iE3PH57nwJjDsNpqfcu/i4/JvwJ+5trxyba
 nmnrGC36yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI7FCGvwITbxdknzXzDPxj
 0uXwrV3+svIh6y6J69zrLom/LfDsM2H4w6kvoehzz2fPdu1L9cUfHvavrXLesvruLY79wgXrk7+
 s5wIA
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

My take is to add a FD_PREPARE() primitive that integrates tightly with
the new ACQUIRE_ERR() scheme that was recently added by peterz:

FD_PREPARE(fdf, open_flag, file_open_handle(&path, open_flag));
ret = ACQUIRE_ERR(fd_prepare, &fdf);
if (ret)
	return ret;

return fd_publish(fdf);

I've converted all of the easy cases over to it and it gets rid of a lot
of convoluted cleanup logic.

It's centered around struct fd_prepare. FD_PREPARE() encapsulates all of
allocation and cleanup logic and must be followed by a call to
fd_publish() which associates the fd with the file and installs it into
the callers fdtable. If fd_publish() isn't called both are deallocated.

It mandates a specific order namely that first we allocate the fd and
then instantiate the file. But that shouldn't be a problem nearly
everyone I've converted uses this exact pattern anyway.

There's a bunch of additional cases where it would be easy to convert
them to this pattern. For example, the whole sync file stuff in dma
currently retains the containing structure of the file instead of the
file itself even though it's only used to allocate files. Changing that
would make it fall into the FD_PREPARE() pattern easily. I've not done
that work yet.

There's room for extending this in a way that wed'd have subclasses for
some particularly often use patterns but as I said I'm not even sure
that's worth it.

Anyway, I'm not a macro wizard per se so maybe I missed some very
obvious bugs. Expect there to still be rough edges.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Remove scope-based variant.
- Link to v2: https://patch.msgid.link/20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org

Changes in v2:
- Make FD_PREPARE() use a separate scope.
- Convert most easy cases.
- Link to v1: https://patch.msgid.link/20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org

---
Christian Brauner (47):
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

 arch/powerpc/platforms/cell/spufs/inode.c          | 38 +++------
 arch/powerpc/platforms/pseries/papr-hvpipe.c       | 37 +++------
 .../powerpc/platforms/pseries/papr-platform-dump.c | 39 +++------
 arch/powerpc/platforms/pseries/papr-rtas-common.c  | 32 +++-----
 drivers/dma-buf/dma-buf.c                          | 14 ++--
 drivers/dma-buf/sw_sync.c                          | 42 ++++------
 drivers/dma-buf/sync_file.c                        | 54 +++++--------
 drivers/gpio/gpiolib-cdev.c                        | 61 +++++++-------
 drivers/hv/mshv_root_main.c                        | 30 ++-----
 drivers/media/mc/mc-request.c                      | 33 +++-----
 drivers/misc/ntsync.c                              | 22 ++----
 drivers/tty/pty.c                                  | 34 +++-----
 drivers/vfio/group.c                               | 27 ++-----
 fs/anon_inodes.c                                   | 25 ++----
 fs/autofs/dev-ioctl.c                              | 34 +++-----
 fs/eventfd.c                                       | 33 +++-----
 fs/eventpoll.c                                     | 33 +++-----
 fs/exec.c                                          |  8 +-
 fs/fhandle.c                                       | 31 ++++----
 fs/file.c                                          | 20 +++--
 fs/namespace.c                                     | 92 ++++++++--------------
 fs/notify/fanotify/fanotify_user.c                 | 63 ++++++---------
 fs/nsfs.c                                          | 51 +++++-------
 fs/open.c                                          | 21 ++---
 fs/signalfd.c                                      | 29 +++----
 fs/timerfd.c                                       | 30 +++----
 fs/userfaultfd.c                                   | 32 +++-----
 fs/xfs/xfs_handle.c                                | 53 ++++---------
 include/linux/cleanup.h                            |  7 ++
 include/linux/file.h                               | 75 ++++++++++++++++++
 io_uring/mock_file.c                               | 46 ++++-------
 ipc/mqueue.c                                       | 34 +++-----
 kernel/bpf/bpf_iter.c                              | 30 +++----
 kernel/bpf/token.c                                 | 48 ++++-------
 mm/memfd.c                                         | 32 +++-----
 mm/secretmem.c                                     | 23 ++----
 net/handshake/netlink.c                            | 32 ++++----
 net/kcm/kcmsock.c                                  | 24 ++----
 net/sctp/socket.c                                  | 89 ++++++---------------
 net/socket.c                                       | 38 +++------
 net/unix/af_unix.c                                 | 20 ++---
 virt/kvm/guest_memfd.c                             | 37 +++------
 virt/kvm/kvm_main.c                                | 24 +++---
 43 files changed, 597 insertions(+), 980 deletions(-)
---
base-commit: c8e00cdc7425d5c60fd1ce6e7f71e5fb1b236991
change-id: 20251118-work-fd-prepare-f415a3bf5fda


