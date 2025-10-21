Return-Path: <linux-fsdevel+bounces-64948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0EBF75AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25B024F1CDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FC346A0F;
	Tue, 21 Oct 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvFM4CMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72C34678B;
	Tue, 21 Oct 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060379; cv=none; b=lhKhGAuW/HpHlhLBgFsJQneEVAE4815IeL0nhZvoybhRW61bkrS3jN+gcytcdUhxs9SLs1u2wOcVOIEJPCX+hgKBrmojpzBtpn86gYrzWsxua0S/Wdog7aeroBGHS7tojdeQTf0XYTyY2+H1QUASw/u4qomB24u9ISnO8tshvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060379; c=relaxed/simple;
	bh=HyqRgBw91WhqZtzTenMCR+3dGk9xVGJz9VhQTZtIs78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaOkFIvEzMBzFLuZ3mLt0A7WzZLeedVaYTryQlzNBG/mxzYVhf7D8TA9nukWXNDXv7rTlElv60fwnUz4wfvj5wwI8+GYCi7/hMkeRfbcXIoBuH8WKQF8Yj5rVLXr3sD5gXxMx3uF//H7e4WS1CWs6ZbFyQzFPDaFxJuqJSnfLHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvFM4CMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F646C116B1;
	Tue, 21 Oct 2025 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060379;
	bh=HyqRgBw91WhqZtzTenMCR+3dGk9xVGJz9VhQTZtIs78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qvFM4CMPLeb6PTxJsg94dwm8fHqO3C7L4dPUo4vcp2qkkAHgsBG2D5j3+7wPNxzf8
	 uVBjFFih4UbTc6ykQcMOiW5bfmfxzaLW6CXw7cqGH13DtDMr9Z/Mbu+5G60X/RvICf
	 gde0uyN7z4FL2VZ492HS/uZIQW07iaaq7y2Sghl6TPa3YX2Lm/WN9F/SZ95ZZ4QoTw
	 m6y3oxVcFLnfyho4qpxf0U1krrR3mVWYbpuOMgwudZoBOgX6ZEzn6ksF+FRb0mT3sU
	 sPLQHbFRdH4MGdMdq7Aw+IKKWctD4oHTlxTJSX2p915jHmwWJCaH736BnaKmnDAyXF
	 4BwiFuHwtyAOA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:40 -0400
Subject: [PATCH v3 05/13] vfs: break parent dir delegations in open(...,
 O_CREAT) codepath
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-5-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HyqRgBw91WhqZtzTenMCR+3dGk9xVGJz9VhQTZtIs78=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YEEfoW9eozdR9KGWdnmBcYOlqeBlMd7he64
 LC8Ey2eB8eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBAAKCRAADmhBGVaC
 FcdkD/9+C+fUrYqbky0LjtjE9purC4C6aTs51o32EHqnaGafX+7RETjcbJpdejBnmJSOLQSjid7
 3/7STizAiD9JhkYCrDQg8CfD7dSLaiCz2jtf/5jGQN3b6fCNvyKQLHmYFYEMySZjUWsboh+D8Ye
 iewgJDKWzudnJ34AwOS7eoYlm4OwvxrYj6JVYvmH1h94tpSQEp41zE90Vddwrl01s2d8zo3eXlG
 GBMDuov1arvrdK4afgIOYo8lVPzrFiJ+QQ7e+9cGyYXC2/AamwrCWnoQj+Jgj/a1fhDPTWOUVmJ
 DJCe3xAmzIW4MHaNAgX7jJD7Q6mqwUwietEK2Qqxu7L2aW7/K0o091HurZyQuZpoawzErq36GAh
 ei5iuMie+TG21eh/joB5/KDAgwaoM96RLEX17lRjZkpkZ9CKA8oIV50fL0BhgXKerHwfBRkZtNP
 jxidwAvRkX+YAvPt52Of0Y4RygYvUDy0BIPkAO9uE09NEjpe5BPM84yEoEFlN9FlN+dXCRQ0Ucz
 MVKoh2ymU3pzIoSt0hysMdxxZsyXkl01vxvzPSxJfsbwhidUPCWK1QmrkYZKpvhkhL79cHB1fA+
 SpooeFFmFkQeCpB6JmHKGeettb5wtLPmm//dT6SG/bgY1A5ovehZ0U9Oe9UgDLqP13FXrl01682
 u6cHD7i387v2U4g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Add a delegated_inode parameter to lookup_open and have it break the
delegation. Then, open_last_lookups can wait for the delegation break
and retry the call to lookup_open once it's done.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4b5a99653c558397e592715d9d4663cd4a63ef86..786f42bd184b5dbf6d754fa1fb6c94c0f75429f2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3697,7 +3697,7 @@ static struct dentry *atomic_open(struct nameidata *nd, struct dentry *dentry,
  */
 static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
-				  bool got_write)
+				  bool got_write, struct inode **delegated_inode)
 {
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
@@ -3786,6 +3786,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
+		/* but break the directory lease first! */
+		error = try_break_deleg(dir_inode, delegated_inode);
+		if (error)
+			goto out_dput;
+
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
@@ -3849,6 +3854,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
 	struct dentry *dir = nd->path.dentry;
+	struct inode *delegated_inode = NULL;
 	int open_flag = op->open_flag;
 	bool got_write = false;
 	struct dentry *dentry;
@@ -3879,7 +3885,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 				return ERR_PTR(-ECHILD);
 		}
 	}
-
+retry:
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
@@ -3892,7 +3898,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
-	dentry = lookup_open(nd, file, op, got_write);
+	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
 			fsnotify_create(dir->d_inode, dentry);
@@ -3907,8 +3913,16 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry)) {
+		if (delegated_inode) {
+			int error = break_deleg_wait(&delegated_inode);
+
+			if (!error)
+				goto retry;
+			return ERR_PTR(error);
+		}
 		return ERR_CAST(dentry);
+	}
 
 	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
 		dput(nd->path.dentry);

-- 
2.51.0


