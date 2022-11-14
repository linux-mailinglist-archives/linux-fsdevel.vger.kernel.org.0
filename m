Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA696277AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiKNI3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 03:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiKNI3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:29:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82881B795
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 00:29:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3691846091fso98573727b3.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 00:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUgTTBqKFuYwrBAzZpO1jGOAUEqlfA9E0Rem6opsB3E=;
        b=BSUGObCx4CoBl4EPyv/sqdhaIx0lyPbCKwJGuN9W7g/1v2YFv9G3VeL8ZFtRN30qVI
         it7y8tFgQ5xe97AjVd7P6AdEMjrFOxTFtTqXdJDejlWuivHSS1Van0dRG83qcQsEBMIQ
         wDOrS1xRqt6t4fC6IUgF/YAiSLRza4BXSkTVHVf3Q9mp+TMdnYUVmajKeWGNJDCrY630
         G3xQ9DNy0yeZ2IW4yHhx/c+U0uyJ9ezELP1uY9T0vUL0hd0EdQdIgXplU7u9zzcEfiTj
         UcnCKgMCRUo/KNtTWV133jD+mGzd+CwzVV0ZHUgwY67ZHbo2fPsm+mimnMOZloDW5i+Z
         QLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUgTTBqKFuYwrBAzZpO1jGOAUEqlfA9E0Rem6opsB3E=;
        b=1ZT1wSo5T6oWVV6eHrW2tltf5y0mRIqUi1HTfphMGl4ceOew4zXlds1PAzt16jUaOr
         O+/nyIJ4tbUaTpljOXj/4D8qJoh7ANOuLDoJAog/R3iQZCZbBK5pq4hYTsRKNBT4MS+8
         jJoZRJdL0+OXtbnkTS3Wq7TmX7nOOSYU6M+dr7dWMUEFl2rttKT/twCcKWmhUmOfm0Z0
         NbgCB7Bnkp0Rbr0IxIF78AhR7uWvBXb9hK/dEQKscB2pGuIZtrb6T1PIXYPWlkS5fLRD
         bm2XPaVnI8iC80t5AvGZZnbZtpW0lwqVH6hJQn1iWSzyVHMeEYhyZHBbkFfWFmjtyQ7U
         JJ6A==
X-Gm-Message-State: ANoB5plO9jzc/HC8VFG3lv2LsDFtMXfQhIeKa3PwvU/zBg7vsjuV+b0W
        M+F9Koa3YQqBYUcO6Nj8zC+Ewtzgjxc=
X-Google-Smtp-Source: AA0mqf6Sled3ymaggMqirPv77RcfKjEQpPjpv0lK3onlVFtDH6YH/gOMt608briDetxvDX9JZVSqqx8k3Ls=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:947a:2eda:94df:cc80])
 (user=glider job=sendgmr) by 2002:a0d:ca08:0:b0:378:f758:8a5c with SMTP id
 m8-20020a0dca08000000b00378f7588a5cmr12670700ywd.134.1668414579205; Mon, 14
 Nov 2022 00:29:39 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:29:35 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221114082935.3007497-1-glider@google.com>
Subject: [PATCH] fs: ext4: initialize fsdata in pagecache_write()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN reports
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Also speculatively fix similar issues in affs, f2fs, hfs, hfsplus,
as suggested by Eric Biggers.

Cc: Eric Biggers <ebiggers@kernel.org>
Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/affs/file.c       | 2 +-
 fs/ext4/verity.c     | 2 +-
 fs/f2fs/verity.c     | 2 +-
 fs/hfs/extent.c      | 2 +-
 fs/hfsplus/extents.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index cefa222f7881c..8daeed31e1af9 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -880,7 +880,7 @@ affs_truncate(struct inode *inode)
 	if (inode->i_size > AFFS_I(inode)->mmu_private) {
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		loff_t isize = inode->i_size;
 		int res;
 
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 3c640bd7ecaeb..30e3b65798b50 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c352fff88a5e6..3f4f3295f1c66 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -81,7 +81,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 3f7e9bef98743..6d1878b99b305 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -486,7 +486,7 @@ void hfs_file_truncate(struct inode *inode)
 		inode->i_size);
 	if (inode->i_size > HFS_I(inode)->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
-		void *fsdata;
+		void *fsdata = NULL;
 		struct page *page;
 
 		/* XXX: Can use generic_cont_expand? */
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 721f779b4ec3e..7a542f3dbe502 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -554,7 +554,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	if (inode->i_size > hip->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		loff_t size = inode->i_size;
 
 		res = hfsplus_write_begin(NULL, mapping, size, 0,
-- 
2.38.1.431.g37b22c650d-goog

