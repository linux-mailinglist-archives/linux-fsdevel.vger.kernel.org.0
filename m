Return-Path: <linux-fsdevel+bounces-10204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D068848A94
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10ED2875F6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7BEAE6;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qxbrWosc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D47460;
	Sun,  4 Feb 2024 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=tcLqQ+Y2qvtnPMrN1vGcukvnFqYb5cZdu1Rt63mpJI4p8Mxp4J7x1Hd3JM91QCi8XleDmm99IA2DKJOELLRNgE87QVb3EbnYokhTHclnBpksVJmv9jTJEKtf17ZlqtZNDudkBnSYIzUE0PLbqRZMP6vRvmpd8rYvfg161kNTqgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=sG42Zf5DTiNNOcAGlM3Zr/H2o4OoCoJx8NrtZkRtutU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aK5h7M0WyGTbKtTPJlaKi2diYtQC5Ty72zarF9tS+o8NeNyav+FG5xq9U0MgRUIMWhvE0U0WiRqlhY1Cg33m4hP0WOhw427JTcki9vP3mo4XMTPt0qYy/nsfXohwCH+8KiBse21q0kD8Hm+z4jS4p93m0Ae4Ra9FdJtvnlsJjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qxbrWosc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EjWkAFYMC0New8r7aI9BMXvNYwHQVwhCzm32GsCIcMM=; b=qxbrWoscao3BKYzdD4PD0fuDnE
	UqP/FXLwX6jwmPbGH2l3okPgOnMkOvN4mfB2xIe3CBE66vbg4tcyGehDknGgRcBnzWVYAW9Lg8lVq
	WVina8FjERTRoggaxszJIc4HAQ9rlrJRXvyuw/HlXZ22ksVm5olRNKwf3xv0uJiKF9sbAoRapGU0k
	6pyhPYetdWWbFzrocj9H5kQ/F2sJK8oHTQCFJZvodGoXar0hHTveIw5gYjefjHKtH+BMyuFF5aWAi
	Nyc4n7zXFjKgC28keu+RISSYHcrJL6Aw9O04dAx9sLqRm4/8q1iHdse2CmN8CIT7esZk4ENubZV2O
	m1XMfxRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4i-004rD1-2B;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 05/13] hfsplus: switch to rcu-delayed unloading of nls and freeing ->s_fs_info
Date: Sun,  4 Feb 2024 02:17:31 +0000
Message-Id: <20240204021739.1157830-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_hash() and ->d_compare() use those, so we need to delay freeing
them.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hfsplus/hfsplus_fs.h |  1 +
 fs/hfsplus/super.c      | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 7ededcb720c1..012a3d003fbe 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -190,6 +190,7 @@ struct hfsplus_sb_info {
 	int work_queued;               /* non-zero delayed work is queued */
 	struct delayed_work sync_work; /* FS sync delayed work */
 	spinlock_t work_lock;          /* protects sync_work and work_queued */
+	struct rcu_head rcu;
 };
 
 #define HFSPLUS_SB_WRITEBACKUP	0
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..97920202790f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -277,6 +277,14 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
 	spin_unlock(&sbi->work_lock);
 }
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct hfsplus_sb_info *sbi = container_of(p, struct hfsplus_sb_info, rcu);
+
+	unload_nls(sbi->nls);
+	kfree(sbi);
+}
+
 static void hfsplus_put_super(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
@@ -302,9 +310,7 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	unload_nls(sbi->nls);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	call_rcu(&sbi->rcu, delayed_free);
 }
 
 static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
-- 
2.39.2


