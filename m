Return-Path: <linux-fsdevel+bounces-73401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09FD179D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C2D3024D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE9A38B995;
	Tue, 13 Jan 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1e/n43y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1792E6CC5;
	Tue, 13 Jan 2026 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296079; cv=none; b=nJ9iFj0aqnOTQq66tDo0rMRi318wJyGHo5jl45TqinB69aqmriMztryRs3N4CrgKnGHZwpMJftolQCK6NdS4m/hhCTS7x+S02NJlzX9nNQxNHxDb7iJljcRj2ixK2Nnyy1aau4g9hXBGkPCFBlUrbYMJpwl8+gt+NPEzId3s2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296079; c=relaxed/simple;
	bh=XHQnjvM0LtkUUMR+/A7ZTCIzseY7chbf3e5+hgmW1Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnvX9nyJJ6WUUJsLJ4FzgS4yxtTW+ai0NdjL60oApS2JesPm7fWNyCKR83yN3sqCiTYFs/1Phw2tMd3B0RWt1bC496tWA3cUwrmguQoNBSelbXNU5eJ1alJgok3gRXRN+47wGbtFb38MRnKnjwr7Qeak+lCEUF3/joEGB4j3US8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1e/n43y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947AC19424;
	Tue, 13 Jan 2026 09:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296078;
	bh=XHQnjvM0LtkUUMR+/A7ZTCIzseY7chbf3e5+hgmW1Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1e/n43y8suHL4+FUfL7NEup+9/zPDPVam9cC2m1LFw2hnK81E3xjARib1/39Ar5f
	 bPNfoO+smTKUO0hB7S07sGbC3/L9Mfkn3vJryrqeAt9GSTyJFCywm2CNcTsDtxGebP
	 xolOyIA+fTZ8HgNO/udpnawS821IfUxa/xyscb5aylBZD9JfgAINqfzhJW7/qo93tt
	 lno/U6VdH3dGdxZ6etYD/APhSF17KLOL9GxwbmWtex25bBR1TwAp6luKNGhN62kaJk
	 ggKpi2O0WDK5ToMsDTs6ZnymaVh/6PnNBYIql/GOb2iF6MYo/b2wATdwITnwLL35Jr
	 IC6WqWKoawREA==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] proc: Disable cancellation of subset=pid option
Date: Tue, 13 Jan 2026 10:20:35 +0100
Message-ID: <568a0aec3be26f1f3ee1d10c657b56626d958bc5.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <20251213050639.735940-1-danilklishch@gmail.com> <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When procfs is mounted with subset=pid option, where is no way to
remount it with this option removed. This is done in order not to make
visible what ever was hidden since some checks occur during mount.

This patch makes the limitation explicit and prints an error message.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/root.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index ed8a101d09d3..b9f33b67cdd6 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -223,7 +223,7 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void proc_apply_options(struct proc_fs_info *fs_info,
+static int proc_apply_options(struct proc_fs_info *fs_info,
 			       struct fs_context *fc,
 			       struct user_namespace *user_ns)
 {
@@ -233,13 +233,17 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
 		fs_info->pid_gid = make_kgid(user_ns, ctx->gid);
 	if (ctx->mask & (1 << Opt_hidepid))
 		fs_info->hide_pid = ctx->hidepid;
-	if (ctx->mask & (1 << Opt_subset))
+	if (ctx->mask & (1 << Opt_subset)) {
+		if (ctx->pidonly != PROC_PIDONLY_ON && fs_info->pidonly == PROC_PIDONLY_ON)
+			return invalf(fc, "proc: subset=pid cannot be unset\n");
 		fs_info->pidonly = ctx->pidonly;
+	}
 	if (ctx->mask & (1 << Opt_pidns) &&
 	    !WARN_ON_ONCE(fc->purpose == FS_CONTEXT_FOR_RECONFIGURE)) {
 		put_pid_ns(fs_info->pid_ns);
 		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	}
+	return 0;
 }
 
 static int proc_fill_super(struct super_block *s, struct fs_context *fc)
@@ -255,7 +259,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
 	fs_info->mounter_cred = get_cred(fc->cred);
-	proc_apply_options(fs_info, fc, current_user_ns());
+	ret = proc_apply_options(fs_info, fc, current_user_ns());
+	if (ret)
+		return ret;
 
 	/* User space would break if executables or devices appear on proc */
 	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
@@ -307,8 +313,7 @@ static int proc_reconfigure(struct fs_context *fc)
 	put_cred(fs_info->mounter_cred);
 	fs_info->mounter_cred = get_cred(fc->cred);
 
-	proc_apply_options(fs_info, fc, current_user_ns());
-	return 0;
+	return proc_apply_options(fs_info, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
-- 
2.52.0


