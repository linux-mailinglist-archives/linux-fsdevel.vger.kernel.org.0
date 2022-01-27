Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB83349D84B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiA0CsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:48:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55164 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiA0CsL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:48:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B0A521959;
        Thu, 27 Jan 2022 02:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643251689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLryoRKmUuPESAB8QyVLfrgvCJTCmPKkdu4P/OX5YBg=;
        b=Qti4P3eej7SwU9djhiMhUMgJ1ckOKm8O/J1pSaUAEHDRhQb1izQ4dQZrO97++mAvn3WVVr
        T2k2nCp5oMqLD8x4f8vee6NJClS2lg1UPexxPkHMg0zJIBN6c452+a+u50wURMgo/tIfRv
        rD3QIr1LCF3psUh7SWng5ZjcDzYoDdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643251689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VLryoRKmUuPESAB8QyVLfrgvCJTCmPKkdu4P/OX5YBg=;
        b=uJ63TZZVZJQxUDYCfYcbm2ZGgBe9Q6Vwcu+8BWf/uQNpUEqXNKCc6PHt7MlRhE+A1sBtn6
        UgWYWcQsDNRd9WCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9B1C13E46;
        Thu, 27 Jan 2022 02:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8ZsrKd4H8mH6KwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 02:47:58 +0000
Subject: [PATCH 4/9] f2f2: replace some congestion_wait() calls with
 io_schedule_timeout()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
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
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Thu, 27 Jan 2022 13:46:29 +1100
Message-ID: <164325158957.29787.2116312603613564596.stgit@noble.brown>
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As congestion is no longer tracked, contestion_wait() is effectively
equivalent to io_schedule_timeout().
It isn't clear to me what these contestion_wait() calls are waiting
for, so I cannot change them to wait for some particular event.
So simply change them to io_schedule_timeout(), which will have
exactly the same behaviour.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/f2fs/segment.c |   14 ++++++++------
 fs/f2fs/super.c   |    8 ++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1dabc8244083..78e3fbc24e77 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -313,8 +313,8 @@ void f2fs_drop_inmem_pages_all(struct f2fs_sb_info *sbi, bool gc_failure)
 skip:
 		iput(inode);
 	}
-	congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
-	cond_resched();
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	if (gc_failure) {
 		if (++looped >= count)
 			return;
@@ -802,9 +802,10 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 
 		do {
 			ret = __submit_flush_wait(sbi, FDEV(i).bdev);
-			if (ret)
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+			if (ret) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+			}
 		} while (ret && --count);
 
 		if (ret) {
@@ -3133,7 +3134,8 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 			goto next;
 		}
 skip:
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 76e6a3df9aba..ae8dcbb71596 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2135,8 +2135,8 @@ static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	/* we should flush all the data to keep data consistency */
 	do {
 		sync_inodes_sb(sbi->sb);
-		cond_resched();
-		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
 
 	if (unlikely(retry < 0))
@@ -2504,8 +2504,8 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 							&page, &fsdata);
 		if (unlikely(err)) {
 			if (err == -ENOMEM) {
-				congestion_wait(BLK_RW_ASYNC,
-						DEFAULT_IO_TIMEOUT);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				io_schedule_timeout(DEFAULT_IO_TIMEOUT);
 				goto retry;
 			}
 			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);


