Return-Path: <linux-fsdevel+bounces-66813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49070C2CA50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78A714F04ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54061334387;
	Mon,  3 Nov 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2N09nCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599D3191D8;
	Mon,  3 Nov 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181896; cv=none; b=N8CbbLnn8Dmpipf4hlqyVNyl1TSzvNS7Bc/xrQUCIvwKdyIkd2Ba6/biWlokCkNcEoDrUQZlW3uJQymIZebDKGfEdxb+Regd9cwjrdVoVSXhSpxOMJ/wuSRxmszqkgo4KjUr6auOlcoIxSD1bNGdPUKe2150vDVFjY578efwHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181896; c=relaxed/simple;
	bh=3SOHcCNtJai0jiEeFwDApQD/S8x6jH+uzaK2QaiBxx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cXauWhcCHeUvDSgXKoSCEQ8rAQg4VHgVMHKBUhkPHv4sIeOELkHoY4yYgTtLIiCUGs/706qxrifEXMjenNVAY+5o9MfjntfLz6Irx9uciqY//o7iHRxjvQok2PoYVjE04fgEIr32pnZoOIlhGrx7AHimxBU6UJAnsOBNfBZUcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2N09nCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18630C4CEFD;
	Mon,  3 Nov 2025 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181896;
	bh=3SOHcCNtJai0jiEeFwDApQD/S8x6jH+uzaK2QaiBxx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C2N09nCE2+2V+HW48Wm/8xl8T3Vs8shmBL2PzA64cpY2NjZv0TZ1uBu113H5CVGUs
	 EIyuggylugy1YAjqFJ0MnPVsslM9K1zthxOVsJAaezo2jCSqpPZh7Tbnj8HidnJ0TL
	 7c4Jzs/R/fB+qKavyrWiLeVudH93nJTZddLVeumTJXbyrKouxsaiimk9gBmosy2RUg
	 cnYZJP8rHuq+nlQL0IEmY/WnyYSG+gLwW/Zj7U921FCiFxyaiaunfjlGlODqdahK8m
	 SIoYI+3SzIj9gb4JTV/Cq8k7QI7yoz2habV+V908LDCAsoWQfTf5MRgBq7IfvbK1ZG
	 wuuNTqG+YFw2w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:34 +0100
Subject: [PATCH 08/12] coredump: split out do_coredump() from
 vfs_coredump()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-8-b447b82f2c9b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4185; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3SOHcCNtJai0jiEeFwDApQD/S8x6jH+uzaK2QaiBxx8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrpENDx8pHFoi2H5317oP34Z/jR3KMOi5/83viya
 RrDlOUfJnWUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMROsmw3/nghPNR/u3azIl
 LkpZocCh1tZ2Zx//pAsrTy1+G7vjTawRwz8F5ZnNO/Ylyd7eMoO7/eC3E+zhHy+93lWTrjH9glk
 VpzI/AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make the function easier to follow and prepare for some of the following
changes.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 131 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 68 insertions(+), 63 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 8253b28bc728..79c681f1d647 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1086,6 +1086,73 @@ static inline bool coredump_skip(const struct coredump_params *cprm,
 	return false;
 }
 
+static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
+			size_t **argv, int *argc, const struct linux_binfmt *binfmt)
+{
+	if (!coredump_parse(cn, cprm, argv, argc)) {
+		coredump_report_failure("format_corename failed, aborting core");
+		return;
+	}
+
+	switch (cn->core_type) {
+	case COREDUMP_FILE:
+		if (!coredump_file(cn, cprm, binfmt))
+			return;
+		break;
+	case COREDUMP_PIPE:
+		if (!coredump_pipe(cn, cprm, *argv, *argc))
+			return;
+		break;
+	case COREDUMP_SOCK_REQ:
+		fallthrough;
+	case COREDUMP_SOCK:
+		if (!coredump_socket(cn, cprm))
+			return;
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return;
+	}
+
+	/* Don't even generate the coredump. */
+	if (cn->mask & COREDUMP_REJECT)
+		return;
+
+	/* get us an unshared descriptor table; almost always a no-op */
+	/* The cell spufs coredump code reads the file descriptor tables */
+	if (unshare_files())
+		return;
+
+	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
+		return;
+
+	coredump_sock_shutdown(cprm->file);
+
+	/* Let the parent know that a coredump was generated. */
+	if (cn->mask & COREDUMP_USERSPACE)
+		cn->core_dumped = true;
+
+	/*
+	 * When core_pipe_limit is set we wait for the coredump server
+	 * or usermodehelper to finish before exiting so it can e.g.,
+	 * inspect /proc/<pid>.
+	 */
+	if (cn->mask & COREDUMP_WAIT) {
+		switch (cn->core_type) {
+		case COREDUMP_PIPE:
+			wait_for_dump_helpers(cprm->file);
+			break;
+		case COREDUMP_SOCK_REQ:
+			fallthrough;
+		case COREDUMP_SOCK:
+			coredump_sock_wait(cprm->file);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct cred *cred __free(put_cred) = NULL;
@@ -1133,70 +1200,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	if (!coredump_parse(&cn, &cprm, &argv, &argc)) {
-		coredump_report_failure("format_corename failed, aborting core");
-		goto close_fail;
-	}
-
-	switch (cn.core_type) {
-	case COREDUMP_FILE:
-		if (!coredump_file(&cn, &cprm, binfmt))
-			goto close_fail;
-		break;
-	case COREDUMP_PIPE:
-		if (!coredump_pipe(&cn, &cprm, argv, argc))
-			goto close_fail;
-		break;
-	case COREDUMP_SOCK_REQ:
-		fallthrough;
-	case COREDUMP_SOCK:
-		if (!coredump_socket(&cn, &cprm))
-			goto close_fail;
-		break;
-	default:
-		WARN_ON_ONCE(true);
-		goto close_fail;
-	}
-
-	/* Don't even generate the coredump. */
-	if (cn.mask & COREDUMP_REJECT)
-		goto close_fail;
-
-	/* get us an unshared descriptor table; almost always a no-op */
-	/* The cell spufs coredump code reads the file descriptor tables */
-	if (unshare_files())
-		goto close_fail;
-
-	if ((cn.mask & COREDUMP_KERNEL) && !coredump_write(&cn, &cprm, binfmt))
-		goto close_fail;
-
-	coredump_sock_shutdown(cprm.file);
-
-	/* Let the parent know that a coredump was generated. */
-	if (cn.mask & COREDUMP_USERSPACE)
-		cn.core_dumped = true;
-
-	/*
-	 * When core_pipe_limit is set we wait for the coredump server
-	 * or usermodehelper to finish before exiting so it can e.g.,
-	 * inspect /proc/<pid>.
-	 */
-	if (cn.mask & COREDUMP_WAIT) {
-		switch (cn.core_type) {
-		case COREDUMP_PIPE:
-			wait_for_dump_helpers(cprm.file);
-			break;
-		case COREDUMP_SOCK_REQ:
-			fallthrough;
-		case COREDUMP_SOCK:
-			coredump_sock_wait(cprm.file);
-			break;
-		default:
-			break;
-		}
-	}
+	do_coredump(&cn, &cprm, &argv, &argc, binfmt);
 
-close_fail:
 	revert_creds(old_cred);
 	coredump_cleanup(&cn, &cprm);
 	return;

-- 
2.47.3


