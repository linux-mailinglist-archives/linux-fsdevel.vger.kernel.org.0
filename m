Return-Path: <linux-fsdevel+bounces-47915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CAAA7265
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228D7188FD89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262A25524D;
	Fri,  2 May 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilvkt6di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D8D248F46;
	Fri,  2 May 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189774; cv=none; b=hbQTGr7w5L/rUQrXrZ2YXuLotwcbBjtq+Jkf8zDTG4NV0YYHdjuzoTQBFQ2PDNXtRf5dM8+eoJInvMU9Rr2RgjkjhBrsbB1e9FhKEYP8ioO08YABEubrCkgpANAaAbEsHTy9KKddJlypA2Q1cDtR7Ll6qy92Ub0UA8pK/AXhD74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189774; c=relaxed/simple;
	bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvAUSQ9Rj9rvD26moYg7rupggyz9p0FjcbPhGHEc8ulMUpKDa+L88SmzA5PIRfxeFs5ePYndfwsUOKBWtdD+XuG46qiuxvhQ0jIDhA62xmCGrpLeL09WNPKfiRJNRS5iTbmO7mXThmtyYCCj+9TKYy/DKHONzY42MHK0zTWoe0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilvkt6di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D51EC4CEEB;
	Fri,  2 May 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189773;
	bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ilvkt6dinbQJBlCYAZYj+1+2FbQR9rqhlQ0M+gncmtxbrumdwgkCSZofmO34ZOUj7
	 mGGEHvnNnuexIbIWyjrHUbaCLkGjRiKfnsQU+SHk5NoayIgLLnJfnFLWpkvEGqQ4Wa
	 Nl4Y9zJKCq5br64R2jKvu+6S2AdD4XnAlSBQqnbX4LVH2G2/sNaP2y1cMr+1G5qqi8
	 BYHsgLDfELQXDWbOzwHLfci/XWxFbLYp2GONpFZLwGCvMUNmJbPvwAbQZESK8ryJgc
	 kt2Vp5Nvao2KGmivvcbxddDn7zefa/dhaXuQ4hA5D2Si9Wk0GktezuqZIM21OJbp2A
	 dd3tZX5QzlayA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 May 2025 14:42:33 +0200
Subject: [PATCH RFC v2 2/6] coredump: massage do_coredump()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-work-coredump-socket-v2-2-43259042ffc7@kernel.org>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4933; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7N2v8eF8qXy1LEvlm1uuAVNWz7kpvXbGlJpdqx/sW
 ZTp5m3xv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAij2YyMrw0+/JjidOuq+dP
 FqcHLXVVY7Q/n/LYTfaEyfpc5/7ZD+cyMjwyfm9kuPjBr6eTTBb1cMqufftE5FxTRcvBgtUSJpv
 T/VgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're going to extend the coredump code in follow-up patches.
Clean it up so we can do this more easily.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 123 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 66 insertions(+), 57 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 281320ea351f..1779299b8c61 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -646,63 +646,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		goto fail_unlock;
 	}
 
-	if (cn.core_type == COREDUMP_PIPE) {
-		int argi;
-		int dump_count;
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
-			goto fail_unlock;
-		}
-		cprm.limit = RLIM_INFINITY;
-
-		dump_count = atomic_inc_return(&core_dump_count);
-		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
-			coredump_report_failure("over core_pipe_limit, skipping core dump");
-			goto fail_dropcount;
-		}
-
-		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
-					    GFP_KERNEL);
-		if (!helper_argv) {
-			coredump_report_failure("%s failed to allocate memory", __func__);
-			goto fail_dropcount;
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
-	} else if (cn.core_type == COREDUMP_FILE) {
+	switch (cn.core_type) {
+	case COREDUMP_FILE: {
 		struct mnt_idmap *idmap;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
@@ -796,6 +741,70 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		if (do_truncate(idmap, cprm.file->f_path.dentry,
 				0, 0, cprm.file))
 			goto close_fail;
+		break;
+	}
+	case COREDUMP_PIPE: {
+		int argi;
+		int dump_count;
+		char **helper_argv;
+		struct subprocess_info *sub_info;
+
+		if (cprm.limit == 1) {
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
+			 *
+			 * Normally core limits are irrelevant to pipes, since
+			 * we're not writing to the file system, but we use
+			 * cprm.limit of 1 here as a special value, this is a
+			 * consistent way to catch recursive crashes.
+			 * We can still crash if the core_pattern binary sets
+			 * RLIM_CORE = !1, but it runs as root, and can do
+			 * lots of stupid things.
+			 *
+			 * Note that we use task_tgid_vnr here to grab the pid
+			 * of the process group leader.  That way we get the
+			 * right pid if a thread in a multi-threaded
+			 * core_pattern process dies.
+			 */
+			coredump_report_failure("RLIMIT_CORE is set to 1, aborting core");
+			goto fail_unlock;
+		}
+		cprm.limit = RLIM_INFINITY;
+
+		dump_count = atomic_inc_return(&core_dump_count);
+		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
+			coredump_report_failure("over core_pipe_limit, skipping core dump");
+			goto fail_dropcount;
+		}
+
+		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
+					    GFP_KERNEL);
+		if (!helper_argv) {
+			coredump_report_failure("%s failed to allocate memory", __func__);
+			goto fail_dropcount;
+		}
+		for (argi = 0; argi < argc; argi++)
+			helper_argv[argi] = cn.corename + argv[argi];
+		helper_argv[argi] = NULL;
+
+		retval = -ENOMEM;
+		sub_info = call_usermodehelper_setup(helper_argv[0],
+						helper_argv, NULL, GFP_KERNEL,
+						umh_coredump_setup, NULL, &cprm);
+		if (sub_info)
+			retval = call_usermodehelper_exec(sub_info,
+							  UMH_WAIT_EXEC);
+
+		kfree(helper_argv);
+		if (retval) {
+			coredump_report_failure("|%s pipe failed", cn.corename);
+			goto close_fail;
+		}
+		break;
+	}
+	default:
+		WARN_ON_ONCE(true);
+		retval = -EINVAL;
+		goto close_fail;
 	}
 
 	/* get us an unshared descriptor table; almost always a no-op */

-- 
2.47.2


