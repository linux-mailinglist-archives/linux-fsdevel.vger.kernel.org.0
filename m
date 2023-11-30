Return-Path: <linux-fsdevel+bounces-4293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47147FE6F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76593B20EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3958125CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SNlQhdaR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A81BC;
	Wed, 29 Nov 2023 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701304640; x=1732840640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gZHtxMLuq2rTH5TQ4Whbm6hr8hi2bU/215bnbJKdOTo=;
  b=SNlQhdaRCh9tMWNatxvpPK6iyuIXqVlqYtTwrW4gmC/10NXaWYghZtcc
   2aJcTh0c4dQox6s/5yp/mZlNnnUorsEvCC4shbqUhZShrpFgANiBrPT08
   xSC1JNER7CAihcYvf0pvkyYpx2GIQXE93f/MSqOmSoNtJHc4ImG4CZtBd
   M=;
X-IronPort-AV: E=Sophos;i="6.04,237,1695686400"; 
   d="scan'208";a="365700991"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:37:19 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 72524803F3;
	Thu, 30 Nov 2023 00:37:18 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:44372]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.99:2525] with esmtp (Farcaster)
 id 28d82deb-a504-4c09-95be-bbb50a6ee114; Thu, 30 Nov 2023 00:37:17 +0000 (UTC)
X-Farcaster-Flow-ID: 28d82deb-a504-4c09-95be-bbb50a6ee114
Received: from EX19D010UWA004.ant.amazon.com (10.13.138.204) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 00:37:17 +0000
Received: from dev-dsk-kamatam-2b-b66a5860.us-west-2.amazon.com (10.169.6.191)
 by EX19D010UWA004.ant.amazon.com (10.13.138.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 00:37:17 +0000
From: Munehisa Kamata <kamatam@amazon.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>, "Munehisa
 Kamata" <kamatam@amazon.com>
Subject: [PATCH] proc: Update inode upon changing task security attribute
Date: Thu, 30 Nov 2023 00:37:04 +0000
Message-ID: <20231130003704.31928-1-kamatam@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D010UWA004.ant.amazon.com (10.13.138.204)

I'm not clear whether VFS is a better (or worse) place[1] to fix the
problem described below and would like to hear opinion.

If the /proc/[pid] directory is bind-mounted on a system with Smack
enabled, and if the task updates its current security attribute, the task
may lose access to files in its own /proc/[pid] through the mountpoint.

 $ sudo capsh --drop=cap_mac_override --
 # mkdir -p dir
 # mount --bind /proc/$$ dir
 # echo AAA > /proc/$$/task/current		# assuming built-in echo
 # cat /proc/$$/task/current			# revalidate
 AAA
 # echo BBB > dir/attr/current
 # cat dir/attr/current
 cat: dir/attr/current: Permission denied
 # ls dir/
 ls: cannot access dir/: Permission denied
 # cat /proc/$$/attr/current			# revalidate
 BBB
 # cat dir/attr/current
 BBB
 # echo CCC > /proc/$$/attr/current
 # cat dir/attr/current
 cat: dir/attr/current: Permission denied

This happens because path lookup doesn't revalidate the dentry of the
/proc/[pid] when traversing the filesystem boundary, so the inode security
blob of the /proc/[pid] doesn't get updated with the new task security
attribute. Then, this may lead security modules to deny an access to the
directory. Looking at the code[2] and the /proc/pid/attr/current entry in
proc man page, seems like the same could happen with SELinux. Though, I
didn't find relevant reports.

The steps above are quite artificial. I actually encountered such an
unexpected denial of access with an in-house application sandbox
framework; each app has its own dedicated filesystem tree where the
process's /proc/[pid] is bind-mounted to and the app enters into via
chroot.

With this patch, writing to /proc/[pid]/attr/current (and its per-security
module variant) updates the inode security blob of /proc/[pid] or
/proc/[pid]/task/[tid] (when pid != tid) with the new attribute.

[1] https://lkml.kernel.org/linux-fsdevel/4A2D15AF.8090000@sun.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c#n4220

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
---
 fs/proc/base.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index dd31e3b6bf77..bdb7bea53475 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2741,6 +2741,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 {
 	struct inode * inode = file_inode(file);
 	struct task_struct *task;
+	const char *name = file->f_path.dentry->d_name.name;
 	void *page;
 	int rv;
 
@@ -2784,10 +2785,26 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 	if (rv < 0)
 		goto out_free;
 
-	rv = security_setprocattr(PROC_I(inode)->op.lsm,
-				  file->f_path.dentry->d_name.name, page,
-				  count);
+	rv = security_setprocattr(PROC_I(inode)->op.lsm, name, page, count);
 	mutex_unlock(&current->signal->cred_guard_mutex);
+
+	/*
+	 *  Update the inode security blob in advance if the task's security
+	 *  attribute was updated
+	 */
+	if (rv > 0 && !strcmp(name, "current")) {
+		struct pid *pid;
+		struct proc_inode *cur, *ei;
+
+		rcu_read_lock();
+		pid = get_task_pid(current, PIDTYPE_PID);
+		hlist_for_each_entry(cur, &pid->inodes, sibling_inodes)
+			ei = cur;
+		put_pid(pid);
+		pid_update_inode(current, &ei->vfs_inode);
+		rcu_read_unlock();
+	}
+
 out_free:
 	kfree(page);
 out:
-- 
2.40.1


