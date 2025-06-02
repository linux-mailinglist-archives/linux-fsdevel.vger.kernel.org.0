Return-Path: <linux-fsdevel+bounces-50337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78464ACB09F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83264845F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E5229B27;
	Mon,  2 Jun 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdVUcxMe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93122A7EB;
	Mon,  2 Jun 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872957; cv=none; b=ns/QmLAtVg/plQ57k7I/qiNJdXZuHj+OB2TGyku3LfxttgDy2SDXZkRbWKmoHy++jtKLRmtiIY0JtMQmgOMyqk891rhKklz+VLanM5HYcDux+61Yk1xJdSUIIpgNBcWlYu0bdtBUVhZb1obZIfpdP6Dx1gQf7b0M5NC1LeC01so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872957; c=relaxed/simple;
	bh=s06Ae4PELaiY01FI16RBzFSeo5l8K3g8hpxK/GqIpnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVht2rx/crZ3xrmT7+E5P+E9kwPM6INvglqGve4NMxR+sV/b3n0WN7nz0gzn/fX2qaysNF/k9b4EKsRDfYQ5PlW4OsTd4AQbxL9p05R+BvQ1HHfJI+dQwkdfLvX9YxBUMtWCapRo8/g/yX0ipuxK5AjQh70s8BtkjQXpCwA1Oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdVUcxMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01296C4CEEE;
	Mon,  2 Jun 2025 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872956;
	bh=s06Ae4PELaiY01FI16RBzFSeo5l8K3g8hpxK/GqIpnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hdVUcxMeGlBRZ7kihzm8hrCdTnznSoWbpdncHT46AENaLkbSeXbVNirbiDcW3lVxz
	 5Nf6+SvKVyfOMrQMXnynqeNCUz2KXX/8rbUTe2TK2rbm1+kRO5pvp1DfKAUS7NK7hL
	 fIBmZNjBJDYtXwH1zkUt//4uhgQsO0OtqXWgC3CAIZrcz/X3HZPK7GqEhC7+T5hQSc
	 0DzwJWr4sVNExBNKGzaFQC1LkqEjRLtH5KnMPrCOQhx3YhprOKBF9kSlqKsOkdtl0f
	 Zq40EoomOB4an9/UJknDdtgleZlmXl8KiW9k5JZ+660v3Uns39LvcnXFVrUBDoCYV1
	 qhTxjpL5sBfUA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:50 -0400
Subject: [PATCH RFC v2 07/28] vfs: make vfs_create break delegations on
 parent directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-7-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=s06Ae4PELaiY01FI16RBzFSeo5l8K3g8hpxK/GqIpnQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7l8YXO/GV+iK0bIwIx8M+FiK6b8G89HnRU6
 WHcQw5Po6WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5QAKCRAADmhBGVaC
 FUq1EADPZoJ+TKPhpk3m+iZfs7CRmFoQzvtp5HirrfFRd7pyg03bLq9LS5RiRcClOPxmZ4IQakJ
 RNYBfIAeK0tBAGP9n/8aVntkngLoz6heNS756YT1H4NHGXE+SPbdTBu81+l03fyi6x7Uwh7iCH2
 C+Hau/Bt7OpfN4JHjsmzxRFkQBLPmXlh8TdzhpVysbo1KKImbacyLnLiiGhVZc2DrazVkF+t1O3
 YZLpoa0LOhMnXbvXIeqxraHViBWqMmR6pvJ4/htKbltFQM0CrTUQVrG/GWCz9/TzOatskTWip7Y
 hM6/LTINps7sKXLpU5WbdubLSjWgxK8zmIqE+x7MKK6iRhpi9tRR0kZx82D5NiEnJKW1dcxXZYE
 VnRXe4g3onGqxCfnjGxvPSLNA14Hp/fEGzpQ6fC/0LeDokbxNXuIgsAXcz6GMabeCuGucWtDFfJ
 E0tW32kWXxNrB/r6GLSswIKEqBWClRSUJCAjXr5AO4CqeZy86QK1kJ0sJbpu09g/MqXSInJCCvo
 ib9qtW3z+c/1vi+trxIHOP8bH5Jrtzk12Rrz6FDVavnonNKLdlqTAGGipVsJISOKiqSn2mp86Ek
 vV+7giOxYE1Jpgmbh/alW1itRZMdWpyhukgWtqv+Mb4Kj8LuDZCVOq5y73ML4c906uL//I7o35c
 cFZ9/VHV7pr7l0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename vfs_create as __vfs_create, make it static, and add a new
delegated_inode parameter. Fix do_mknodat to call __vfs_create and wait
for a delegation break if there is one. Add a new exported vfs_create
wrapper that passes in NULL for delegated_inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 55 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c8fe924cbb7dcefac9a4930df9f8303d9a478508..7b27a9bc4616d3880d6365f1e37f13f7f45bc2c9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3370,6 +3370,32 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static int __vfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool want_excl,
+			struct inode **delegated_inode)
+{
+	int error;
+
+	error = may_create(idmap, dir, dentry);
+	if (error)
+		return error;
+
+	if (!dir->i_op->create)
+		return -EACCES;	/* shouldn't it be ENOSYS? */
+
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
+	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
+	if (!error)
+		fsnotify_create(dir, dentry);
+	return error;
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -3389,23 +3415,7 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 int vfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	       struct dentry *dentry, umode_t mode, bool want_excl)
 {
-	int error;
-
-	error = may_create(idmap, dir, dentry);
-	if (error)
-		return error;
-
-	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
-
-	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
-	error = security_inode_create(dir, dentry, mode);
-	if (error)
-		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, want_excl);
-	if (!error)
-		fsnotify_create(dir, dentry);
-	return error;
+	return __vfs_create(idmap, dir, dentry, mode, want_excl, NULL);
 }
 EXPORT_SYMBOL(vfs_create);
 
@@ -4278,6 +4288,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	struct inode *delegated_inode = NULL;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4296,8 +4307,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	idmap = mnt_idmap(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
-			error = vfs_create(idmap, path.dentry->d_inode,
-					   dentry, mode, true);
+			error = __vfs_create(idmap, path.dentry->d_inode,
+					     dentry, mode, true,
+					     &delegated_inode);
 			if (!error)
 				security_path_post_mknod(idmap, dentry);
 			break;
@@ -4312,6 +4324,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	}
 out2:
 	done_path_create(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;

-- 
2.49.0


