Return-Path: <linux-fsdevel+bounces-4124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E57FCB8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 01:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E86E1C204BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9D1850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SipIV3Ha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDCA35;
	Wed, 29 Nov 2023 00:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C1DC433C7;
	Wed, 29 Nov 2023 00:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701218223;
	bh=kdIRsKLRcIcA0iXyzdZN/aSUQG54RXIUtB60difygWo=;
	h=From:To:Cc:Subject:Date:From;
	b=SipIV3HaFQi80qqa2I8P40D9b/jgcVX5MugptQclkwT+2sJU3MX9SOUZAaoNWf6wr
	 h0Qmh9cUYgLXoRJzoHZ84uposyk7nFV7QQNQotTZaRQT8dMcm/wHICfpVHFNF02KC1
	 evegJYuvlVnL+CYhHhTy3i3GEKpQcEJBE4vSsegfWnMrsQdlRBv/KY0s3TMlsJ9YAD
	 XHYVFHfr3bd0GMKof8LmXIDhSe0QNKmyi3Axe5Pg3kONEsWsnKnvyuCrxr9KaTORfL
	 YDIbVCbmcMIE6rPzxndt1gHZNJuwadd8aCHn0hlh9O0H/niirZsgkZZids6BokQJof
	 07Cr41GLx51uw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Cc: ebiggers@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	casey@schaufler-ca.com,
	amir73il@gmail.com,
	kpsingh@kernel.org,
	roberto.sassu@huawei.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v14 bpf-next 0/6] bpf: File verification with LSM and fsverity
Date: Tue, 28 Nov 2023 16:36:50 -0800
Message-Id: <20231129003656.1165061-1-song@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v13 => v14:
1. Add "static" for bpf_fs_kfunc_set.
2. Add Acked-by from Christian Brauner.

Changes v12 => v13:
1. Only keep 4/9 through 9/9 of v12, as the first 3 patches already
   applied;
2. Use new macro __bpf_kfunc_[start|end]_defs().

Changes v11 => v12:
1. Fix typo (data_ptr => sig_ptr) in bpf_get_file_xattr().

Changes v10 => v11:
1. Let __bpf_dynptr_data() return const void *. (Andrii)
2. Optimize code to reuse output from __bpf_dynptr_size(). (Andrii)
3. Add __diag_ignore_all("-Wmissing-declarations") for kfunc definition.
4. Fix an off indentation. (Andrii)

Changes v9 => v10:
1. Remove WARN_ON_ONCE() from check_reg_const_str. (Alexei)

Changes v8 => v9:
1. Fix test_progs kfunc_dynptr_param/dynptr_data_null.

Changes v7 => v8:
1. Do not use bpf_dynptr_slice* in the kernel. Add __bpf_dynptr_data* and
   use them in ther kernel. (Andrii)

Changes v6 => v7:
1. Change "__const_str" annotation to "__str". (Alexei, Andrii)
2. Add KF_TRUSTED_ARGS flag for both new kfuncs. (KP)
3. Only allow bpf_get_file_xattr() to read xattr with "user." prefix.
4. Add Acked-by from Eric Biggers.

Changes v5 => v6:
1. Let fsverity_init_bpf() return void. (Eric Biggers)
2. Sort things in alphabetic orders. (Eric Biggers)

Changes v4 => v5:
1. Revise commit logs. (Alexei)

Changes v3 => v4:
1. Fix error reported by CI.
2. Update comments of bpf_dynptr_slice* that they may return error pointer.

Changes v2 => v3:
1. Rebase and resolve conflicts.

Changes v1 => v2:
1. Let bpf_get_file_xattr() use const string for arg "name". (Alexei)
2. Add recursion prevention with allowlist. (Alexei)
3. Let bpf_get_file_xattr() use __vfs_getxattr() to avoid recursion,
   as vfs_getxattr() calls into other LSM hooks.
4. Do not use dynptr->data directly, use helper insteadd. (Andrii)
5. Fixes with bpf_get_fsverity_digest. (Eric Biggers)
6. Add documentation. (Eric Biggers)
7. Fix some compile warnings. (kernel test robot)

This set enables file verification with BPF LSM and fsverity.

In this solution, fsverity is used to provide reliable and efficient hash
of files; and BPF LSM is used to implement signature verification (against
asymmetric keys), and to enforce access control.

This solution can be used to implement access control in complicated cases.
For example: only signed python binary and signed python script and access
special files/devices/ports.

Thanks,
Song

Song Liu (6):
  bpf: Add kfunc bpf_get_file_xattr
  bpf, fsverity: Add kfunc bpf_get_fsverity_digest
  Documentation/bpf: Add documentation for filesystem kfuncs
  selftests/bpf: Sort config in alphabetic order
  selftests/bpf: Add tests for filesystem kfuncs
  selftests/bpf: Add test that uses fsverity and xattr to sign a file

 Documentation/bpf/fs_kfuncs.rst               |  21 +++
 Documentation/bpf/index.rst                   |   1 +
 fs/verity/fsverity_private.h                  |  10 ++
 fs/verity/init.c                              |   1 +
 fs/verity/measure.c                           |  84 +++++++++
 kernel/trace/bpf_trace.c                      |  67 +++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 ++
 tools/testing/selftests/bpf/config            |   3 +-
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 132 ++++++++++++++
 .../bpf/prog_tests/verify_pkcs7_sig.c         | 163 +++++++++++++++++-
 .../selftests/bpf/progs/test_fsverity.c       |  46 +++++
 .../selftests/bpf/progs/test_get_xattr.c      |  37 ++++
 .../selftests/bpf/progs/test_sig_in_xattr.c   |  82 +++++++++
 .../bpf/progs/test_verify_pkcs7_sig.c         |   8 +-
 .../testing/selftests/bpf/verify_sig_setup.sh |  25 +++
 15 files changed, 681 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/bpf/fs_kfuncs.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fs_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_fsverity.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_get_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sig_in_xattr.c

--
2.34.1

