Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E943B73AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbhF2OCF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbhF2OCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:02:03 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A40C061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:35 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d5so16169233qtd.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2uFn6PKotRyoL/EKvc9hZ16Pkk9IJiulS9AMGBGQqf0=;
        b=La0ktyq8ut/I4zTJmlU9AODAv7RgJ+QBSGCq1XtTKYB4oYTFM8iYSQm38B04EKyqV+
         +U1bDk4OJO05Ix6tYjUKlKMBG5PjEYxi20Ol0yBWp91kbjU7KZjlrQX7J6ETDHNY8y3K
         JGvSuLiWmdC7IlhdeLryxSKrYIz9eYP+j+HgvyK0q99g6/0L2smkn/nsjwtkyBJ87bVe
         Rsjq/hDMViMdV9FIgfAX02Z053RhLvLl/PogVK9TdnSJkkjNpjm9IaTQT6abfErFe1DA
         5gFhqKcmMjMYfVV4+YsVKtYfLvrvYubEDAXQps4SiPrjI96S6yIYUAfZVxUcdjpNhw+m
         k6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uFn6PKotRyoL/EKvc9hZ16Pkk9IJiulS9AMGBGQqf0=;
        b=NfzOgzV6RcsbiIsdDDHEQmZAgoKslGmsxt3yLJ3QHfpkZZkFz6XJoqo7AyTNsJGgWf
         kMUqdiTxhBvL3Dk9ZObAuXVLsMUwzb6qaBzn3as7o6TyVu4BMVNq1ixj5o9jbc8XHxM0
         BnpT1/Dd86fUQxwIWYgQNd8cwWyje9xpyGrRAFKAN1I7OQmgulSz5uSNsRVxJa5KSkZb
         jY/MF4QUL2sYjPey1C00I0qDaBnEUnAMDfAcuduKf/XTgryiBKOl62UoPCtbYCibz6X0
         mAHirJTNA2sPe69CoBKUg51/4C++1zM86u5SdVIItWUNjJ+HYeR4isTXpScUbJx4gYRx
         TwLQ==
X-Gm-Message-State: AOAM5307/CHzE8Y+c9+spos6k+NignymVhklseQ3QFVxsWueaL0fpqXv
        VRVTSVJ3TBW+oUbQP3F7L6XY9A==
X-Google-Smtp-Source: ABdhPJzB3kjb1w+C0PCwYbRhbV1AeLxzp1l6rfNcvXs+p7qC+IhH8whbCnC5xwrtqTQwn5QzB3Kr4A==
X-Received: by 2002:ac8:7dc9:: with SMTP id c9mr26612481qte.169.1624975174387;
        Tue, 29 Jun 2021 06:59:34 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y7sm12201170qkp.103.2021.06.29.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/8] fs: add a filemap_fdatawrite_wbc helper
Date:   Tue, 29 Jun 2021 09:59:21 -0400
Message-Id: <b57a146e13e5e08ecffce68fa8a71cf1e36081c8.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Btrfs sometimes needs to flush dirty pages on a bunch of dirty inodes in
order to reclaim metadata reservations.  Unfortunately most helpers in
this area are too smart for us

1) The normal filemap_fdata* helpers only take range and sync modes, and
   don't give any indication of how much was written, so we can only
   flush full inodes, which isn't what we want in most cases.
2) The normal writeback path requires us to have the s_umount sem held,
   but we can't unconditionally take it in this path because we could
   deadlock.
3) The normal writeback path also skips inodes with I_SYNC set if we
   write with WB_SYNC_NONE.  This isn't the behavior we want under heavy
   ENOSPC pressure, we want to actually make sure the pages are under
   writeback before returning, and if another thread is in the middle of
   writing the file we may return before they're under writeback and
   miss our ordered extents and not properly wait for completion.
4) sync_inode() uses the normal writeback path and has the same problem
   as #3.

What we really want is to call do_writepages() with our wbc.  This way
we can make sure that writeback is actually started on the pages, and we
can control how many pages are written as a whole as we write many
inodes using the same wbc.  Accomplish this with a new helper that does
just that so we can use it for our ENOSPC flushing infrastructure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 35 ++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..aace07f88b73 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2886,6 +2886,8 @@ extern int filemap_fdatawrite_range(struct address_space *mapping,
 				loff_t start, loff_t end);
 extern int filemap_check_errors(struct address_space *mapping);
 extern void __filemap_set_wb_err(struct address_space *mapping, int err);
+extern int filemap_fdatawrite_wbc(struct address_space *mapping,
+				  struct writeback_control *wbc);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 66f7e9fdfbc4..8395eafc178b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -376,6 +376,31 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
 		return -ENOSPC;
 	return 0;
 }
+/**
+ * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in range
+ * @mapping:	address space structure to write
+ * @wbc:	the writeback_control controlling the writeout
+ *
+ * Call writepages on the mapping using the provided wbc to control the
+ * writeout.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_wbc(struct address_space *mapping,
+			   struct writeback_control *wbc)
+{
+	int ret;
+
+	if (!mapping_can_writeback(mapping) ||
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		return 0;
+
+	wbc_attach_fdatawrite_inode(wbc, mapping->host);
+	ret = do_writepages(mapping, wbc);
+	wbc_detach_inode(wbc);
+	return ret;
+}
+EXPORT_SYMBOL(filemap_fdatawrite_wbc);
 
 /**
  * __filemap_fdatawrite_range - start writeback on mapping dirty pages in range
@@ -397,7 +422,6 @@ static int filemap_check_and_keep_errors(struct address_space *mapping)
 int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 				loff_t end, int sync_mode)
 {
-	int ret;
 	struct writeback_control wbc = {
 		.sync_mode = sync_mode,
 		.nr_to_write = LONG_MAX,
@@ -405,14 +429,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 		.range_end = end,
 	};
 
-	if (!mapping_can_writeback(mapping) ||
-	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
-		return 0;
-
-	wbc_attach_fdatawrite_inode(&wbc, mapping->host);
-	ret = do_writepages(mapping, &wbc);
-	wbc_detach_inode(&wbc);
-	return ret;
+	return filemap_fdatawrite_wbc(mapping, &wbc);
 }
 
 static inline int __filemap_fdatawrite(struct address_space *mapping,
-- 
2.26.3

