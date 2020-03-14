Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6618544B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCNDmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 23:42:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCNDmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FPuX6zkcFdbtbyZLM/zhUFihyPFRGyl8uLloYAglaW4=; b=OpOTn0zMuOdXiX+nG5KqNzhp2C
        MFO8ZJrMRNSPEnmHRShvqHFGm+8SEWUCw/2vJ02XYfyy/ZEnG6zdRZO8yOQt0KhPu7Wbss2w9Qjmw
        HrYyZaMCCnMyiJtBeosjFLXzhBKRcM2rdhSQKq1Uopt8oWn/8B8D5PlEOuhm05Oe2u/PQn19TBMef
        gU5a/ikD5z5lLNxpL/iJqTCJ9WMZp2sxCjR5CnKLsPO04nu/apOxseiYz97eAcnQgCe/hkkwQ35Wa
        BniQ+9ZkOyRckzykVSlVg4qgkNzUDi2G17Ul9/a1xth+huva46YRQ+8DcCc7JZbsEspPhzLtpKfc+
        0BqdZDWA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCxgc-0003TM-IG; Sat, 14 Mar 2020 03:42:06 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ext2: fix debug reference to ext2_xattr_cache
Message-ID: <88b8bde4-8c7a-6b44-9478-3ce13ecfab3a@infradead.org>
Date:   Fri, 13 Mar 2020 20:42:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a debug-only build error in ext2/xattr.c:

When building without extra debugging, (and with another patch that uses
no_printk() instead of <empty> for the ext2-xattr debug-print macros,
this build error happens:

../fs/ext2/xattr.c: In function ‘ext2_xattr_cache_insert’:
../fs/ext2/xattr.c:869:18: error: ‘ext2_xattr_cache’ undeclared (first use in this function); did you mean ‘ext2_xattr_list’?
     atomic_read(&ext2_xattr_cache->c_entry_count));

Fix by moving struct mb_cache from fs/mbcache.c to <linux/mbcache.h>,
and then using the correct struct name in the debug-print macro.

This wasn't converted when ext2 xattr cache was changed to use mbcache.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
This is ancient, from the beginning of git history.

Or just kill of that print of c_entry_count...

 fs/ext2/xattr.c         |    2 +-
 fs/mbcache.c            |   34 ----------------------------------
 include/linux/mbcache.h |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 36 deletions(-)

--- linux-next-20200313.orig/fs/ext2/xattr.c
+++ linux-next-20200313/fs/ext2/xattr.c
@@ -873,7 +873,7 @@ ext2_xattr_cache_insert(struct mb_cache
 	if (error) {
 		if (error == -EBUSY) {
 			ea_bdebug(bh, "already in cache (%d cache entries)",
-				atomic_read(&ext2_xattr_cache->c_entry_count));
+				atomic_read(&cache->c_entry_count));
 			error = 0;
 		}
 	} else
--- linux-next-20200313.orig/fs/mbcache.c
+++ linux-next-20200313/fs/mbcache.c
@@ -8,40 +8,6 @@
 #include <linux/workqueue.h>
 #include <linux/mbcache.h>
 
-/*
- * Mbcache is a simple key-value store. Keys need not be unique, however
- * key-value pairs are expected to be unique (we use this fact in
- * mb_cache_entry_delete()).
- *
- * Ext2 and ext4 use this cache for deduplication of extended attribute blocks.
- * Ext4 also uses it for deduplication of xattr values stored in inodes.
- * They use hash of data as a key and provide a value that may represent a
- * block or inode number. That's why keys need not be unique (hash of different
- * data may be the same). However user provided value always uniquely
- * identifies a cache entry.
- *
- * We provide functions for creation and removal of entries, search by key,
- * and a special "delete entry with given key-value pair" operation. Fixed
- * size hash table is used for fast key lookups.
- */
-
-struct mb_cache {
-	/* Hash table of entries */
-	struct hlist_bl_head	*c_hash;
-	/* log2 of hash table size */
-	int			c_bucket_bits;
-	/* Maximum entries in cache to avoid degrading hash too much */
-	unsigned long		c_max_entries;
-	/* Protects c_list, c_entry_count */
-	spinlock_t		c_list_lock;
-	struct list_head	c_list;
-	/* Number of entries in cache */
-	unsigned long		c_entry_count;
-	struct shrinker		c_shrink;
-	/* Work for shrinking when the cache has too many entries */
-	struct work_struct	c_shrink_work;
-};
-
 static struct kmem_cache *mb_entry_cache;
 
 static unsigned long mb_cache_shrink(struct mb_cache *cache,
--- linux-next-20200313.orig/include/linux/mbcache.h
+++ linux-next-20200313/include/linux/mbcache.h
@@ -8,7 +8,40 @@
 #include <linux/atomic.h>
 #include <linux/fs.h>
 
-struct mb_cache;
+/*
+ * Mbcache is a simple key-value store. Keys need not be unique, however
+ * key-value pairs are expected to be unique (we use this fact in
+ * mb_cache_entry_delete()).
+ *
+ * Ext2 and ext4 use this cache for deduplication of extended attribute blocks.
+ * Ext4 also uses it for deduplication of xattr values stored in inodes.
+ * They use hash of data as a key and provide a value that may represent a
+ * block or inode number. That's why keys need not be unique (hash of different
+ * data may be the same). However user provided value always uniquely
+ * identifies a cache entry.
+ *
+ * We provide functions for creation and removal of entries, search by key,
+ * and a special "delete entry with given key-value pair" operation. Fixed
+ * size hash table is used for fast key lookups.
+ */
+
+struct mb_cache {
+	/* Hash table of entries */
+	struct hlist_bl_head	*c_hash;
+	/* log2 of hash table size */
+	int			c_bucket_bits;
+	/* Maximum entries in cache to avoid degrading hash too much */
+	unsigned long		c_max_entries;
+	/* Protects c_list, c_entry_count */
+	spinlock_t		c_list_lock;
+	struct list_head	c_list;
+	/* Number of entries in cache */
+	unsigned long		c_entry_count;
+	struct shrinker		c_shrink;
+	/* Work for shrinking when the cache has too many entries */
+	struct work_struct	c_shrink_work;
+};
+
 
 struct mb_cache_entry {
 	/* List of entries in cache - protected by cache->c_list_lock */

