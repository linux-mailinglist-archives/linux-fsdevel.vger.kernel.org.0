Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897F777F474
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbjHQKsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350006AbjHQKsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330B72D54
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 03:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C45CB62887
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 10:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D23BC433C8;
        Thu, 17 Aug 2023 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692269280;
        bh=AbC55INTlMhvPZv/xNNCsMKtcsY5B/9ka5ogbMcQPBQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EYm9OFvcvrNKLLUt3sjgt/0Nfi91GrCF8fanIr588gFKYzTHs63gh19vbEIH0rxh5
         uzlinI0215F5Ihm99ZjudwQcfseHTc7H5Ntq0oYsNgEKOygAqR8YTkuY04ADmX9Kpw
         gPthP+Bhtwy8qUSCjrMdND7v67rVXWaJx31al3eZ8D6LpkLGiZD2OlyvOeHYQt4FSn
         S20p7Q3DygRXZ9LsqGkAmvJczb5hNsPGDE3npKVcaUFPZH3w9+h+hfOODH5Zco9zlD
         vuLdAb/TWoAjtaiGqpJddhJYExN+MXSFjn5cZ68XXpbtXbHb3u33dWKUbpqzg0hCQ9
         c1RRXHlRtHxdg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Thu, 17 Aug 2023 12:47:44 +0200
Subject: [PATCH 3/3] super: wait until we passed kill super
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230817-vfs-super-fixes-v3-v1-3-06ddeca7059b@kernel.org>
References: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
In-Reply-To: <20230817-vfs-super-fixes-v3-v1-0-06ddeca7059b@kernel.org>
To:     Jan Kara <jack@suse.com>, Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=5441; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AbC55INTlMhvPZv/xNNCsMKtcsY5B/9ka5ogbMcQPBQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTc/XWL29Bg4taupskMIdyFvd/8BbWZfjdLXGup+7opcp+j
 iKt0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER+PGT4n+wil/mW13lC4JaZks/sL+
 6oXLfxR6773dM/W57Unsjs+MvwPyv6TNfTVVOjXpQqrjz8o3y+pTJTfV5KjPNi1YiiziROFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/super.c         | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/fs.h |  1 +
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 55bf495763d9..710448078c07 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -98,6 +98,18 @@ static inline bool wait_born(struct super_block *sb)
 	return flags & (SB_BORN | SB_DYING);
 }
 
+static inline bool wait_dead(struct super_block *sb)
+{
+	unsigned int flags;
+
+	/*
+	 * Pairs with smp_store_release() in super_wake() and ensure
+	 * that we see SB_DEAD after we're woken.
+	 */
+	flags = smp_load_acquire(&sb->s_flags);
+	return flags & SB_DEAD;
+}
+
 /**
  * super_wait - wait for superblock to become ready
  * @sb: superblock to wait for
@@ -144,6 +156,19 @@ static bool super_wait(struct super_block *sb, bool excl)
 	goto relock;
 }
 
+static bool super_wait_dead(struct super_block *sb)
+{
+	if (super_wait(sb, true))
+		return true;
+
+	lockdep_assert_held(&sb->s_umount);
+	super_unlock_write(sb);
+	/* If superblock is dying, wait for everything to be shutdown. */
+	wait_var_event(&sb->s_flags, wait_dead(sb));
+	super_lock_write(sb);
+	return false;
+}
+
 /* wait and acquire read-side of @sb->s_umount */
 static inline bool super_wait_read(struct super_block *sb)
 {
@@ -169,6 +194,22 @@ static void super_wake(struct super_block *sb, unsigned int flag)
 	wake_up_var(&sb->s_flags);
 }
 
+static int grab_super_wait_dead(struct super_block *s) __releases(sb_lock)
+{
+	bool born;
+
+	s->s_count++;
+	spin_unlock(&sb_lock);
+	born = super_wait_dead(s);
+	if (born && atomic_inc_not_zero(&s->s_active)) {
+		put_super(s);
+		return 1;
+	}
+	up_write(&s->s_umount);
+	put_super(s);
+	return 0;
+}
+
 /*
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
@@ -456,6 +497,25 @@ void deactivate_locked_super(struct super_block *s)
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
@@ -638,15 +698,14 @@ void generic_shutdown_super(struct super_block *sb)
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
 	super_unlock_write(sb);
@@ -741,7 +800,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 		destroy_unused_super(s);
 		return ERR_PTR(-EBUSY);
 	}
-	if (!grab_super(old))
+	if (!grab_super_wait_dead(old))
 		goto retry;
 	destroy_unused_super(s);
 	return old;
@@ -785,7 +844,7 @@ struct super_block *sget(struct file_system_type *type,
 				destroy_unused_super(s);
 				return ERR_PTR(-EBUSY);
 			}
-			if (!grab_super(old))
+			if (!grab_super_wait_dead(old))
 				goto retry;
 			destroy_unused_super(s);
 			return old;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 173672645156..34ac792c4b19 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1095,6 +1095,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_LAZYTIME     BIT(25)	/* Update the on-disk [acm]times lazily */
 
 /* These sb flags are internal to the kernel */
+#define SB_DEAD	        BIT(21)
 #define SB_DYING        BIT(24)
 #define SB_SUBMOUNT     BIT(26)
 #define SB_FORCE        BIT(27)

-- 
2.34.1

