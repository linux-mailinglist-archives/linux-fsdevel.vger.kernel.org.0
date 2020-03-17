Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A578A188273
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 12:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgCQLrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 07:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQLrQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:47:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 493F2AD88;
        Tue, 17 Mar 2020 11:47:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3CB391E121E; Tue, 17 Mar 2020 12:47:12 +0100 (CET)
Date:   Tue, 17 Mar 2020 12:47:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] ext2: fix debug reference to ext2_xattr_cache
Message-ID: <20200317114712.GH22684@quack2.suse.cz>
References: <88b8bde4-8c7a-6b44-9478-3ce13ecfab3a@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88b8bde4-8c7a-6b44-9478-3ce13ecfab3a@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri 13-03-20 20:42:05, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a debug-only build error in ext2/xattr.c:
> 
> When building without extra debugging, (and with another patch that uses
> no_printk() instead of <empty> for the ext2-xattr debug-print macros,
> this build error happens:
> 
> ../fs/ext2/xattr.c: In function ‘ext2_xattr_cache_insert’:
> ../fs/ext2/xattr.c:869:18: error: ‘ext2_xattr_cache’ undeclared (first use in this function); did you mean ‘ext2_xattr_list’?
>      atomic_read(&ext2_xattr_cache->c_entry_count));
> 
> Fix by moving struct mb_cache from fs/mbcache.c to <linux/mbcache.h>,
> and then using the correct struct name in the debug-print macro.
> 
> This wasn't converted when ext2 xattr cache was changed to use mbcache.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org

Thanks for the patch! I don't think exporting 'struct mb_cache' just for
this is reasonable. I've committed a patch which just removes the entry
count from the debug message (attached).

								Honza

> ---
> This is ancient, from the beginning of git history.
> 
> Or just kill of that print of c_entry_count...
> 
>  fs/ext2/xattr.c         |    2 +-
>  fs/mbcache.c            |   34 ----------------------------------
>  include/linux/mbcache.h |   35 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 35 insertions(+), 36 deletions(-)
> 
> --- linux-next-20200313.orig/fs/ext2/xattr.c
> +++ linux-next-20200313/fs/ext2/xattr.c
> @@ -873,7 +873,7 @@ ext2_xattr_cache_insert(struct mb_cache
>  	if (error) {
>  		if (error == -EBUSY) {
>  			ea_bdebug(bh, "already in cache (%d cache entries)",
> -				atomic_read(&ext2_xattr_cache->c_entry_count));
> +				atomic_read(&cache->c_entry_count));
>  			error = 0;
>  		}
>  	} else
> --- linux-next-20200313.orig/fs/mbcache.c
> +++ linux-next-20200313/fs/mbcache.c
> @@ -8,40 +8,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/mbcache.h>
>  
> -/*
> - * Mbcache is a simple key-value store. Keys need not be unique, however
> - * key-value pairs are expected to be unique (we use this fact in
> - * mb_cache_entry_delete()).
> - *
> - * Ext2 and ext4 use this cache for deduplication of extended attribute blocks.
> - * Ext4 also uses it for deduplication of xattr values stored in inodes.
> - * They use hash of data as a key and provide a value that may represent a
> - * block or inode number. That's why keys need not be unique (hash of different
> - * data may be the same). However user provided value always uniquely
> - * identifies a cache entry.
> - *
> - * We provide functions for creation and removal of entries, search by key,
> - * and a special "delete entry with given key-value pair" operation. Fixed
> - * size hash table is used for fast key lookups.
> - */
> -
> -struct mb_cache {
> -	/* Hash table of entries */
> -	struct hlist_bl_head	*c_hash;
> -	/* log2 of hash table size */
> -	int			c_bucket_bits;
> -	/* Maximum entries in cache to avoid degrading hash too much */
> -	unsigned long		c_max_entries;
> -	/* Protects c_list, c_entry_count */
> -	spinlock_t		c_list_lock;
> -	struct list_head	c_list;
> -	/* Number of entries in cache */
> -	unsigned long		c_entry_count;
> -	struct shrinker		c_shrink;
> -	/* Work for shrinking when the cache has too many entries */
> -	struct work_struct	c_shrink_work;
> -};
> -
>  static struct kmem_cache *mb_entry_cache;
>  
>  static unsigned long mb_cache_shrink(struct mb_cache *cache,
> --- linux-next-20200313.orig/include/linux/mbcache.h
> +++ linux-next-20200313/include/linux/mbcache.h
> @@ -8,7 +8,40 @@
>  #include <linux/atomic.h>
>  #include <linux/fs.h>
>  
> -struct mb_cache;
> +/*
> + * Mbcache is a simple key-value store. Keys need not be unique, however
> + * key-value pairs are expected to be unique (we use this fact in
> + * mb_cache_entry_delete()).
> + *
> + * Ext2 and ext4 use this cache for deduplication of extended attribute blocks.
> + * Ext4 also uses it for deduplication of xattr values stored in inodes.
> + * They use hash of data as a key and provide a value that may represent a
> + * block or inode number. That's why keys need not be unique (hash of different
> + * data may be the same). However user provided value always uniquely
> + * identifies a cache entry.
> + *
> + * We provide functions for creation and removal of entries, search by key,
> + * and a special "delete entry with given key-value pair" operation. Fixed
> + * size hash table is used for fast key lookups.
> + */
> +
> +struct mb_cache {
> +	/* Hash table of entries */
> +	struct hlist_bl_head	*c_hash;
> +	/* log2 of hash table size */
> +	int			c_bucket_bits;
> +	/* Maximum entries in cache to avoid degrading hash too much */
> +	unsigned long		c_max_entries;
> +	/* Protects c_list, c_entry_count */
> +	spinlock_t		c_list_lock;
> +	struct list_head	c_list;
> +	/* Number of entries in cache */
> +	unsigned long		c_entry_count;
> +	struct shrinker		c_shrink;
> +	/* Work for shrinking when the cache has too many entries */
> +	struct work_struct	c_shrink_work;
> +};
> +
>  
>  struct mb_cache_entry {
>  	/* List of entries in cache - protected by cache->c_list_lock */
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--huq684BweRXVnRxX
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename="0001-ext2-fix-debug-reference-to-ext2_xattr_cache.patch"
Content-Transfer-Encoding: 8bit

From 32302085a8d90859c40cf1a5e8313f575d06ec75 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Tue, 17 Mar 2020 12:40:02 +0100
Subject: [PATCH] ext2: fix debug reference to ext2_xattr_cache
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a debug-only build error in ext2/xattr.c:

When building without extra debugging, (and with another patch that uses
no_printk() instead of <empty> for the ext2-xattr debug-print macros,
this build error happens:

../fs/ext2/xattr.c: In function ‘ext2_xattr_cache_insert’:
../fs/ext2/xattr.c:869:18: error: ‘ext2_xattr_cache’ undeclared (first use in
this function); did you mean ‘ext2_xattr_list’?
     atomic_read(&ext2_xattr_cache->c_entry_count));

Fix the problem by removing cached entry count from the debug message
since otherwise we'd have to export the mbcache structure just for that.

Fixes: be0726d33cb8 ("ext2: convert to mbcache2")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 9ad07c7ef0b3..6d9731b03715 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -872,8 +872,7 @@ ext2_xattr_cache_insert(struct mb_cache *cache, struct buffer_head *bh)
 				      true);
 	if (error) {
 		if (error == -EBUSY) {
-			ea_bdebug(bh, "already in cache (%d cache entries)",
-				atomic_read(&ext2_xattr_cache->c_entry_count));
+			ea_bdebug(bh, "already in cache");
 			error = 0;
 		}
 	} else
-- 
2.16.4


--huq684BweRXVnRxX--
