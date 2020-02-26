Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE61703F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBZQPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727958AbgBZQPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=3ALKQxAFCE5F0LGykWYTT3UrmTGHD8OtYz0jmj8J0is=;
        b=HbvRgu/5MzllOFe6EqArhwpR8ruMRhle/FXZ+2d69LvxsVwUiibXsb+gvYAjPpFazImH68
        BWaqnW/XybPGwLWgv6yO7LSlDjmJSAhtcdPWHK3x8PZJ1yhkUywy8A/3lFbeVWjNj+Indc
        1BkfvwQ7ZCyW4JUUHEivU3Gz6bT1n94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-ZKqxeAOBPGuZTRtzGLOUIg-1; Wed, 26 Feb 2020 11:15:13 -0500
X-MC-Unique: ZKqxeAOBPGuZTRtzGLOUIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FBEF1005513;
        Wed, 26 Feb 2020 16:15:09 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 871A960BE1;
        Wed, 26 Feb 2020 16:15:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 03/11] fs/dcache: Add a counter to track number of children
Date:   Wed, 26 Feb 2020 11:13:56 -0500
Message-Id: <20200226161404.14136-4-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a new field d_nchildren to struct dentry to track the number of
children in a directory.

Theoretically, we could use reference count (d_lockref.count) as a
proxy for the number of children. Normally the reference count should
be quite close to the number of children. However, when the directory
dentry is heavily contended, the reference count can differ from the
number of children by quite a bit.

The d_nchildren field is updated only when d_lock has already been held,
so the performance cost of this tracking should be negligible.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c            | 16 ++++++++++++----
 include/linux/dcache.h |  7 ++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a977f9e05840..0ee5aa2c31cf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -526,6 +526,8 @@ static inline void dentry_unlist(struct dentry *dentry, struct dentry *parent)
 	if (unlikely(list_empty(&dentry->d_child)))
 		return;
 	__list_del_entry(&dentry->d_child);
+	parent->d_nchildren--;
+
 	/*
 	 * Cursors can move around the list of children.  While we'd been
 	 * a normal list member, it didn't matter - ->d_child.next would've
@@ -1738,6 +1740,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_sb = sb;
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
+	dentry->d_nchildren = 0;
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
@@ -1782,6 +1785,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	__dget_dlock(parent);
 	dentry->d_parent = parent;
 	list_add(&dentry->d_child, &parent->d_subdirs);
+	parent->d_nchildren++;
 	spin_unlock(&parent->d_lock);
 
 	return dentry;
@@ -2762,10 +2766,10 @@ static void swap_names(struct dentry *dentry, struct dentry *target)
 			 * Both are internal.
 			 */
 			unsigned int i;
-			BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
-			for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
-				swap(((long *) &dentry->d_iname)[i],
-				     ((long *) &target->d_iname)[i]);
+			BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(int)));
+			for (i = 0; i < DNAME_INLINE_LEN / sizeof(int); i++) {
+				swap(((int *) &dentry->d_iname)[i],
+				     ((int *) &target->d_iname)[i]);
 			}
 		}
 	}
@@ -2855,6 +2859,10 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 		dentry->d_parent->d_lockref.count++;
 		if (dentry != old_parent) /* wasn't IS_ROOT */
 			WARN_ON(!--old_parent->d_lockref.count);
+
+		/* Adjust d_nchildren */
+		dentry->d_parent->d_nchildren++;
+		old_parent->d_nchildren--;
 	} else {
 		target->d_parent = old_parent;
 		swap_names(dentry, target);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 2762ca2508f9..e9e66eb50d1a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -75,12 +75,12 @@ extern struct dentry_stat_t dentry_stat;
  * large memory footprint increase).
  */
 #ifdef CONFIG_64BIT
-# define DNAME_INLINE_LEN 32 /* 192 bytes */
+# define DNAME_INLINE_LEN 28 /* 192 bytes */
 #else
 # ifdef CONFIG_SMP
-#  define DNAME_INLINE_LEN 36 /* 128 bytes */
+#  define DNAME_INLINE_LEN 32 /* 128 bytes */
 # else
-#  define DNAME_INLINE_LEN 40 /* 128 bytes */
+#  define DNAME_INLINE_LEN 36 /* 128 bytes */
 # endif
 #endif
 
@@ -96,6 +96,7 @@ struct dentry {
 	struct inode *d_inode;		/* Where the name belongs to - NULL is
 					 * negative */
 	unsigned char d_iname[DNAME_INLINE_LEN];	/* small names */
+	unsigned int d_nchildren;	/* # of children (directory only) */
 
 	/* Ref lookup also touches following */
 	struct lockref d_lockref;	/* per-dentry lock and refcount */
-- 
2.18.1

