Return-Path: <linux-fsdevel+bounces-78176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKkkJ7fmnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F68B17FEAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A13730985B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C229037FF58;
	Mon, 23 Feb 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFjtJQHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF771E9B1A;
	Mon, 23 Feb 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890140; cv=none; b=iSaU0jNiz57yP80yz29TjoI7p9biSBzysZvN9VhtLbDP7CxuI14g6U45Meo1LWdimHsUQ7qIHT6l/g/Vm6CzZ79A4GRMiE3/9q/lZb2s4gx2N1nXE4RqMTCQnqvbL7/G7IisdMhHiHYmZjeRnn9n0ktoEkOiVY5eql9FWYpjvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890140; c=relaxed/simple;
	bh=cdZcGGu/6uNPKzNkC5KGoVHixzDyADK0On+TYoFCwqY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJwI0lWlkj9EMblLTqpbcWE3aRZxJbjtTNFDQTWz9TIKhq4NAT7PiNlt/kdG68XryU9eNzWjgsMgNF6rtRfPGfkH0Q1Q6BarMd6TAc1HxFRePam738N3TzjJWhfiF6JIUacffyaaN/lTYnFNYb1KxW3AKwAjQgR/TY9lIZfr8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFjtJQHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C76C19421;
	Mon, 23 Feb 2026 23:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890140;
	bh=cdZcGGu/6uNPKzNkC5KGoVHixzDyADK0On+TYoFCwqY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gFjtJQHjV/l+0W4BTMN39UfwqyDmGTmyLdJIQHvx8mudaYEK/3CJhS7VkAhs1sVAk
	 V/0OOkQn+uEKZhcCf9ha+mn5GH8Naz2GObN7teXP3BgsYXPVGv6KhfddSL0YwJhTh2
	 DiGrcL/bpOvp4BefomWYxvQEBn7zp5jEUHAsaIxCUu0LIb+wBUKTrCNlx6ULfG1mdr
	 KXifJo++sjxRTTV2iRxzrAdgqt44Mre8fO9nA+bKjPRrj+w4nyU81Gae5GmNWDmQxb
	 4ZjbNHeG00XyxYVbwpLCu2GvOXfyKcKuDAH4cdHgBWn0Z6H4dIFrC1m81b8Ye+BBXn
	 sgLPnC800gEwg==
Date: Mon, 23 Feb 2026 15:42:19 -0800
Subject: [PATCH 04/10] fuse2fs: better debugging for file mode updates
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745252.3944028.7218881550245080550.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
References: <177188745140.3944028.16289511572192714858.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78176-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F68B17FEAD
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Improve the tracing of a chmod operation so that we can debug file mode
updates.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   10 ++++++----
 misc/fuse2fs.c    |   12 +++++++-----
 2 files changed, 13 insertions(+), 9 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 2cbbd1ed19a00c..97747d42a64a52 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -3914,6 +3914,7 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			 mode_t mode, struct ext2_inode_large *inode)
 {
 	const struct fuse_ctx *ctxt = fuse_req_ctx(req);
+	mode_t new_mode;
 	int ret = 0;
 
 	dbg_printf(ff, "%s: ino=%d mode=0%o\n", __func__, ino, mode);
@@ -3940,11 +3941,12 @@ static int fuse4fs_chmod(struct fuse4fs *ff, fuse_req_t req, ext2_ino_t ino,
 			mode &= ~S_ISGID;
 	}
 
-	inode->i_mode &= ~0xFFF;
-	inode->i_mode |= mode & 0xFFF;
+	new_mode = (inode->i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: ino=%d new_mode=0%o\n",
-		   __func__, ino, inode->i_mode);
+	dbg_printf(ff, "%s: ino=%d old_mode=0%o new_mode=0%o\n",
+		   __func__, ino, inode->i_mode, new_mode);
+
+	inode->i_mode = new_mode;
 
 	return 0;
 }
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 503d3c1cba5fd4..90f537efe525ce 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3607,6 +3607,7 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 	errcode_t err;
 	ext2_ino_t ino;
 	struct ext2_inode_large inode;
+	mode_t new_mode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);
@@ -3645,11 +3646,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 			mode &= ~S_ISGID;
 	}
 
-	inode.i_mode &= ~0xFFF;
-	inode.i_mode |= mode & 0xFFF;
+	new_mode = (inode.i_mode & ~0xFFF) | (mode & 0xFFF);
 
-	dbg_printf(ff, "%s: path=%s new_mode=0%o ino=%d\n", __func__,
-		   path, inode.i_mode, ino);
+	dbg_printf(ff, "%s: path=%s old_mode=0%o new_mode=0%o ino=%d\n",
+		   __func__, path, inode.i_mode, new_mode, ino);
+
+	inode.i_mode = new_mode;
 
 	ret = update_ctime(fs, ino, &inode);
 	if (ret)
@@ -3669,12 +3671,12 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
 static int op_chown(const char *path, uid_t owner, gid_t group,
 		    struct fuse_file_info *fi)
 {
+	struct ext2_inode_large inode;
 	struct fuse_context *ctxt = fuse_get_context();
 	struct fuse2fs *ff = fuse2fs_get();
 	ext2_filsys fs;
 	errcode_t err;
 	ext2_ino_t ino;
-	struct ext2_inode_large inode;
 	int ret = 0;
 
 	FUSE2FS_CHECK_CONTEXT(ff);


