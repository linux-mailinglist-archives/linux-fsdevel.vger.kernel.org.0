Return-Path: <linux-fsdevel+bounces-78055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ6ZNXrenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:10:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CB17EEFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8CD6300E483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEF37E2FE;
	Mon, 23 Feb 2026 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw4loPRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2737D134;
	Mon, 23 Feb 2026 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888245; cv=none; b=K1Uv1DWWdhcYQxAHWVj+XvvqwJfX9L4N/iz+Aw5q2n5p+g4sBz/AhP7SdAgnj/NvJAXAIs2gTpkCJ8PjKtdfhK4BzTicQEkE+MIIDt4p1jVfzPGJGKcAZE5sdPSp/3OXtegPnruvu/Q3c3RGq2CDODvNManRyBd7nYFnXeYfBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888245; c=relaxed/simple;
	bh=2ArjwOtEwW7J3uKf8zF9fhp2gzNCqSJHCS9o0LYi8/o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/ME404imm5W9HzNYcNzpLCoh18fMGaOl0cILObI7g41BkTFL6VGodWLYN2UOEeScPcXDzl36x2wbp4w1GUQSVx5mXcSf/QLWp66c4u83dIxpCzFuVAkFttatlDpMbCm6XnIMMchWaXXgD1oy1JUima0lnh539IQn7fQk2Q61Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw4loPRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0EAC116C6;
	Mon, 23 Feb 2026 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888245;
	bh=2ArjwOtEwW7J3uKf8zF9fhp2gzNCqSJHCS9o0LYi8/o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Pw4loPRQl36nE1FbGVVNUuvx3ggt2b0ufzEQobILhzdq1aA2RPG7gM6LCzzGdKAQz
	 cP8Cz/CvRDf/XWI4i4SCuq7wsFzhl6WIBkR0WPJAuFSXvrwa0qOWOHif1uFunRMAgi
	 ztEN3CwIANh9Cg2B1ghQFdZ6Ww7aElvrKpX5uRZXElBisyhAjx+/KfWbcY8ahDy5OV
	 g4SWAIte13awx09E/vdd2E/GuwChABgqnQyG6JE+D6ZSe53DhFakdfbtIkRX8oGVrG
	 ZOUkyFsrCzZFLyaZMSykhx/v+52Y3fa/0bGmADhfpZZGbqgKhKMcAPlX4PsI998Pd0
	 +GX2l8eahtl5A==
Date: Mon, 23 Feb 2026 15:10:45 -0800
Subject: [PATCH 08/33] fuse: create a per-inode flag for setting exclusive
 mode.
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734416.3935739.4908610231604767076.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78055-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 101CB17EEFE
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Create a per-inode flag to control whether or not this inode can use
exclusive mode.  This enables more aggressive use of cached file
attributes for things such as ACL inheritance and transformations.

The initial user will be iomap filesystems, where we hoist the IO path
into the kernel and need ACLs to work for regular files and directories
in the manner that most local filesystems expect.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   17 +++++++++++++++++
 include/uapi/linux/fuse.h |    4 ++++
 fs/fuse/inode.c           |    5 +++++
 3 files changed, 26 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c6d39290a7a9cf..46c2c660a39484 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1117,6 +1117,23 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
+static inline void fuse_inode_set_exclusive(const struct fuse_conn *fc,
+					    struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	/* This flag wasn't added until kernel API 7.99 */
+	if (fc->minor >= 99)
+		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
+static inline void fuse_inode_clear_exclusive(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
 static inline bool fuse_inode_is_exclusive(const struct inode *inode)
 {
 	const struct fuse_inode *fi = get_fuse_inode(inode);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ae6b05de623d7..2d35dcfbf8aaf5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -244,6 +244,7 @@
  *  7.99
  *  - XXX magic minor revision to make experimental code really obvious
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_EXCLUSIVE to enable exclusive mode for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -584,9 +585,12 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_EXCLUSIVE: This file can only be modified by this mount, so the
+ * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 
 /**
  * Open flags
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 40450a3d32e7cb..e45b53bfce4b2d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -197,6 +197,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_inode_clear_exclusive(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -436,6 +438,9 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
 
+	if (attr->flags & FUSE_ATTR_EXCLUSIVE)
+		fuse_inode_set_exclusive(fc, inode);
+
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		fuse_init_file_inode(inode, attr);


