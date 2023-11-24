Return-Path: <linux-fsdevel+bounces-3632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53767F6C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FB62812D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC877BE49;
	Fri, 24 Nov 2023 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UY07sXvb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B3B4C0E;
	Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lnbbS18wLWaDwOTFVceXIDvTLDooxjegMdHwHRn+IMc=; b=UY07sXvbpC/koBlSvAzwKDUaGu
	rjscW5ggMLL0lPPEISTLCAdk3wrU+vzisRdXudPRQA3fSYQYlyARj1w0of/UgAw8to0dWKwOLLpm/
	T38sQKLK5U9N9oShmD+WXidF4FQkfbR/j7hR5g/1p1VRDKBjkV9bRlGxOwu5s0mIAROFaQQe6Qhpk
	bGPDZkkF7o0y/unILxmXuc/5CKPdSPuI530UPJPZndfLNL5FOx9Ayrn/j3gyRQMaQjSGxwfClofxf
	urKnablmSBW1/LZQazrcOBgjIgh2lklEeHWDnwvmvdE3ka2IYh7T0DqzPhYO5t1pqyVpUO3ef0P6X
	1VTj4Xzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKw-002Q1D-1j;
	Fri, 24 Nov 2023 06:06:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] d_alloc_pseudo(): move setting ->d_op there from the (sole) caller
Date: Fri, 24 Nov 2023 06:06:36 +0000
Message-Id: <20231124060644.576611-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c     | 8 +++++++-
 fs/file_table.c | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 6dde21dbdd1a..1296a3fa4f93 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1890,9 +1890,15 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
  */
 struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 {
+	static const struct dentry_operations anon_ops = {
+		.d_dname = simple_dname
+	};
 	struct dentry *dentry = __d_alloc(sb, name);
-	if (likely(dentry))
+	if (likely(dentry)) {
 		dentry->d_flags |= DCACHE_NORCU;
+		if (!sb->s_d_op)
+			d_set_d_op(dentry, &anon_ops);
+	}
 	return dentry;
 }
 
diff --git a/fs/file_table.c b/fs/file_table.c
index de4a2915bfd4..8889cbee13f8 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -329,9 +329,6 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 				const char *name, int flags,
 				const struct file_operations *fops)
 {
-	static const struct dentry_operations anon_ops = {
-		.d_dname = simple_dname
-	};
 	struct qstr this = QSTR_INIT(name, strlen(name));
 	struct path path;
 	struct file *file;
@@ -339,8 +336,6 @@ struct file *alloc_file_pseudo(struct inode *inode, struct vfsmount *mnt,
 	path.dentry = d_alloc_pseudo(mnt->mnt_sb, &this);
 	if (!path.dentry)
 		return ERR_PTR(-ENOMEM);
-	if (!mnt->mnt_sb->s_d_op)
-		d_set_d_op(path.dentry, &anon_ops);
 	path.mnt = mntget(mnt);
 	d_instantiate(path.dentry, inode);
 	file = alloc_file(&path, flags, fops);
-- 
2.39.2


