Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331AF78AEC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjH1L10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 07:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjH1L07 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:26:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D4F7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 04:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19F7963C4B
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 11:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA98C433C8;
        Mon, 28 Aug 2023 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693222014;
        bh=u/LTcY3JzoYN9iUVs0DqG5qtMeZyqnuLJi9QJd8Rj6c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bAmT6vs92RbWCkhPmyA+ZklMFRX0ic0TseerKTCii5hlucUpCR3XX/HkoZyZHZ7Gj
         ZncZN7sghkFysFTE+tBBcHbPwp4VH4eKSTfU7lXMY2o1xlxnFiLYCGtdx4eIMf38yz
         9/repqibMHt5lgTF2f2IFzFFtBM73o7DWWzFrNCVKCvLM+FTc1A+jcS/kw2x4Y314c
         Bnb6mfRccXzbX4k5Cpvj7/lpZE3FsYulExy0ropp7gvt3k7EjfU2+YAZVyz1n1ab9d
         AFAPRdjgWVAYII6t5Qjs6feZyoulcE9j4crbcAZhHuo++RlSA4gJd78/Tw2qyFr8gP
         D9yEHvXzBrW8A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 28 Aug 2023 13:26:24 +0200
Subject: [PATCH 2/2] super: ensure valid info
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
In-Reply-To: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u/LTcY3JzoYN9iUVs0DqG5qtMeZyqnuLJi9QJd8Rj6c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8aana+XTH9c/eE3M1N68wkSlL407seFDwZHlfyz/+aCft
 C4mZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5uIqR4WlrtvSOVPGzn9w36Wjnsn
 wR1PurXbAxoPaOpdxzh8WrrjH8Zg/Z/qLpt8yblRudtDwO3utRv7fy9KHsSRs999lOtHvAxAwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For keyed filesystems that recycle superblocks based on s_fs_info or
information contained therein s_fs_info must be kept as long as the
superblock is on the filesystem type super list. This isn't guaranteed
as s_fs_info will be freed latest in sb->kill_sb().

The fix is simply to perform notification and list removal in
kill_anon_super(). Any filesystem needs to free s_fs_info after they
call the kill_*() helpers. If they don't they risk use-after-free right
now so fixing it here is guaranteed that s_fs_info remain valid.

For block backed filesystems notifying in pass sb->kill_sb() in
deactivate_locked_super() remains unproblematic and is required because
multiple other block devices can be shut down after kill_block_super()
has been called from a filesystem's sb->kill_sb() handler. For example,
ext4 and xfs close additional devices. Block based filesystems don't
depend on s_fs_info (btrfs does use s_fs_info but also uses
kill_anon_super() and not kill_block_super().).

Sorry for that braino. Goal should be to unify this behavior during this
cycle obviously. But let's please do a simple bugfix now.

Fixes: 2c18a63b760a ("super: wait until we passed kill super")
Fixes: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Reported-by: syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 779247eb219c..ad7ac3a24d38 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -434,6 +434,33 @@ void put_super(struct super_block *sb)
 	spin_unlock(&sb_lock);
 }
 
+static void kill_super_notify(struct super_block *sb)
+{
+	lockdep_assert_not_held(&sb->s_umount);
+
+	/* already notified earlier */
+	if (sb->s_flags & SB_DEAD)
+		return;
+
+	/*
+	 * Remove it from @fs_supers so it isn't found by new
+	 * sget{_fc}() walkers anymore. Any concurrent mounter still
+	 * managing to grab a temporary reference is guaranteed to
+	 * already see SB_DYING and will wait until we notify them about
+	 * SB_DEAD.
+	 */
+	spin_lock(&sb_lock);
+	hlist_del_init(&sb->s_instances);
+	spin_unlock(&sb_lock);
+
+	/*
+	 * Let concurrent mounts know that this thing is really dead.
+	 * We don't need @sb->s_umount here as every concurrent caller
+	 * will see SB_DYING and either discard the superblock or wait
+	 * for SB_DEAD.
+	 */
+	super_wake(sb, SB_DEAD);
+}
 
 /**
  *	deactivate_locked_super	-	drop an active reference to superblock
@@ -453,6 +480,8 @@ void deactivate_locked_super(struct super_block *s)
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
+		kill_super_notify(s);
+
 		/*
 		 * Since list_lru_destroy() may sleep, we cannot call it from
 		 * put_super(), where we hold the sb_lock. Therefore we destroy
@@ -461,25 +490,6 @@ void deactivate_locked_super(struct super_block *s)
 		list_lru_destroy(&s->s_dentry_lru);
 		list_lru_destroy(&s->s_inode_lru);
 
-		/*
-		 * Remove it from @fs_supers so it isn't found by new
-		 * sget{_fc}() walkers anymore. Any concurrent mounter still
-		 * managing to grab a temporary reference is guaranteed to
-		 * already see SB_DYING and will wait until we notify them about
-		 * SB_DEAD.
-		 */
-		spin_lock(&sb_lock);
-		hlist_del_init(&s->s_instances);
-		spin_unlock(&sb_lock);
-
-		/*
-		 * Let concurrent mounts know that this thing is really dead.
-		 * We don't need @sb->s_umount here as every concurrent caller
-		 * will see SB_DYING and either discard the superblock or wait
-		 * for SB_DEAD.
-		 */
-		super_wake(s, SB_DEAD);
-
 		put_filesystem(fs);
 		put_super(s);
 	} else {
@@ -1260,6 +1270,7 @@ void kill_anon_super(struct super_block *sb)
 {
 	dev_t dev = sb->s_dev;
 	generic_shutdown_super(sb);
+	kill_super_notify(sb);
 	free_anon_bdev(dev);
 }
 EXPORT_SYMBOL(kill_anon_super);

-- 
2.34.1

