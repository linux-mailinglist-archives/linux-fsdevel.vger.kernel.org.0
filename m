Return-Path: <linux-fsdevel+bounces-49241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F6EAB9AEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8837B50418E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E1239E64;
	Fri, 16 May 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAJEYftS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF53205502;
	Fri, 16 May 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394752; cv=none; b=p7EdDWvIO2Nwt4zoRo7ie/uD4nBijyvLfTKXrghQGSm0bi1aW69uzfaGPk1yEOxNV24jSglSiN0095qb5TFnGfccC0SPB/KsQhvKViSl5JCAuYr7aVUgoB6vy3kfew4+TVgbD+YtFbjg0E5y/NOnN9acxhEntx8AZyYfYm/L5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394752; c=relaxed/simple;
	bh=aEsNIF9y6JxcvOwyyzzXZ1H3HPtUSep+0f3agKGpmcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nciB7KmLkuYvWKdeGkWCbDiNlildFOdD5S2Sb8Mmh7/K/Z4PW2ZbGTAylPSGJ8fe2YUg5mmbGn/mnlFr9BYbohwp8VXDPoNOcOpZLiNr0rZYuFMy5Mkn3OAyER4bSvIUe+TYW4g0kqC6/by4f6Pn709RWQDR4SRjjjrb1IC1vPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAJEYftS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98753C4CEE4;
	Fri, 16 May 2025 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394752;
	bh=aEsNIF9y6JxcvOwyyzzXZ1H3HPtUSep+0f3agKGpmcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pAJEYftSqS3wkN3BRYgU3SIPkSLTPQNiSALKSkPtRAypqJ4ukWIB5If3C4d+RLXCd
	 ehiy2COgUCbUcdzPaT6slmiIIe5sslmzE2TLRGT9dDbChRZ7AK+rJS5ekSscvIzuPu
	 tJbUXmEfWnZywVf1+MCRmhD5zP9eMNJnFErqgTOSTseNgsvbwvgfbG0tP1pB9zh0MD
	 hKFDqowhqAAizpbkxuHMD7fORZ/POBpbaTeIp7/TfbdWcSU5LwIXvuG+Pk90H6EPdT
	 FxQyiWNShNZBgEuLitSC6C7MioiSjv6sv6wn8aREMWYwIMxhRvFDTnpFnWp4zhx6NP
	 XpClbpocZ7aww==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 16 May 2025 13:25:28 +0200
Subject: [PATCH v8 1/9] coredump: massage format_corename()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-work-coredump-socket-v8-1-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Serge Hallyn <serge@hallyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=4920; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aEsNIF9y6JxcvOwyyzzXZ1H3HPtUSep+0f3agKGpmcE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2zNll65uP+fdZW3UFZK/p59S8oP58Rbcn4XiLvP+
 PS7maduRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERuBjIy7FjvxCGluG+Z5wan
 3rA1kYHqrQ5TwgNdzsWnKxx4YbZFlJHh0Mwfd4QPzuY8MmOys0n/h8nCR9+e/v6vKNlHY86UlZ4
 zOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're going to extend the coredump code in follow-up patches.
Clean it up so we can do this more easily.

Acked-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d740a0411266..45725465c299 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -76,9 +76,15 @@ static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 
+enum coredump_type_t {
+	COREDUMP_FILE = 1,
+	COREDUMP_PIPE = 2,
+};
+
 struct core_name {
 	char *corename;
 	int used, size;
+	enum coredump_type_t core_type;
 };
 
 static int expand_corename(struct core_name *cn, int size)
@@ -218,18 +224,21 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 {
 	const struct cred *cred = current_cred();
 	const char *pat_ptr = core_pattern;
-	int ispipe = (*pat_ptr == '|');
 	bool was_space = false;
 	int pid_in_pattern = 0;
 	int err = 0;
 
 	cn->used = 0;
 	cn->corename = NULL;
+	if (*pat_ptr == '|')
+		cn->core_type = COREDUMP_PIPE;
+	else
+		cn->core_type = COREDUMP_FILE;
 	if (expand_corename(cn, core_name_size))
 		return -ENOMEM;
 	cn->corename[0] = '\0';
 
-	if (ispipe) {
+	if (cn->core_type == COREDUMP_PIPE) {
 		int argvs = sizeof(core_pattern) / 2;
 		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
 		if (!(*argv))
@@ -247,7 +256,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		 * Split on spaces before doing template expansion so that
 		 * %e and %E don't get split if they have spaces in them
 		 */
-		if (ispipe) {
+		if (cn->core_type == COREDUMP_PIPE) {
 			if (isspace(*pat_ptr)) {
 				if (cn->used != 0)
 					was_space = true;
@@ -353,7 +362,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 				 * Installing a pidfd only makes sense if
 				 * we actually spawn a usermode helper.
 				 */
-				if (!ispipe)
+				if (cn->core_type != COREDUMP_PIPE)
 					break;
 
 				/*
@@ -384,12 +393,9 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	 * If core_pattern does not include a %p (as is the default)
 	 * and core_uses_pid is set, then .%pid will be appended to
 	 * the filename. Do not do this for piped commands. */
-	if (!ispipe && !pid_in_pattern && core_uses_pid) {
-		err = cn_printf(cn, ".%d", task_tgid_vnr(current));
-		if (err)
-			return err;
-	}
-	return ispipe;
+	if (cn->core_type == COREDUMP_FILE && !pid_in_pattern && core_uses_pid)
+		return cn_printf(cn, ".%d", task_tgid_vnr(current));
+	return 0;
 }
 
 static int zap_process(struct signal_struct *signal, int exit_code)
@@ -583,7 +589,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	const struct cred *old_cred;
 	struct cred *cred;
 	int retval = 0;
-	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
 	/* require nonrelative corefile path and be extra careful */
@@ -632,19 +637,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	ispipe = format_corename(&cn, &cprm, &argv, &argc);
+	retval = format_corename(&cn, &cprm, &argv, &argc);
+	if (retval < 0) {
+		coredump_report_failure("format_corename failed, aborting core");
+		goto fail_unlock;
+	}
 
-	if (ispipe) {
+	if (cn.core_type == COREDUMP_PIPE) {
 		int argi;
 		int dump_count;
 		char **helper_argv;
 		struct subprocess_info *sub_info;
 
-		if (ispipe < 0) {
-			coredump_report_failure("format_corename failed, aborting core");
-			goto fail_unlock;
-		}
-
 		if (cprm.limit == 1) {
 			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
@@ -695,7 +699,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			coredump_report_failure("|%s pipe failed", cn.corename);
 			goto close_fail;
 		}
-	} else {
+	} else if (cn.core_type == COREDUMP_FILE) {
 		struct mnt_idmap *idmap;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
@@ -823,13 +827,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
 	}
-	if (ispipe && core_pipe_limit)
+	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
 fail_dropcount:
-	if (ispipe)
+	if (cn.core_type == COREDUMP_PIPE)
 		atomic_dec(&core_dump_count);
 fail_unlock:
 	kfree(argv);

-- 
2.47.2


