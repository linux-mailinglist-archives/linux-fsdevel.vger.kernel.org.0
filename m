Return-Path: <linux-fsdevel+bounces-52311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFAAE19EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3553A970E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32128936C;
	Fri, 20 Jun 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKBJXDpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB796221260;
	Fri, 20 Jun 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418470; cv=none; b=JAL+Fxl/troA+CKemlxs+2LiwoZ4RVxfOv8WiiGdQiH85NuRSt3Cz644+9zSuydZeTucd379b2PmmAPG7KkWAYSmo4/1hpThZlKNml6+mxmpazN49BkAhVzUAPBC5EyNDfVyfy6FR4f+1YZFCD4juiKOdgBjOZ7ieF5qrcSCptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418470; c=relaxed/simple;
	bh=O4PKCznY7W3LGDkG5sDRa0s05jDbDksNrKayrGHplQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMj6C/610YaVGk3ZG3ylSJYsGDG+zlmz/jSr0Dkh2B+fICNXamLsWTXTPko/wyIS+9/zKBjkeucxo56qChgHjKDhlNZ1KMFdEVu3n29C3vEZDC5qk9di5ntvgIJmyZhAv2GhU42yX4cia8cpQEVNZ8N1nvUhTZVKsWXT+fyYoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKBJXDpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C10C4CEE3;
	Fri, 20 Jun 2025 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418470;
	bh=O4PKCznY7W3LGDkG5sDRa0s05jDbDksNrKayrGHplQk=;
	h=From:To:Cc:Subject:Date:From;
	b=AKBJXDptacMfKYLxow6/dFuLpayqedKiG7MUgBG73PRvOXa9pauNqlJl1td5CgHeG
	 AEtNEyQGBsedoaOLcUNIe3IIPiOLmX2dmephDtwhHTb02R35TT1lEYawDL/zaAjZQ0
	 Z6prlcvM9cQXLp3USRGUCOdKmOarqpvq4ojRl8drI196T0FEWyy1S5JZQT7ovoFCGB
	 S/AZ+bS16iL0MFezHxgvNmbTN1hGMGyI9FqoHr93C44q8q0u/jA5kKyuo/QcuuNial
	 8faOdjJCpSqVFtqt2kVtg/9m+8VDR7hgQB54pJytDRR5Dy8H2bPOkFKFXR88oj/Fyw
	 XPgK6rtPrlB4Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Jann Horn <jannh@google.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Roman Kisel <romank@linux.microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: reduce stack usage in vfs_coredump()
Date: Fri, 20 Jun 2025 13:21:01 +0200
Message-Id: <20250620112105.3396149-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added socket coredump code runs into some corner cases
with KASAN that end up needing a lot of stack space:

fs/coredump.c:1206:1: error: the frame size of 1680 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Mark the socket helper function as noinline_for_stack so its stack
usage does not leak out to the other code paths. This also seems to
help with register pressure, and the resulting combined stack usage of
vfs_coredump() and coredump_socket() is actually lower than the inlined
version.

Moving the core_state variable into coredump_wait() helps reduce the
stack usage further and simplifies the code, though it is not sufficient
to avoid the warning by itself.

Fixes: 6a7a50e5f1ac ("coredump: use a single helper for the socket")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/coredump.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index e2611fb1f254..c46e3996ff91 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -518,27 +518,28 @@ static int zap_threads(struct task_struct *tsk,
 	return nr;
 }
 
-static int coredump_wait(int exit_code, struct core_state *core_state)
+static int coredump_wait(int exit_code)
 {
 	struct task_struct *tsk = current;
+	struct core_state core_state;
 	int core_waiters = -EBUSY;
 
-	init_completion(&core_state->startup);
-	core_state->dumper.task = tsk;
-	core_state->dumper.next = NULL;
+	init_completion(&core_state.startup);
+	core_state.dumper.task = tsk;
+	core_state.dumper.next = NULL;
 
-	core_waiters = zap_threads(tsk, core_state, exit_code);
+	core_waiters = zap_threads(tsk, &core_state, exit_code);
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		wait_for_completion_state(&core_state->startup,
+		wait_for_completion_state(&core_state.startup,
 					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
 		 * fpu etc) gets copied to the memory.
 		 */
-		ptr = core_state->dumper.next;
+		ptr = core_state.dumper.next;
 		while (ptr != NULL) {
 			wait_task_inactive(ptr->task, TASK_ANY);
 			ptr = ptr->next;
@@ -858,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
 
-static bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
+static noinline_for_stack bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
 {
 	if (!coredump_sock_connect(cn, cprm))
 		return false;
@@ -1095,7 +1096,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct cred *cred __free(put_cred) = NULL;
 	size_t *argv __free(kfree) = NULL;
-	struct core_state core_state;
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt *binfmt = mm->binfmt;
@@ -1131,7 +1131,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_force_suid_safe(&cprm))
 		cred->fsuid = GLOBAL_ROOT_UID;
 
-	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
+	if (coredump_wait(siginfo->si_signo) < 0)
 		return;
 
 	old_cred = override_creds(cred);
-- 
2.39.5


