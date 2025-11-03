Return-Path: <linux-fsdevel+bounces-66812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512AAC2C98B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FFA188693F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF163328F1;
	Mon,  3 Nov 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LokUB/Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E73168FC;
	Mon,  3 Nov 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181895; cv=none; b=QW6KT55Fk9zuvWQneNRjFdgQOxu1GL1A7ZIIOYYLkMwOFYIrupLdvxr6s2x67Afu2iKAOfwWzeNeVROfOXlB8d+FE1+E5RME0LHFnmQdlrAcUltzol/QYLneOiV7avwTtS1tjJzvqrVi45LlXNdOr7l/NJHWW4EzypSR9EPHeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181895; c=relaxed/simple;
	bh=9EsH2Da/6UhJaCMVF0omDPDa4FG+ogIUAttbOM8Fjec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yi70wRoTFLoc7gR09WBQyns1HKtz0B8fTA2rc48WirdtYrAYr0eFY6HZgkFwrvowMCxKNh3fJMqXlFRSYTkxBQhct0u2VzK6SnOdrwBT+kXzPkoBcvipPBASH+KOh22/ZTGvWQzhrJ/ybylXl2jhsyPSmn0Kjn5SyOlXuQsy6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LokUB/Mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB73C19424;
	Mon,  3 Nov 2025 14:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181892;
	bh=9EsH2Da/6UhJaCMVF0omDPDa4FG+ogIUAttbOM8Fjec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LokUB/McgJ3/29UMikpNosikAQqnLwDTX7X8gxMGompKPQe50GAhAhDb9V7MfeH+N
	 WybYX5a9QtVgpXPUoJ6vGEf9fR2uq2Wk54rlzuExUqBjsdwfBgwQsIIfnmlrAzf9qV
	 a+dc5BpxypOmzwR2uyHJV3EX4rB6mTVjR9FvQ2wpYVIw9umJ2FK9IaDqpvMTLYkQ2X
	 zfmkvjMdH9mOWJq1wxUGfSxH5UFk04bsEYNaykTa/vg0JJTJlQsZ5bPl35IO0r8rDr
	 SMdKGofW3CBbq6NsS3+vuh9+wtWJxOv+YbsNLt7xRnVZX+xa0wBXmZj9/2V2bawz5M
	 e6KCSLn3GkgTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:33 +0100
Subject: [PATCH 07/12] coredump: mark struct mm_struct as const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-7-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9EsH2Da/6UhJaCMVF0omDPDa4FG+ogIUAttbOM8Fjec=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpe3G1dtnTrr4PBwxfP/m/JmXpzS8lXwrj/c5Ki
 8hLXajk7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpzTDP9XcpOfRU9T6lQR3
 qW7o3hXK6sfa0fVU60Y727FFC86tl2P476eY7rGk7Xh2TtfP72zTJ7wMexFh1GyRX6i5//1LPwZ
 7HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We don't actually modify it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c                  | 2 +-
 include/linux/sched/coredump.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 590360ba0a28..8253b28bc728 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1092,7 +1092,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	size_t *argv __free(kfree) = NULL;
 	struct core_state core_state;
 	struct core_name cn;
-	struct mm_struct *mm = current->mm;
+	const struct mm_struct *mm = current->mm;
 	const struct linux_binfmt *binfmt = mm->binfmt;
 	const struct cred *old_cred;
 	int argc = 0;
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index b7fafe999073..624fda17a785 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -8,7 +8,7 @@
 #define SUID_DUMP_USER		1	/* Dump as user of process */
 #define SUID_DUMP_ROOT		2	/* Dump as root */
 
-static inline unsigned long __mm_flags_get_dumpable(struct mm_struct *mm)
+static inline unsigned long __mm_flags_get_dumpable(const struct mm_struct *mm)
 {
 	/*
 	 * By convention, dumpable bits are contained in first 32 bits of the

-- 
2.47.3


