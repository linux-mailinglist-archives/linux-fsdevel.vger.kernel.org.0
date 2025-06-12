Return-Path: <linux-fsdevel+bounces-51483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0ECAD7228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A50A1884C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDE52472A8;
	Thu, 12 Jun 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh60gDOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FD24677F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734776; cv=none; b=fItMIsrUJE0e6Y2IM21oxUGhUlwvmjxzInAPJARi28ceiSUf22TxaT1KmItBjMSez2eUTNGrKiHIRuwgxQ9qk4onDu+nYJV3JhVRGKXz5BgRvWcml86SHM6YDphd/mAcVwpGYSLt/uo/E5EI4xV4+lvDoOQR0X4GwO14GXj57jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734776; c=relaxed/simple;
	bh=ZyYfe02ChAuwU7/oqtTlfiTFF8IxyFojUGr98qwcbkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICbKcxWqNZXOwvkYFeCxkr3Fxr6MEoHE+0prEfVk00keQ1PU5F/CDVpNhc/DMTljW0DVtfYmOahIKfiMOxMC9bV6POEzq4po6C2GvX2oAa+x34jeWi3FuLuFDORu/xxBqmEryouwwXfcniNi0gZEUc4UIJTI5Kfhc6BPYkWmM/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh60gDOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A6BC4CEEB;
	Thu, 12 Jun 2025 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734774;
	bh=ZyYfe02ChAuwU7/oqtTlfiTFF8IxyFojUGr98qwcbkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gh60gDOkDweJN13wgjcpBIrAtnmLa09CM+jx8ijg4kgUA9HLnSjNWdhDn253w8mQT
	 LRFecIz3sF0yxqjU7DdR5fev/F1hgyqGOb7wN5z6iw8MVizj2aXB8ps9Z10YTPgeGQ
	 czGuhenA0dPDuZTdV4ucjAh+wTdWl/kErLzCPWkkZzucuDHqphqEzIAi1rlD+zlF9I
	 jZbT7pOyLvrkRzLLOTAN/e8eUY7VmNx8trPFMusldNmpR+w/EoXuyjzvyXgsfDcfyD
	 zqCB28Mk1euIxBZXSb4mtHqnpc994Ka6/GLqYwCJv0nG3uD5CwLDiWIULcpYGkyeEQ
	 OJRMAQpDV04JA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:35 +0200
Subject: [PATCH 21/24] coredump: add coredump_cleanup()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-21-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZyYfe02ChAuwU7/oqtTlfiTFF8IxyFojUGr98qwcbkY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVnqLV+42Lju0JvmfDDb4nLnybPPJS/mW+uEsu99
 E9NJ58FdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWwIF6cATMSggpFh+zQF9V0yub9SAj/I
 bVNO3ND2S/z6FtGCzH9PutnaFn1LZGR4nJmhM3N5+PaNBxi3d4XkvOe+vHK+2I4J1vPvG+rN27y
 dCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0ad0f29a350d..d469ee290246 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1067,6 +1067,18 @@ static bool coredump_write(struct core_name *cn,
 	return true;
 }
 
+static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
+{
+	if (cprm->file)
+		filp_close(cprm->file, NULL);
+	if (cn->core_pipe_limit) {
+		VFS_WARN_ON_ONCE(cn->core_type != COREDUMP_PIPE);
+		atomic_dec(&core_pipe_count);
+	}
+	kfree(cn->corename);
+	coredump_finish(cn->core_dumped);
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -1119,7 +1131,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	if (!coredump_parse(&cn, &cprm, &argv, &argc)) {
 		coredump_report_failure("format_corename failed, aborting core");
-		goto fail_unlock;
+		goto close_fail;
 	}
 
 	switch (cn.core_type) {
@@ -1182,15 +1194,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 close_fail:
-	if (cprm.file)
-		filp_close(cprm.file, NULL);
-	if (cn.core_pipe_limit) {
-		VFS_WARN_ON_ONCE(cn.core_type != COREDUMP_PIPE);
-		atomic_dec(&core_pipe_count);
-	}
-fail_unlock:
-	kfree(cn.corename);
-	coredump_finish(cn.core_dumped);
+	coredump_cleanup(&cn, &cprm);
 	revert_creds(old_cred);
 	return;
 }

-- 
2.47.2


