Return-Path: <linux-fsdevel+bounces-77129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGWzIasAj2kAHQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:44:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE2135387
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 618473026F18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F33542D7;
	Fri, 13 Feb 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJXX14Jp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA4354AC7;
	Fri, 13 Feb 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979492; cv=none; b=qQBrxC2mxoEQVcj3aRoIWZHrYQNayrKi31ndNhhH5WFKt+UVuDN0ZoFbCWQXzFx7rah0JCLSdaLfvB2B9d7gRQSm8s2JGIgEaAhO03387ITkuDg2HvFYUIcpaGm04JjuU8+N2fmMU8s7s8xVC55m8LtJRf6wS71QjlYjqRuvTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979492; c=relaxed/simple;
	bh=mwQQgljy62m4eK+PIfpSlj2KKV74LnDLIugSpu0zBCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMXv1W9Y2B1iq4Dj/9uEYsfcL3kwCc1gVuWSCE6SqWSAHckTwM9hJkADHcNAlYKqySNw1I2NBI474h1LRizrtXTYx/jjqJldhqmxn7CV0FHWkStynDTZBNQCeRx6qbqMA+JcUwYSrYJE6usFCVSDr25YVcm63BfuXwmDT+Hcboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJXX14Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2834C116C6;
	Fri, 13 Feb 2026 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770979492;
	bh=mwQQgljy62m4eK+PIfpSlj2KKV74LnDLIugSpu0zBCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJXX14JpR2+HCi4NfMunPJR3uZsaaWcbWnb3XCOYGVyW5Y9XhA8fH1GyeoM1TQMqO
	 Z1imj/2oJjlA4wqxRniPMX335Vi79Neh8WCh7v9yk3ceM5OU5d25uQdEArMdBcGT/E
	 DLkg98UFuLqVXZvJRioKUa09CxBBJNzZH7u2+uA+Zl9WtrKzQmZi65F5I4/i3NNff/
	 dnotyaNDtjRFqmULVR2sWHwRfUJ/t4eRWkT5Kz7XcbBX+P5PHVVnp4JRzwSk4g07CK
	 fEWs7kkGppVKfCVTebaNV2qzzbVtkRZWGtAcZtiA5jKfZLt9Jn9v/Uj5/wtF0pUvVv
	 jJYDlzjvMiCCg==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/5] proc: Disable cancellation of subset=pid option
Date: Fri, 13 Feb 2026 11:44:28 +0100
Message-ID: <774be6da2605e432d08009a75db292067d6f0030.1770979341.git.legion@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770979341.git.legion@kernel.org>
References: <cover.1768295900.git.legion@kernel.org> <cover.1770979341.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-77129-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FEE2135387
X-Rspamd-Action: no action

When procfs is mounted with subset=pid option, where is no way to
remount it with this option removed. This is done in order not to make
visible what ever was hidden since some checks occur during mount.

This patch makes the limitation explicit and prints an error message.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/root.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index c4af3a9b1a44..535a168046e3 100644
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
@@ -304,8 +310,7 @@ static int proc_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
-	proc_apply_options(fs_info, fc, current_user_ns());
-	return 0;
+	return proc_apply_options(fs_info, fc, current_user_ns());
 }
 
 static int proc_get_tree(struct fs_context *fc)
-- 
2.53.0


