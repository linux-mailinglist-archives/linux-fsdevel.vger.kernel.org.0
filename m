Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12031D698
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 09:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhBQIa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 03:30:27 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:60130 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhBQIaS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 03:30:18 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 50EEC20A19;
        Wed, 17 Feb 2021 08:21:57 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [RESEND PATCH v4 3/3] proc: Disable cancellation of subset=pid option
Date:   Wed, 17 Feb 2021 09:21:43 +0100
Message-Id: <4aa63b96263e564822a7782ad826e43d3d9de34b.1613550081.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613550081.git.gladkov.alexey@gmail.com>
References: <cover.1613550081.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 17 Feb 2021 08:21:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no way to remount procfs mountpoint with subset=pid option
without it. This is done in order not to make visible what was hidden
since some checks occur during mount.

This patch makes this limitation explicit and demonstrates the error.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/root.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 0ab90e24d9ae..d4a91f48c430 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -145,7 +145,7 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void proc_apply_options(struct super_block *s,
+static int proc_apply_options(struct super_block *s,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
 {
@@ -159,8 +159,11 @@ static void proc_apply_options(struct super_block *s,
 	if (ctx->mask & (1 << Opt_subset)) {
 		if (ctx->pidonly == PROC_PIDONLY_ON)
 			s->s_iflags |= SB_I_DYNAMIC;
+		else if (fs_info->pidonly == PROC_PIDONLY_ON)
+			return invalf(fc, "proc: subset=pid cannot be unset\n");
 		fs_info->pidonly = ctx->pidonly;
 	}
+	return 0;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -187,7 +190,10 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	proc_apply_options(s, fc, current_user_ns());
+	ret = proc_apply_options(s, fc, current_user_ns());
+	if (ret) {
+		return ret;
+	}
 
 	/*
 	 * procfs isn't actually a stacking filesystem; however, there is
@@ -229,8 +235,7 @@ static int proc_reconfigure(struct fs_context *fc)
 	put_cred(fs_info->mounter_cred);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	proc_apply_options(sb, fc, current_user_ns());
-	return 0;
+	return proc_apply_options(sb, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
-- 
2.29.2

