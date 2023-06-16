Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2473363F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbjFPQii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFPQih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:38:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A11707
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:38:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97BF71F8BB;
        Fri, 16 Jun 2023 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686933513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sFHlWeP7zSne26zy71O9brQu5PKEaTrglF/shEQ5yLs=;
        b=ugRDgvYYM/mosABjA9YyXCavVb3BBlBOqvmARKFM7/HyofFUaHf6Kp/r+SdVxNNH/ERx/W
        oS8jFU1dFl29zDeM1B2J55auzBhAXowD4hTcAhZ0SGGH0mVQud1Bn6i71g+gewUcXncPh3
        8G0yL7Jsy6H9fPLnxphck7/FG8YMzBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686933513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sFHlWeP7zSne26zy71O9brQu5PKEaTrglF/shEQ5yLs=;
        b=Vc/vWNroQJveDdOjw8PlJw9mdIACyBfIsiyhRHWBvxYnz+bdePbNiQtJ2wGTDA8ztvN2WJ
        mSZ36t0rkISIEqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83D0E1330B;
        Fri, 16 Jun 2023 16:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RCEnIAmQjGRgHgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:38:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 017A1A0755; Fri, 16 Jun 2023 18:38:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Provide helpers for manipulating sb->s_readonly_remount
Date:   Fri, 16 Jun 2023 18:38:27 +0200
Message-Id: <20230616163827.19377-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4696; i=jack@suse.cz; h=from:subject; bh=ok7sIOaGh5aAtMv2lHvAGOUOrpmaJIJ213UFBZypo9g=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjI/xbctl8RLGcpUTbt6tGDfy8tjzQ9KatE2CJUqC +9muCjGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyP8QAKCRCcnaoHP2RA2eBaB/ 4+mxGMoIkXao4GuriWKvkM8hKknuTfBU3XtJHuMkSSJduHfHpFF1Z16/k+G5H3JaA7TTPxsKJnjABa Td4/vDNM8qTtjvHUeqASCn/SGPMLegwK5Cr7jdLCGzefOLFmD17t4D2mexbN+TpbcCgpRxtPSSBw8g e1yYqqc/1eNI7YZ+/oUYss753EpGeNrMkMD+oBo1VReosDJ+IkYJad2xHwVW7TD9MgISg5FjzsP4z+ p3r5eDfneh+fKQGnpJypDjSyO+37FGu/2f6v8dnxdEnzk4tXqDhCyqv7rGhQuCqE2NgrAt+cXexSpv eAsvSXcaa+Fu51otWKojudTGxNe8FL
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide helpers to set and clear sb->s_readonly_remount including
appropriate memory barriers. Also use this opportunity to document what
the barriers pair with and why they are needed.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/internal.h      | 26 ++++++++++++++++++++++++++
 fs/namespace.c     | 10 ++++------
 fs/super.c         | 17 ++++++-----------
 include/linux/fs.h |  2 +-
 4 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..01bff3f6db79 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -120,6 +120,32 @@ void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
 int sb_init_dio_done_wq(struct super_block *sb);
 
+/*
+ * Prepare superblock for changing its read-only state (i.e., either remount
+ * read-write superblock read-only or vice versa). After this function returns
+ * mnt_is_readonly() will return true for any mount of the superblock if its
+ * caller is able to observe any changes done by the remount. This holds until
+ * sb_end_ro_state_change() is called.
+ */
+static inline void sb_start_ro_state_change(struct super_block *sb)
+{
+	WRITE_ONCE(sb->s_readonly_remount, 1);
+	/* The barrier pairs with the barrier in mnt_is_readonly() */
+	smp_wmb();
+}
+
+/*
+ * Ends section changing read-only state of the superblock. After this function
+ * returns if mnt_is_readonly() returns false, the caller will be able to
+ * observe all the changes remount did to the superblock.
+ */
+static inline void sb_end_ro_state_change(struct super_block *sb)
+{
+	/* The barrier pairs with the barrier in mnt_is_readonly() */
+	smp_wmb();
+	WRITE_ONCE(sb->s_readonly_remount, 0);
+}
+
 /*
  * open.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..2eff091df549 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -309,9 +309,9 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 
 static int mnt_is_readonly(struct vfsmount *mnt)
 {
-	if (mnt->mnt_sb->s_readonly_remount)
+	if (READ_ONCE(mnt->mnt_sb->s_readonly_remount))
 		return 1;
-	/* Order wrt setting s_flags/s_readonly_remount in do_remount() */
+	/* Order wrt barriers in sb_{start,end}_ro_state_change() */
 	smp_rmb();
 	return __mnt_is_readonly(mnt);
 }
@@ -588,10 +588,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (!err && atomic_long_read(&sb->s_remove_count))
 		err = -EBUSY;
 
-	if (!err) {
-		sb->s_readonly_remount = 1;
-		smp_wmb();
-	}
+	if (!err)
+		sb_start_ro_state_change(sb);
 	list_for_each_entry(mnt, &sb->s_mounts, mnt_instance) {
 		if (mnt->mnt.mnt_flags & MNT_WRITE_HOLD)
 			mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
diff --git a/fs/super.c b/fs/super.c
index 6cd64961aa07..8a39902b859f 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -944,8 +944,7 @@ int reconfigure_super(struct fs_context *fc)
 	 */
 	if (remount_ro) {
 		if (force) {
-			sb->s_readonly_remount = 1;
-			smp_wmb();
+			sb_start_ro_state_change(sb);
 		} else {
 			retval = sb_prepare_remount_readonly(sb);
 			if (retval)
@@ -953,12 +952,10 @@ int reconfigure_super(struct fs_context *fc)
 		}
 	} else if (remount_rw) {
 		/*
-		 * We set s_readonly_remount here to protect filesystem's
-		 * reconfigure code from writes from userspace until
-		 * reconfigure finishes.
+		 * Protect filesystem's reconfigure code from writes from
+		 * userspace until reconfigure finishes.
 		 */
-		sb->s_readonly_remount = 1;
-		smp_wmb();
+		sb_start_ro_state_change(sb);
 	}
 
 	if (fc->ops->reconfigure) {
@@ -974,9 +971,7 @@ int reconfigure_super(struct fs_context *fc)
 
 	WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
 				 (fc->sb_flags & fc->sb_flags_mask)));
-	/* Needs to be ordered wrt mnt_is_readonly() */
-	smp_wmb();
-	sb->s_readonly_remount = 0;
+	sb_end_ro_state_change(sb);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -991,7 +986,7 @@ int reconfigure_super(struct fs_context *fc)
 	return 0;
 
 cancel_readonly:
-	sb->s_readonly_remount = 0;
+	sb_end_ro_state_change(sb);
 	return retval;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..ede51d60d124 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1242,7 +1242,7 @@ struct super_block {
 	 */
 	atomic_long_t s_fsnotify_connectors;
 
-	/* Being remounted read-only */
+	/* Read-only state of the superblock is being changed */
 	int s_readonly_remount;
 
 	/* per-sb errseq_t for reporting writeback errors via syncfs */
-- 
2.35.3

