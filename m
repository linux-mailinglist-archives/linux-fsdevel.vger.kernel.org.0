Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34B67DB48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 02:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjA0BcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 20:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjA0BcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:32:04 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6068120;
        Thu, 26 Jan 2023 17:32:03 -0800 (PST)
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1pLDaz-0008Ij-0Y;
        Thu, 26 Jan 2023 20:32:01 -0500
Date:   Thu, 26 Jan 2023 20:31:59 -0500
From:   Rik van Riel <riel@surriel.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, linux-fsdevel@vger.kernel.org,
        gscrivan@redhat.com
Cc:     Chris Mason <clm@meta.com>
Subject: [PATCH v2 2/2] ipc,namespace: batch free ipc_namespace structures
Message-ID: <20230126203159.3af959c8@imladris.surriel.com>
In-Reply-To: <20230127011535.1265297-3-riel@surriel.com>
References: <20230127011535.1265297-1-riel@surriel.com>
        <20230127011535.1265297-3-riel@surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Jan 2023 20:15:35 -0500
Rik van Riel <riel@surriel.com> wrote:

> Instead of waiting for an RCU grace period between each ipc_namespace
> structure that is being freed, wait an RCU grace period for every batch
> of ipc_namespace structures.
> 
> Thanks to Al Viro for the suggestion of the helper function.

... and of course I forgot the "git add" before the "git commit --amend".
Sorry about that.

The real v2 of this patch, with Al's suggestions included is below.

---8<---

From 479378a794c5312acdb555b3deedc403134b2a70 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Thu, 26 Jan 2023 15:45:06 -0500
Subject: [PATCH] ipc,namespace: batch free ipc_namespace structures

Instead of waiting for an RCU grace period between each ipc_namespace
structure that is being freed, wait an RCU grace period for every batch
of ipc_namespace structures.

Thanks to Al Viro for the suggestion of the helper function.

This speeds up the run time of the test case that allocates ipc_namespaces
in a loop from 6 minutes, to a little over 1 second:

real	0m1.192s
user	0m0.038s
sys	0m1.152s

Signed-off-by: Rik van Riel <riel@surriel.com>
Reported-by: Chris Mason <clm@meta.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        | 18 ++++++++++++++----
 include/linux/mount.h |  1 +
 ipc/namespace.c       | 13 ++++++++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ab467ee58341..1ad4e5acef06 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1397,6 +1397,17 @@ struct vfsmount *mntget(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(mntget);
 
+/*
+ * Make a mount point inaccessible to new lookups.
+ * Because there may still be current users, the caller MUST WAIT
+ * for an RCU grace period before destroying the mount point.
+ */
+void mnt_make_shortterm(struct vfsmount *mnt)
+{
+	if (mnt)
+		real_mount(mnt)->mnt_ns = NULL;
+}
+
 /**
  * path_is_mountpoint() - Check if path is a mount in the current namespace.
  * @path: path to check
@@ -4573,8 +4584,8 @@ EXPORT_SYMBOL_GPL(kern_mount);
 void kern_unmount(struct vfsmount *mnt)
 {
 	/* release long term mount so mount point can be released */
-	if (!IS_ERR_OR_NULL(mnt)) {
-		real_mount(mnt)->mnt_ns = NULL;
+	if (!IS_ERR(mnt)) {
+		mnt_make_shortterm(mnt);
 		synchronize_rcu();	/* yecchhh... */
 		mntput(mnt);
 	}
@@ -4586,8 +4597,7 @@ void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
 	unsigned int i;
 
 	for (i = 0; i < num; i++)
-		if (mnt[i])
-			real_mount(mnt[i])->mnt_ns = NULL;
+		mnt_make_shortterm(mnt[i]);
 	synchronize_rcu_expedited();
 	for (i = 0; i < num; i++)
 		mntput(mnt[i]);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 62475996fac6..ec55a031aa8c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -88,6 +88,7 @@ extern void mnt_drop_write(struct vfsmount *mnt);
 extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
+extern void mnt_make_shortterm(struct vfsmount *mnt);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
diff --git a/ipc/namespace.c b/ipc/namespace.c
index a26860a41dac..6ecc30effd3e 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -145,10 +145,11 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 
 static void free_ipc_ns(struct ipc_namespace *ns)
 {
-	/* mq_put_mnt() waits for a grace period as kern_unmount()
-	 * uses synchronize_rcu().
+	/*
+	 * Caller needs to wait for an RCU grace period to have passed
+	 * after making the mount point inaccessible to new accesses.
 	 */
-	mq_put_mnt(ns);
+	mntput(ns->mq_mnt);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
@@ -168,6 +169,12 @@ static void free_ipc(struct work_struct *unused)
 	struct llist_node *node = llist_del_all(&free_ipc_list);
 	struct ipc_namespace *n, *t;
 
+	llist_for_each_entry_safe(n, t, node, mnt_llist)
+		mnt_make_shortterm(n->mq_mnt);
+
+	/* Wait for any last users to have gone away. */
+	synchronize_rcu();
+
 	llist_for_each_entry_safe(n, t, node, mnt_llist)
 		free_ipc_ns(n);
 }
-- 
2.38.1

