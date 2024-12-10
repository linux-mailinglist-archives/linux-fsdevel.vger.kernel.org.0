Return-Path: <linux-fsdevel+bounces-36993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B69569EBD82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 23:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AC8286F65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9168F24036D;
	Tue, 10 Dec 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMW6pNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0C1EE7B4;
	Tue, 10 Dec 2024 22:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868408; cv=none; b=E1hpbE6lfye6xj+HvJiq7iDmJauCUhu369cpBoYiQqKPmKph3+sAw620w821rR06uyeGRWdwmlXN4Jt/HpP9xCPGN+fLIA00cC5lkSXVjok1gLAQyclr4xZP+TWuD6OOOM6N5IXoTa3HW97NXr0HpyotQkag+KudDNz+qLQ9ipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868408; c=relaxed/simple;
	bh=T8llLC6PFC/Gc9fbpZBPsYWsfacHNK3mptA3yecDcSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKozSx65yEnvTP+Hymv/bet2J9rEPROCKkhKkXBIM0FUVzxYFu/ET+oolISa2cvCSv4/UJoAC3wVM5rqpzDvPu+jA0n+WvL0vOOqeqPnJEVm0wCvnDFPONGsYqWVIGuJm36S5JRjV1pe1Kxmi9JsJhLc8uVWDni4G9YL+pjSQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMW6pNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86682C4CED6;
	Tue, 10 Dec 2024 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733868407;
	bh=T8llLC6PFC/Gc9fbpZBPsYWsfacHNK3mptA3yecDcSc=;
	h=From:To:Cc:Subject:Date:From;
	b=OBMW6pNBMyFRqq9VSw2kQewuWnunpEQEu+0Yjttg5goXs1KSKFgSc8hJClyGTGRqy
	 dyhDLQXFWVFlMoRgqJjQHSDLgTv3+n+nIZILCZZhVp3nhd2XygfmWbtewC2uJQngp6
	 JuX9mM5/qvD0nLIrDozgkKcoMgMwkkLuc0AJvfZ0oaz3O6EvcwEh++PjrcYeF1Ct06
	 YehqzIup8JTiLFdlwskLkWonQiIFQdoh682xRGj7mKM310ExlWAqXe5LzLmkCA7kud
	 BNgVJmxWQtTHWoLlmKDJyGQio4kRFY4CEuITSj2XSaOSIwvNdQjZVnHGnoveBVLwsk
	 At3PzI5QW9j2Q==
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
Subject: [PATCH v3 bpf-next 0/6] Enable writing xattr from BPF programs
Date: Tue, 10 Dec 2024 14:06:21 -0800
Message-ID: <20241210220627.2800362-1-song@kernel.org>
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

 fs/bpf_fs_kfuncs.c                            | 258 +++++++++++++++++-
 include/uapi/linux/xattr.h                    |   4 +
 kernel/bpf/bpf_lsm.c                          |   2 +
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  10 +
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 165 ++++++++++-
 .../selftests/bpf/progs/test_get_xattr.c      |  28 +-
 .../bpf/progs/test_set_remove_xattr.c         | 129 +++++++++
 .../bpf/progs/test_set_remove_xattr_failure.c |  56 ++++
 8 files changed, 632 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_set_remove_xattr_failure.c

--
2.43.5

