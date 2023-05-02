Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C906F453F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjEBNlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjEBNkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B70728F;
        Tue,  2 May 2023 06:39:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 165141FD64;
        Tue,  2 May 2023 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683034730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I/j4j9VxXGy/bDa3ZnK1aishpl8LLc1RBAztW/6LzNg=;
        b=TcCfrFzTb2GRwJYnmkZtx/AUQ6ImGap2e8r4FxC9peMvwWganei9xc2rzw0XO7CkKJvoqD
        Kb7qic6qmYoUyjZu9jtT+UfyJjpew6bT/ifb+NBAP2VrlT1UNFXqAonzY3WLwYc7RUwYE4
        tGeCU80e/++C4sgH6PfoViUwgJkFhnU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D26C3134FB;
        Tue,  2 May 2023 13:38:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFqdMmkSUWTOYQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 02 May 2023 13:38:49 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [RFC PATCH 2/3] cgroup: Rely on namespace_sem in current_cgns_cgroup_from_root explicitly
Date:   Tue,  2 May 2023 15:38:46 +0200
Message-Id: <20230502133847.14570-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502133847.14570-1-mkoutny@suse.com>
References: <20230502133847.14570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function current_cgns_cgroup_from_root() expects a stable
cgroup_root, which is currently ensured with RCU read side paired with
cgroup_destroy_root() called after RCU period.

The particular current_cgns_cgroup_from_root() is called from VFS code
and cgroup_root stability can be also ensured by namespace_sem. Mark it
explicitly as a preparation for further rework.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 fs/namespace.c         | 5 ++++-
 include/linux/mount.h  | 4 ++++
 kernel/cgroup/cgroup.c | 7 +++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..0d2333832064 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -71,7 +71,10 @@ static DEFINE_IDA(mnt_group_ida);
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
-static DECLARE_RWSEM(namespace_sem);
+DECLARE_RWSEM(namespace_sem);
+#ifdef CONFIG_LOCKDEP
+EXPORT_SYMBOL_GPL(namespace_sem);
+#endif
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1ea326c368f7..6277435f6748 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -80,6 +80,10 @@ static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 	return smp_load_acquire(&mnt->mnt_idmap);
 }
 
+#ifdef CONFIG_LOCKDEP
+extern struct rw_semaphore namespace_sem;
+#endif
+
 extern int mnt_want_write(struct vfsmount *mnt);
 extern int mnt_want_write_file(struct file *file);
 extern void mnt_drop_write(struct vfsmount *mnt);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 55e5f0110e3b..32d693a797b9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1440,13 +1440,12 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 
 	lockdep_assert_held(&css_set_lock);
 
-	rcu_read_lock();
+	/* namespace_sem ensures `root` stability on unmount */
+	lockdep_assert(lockdep_is_held_type(&namespace_sem, -1));
 
 	cset = current->nsproxy->cgroup_ns->root_cset;
 	res = __cset_cgroup_from_root(cset, root);
 
-	rcu_read_unlock();
-
 	return res;
 }
 
@@ -1454,7 +1453,7 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
  * Look up cgroup associated with current task's cgroup namespace on the default
  * hierarchy.
  *
- * Unlike current_cgns_cgroup_from_root(), this doesn't need locks:
+ * Relaxed locking requirements:
  * - Internal rcu_read_lock is unnecessary because we don't dereference any rcu
  *   pointers.
  * - css_set_lock is not needed because we just read cset->dfl_cgrp.
-- 
2.40.1

