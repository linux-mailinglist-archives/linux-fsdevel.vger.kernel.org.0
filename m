Return-Path: <linux-fsdevel+bounces-34740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524229C84FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183A2283A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2C1F76A8;
	Thu, 14 Nov 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxWo43cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44512E573;
	Thu, 14 Nov 2024 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573842; cv=none; b=GmiA535N1E9gphgh+LZ3mM84paSBia0Pw7/oCB9vKFdDBhmnAxgoQ7LPE8s+GgTlqeTSGPhokfPOcO0R0L/3UB5ZLF3d9bqDITW5ktPVsgtfE87/bW4pXv9CNp6bjK3MwRjWHoORfZbvsV6LdLJBVJ2tNIsXQRsZuZU1wJQjkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573842; c=relaxed/simple;
	bh=yueFnat0srpXokXZ3xaTaiktYxAAHlj69Ro0EkqDHQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0DdGgZLfV/CuciWWntyalgVDlXCCbTCXuWhCIJPLJ9AJy/rUIn/RTXTzYiwRaKwVMg5yeMSgTmJNQ5VjK8QYwG69CpYx0Qvhz/9tjAsUdL7bxHdqwPwW5mPaL3ROSXqjP/3aCg3vgr0DSxgkiGfotW2C5u8Tc0rvaPtQeQPCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxWo43cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C69C4CECD;
	Thu, 14 Nov 2024 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573841;
	bh=yueFnat0srpXokXZ3xaTaiktYxAAHlj69Ro0EkqDHQc=;
	h=From:To:Cc:Subject:Date:From;
	b=rxWo43cwFb5eeMp2KXc2N3dRMTdeL6xpJsO1nhH/4es6mrWCDapd1Th1yhMVFYecr
	 xjyMz2r+jvTIunUhItNs4QVx7Pd3dvyx7dzJN+7YwyHuDarUNG6DCPqg0GCH8t4wnL
	 ObvZ5dd0rhi6wT4ygczUDXCTCaXG7F2nv38k3qPm8BttKEuY4CmO6V9zBuKRHk3qSh
	 nLSb/JAM9AErHCIbR7Hneue+0mU3BCI0PWmPCK+CAfC39SGirkLMj168MP2OA0tPGf
	 gEIGjG3WagIM1c+FVMCYnzOsSkQ7an8DaXuocsAQYKfFMaCEAKS1Lt+fC+Y+FVnLHQ
	 fE5453mu2Z7RA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
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
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [RFC/PATCH v2 bpf-next fanotify 0/7] Fanotify fastpath handler
Date: Thu, 14 Nov 2024 00:43:38 -0800
Message-ID: <20241114084345.1564165-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Overview of v2:

Patch 1/7 adds logic to write fastpath handlers in kernel modules.
Patch 2/7 adds a sample of a fastpath handler in a kernel module.
Patch 3/7 to 5/7 are preparation work on BPF side.
Patch 6/7 adds logic to write fastpath handlers in bpf programs.
Patch 7/7 is a selftest and example of bpf based fastpath handler.

Changes v1 => v2:
1. Add sysfs entries for fastpath handler.
2. Rewrite the sample and bpf selftest to handle subtree monitoring.
   This requires quite some work from BPF side to properly handle
   inode, dentry, etc.
3. Add CONFIG_FANOTIFY_FASTPATH.
4. Add more documents.

TODO of v2:
1. Enable prviate (not added to global list) bpf based fastpath handlers.
4. Man pages.

From v1 RFC:

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

[1] https://lpc.events/event/18/contributions/1717/
[2] https://lpc.events/event/18/contributions/1940/


Song Liu (7):
  fanotify: Introduce fanotify fastpath handler
  samples/fanotify: Add a sample fanotify fastpath handler
  bpf: Make bpf inode storage available to tracing programs
  bpf: fs: Add three kfuncs
  bpf: Allow bpf map hold reference on dentry
  fanotify: Enable bpf based fanotify fastpath handler
  selftests/bpf: Add test for BPF based fanotify fastpath handler

 MAINTAINERS                                   |   1 +
 fs/Makefile                                   |   2 +-
 fs/bpf_fs_kfuncs.c                            |  51 +-
 fs/inode.c                                    |   2 +
 fs/notify/fanotify/Kconfig                    |  13 +
 fs/notify/fanotify/Makefile                   |   1 +
 fs/notify/fanotify/fanotify.c                 |  29 ++
 fs/notify/fanotify/fanotify_fastpath.c        | 448 ++++++++++++++++++
 fs/notify/fanotify/fanotify_user.c            |   7 +
 include/linux/bpf.h                           |   9 +
 include/linux/bpf_lsm.h                       |  29 --
 include/linux/fanotify.h                      | 131 +++++
 include/linux/fs.h                            |   4 +
 include/linux/fsnotify_backend.h              |   4 +
 include/uapi/linux/fanotify.h                 |  25 +
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/bpf_inode_storage.c                | 176 +++++--
 kernel/bpf/bpf_lsm.c                          |   4 -
 kernel/bpf/helpers.c                          |  14 +-
 kernel/bpf/verifier.c                         |   6 +
 kernel/trace/bpf_trace.c                      |   8 +
 samples/Kconfig                               |  20 +-
 samples/Makefile                              |   2 +-
 samples/fanotify/.gitignore                   |   1 +
 samples/fanotify/Makefile                     |   5 +-
 samples/fanotify/fastpath-mod.c               |  82 ++++
 samples/fanotify/fastpath-user.c              | 111 +++++
 security/bpf/hooks.c                          |   7 -
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 tools/testing/selftests/bpf/config            |   2 +
 .../testing/selftests/bpf/prog_tests/fan_fp.c | 264 +++++++++++
 tools/testing/selftests/bpf/progs/fan_fp.c    | 154 ++++++
 32 files changed, 1530 insertions(+), 90 deletions(-)
 create mode 100644 fs/notify/fanotify/fanotify_fastpath.c
 create mode 100644 samples/fanotify/fastpath-mod.c
 create mode 100644 samples/fanotify/fastpath-user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fan_fp.c
 create mode 100644 tools/testing/selftests/bpf/progs/fan_fp.c

--
2.43.5

