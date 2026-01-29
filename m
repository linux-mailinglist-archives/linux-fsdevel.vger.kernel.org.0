Return-Path: <linux-fsdevel+bounces-75909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIlhDezVe2klIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:49:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CF9B512A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 22:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 375F730495D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C510364EBE;
	Thu, 29 Jan 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGM4QlsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC1341654;
	Thu, 29 Jan 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723282; cv=none; b=oB5wqz0uwaMdAW7SiySafWpnMaBNbf9SHXICvfm+C7y6/Booy41t+9P0+YKVXlblbeGG6OO/dtZsZ/eUV4VnWgKCuje0PlRIm7PnOPib7iMKh2wbKjnemyIgoU73icCZwIm7SqVqYZcEDc1i2KFVCt3IcI15upgLZihmCNbYG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723282; c=relaxed/simple;
	bh=KCfHIRNIzQzmMNTHvMxpX0pCBVPoHL5AjM3bzx+Vkkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eoxNz2kTE6Jrbrmo7lQvVMRw6K/aZlNFPakI+vpsn7hBXNfGq+GAptMkueqX9qjGDmeGgmNspNOiCNWug/prTg9rdC1jj0Xzw7aQE+EzLQoZwX6GrdWL/ZluLKqdI//li611U/ypp+eW7aBptzdKtEbFTwUgje1qMI9fBlrwVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGM4QlsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6036AC16AAE;
	Thu, 29 Jan 2026 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723282;
	bh=KCfHIRNIzQzmMNTHvMxpX0pCBVPoHL5AjM3bzx+Vkkw=;
	h=From:Date:Subject:To:Cc:From;
	b=UGM4QlsAOHzAAKw+pey3jrNubJB5kW37QUeQnvbQupC9CbT+bJNdOcsaFvEq7D2St
	 dH2QssLyuGop60g0+uEHyxojZkQRhPxhWy7per3Okupw7k41utSybokypch3dvzpJz
	 HfWnbeyQY1Vepm7+PVh3S+FGqKumCeVHvgnTppgpgeJRs9tpP7CpR6uGo0NDTa+Pjb
	 h8e/LZuivP0MuLXVoazjJbpAmwaxUqZubxqmWVgnXgd/+a/otCsrjdcLa7iTOn7NUn
	 YIoFUJax3ISjHzJ1NS61YoK+YeizpoEuaBg/rJpvfQ1b4Tsd8t5Y/ltrpXAd5Zvcip
	 cDVsMF7hXqN8g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 Jan 2026 16:47:43 -0500
Subject: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyNL3ZLy3PzSvBJdQ0OTlJS0FBNjEyMDJaDqgqLUtMwKsEnRsbW1AOG
 EbDJZAAAA
X-Change-ID: 20260129-twmount-114ddfd43420
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KCfHIRNIzQzmMNTHvMxpX0pCBVPoHL5AjM3bzx+Vkkw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpe9WJYdNlDRR4DQUZwjy+Kw7c8bELmz6k50tvG
 aD6NrrhEM+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXvViQAKCRAADmhBGVaC
 FZSZEACjhfeKy/f4a0++5uPJ8ofQjK6wTeKpOdiOCXRjAfh1MpNm9k6GbKsLa44mSi5smG394Lu
 8hbLmn9OyLhKsAHBZ84KNgAVua4BgFgJE+Tgy1gBu9f1qhCR8mM4JZZaNK6TBGsmRhgb55NGrm5
 9DSJ4xjkGrYlzMiEZf9upR5SCiGrKfdrpT/XJd3xfvw0dS6BOSd8vI/6M8Fx8hCu3JRQ402cghf
 0v1FOfCpuPhvwNSdYVBnJacJhkIOH1ev3uDDXrii+SkBTf4D2SOcYLI5CaSCHh7JCijKP5/nKtZ
 hHurNW0rJkVay9OpwMXlAUtrXI+iuJwedmlBw91RV9yx85acZ52WwhmaDoiL81WFztlSTgwnQ+Y
 1MHrjTUCSk4eBiXvBNdp9Oyi9vkBjU1qnZeK2/wJs2ZKlEI0umYRtdxT7xE8V+R2Cnjh4nNZCxX
 hZd5Pbopqr3wx/ZnzRE+iMsQlBViTTcFaAPnC87chNoYUclXk2WcIbacliurni4tTA2jW6gaAVj
 QBB9jYB0rNJZZIIlDZ5AZeZCVHHO7Uh+/HaTbi8UP182c+K7HjpnV2auwJtfCvgVI2XkUBD9s7t
 d74W2xenRt/fLoLPP2OeVV+WkQPCJx1mdSDmUvZa3EuwVAn6uyzVfjMqhVAPpArKqZzJSGzOmjU
 xaVx+XzcZm/iVzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75909-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0CF9B512A
X-Rspamd-Action: no action

Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
container that doesn't have FS_USERNS_MOUNT set.

This broke NFS mounts in our containerized environment. We have a daemon
somewhat like systemd-mountfsd running in the init_ns. A process does a
fsopen() inside the container and passes it to the daemon via unix
socket.

The daemon then vets that the request is for an allowed NFS server and
performs the mount. This now fails because the fc->user_ns is set to the
value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
want to add FS_USERNS_MOUNT to NFS since that would allow the container
to mount any NFS server (even malicious ones).

Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.

Fixes: e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/fs_context.c |  8 ++++++--
 fs/super.c          | 11 ++++++-----
 include/linux/fs.h  |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index b4679b7161b0968810e13f57c889052ea015bf56..128ebd48b4f4ba1c17e8b5b1b9dcefbd7a97db1a 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1768,7 +1768,9 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE	|
+				  FS_BINARY_MOUNTDATA	|
+				  FS_USERNS_DELEGATABLE,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1780,7 +1782,9 @@ struct file_system_type nfs4_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE	|
+				  FS_BINARY_MOUNTDATA	|
+				  FS_USERNS_DELEGATABLE,
 };
 MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
diff --git a/fs/super.c b/fs/super.c
index 3d85265d14001d51524dbaec0778af8f12c048ac..b7f1bb2b679b43261fbdcd586971c551b85e8372 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -738,12 +738,13 @@ struct super_block *sget_fc(struct fs_context *fc,
 	int err;
 
 	/*
-	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
-	 * not set, as the filesystem is likely unprepared to handle it.
-	 * This can happen when fsconfig() is called from init_user_ns with
-	 * an fs_fd opened in another user namespace.
+	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT or
+	 * FS_USERNS_DELEGATABLE is not set, as the filesystem is likely
+	 * unprepared to handle it. This can happen when fsconfig() is called
+	 * from init_user_ns with an fs_fd opened in another user namespace.
 	 */
-	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+	if (user_ns != &init_user_ns &&
+	    !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
 		errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
 		return ERR_PTR(-EPERM);
 	}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a01621fa636a60764e1dfe83f2260caf50c4037e..94695ce5e25b5fbe4f321d5478172b8cb24e00d1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2273,6 +2273,7 @@ struct file_system_type {
 #define FS_MGTIME		64	/* FS uses multigrain timestamps */
 #define FS_LBS			128	/* FS supports LBS */
 #define FS_POWER_FREEZE		256	/* Always freeze on suspend/hibernate */
+#define FS_USERNS_DELEGATABLE	512	/* Can be mounted inside userns from outside */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;

---
base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
change-id: 20260129-twmount-114ddfd43420

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


