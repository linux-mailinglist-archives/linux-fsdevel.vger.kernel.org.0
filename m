Return-Path: <linux-fsdevel+bounces-40336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98CA2254B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0003A682C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFD81E32A3;
	Wed, 29 Jan 2025 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elmbCR2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2E1E2613;
	Wed, 29 Jan 2025 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184407; cv=none; b=njuSQ7Pu4wmIcYhNTQx6kzQDFtUbX6triu6bX6DcJo7KM++r5RdJ853uWWgweoFxdBWi7bCTQ/TMKTftAvxR0e375XiUdyhAvaP+Y38Fc5E1gIvTWyRzHcQ4rd+8SSEJDxlCH6HYhEo41rk1yx5DBzqcwOzsb+a9zHvT8IXFIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184407; c=relaxed/simple;
	bh=J6NG0xJGCikkFG/B1ZrwYa2LzoqhJh8SS7oBMDNSwEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tqaj6a1AYPMy9sRWpvUGpVzodAKQVHTqxpSw1J7WSihaB47d//mtoL6ZZ1lOD9xlB56zVqTIPPd9LvLSes+GVDm0QeEbuJCQzkMPzxEkQ/S26UIt+SyypauXtIWtXn7VVFn4IyAf0unrGLLlgLGsT8uMHMOPYjcRkPbQcANNSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elmbCR2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ECFC4CED1;
	Wed, 29 Jan 2025 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184406;
	bh=J6NG0xJGCikkFG/B1ZrwYa2LzoqhJh8SS7oBMDNSwEA=;
	h=From:To:Cc:Subject:Date:From;
	b=elmbCR2cOgY8xDFqQkQAKLfaO+5KJi0tG2OU/GB3ToQ+Jscux/+bFKVhzm/51Cpos
	 7YpRG7pD6w5rs6E1M4BbHZ4c5vIHL/wtISa6aMr3RJ5wE+jqUNOv8FJQXtEemNg9W/
	 cZFV+rR2KLXt7HwgxXcoQ4LzPBS2PPaH8CNI+aK3Udo8QaDPpUFsku10qaa3r9ZlKt
	 GIZyquOywIGZ4OM7K0Wk5JeZhVE5oDCrPv5EhEGCdLc369b8R8z4I7RbbkDCMsrTUC
	 Zta2wQLfRTEQ3Oxy9nLXPH22rL8gJH3HYc7O4OnrIriFMGp77T8efqATWAmUETF0vQ
	 uzB1l/jzPTSCA==
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
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v11 bpf-next 0/7] Enable writing xattr from BPF programs
Date: Wed, 29 Jan 2025 12:59:50 -0800
Message-ID: <20250129205957.2457655-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to set and remove xattr from BPF program. Also add
security.bpf. xattr name prefix.

kfuncs are added to set and remove xattrs with security.bpf. name
prefix. Update kfuncs bpf_get_[file|dentry]_xattr to read xattrs
with security.bpf. name prefix. Note that BPF programs can read
user. xattrs, but not write and remove them.

To pick the right version of kfunc to use, a remap logic is added to
btf_kfunc_id_set. This helps move some kfunc specific logic off the
verifier core code. Also use this remap logic to select
bpf_dynptr_from_skb or bpf_dynptr_from_skb_rdonly.


Cover letter of v1 and v2:

Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
prefix. This set adds "security.bpf." xattr name prefix, and allows
bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.

[1] https://lpc.events/event/18/contributions/1940/

---

Changes v10 => v11:

1. Add Acked-by from Christian Brauner.
2. Fix selftests build error like this one:
   https://github.com/kernel-patches/bpf/actions/runs/13022268618/job/36325472992
3. Rename some variables in the selftests.

v10: https://lore.kernel.org/bpf/20250124202911.3264715-1-song@kernel.org/

Changes v9 => v10:
1. Refactor bpf_[set|remove]_dentry_xattr[_locked]. (Christian Brauner).

v9: https://lore.kernel.org/bpf/20250110011342.2965136-1-song@kernel.org/

Changes v8 => v9
1. Fix build for CONFIG_DEBUG_INFO_BTF=n case. (kernel test robot)

v8: https://lore.kernel.org/bpf/20250108225140.3467654-1-song@kernel.org/

Changes v7 => v8
1. Rebase and resolve conflicts.

v7: https://lore.kernel.org/bpf/20241219221439.2455664-1-song@kernel.org/

Changes v6 => v7
1. Move btf_kfunc_id_remap() to the right place. (Bug reported by CI)

v6: https://lore.kernel.org/bpf/20241219202536.1625216-1-song@kernel.org/

Changes v5 => v6
1. Hide _locked version of the kfuncs from vmlinux.h (Alexei)
2. Add remap logic to btf_kfunc_id_set and use that to pick the correct
   version of kfuncs to use.
3. Also use the remap logic for bpf_dynptr_from_skb[|_rdonly].

v5: https://lore.kernel.org/bpf/20241218044711.1723221-1-song@kernel.org/

Changes v4 => v5
1. Let verifier pick proper kfunc (_locked or not _locked)  based on the
   calling context. (Alexei)
2. Remove the __failure test (6/6 of v4).

v4: https://lore.kernel.org/bpf/20241217063821.482857-1-song@kernel.org/

Changes v3 => v4
1. Do write permission check with inode locked. (Jan Kara)
2. Fix some source_inline warnings.

v3: https://lore.kernel.org/bpf/20241210220627.2800362-1-song@kernel.org/

Changes v2 => v3
1. Add kfuncs to set and remove xattr from BPF programs.

v2: https://lore.kernel.org/bpf/20241016070955.375923-1-song@kernel.org/

Changes v1 => v2
1. Update comment of bpf_get_[file|dentry]_xattr. (Jiri Olsa)
2. Fix comment for return value of bpf_get_[file|dentry]_xattr.

v1: https://lore.kernel.org/bpf/20241002214637.3625277-1-song@kernel.org/

Song Liu (7):
  fs/xattr: bpf: Introduce security.bpf. xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr
    names
  bpf: lsm: Add two more sleepable hooks
  bpf: Extend btf_kfunc_id_set to handle kfunc polymorphism
  bpf: Use btf_kfunc_id_set.remap logic for bpf_dynptr_from_skb
  bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
  selftests/bpf: Test kfuncs that set and remove xattr from BPF programs

 fs/bpf_fs_kfuncs.c                            | 238 +++++++++++++++++-
 include/linux/bpf_lsm.h                       |   2 +
 include/linux/btf.h                           |  20 ++
 include/linux/btf_ids.h                       |   4 +
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 kernel/bpf/btf.c                              | 117 +++++++--
 kernel/bpf/verifier.c                         |  31 +--
 net/core/filter.c                             |  49 +++-
 tools/testing/selftests/bpf/bpf_kfuncs.h      |   5 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 162 +++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 ++-
 .../bpf/progs/test_set_remove_xattr.c         | 133 ++++++++++
 13 files changed, 732 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c

--
2.43.5

