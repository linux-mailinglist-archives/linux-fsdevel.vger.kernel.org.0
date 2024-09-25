Return-Path: <linux-fsdevel+bounces-30062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FF985859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD234285359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2317B508;
	Wed, 25 Sep 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiXzXxwf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6E18C34C;
	Wed, 25 Sep 2024 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264248; cv=none; b=ueyywQWZgL3a7QIfC1JaT/vmtUeZf2YPckGEzA8qrmOqUVNIMkMlHrxtLJ99/p5TpOep0r2ePIcgwn0ITRZUwlxAdlwSvuoaIx5STzQPSHqjXmmYwtJVjCrlLRu99C62Kgj5Gidg0aV8FGDoynTHymJLy7Xg3AYzkkPmspEIPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264248; c=relaxed/simple;
	bh=oxGGPOE4uL7X7MkTJ9BgnFV6wDR+RX7IZb/it7homu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV+OAh8gtkabpGik3J7E6WFWn1W/mJ01kCznj8eWiMJPLCPj0BDOVP+rteezaKPyAvzCzbRBdtxWMaOBPCVMlQk1IBdMS6CdOmZKDHKpQqlsAlNV8fcdma9PDd5LgQ0MxEZTo5MVKdKzimPTAjMrO8CDNFb/T9M7kEDKSdxA47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiXzXxwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84309C4CEC7;
	Wed, 25 Sep 2024 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264248;
	bh=oxGGPOE4uL7X7MkTJ9BgnFV6wDR+RX7IZb/it7homu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AiXzXxwfCszQteN0H2JfpBF1HmMWp0eyH70Tp40fzJo7kzIECnaJsmcv577jq/AKs
	 SWhJR/GafkU95byIdjU/iGTngsmxg5YRAxhgafsigwNZXN2UWJhe/uOzP2jqVVedUJ
	 KxvtN8vwSYBWKeEFRsgjqcIps5iX9XKDOfl7ojybZm6GC/weBB0GhGLU4XoOg/tUpu
	 oLo3G2qLnRk907VfJ8vR4m8aLeBwf2jtNZL/PYHr9vXisqS2X7x7R1wBtzT19gFjKl
	 QiXJdLzrhL5QZlwzEUuigczvjMFtEPlRrilxO48/G2Eknpn1w4QVcOO8bjOLFFzH6L
	 wHN7J2l7aHTMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 020/244] exec: don't WARN for racy path_noexec check
Date: Wed, 25 Sep 2024 07:24:01 -0400
Message-ID: <20240925113641.1297102-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit 0d196e7589cefe207d5d41f37a0a28a1fdeeb7c6 ]

Both i_mode and noexec checks wrapped in WARN_ON stem from an artifact
of the previous implementation. They used to legitimately check for the
condition, but that got moved up in two commits:
633fb6ac3980 ("exec: move S_ISREG() check earlier")
0fd338b2d2cd ("exec: move path_noexec() check earlier")

Instead of being removed said checks are WARN_ON'ed instead, which
has some debug value.

However, the spurious path_noexec check is racy, resulting in
unwarranted warnings should someone race with setting the noexec flag.

One can note there is more to perm-checking whether execve is allowed
and none of the conditions are guaranteed to still hold after they were
tested for.

Additionally this does not validate whether the code path did any perm
checking to begin with -- it will pass if the inode happens to be
regular.

Keep the redundant path_noexec() check even though it's mindless
nonsense checking for guarantee that isn't given so drop the WARN.

Reword the commentary and do small tidy ups while here.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20240805131721.765484-1-mjguzik@gmail.com
[brauner: keep redundant path_noexec() check]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 50e76cc633c4b..caae051c5a956 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -145,13 +145,11 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 		goto out;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * Check do_open_execat() for an explanation.
 	 */
 	error = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path))
 		goto exit;
 
 	error = -ENOEXEC;
@@ -954,7 +952,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
 static struct file *do_open_execat(int fd, struct filename *name, int flags)
 {
 	struct file *file;
-	int err;
 	struct open_flags open_exec_flags = {
 		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
 		.acc_mode = MAY_EXEC,
@@ -971,24 +968,20 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 
 	file = do_filp_open(fd, name, &open_exec_flags);
 	if (IS_ERR(file))
-		goto out;
+		return file;
 
 	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
+	 * In the past the regular type check was here. It moved to may_open() in
+	 * 633fb6ac3980 ("exec: move S_ISREG() check earlier"). Since then it is
+	 * an invariant that all non-regular files error out before we get here.
 	 */
-	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
+	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)) ||
+	    path_noexec(&file->f_path)) {
+		fput(file);
+		return ERR_PTR(-EACCES);
+	}
 
-out:
 	return file;
-
-exit:
-	fput(file);
-	return ERR_PTR(err);
 }
 
 /**
-- 
2.43.0


