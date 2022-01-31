Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C844A3CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 05:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357519AbiAaEEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jan 2022 23:04:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357527AbiAaEEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:04:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C13B210FE;
        Mon, 31 Jan 2022 04:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643601853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT52NhE/N7PVVSZ6niTpMaHbrmZWUrKq22PpJBM3oqQ=;
        b=SCTOYzJUJN9O7QnOxKZ/Hi1cy4glOFhzJ2+sxy5rYG43SrFy4kOWOOW6A5ANReXHSFW9lB
        l4VwBe9DUkx2KW7tzJldcy4BUUM6XZoqdZD21f/+AYSunBr0wxsKBDOhXs9zkqbgNjltOA
        X67a1H8OXXNO8sCsiMnkaSNMd6YAKuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643601853;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT52NhE/N7PVVSZ6niTpMaHbrmZWUrKq22PpJBM3oqQ=;
        b=u4JbDZRGbh+eNpjziK1mfGZwOXLgnKGchPs09Z0oJFEBr0i6U9x8OjPFefWK09ydRV/lfn
        AApIc6nFozIMCTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CC143133A4;
        Mon, 31 Jan 2022 04:04:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XdgIblf92GTCQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jan 2022 04:04:09 +0000
Subject: [PATCH 1/3] fuse: remove reliance on bdi congestion
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:03:53 +1100
Message-ID: <164360183348.4233.761031466326833349.stgit@noble.brown>
In-Reply-To: <164360127045.4233.2606812444285122570.stgit@noble.brown>
References: <164360127045.4233.2606812444285122570.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 - .readahead to do nothing if the flag would be set
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
 fs/fuse/dax.c     |    3 +++
 fs/fuse/dev.c     |    8 --------
 fs/fuse/file.c    |   11 +++++++++++
 4 files changed, 14 insertions(+), 25 deletions(-)

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
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 182b24a14804..5f74e2585f50 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -781,6 +781,9 @@ static int fuse_dax_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return 0;
 	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);
 }
 
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
index 829094451774..b22a948be422 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -958,6 +958,8 @@ static void fuse_readahead(struct readahead_control *rac)
 
 	if (fuse_is_bad(inode))
 		return;
+	if (fc->num_background >= fc->congestion_threshold)
+		return;
 
 	max_pages = min_t(unsigned int, fc->max_pages,
 			fc->max_read / PAGE_SIZE);
@@ -1958,6 +1960,7 @@ static int fuse_writepage_locked(struct page *page)
 
 static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct fuse_conn *fc = get_fuse_conn(page->mapping->host);
 	int err;
 
 	if (fuse_page_is_writeback(page->mapping->host, page->index)) {
@@ -1973,6 +1976,10 @@ static int fuse_writepage(struct page *page, struct writeback_control *wbc)
 		return 0;
 	}
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	err = fuse_writepage_locked(page);
 	unlock_page(page);
 
@@ -2226,6 +2233,10 @@ static int fuse_writepages(struct address_space *mapping,
 	if (fuse_is_bad(inode))
 		goto out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+	    fc->num_background >= fc->congestion_threshold)
+		return AOP_WRITEPAGE_ACTIVATE;
+
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;


