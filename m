Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D664BF09E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiBVDUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:20:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbiBVDUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:20:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3538240B7;
        Mon, 21 Feb 2022 19:20:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A77DF210E6;
        Tue, 22 Feb 2022 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645500006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxH/65m79qvzBGSCwVr/N2GJs7ZD/rte4Udz5IqpfIY=;
        b=1izYW0top9BS+iGfXZVpKBuJ+MwMK08zsbUAzadqpGOGRwgyzsXY0KDfKzHJtGimNVXYoj
        YhuEAPMn4VxOA/kBjGsoV5UTt9YspUnvu+gax168HsZudoD00qGGBJyvTZw7EGhrd1u24P
        ZQ+YUljewjlzwFNP28OSuOKUhNTgyTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645500006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxH/65m79qvzBGSCwVr/N2GJs7ZD/rte4Udz5IqpfIY=;
        b=aZJVVnALmXFu3ExBGTckF/YwvXjWy9CmPulvw2T47YMa7c6/yeRvxkKpZ8N0EufKCpXPz9
        J/yg0Bxc1k1hRJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B32713BA7;
        Tue, 22 Feb 2022 03:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eOF7CFpWFGISWwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 03:19:54 +0000
Subject: [PATCH 09/11] f2fs: replace congestion_wait() calls with
 io_schedule_timeout()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Feb 2022 14:17:17 +1100
Message-ID: <164549983744.9187.6425865370954230902.stgit@noble.brown>
In-Reply-To: <164549971112.9187.16871723439770288255.stgit@noble.brown>
References: <164549971112.9187.16871723439770288255.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As congestion is no longer tracked, congestion_wait() is effectively
equivalent to io_schedule_timeout().
So introduce f2fs_io_schedule_timeout() which sets TASK_UNINTERRUPTIBLE
and call that instead.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/f2fs/compress.c |    4 +---
 fs/f2fs/data.c     |    3 +--
 fs/f2fs/f2fs.h     |    6 ++++++
 fs/f2fs/segment.c  |    8 +++-----
 fs/f2fs/super.c    |    6 ++----
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index d0c3aeba5945..2f95559025ad 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1505,9 +1505,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				if (IS_NOQUOTA(cc->inode))
 					return 0;
 				ret = 0;
-				cond_resched();
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry_write;
 			}
 			return ret;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c417864c66a..d428ddfd42ee 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3047,8 +3047,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				} else if (ret == -EAGAIN) {
 					ret = 0;
 					if (wbc->sync_mode == WB_SYNC_ALL) {
-						cond_resched();
-						congestion_wait(BLK_RW_ASYNC,
+						f2fs_io_schedule_timeout(
 							DEFAULT_IO_TIMEOUT);
 						goto retry_write;
 					}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 68b44015514f..467f5dbdc7d1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4426,6 +4426,12 @@ static inline bool f2fs_block_unit_discard(struct f2fs_sb_info *sbi)
 	return F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_BLOCK;
 }
 
+static inline void f2fs_io_schedule_timeout(long timeout)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	io_schedule_timeout(timeout);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1dabc8244083..6ff20da44ad7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -313,8 +313,7 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 skip:
 		iput(inode);
 	}
-	congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
-	cond_resched();
+	f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	if (gc_failure) {
 		if (++looped >= count)
 			return;
@@ -803,8 +802,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 		do {
 			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
 			if (ret)
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 		} while (ret && --count);
 
 		if (ret) {
@@ -3133,7 +3131,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+			f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 			goto next;
 		}
 skip:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index baefd398ec1a..ebd32daf052c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2135,8 +2135,7 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* we should flush all the data to keep data consistency */
 	do {
 		sync_inodes_sb(sbi->sb);
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+		f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
 
 	if (unlikely(retry < 0))
@@ -2504,8 +2503,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);


