Return-Path: <linux-fsdevel+bounces-51477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC102AD721E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3271C25172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6288025B2F9;
	Thu, 12 Jun 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtkif436"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC284244EA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734763; cv=none; b=gZjB3pgZMuaahpUMH6UzQU/5C8EGNcVoIAh3AZOrGL9yQPB/SQ2y+tgimTQnjBbxOGp4cTArzHsZs9P+ikWoBOyfLs4hJ99hTScxVZPpZtu12YlH/PKXClD9ZG6HdsMJSMhYg1Wd/UkWQ7lPN4vKTIaeT2BWBiIpW9jucb76IaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734763; c=relaxed/simple;
	bh=NOs3aYDBZ3qSM/f/fuug59GAFkv45K+UF+HYW/GFonM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzHAJQJ1WCE46w7EdjNCH+Aou/o5Z6pbd8NEK9WnvHNDWUNCXukKXO+NjgdLUnZz65DBUtILBM8WNp5a0LHW71SoTjan7VCaUUq7zLo2nj13o0xFuWWH+8AbyKEUdl2/DJ5jP3JArcgZ4aJblcUVPNmt0ue5AsPbBLBjltMnLqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtkif436; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0635BC4CEEA;
	Thu, 12 Jun 2025 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734763;
	bh=NOs3aYDBZ3qSM/f/fuug59GAFkv45K+UF+HYW/GFonM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xtkif436wB4+vWZCJif2bxB7pa3TKHUnSsiSnbST7M27TCDQeXWv6emuEnqWSAYk3
	 dUomWqxjOz1oGzUsDBUqJVPVl3aGH1DpoNmu23hB61r7bUjTDXyj3ApleUiSShqxfQ
	 0XZkcwMlVUrpSgSaonQ9oGZ+fFUiELekgbCPVkUUzN5aLVLIh1j/Ms4hGtAYfp184P
	 nYYNppffg3YLLoBqBmjxMettwXhoZYhEbKq/4dAA/kMfOSYLY4z++NOeToRYjaQNmZ
	 bJBe6Q88+F/+NC1R1X4AbOst4zr8HDeUU+5yd9X13Xl7zZqxSzn2svjYfnBjuIcq3V
	 CPhCE2D/ByM4A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:30 +0200
Subject: [PATCH 16/24] coredump: add coredump_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-16-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3332; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NOs3aYDBZ3qSM/f/fuug59GAFkv45K+UF+HYW/GFonM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXXfEJJ+/OfmT3oTz8w5GXZIb84VFSndRjb/vP/Fd
 WHftMwOdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdg3D/+LdSy4FvdUzreT4
 9u3GV/7JsQnK0Rd/zOKxCSlM/M2Zc4CR4VLDkauZ77Ml5ukrG29MlHysdKnkwdbWGYuvdMrHyt6
 L5QcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

to encapsulate that logic simplifying vfs_coredump() even further.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 56 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 521c6c4ded9d..f980a7920481 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -95,6 +95,7 @@ struct core_name {
 	char *corename;
 	int used, size;
 	unsigned int core_pipe_limit;
+	bool core_dumped;
 	enum coredump_type_t core_type;
 	u64 mask;
 };
@@ -247,6 +248,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	cn->used = 0;
 	cn->corename = NULL;
 	cn->core_pipe_limit = 0;
+	cn->core_dumped = false;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
 	else if (*pat_ptr == '@')
@@ -1037,6 +1039,34 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 	return true;
 }
 
+static bool coredump_write(struct core_name *cn,
+			  struct coredump_params *cprm,
+			  struct linux_binfmt *binfmt)
+{
+
+	if (dump_interrupted())
+		return true;
+
+	if (!dump_vma_snapshot(cprm))
+		return false;
+
+	file_start_write(cprm->file);
+	cn->core_dumped = binfmt->core_dump(cprm);
+	/*
+	 * Ensures that file size is big enough to contain the current
+	 * file postion. This prevents gdb from complaining about
+	 * a truncated file if the last "write" to the file was
+	 * dump_skip.
+	 */
+	if (cprm->to_skip) {
+		cprm->to_skip--;
+		dump_emit(cprm, "", 1);
+	}
+	file_end_write(cprm->file);
+	free_vma_snapshot(cprm);
+	return true;
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -1048,7 +1078,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	int retval = 0;
 	size_t *argv = NULL;
 	int argc = 0;
-	bool core_dumped = false;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
 		.limit = rlimit(RLIMIT_CORE),
@@ -1123,31 +1152,14 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	if (retval)
 		goto close_fail;
 
-	if ((cn.mask & COREDUMP_KERNEL) && !dump_interrupted()) {
-		if (!dump_vma_snapshot(&cprm))
-			goto close_fail;
-
-		file_start_write(cprm.file);
-		core_dumped = binfmt->core_dump(&cprm);
-		/*
-		 * Ensures that file size is big enough to contain the current
-		 * file postion. This prevents gdb from complaining about
-		 * a truncated file if the last "write" to the file was
-		 * dump_skip.
-		 */
-		if (cprm.to_skip) {
-			cprm.to_skip--;
-			dump_emit(&cprm, "", 1);
-		}
-		file_end_write(cprm.file);
-		free_vma_snapshot(&cprm);
-	}
+	if ((cn.mask & COREDUMP_KERNEL) && !coredump_write(&cn, &cprm, binfmt))
+		goto close_fail;
 
 	coredump_sock_shutdown(cprm.file);
 
 	/* Let the parent know that a coredump was generated. */
 	if (cn.mask & COREDUMP_USERSPACE)
-		core_dumped = true;
+		cn.core_dumped = true;
 
 	/*
 	 * When core_pipe_limit is set we wait for the coredump server
@@ -1179,7 +1191,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 fail_unlock:
 	kfree(argv);
 	kfree(cn.corename);
-	coredump_finish(core_dumped);
+	coredump_finish(cn.core_dumped);
 	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);

-- 
2.47.2


