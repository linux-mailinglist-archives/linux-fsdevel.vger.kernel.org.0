Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605B461964
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhK2Oio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345741AbhK2OgX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:36:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9De042WLsElwjPxKHUOaJ/q0inJ/NX3F0RwHUAnY+hs=;
        b=FAXU8ksWbCeFGshKBAENzkIYyiqlg7Ev3nQh+/i8UgIyn2tvebo+1mZo6zzD7dIxrbsWG3
        nPmDhYC6F9l3swvFWpR9IkM+8AOW49YwiO7y1DrLsdtL+YDkbSO9pfCAlgoW5dq3s2+9+O
        LPNfVaQ/5UQj4lu+SvpK0KeCe9gF6MI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-xvxNg-1-OfKFk4NQLqbiYQ-1; Mon, 29 Nov 2021 09:33:02 -0500
X-MC-Unique: xvxNg-1-OfKFk4NQLqbiYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9CF4104FC0F;
        Mon, 29 Nov 2021 14:32:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDACC5D6BA;
        Mon, 29 Nov 2021 14:32:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 41/64] cachefiles: Implement volume support
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:32:33 +0000
Message-ID: <163819635314.215744.13081522301564537723.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement support for creating the directory layout for a volume on disk
and setting up and withdrawing volume caching.

Each volume has a directory named for the volume key under the root of the
cache (prefixed with an 'I' to indicate to cachefilesd that it's an index)
and then creates a bunch of hash bucket subdirectories under that (named as
'@' plus a hex number) in which cookie files will be created.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/Makefile    |    3 +
 fs/cachefiles/cache.c     |   28 ++++++++++-
 fs/cachefiles/daemon.c    |    2 +
 fs/cachefiles/interface.c |    2 +
 fs/cachefiles/internal.h  |   20 ++++++++
 fs/cachefiles/volume.c    |  118 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 fs/cachefiles/volume.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index 92af5daee8ce..d67210ece9cd 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -9,7 +9,8 @@ cachefiles-y := \
 	interface.o \
 	main.o \
 	namei.o \
-	security.o
+	security.o \
+	volume.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 
diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 4c4121105750..d87db9b6e4c8 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -262,6 +262,32 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 	return ret;
 }
 
+/*
+ * Withdraw volumes.
+ */
+static void cachefiles_withdraw_volumes(struct cachefiles_cache *cache)
+{
+	_enter("");
+
+	for (;;) {
+		struct cachefiles_volume *volume = NULL;
+
+		spin_lock(&cache->object_list_lock);
+		if (!list_empty(&cache->volumes)) {
+			volume = list_first_entry(&cache->volumes,
+						  struct cachefiles_volume, cache_link);
+			list_del_init(&volume->cache_link);
+		}
+		spin_unlock(&cache->object_list_lock);
+		if (!volume)
+			break;
+
+		cachefiles_withdraw_volume(volume);
+	}
+
+	_leave("");
+}
+
 /*
  * Sync a cache to backing disk.
  */
@@ -303,7 +329,7 @@ void cachefiles_withdraw_cache(struct cachefiles_cache *cache)
 	// PLACEHOLDER: Withdraw objects
 	fscache_wait_for_objects(fscache);
 
-	// PLACEHOLDER: Withdraw volume
+	cachefiles_withdraw_volumes(cache);
 	cachefiles_sync_cache(cache);
 	cache->cache = NULL;
 	fscache_relinquish_cache(fscache);
diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index a449ee661987..337597a4e30c 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -105,6 +105,8 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
 
 	mutex_init(&cache->daemon_mutex);
 	init_waitqueue_head(&cache->daemon_pollwq);
+	INIT_LIST_HEAD(&cache->volumes);
+	spin_lock_init(&cache->object_list_lock);
 
 	/* set default caching limits
 	 * - limit at 1% free space and/or free files
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 564ea8fa6641..1793e46bd3e7 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -15,4 +15,6 @@
 
 const struct fscache_cache_ops cachefiles_cache_ops = {
 	.name			= "cachefiles",
+	.acquire_volume		= cachefiles_acquire_volume,
+	.free_volume		= cachefiles_free_volume,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 0ccea2373b40..3b1a6d67cf96 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,17 @@
 struct cachefiles_cache;
 struct cachefiles_object;
 
+/*
+ * Cached volume representation.
+ */
+struct cachefiles_volume {
+	struct cachefiles_cache		*cache;
+	struct list_head		cache_link;	/* Link in cache->volumes */
+	struct fscache_volume		*vcookie;	/* The netfs's representation */
+	struct dentry			*dentry;	/* The volume dentry */
+	struct dentry			*fanout[256];	/* Fanout subdirs */
+};
+
 /*
  * Data file records.
  */
@@ -35,6 +46,8 @@ struct cachefiles_cache {
 	struct dentry			*store;		/* Directory into which live objects go */
 	struct dentry			*graveyard;	/* directory into which dead objects go */
 	struct file			*cachefilesd;	/* manager daemon handle */
+	struct list_head		volumes;	/* List of volume objects */
+	spinlock_t			object_list_lock; /* Lock for volumes and object_list */
 	const struct cred		*cache_cred;	/* security override for accessing cache */
 	struct mutex			daemon_mutex;	/* command serialisation mutex */
 	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
@@ -162,6 +175,13 @@ static inline void cachefiles_end_secure(struct cachefiles_cache *cache,
 	revert_creds(saved_cred);
 }
 
+/*
+ * volume.c
+ */
+void cachefiles_acquire_volume(struct fscache_volume *volume);
+void cachefiles_free_volume(struct fscache_volume *volume);
+void cachefiles_withdraw_volume(struct cachefiles_volume *volume);
+
 /*
  * Error handling
  */
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
new file mode 100644
index 000000000000..2d3635f1aea1
--- /dev/null
+++ b/fs/cachefiles/volume.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Volume handling.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include "internal.h"
+#include <trace/events/fscache.h>
+
+/*
+ * Allocate and set up a volume representation.  We make sure all the fanout
+ * directories are created and pinned.
+ */
+void cachefiles_acquire_volume(struct fscache_volume *vcookie)
+{
+	struct cachefiles_volume *volume;
+	struct cachefiles_cache *cache = vcookie->cache->cache_priv;
+	const struct cred *saved_cred;
+	struct dentry *vdentry, *fan;
+	size_t len;
+	char *name;
+	int n_accesses, i;
+
+	_enter("");
+
+	volume = kzalloc(sizeof(struct cachefiles_volume), GFP_KERNEL);
+	if (!volume)
+		return;
+	volume->vcookie = vcookie;
+	volume->cache = cache;
+	INIT_LIST_HEAD(&volume->cache_link);
+
+	cachefiles_begin_secure(cache, &saved_cred);
+
+	len = vcookie->key[0];
+	name = kmalloc(len + 3, GFP_NOFS);
+	if (!name)
+		goto error_vol;
+	name[0] = 'I';
+	memcpy(name + 1, vcookie->key + 1, len);
+	name[len + 1] = 0;
+
+	vdentry = cachefiles_get_directory(cache, cache->store, name);
+	if (IS_ERR(vdentry))
+		goto error_name;
+	volume->dentry = vdentry;
+
+	for (i = 0; i < 256; i++) {
+		sprintf(name, "@%02x", i);
+		fan = cachefiles_get_directory(cache, vdentry, name);
+		if (IS_ERR(fan))
+			goto error_fan;
+		volume->fanout[i] = fan;
+	}
+
+	cachefiles_end_secure(cache, saved_cred);
+
+	vcookie->cache_priv = volume;
+	n_accesses = atomic_inc_return(&vcookie->n_accesses); /* Stop wakeups on dec-to-0 */
+	trace_fscache_access_volume(vcookie->debug_id, 0,
+				    refcount_read(&vcookie->ref),
+				    n_accesses, fscache_access_cache_pin);
+
+	spin_lock(&cache->object_list_lock);
+	list_add(&volume->cache_link, &volume->cache->volumes);
+	spin_unlock(&cache->object_list_lock);
+
+	kfree(name);
+	return;
+
+error_fan:
+	for (i = 0; i < 256; i++)
+		cachefiles_put_directory(volume->fanout[i]);
+	cachefiles_put_directory(volume->dentry);
+error_name:
+	kfree(name);
+error_vol:
+	kfree(volume);
+	cachefiles_end_secure(cache, saved_cred);
+}
+
+/*
+ * Release a volume representation.
+ */
+static void __cachefiles_free_volume(struct cachefiles_volume *volume)
+{
+	int i;
+
+	_enter("");
+
+	volume->vcookie->cache_priv = NULL;
+
+	for (i = 0; i < 256; i++)
+		cachefiles_put_directory(volume->fanout[i]);
+	cachefiles_put_directory(volume->dentry);
+	kfree(volume);
+}
+
+void cachefiles_free_volume(struct fscache_volume *vcookie)
+{
+	struct cachefiles_volume *volume = vcookie->cache_priv;
+
+	if (volume) {
+		spin_lock(&volume->cache->object_list_lock);
+		list_del_init(&volume->cache_link);
+		spin_unlock(&volume->cache->object_list_lock);
+		__cachefiles_free_volume(volume);
+	}
+}
+
+void cachefiles_withdraw_volume(struct cachefiles_volume *volume)
+{
+	fscache_withdraw_volume(volume->vcookie);
+	__cachefiles_free_volume(volume);
+}


