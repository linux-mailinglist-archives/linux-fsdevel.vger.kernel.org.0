Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C27710E17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 16:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbjEYORT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEYORS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 10:17:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A8189
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 07:17:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E13E71FE66;
        Thu, 25 May 2023 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685024235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X6Dj5SbnioRpzQa86EakUDpSW1KTxgyl2UXowSV3mqg=;
        b=TebKdMP2Ib/nJXWTE6JHs5tIGWhS3YhKdJQQaJpybfjieICjdwdiPRGqiW2xf0dOf/9eFH
        2t3HTkgBoxHMQkjNPYz2JgvfaQ3ikrouPPvXooNn9ruaq/4zJzMhYYDmDNaTpvzqWGfjfb
        krWHc/ZozIcRwiBE+inX3IFsS8LCp/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685024235;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X6Dj5SbnioRpzQa86EakUDpSW1KTxgyl2UXowSV3mqg=;
        b=QH3a2RjOVLsxyoN3Y1Q60EsRJc6vvuCFIXuPhzTbyD4QjS3aD7/rehbsqpiOTVYRFjVvch
        HExRuF0gslOFFkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF7AA134B2;
        Thu, 25 May 2023 14:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7wqZMuttb2QTaAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 May 2023 14:17:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2B02DA075C; Thu, 25 May 2023 16:17:15 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Drop wait_unfrozen wait queue
Date:   Thu, 25 May 2023 16:17:10 +0200
Message-Id: <20230525141710.7595-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=jack@suse.cz; h=from:subject; bh=/AQOGNkCHvftqXw/Vfi9QbKMJfxbiMS1L+K6x7okguU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkb23geVozHyQR0Sc2HNg94/LEyCK8HaYtyQo7g5B2 /AABGSOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZG9t4AAKCRCcnaoHP2RA2dsJB/ 9/hpYM2pcYuAvK5dlWXtS2/nyviPfFbsMMDlBbe4WmjSqJk8ZUzztdf68wbQCQvWfWwg1J0HT1F+2w ckbkpm/508OdB9OOs5J2vxaWQoB4LOLO9oFcnqDHE2d+giUAE7V/k6juOCr3HDitnvRPkpkwgQtsiJ 4HUrQbTdIhUbCeJnH5wNJKSdhe8O0+v7SsyLI2B5WuojKaHjpo49ft3jIvHBo283DhWrA3jdZ+QbZD Wm+cbLQISwt1r7f74QlFxAfmqxgBT4ldqh7soM8iMAmWINR6kbWY6NIjUv65lXFvxZbaV/qm8uujY8 et387+riiDGQx+BtE+9NPG2E3xfKYf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wait_unfrozen waitqueue is used only in quota code to wait for
filesystem to become unfrozen. In that place we can just use
sb_start_write() - sb_end_write() pair to achieve the same. So just
remove the waitqueue.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota.c   | 5 +++--
 fs/super.c         | 4 ----
 include/linux/fs.h | 1 -
 3 files changed, 3 insertions(+), 7 deletions(-)

Guys, I can merge this cleanup through my tree since I don't expect any
conflicts and the generic part is pure removal of unused code.

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 052f143e2e0e..0e41fb84060f 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -895,8 +895,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 			up_write(&sb->s_umount);
 		else
 			up_read(&sb->s_umount);
-		wait_event(sb->s_writers.wait_unfrozen,
-			   sb->s_writers.frozen == SB_UNFROZEN);
+		/* Wait for sb to unfreeze */
+		sb_start_write(sb);
+		sb_end_write(sb);
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/super.c b/fs/super.c
index 34afe411cf2b..6283cea67280 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -236,7 +236,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 					&type->s_writers_key[i]))
 			goto fail;
 	}
-	init_waitqueue_head(&s->s_writers.wait_unfrozen);
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
@@ -1706,7 +1705,6 @@ int freeze_super(struct super_block *sb)
 	if (ret) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb_freeze_unlock(sb, SB_FREEZE_PAGEFAULT);
-		wake_up(&sb->s_writers.wait_unfrozen);
 		deactivate_locked_super(sb);
 		return ret;
 	}
@@ -1722,7 +1720,6 @@ int freeze_super(struct super_block *sb)
 				"VFS:Filesystem freeze failed\n");
 			sb->s_writers.frozen = SB_UNFROZEN;
 			sb_freeze_unlock(sb, SB_FREEZE_FS);
-			wake_up(&sb->s_writers.wait_unfrozen);
 			deactivate_locked_super(sb);
 			return ret;
 		}
@@ -1768,7 +1765,6 @@ static int thaw_super_locked(struct super_block *sb)
 	sb->s_writers.frozen = SB_UNFROZEN;
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
 out:
-	wake_up(&sb->s_writers.wait_unfrozen);
 	deactivate_locked_super(sb);
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..3b65a6194485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1146,7 +1146,6 @@ enum {
 
 struct sb_writers {
 	int				frozen;		/* Is sb frozen? */
-	wait_queue_head_t		wait_unfrozen;	/* wait for thaw */
 	struct percpu_rw_semaphore	rw_sem[SB_FREEZE_LEVELS];
 };
 
-- 
2.35.3

