Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F645780A88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 12:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjHRKzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 06:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244068AbjHRKya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6C270C
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 03:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C0766708
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 10:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56020C433CB;
        Fri, 18 Aug 2023 10:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692356068;
        bh=SseT1vduaEzsKIyBvRz/wmXqmIYUvn1qbmXNlxWgmJI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TOVX0dL3Smz4280I7ipfBDUikn1Rhi+yTtYVPpW7gaSfX1aN/l+S9w965ipWv214k
         HhPGarAyXIz5oNxise3BO+5g2gz8EaJJDKgHijbWpSKythMfGwPB5KmasN9/3xez4v
         JmRSRU8JmE5SsogScF5FwMnWBEHv4BorOpkuHlodzxBEsvno2Lp31LeFq3Hie3wua9
         eaKybtXANDAFMT5BJPg0Bzt3wx47pVAJbLWwnJ0EF/UWZSy28KQ1SNI8z+T/PxH+sN
         OA4x1dEvblWz1jBfYOMHWmPpHjZiHMqcjpNX/9Ivf0aaKaZwUYDYgqB9t6edetKuXH
         bybW1NIkgPL1A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Fri, 18 Aug 2023 12:54:18 +0200
Subject: [PATCH v2 4/4] super: wait until we passed kill super
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-vfs-super-fixes-v3-v2-4-cdab45934983@kernel.org>
References: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
In-Reply-To: <20230818-vfs-super-fixes-v3-v2-0-cdab45934983@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=6877; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SseT1vduaEzsKIyBvRz/wmXqmIYUvn1qbmXNlxWgmJI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc973T+Ip/Yt9BBqf1s3b9zPnu8KvxzvtCM+2o/Z2K/dGP
 VcondJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkbhEjw8WZ67VnVJjx32TNS1j6f9
 KiCU2mj259Te7v2KwUXFQjN53hr3zTR7nlYoxKoq5V50qvHclKeHGwqH/Rla0mJ2evDXDg5QAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recent rework moved block device closing out of sb->put_super() and into
sb->kill_sb() to avoid deadlocks as s_umount is held in put_super() and
blkdev_put() can end up taking s_umount again.

That means we need to move the removal of the superblock from @fs_supers
out of generic_shutdown_super() and into deactivate_locked_super() to
ensure that concurrent mounters don't fail to open block devices that
are still in use because blkdev_put() in sb->kill_sb() hasn't been
called yet.

We can now do this as we can make iterators through @fs_super and
@super_blocks wait without holding s_umount. Concurrent mounts will wait
until a dying superblock is fully dead so until sb->kill_sb() has been
called and SB_DEAD been set. Concurrent iterators can already discard
any SB_DYING superblock.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h |   1 +
 2 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 52e7b4153035..045d8611c44b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -93,6 +93,18 @@ static inline bool wait_born(struct super_block *sb)
 	return flags & (SB_BORN | SB_DYING);
 }
 
+static inline bool wait_dead(struct super_block *sb)
+{
+	unsigned int flags;
+
+	/*
+	 * Pairs with smp_store_release() in super_wake() and ensures
+	 * that we see SB_DEAD after we're woken.
+	 */
+	flags = smp_load_acquire(&sb->s_flags);
+	return flags & SB_DEAD;
+}
+
 /**
  * super_lock - wait for superblock to become ready
  * @sb: superblock to wait for
@@ -140,6 +152,33 @@ static bool super_lock(struct super_block *sb, bool excl)
 	goto relock;
 }
 
+/**
+ * super_lock_dead - wait for superblock to become ready or fully dead
+ * @sb: superblock to wait for
+ *
+ * Wait for a superblock to be SB_BORN or to be SB_DEAD. In other words,
+ * don't just wait for the superblock to be shutdown in
+ * generic_shutdown_super() but actually wait until sb->kill_sb() has
+ * finished.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_count.
+ *
+ * Return: This returns true if SB_BORN was set, false if SB_DEAD was
+ *         set. The function acquires s_umount and returns with it held.
+ */
+static bool super_lock_dead(struct super_block *sb)
+{
+	if (super_lock(sb, true))
+		return true;
+
+	lockdep_assert_held(&sb->s_umount);
+	super_unlock_excl(sb);
+	/* If superblock is dying, wait for everything to be shutdown. */
+	wait_var_event(&sb->s_flags, wait_dead(sb));
+	__super_lock_excl(sb);
+	return false;
+}
+
 /* wait and acquire read-side of @sb->s_umount */
 static inline bool super_lock_shared(struct super_block *sb)
 {
@@ -153,7 +192,7 @@ static inline bool super_lock_excl(struct super_block *sb)
 }
 
 /* wake waiters */
-#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING)
+#define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
 static void super_wake(struct super_block *sb, unsigned int flag)
 {
 	unsigned int flags = sb->s_flags;
@@ -169,6 +208,35 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+/**
+ * grab_super_dead - acquire an active reference to a superblock
+ * @sb: superblock to acquire
+ *
+ * Acquire a temporary reference on a superblock and try to trade it for
+ * an active reference. This is used in sget{_fc}() to wait for a
+ * superblock to either become SB_BORN or for it to pass through
+ * sb->kill() and be marked as SB_DEAD.
+ *
+ * Return: This returns true if an active reference could be acquired,
+ *         false if not. The function acquires s_umount and returns with
+ *         it held.
+ */
+static bool grab_super_dead(struct super_block *s) __releases(sb_lock)
+{
+	bool born;
+
+	s->s_count++;
+	spin_unlock(&sb_lock);
+	born = super_lock_dead(s);
+	if (born && atomic_inc_not_zero(&s->s_active)) {
+		put_super(s);
+		return true;
+	}
+	up_write(&s->s_umount);
+	put_super(s);
+	return false;
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -456,6 +524,25 @@ void deactivate_locked_super(struct super_block *s)
 		list_lru_destroy(&s->s_dentry_lru);
 		list_lru_destroy(&s->s_inode_lru);
 
+		/*
+		 * Remove it from @fs_supers so it isn't found by new
+		 * sget{_fc}() walkers anymore. Any concurrent mounter still
+		 * managing to grab a temporary reference is guaranteed to
+		 * already see SB_DYING and will wait until we notify them about
+		 * SB_DEAD.
+		 */
+		spin_lock(&sb_lock);
+		hlist_del_init(&s->s_instances);
+		spin_unlock(&sb_lock);
+
+		/*
+		 * Let concurrent mounts know that this thing is really dead.
+		 * We don't need @sb->s_umount here as every concurrent caller
+		 * will see SB_DYING and either discard the superblock or wait
+		 * for SB_DEAD.
+		 */
+		super_wake(s, SB_DEAD);
+
 		put_filesystem(fs);
 		put_super(s);
 	} else {
@@ -638,15 +725,14 @@ void generic_shutdown_super(struct super_block *sb)
 			spin_unlock(&sb->s_inode_list_lock);
 		}
 	}
-	spin_lock(&sb_lock);
-	/* should be initialized for __put_super_and_need_restart() */
-	hlist_del_init(&sb->s_instances);
-	spin_unlock(&sb_lock);
 	/*
 	 * Broadcast to everyone that grabbed a temporary reference to this
 	 * superblock before we removed it from @fs_supers that the superblock
 	 * is dying. Every walker of @fs_supers outside of sget{_fc}() will now
 	 * discard this superblock and treat it as dead.
+	 *
+	 * We leave the superblock on @fs_supers so it can be found by
+	 * sget{_fc}() until we passed sb->kill_sb().
 	 */
 	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
@@ -741,7 +827,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 		destroy_unused_super(s);
 		return ERR_PTR(-EBUSY);
 	}
-	if (!grab_super(old))
+	if (!grab_super_dead(old))
 		goto retry;
 	destroy_unused_super(s);
 	return old;
@@ -785,7 +871,7 @@ struct super_block *sget(struct file_system_type *type,
 				destroy_unused_super(s);
 				return ERR_PTR(-EBUSY);
 			}
-			if (!grab_super(old))
+			if (!grab_super_dead(old))
 				goto retry;
 			destroy_unused_super(s);
 			return old;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 173672645156..a63da68305e9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1095,6 +1095,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
+#define SB_DEAD         BIT(21)
 #define SB_DYING        BIT(24)
 #define SB_SUBMOUNT     BIT(26)
 #define SB_FORCE        BIT(27)

-- 
2.34.1

