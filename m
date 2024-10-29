Return-Path: <linux-fsdevel+bounces-33170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991619B5689
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4D71C20D72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF020B201;
	Tue, 29 Oct 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3yo2Wf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D420ADD4;
	Tue, 29 Oct 2024 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243575; cv=none; b=AoXNcusJDOMbJ3fwjQeWVLuvEVuNh3T2QCkFuVULmY910Po/V+bXQSufZe51aXLmCNex8kKkBJyqa0ahqNNDofk978FAKHiyF5PNTISELUlhTMEiW4vF64hh+1oX//8awQ89XGgmFLl2F20DUVpETj/O5BPWtmKxHDA2fSqeUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243575; c=relaxed/simple;
	bh=LjcugxeRFbGxnwLPmH2IHhrjSAtZ2rEER7t/y7d2bMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWqpTh98qCMVuc1zJt+X6Pn2sRz0h4pgvghcUxAKlUNPhOj9zH3aVIVU+6zJ/5ZjCW58In2erP6MiasCc8aktTXAh/3FavUM+NR6sY/d0MaAcrlciT0t4nNi1GGlzQWc933LPzIWmq8O0kgemVTRfXpHcku+XkcIZN+6bNWJDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3yo2Wf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5E3C4CEE3;
	Tue, 29 Oct 2024 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243575;
	bh=LjcugxeRFbGxnwLPmH2IHhrjSAtZ2rEER7t/y7d2bMs=;
	h=From:To:Cc:Subject:Date:From;
	b=j3yo2Wf1KLjmO/WmIqJeCDal4Z6naw/DuztLhMTbuh/MsKmd71oWTXLyqDwF9Aj+E
	 FIkkJ+tHg/j1K0buShRvT3+TaGqpgFBn0xSzMRAEQpAmsm/cJkf625KlSYTiSLp0zg
	 tmIgBhmLs7b/3mlCXyx1JVutvKoddnbFpiY7dVd5zps6zOwmvSOcLWZUP0TFkIWg+d
	 hzNhKpZue9cYAvBZomKbjWXIQORkxO46mvCB+HjzXl8QTEvV2dVFBOz/Q0TVwUi1nx
	 +uEdYR4W9FiObUQX/qL++mMnxwU+HgRD8vO2T2kdvrdMXQAC9r/JZoHVUFTJKEWf+1
	 u0tEwnPEMqZTA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next fanotify 0/5] Fanotify fastpath handler
Date: Tue, 29 Oct 2024 16:12:39 -0700
Message-ID: <20241029231244.2834368-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC set introduces in-kernel fastpath handler for fanotify. The
fastpath handler can be used to handle/filter some events without going
through userspace.

In LPC 2024, multiple talks covered use cases of monitoring a subtree in
the VFS (fanotify: [1], bpf/lsm: [2]). This work is inspired by these
discussions. Reliably monitoring of a subtree with low overhead is a hard
problem. We do not claim this set fully solves problem. But we think this
work can be a very useful building block of the solution to this problem.

The fastpath handler can be implemented with built-in logic, in a kernel
module, or a bpf program. The fastpath handler is attached to a fsnotify
group. With current implementation, the multiple fastpath handlers are
maintained in a global list. Only users with CAP_SYS_ADMIN can add
fastpath handlers to the list by loading a kernel module. User without
CAP_SYS_ADMIN can attach a loaded fastpath handler to fanotify instances.
During the attach operation, the fastpath handler can take an argument.
This enables non-CAP_SYSADMIN users to customize/configure the fastpath
handler, for example, with a specific allowlist/denylist.

As the patchset grows to 1000+ lines (including samples and tests), I
would like some feedback before pushing it further.

Overview:

Patch 1/5 adds logic to write fastpath handlers in kernel modules.
Patch 2/5 adds a sample of a fastpath handler in a kernel module.
Patch 3/5 is some preparation work on BPF side.
Patch 4/5 adds logic to write fastpath handlers in bpf programs.
Patch 5/5 is a selftest and example of bpf based fastpath handler.

TODO:
1. Add some mechanism to help users discover available fastpath
   handlers. For example, we can add a sysctl which is similar to
   net.ipv4.tcp_available_congestion_control, or we can add some sysfs
   entries.
2. Enable prviate (not added to global list) bpf based fastpath handlers.
3. More testing for inode local storage.
4. Man pages.

[1] https://lpc.events/event/18/contributions/1717/
[2] https://lpc.events/event/18/contributions/1940/

Song Liu (5):
  fanotify: Introduce fanotify fastpath handler
  samples/fanotify: Add a sample fanotify fastpath handler
  bpf: Make bpf inode storage available to tracing programs
  fanotify: Enable bpf based fanotify fastpath handler
  selftests/bpf: Add test for BPF based fanotify fastpath handler

 MAINTAINERS                                   |   1 +
 fs/Makefile                                   |   2 +-
 fs/bpf_fs_kfuncs.c                            |  23 +-
 fs/notify/fanotify/Makefile                   |   2 +-
 fs/notify/fanotify/fanotify.c                 |  25 ++
 fs/notify/fanotify/fanotify_fastpath.c        | 318 ++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c            |   7 +
 include/linux/bpf.h                           |   9 +
 include/linux/bpf_lsm.h                       |  29 --
 include/linux/fanotify.h                      |  45 +++
 include/linux/fs.h                            |   4 +
 include/linux/fsnotify_backend.h              |   3 +
 include/uapi/linux/fanotify.h                 |  26 ++
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/bpf_inode_storage.c                | 174 +++++++---
 kernel/bpf/bpf_lsm.c                          |   4 -
 kernel/bpf/verifier.c                         |   5 +
 kernel/trace/bpf_trace.c                      |   8 +
 samples/Kconfig                               |  20 +-
 samples/Makefile                              |   2 +-
 samples/fanotify/.gitignore                   |   1 +
 samples/fanotify/Makefile                     |   5 +-
 samples/fanotify/fastpath-mod.c               | 138 ++++++++
 samples/fanotify/fastpath-user.c              |  90 +++++
 security/bpf/hooks.c                          |   5 -
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   4 +
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/prog_tests/fan_fp.c | 245 ++++++++++++++
 tools/testing/selftests/bpf/progs/fan_fp.c    |  77 +++++
 29 files changed, 1189 insertions(+), 87 deletions(-)
 create mode 100644 fs/notify/fanotify/fanotify_fastpath.c
 create mode 100644 samples/fanotify/fastpath-mod.c
 create mode 100644 samples/fanotify/fastpath-user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fan_fp.c
 create mode 100644 tools/testing/selftests/bpf/progs/fan_fp.c

--
2.43.5

