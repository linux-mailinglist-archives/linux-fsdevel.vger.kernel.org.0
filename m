Return-Path: <linux-fsdevel+bounces-51474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9FAAD71E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D530B3A2914
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4411925A62D;
	Thu, 12 Jun 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2rR3Zq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E815248886
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734757; cv=none; b=NIivqBcOhvpsnFY3wMoIOuGvnn6/ow4W0AHvrGuYZWT8+gtWhIY5TEahKp6ebzh4hHjS4Eb0LlnVlawgF0IzW1Rgq2cPsgOVQWEAkHqHp3yfiN8FkPeFOgwn6QlDRtjFamCZUH1IXyQh0Mb5RIbB3rYa/eDnEOTS7PC4A7Zf9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734757; c=relaxed/simple;
	bh=xIlgYDMqYkmnj0kr3tJRysutwVaxtq8S84NQB2Ics54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pi9F/9OtNIbC/y4/0ZTZR7nBQSVDAzajWnsU2qjOM/T0NejsHNuPftUv3XS6iR4UCrCgDXk3DPp23sTLhMTtiIMlqHOZf3Fq6UxmOKggua3mgukBATwUZ34Fvpj4U3WJh5f8FrvIKp+pCaZSKH+173YnzEddDZ4lHo/Csxa09Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2rR3Zq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A95C4CEEE;
	Thu, 12 Jun 2025 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734757;
	bh=xIlgYDMqYkmnj0kr3tJRysutwVaxtq8S84NQB2Ics54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C2rR3Zq3/C0NPtEkA+f/v3u2Zjkm5UlEUKbnsM1SlwTudy7uvFHdTl1w8cZ1g7Dyg
	 KC5OQSZHv3rcWnu1ZMSwKMthHLnGZ90lfm4nIyYcqDMORbuOhdxt2xu1wxuKM++gCE
	 ddq3fm+QjRetcoJZeSwyvHpr+uRVynJUN2CXzm4upI+96Dig8mnqkvXKADgxBd0MZr
	 Em56c9lysdWPUTGeoAP1078fIJfqlXBA+2YQbkyWtz7HsNt42He73NYodd/oRC78+z
	 CcB/wEO8Xi/QH4JBdGZiga+N6yFLDXvOBzVHLE02vK4HdPcLy0JrhdSro7QHNFJYvL
	 POE8X8mJeV2zw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:27 +0200
Subject: [PATCH 13/24] coredump: split pipe coredumping into
 coredump_pipe()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-13-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=4825; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xIlgYDMqYkmnj0kr3tJRysutwVaxtq8S84NQB2Ics54=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVf62R/Yum9LduOHFd5+eLl+88BFY+5npfo6Fy0P
 H1RKEN/bUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEDnIz/BUJ/HGd/cCmzJMH
 TVUYdK6slrm5yflx+ydzxc/H1t+2zT/LyPD07cMVl/fbFW29bXv4V4YeM9/K+FW7oxODW3na2e3
 ex/IDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

* Move that whole mess into a separate helper instead of having all that
  hanging around in vfs_coredump() directly. Cleanup paths are already
  centralized.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 114 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c863e053b1f8..081b5e9d16e2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -970,6 +970,63 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 	return true;
 }
 
+static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
+			  size_t *argv, int argc)
+{
+	int argi;
+	char **helper_argv __free(kfree) = NULL;
+	struct subprocess_info *sub_info;
+
+	if (cprm->limit == 1) {
+		/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
+		 *
+		 * Normally core limits are irrelevant to pipes, since
+		 * we're not writing to the file system, but we use
+		 * cprm.limit of 1 here as a special value, this is a
+		 * consistent way to catch recursive crashes.
+		 * We can still crash if the core_pattern binary sets
+		 * RLIM_CORE = !1, but it runs as root, and can do
+		 * lots of stupid things.
+		 *
+		 * Note that we use task_tgid_vnr here to grab the pid
+		 * of the process group leader.  That way we get the
+		 * right pid if a thread in a multi-threaded
+		 * core_pattern process dies.
+		 */
+		coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
+		return false;
+	}
+	cprm->limit = RLIM_INFINITY;
+
+	cn->core_pipe_limit = atomic_inc_return(&core_pipe_count);
+	if (core_pipe_limit && (core_pipe_limit < cn->core_pipe_limit)) {
+		coredump_report_failure("over core_pipe_limit, skipping core dump");
+		return false;
+	}
+
+	helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv), GFP_KERNEL);
+	if (!helper_argv) {
+		coredump_report_failure("%s failed to allocate memory", __func__);
+		return false;
+	}
+	for (argi = 0; argi < argc; argi++)
+		helper_argv[argi] = cn->corename + argv[argi];
+	helper_argv[argi] = NULL;
+
+	sub_info = call_usermodehelper_setup(helper_argv[0], helper_argv, NULL,
+					     GFP_KERNEL, umh_coredump_setup,
+					     NULL, cprm);
+	if (!sub_info)
+		return false;
+
+	if (!call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
+		coredump_report_failure("|%s pipe failed", cn->corename);
+		return false;
+	}
+
+	return true;
+}
+
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -1031,63 +1088,10 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		if (!coredump_file(&cn, &cprm, binfmt))
 			goto close_fail;
 		break;
-	case COREDUMP_PIPE: {
-		int argi;
-		char **helper_argv;
-		struct subprocess_info *sub_info;
-
-		if (cprm.limit == 1) {
-			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
-			 *
-			 * Normally core limits are irrelevant to pipes, since
-			 * we're not writing to the file system, but we use
-			 * cprm.limit of 1 here as a special value, this is a
-			 * consistent way to catch recursive crashes.
-			 * We can still crash if the core_pattern binary sets
-			 * RLIM_CORE = !1, but it runs as root, and can do
-			 * lots of stupid things.
-			 *
-			 * Note that we use task_tgid_vnr here to grab the pid
-			 * of the process group leader.  That way we get the
-			 * right pid if a thread in a multi-threaded
-			 * core_pattern process dies.
-			 */
-			coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
-			goto close_fail;
-		}
-		cprm.limit = RLIM_INFINITY;
-
-		cn.core_pipe_limit = atomic_inc_return(&core_pipe_count);
-		if (core_pipe_limit && (core_pipe_limit < cn.core_pipe_limit)) {
-			coredump_report_failure("over core_pipe_limit, skipping core dump");
+	case COREDUMP_PIPE:
+		if (!coredump_pipe(&cn, &cprm, argv, argc))
 			goto close_fail;
-		}
-
-		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
-					    GFP_KERNEL);
-		if (!helper_argv) {
-			coredump_report_failure("%s failed to allocate memory", __func__);
-			goto close_fail;
-		}
-		for (argi = 0; argi < argc; argi++)
-			helper_argv[argi] = cn.corename + argv[argi];
-		helper_argv[argi] = NULL;
-
-		retval = -ENOMEM;
-		sub_info = call_usermodehelper_setup(helper_argv[0],
-						helper_argv, NULL, GFP_KERNEL,
-						umh_coredump_setup, NULL, &cprm);
-		if (sub_info)
-			retval = call_usermodehelper_exec(sub_info,
-							  UMH_WAIT_EXEC);
-
-		kfree(helper_argv);
-		if (retval) {
-			coredump_report_failure("|%s pipe failed", cn.corename);
-			goto close_fail;
-		}
 		break;
-	}
 	case COREDUMP_SOCK_REQ:
 		fallthrough;
 	case COREDUMP_SOCK:

-- 
2.47.2


