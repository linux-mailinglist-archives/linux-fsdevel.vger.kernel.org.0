Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB63C8B38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhGNSu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240080AbhGNSu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:28 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B33C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m68so2620307qke.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcIKkUHDUMaUNxFd2j3gUaKSKz8MliVlhmquY+JHLoY=;
        b=lQj78Zf63qxlNkMkUh3NAtWpK7o0ZfxSoZfNSFGJUgDawTJjppaWcxmmyLXq23b5Uw
         czSlmrehECOrHHSdBE8SNl1uIx9aRxGTrCbILoowHC3JNLel5tD+p3Td+fnJRNmY8c5A
         AyS1fb7gZ+IdckWjijLg8RwP5MEVKNsKNufEkiMT9yvE2WqW/AnryiOHTNgqMtf9hLxZ
         9XQ9Ux+QbUqdWvNjguPhpTKMCa79qHl425VWdl2F1sTSSknoe1HNYRn2XAv8mSx9FQjQ
         v12elPGGDVf9AbWfd5IX3KI+4RCHQoSaGCPEfyT591+k1tuVv0bU0QQ7N3KD9CGqb2l0
         bKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcIKkUHDUMaUNxFd2j3gUaKSKz8MliVlhmquY+JHLoY=;
        b=bAZPO0b2/s55xrxX9O5kQ5EwDoWb7hnIbbgOb3HW0bONhNG+SW3KjNDMnJyvaF8R5l
         4Y1bi0+Z1VoIsuI5yhKuIQBawuTVBBp9i0tYr2dAiJ/bfpkZI0G2xilNUnn1gFmM+izr
         YXy0TOavhsPfRZTee6FOMEk5EZcjTKgJSDnJg5hR9Z6tobYeaafSa/GL3ZPm7KVJ4NNj
         Qy1AV654+iWI5jcatgPv/9ipinTwiGBHUJAD4lRk9VelBNMj66VCnOIKwtC1DP+CmBwt
         JscgjxzlTU/dbLvY5hW2MKyoiyBhGhjkcsz7PqJR4bmX3dHDsyyqctB/CoGv7fDORFP4
         K+SA==
X-Gm-Message-State: AOAM530yH3Q83tsBsvusBxCPuH++iuySvpHnf3N06X3ceDISSu7iBPps
        +RZotrRIfWodDep55fcfBaTOZQ==
X-Google-Smtp-Source: ABdhPJwrcsMqMo+umcx1D8jfi9BI/Qh+9Dq9C68/MCcJnUujU3NVfdVQ034Vod6IszzfoHml9tPZzA==
X-Received: by 2002:a37:847:: with SMTP id 68mr11453978qki.112.1626288455720;
        Wed, 14 Jul 2021 11:47:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d2sm1067358qto.91.2021.07.14.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 6/9] fs: add a filemap_fdatawrite_wbc helper
Date:   Wed, 14 Jul 2021 14:47:22 -0400
Message-Id: <1a353b1b013f616c2798526a8d21bb0cd609c25f.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

