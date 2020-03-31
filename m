Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7174198913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgCaAy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:54:27 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:54738
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729636AbgCaAy0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:54:26 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C6BQA4lIJe/+im0XZmHgELHIQkgUA?=
 =?us-ascii?q?hEiqEGo9OAQEBAwaBEooghRSFFYU9gWcKAQEBAQEBAQEBGxkBAgQBAYREAoI?=
 =?us-ascii?q?yJDgTAhABAQEFAQEBAQEFAwFthQpYhXEGIwRSEBgNAhgOAgJHEAYThX4krXh?=
 =?us-ascii?q?/MxoCiimBDiqMMRp5gQeBETMDgTaBZoQ0gyyCXgSNcwyCd4cPRYEAlxuCRpc?=
 =?us-ascii?q?VHY9CA4wnLa0AIoFYTS4KgydQGI42F44yNzCBBgEBjSZfAQE?=
X-IPAS-Result: =?us-ascii?q?A2C6BQA4lIJe/+im0XZmHgELHIQkgUAhEiqEGo9OAQEBA?=
 =?us-ascii?q?waBEooghRSFFYU9gWcKAQEBAQEBAQEBGxkBAgQBAYREAoIyJDgTAhABAQEFA?=
 =?us-ascii?q?QEBAQEFAwFthQpYhXEGIwRSEBgNAhgOAgJHEAYThX4krXh/MxoCiimBDiqMM?=
 =?us-ascii?q?Rp5gQeBETMDgTaBZoQ0gyyCXgSNcwyCd4cPRYEAlxuCRpcVHY9CA4wnLa0AI?=
 =?us-ascii?q?oFYTS4KgydQGI42F44yNzCBBgEBjSZfAQE?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="238809201"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Mar 2020 08:54:20 +0800
Subject: [PATCH v2 2/4] autofs: remove rcu_walk parameter from
 autofs_expire_wait()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:54:18 +0800
Message-ID: <158561605892.23197.7870115837303946608.stgit@mickey.themaw.net>
In-Reply-To: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
References: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that do_expire_wait() isn't called from autofs_d_manage() the
rcu_walk boolean parameter can be removed. Now autofs_expire_wait()
and autofs_lookup_expiring() are no longer called from rcu-walk
context either so remove the extra parameter from them too.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h  |    2 +-
 fs/autofs/dev-ioctl.c |    2 +-
 fs/autofs/expire.c    |    5 +----
 fs/autofs/root.c      |   18 ++++++------------
 4 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 054f97b07754..5fc0c31b1fd5 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -152,7 +152,7 @@ void autofs_free_ino(struct autofs_info *);
 
 /* Expiration */
 int is_autofs_dentry(struct dentry *);
-int autofs_expire_wait(const struct path *path, int rcu_walk);
+int autofs_expire_wait(const struct path *path);
 int autofs_expire_run(struct super_block *, struct vfsmount *,
 		      struct autofs_sb_info *,
 		      struct autofs_packet_expire __user *);
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index a3cdb0036c5d..a892a517c695 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -437,7 +437,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	ino = autofs_dentry_ino(path.dentry);
 	if (ino) {
 		err = 0;
-		autofs_expire_wait(&path, 0);
+		autofs_expire_wait(&path);
 		spin_lock(&sbi->fs_lock);
 		param->requester.uid =
 			from_kuid_munged(current_user_ns(), ino->uid);
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index a1c7701007e7..f67da46f6992 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -486,7 +486,7 @@ static struct dentry *autofs_expire_indirect(struct super_block *sb,
 	return expired;
 }
 
-int autofs_expire_wait(const struct path *path, int rcu_walk)
+int autofs_expire_wait(const struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
@@ -497,9 +497,6 @@ int autofs_expire_wait(const struct path *path, int rcu_walk)
 	/* Block on any pending expire */
 	if (!(ino->flags & AUTOFS_INF_WANT_EXPIRE))
 		return 0;
-	if (rcu_walk)
-		return -ECHILD;
-
 retry:
 	spin_lock(&sbi->fs_lock);
 	state = ino->flags & (AUTOFS_INF_WANT_EXPIRE | AUTOFS_INF_EXPIRING);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a3b7c72a298d..a1c9c32e104f 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -177,8 +177,7 @@ static struct dentry *autofs_lookup_active(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *autofs_lookup_expiring(struct dentry *dentry,
-					     bool rcu_walk)
+static struct dentry *autofs_lookup_expiring(struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 	struct dentry *parent = dentry->d_parent;
@@ -197,11 +196,6 @@ static struct dentry *autofs_lookup_expiring(struct dentry *dentry,
 		struct dentry *expiring;
 		const struct qstr *qstr;
 
-		if (rcu_walk) {
-			spin_unlock(&sbi->lookup_lock);
-			return ERR_PTR(-ECHILD);
-		}
-
 		ino = list_entry(p, struct autofs_info, expiring);
 		expiring = ino->dentry;
 
@@ -257,16 +251,16 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 	return status;
 }
 
-static int do_expire_wait(const struct path *path, bool rcu_walk)
+static int do_expire_wait(const struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
 
-	expiring = autofs_lookup_expiring(dentry, rcu_walk);
+	expiring = autofs_lookup_expiring(dentry);
 	if (IS_ERR(expiring))
 		return PTR_ERR(expiring);
 	if (!expiring)
-		return autofs_expire_wait(path, rcu_walk);
+		return autofs_expire_wait(path);
 	else {
 		const struct path this = { .mnt = path->mnt, .dentry = expiring };
 		/*
@@ -274,7 +268,7 @@ static int do_expire_wait(const struct path *path, bool rcu_walk)
 		 * be quite complete, but the directory has been removed
 		 * so it must have been successful, just wait for it.
 		 */
-		autofs_expire_wait(&this, 0);
+		autofs_expire_wait(&this);
 		autofs_del_expiring(expiring);
 		dput(expiring);
 	}
@@ -327,7 +321,7 @@ static struct vfsmount *autofs_d_automount(struct path *path)
 	 * and the directory was removed, so just go ahead and try
 	 * the mount.
 	 */
-	status = do_expire_wait(path, 0);
+	status = do_expire_wait(path);
 	if (status && status != -EAGAIN)
 		return NULL;
 

