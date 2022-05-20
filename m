Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02C452E30F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343795AbiETDUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiETDUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:20:50 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C202BE44
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ghwgm1fH0htvND0fPUiymkLbazZybOUvyxu0mdeWPjY=; b=pYiQs7vojObOr/C2PiJZRwwaHA
        rQVBKFptpj42DZzIbdoWRW4UFv0IvCJPIgSm7bTB3YgZHGloWoxI2mKeMw9aASkeSkl5SodoDzM7q
        rxl3VxhWlHydvArfALDuzW8SG1dljDM4cM9sfGBeljD+/sJN5uNVumuODNZYqxr2eUhXW9RoESq3r
        8jao36qCdARVcXNPlp3zYj9uTH0P+PfEyrHqHzOrilH8ficg3TqnIz9QwLsDqHNckyGGPXCe8R5jN
        0yH9Wup239ghEEHAERiMSmk97z9B95eRhZiziLOaynqAC2q3OiyLUu8FTnryRsiL3P7QIbyHUcNYI
        L4TUzJag==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtC1-00GUAG-MZ
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:20:45 +0000
Date:   Fri, 20 May 2022 03:20:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] linux/mount.h: trim includes
Message-ID: <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
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
 include/linux/mount.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index 7f18a7555dff..b3b149dcbf96 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -11,17 +11,15 @@
 #define _LINUX_MOUNT_H
 
 #include <linux/types.h>
-#include <linux/list.h>
-#include <linux/nodemask.h>
-#include <linux/spinlock.h>
-#include <linux/seqlock.h>
-#include <linux/atomic.h>
+#include <asm/barrier.h>
 
 struct super_block;
-struct vfsmount;
 struct dentry;
-struct mnt_namespace;
+struct user_namespace;
+struct file_system_type;
 struct fs_context;
+struct file;
+struct path;
 
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
@@ -81,9 +79,6 @@ static inline struct user_namespace *mnt_user_ns(const struct vfsmount *mnt)
 	return smp_load_acquire(&mnt->mnt_userns);
 }
 
-struct file; /* forward dec */
-struct path;
-
 extern int mnt_want_write(struct vfsmount *mnt);
 extern int mnt_want_write_file(struct file *file);
 extern void mnt_drop_write(struct vfsmount *mnt);
@@ -94,12 +89,10 @@ extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);
 
-struct path;
 extern struct vfsmount *clone_private_mount(const struct path *path);
 extern int __mnt_want_write(struct vfsmount *);
 extern void __mnt_drop_write(struct vfsmount *);
 
-struct file_system_type;
 extern struct vfsmount *fc_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_create_mount(struct fs_context *fc);
 extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
-- 
2.30.2

