Return-Path: <linux-fsdevel+bounces-51484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDBAAD71ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4277C17D40E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC225BF01;
	Thu, 12 Jun 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPLi4phI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0C25BEF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734778; cv=none; b=pZ/crthZoLa3EWQ5Nb8LXdZUHhpRYkpgmhuFS3aF6S2CE8H8/F+jNHLRyLRDKazP7aK57c8gjzkCrcuiUdkMRemZsF4jE0LKhIhepLcVBjvNS1uwvMvRm7T+eJ1tdWkq3TmlVwKxw4t/9bgi2KoroOMpiB8dwwxROsDpnJYrDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734778; c=relaxed/simple;
	bh=7yiP7YYxFhy8d52aBzHwfm05JIx80bjaq/2blTZjf2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYQQPtzlr7bYB2JkQExQp/XggTDmOShahIRPqIqxuEg2WZKzSPeK/Rx6ph6Ru5LHAIWhazZG7mPX4XuwPYuLqza4VW3WwXrXNrDs/0MAxpZXpe3iVtoR2iAm62Le6+403ofpjxJ6hA9v7xNEk4jqrsBTCW8o9K6jLOXeWxzgN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPLi4phI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD3BC4CEEB;
	Thu, 12 Jun 2025 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734778;
	bh=7yiP7YYxFhy8d52aBzHwfm05JIx80bjaq/2blTZjf2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YPLi4phISvLDqa6M84Wnh4UukTI47SDiIS1n/s9rXOOsxyz7QZI7HwOWyawSHgUED
	 1aeWVBlpk5uq33wEcsvaCn5cKehI/1AWhr8ceKanDOWaTvBDIDiGQP2WWJBfTJe79f
	 uuA1NZjbMZvrCseBUndP2IQ/8uiR1sgt/Nj6AaIxZS4TSEASKwFXi3szEYUui7C7mL
	 A7DfViVigX5Er/y7EarupbP7ZB+WDtOBW9Mk+gHgCrZ0xRDkBfgrhxeF3gSz1SL1q9
	 MVmP6abzH1c/NPL29+LmpLprgB96VtyhGTs0Tq0hnrZpaBLeHsnFUzxSGAGbGN/yic
	 4s3UTlo8Wol/A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:37 +0200
Subject: [PATCH 23/24] coredump: avoid pointless variable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-23-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7yiP7YYxFhy8d52aBzHwfm05JIx80bjaq/2blTZjf2E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXXXYWU0n/SKpbL97MaEE/ftV7c5/tRzZJctK5geU
 WrB63Kho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKChxn+8PFMDlPle+tiIrU2
 Qm1u2S02waPpr+c+ObQjX//pJJ5Flxj+Z5/22Jc2kS/zwKc4tUJv2ZiyFznpogt5xNIuXqh8+2c
 GJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

we don't use that value at all so don't bother with it in the first
place.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5b88a4be558f..689914c8cf0f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1088,7 +1088,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
-	int retval = 0;
 	int argc = 0;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
@@ -1123,8 +1122,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_force_suid_safe(&cprm))
 		cred->fsuid = GLOBAL_ROOT_UID;
 
-	retval = coredump_wait(siginfo->si_signo, &core_state);
-	if (retval < 0)
+	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
 		return;
 
 	old_cred = override_creds(cred);
@@ -1160,8 +1158,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	/* get us an unshared descriptor table; almost always a no-op */
 	/* The cell spufs coredump code reads the file descriptor tables */
-	retval = unshare_files();
-	if (retval)
+	if (unshare_files())
 		goto close_fail;
 
 	if ((cn.mask & COREDUMP_KERNEL) && !coredump_write(&cn, &cprm, binfmt))

-- 
2.47.2


