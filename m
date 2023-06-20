Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CB736AEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 13:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjFTL2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFTL2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:28:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37A130
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 04:28:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E27041F37E;
        Tue, 20 Jun 2023 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687260521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pSAQRNGlw7wnnNLtODSuXEr+DaFfQ/773ZR0Hgfyj6M=;
        b=BFIs3HwU+E0VblejSg8uofyZ+jKr1V3SETdu5TCXElNGBBDE2ui1oIIEj1+yAsAZytRA1a
        EC2LQimuFV0ELq/r2lvPOSkm8JLA85IGvJ4bypNuesjXECilt6ax3Z2gENv9dn7Nm/mHDK
        EagCpbJ96fy8ojl7zYEcxxPJcqoiVhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687260521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pSAQRNGlw7wnnNLtODSuXEr+DaFfQ/773ZR0Hgfyj6M=;
        b=cb2ovI4tLnB8jNbgZMqidPOFttRUKCFEIfEd0C5RvyVsJVRasxgwqVH3YlV1j6c9oGhVIS
        V6DtgQC/ocVeMFBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF5B2133A9;
        Tue, 20 Jun 2023 11:28:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q0eQMmmNkWSreQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 20 Jun 2023 11:28:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67708A075D; Tue, 20 Jun 2023 13:28:41 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v3] fs: Provide helpers for manipulating sb->s_readonly_remount
Date:   Tue, 20 Jun 2023 13:28:32 +0200
Message-Id: <20230620112832.5158-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6369; i=jack@suse.cz; h=from:subject; bh=LCHbdopSvVSmU8Jmd8eKqVrMFPpF5QXkJgPYCj14YcM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkkY1PyliuAf7t3Q66YdlO5Bf5CC8jCzwumSxTsx+s uCshoMKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZJGNTwAKCRCcnaoHP2RA2QstB/ 0fcn9oIRQcZqZMRpdl17cxve9AgoajUat5RWpgt6Vk3Pu4KE8r3PhKPdvSvtfHcbSLBHPTLRFyaqI6 JdykCXneqsbzSFjpLEFz7WwoAQfxOsdK6Qw3k+wPqHItlMnGER2amLFKi12JDK00O1Yq+hvOf4x4qd 34/gYsGHFK47pe0DSfGXaVggFF73o0lGHL0bkpkJENsoYtxKW3ZKoEwWtcxP1iIG1/pPjSbmwuM2ng J/tqq1iXUTGqSBQtsKIpWTyMEIsvTy70UC1/pQCvWGntrfMftTX5V2TeY+OfnhqL8XblmPl9wCxtFE td7FK9ca+MG8SC55txXY3SeV/T9Rir
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
 fs/internal.h      | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c     | 25 ++++++++++++++++---------
 fs/super.c         | 17 ++++++-----------
 include/linux/fs.h |  2 +-
 4 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..b916b84809f3 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -120,6 +120,47 @@ void put_super(struct super_block *sb);
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
+	/*
+	 * For RO->RW transition, the barrier pairs with the barrier in
+	 * mnt_is_readonly() making sure if mnt_is_readonly() sees SB_RDONLY
+	 * cleared, it will see s_readonly_remount set.
+	 * For RW->RO transition, the barrier pairs with the barrier in
+	 * __mnt_want_write() before the mnt_is_readonly() check. The barrier
+	 * makes sure if __mnt_want_write() sees MNT_WRITE_HOLD already
+	 * cleared, it will see s_readonly_remount set.
+	 */
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
+	/*
+	 * This barrier provides release semantics that pairs with
+	 * the smp_rmb() acquire semantics in mnt_is_readonly().
+	 * This barrier pair ensure that when mnt_is_readonly() sees
+	 * 0 for sb->s_readonly_remount, it will also see all the
+	 * preceding flag changes that were made during the RO state
+	 * change.
+	 */
+	smp_wmb();
+	WRITE_ONCE(sb->s_readonly_remount, 0);
+}
+
 /*
  * open.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 54847db5b819..5ba1eca6f720 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -309,9 +309,16 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 
 static int mnt_is_readonly(struct vfsmount *mnt)
 {
-	if (mnt->mnt_sb->s_readonly_remount)
+	if (READ_ONCE(mnt->mnt_sb->s_readonly_remount))
 		return 1;
-	/* Order wrt setting s_flags/s_readonly_remount in do_remount() */
+	/*
+	 * The barrier pairs with the barrier in sb_start_ro_state_change()
+	 * making sure if we don't see s_readonly_remount set yet, we also will
+	 * not see any superblock / mount flag changes done by remount.
+	 * It also pairs with the barrier in sb_end_ro_state_change()
+	 * assuring that if we see s_readonly_remount already cleared, we will
+	 * see the values of superblock / mount flags updated by remount.
+	 */
 	smp_rmb();
 	return __mnt_is_readonly(mnt);
 }
@@ -364,9 +371,11 @@ int __mnt_want_write(struct vfsmount *m)
 		}
 	}
 	/*
-	 * After the slowpath clears MNT_WRITE_HOLD, mnt_is_readonly will
-	 * be set to match its requirements. So we must not load that until
-	 * MNT_WRITE_HOLD is cleared.
+	 * The barrier pairs with the barrier sb_start_ro_state_change() making
+	 * sure that if we see MNT_WRITE_HOLD cleared, we will also see
+	 * s_readonly_remount set (or even SB_RDONLY / MNT_READONLY flags) in
+	 * mnt_is_readonly() and bail in case we are racing with remount
+	 * read-only.
 	 */
 	smp_rmb();
 	if (mnt_is_readonly(m)) {
@@ -588,10 +597,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
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

