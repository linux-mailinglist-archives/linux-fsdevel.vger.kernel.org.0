Return-Path: <linux-fsdevel+bounces-666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E557CE131
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883A01F23430
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D783AC0E;
	Wed, 18 Oct 2023 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8RAroh2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lB/l16MV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E015AE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:29:30 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3F119
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:29:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8CCC91F383;
	Wed, 18 Oct 2023 15:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697642966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OqJpMmsX7KVeyLXusDyJpnhIM3uqPdENlqY8PJmQlC8=;
	b=x8RAroh2n9PuxwkM+VgisjY+lswN+GqNY0vdfNIu7kjps58Z4vchKYAbl9ZKJRk6NKRxJK
	jZPfdajrrrQWslS2LEM+EFt7SuB9PBskeahLndRMpippqjrVjNJFJaYpcY8Qxh7QfAHfd0
	lJi8o+gQNIBe2xQl8IRyqeuDSFjsyPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697642966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=OqJpMmsX7KVeyLXusDyJpnhIM3uqPdENlqY8PJmQlC8=;
	b=lB/l16MVf6YR9t650woBHTZFP/BAVnXi+mLSEJdPv9hSJgyVN9MBsFbKnLpiHnAQ2H7Ht2
	gGAXwpyk06KruyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7851413780;
	Wed, 18 Oct 2023 15:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EUxPHdb5L2VseQAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 18 Oct 2023 15:29:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 043ACA06B0; Wed, 18 Oct 2023 17:29:25 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock
Date: Wed, 18 Oct 2023 17:29:24 +0200
Message-Id: <20231018152924.3858-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4554; i=jack@suse.cz; h=from:subject; bh=fhf4PxKpHhLstiJoeXU0ZUzeBDapG2hYkP71E3ms7ak=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlL/nJ1KFji5ZuCu6i47epPhUNfSpwziLxR19PQS22 epvpGaaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZS/5yQAKCRCcnaoHP2RA2eUnCA CJLoJWakX9JRd+BoPYS1AQYcMie8yFQl+k8OgeL/pckGczFCMEaBcezhzMsHvs118T4F21UYfpsX0B VVVeY8krF/WGtccAfWsQ94HD4y+AN/bfjrEYiNVfilWVNhiW2ez2dKvTdhpsy7UMSVwD6s+fKbwrWT tPhOodF0NeovRuMNmEVkv6iBsahijotJH3TsggPg3xSO4z0dsgD4JkDj0EmW4htqX54iMGw/wT6ikG g9+aVI5lN8R6M9G1ZWjkuzwcCAdhuycp8vSDbq6Tr/6ydtSfFbjpXCRflHX8UQPbvx2Jf9tj9SuGOx /cmcczM706LvBYJr7RoHNgHOF2lytW
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The implementation of bdev holder operations such as fs_bdev_mark_dead()
and fs_bdev_sync() grab sb->s_umount semaphore under
bdev->bd_holder_lock. This is problematic because it leads to
disk->open_mutex -> sb->s_umount lock ordering which is counterintuitive
(usually we grab higher level (e.g. filesystem) locks first and lower
level (e.g. block layer) locks later) and indeed makes lockdep complain
about possible locking cycles whenever we open a block device while
holding sb->s_umount semaphore. Implement a function
bdev_super_lock_shared() which safely transitions from holding
bdev->bd_holder_lock to holding sb->s_umount on alive superblock without
introducing the problematic lock dependency. We use this function
fs_bdev_sync() and fs_bdev_mark_dead().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c  |  5 +++--
 block/ioctl.c |  5 +++--
 fs/super.c    | 48 ++++++++++++++++++++++++++++++------------------
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..a9a485aae6b0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -961,9 +961,10 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else
+	else {
+		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
-	mutex_unlock(&bdev->bd_holder_lock);
+	}
 
 	invalidate_bdev(bdev);
 }
diff --git a/block/ioctl.c b/block/ioctl.c
index d5f5cd61efd7..fc492f9d34ae 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -370,9 +370,10 @@ static int blkdev_flushbuf(struct block_device *bdev, unsigned cmd,
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->sync)
 		bdev->bd_holder_ops->sync(bdev);
-	else
+	else {
+		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
-	mutex_unlock(&bdev->bd_holder_lock);
+	}
 
 	invalidate_bdev(bdev);
 	return 0;
diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e..8b80d03e7cb4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1419,32 +1419,45 @@ EXPORT_SYMBOL(sget_dev);
 
 #ifdef CONFIG_BLOCK
 /*
- * Lock a super block that the callers holds a reference to.
+ * Lock the superblock that is holder of the bdev. Returns the superblock
+ * pointer if we successfully locked the superblock and it is alive. Otherwise
+ * we return NULL and just unlock bdev->bd_holder_lock.
  *
- * The caller needs to ensure that the super_block isn't being freed while
- * calling this function, e.g. by holding a lock over the call to this function
- * and the place that clears the pointer to the superblock used by this function
- * before freeing the superblock.
+ * The function must be called with bdev->bd_holder_lock and releases it.
  */
-static bool super_lock_shared_active(struct super_block *sb)
+static struct super_block *bdev_super_lock_shared(struct block_device *bdev)
+	__releases(&bdev->bd_holder_lock)
 {
-	bool born = super_lock_shared(sb);
+	struct super_block *sb = bdev->bd_holder;
+	bool born;
 
+	lockdep_assert_held(&bdev->bd_holder_lock);
+	/* Make sure sb doesn't go away from under us */
+	spin_lock(&sb_lock);
+	sb->s_count++;
+	spin_unlock(&sb_lock);
+	mutex_unlock(&bdev->bd_holder_lock);
+
+	born = super_lock_shared(sb);
 	if (!born || !sb->s_root || !(sb->s_flags & SB_ACTIVE)) {
 		super_unlock_shared(sb);
-		return false;
+		put_super(sb);
+		return NULL;
 	}
-	return true;
+	/*
+	 * The superblock is active and we hold s_umount, we can drop our
+	 * temporary reference now.
+	 */
+	put_super(sb);
+	return sb;
 }
 
 static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
-	struct super_block *sb = bdev->bd_holder;
-
-	/* bd_holder_lock ensures that the sb isn't freed */
-	lockdep_assert_held(&bdev->bd_holder_lock);
+	struct super_block *sb;
 
-	if (!super_lock_shared_active(sb))
+	sb = bdev_super_lock_shared(bdev);
+	if (!sb)
 		return;
 
 	if (!surprise)
@@ -1459,11 +1472,10 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 
 static void fs_bdev_sync(struct block_device *bdev)
 {
-	struct super_block *sb = bdev->bd_holder;
-
-	lockdep_assert_held(&bdev->bd_holder_lock);
+	struct super_block *sb;
 
-	if (!super_lock_shared_active(sb))
+	sb = bdev_super_lock_shared(bdev);
+	if (!sb)
 		return;
 	sync_filesystem(sb);
 	super_unlock_shared(sb);
-- 
2.35.3


