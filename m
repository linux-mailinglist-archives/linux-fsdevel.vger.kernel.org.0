Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4A3CB64A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhGPKtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239590AbhGPKtn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:49:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A905C613FC;
        Fri, 16 Jul 2021 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626432408;
        bh=ZzDOAMdJ5lHEY2dNQ7o9jwZutsDPDTAfabK8gQhelcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUfa6wUxAUiRHaA4WyND6EKFUJUT8B9lDerSNVKcnolQqobsI22sEe7K9XUS1Lh2u
         +YQfhx/891tlBghE7tGhNMfkI4VPPcwuE34IhPkcVKYETQQ9VNp71rc1US9+mPJDWU
         vvnJgMIGy+XxmcWOH7DqT4rBtorcUdFIaNUOrOuGEGbnua4ae8jOcOvSVEGdGVhbOa
         P8YmVNZKUCLs/0N5gyaF7J77GXMhyqhnkWHgmfxBeDGweL0h+K89HBtfJzNCNK8/JE
         1zE2re2wCSVIAHyB02xRAs1BhLBhI8GvQ4HaWN73Nvpur1vdCyaQUO+2gFV69Df3hQ
         WXGC3zpT0X7Ug==
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH v6 3/5] proc: Disable cancellation of subset=pid option
Date:   Fri, 16 Jul 2021 12:46:01 +0200
Message-Id: <883677463902534d2de724dca9ff139f6ad777b8.1626432185.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1626432185.git.legion@kernel.org>
References: <cover.1626432185.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When procfs is mounted with subset=pid option, where is no way to
remount it with this option removed. This is done in order not to make
visible what ever was hidden since some checks occur during mount.

This patch makes the limitation explicit and prints an error message.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/root.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6a75ac717455..0d20bb67e79a 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -145,7 +145,7 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void proc_apply_options(struct proc_fs_info *fs_info,
+static int proc_apply_options(struct proc_fs_info *fs_info,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
 {
@@ -155,8 +155,12 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
-	if (ctx->mask & (1 << Opt_subset))
+	if (ctx->mask & (1 << Opt_subset)) {
+		if (ctx->pidonly != PROC_PIDONLY_ON && fs_info->pidonly == PROC_PIDONLY_ON)
+			return invalf(fc, "proc: subset=pid cannot be unset\n");
 		fs_info->pidonly = ctx->pidonly;
+	}
+	return 0;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -172,7 +176,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	fs_info->mounter_cred = get_cred(fc->cred);
-	proc_apply_options(fs_info, fc, current_user_ns());
+	ret = proc_apply_options(fs_info, fc, current_user_ns());
+	if (ret)
+		return ret;
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -224,8 +230,7 @@ static int proc_reconfigure(struct fs_context *fc)
 	put_cred(fs_info->mounter_cred);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	proc_apply_options(fs_info, fc, current_user_ns());
-	return 0;
+	return proc_apply_options(fs_info, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
-- 
2.29.3

