Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89554BBF91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbiBRSfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:35:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiBRSfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:35:31 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E3251E75;
        Fri, 18 Feb 2022 10:35:14 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL82Z-0004OI-C5; Fri, 18 Feb 2022 13:31:35 -0500
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        paulmck@kernel.org, gscrivan@redhat.com, viro@zeniv.linux.org.uk,
        Rik van Riel <riel@surriel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH 1/2] vfs: free vfsmount through rcu work from kern_unmount
Date:   Fri, 18 Feb 2022 13:31:13 -0500
Message-Id: <20220218183114.2867528-2-riel@surriel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218183114.2867528-1-riel@surriel.com>
References: <20220218183114.2867528-1-riel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After kern_unmount returns, callers can no longer access the
vfsmount structure. However, the vfsmount structure does need
to be kept around until the end of the RCU grace period, to
make sure other accesses have all gone away too.

This can be accomplished by either gating each kern_unmount
on synchronize_rcu (the comment in the code says it all), or
by deferring the freeing until the next grace period, where
it needs to be handled in a workqueue due to the locking in
mntput_no_expire().

Suggested-by: Eric Biederman <ebiederm@xmission.com>
Reported-by: Chris Mason <clm@fb.com>
---
 fs/namespace.c        | 11 +++++++++--
 include/linux/mount.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 40b994a29e90..9f62cf6c69de 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4384,13 +4384,20 @@ struct vfsmount *kern_mount(struct file_system_type *type)
 }
 EXPORT_SYMBOL_GPL(kern_mount);
 
+static void mntput_rcu_work(struct work_struct *work)
+{
+	struct vfsmount *mnt = container_of(to_rcu_work(work),
+			       struct vfsmount, free_rwork);
+	mntput(mnt);
+}
+
 void kern_unmount(struct vfsmount *mnt)
 {
 	/* release long term mount so mount point can be released */
 	if (!IS_ERR_OR_NULL(mnt)) {
 		real_mount(mnt)->mnt_ns = NULL;
-		synchronize_rcu();	/* yecchhh... */
-		mntput(mnt);
+		INIT_RCU_WORK(&mnt->free_rwork, mntput_rcu_work);
+		queue_rcu_work(system_wq, &mnt->free_rwork);
 	}
 }
 EXPORT_SYMBOL(kern_unmount);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 7f18a7555dff..cd007cb70d57 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/atomic.h>
+#include <linux/workqueue.h>
 
 struct super_block;
 struct vfsmount;
@@ -73,6 +74,7 @@ struct vfsmount {
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	int mnt_flags;
 	struct user_namespace *mnt_userns;
+	struct rcu_work free_rwork;
 } __randomize_layout;
 
 static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
-- 
2.34.1

