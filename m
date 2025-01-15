Return-Path: <linux-fsdevel+bounces-39309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1FDA128BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5B77A29FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B966158DD8;
	Wed, 15 Jan 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qxbZ0w9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73578132105;
	Wed, 15 Jan 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958830; cv=none; b=uXRNou4x5s4UffXWpFksOm+sxkEa2RKuzh73znISApEVKhvEuJIc3OOUixOeJMe40cAHnUbu2DnMfpcyO2wb/KzSm498DIqgWuLZE7ASl6vAPpe2RM1+VLg24VvbtlBlfCRjLR2CDxifWCZxTwOluoKFh3GE2W1rkdWSu00Pd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958830; c=relaxed/simple;
	bh=nX/nhIsjOUcLlBn4V4TTAh/0TOY9Sl3MLTyLGigZDc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sl7Mi83m8WzjFrgONh3hpFb+5ZcPXPDsOnQmtjA5w8PywnIgUfkaEsDnwNf+UkVjEnT5Tuvdps70teX563tK6N+A9lxQFaF1uGh8ZdkW6eytvBPgVhofRbhayO3W4wJHhnYlf6Eu6Yc5u3n5edBqjIpH1ap1VtXm1ZXJYompzag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qxbZ0w9n; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JrTgrEEUfi08jB+SQvIEksCnooLdJo/IdjdB1aS/dq0=; b=qxbZ0w9nDkDEMUILwuiLvi+orw
	Fd76cWTJvRuO1EBQrRGJP4mxdjgcydJ+tOhPhsQQLMCIiUXxXLLyjfyKP2akOzOJ9wKO9QGqi/aXT
	Ogz6yYAv7QTze22V1Kb/90fdQi4mZCe8t4kHqDXZd/Jn8I85wcpiqUkNBZ+n+jEOwWKU3qzfEQ4M+
	WQcQIEjv4M2Szvzy81gdnCcfBCEaCIhWCbtY1YDl2DHfZaEICh0OU4Gl0bxEhIYtPbzvoRcabGCIF
	fF8OEHSAgLHmkjh3KyJCld0xf+hcczeh/f6mpG0x6Q1FagY+rlWGV3puKyfYb4sLS6sEJRZAjQV3t
	CIrhfkig==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tY6Kt-00GAFm-IE; Wed, 15 Jan 2025 17:33:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH] fuse: add new function to invalidate cache for all inodes
Date: Wed, 15 Jan 2025 16:32:53 +0000
Message-ID: <20250115163253.8402-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently userspace is able to notify the kernel to invalidate the cache
for an inode.  This means that, if all the inodes in a filesystem need to
be invalidated, then userspace needs to iterate through all of them and do
this kernel notification separately.

This patch adds a new option that allows userspace to invalidate all the
inodes with a single notification operation.  In addition to invalidate all
the inodes, it also shrinks the superblock dcache.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
Just an additional note that this patch could eventually be simplified if
Dave Chinner patch to iterate through the superblock inodes[1] is merged.

[1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com

 fs/fuse/inode.c           | 53 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  3 +++
 2 files changed, 56 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3ce4f4e81d09..1fd9a5f303da 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -546,6 +546,56 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 	return NULL;
 }
 
+static int fuse_reverse_inval_all(struct fuse_conn *fc)
+{
+	struct fuse_mount *fm;
+	struct super_block *sb;
+	struct inode *inode, *old_inode = NULL;
+	struct fuse_inode *fi;
+
+	inode = fuse_ilookup(fc, FUSE_ROOT_ID, NULL);
+	if (!inode)
+		return -ENOENT;
+
+	fm = get_fuse_mount(inode);
+	iput(inode);
+	if (!fm)
+		return -ENOENT;
+	sb = fm->sb;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		spin_lock(&inode->i_lock);
+		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		    !atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&sb->s_inode_list_lock);
+		iput(old_inode);
+
+		fi = get_fuse_inode(inode);
+		spin_lock(&fi->lock);
+		fi->attr_version = atomic64_inc_return(&fm->fc->attr_version);
+		spin_unlock(&fi->lock);
+		fuse_invalidate_attr(inode);
+		forget_all_cached_acls(inode);
+
+		old_inode = inode;
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(old_inode);
+
+	shrink_dcache_sb(sb);
+
+	return 0;
+}
+
 int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 			     loff_t offset, loff_t len)
 {
@@ -554,6 +604,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	pgoff_t pg_start;
 	pgoff_t pg_end;
 
+	if (nodeid == FUSE_INVAL_ALL_INODES)
+		return fuse_reverse_inval_all(fc);
+
 	inode = fuse_ilookup(fc, nodeid, NULL);
 	if (!inode)
 		return -ENOENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index f1e99458e29e..e9e78292d107 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -658,6 +658,9 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_CODE_MAX,
 };
 
+/* The nodeid to request to invalidate all inodes */
+#define FUSE_INVAL_ALL_INODES 0
+
 /* The read buffer is required to be at least 8k, but may be much larger */
 #define FUSE_MIN_READ_BUFFER 8192
 

