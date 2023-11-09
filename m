Return-Path: <linux-fsdevel+bounces-2645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B207E73B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C58B210F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55838F80;
	Thu,  9 Nov 2023 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UAdlYhOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DB38DEF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 21:38:21 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF43C39;
	Thu,  9 Nov 2023 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6ZT7FJvDZFk52iLWTs4ADJtCF3Ou7kQeTljiE1vVw8M=;
	t=1699565900; x=1700775500; b=UAdlYhOAvjrHYOPAbb2Mb8zNSg97SFKyj7Cpn+Y/RdoYZ1u
	+yHSpkU98GF4XU0nsiSTUsX/Hu186weqvkIKluzsGVehfN0TRaoeHwHohx0xtoFJoVpuKN3I1bYMU
	FsPxo/uwDa27c6G9HNR8LijMmQFG5PTf/o4FRLL6fpb2c94T4+MHvJsL4it87tZs4gmFXS2ytZ7S4
	9z9IoMIgL4EtqMqirlgMgDUxxu8lsHsCgUTq+HAoolmn+CqRGxD0eDUXCvONr0GB/nxqdA/bAOwSt
	GDR2Iw81HONfl95SrVKojS6/cfvFUp+HSWhVMUVRn/nWFqfQsdWVFPJR3egkqstw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1CjB-00000001znF-1Xz5;
	Thu, 09 Nov 2023 22:38:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 1/6] debugfs: fix automount d_fsdata usage
Date: Thu,  9 Nov 2023 22:22:53 +0100
Message-ID: <20231109222251.9e54cb55c700.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109212251.213873-7-johannes@sipsolutions.net>
References: <20231109212251.213873-7-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

debugfs_create_automount() stores a function pointer in d_fsdata,
but since commit 7c8d469877b1 ("debugfs: add support for more
elaborate ->d_fsdata") debugfs_release_dentry() will free it, now
conditionally on DEBUGFS_FSDATA_IS_REAL_FOPS_BIT, but that's not
set for the function pointer in automount. As a result, removing
an automount dentry would attempt to free the function pointer.
Luckily, the only user of this (tracing) never removes it.

Nevertheless, it's safer if we just handle the fsdata in one way,
namely either DEBUGFS_FSDATA_IS_REAL_FOPS_BIT or allocated. Thus,
change the automount to allocate it, and use the real_fops in the
data to indicate whether or not automount is filled, rather than
adding a type tag. At least for now this isn't actually needed,
but the next changes will require it.

Also check in debugfs_file_get() that it gets only called
on regular files, just to make things clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c     |  3 +++
 fs/debugfs/inode.c    | 25 ++++++++++++++++++-------
 fs/debugfs/internal.h | 10 ++++++++--
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 87b3753aa4b1..23bdfc126b5e 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa0..269bad87d552 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -236,17 +236,19 @@ static const struct super_operations debugfs_super_operations = {
 
 static void debugfs_release_dentry(struct dentry *dentry)
 {
-	void *fsd = dentry->d_fsdata;
+	struct debugfs_fsdata *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
+	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+		return;
+
+	kfree(fsd);
 }
 
 static struct vfsmount *debugfs_automount(struct path *path)
 {
-	debugfs_automount_t f;
-	f = (debugfs_automount_t)path->dentry->d_fsdata;
-	return f(path->dentry, d_inode(path->dentry)->i_private);
+	struct debugfs_fsdata *fsd = path->dentry->d_fsdata;
+
+	return fsd->automount(path->dentry, d_inode(path->dentry)->i_private);
 }
 
 static const struct dentry_operations debugfs_dops = {
@@ -634,11 +636,20 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data)
 {
 	struct dentry *dentry = start_creating(name, parent);
+	struct debugfs_fsdata *fsd;
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
 		return dentry;
 
+	fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
+	if (!fsd) {
+		failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	fsd->automount = f;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API)) {
 		failed_creating(dentry);
 		return ERR_PTR(-EPERM);
@@ -654,7 +665,7 @@ struct dentry *debugfs_create_automount(const char *name,
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
-	dentry->d_fsdata = (void *)f;
+	dentry->d_fsdata = fsd;
 	/* directory inodes start off with i_nlink == 2 (for "." entry) */
 	inc_nlink(inode);
 	d_instantiate(dentry, inode);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index 92af8ae31313..f7c489b5a368 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -17,8 +17,14 @@ extern const struct file_operations debugfs_full_proxy_file_operations;
 
 struct debugfs_fsdata {
 	const struct file_operations *real_fops;
-	refcount_t active_users;
-	struct completion active_users_drained;
+	union {
+		/* automount_fn is used when real_fops is NULL */
+		debugfs_automount_t automount;
+		struct {
+			refcount_t active_users;
+			struct completion active_users_drained;
+		};
+	};
 };
 
 /*
-- 
2.41.0


