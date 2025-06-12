Return-Path: <linux-fsdevel+bounces-51463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5374AD71CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B5817B71E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044F253F08;
	Thu, 12 Jun 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyFn9v/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B8248884
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734734; cv=none; b=NxktEPCT9fpWkTQ0nzKdxlg+QxM/36VD6JyJd5DWcUjvn6j+co4TkzS3i2gUffG9Sgu72+U4QM83TLipmRWSzDgzgFywldYI5d7El9cWRHCznBN83WGZXvK0qOtU6BvZPrunYEgLCUrPgCWvP8SvHLoPUcdRj6WBob0W5PkmWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734734; c=relaxed/simple;
	bh=u8xA3HQER+uL20YPMpSX7zopOKKlIfEWAIaQ9JoCGWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4zAt9WhdN3+0OlwEe4CeFQJQ05Ax3qVxO7u/9sae8T3cenCFOZrX7DygFpJ0F6vcHuW9bXoEOVHu8Wswwyedz067ks7+3Z6FeZIyx03D1laxvo7w1mtquqbTzirC+al9MxY1qcn33GSb8bZ4z52h4+z5/FEXho39i/HDuQiSfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyFn9v/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC85C4CEEA;
	Thu, 12 Jun 2025 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734734;
	bh=u8xA3HQER+uL20YPMpSX7zopOKKlIfEWAIaQ9JoCGWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JyFn9v/jETQGX4ZS3+804b+mBQN6Rev78Cc3RxRja+g7XrlmsZceLnpj/22S7kwJ8
	 hTrAcz0VxFokvIZ1zS+5hCFDh5gRLMEBih50InKBuGDvl0Z9Jaza2Qlx6LglVsFBdV
	 1T12CAONzaGCxw8acluyZdQ330c9VAm1815qQNPRnS0hcqwk49Or8i1h4S4GvWB8Ab
	 AQxZi+WXVTfGbM99LYJW4oyx9EVSR7LP0Oi+eVxFr6roYGelIGXI56IPq5kS4Rx5G9
	 daN7XEpmq/eQeUiDjQ9C1Jf9sclz/0tYACGOn9zIIw4Cs95VqWITVh6ZXnezxvLnNY
	 8CmAnvCHn7SCQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:16 +0200
Subject: [PATCH 02/24] coredump: make coredump_parse() return bool
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-2-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u8xA3HQER+uL20YPMpSX7zopOKKlIfEWAIaQ9JoCGWU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXWTaZ52zveQT/h/2z+P1eTOXTp0/kjLgy21Cperd
 r//5lqT1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARluWMDL/1Yq8YLFOo2VBy
 ffV+ifzlV754KuVtbhHsyrWZwnxG04SRYeWF0gOVf5c63uMU+d//b9Yjt2c9l/qm2vNwunMyLjZ
 4zwUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point in returning negative error values.
They will never be seen by anyone.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 79a3c8141e8c..42ceb9db2a5a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -230,8 +230,8 @@ static int cn_print_exe_file(struct core_name *cn, bool name_only)
  * into corename, which must have space for at least CORENAME_MAX_SIZE
  * bytes plus one byte for the zero terminator.
  */
-static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
-			  size_t **argv, int *argc)
+static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
+			   size_t **argv, int *argc)
 {
 	const struct cred *cred = current_cred();
 	const char *pat_ptr = core_pattern;
@@ -251,7 +251,7 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	else
 		cn->core_type = COREDUMP_FILE;
 	if (expand_corename(cn, core_name_size))
-		return -ENOMEM;
+		return false;
 	cn->corename[0] = '\0';
 
 	switch (cn->core_type) {
@@ -259,33 +259,33 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 		int argvs = sizeof(core_pattern) / 2;
 		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
 		if (!(*argv))
-			return -ENOMEM;
+			return false;
 		(*argv)[(*argc)++] = 0;
 		++pat_ptr;
 		if (!(*pat_ptr))
-			return -ENOMEM;
+			return false;
 		break;
 	}
 	case COREDUMP_SOCK: {
 		/* skip the @ */
 		pat_ptr++;
 		if (!(*pat_ptr))
-			return -ENOMEM;
+			return false;
 		if (*pat_ptr == '@') {
 			pat_ptr++;
 			if (!(*pat_ptr))
-				return -ENOMEM;
+				return false;
 
 			cn->core_type = COREDUMP_SOCK_REQ;
 		}
 
 		err = cn_printf(cn, "%s", pat_ptr);
 		if (err)
-			return err;
+			return false;
 
 		/* Require absolute paths. */
 		if (cn->corename[0] != '/')
-			return -EINVAL;
+			return false;
 
 		/*
 		 * Ensure we can uses spaces to indicate additional
@@ -293,7 +293,7 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 		 */
 		if (strchr(cn->corename, ' ')) {
 			coredump_report_failure("Coredump socket may not %s contain spaces", cn->corename);
-			return -EINVAL;
+			return false;
 		}
 
 		/*
@@ -303,13 +303,13 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 		 * via /proc/<pid>, using the SO_PEERPIDFD to guard
 		 * against pid recycling when opening /proc/<pid>.
 		 */
-		return 0;
+		return true;
 	}
 	case COREDUMP_FILE:
 		break;
 	default:
 		WARN_ON_ONCE(true);
-		return -EINVAL;
+		return false;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -447,7 +447,7 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 		}
 
 		if (err)
-			return err;
+			return false;
 	}
 
 out:
@@ -457,9 +457,9 @@ static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	 * and core_uses_pid is set, then .%pid will be appended to
 	 * the filename. Do not do this for piped commands. */
 	if (cn->core_type == COREDUMP_FILE && !pid_in_pattern && core_uses_pid)
-		return cn_printf(cn, ".%d", task_tgid_vnr(current));
+		return cn_printf(cn, ".%d", task_tgid_vnr(current)) == 0;
 
-	return 0;
+	return true;
 }
 
 static int zap_process(struct signal_struct *signal, int exit_code)
@@ -911,8 +911,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	retval = coredump_parse(&cn, &cprm, &argv, &argc);
-	if (retval < 0) {
+	if (!coredump_parse(&cn, &cprm, &argv, &argc)) {
 		coredump_report_failure("format_corename failed, aborting core");
 		goto fail_unlock;
 	}

-- 
2.47.2


