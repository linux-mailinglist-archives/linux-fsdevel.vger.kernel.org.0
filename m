Return-Path: <linux-fsdevel+bounces-73111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3DBD0CE74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14632303F36D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB227B32B;
	Sat, 10 Jan 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TFa5gVdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C13500963;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=om30xKkfyD+/H20dwE6iSypC0q5l2Dhfwtzy2FBPaepOI7km6X/aZVFyFdvfzCrXGTf+wLVOsq1WoR/6Oq97OeuaQDPsPaDYybEwctBUDz3OznVJW1jJCZdggBUro10QPwO1iY0VSON0SnbFpWZFvzUTHEP2sXa7tRYCgCMRMss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=FNJ/LAWDZhf/4UGECsNoVJF3S9MIQgpyO8vZJlbx1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTx4sRFVTKbZByfSN4bUGGdQi/NSt0Nnj3H1sZ6pWM+T+uq2DVWqxcaWI8KnjBS9AwHdWRz/34YyKbOazA9up/ukYpS+L53qC+fMEtDe8LLlEgVKsDGv5Bf6qBpJE+WlHiV5CW6nsys2bK1GdPGhqVL7eu9jcP3Ddu1NoA5ogUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TFa5gVdr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ISNZFsbhMluGOOgPJOf7PuXZbW/+Y33dgsD1DeUdNV0=; b=TFa5gVdrJvHVBG1sACtJpPQTOx
	+glfX5twmsJHBvGQUd7Lw6Y+eEtRTXV77LC0AUyJHDPFml5kDOFay7oyDroqQn4vCJRcljjNA0aSz
	+QxWiTMVa86jafeoaXLMOWXtREF0YYii1VtGCQNHJh1BFZtaezyAEKZpJWWDXIm0Ld71UF4NIazsu
	GqDPFmAj1U/RyGs0YUSxdga4Vb0FbVSPchaXbqR40LpZ96DTfeku9RnQvxIVIwt4DEl3yIAUpfWmI
	4Ca+Fwlz7Q31GJeuKZ2e9DoUwKZLhy+hSK5pcPJPtymhmyfb1WBOr8Uia9RNWzOz5VlLooAzzSV/i
	JZInNl/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB8-000000085ZD-1yqq;
	Sat, 10 Jan 2026 04:02:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/15] allow static-duration kmem_cache in modules
Date: Sat, 10 Jan 2026 04:02:04 +0000
Message-ID: <20260110040217.1927971-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	We need to make sure that instance in a module will get to
slab_kmem_cache_release() before the module data gets freed.  That's only
a problem on sysfs setups - otherwise it'll definitely be finished before
kmem_cache_destroy() returns.

	Note that modules themselves have sysfs-exposed attributes,
so a similar problem already exists there.  That's dealt with by
having mod_sysfs_teardown() wait for refcount of module->mkobj.kobj
reaching zero.  Let's make use of that - have static-duration-in-module
kmem_cache instances grab a reference to that kobject upon setup and
drop it in the end of slab_kmem_cache_release().

	Let setup helpers store the kobjetct to be pinned in
kmem_cache_args->owner (for preallocated; if somebody manually sets it
for non-preallocated case, it'll be ignored).  That would be
&THIS_MODULE->mkobj.kobj for a module and NULL in built-in.

	If sysfs is enabled and we are dealing with preallocated instance,
let create_cache() grab and stash that reference in kmem_cache->owner
and let slab_kmem_cache_release() drop it instead of freeing kmem_cache
instance.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/slab-static.h | 12 ++++++++----
 include/linux/slab.h        |  4 ++++
 mm/slab.h                   |  1 +
 mm/slab_common.c            | 16 ++++++++++++++--
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab-static.h b/include/linux/slab-static.h
index 47b2220b4988..16d1564b4a4b 100644
--- a/include/linux/slab-static.h
+++ b/include/linux/slab-static.h
@@ -2,10 +2,7 @@
 #ifndef _LINUX_SLAB_STATIC_H
 #define _LINUX_SLAB_STATIC_H
 
-#ifdef MODULE
-#error "can't use that in modules"
-#endif
-
+#include <linux/init.h>
 #include <generated/kmem_cache_size.h>
 
 /* same size and alignment as struct kmem_cache: */
@@ -13,9 +10,16 @@ struct kmem_cache_opaque {
 	unsigned char opaque[KMEM_CACHE_SIZE];
 } __aligned(KMEM_CACHE_ALIGN);
 
+#ifdef MODULE
+#define THIS_MODULE_KOBJ &THIS_MODULE->mkobj.kobj
+#else
+#define THIS_MODULE_KOBJ NULL
+#endif
+
 #define __KMEM_CACHE_SETUP(cache, name, size, flags, ...)	\
 		__kmem_cache_create_args((name), (size),	\
 			&(struct kmem_cache_args) {		\
+				.owner = THIS_MODULE_KOBJ,	\
 				.preallocated = (cache),	\
 				__VA_ARGS__}, (flags))
 
diff --git a/include/linux/slab.h b/include/linux/slab.h
index f16c784148b4..dc1aeb14a12b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -60,6 +60,7 @@ enum _slab_flag_bits {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	_SLAB_NO_OBJ_EXT,
 #endif
+	_SLAB_PREALLOCATED,
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -244,6 +245,8 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
+#define SLAB_PREALLOCATED	__SLAB_FLAG_BIT(_SLAB_PREALLOCATED)
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
@@ -373,6 +376,7 @@ struct kmem_cache_args {
 	 */
 	unsigned int sheaf_capacity;
 	struct kmem_cache *preallocated;
+	struct kobject *owner;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/mm/slab.h b/mm/slab.h
index e767aa7e91b0..9ff9a0a3b164 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -249,6 +249,7 @@ struct kmem_cache {
 	struct list_head list;		/* List of slab caches */
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;		/* For sysfs */
+	struct kobject *owner;		/* keep that pinned while alive */
 #endif
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	unsigned long random;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 81a413b44afb..a854e6872acd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -245,6 +245,12 @@ static struct kmem_cache *create_cache(const char *name,
 			kmem_cache_free(kmem_cache, s);
 		return ERR_PTR(err);
 	}
+#ifdef CONFIG_SYSFS
+	if (flags & SLAB_PREALLOCATED) {
+		s->owner = args->owner;
+		kobject_get(s->owner);
+	}
+#endif
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
 	return s;
@@ -322,7 +328,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		args->usersize = args->useroffset = 0;
 
 	if (args->preallocated)
-		flags |= SLAB_NO_MERGE;
+		flags |= SLAB_NO_MERGE | SLAB_PREALLOCATED;
 
 	if (!args->usersize && !args->sheaf_capacity)
 		s = __kmem_cache_alias(name, object_size, args->align, flags,
@@ -481,7 +487,13 @@ void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
 	kfree_const(s->name);
-	kmem_cache_free(kmem_cache, s);
+	if (!(s->flags & SLAB_PREALLOCATED)) {
+		kmem_cache_free(kmem_cache, s);
+		return;
+	}
+#ifdef CONFIG_SYSFS
+	kobject_put(s->owner);
+#endif
 }
 
 void kmem_cache_destroy(struct kmem_cache *s)
-- 
2.47.3


