Return-Path: <linux-fsdevel+bounces-78054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULO0GqXenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7517EF3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB1E43085436
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5D37E300;
	Mon, 23 Feb 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC73bkDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB837AA81;
	Mon, 23 Feb 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888230; cv=none; b=pcYyzQGCbZwLkLDArjKjXMd4ADpdqeZZreEcjrdaYTG4aWz0xvgx6DiVpmSEqAw6vlhIBFpB3m8DaNGkUHJCHGKjaHnahpO55TDoCMnLNMMYIUcU1juskGheEOOY6/zzvaJF5LRPrt+8QumiIPtv1zeE2rjtXd3gnGzBAuBRdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888230; c=relaxed/simple;
	bh=WNpqv5UQCnYX2QjyDI+sG7vHCawMDloEIxGiBevxqvc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTSBUg7eJJLbqmUz+hySBtZufE4PiUxpK8bDIgiK0L4Mf2kJCzLOCq4lPIo1AmP/08kxCSPZFYfTVUCOCP+GvRTBICCvZgBD1oMllEl5og2vyajT1hZUBD1wCZbx2+f1mFM31GVduXJZCmvK5tykjqmMXJT+OGmUa7dvkqYvwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vC73bkDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC04EC116C6;
	Mon, 23 Feb 2026 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888229;
	bh=WNpqv5UQCnYX2QjyDI+sG7vHCawMDloEIxGiBevxqvc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vC73bkDwJrA7DCXzQylfiNA8suWYsNWgX/P71dGsMLw4+Sz1LlOCIZBaqyahzXQlV
	 Ty3rRJaIV3py+LPKGlQIg+p5sb8TCxS1EtwvY+OevO0aoGQTnGhddS2KeJxJVAMyyV
	 0sFlOFGp06fahJs2CS3I4UZR8GeQcnYl8LUtz9z4wWNJ5UTIkyy2LEY51FhMlnxvUv
	 nGnQ7TviSTM+YwoxYr0ne4yOtuzCAPK/QfvS+4M+B9kNYu1adywaRoPCq8hVXswg3g
	 1bPSjiNPdrFiL0jCfDJe+Oaax/LalqgJOG5KEH+94YGAYUrt0gSxygmRRr2rh7F2ed
	 O2kbjfaT7/z9w==
Date: Mon, 23 Feb 2026 15:10:29 -0800
Subject: [PATCH 07/33] fuse: clean up per-file type inode initialization
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734395.3935739.17138889571437388213.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78054-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 24B7517EF3F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Clean up the per-filetype inode initialization in fuse_init_inode before
we start adding more functionality here.  Primarily this consists of
refactoring to use a switch statement and passing the file attr struct
around.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/file.c   |    5 +++--
 fs/fuse/inode.c  |   36 +++++++++++++++++++++++++-----------
 3 files changed, 29 insertions(+), 14 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6860913a89e65d..c6d39290a7a9cf 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1230,7 +1230,7 @@ int fuse_notify_poll_wakeup(struct fuse_conn *fc,
 /**
  * Initialize file operations on a regular file
  */
-void fuse_init_file_inode(struct inode *inode, unsigned int flags);
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr);
 
 /**
  * Initialize inode operations on regular files and special files
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b1bb7153cb785f..21a6f2cd7bfaa9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3194,11 +3194,12 @@ static const struct address_space_operations fuse_file_aops  = {
 	.direct_IO	= fuse_direct_IO,
 };
 
-void fuse_init_file_inode(struct inode *inode, unsigned int flags)
+void fuse_init_file_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	fuse_init_common(inode);
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache) {
@@ -3214,5 +3215,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	init_waitqueue_head(&fi->direct_io_waitq);
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
-		fuse_dax_inode_init(inode, flags);
+		fuse_dax_inode_init(inode, attr->flags);
 }
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 778fdec9d81a03..40450a3d32e7cb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -422,6 +422,12 @@ static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
 	refcount_set(&sl->count, 1);
 }
 
+static void fuse_init_special(struct inode *inode, struct fuse_attr *attr)
+{
+	fuse_init_common(inode);
+	init_special_inode(inode, inode->i_mode, new_decode_dev(attr->rdev));
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -429,20 +435,28 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode->i_size = attr->size;
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
-	if (S_ISREG(inode->i_mode)) {
-		fuse_init_common(inode);
-		fuse_init_file_inode(inode, attr->flags);
-	} else if (S_ISDIR(inode->i_mode))
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+		fuse_init_file_inode(inode, attr);
+		break;
+	case S_IFDIR:
 		fuse_init_dir(inode);
-	else if (S_ISLNK(inode->i_mode))
+		break;
+	case S_IFLNK:
 		fuse_init_symlink(inode);
-	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
-		fuse_init_common(inode);
-		init_special_inode(inode, inode->i_mode,
-				   new_decode_dev(attr->rdev));
-	} else
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		fuse_init_special(inode, attr);
+		break;
+	default:
 		BUG();
+		break;
+	}
+
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.


