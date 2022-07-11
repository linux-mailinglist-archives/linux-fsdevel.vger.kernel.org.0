Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9E56D364
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 05:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGKDh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jul 2022 23:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:37:55 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E511055F;
        Sun, 10 Jul 2022 20:37:48 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 6C0A410051D;
        Mon, 11 Jul 2022 13:37:47 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PYpA9ReO_2bm; Mon, 11 Jul 2022 13:37:47 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 60D90100518; Mon, 11 Jul 2022 13:37:47 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id DDE96100507;
        Mon, 11 Jul 2022 13:37:46 +1000 (AEST)
Subject: [PATCH 2/3] vfs: add propagate_mount_tree_busy() helper
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 Jul 2022 11:37:46 +0800
Message-ID: <165751066658.210556.1326573473015621909.stgit@donald.themaw.net>
In-Reply-To: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
References: <165751053430.210556.5634228273667507299.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that child mounts are tracked the expire checks need to be able to
use this to check if a mount is in use.

Currently when checking a mount for expiration may_umount_tree() checks
only if the passed in mount is in use. This leads to false positive
callbacks to the automount daemon to umount the mount which fail if any
propagated mounts are in use.

To avoid these unnecessary callbacks may_umount_tree() needs to check
propagated mounts in a similar way to may_umount().

Add a helper that can do this.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/pnode.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/pnode.h |    3 +++
 2 files changed, 64 insertions(+)

diff --git a/fs/pnode.c b/fs/pnode.c
index 1106137c747a..e2a906db4324 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -404,6 +404,67 @@ int propagate_mount_busy(struct mount *mnt, int refcnt)
 	return 0;
 }
 
+static int do_mount_in_use_check(struct mount *mnt, int cnt)
+{
+	struct mount *topper;
+
+	/* Is there exactly one mount on the child that covers
+	 * it completely?
+	 */
+	topper = find_topper(mnt);
+	if (topper) {
+		int topper_cnt = topper->mnt_mounts_cnt + 1;
+
+		/* Open file or pwd within singular mount? */
+		if (do_refcount_check(topper, topper_cnt))
+			return 1;
+		/* Account for singular mount on parent */
+		cnt += 1;
+	}
+
+	if (do_refcount_check(mnt, cnt))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Check if the mount tree at 'mnt' is in use or any of its
+ * propogated mounts are in use.
+ * @mnt: the mount to be checked
+ * @adjust: caller holds an additional reference to mount
+ * Check if mnt or any of its propogated mounts have a reference
+ * count greater than the minimum reference count (ie. are in use).
+ */
+int propagate_mount_tree_busy(struct mount *mnt, unsigned int flags)
+{
+	struct mount *parent = mnt->mnt_parent;
+	struct mount *m, *child;
+	unsigned int referenced = flags & TREE_BUSY_REFERENCED;
+	int cnt;
+
+	/* Check for an elevated refcount on the passed in mount.
+	 * If adjust is true the caller holds a reference to the
+	 * passed in mount.
+	 */
+	cnt = mnt->mnt_mounts_cnt + (referenced ?  2 : 1);
+	if (do_mount_in_use_check(mnt, cnt))
+		return 1;
+
+	for (m = propagation_next(parent, parent); m;
+			m = propagation_next(m, parent)) {
+		child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
+		if (!child)
+			continue;
+
+		cnt = child->mnt_mounts_cnt + 1;
+
+		if (do_mount_in_use_check(child, cnt))
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Clear MNT_LOCKED when it can be shown to be safe.
  *
diff --git a/fs/pnode.h b/fs/pnode.h
index 988f1aa9b02a..d7b9dddb257b 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -30,6 +30,8 @@
 
 #define CL_COPY_ALL		(CL_COPY_UNBINDABLE | CL_COPY_MNT_NS_FILE)
 
+#define TREE_BUSY_REFERENCED	0x01
+
 static inline void set_mnt_shared(struct mount *mnt)
 {
 	mnt->mnt.mnt_flags &= ~MNT_SHARED_MASK;
@@ -41,6 +43,7 @@ int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
 int propagate_umount(struct list_head *);
 int propagate_mount_busy(struct mount *, int);
+int propagate_mount_tree_busy(struct mount *, unsigned int);
 void propagate_mount_unlock(struct mount *);
 void mnt_release_group_id(struct mount *);
 int get_dominating_id(struct mount *mnt, const struct path *root);


