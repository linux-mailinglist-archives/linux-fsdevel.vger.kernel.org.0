Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD5852E313
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbiETDYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiETDYB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:24:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE07F11AFC0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9jD4ZGh3MTfLnoBQSPCmx0Cyz527ah7gT8HS198vrTE=; b=KlA5aPM45flfdPRqz48kfciT/w
        0sr8hhCk0W3yvi0sAVQyhPO7t32WNt8YhmXXapSFAGy39/dzALzJG4WlDU8Zi6UcyCyLUqqzV1mss
        2YMeNKA62LyUFx7TLxAOArx28ZMJrgYhqFc0LJmGk66IJYmrDTtaODiImXkZX2r3UW6xNydovD02e
        GTW03IiCqeSRJoD/KGhfEe0F8VENs/OHAy0xkyY6AsTXtIZIK+zqlTFFcx0ZyS1hyNlDaMq51EtFS
        tnhzoL9Kj3mepsPH4F/n9IjVtY04WeeKfr+f2Nuc1pQk+5atFJ4n4SGKD1AosV15pWWfxWrZ3708x
        z0MjY+Gg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtF8-00GUC7-T9
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:23:58 +0000
Date:   Fri, 20 May 2022 03:23:58 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] move mount-related externs from fs.h to mount.h
Message-ID: <YocJzhlCzthlvS1I@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
 <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
 <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
 <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocJqCkNoTaehfYL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/kernel/osf_sys.c |  1 +
 include/linux/fs.h          | 11 -----------
 include/linux/mount.h       | 12 ++++++++++++
 security/smack/smackfs.c    |  1 +
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 8bbeebb73cf0..d257293401e2 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <linux/ipc.h>
 #include <linux/namei.h>
+#include <linux/mount.h>
 #include <linux/uio.h>
 #include <linux/vfs.h>
 #include <linux/rcupdate.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f3daaea16554..b51e3bd223f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2504,22 +2504,11 @@ struct super_block *sget(struct file_system_type *type,
 
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
-extern struct vfsmount *kern_mount(struct file_system_type *);
-extern void kern_unmount(struct vfsmount *mnt);
-extern int may_umount_tree(struct vfsmount *);
-extern int may_umount(struct vfsmount *);
-extern long do_mount(const char *, const char __user *,
-		     const char *, unsigned long, void *);
-extern struct vfsmount *collect_mounts(const struct path *);
-extern void drop_collected_mounts(struct vfsmount *);
-extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
-			  struct vfsmount *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
-extern bool our_mnt(struct vfsmount *mnt);
 extern __printf(2, 3)
 int super_setup_bdi_name(struct super_block *sb, char *fmt, ...);
 extern int super_setup_bdi(struct super_block *sb);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index b3b149dcbf96..55a4abaf6715 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -108,6 +108,18 @@ extern void mark_mounts_for_expiry(struct list_head *mounts);
 extern dev_t name_to_dev_t(const char *name);
 extern bool path_is_mountpoint(const struct path *path);
 
+extern bool our_mnt(struct vfsmount *mnt);
+
+extern struct vfsmount *kern_mount(struct file_system_type *);
+extern void kern_unmount(struct vfsmount *mnt);
+extern int may_umount_tree(struct vfsmount *);
+extern int may_umount(struct vfsmount *);
+extern long do_mount(const char *, const char __user *,
+		     const char *, unsigned long, void *);
+extern struct vfsmount *collect_mounts(const struct path *);
+extern void drop_collected_mounts(struct vfsmount *);
+extern int iterate_mounts(int (*)(struct vfsmount *, void *), void *,
+			  struct vfsmount *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 #endif /* _LINUX_MOUNT_H */
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 658eab05599e..192f33cc601e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/audit.h>
 #include <linux/magic.h>
+#include <linux/mount.h>
 #include <linux/fs_context.h>
 #include "smack.h"
 
-- 
2.30.2

