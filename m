Return-Path: <linux-fsdevel+bounces-48398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43512AAE64E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D108C4C298C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71E28C853;
	Wed,  7 May 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9wb1YsN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1E28B7FA;
	Wed,  7 May 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634437; cv=none; b=mdEB8TNLpc1OQ81cQ3pkkpnR7MOdAKJI1jNpPJ6Tpo7a+0Ny+uSWI1kMSrsaNAgMvn4PTiDXXDgUQJv22KUE51JEeqx+F7WgYkB8qLWGi8YJlyL4p/XHqtnKu+Rndwas2vKZ6Y/IptexbZe+yNYj8nDBDlgFT2aQY++Sszu0bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634437; c=relaxed/simple;
	bh=fEpmDQLWLttpCZqCdebailDPLzOF/JIhp5x6zzfJN4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGtbO+GPhb7NRYzzOhXFaak0bocOnH4zZX3oOpoch50Z+JDnEIZcQXpbQP/xDGMIyz1xO2/2yGSybF5Y2JOYbIgyuKmeS/XfmxC2FQ98yypld5pTaNIgAhFkKuT4Tx2FiPfwKbMuSCE40xNw0+GU+YMM2OBZp+cKlCUWlQIh5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9wb1YsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5E5C4CEE2;
	Wed,  7 May 2025 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634435;
	bh=fEpmDQLWLttpCZqCdebailDPLzOF/JIhp5x6zzfJN4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T9wb1YsNd+CmcorZNNFfVSCWuLnbYPxwlk8NpmGEsCiIVKGlt+DuCNeE04DzOssDz
	 UpWWy027Q6rjh0OQktjX7Uf00Po9Wwt6hGrlcpY0Sx6mcAgfxvz/KUWX/5135H1kpc
	 FGmb7+B1ke4feR07wafyumYuKuCB0r6V7rUYj6ulPSM2nCdBJqjDDSLg4IlzJFnInj
	 4uzGLpd9FbY0hUfvokj7WCIdAIbOPvwWHxKPi51JWUbXviCx5dzGtN/ZDpRhRn+JVT
	 tZIjurJtihDBnBeh62C23jn9aOKFOUX7AFbuNmJ4/0tzi5UD4/+vYh7giPe/8bf9CJ
	 dIMNAJWdmvNmg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:35 +0200
Subject: [PATCH v4 02/11] coredump: massage do_coredump()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-2-af0ef317b2d0@kernel.org>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
In-Reply-To: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4911; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fEpmDQLWLttpCZqCdebailDPLzOF/JIhp5x6zzfJN4U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt219cMiUxez4DjNHwS3du7307jLXZVUVuR6509eWs
 iedf691RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETybjMy/D+geDvhh8lF5U6n
 FL4n0tKtO+4mu3zmWP9rW1zblUrD2Qx/RXqedq9065vJJefZvrXeJ+qoeuqfJg/9qMybuoEfT/b
 xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're going to extend the coredump code in follow-up patches.
Clean it up so we can do this more easily.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 122 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 281320ea351f..41491dbfafdf 100644
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
@@ -796,6 +741,69 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
+		goto close_fail;
 	}
 
 	/* get us an unshared descriptor table; almost always a no-op */

-- 
2.47.2


