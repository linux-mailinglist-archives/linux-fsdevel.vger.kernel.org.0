Return-Path: <linux-fsdevel+bounces-41383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CABA2E82C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECC1164354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341AE1C54BE;
	Mon, 10 Feb 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sumqEfQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216282B2DA;
	Mon, 10 Feb 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180935; cv=none; b=HrTf3J5yDt5kmL4//R5MEt9+juzVIMThdL6wXDr8fboZKuBSNVfmvp75He7nTLb60ycQXzJXlp8pjJZyaZVa1qbYz0BNGEO5nfccmXY2+DCQ2SeCnQKh3XCAZiv8qnLxvS7OEjGk7Yo8N23EsAj+EmY4acx4k04Ygr7TuR4FYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180935; c=relaxed/simple;
	bh=Me0LwP5wzy/BkVBF94yzA0evXRqU+PvQ25S5vc4pyCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2M5hiuc11oyvvwNXDQ1YTSHyHmeQr5+JCWmAnOCllQ97NmrG/qAzWqjy+dvWOPB/TEhdle8D+6g6JdfJ6Tq20v7loYEL0MYezYMHWXorJM2m7C5mrms79SiTdqTG6BAR+hxmWqlMB1ta+cj6NYRFLzVfxoYj57TK01/VpY8pwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sumqEfQN; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C9BUP77uPSvxs2+mKdlHJf2qkWrE1J5DcyM2T4Vp+80=; b=sumqEfQNp8AaL65zL97+992C3p
	Ru1OyShn1cdheLghTlSRytY8Cq7stQtXLam7mv70JfJXcNh5RMrP6t26Tn/BF7IWSGe8BEqIXS5C6
	NemQ5KgyrGu12aePaHk2I9yt6E33NUVeeTrxC1ymLXBgWpdOpY/RkNHqKdE6rqfwe7rm4bn2AKAkg
	QRE/zM8nPBLoHxVh61p1xKGaouXkhC/kpVK0Jb1AwmaAduUafoDY13hlLkzRi0YVK4vvzXs35SfDO
	jxNWy2enLoe+e/WMsMUZMvLxYhffteNAuMPdy/WcakLxawmwEtP6zp5S9su2kTgu0hBJa7bwb8HNE
	J8c08V1A==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1thQP5-0077WR-Jo; Mon, 10 Feb 2025 10:48:41 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2] fuse: add new function to invalidate cache for all inodes
Date: Mon, 10 Feb 2025 09:48:40 +0000
Message-ID: <20250210094840.5627-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently userspace is able to notify the kernel to invalidate the cache for
an inode.  This means that, if all the inodes in a filesystem need to be
invalidated, then userspace needs to iterate through all of them and do this
kernel notification separately.

This patch adds a new option that allows userspace to invalidate all the
inodes with a single notification operation.  In addition to invalidate all
the inodes, it also shrinks the sb dcache.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
Hi!

As suggested by Bernd, this patch v2 simply adds an helper function that
will make it easier to replace most of it's code by a call to function
super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.

[1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com

 fs/fuse/inode.c           | 59 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  3 ++
 2 files changed, 62 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..be51b53006d8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -547,6 +547,62 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 	return NULL;
 }
 
+static void inval_single_inode(struct inode *inode, struct fuse_conn *fc)
+{
+	struct fuse_inode *fi;
+
+	fi = get_fuse_inode(inode);
+	spin_lock(&fi->lock);
+	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	spin_unlock(&fi->lock);
+	fuse_invalidate_attr(inode);
+	forget_all_cached_acls(inode);
+}
+
+static int fuse_reverse_inval_all(struct fuse_conn *fc)
+{
+	struct fuse_mount *fm;
+	struct super_block *sb;
+	struct inode *inode, *old_inode = NULL;
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
+		inval_single_inode(inode, fc);
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
@@ -555,6 +611,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	pgoff_t pg_start;
 	pgoff_t pg_end;
 
+	if (nodeid == FUSE_INVAL_ALL_INODES)
+		return fuse_reverse_inval_all(fc);
+
 	inode = fuse_ilookup(fc, nodeid, NULL);
 	if (!inode)
 		return -ENOENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..e5852b63f99f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -669,6 +669,9 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_CODE_MAX,
 };
 
+/* The nodeid to request to invalidate all inodes */
+#define FUSE_INVAL_ALL_INODES 0
+
 /* The read buffer is required to be at least 8k, but may be much larger */
 #define FUSE_MIN_READ_BUFFER 8192
 

