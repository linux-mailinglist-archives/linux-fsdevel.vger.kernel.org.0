Return-Path: <linux-fsdevel+bounces-48055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F2AA91BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3833A3BA769
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D3208961;
	Mon,  5 May 2025 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkjSkPhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A9282EE;
	Mon,  5 May 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746443644; cv=none; b=J6kCKcA9joh4YGsLnVYsID8KB2kixBihw1jlbI41tUrX/QIvlnHQ+hJOgXLWTXOc50bBVs3ZI4CSwD5YVfFNYHiLT2zGWXz95wOGcS5gw7OtRCOsAQiWisc+dDRz4P7hFhMi+vRqeQG4jeJqtzOUmtC+N7nM8X9PZ6dEG4hk+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746443644; c=relaxed/simple;
	bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUWmYn5X528XLlehdI3ymxGtW4B4C48uRpB/drLEpiQdoiSrUD/UqtSpfCYLQZzCPx1SJxaJDr5g6jea0l5HzBe3Dss+kL/rFwDDU2EtrHnW63+hKToW56qcOej99NTGMt23s+LIZ8hydMu7EnF1SnhmWC+KboZ9tdtJlLTcvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkjSkPhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0224C4CEF6;
	Mon,  5 May 2025 11:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746443644;
	bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DkjSkPhNx+2WHsjnkemPSKwEKlYmWiVFAjCsefhgqCjdo1xJj6bcJNeA2a8Ou2WKA
	 SURnXWsH2M/UdG56h7kNdGeLQWLbhG4pVajNe7U5lxizSsAvAGdgGs2MikY/xJr+/x
	 49KBSqPzPrCV+J/KU+8/tKqR+s4rdQT5Ygb0H5TW6cV6vJjsLA8nFJPRwdXQ7c8TlA
	 2Qhz3ASB81qh7v1qNZ++XJHsux+tdpnjRHW6cH1JNv4NvtsAIC7/afpTHvsw3fNVep
	 6/PmZKvgV5eqYk6wfd7cfgvavvzCtdsjn3baLvq2PprT/r7RUXCdOEitX/++gB9xNF
	 zH97+ePNwENfg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 05 May 2025 13:13:40 +0200
Subject: [PATCH RFC v3 02/10] coredump: massage do_coredump()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-work-coredump-socket-v3-2-e1832f0e1eae@kernel.org>
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4933; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sY3uIB6g6xsWBkS/M2/GrdpdnZH6W10Su5t41D1OTEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIzM1VmvSjT9vAUM2qf//zapt/V2/L/b+o/dfh49EJH
 //wpGYKdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykO5+R4VPHvy2sy7kMJSze
 ShS25Hx7wcP+9Oqn6T8uvVj7aZfIXQ+G/9Xd8p6LNIV+nLy1XWY/R/2Fud37j99886DNzt9l/8r
 vj/kA
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


