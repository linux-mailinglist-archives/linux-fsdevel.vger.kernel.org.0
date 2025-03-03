Return-Path: <linux-fsdevel+bounces-42932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15545A4C32B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 15:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05437A3AD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C47214211;
	Mon,  3 Mar 2025 14:17:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9478F39;
	Mon,  3 Mar 2025 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011421; cv=none; b=bzRjxCw1Je9qsQnfCqFYtHgvjanRQyAk8hdTwAHl17uxGdNshHln7RTqqZhnwbSe+IwAnh6+8sGsdfsIGnIsCLkZRizyP+00P2BQdLhxsiFrrvs2zndU5zQGUiV+8YyY3ff8Jd8mWAe4SeBwONnoIBQ4csyxd1QzTGMkkJNJe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011421; c=relaxed/simple;
	bh=b4taB+Fti+VB8e0zy6Q1xVV9/mBkIXRAE0/+vRXbT90=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bw6t3swjlS3/FC65Dqov3AzEvShUy8keRb6GKS2MiQtRjIc2kBn14IA5ObiRYZiYmlxHODStJ4fpxeOo3lmUtKgqlBoo/DCRxa4n94lM/i9msIZCjXRcutJZez9flOr+RVgebR3/RCLsi3E16dsmSeWKFVoDNltnBcAkNbpkg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z613420R5zwWx3;
	Mon,  3 Mar 2025 22:12:00 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 552791800E5;
	Mon,  3 Mar 2025 22:16:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Mar
 2025 22:16:50 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <sfrench@samba.org>,
	<pc@manguebit.com>, <ronniesahlberg@gmail.com>, <sprasad@microsoft.com>,
	<tom@talpey.com>, <bharathsm@microsoft.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <yukuai1@huaweicloud.com>,
	<houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
	<lilingfeng@huaweicloud.com>, <lilingfeng3@huawei.com>
Subject: [PATCH] nfs: Fix incorrect read-only status reporting in mountstats
Date: Mon, 3 Mar 2025 22:33:55 +0800
Message-ID: <20250303143355.3821411-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In the process of read-only mounting of NFS, only the first generated
superblock carries the ro flag passed from the user space.
However, NFS mounting may generate multiple superblocks, and the last
generated superblock is the one actually used. This leads to a situation
where the superblock of a read-only NFS file system may not have the ro
flag. Therefore, using s_flags to determine whether an NFS file system is
read-only is incorrect.

Use mnt_flags instead of s_flags to decide whether the file system state
displayed by the /proc/self/mountstats interface is read-only or not.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/internal.h      |  2 +-
 fs/nfs/super.c         | 12 ++++++------
 fs/proc_namespace.c    |  2 +-
 fs/smb/client/cifsfs.c |  2 +-
 include/linux/fs.h     |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index fae2c7ae4acc..14076fc9b1e8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -565,7 +565,7 @@ int  nfs_statfs(struct dentry *, struct kstatfs *);
 int  nfs_show_options(struct seq_file *, struct dentry *);
 int  nfs_show_devname(struct seq_file *, struct dentry *);
 int  nfs_show_path(struct seq_file *, struct dentry *);
-int  nfs_show_stats(struct seq_file *, struct dentry *);
+int  nfs_show_stats(struct seq_file *, struct vfsmount *);
 int  nfs_reconfigure(struct fs_context *);
 
 /* write.c */
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index aeb715b4a690..62dfba216f7f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -662,10 +662,10 @@ EXPORT_SYMBOL_GPL(nfs_show_path);
 /*
  * Present statistical information for this VFS mountpoint
  */
-int nfs_show_stats(struct seq_file *m, struct dentry *root)
+int nfs_show_stats(struct seq_file *m, struct vfsmount *mnt)
 {
 	int i, cpu;
-	struct nfs_server *nfss = NFS_SB(root->d_sb);
+	struct nfs_server *nfss = NFS_SB(mnt->mnt_sb);
 	struct rpc_auth *auth = nfss->client->cl_auth;
 	struct nfs_iostats totals = { };
 
@@ -675,10 +675,10 @@ int nfs_show_stats(struct seq_file *m, struct dentry *root)
 	 * Display all mount option settings
 	 */
 	seq_puts(m, "\n\topts:\t");
-	seq_puts(m, sb_rdonly(root->d_sb) ? "ro" : "rw");
-	seq_puts(m, root->d_sb->s_flags & SB_SYNCHRONOUS ? ",sync" : "");
-	seq_puts(m, root->d_sb->s_flags & SB_NOATIME ? ",noatime" : "");
-	seq_puts(m, root->d_sb->s_flags & SB_NODIRATIME ? ",nodiratime" : "");
+	seq_puts(m, (mnt->mnt_flags & MNT_READONLY) ? "ro" : "rw");
+	seq_puts(m, mnt->mnt_sb->s_flags & SB_SYNCHRONOUS ? ",sync" : "");
+	seq_puts(m, mnt->mnt_sb->s_flags & SB_NOATIME ? ",noatime" : "");
+	seq_puts(m, mnt->mnt_sb->s_flags & SB_NODIRATIME ? ",nodiratime" : "");
 	nfs_show_mount_options(m, nfss, 1);
 
 	seq_printf(m, "\n\tage:\t%lu", (jiffies - nfss->mount_time) / HZ);
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e133b507ddf3..1310c655f33f 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -227,7 +227,7 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 	/* optional statistics */
 	if (sb->s_op->show_stats) {
 		seq_putc(m, ' ');
-		err = sb->s_op->show_stats(m, mnt_path.dentry);
+		err = sb->s_op->show_stats(m, mnt);
 	}
 
 	seq_putc(m, '\n');
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 6a3bd652d251..f3bf2c62e195 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -836,7 +836,7 @@ static int cifs_freeze(struct super_block *sb)
 }
 
 #ifdef CONFIG_CIFS_STATS2
-static int cifs_show_stats(struct seq_file *s, struct dentry *root)
+static int cifs_show_stats(struct seq_file *s, struct vfsmount *mnt)
 {
 	/* BB FIXME */
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2788df98080f..94ad8bdb409b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2308,7 +2308,7 @@ struct super_operations {
 	int (*show_options)(struct seq_file *, struct dentry *);
 	int (*show_devname)(struct seq_file *, struct dentry *);
 	int (*show_path)(struct seq_file *, struct dentry *);
-	int (*show_stats)(struct seq_file *, struct dentry *);
+	int (*show_stats)(struct seq_file *, struct vfsmount *);
 #ifdef CONFIG_QUOTA
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-- 
2.31.1


