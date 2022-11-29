Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3663CB91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 00:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiK2XIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 18:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiK2XIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED10167FF
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669763265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eq6o2YkUszl+9c046A048ilgSrG46T/MwnQ/rycUhiw=;
        b=e+I6x6mmepSojEZ+VKlRFeveiWdiXfCXuvI7kh4M6cseIVcxfNT+J2bJpXJlAv8cE/QN7A
        WjCaq3XPGDq4YX0PmtM0ApfCmbLnW0KIU8ZEmelFJTYiV2AftpBt9WeLNL2xG7ZrVn/B6J
        cHMeGa8XEe7sgzCFX+Laml1QWgR6GLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-ZpNed_X9NYemhnwKJjysmg-1; Tue, 29 Nov 2022 18:07:43 -0500
X-MC-Unique: ZpNed_X9NYemhnwKJjysmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34599811E75;
        Tue, 29 Nov 2022 23:07:42 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAFC040C6EC4;
        Tue, 29 Nov 2022 23:07:40 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fs: Introduce { freeze, thaw }_active_super functions
Date:   Wed, 30 Nov 2022 00:07:34 +0100
Message-Id: <20221129230736.3462830-3-agruenba@redhat.com>
In-Reply-To: <20221129230736.3462830-1-agruenba@redhat.com>
References: <20221129230736.3462830-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce functions freeze_active_super() and thaw_active_super(), which
are like freeze_super() and thaw_super() but don't keep an active super
block reference between freeze_super() and the following thaw_super().
This allows filesystem shutdown to occur while a filesystem is frozen.

In places in the filesystem code where a super block may or may not be
active anymore (i.e., places that may race with ->put_super()), function
activate_super() can be used for grabbing an active super block
reference.  In that case,

freeze_super(sb) turns into:

	if (activate_super(sb)) {
		ret = freeze_active_super(sb);
		deactivate_super(sb);
	}

and thaw_super(sb) turns into:

	if (activate_super(sb)) {
		ret = thaw_active_super(sb);
		deactivate_super(sb);
	}

For obvious reaons, the filesystem is responsible for making sure that
no such asynchronous code outlives put_super().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/super.c         | 70 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |  2 ++
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 051241cf408b..cba55ca89c09 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -39,6 +39,7 @@
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
+static int thaw_active_super_locked(struct super_block *sb);
 static int thaw_super_locked(struct super_block *sb);
 
 static LIST_HEAD(super_blocks);
@@ -510,6 +511,8 @@ void generic_shutdown_super(struct super_block *sb)
 		if (sop->put_super)
 			sop->put_super(sb);
 
+		thaw_active_super_locked(sb);
+
 		if (!list_empty(&sb->s_inodes)) {
 			printk("VFS: Busy inodes after unmount of %s. "
 			   "Self-destruct in 5 seconds.  Have a nice day...\n",
@@ -1676,7 +1679,7 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
 }
 
 /**
- * freeze_super - lock the filesystem and force it into a consistent state
+ * freeze_active_super - lock the filesystem and force it into a consistent state
  * @sb: the super to lock
  *
  * Syncs the super to make sure the filesystem is consistent and calls the fs's
@@ -1708,11 +1711,10 @@ static void sb_freeze_unlock(struct super_block *sb, int level)
  *
  * sb->s_writers.frozen is protected by sb->s_umount.
  */
-int freeze_super(struct super_block *sb)
+int freeze_active_super(struct super_block *sb)
 {
 	int ret;
 
-	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
 	if (sb->s_writers.frozen != SB_UNFROZEN) {
 		deactivate_locked_super(sb);
@@ -1776,16 +1778,38 @@ int freeze_super(struct super_block *sb)
 	up_write(&sb->s_umount);
 	return 0;
 }
+EXPORT_SYMBOL(freeze_active_super);
+
+/**
+ * freeze_super - lock the filesystem and force it into a consistent state
+ * @sb: the super to lock
+ *
+ * Like freeze_active_super(), but takes an active reference on @sb so
+ * that it cannot be shut down while frozen.
+ */
+int freeze_super(struct super_block *sb)
+{
+	atomic_inc(&sb->s_active);
+	return freeze_active_super(sb);
+}
 EXPORT_SYMBOL(freeze_super);
 
-static int thaw_super_locked(struct super_block *sb)
+/**
+ * thaw_active_super_locked -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ *
+ * Like thaw_super(), but takes a locked super block, leaves it locked, and
+ * doesn't drop an active reference.  For use in ->put_super by filesystems
+ * that use freeze_active_super() and thaw_active_super().
+ */
+static int thaw_active_super_locked(struct super_block *sb)
 {
 	int error;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
-		up_write(&sb->s_umount);
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
 		return -EINVAL;
-	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.frozen = SB_UNFROZEN;
@@ -1800,7 +1824,6 @@ static int thaw_super_locked(struct super_block *sb)
 			printk(KERN_ERR
 				"VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			up_write(&sb->s_umount);
 			return error;
 		}
 	}
@@ -1809,6 +1832,18 @@ static int thaw_super_locked(struct super_block *sb)
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
 	wake_up(&sb->s_writers.wait_unfrozen);
+	return 0;
+}
+
+static int thaw_super_locked(struct super_block *sb)
+{
+	int ret;
+
+	ret = thaw_active_super_locked(sb);
+	if (ret) {
+		up_write(&sb->s_umount);
+		return ret;
+	}
 	deactivate_locked_super(sb);
 	return 0;
 }
@@ -1825,3 +1860,22 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+/**
+ * thaw_active_super -- unlock filesystem
+ * @sb: the super to thaw
+ *
+ * Unlocks the filesystem and marks it writeable again after freeze_super().
+ *
+ * Like thaw_super(), but doesn't drop an active reference.
+ */
+int thaw_active_super(struct super_block *sb)
+{
+	int ret;
+
+	down_write(&sb->s_umount);
+	ret = thaw_active_super_locked(sb);
+	up_write(&sb->s_umount);
+	return ret;
+}
+EXPORT_SYMBOL(thaw_active_super);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84c609123a25..fe869102cd85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2612,6 +2612,8 @@ extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
+extern int freeze_active_super(struct super_block *super);
+extern int thaw_active_super(struct super_block *super);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
-- 
2.38.1

