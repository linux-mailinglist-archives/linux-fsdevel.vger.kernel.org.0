Return-Path: <linux-fsdevel+bounces-51472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9758AD7200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847963B2FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DE258CED;
	Thu, 12 Jun 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekAYNuvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5E2580E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734753; cv=none; b=HjGF8zbH1Tuyr+lacKxCCF3Zv4td6hmHREe/IHIOKVelvg/IwXfbaz+rXXQf9bcEwMHGc8HaJJVP2CX+/kgFP0Kw1hAwS5XmEa5Qi3ZDGoUlEfeIxVHNMvfkO3Gfdzz4KXeKkV6e9BUKE3QTCNcLXIzLvszn4FgzjO0xCKI+qVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734753; c=relaxed/simple;
	bh=NUMr3Fjhb2vFlkLhqwxqAFwI+xKPQn6mpj4YxoiJFk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OyrR3Tdz+nMMfYH541/wgm3zpGDFyqnTNobmkh78rarvczAY8LGm1SoMAz5OND9eXesw5guIAJtPE3SEyj0o8r4grtAWvTWHXy1QrT8+7PeF/LiCK2n6GQBBi133rpG9JGGe38IqrgyFXybCzZ2cQ7JM0TFkEhG9UBJo5sFNSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekAYNuvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C9C4CEEB;
	Thu, 12 Jun 2025 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734753;
	bh=NUMr3Fjhb2vFlkLhqwxqAFwI+xKPQn6mpj4YxoiJFk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ekAYNuvA0HUiBhPCAhktP9wkn5HXF0uBHppfxs3xvAY8C+fPSIH60RUSlvMYR7MCB
	 mgocnL239zwhTIn/dlEROhb62ELo4IG+7TwRQCR8i9udxbIs2doYap8eHuzQsjQX3r
	 mdOga5lZ2R/p5nuOlxr8A2vSZTqu7udtge8rGwYqxgeMF56lMtZbyWN2RNOEZGDGXr
	 YfSWSPau495iGMKA3t9Gx7HoCQSzpN1UfqyyLYzJpWi6FSg8D1XSA7F10aVs80ilVU
	 e018CyXUDwIBXjPJv2nuzQ++hwf0O6ELvXTRQ3pDpG9laY6PWkO8m0HH88Ta8FbVzA
	 T16CLgjvMBFtQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:25 +0200
Subject: [PATCH 11/24] coredump: prepare to simplify exit paths
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-11-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NUMr3Fjhb2vFlkLhqwxqAFwI+xKPQn6mpj4YxoiJFk0=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGhK1UfIb05fB7xKA044T+6ub+2yRrr+IfDBpdHt/9gyhCQc1
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmhK1UcACgkQkcYbwGV43KIo0QEA0tLO
 JPyN8SYsJT88bKwoB5nuC0AbaI6wDJG7sFbh6xEBAIDaaX4fSgxTpLaPbJpbXIKFuYO3qeSy4Aa
 P/wT6DqQN
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The exit path is currently entangled with core pipe limit accounting
which is really unpleasant. Use a local variable in struct core_name
that remembers whether the count was incremented and if so to clean
decrement in once the coredump is done. Assert that this only happens
for pipes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9f9d8ae29359..4afaf792a12e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -93,6 +93,7 @@ enum coredump_type_t {
 struct core_name {
 	char *corename;
 	int used, size;
+	unsigned int core_pipe_limit;
 	enum coredump_type_t core_type;
 	u64 mask;
 };
@@ -244,6 +245,7 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 		cn->mask |= COREDUMP_WAIT;
 	cn->used = 0;
 	cn->corename = NULL;
+	cn->core_pipe_limit = 0;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
 	else if (*pat_ptr == '@')
@@ -1031,7 +1033,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		break;
 	case COREDUMP_PIPE: {
 		int argi;
-		int dump_count;
 		char **helper_argv;
 		struct subprocess_info *sub_info;
 
@@ -1052,21 +1053,21 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 			 * core_pattern process dies.
 			 */
 			coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
-			goto fail_unlock;
+			goto close_fail;
 		}
 		cprm.limit = RLIM_INFINITY;
 
-		dump_count = atomic_inc_return(&core_dump_count);
-		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
+		cn.core_pipe_limit = atomic_inc_return(&core_dump_count);
+		if (core_pipe_limit && (core_pipe_limit < cn.core_pipe_limit)) {
 			coredump_report_failure("over core_pipe_limit, skipping core dump");
-			goto fail_dropcount;
+			goto close_fail;
 		}
 
 		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
 					    GFP_KERNEL);
 		if (!helper_argv) {
 			coredump_report_failure("%s failed to allocate memory", __func__);
-			goto fail_dropcount;
+			goto close_fail;
 		}
 		for (argi = 0; argi < argc; argi++)
 			helper_argv[argi] = cn.corename + argv[argi];
@@ -1168,9 +1169,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
-fail_dropcount:
-	if (cn.core_type == COREDUMP_PIPE)
+	if (cn.core_pipe_limit) {
+		VFS_WARN_ON_ONCE(cn.core_type != COREDUMP_PIPE);
 		atomic_dec(&core_dump_count);
+	}
 fail_unlock:
 	kfree(argv);
 	kfree(cn.corename);

-- 
2.47.2


