Return-Path: <linux-fsdevel+bounces-46252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1B7A85ED3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9601BA2E7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D407191F75;
	Fri, 11 Apr 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ6F5afm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38518FDDB;
	Fri, 11 Apr 2025 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377778; cv=none; b=dAuyl93lLMeMNcicfSN/dKvOBMhNz2FoGW0FQd9hBDVB73PXlxjGeEKNomOFppqYymHysaFSJRQYYewMTxl4s9DeYcYCadj4o/7VA/9DbHjelNIGmaHXeQ9kQhp/k+LYJfnUKEZ4cmxdCfV9hTB5wA9M6afw3QdTnaYDQm3JXPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377778; c=relaxed/simple;
	bh=CvWVldzuNN35tPBO/DGxM2pU9PrRocJ7BQFvuEn/dWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUZyKTcbIiR/o7yqAakv/afav/wQVqLWMouljLfZpyxejZAwGmyv2XVGgIXmMihR5jvUI/UJUuupItSxSEKOTyGJSS1jCcI+upLaoTFEXhyf/aOE1COn+gNmVoGB6OflZK3EnTdKIjBe99CKPht/7/iokY3bKEg6+XsEWc4N5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ6F5afm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D6C4CEE8;
	Fri, 11 Apr 2025 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744377777;
	bh=CvWVldzuNN35tPBO/DGxM2pU9PrRocJ7BQFvuEn/dWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lZ6F5afmitaFa8Lmpw2oa2k6aztS+gggRGkSrGJtQ4xfs6PJcu2KCJ+w2iEVKPeX8
	 qIeb1X6xqjb0x1CLsHPpl1v1PSRJGhiOOJqX7UNUKYIg4AyrygkUxdfdny+W/i+lIR
	 jOiELTTragYF6qOjY41Ey+1OCD/A0Y1+BBpCiNL+CjHUpWBJq7qnLrcIuMdowUUCLU
	 SR5g01aeajfdVA6XjIzpZyVZdzwyg9Kjlam44p6VGUF3idWNdX2QBCQmALktCiiz9J
	 hWbH10dFAYtguBpsj6t7ycrHisIkgwRM0YC7q4J58rvccEWSZsMR5I6NBprhYaRNL9
	 BgTYQIPmvQ1LQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Apr 2025 15:22:45 +0200
Subject: [PATCH v2 2/2] pidfs: ensure consistent ENOENT/ESRCH reporting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-work-pidfs-enoent-v2-2-60b2d3bb545f@kernel.org>
References: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
In-Reply-To: <20250411-work-pidfs-enoent-v2-0-60b2d3bb545f@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 linux-kernel@vger.kernel.org, Peter Ziljstra <peterz@infradead.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CvWVldzuNN35tPBO/DGxM2pU9PrRocJ7BQFvuEn/dWA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/FF/1vPRkwSxW1btZ2xIjoxNyOWT3PrGsST6Vdcfp5
 ZYdXzlTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi+p7hf5ZYac7NQvdp0pKf
 Pfin1d5P923PK5WPuLU8bbI9/4ooVYb/3gFzZpY7m6W7H332/YVHY6zwYoGDn2R/qm5dPOG01q8
 yZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In a prior patch series we tried to cleanly differentiate between:

(1) The task has already been reaped.
(2) The caller requested a pidfd for a thread-group leader but the pid
    actually references a struct pid that isn't used as a thread-group
    leader.

as this was causing issues for non-threaded workloads.

But there's cases where the current simple logic is wrong. Specifically,
if the pid was a leader pid and the check races with __unhash_process().
Stabilize this by using the pidfd waitqueue lock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 4a2080b968c8..cde960fd0c71 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2108,28 +2108,23 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	int err = 0;
-
-	if (!(flags & PIDFD_THREAD)) {
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		/*
+		 * If this wasn't a thread-group leader struct pid or
+		 * the task already been reaped report ESRCH to
+		 * userspace.
+		 */
+		if (!pid_has_task(pid, PIDTYPE_PID))
+			return -ESRCH;
 		/*
-		 * If this is struct pid isn't used as a thread-group
-		 * leader pid but the caller requested to create a
-		 * thread-group leader pidfd then report ENOENT to the
-		 * caller as a hint.
+		 * If this struct pid isn't used as a thread-group
+		 * leader but the caller requested to create a
+		 * thread-group leader pidfd then report ENOENT.
 		 */
-		if (!pid_has_task(pid, PIDTYPE_TGID))
-			err = -ENOENT;
+		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
+			return -ENOENT;
 	}
 
-	/*
-	 * If this wasn't a thread-group leader struct pid or the task
-	 * got reaped in the meantime report -ESRCH to userspace.
-	 */
-	if (!pid_has_task(pid, PIDTYPE_PID))
-		err = -ESRCH;
-	if (err)
-		return err;
-
 	return __pidfd_prepare(pid, flags, ret);
 }
 

-- 
2.47.2


