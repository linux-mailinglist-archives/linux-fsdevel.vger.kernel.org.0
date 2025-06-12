Return-Path: <linux-fsdevel+bounces-51485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39206AD7208
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9808A3B68E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4479F2475E8;
	Thu, 12 Jun 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jps79S4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F925BEF1
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734780; cv=none; b=D2S2GL8gdGdCc3RlJVL7afAfUKOHjIseZ2eoJSptO5RBLvSOOuoCe2zj14OmNtRnz0WhT95UDA3Aow8nuymnQwBHC3/qtHilF97fwKb7kBT1meHS6o+QxxElvxa7BM7TSwHoMjnpUDw6xNT3fDr13qFkehiaC/UJ6JGuRWT+emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734780; c=relaxed/simple;
	bh=sVQ84MElWL6vgKyVB4HW//Lhim+Ah21V9GZ44Xe3mNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DczgHHaO6q7Bo9WfzLWmznAAekW7jEkPw4RubpQfq69OGMxwcbDEE5OZJ+wiIc4DI0oEv4mkeBbqYThvF0Vc8GY9fzxMYZPq5cwDTfTAR55jK1n0isEOL2w7GXVzpto1vdWw9vN5mqBs6koIR4guEiYkSnWv25YMdqW60wBWe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jps79S4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0533C4CEEE;
	Thu, 12 Jun 2025 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734780;
	bh=sVQ84MElWL6vgKyVB4HW//Lhim+Ah21V9GZ44Xe3mNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jps79S4tW69sVcuFeRUOrcWF+cpZiC4h+3KiBp2MNUC+RBEZ1vBvsfmXxuaj4T85d
	 w18hCgaSvUXuliH02xAZWCPqFBI618hpPkE3Kx7bBclV909Buqdl8NOZzD9AebSN5M
	 IBqbIoe8GdghwNU7iOqUkPEX1Qnxn15HTcsqxbr71p+XjudSDS8WOItPWACH4VFpT2
	 ZM+yCCvVUUEHZg92nXPSY1F/K3SOERCvFLcgXZkUdDrTumHf6M5TCaTtUhkT/eOPlG
	 CfYiP1Rdpqq9M2DvkgNsEZLOvprSC8B6StFQQM1gLKop6/cpWDR+n+wupWvNHOS2Ng
	 Mw6zMLIbSuA8g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:38 +0200
Subject: [PATCH 24/24] coredump: add coredump_skip() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-24-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sVQ84MElWL6vgKyVB4HW//Lhim+Ah21V9GZ44Xe3mNI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XfV4OSP/Y9MT3i0+LP+Vvq87cDQl5eca0Z1ZDGf3f
 F7z51Tty45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJPPFgZLi/yrl34gbFO08k
 PHfHbnSWSdmQflTiWKXpTeHf25yrbt1hZJikdErDZrblr2l+8z/uidtQPMHW4fF+/Xc23yZ0Jen
 yb+QAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 689914c8cf0f..e2611fb1f254 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1079,6 +1079,18 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 	coredump_finish(cn->core_dumped);
 }
 
+static inline bool coredump_skip(const struct coredump_params *cprm,
+				 const struct linux_binfmt *binfmt)
+{
+	if (!binfmt)
+		return true;
+	if (!binfmt->core_dump)
+		return true;
+	if (!__get_dumpable(cprm->mm_flags))
+		return true;
+	return false;
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct cred *cred __free(put_cred) = NULL;
@@ -1086,7 +1098,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct core_state core_state;
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
-	struct linux_binfmt * binfmt;
+	struct linux_binfmt *binfmt = mm->binfmt;
 	const struct cred *old_cred;
 	int argc = 0;
 	struct coredump_params cprm = {
@@ -1104,10 +1116,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	audit_core_dumps(siginfo->si_signo);
 
-	binfmt = mm->binfmt;
-	if (!binfmt || !binfmt->core_dump)
-		return;
-	if (!__get_dumpable(cprm.mm_flags))
+	if (coredump_skip(&cprm, binfmt))
 		return;
 
 	cred = prepare_creds();

-- 
2.47.2


