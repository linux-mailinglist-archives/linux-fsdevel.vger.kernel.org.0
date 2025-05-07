Return-Path: <linux-fsdevel+bounces-48397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76085AAE646
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009C57AD73F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367928C5BF;
	Wed,  7 May 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeUbK3MX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5928C016;
	Wed,  7 May 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634431; cv=none; b=nTogXGQcfvE+ITMIB0APiUSi8E3m7yZWR16gepIN4XHYYGk9XJvaCPnIJP1ZVjMPuDhaBekyEWqZ+9DocdougzK86kpAjDaubsWkkoLDeg10slKHaMDxZ0hBiiT/zYVCHCHw38ZSmk8fJt+lK2iOFFBWWu1GcJbhqYyRmDxekB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634431; c=relaxed/simple;
	bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VqE1gg1TL9FaFzgvreVs3n+EeftuV/mUp1BaJfci2wItj/9rAuACax6IXyOe0wvOKyAh2k7DEJxkUInvcWa6eK9HcQjUFU3jhySM4VVeCK/Bfvevt7NdtalLaPG12SF5bfRsdg8Vl7aKMgxWAnbde6KCsgZIsVkvXAawmeLOELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeUbK3MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DBCC4CEEE;
	Wed,  7 May 2025 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634430;
	bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GeUbK3MXb57Fun9p3AUHSHga6ExOjFIt54ht8tzr09TM3In1UkMtMy33bZSzqYJ/N
	 Dwt2Lr6Ya1mrLegSWf7uzyBjN29xn1p45EhFdYMyBeMADvq6Hqsb4XcdcYITaCxXCR
	 Oz/MV7TXRQivpE0JFahV69estdvmmzNKGXfT4iiwBZFSJL8lm3zz1H0Tm7aJWQ0GFL
	 zopJCxt+dVtS6J3yatI5Bzpkt7E2n0Zm555/w6s1TpoSOmJvQPMBd9VUlKYU9jrkmc
	 wgFpsc1XlDROiCoVsLInNqvEXqMg1l+oDjNTTL8o4bhZftsr138tJeQdLqF8GodEaU
	 lba7lpiparDXQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 07 May 2025 18:13:34 +0200
Subject: [PATCH v4 01/11] coredump: massage format_corname()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-work-coredump-socket-v4-1-af0ef317b2d0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4656; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d48rlIeb55kv9LHwHtfILNbBpVSvS+cV2//Rf2p6cRQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt211E7gt+pehsXuziatNfvZ+R8e3Ny7/fh0/0bL+J
 PuN/k69jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlM4WRk2HfLLW2n6toS7tjw
 2SZ/M/ni7vz8mLlj9eRHMpNf3k3odWf4K/3mc7TNpozd3VwlJY+2uS0SdX2Zwp2/TeLyTcmvYlc
 yuAE=
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


