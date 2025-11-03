Return-Path: <linux-fsdevel+bounces-66815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C2C2CACB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBC7F4F11CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9D3358C0;
	Mon,  3 Nov 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnuQoRf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B582335567;
	Mon,  3 Nov 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181903; cv=none; b=szYBDpZIF0w4bc33nJPH7M4sY+uJKzLHNt3kNUvSnTbZlnzvbaMFPmX1z6tpI4CYw4lq31m6oYPU4IesdvTlyh8S/iBHsBo9pAo3vNruhnoaB/9opq4+/yImabZQ3G/uweJ7DMBFxqy/lRZE+owAWBuiDsPsgnqJGm5KobTABbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181903; c=relaxed/simple;
	bh=owV/Eekd/Ucg3vFKIrGEVlXyUSEK1yiGGOB8cDqW0Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KX8MXT4fl2jLKoS8f4IarTgvuG8NiLkC44MAqg+Xdgmzd3QHY+ihVMKDlxAGJLRsZYSQ3MJPoBSstcIuFhsIXSrqtos4rdO8MKcyLkJA55jb+jLDr66BwpSg6S9XwIvepbxXHObtl859YiAB71Z3msLVZjBX8B8zdMncJbMi6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnuQoRf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91CC116C6;
	Mon,  3 Nov 2025 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181902;
	bh=owV/Eekd/Ucg3vFKIrGEVlXyUSEK1yiGGOB8cDqW0Rk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UnuQoRf/PeJwNPDSGCW5mXyEpJLYPzFpeFhGdPnORVWh9sUnFHudllQ2hCaEiSieE
	 sQnAMSiLhBe/vmsUDa5iNxOiGFFVOSJEZKtdfxAiuCdHHuhcswxKiFHvKjxgxnmAWu
	 nSKDXMMfW64z3Xzp8RDcImZQNaMF2egtEHfPntmsGgAO4fU1HdFij85WQePDZrqgSm
	 IoEvuRDLjlgYchNMe0/g6aolzcal0Zrpkkrid8v/zHOIYeI32EQv+GYeq/0/uJFtWN
	 kgcpZ12d40QJ1Y609PLC0HH122AaBxWx/ovfUwUvL/L5/0x59a1/4gakZQSfpepqK+
	 2B3sUf9scN0Eg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:36 +0100
Subject: [PATCH 10/12] coredump: use override credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-10-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=brauner@kernel.org;
 h=from:subject:message-id; bh=owV/Eekd/Ucg3vFKIrGEVlXyUSEK1yiGGOB8cDqW0Rk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrJHLgt8mK/gm2Pdu3sfU8ef16VdHmq4JPOMMWFb
 5faX6/83lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCROzcY/idvX1jNd5BRW/f2
 F4dktuv/bzTfmXf9EgtL0ge5zQ1nL9oz/GL+lVZz5LsjL1eit9uyJ8sy75sE7j4qdm9aTZlPq5S
 fMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use override credential guards for scoped credential override with
automatic restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5424a6c4e360..fe4099e0530b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1160,7 +1160,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct core_name cn;
 	const struct mm_struct *mm = current->mm;
 	const struct linux_binfmt *binfmt = mm->binfmt;
-	const struct cred *old_cred;
 	int argc = 0;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
@@ -1197,11 +1196,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
 		return;
 
-	old_cred = override_creds(cred);
-
-	do_coredump(&cn, &cprm, &argv, &argc, binfmt);
-
-	revert_creds(old_cred);
+	scoped_with_creds(cred)
+		do_coredump(&cn, &cprm, &argv, &argc, binfmt);
 	coredump_cleanup(&cn, &cprm);
 	return;
 }

-- 
2.47.3


