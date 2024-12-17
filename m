Return-Path: <linux-fsdevel+bounces-37603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1F9F43D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5BD189025F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB49187859;
	Tue, 17 Dec 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5RWmFRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446315B111;
	Tue, 17 Dec 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417509; cv=none; b=W8D4Jpj/rNi+p4bGT6RqM+ehDPgHxQUsHdmNF6sVvE1hak8e/oJU2UMNfN3J8tS/XgKwO7RlTseI5iLUi5bnzDYPbvkUa1JgoLVvoXo/V26RuVqotYGySctBxtibKn16w6xNBbElslfLZV57W5LtmXsHoQNCe7nRmKyMhatqZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417509; c=relaxed/simple;
	bh=boyS65jhqMXSVcqNQBzlAGscorMmiO3BTj7FviB7ydg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXAvqhTXnsU7Yknjw3dJGHM114T3CUkPAU15TJsulsVRdWrCuMwGslpH0PU661CrU6I3fS8Rx733d1Sq5Wnd8LNlgnu0YorUIhU5TNbAq1vgLUldYZsqsHgtN/Gj78NSU2RR+wAgDJ87xvJbLLPtnSmdlv14nApCyst0NGf9cCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5RWmFRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F4C4CED3;
	Tue, 17 Dec 2024 06:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417509;
	bh=boyS65jhqMXSVcqNQBzlAGscorMmiO3BTj7FviB7ydg=;
	h=From:To:Cc:Subject:Date:From;
	b=c5RWmFRTKIRNea2VlCt5c5VKABGJkbbcbCOr/N2W+kfBso8Mih/qiQrIc55/NbwQS
	 9ajnyN8mEbL0AY92I5AwfObXDXhF4evOlR319cHu08Rc1MR3gCUOZSdFCHSRDTFNbA
	 uju1nFyiAg8UBrAnp5pbKLeP874QRKXP5ikjiQ0qbT/BIuR5IofiXty/evMBMpQGOL
	 zEmvBetSYgkbf4YT6FwIt6BBUzmhxHs/ekJw/kMmdfMA7cRFqTMw6tgdphkgHDiORK
	 qPwW5Am6vRAfVKoPB4uX/DNbI+Hjebp6mU6J848AnQPMyC92QqNvn1jCspSzqRtIf6
	 iwA28jeC84nVA==
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
Subject: [PATCH v4 bpf-next 0/6] Enable writing xattr from BPF programs
Date: Mon, 16 Dec 2024 22:38:15 -0800
Message-ID: <20241217063821.482857-1-song@kernel.org>
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

Cover letter of v1 and v2:

Follow up discussion in LPC 2024 [1], that we need security.bpf xattr
prefix. This set adds "security.bpf." xattr name prefix, and allows
bpf kfuncs bpf_get_[file|dentry]_xattr() to read these xattrs.

[1] https://lpc.events/event/18/contributions/1940/

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

Song Liu (6):
  fs/xattr: bpf: Introduce security.bpf. xattr name prefix
  selftests/bpf: Extend test fs_kfuncs to cover security.bpf. xattr
    names
  bpf: lsm: Add two more sleepable hooks
  bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs
  selftests/bpf: Test kfuncs that set and remove xattr from BPF programs
  selftests/bpf: Add __failure tests for set/remove xattr kfuncs

 fs/bpf_fs_kfuncs.c                            | 262 +++++++++++++++++-
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 165 ++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
 .../bpf/progs/test_set_remove_xattr.c         | 129 +++++++++
 .../bpf/progs/test_set_remove_xattr_failure.c |  56 ++++
 8 files changed, 636 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c

--
2.43.5

