Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867EB4BF03B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiBVDTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:19:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiBVDTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:19:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1552F73;
        Mon, 21 Feb 2022 19:18:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 562ED1F396;
        Tue, 22 Feb 2022 03:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645499927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2iKmKfQAV47ltxyUTpJL5kF151jPpkpJZBMxZj0hPA=;
        b=0+g51AMGEI3r9A8ASMpz3wY3CyKSJDeDWn0AKqsQTwh9NMem16Yu3oX327mnvhNj8U+DA9
        33oY/yjrsDIe2YUWn2bZG7jQOA+4FUB3X9JdnoOXaU38SgqeQ9WEuMqtv61aD05pH60kr9
        62rxLcOCo92AZ73iiwrb3gpP+RZqT9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645499927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2iKmKfQAV47ltxyUTpJL5kF151jPpkpJZBMxZj0hPA=;
        b=RQ5ZNUEdexnmqLSqD8rTQIgSPwQRUQeUCQajOzdhoZRnXzxb5C8Ud6kKPvOlourkGfZFR4
        QB7vKbrUxbKosNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A183013BA7;
        Tue, 22 Feb 2022 03:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pv19FwxWFGKWWgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 22 Feb 2022 03:18:36 +0000
Subject: [PATCH 04/11] fuse: remove reliance on bdi congestion
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
Message-ID: <164549983737.9187.2627117501000365074.stgit@noble.brown>
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

The bdi congestion tracking in not widely used and will be removed.

Fuse is one of a small number of filesystems that uses it, setting both
the sync (read) and async (write) congestion flags at what it determines
are appropriate times.

The only remaining effect of the sync flag is to cause read-ahead to be
skipped.
The only remaining effect of the async flag is to cause (some)
WB_SYNC_NONE writes to be skipped.

So instead of setting the flags, change:
 - .readahead to stop when it has submitted all non-async pages
    for read.
 - .writepages to do nothing if WB_SYNC_NONE and the flag would be set
 - .writepage to return AOP_WRITEPAGE_ACTIVATE if WB_SYNC_NONE
    and the flag would be set.

The writepages change causes a behavioural change in that pageout() can
now return PAGE_ACTIVATE instead of PAGE_KEEP, so SetPageActive() will
be called on the page which (I think) will further delay the next attempt
at writeout.  This might be a good thing.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/fuse/control.c |   17 -----------------
 fs/fuse/dev.c     |    8 --------
 fs/fuse/file.c    |   17 +++++++++++++++++
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 000d2e5627e9..7cede9a3bc96 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -164,7 +164,6 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 {
 	unsigned val;
 	struct fuse_conn *fc;
-	struct fuse_mount *fm;
 	ssize_t ret;
 
 	ret = fuse_conn_limit_write(file, buf, count, ppos, &val,
@@ -178,22 +177,6 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
 	down_read(&fc->killsb);
 	spin_lock(&fc->bg_lock);
 	fc->congestion_threshold = val;
-
-	/*
-	 * Get any fuse_mount belonging to this fuse_conn; s_bdi is
-	 * shared between all of them
-	 */
-
-	if (!list_empty(&fc->mounts)) {
-		fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
-		if (fc->num_background < fc->congestion_threshold) {
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		} else {
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
-	}
 	spin_unlock(&fc->bg_lock);
 	up_read(&fc->killsb);
 	fuse_conn_put(fc);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index cd54a529460d..e1b4a846c90d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -315,10 +315,6 @@ void fuse_request_end(struct fuse_req *req)
 				wake_up(&fc->blocked_waitq);
 		}
 
-		if (fc->num_background == fc->congestion_threshold && fm->sb) {
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			clear_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
 		fc->num_background--;
 		fc->active_background--;
 		flush_bg_queue(fc);
@@ -540,10 +536,6 @@ static bool fuse_request_queue_background(struct fuse_req *req)
 		fc->num_background++;
 		if (fc->num_background == fc->max_background)
 			fc->blocked = 1;
-		if (fc->num_background == fc->congestion_threshold && fm->sb) {
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_SYNC);
-			set_bdi_congested(fm->sb->s_bdi, BLK_RW_ASYNC);
-		}
 		list_add_tail(&req->list, &fc->bg_queue);
 		flush_bg_queue(fc);
 		queued = true;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 829094451774..94747bac3489 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -966,6 +966,14 @@ static void fuse_readahead(struct readahead_control *rac)
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
 
+		if (fc->num_background >= fc->congestion_threshold &&
+		    rac->ra->async_size >= readahead_count(rac))
+			/*
+			 * Congested and only async pages left, so skip the
+			 * rest.
+			 */
+			break;
+
 		nr_pages = readahead_count(rac) - nr_pages;
 		if (nr_pages > max_pages)
 			nr_pages = max_pages;
@@ -1958,6 +1966,7 @@ static int fuse_writepage_locked(struct page *page)
 
 static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct fuse_conn *fc = get_fuse_conn(page->mapping->host);
 	int err;
 
 	if (fuse_page_is_writeback(page->mapping->host, page->index)) {
@@ -1973,6 +1982,10 @@ static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 		return 0;
 	}
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	err = fuse_writepage_locked(page);
 	unlock_page(page);
 
@@ -2226,6 +2239,10 @@ static int fuse_writepages(struct address_space *mapping,
 	if (fuse_is_bad(inode))
 		goto out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return 0;
+
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;


