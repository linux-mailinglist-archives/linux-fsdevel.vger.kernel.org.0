Return-Path: <linux-fsdevel+bounces-34577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26E9C6642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BE72835A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CD12E4A;
	Wed, 13 Nov 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4CtvmwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245892C9A;
	Wed, 13 Nov 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459255; cv=none; b=qX4mLJ3CN9+bidX9fL+CDhnw3psfwFBp3H6VmPHg4dhZHLLsmxdXI6Ah1F9PsiyUfaCxLJRpkdPjMRjnOFzA9oBXDqM6CWD8dJF4EFHW5qxnN4A98oWGOlHNHzfoIvyXt7omWl1nxftGHppm/JDDiiCPLcf8Y3RKYdKJTBpPqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459255; c=relaxed/simple;
	bh=2/BzEDLl8uZtmkZu3QBWi0fXXCGMuB/3jo/IFlR+2dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gd9YuzRkaIpqiZgE9GzJsv+mPkwBNdua6q/R1V9MphxioCdgmqytXP4bVJBP/B50Yyp0nX1YsvuMlrdRM0H0nv7/Rn+30Pi/UeCL6kEX2joNCWXfBuNdE6zIEErwV6wRxzDPaAzvH2pRGhwjjXlI3r5+VUREOxV1JoLqBsCEZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4CtvmwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF79C4CECD;
	Wed, 13 Nov 2024 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731459254;
	bh=2/BzEDLl8uZtmkZu3QBWi0fXXCGMuB/3jo/IFlR+2dk=;
	h=From:To:Cc:Subject:Date:From;
	b=i4CtvmwB6H1T4GSXb+N5S5Sy3BCj1XG8ooAYTXbE2wDnKGStibmR+0saHieYvfCg2
	 wcrJDJPoa28mpVADlkpuk4f8exZ4chOcwJuhdHbYNt4runPcz2Qbn7/bcNmBsIj3y0
	 vshFHN66eWfEY/DMv8vVrxEIXxNSNTMsDXhKdiPDzphm3ximVagbjCnsW/7HgLOHOn
	 jsRm+PJutXpf3Lqxjbd1OcfcNA6UlJpaUY2pRkSlywscoZToiYiimOE3J2TS+Uai07
	 4pbXDL4CTCnQeyb1r6kDxy6vYORD1oIAlz2lc0NK/tAv83oljKFjtZUEA/qhgDyx39
	 DhlWtFIFb4QWA==
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
Subject: [PATCH v3 bpf-next 0/4] Make inode storage available to tracing prog
Date: Tue, 12 Nov 2024 16:53:47 -0800
Message-ID: <20241113005351.2197340-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf inode local storage can be useful beyond LSM programs. For example,
bcc/libbpf-tools file* can use inode local storage to simplify the logic.
This set makes inode local storage available to tracing program.

1/4 is missing change for bpf task local storage. 2/4 move inode local
storage from security blob to inode.

Similar to task local storage in tracing program, it is necessary to add
recursion prevention logic for inode local storage. Patch 3/4 adds such
logic, and 4/4 add a test for the recursion prevention logic.

Changes v2 => v3:
1. Move bpf_inode_storage_free to i_callback(). (Martin)
2. Fix __bpf_inode_storage_get(). (Martin)

Changes v1 => v2:
1. Rebase.
2. Fix send-email mistake.

Song Liu (4):
  bpf: lsm: Remove hook to bpf_task_storage_free
  bpf: Make bpf inode storage available to tracing program
  bpf: Add recursion prevention logic for inode storage
  selftest/bpf: Test inode local storage recursion prevention

 fs/inode.c                                    |   2 +
 include/linux/bpf.h                           |   9 +
 include/linux/bpf_lsm.h                       |  29 ---
 include/linux/fs.h                            |   4 +
 kernel/bpf/Makefile                           |   3 +-
 kernel/bpf/bpf_inode_storage.c                | 185 +++++++++++++-----
 kernel/bpf/bpf_lsm.c                          |   4 -
 kernel/trace/bpf_trace.c                      |   8 +
 security/bpf/hooks.c                          |   7 -
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/prog_tests/inode_local_storage.c      |  72 +++++++
 .../bpf/progs/inode_storage_recursion.c       |  90 +++++++++
 12 files changed, 321 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_local_storage.c
 create mode 100644 tools/testing/selftests/bpf/progs/inode_storage_recursion.c

--
2.43.5

