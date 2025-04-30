Return-Path: <linux-fsdevel+bounces-47715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D7AA4978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7540E162A35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796B25A633;
	Wed, 30 Apr 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8+kB8Ow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3525A341;
	Wed, 30 Apr 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011137; cv=none; b=iR1d2BeRW56/WcR58kuQyq9puW8mplWJcD6O9o4cwgDCso8Y91F62NPBxIwNLomfABawBf4ofS1sNdhNJPQvBYdSZVQNtDjIHTk+BCuAut5y6l/s4YBGDS/oibTInvyYg07OmTyIOuOnBW3azbgb/MC9QkgHCxyF4GH2xFO7LgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011137; c=relaxed/simple;
	bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaCjihb/x3djaqPMhKgX1o0BMoEe8Tqjt2vBhvIyAxp7H/qts7IQxCweNvuDxqnBG1qOS3sOx8zXzGiR7RlGgPiaSVyF8mMFbHuBxVAw4GgOTJla6b2owhr5x3rpsnO7wijF3q9oUadCNGQODGmUlIMrL7qA4GtLk3WZGfFLVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8+kB8Ow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1689DC4CEEA;
	Wed, 30 Apr 2025 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746011137;
	bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r8+kB8OwWOnmELOGL1aMYIB14NUMkbyotvFN0u77g3jppiJ2JT4ZgIkT7FtCHQNQg
	 m2bno3x/v0itoVY5Qh5kwSaH03/P6tCh0GCP1Igz3mEi8Q8LjO+IG0urqA9i52aLJD
	 y/Pl5+jnlFftnWFxaadbpAaTyrsbnZKcBh8yMcrNzemdd9XfXA9dFN5kE6odIo9k1g
	 Lsaa5JCanLSZ4N9lCVwYR4DzfYf2/KwBml0EhcE6FvXJOinmGYAMwBQb1xozjNXAhn
	 w4+VUq9kqFTZfxsgCg4XOESiqcP+9gSYXhHvGqX2gJFiKds+b/7rjP7ES9tFAHTf8h
	 1I+O6QQLBLJSw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Apr 2025 13:05:01 +0200
Subject: [PATCH RFC 1/3] coredump: massage format_corname()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-work-coredump-socket-v1-1-2faf027dbb47@kernel.org>
References: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
In-Reply-To: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Oleg Nesterov <oleg@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4656; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQIMX+/oCcqWRK6yC0l40be4216qzqCOePOH3O7slphx
 spfPAFuHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5uoyRYaZDXfmEwD2Zr1cv
 izz9Qv7rT1X+JYU7XxRdYQ7Z8mOzpzvD/7SedYLTvG4+XWnaXLjmZRene0rYIQuhGY4WJhN2PH7
 qwAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're going to extend the coredump code in follow-up patches.
Clean it up so we can do this more easily.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d740a0411266..281320ea351f 100644
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
+				if (!(cn->core_type != COREDUMP_PIPE))
 					break;
 
 				/*
@@ -384,12 +393,12 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	 * If core_pattern does not include a %p (as is the default)
 	 * and core_uses_pid is set, then .%pid will be appended to
 	 * the filename. Do not do this for piped commands. */
-	if (!ispipe && !pid_in_pattern && core_uses_pid) {
+	if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
 		err = cn_printf(cn, ".%d", task_tgid_vnr(current));
 		if (err)
 			return err;
 	}
-	return ispipe;
+	return 0;
 }
 
 static int zap_process(struct signal_struct *signal, int exit_code)
@@ -583,7 +592,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	const struct cred *old_cred;
 	struct cred *cred;
 	int retval = 0;
-	int ispipe;
 	size_t *argv = NULL;
 	int argc = 0;
 	/* require nonrelative corefile path and be extra careful */
@@ -632,19 +640,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
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
@@ -695,7 +702,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			coredump_report_failure("|%s pipe failed", cn.corename);
 			goto close_fail;
 		}
-	} else {
+	} else if (cn.core_type == COREDUMP_FILE) {
 		struct mnt_idmap *idmap;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
@@ -823,13 +830,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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


