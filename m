Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2B6146C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 10:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiKAJej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiKAJe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:34:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5B19005
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 02:34:27 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so18279280pjc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Nov 2022 02:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XLH6YyEbVm2Z6h5s13YZtEQu0aHxoi9jUbOAeZzMA=;
        b=MTIZBkpQ1AJ926SViIChs8XqH4br4rHBewQYn0WqUlDIV9ULmYWNtD30sSdpApONyR
         Gs0DlVVG7XryC9wI0hdtSDlEH7zVQl6hwFmg9lEhgkN5WFMULzfJ6yY3A2ytjcFs6fDn
         LpPrGX84of+QOz9DKYI5WfxA576gfbuuCXbmn7+/m5fYC9ZXjROiEfjiFaw65BRp9khS
         me1r+X5kEE5zQckfEMplZj7klnLnoFV7VW/xfytEeSzA3wyuVLRJ5ynhppQXQ2yrjVOC
         82UpbTgzJo5kIYj3cAyqEjFP7I6CC5PwNW+pHBVZdFoZYCpgP/c8Gl/5kEyRL5fAw1Au
         /5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0XLH6YyEbVm2Z6h5s13YZtEQu0aHxoi9jUbOAeZzMA=;
        b=TIHKUlCBXf2s3mvWLh1yanqhESohO8frtWQtKztTrG6aKtrxgkK548GgGHuXwk0qp8
         nb107pB1gTNhArqUTEZ01XkldwFiiJ41iYfk5X6xpnaFbxl2JX7qJNXQacV+tNMjcGs5
         CnBlkowytlzpGrUHkblw2lxl34rKWenQo/YgFIcC/v0CNkda3E+pVT/VnlI92IkxSDmc
         qJ6GGj+9jcg2hDItDSl7dMhLm5QSFnMM3qHKVby6XNUwpnve5vhegJxCFUioCmjHziHE
         8V8pGsdAjRmrIz1QJqsNMvZI9tEONg4YdQJlDPFiqNtotnu1nvInc8vGvBdEMkLCExLS
         DhqA==
X-Gm-Message-State: ACrzQf1YlcE+3KfEPHGkN6cr3tTZIKkFAwMnDJLYXBTjempKbDs1RRkh
        Mc5nzk0MQHmkv1u8PniyIiAiBA==
X-Google-Smtp-Source: AMsMyM4O4afEojXTF5wq0P2O3SrchQKBUxntq3oJARVNe7hoAHJO9RhjpJZi0VSMdVQGLNxwrhrH2Q==
X-Received: by 2002:a17:903:11c4:b0:178:634b:1485 with SMTP id q4-20020a17090311c400b00178634b1485mr18001827plh.142.1667295267042;
        Tue, 01 Nov 2022 02:34:27 -0700 (PDT)
Received: from HTW5T2C6VL.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id b189-20020a621bc6000000b0056b818142a2sm6080300pfb.109.2022.11.01.02.34.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 01 Nov 2022 02:34:26 -0700 (PDT)
From:   changfengnan <changfengnan@bytedance.com>
To:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk, djwong@kernel.org,
        dchinner@redhat.com, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org
Cc:     changfengnan <changfengnan@bytedance.com>
Subject: [PATCH] mm: remove filemap_fdatawait_keep_errors
Date:   Tue,  1 Nov 2022 17:34:13 +0800
Message-Id: <20221101093413.5871-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

use filemap_fdatawait_range_keep_errors to instead of
filemap_fdatawait_keep_errors, no functional change.

Signed-off-by: changfengnan <changfengnan@bytedance.com>
---
 block/bdev.c            |  5 +++--
 fs/fs-writeback.c       |  5 +++--
 fs/xfs/scrub/bmap.c     |  3 ++-
 include/linux/pagemap.h |  1 -
 mm/filemap.c            | 21 ---------------------
 5 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ce05175e71ce..f600b10017cd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1055,10 +1055,11 @@ void sync_bdevs(bool wait)
 			/*
 			 * We keep the error status of individual mapping so
 			 * that applications can catch the writeback error using
-			 * fsync(2). See filemap_fdatawait_keep_errors() for
+			 * fsync(2). See filemap_fdatawait_range_keep_errors for
 			 * details.
 			 */
-			filemap_fdatawait_keep_errors(inode->i_mapping);
+			filemap_fdatawait_range_keep_errors(inode->i_mapping,
+								0, LLONG_MAX);
 		} else {
 			filemap_fdatawrite(inode->i_mapping);
 		}
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..d417cdb4505a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2582,9 +2582,10 @@ static void wait_sb_inodes(struct super_block *sb)
 		/*
 		 * We keep the error status of individual mapping so that
 		 * applications can catch the writeback error using fsync(2).
-		 * See filemap_fdatawait_keep_errors() for details.
+		 * See filemap_fdatawait_range_keep_errors for details.
 		 */
-		filemap_fdatawait_keep_errors(mapping);
+		filemap_fdatawait_range_keep_errors(inode->i_mapping,
+							0, LLONG_MAX);
 
 		cond_resched();
 
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index f0b9cb6506fd..6be0433eaa51 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -64,7 +64,8 @@ xchk_setup_inode_bmap(
 		 */
 		error = filemap_fdatawrite(mapping);
 		if (!error)
-			error = filemap_fdatawait_keep_errors(mapping);
+			error = filemap_fdatawait_range_keep_errors(mapping,
+								0, LLONG_MAX);
 		if (error && (error != -ENOSPC && error != -EIO))
 			goto out;
 	}
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..75536967f57b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -33,7 +33,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
-int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
 		loff_t start_byte, loff_t end_byte);
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b..b4932493175b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -600,27 +600,6 @@ int file_fdatawait_range(struct file *file, loff_t start_byte, loff_t end_byte)
 }
 EXPORT_SYMBOL(file_fdatawait_range);
 
-/**
- * filemap_fdatawait_keep_errors - wait for writeback without clearing errors
- * @mapping: address space structure to wait for
- *
- * Walk the list of under-writeback pages of the given address space
- * and wait for all of them.  Unlike filemap_fdatawait(), this function
- * does not clear error status of the address space.
- *
- * Use this function if callers don't handle errors themselves.  Expected
- * call sites are system-wide / filesystem-wide data flushers: e.g. sync(2),
- * fsfreeze(8)
- *
- * Return: error status of the address space.
- */
-int filemap_fdatawait_keep_errors(struct address_space *mapping)
-{
-	__filemap_fdatawait_range(mapping, 0, LLONG_MAX);
-	return filemap_check_and_keep_errors(mapping);
-}
-EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
-
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-- 
2.37.0 (Apple Git-136)

