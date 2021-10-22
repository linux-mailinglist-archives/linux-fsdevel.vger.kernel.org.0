Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0DF437DB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhJVTI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 15:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234132AbhJVTIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 15:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634929590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxW5faIBpT4iZKMN/oHuPMSl3X4LcdX9XSZHMc3sLQQ=;
        b=aJM+XjWmnUT6eofvNI9m31k/PEK4LaTFWgj+34rYZLaAYLxA8/P3DvarEH1woKD0R6/a63
        LygoYB0xKeHAPs0gio3l2DwZ/Q1oc4+l0m9gFZ5BAgMS+Oa/IK7SY45++/2uf6oh9CfKOt
        79dwf2xkIOptlGu0iBwFaFUZhDK9rr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-qwGzpZofPZa_wUEkLF6qZg-1; Fri, 22 Oct 2021 15:06:27 -0400
X-MC-Unique: qwGzpZofPZa_wUEkLF6qZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E74718D6A25;
        Fri, 22 Oct 2021 19:06:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC1AE5C1A3;
        Fri, 22 Oct 2021 19:06:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 31/53] cachefiles: Define structs
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 22 Oct 2021 20:06:18 +0100
Message-ID: <163492957882.1038219.5079747779493876581.stgit@warthog.procyon.org.uk>
In-Reply-To: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
References: <163492911924.1038219.13107463173777870713.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define structures to represent the state inside cachefiles.  There are
three structures:

 (1) struct cachefiles_cache.

     This represents the cache as a whole and is used to keep track of the
     cache parameters and security, the communication channel to the
     controlling daemon and various directories in the cache filesystem.

 (2) struct cachefiles_volume.

     This represents a volume in the cache.  It keeps track of the
     directory for the volume and the fanout subdirs that form a hash
     table.

 (3) struct cachefiles_object.

     This represents a data file in the cache.  It keeps track of the
     filename and the open file handle for the relevant file.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 fs/cachefiles/internal.h |   86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2f8e2835a785..11dcf9dbcf05 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,11 +19,97 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 
+struct cachefiles_cache;
+struct cachefiles_object;
+
 extern unsigned cachefiles_debug;
 #define CACHEFILES_DEBUG_KENTER	1
 #define CACHEFILES_DEBUG_KLEAVE	2
 #define CACHEFILES_DEBUG_KDEBUG	4
 
+enum cachefiles_content {
+	/* These values are saved on disk */
+	CACHEFILES_CONTENT_NO_DATA	= 0, /* No content stored */
+	CACHEFILES_CONTENT_SINGLE	= 1, /* Content is monolithic, all is present */
+	CACHEFILES_CONTENT_ALL		= 2, /* Content is all present, no map */
+	CACHEFILES_CONTENT_BACKFS_MAP	= 3, /* Content is piecemeal, mapped through backing fs */
+	CACHEFILES_CONTENT_DIRTY	= 4, /* Content is dirty (only seen on disk) */
+	nr__cachefiles_content
+};
+
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
+/*
+ * node records
+ */
+struct cachefiles_object {
+	int				debug_id;	/* debugging ID */
+	spinlock_t			lock;		/* state and operations lock */
+
+	struct list_head		cache_link;	/* Link in cache->*_list */
+	struct cachefiles_volume	*volume;	/* Cache volume that holds this object */
+	struct fscache_cookie		*cookie;	/* netfs's file/index object */
+	struct file			*file;		/* The file representing this object */
+	char				*d_name;	/* Filename */
+	atomic_t			usage;		/* object usage count */
+	u8				d_name_len;	/* Length of filename */
+	u8				key_hash;	/* Hash of object key */
+	unsigned long			flags;
+#define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
+	enum cachefiles_content		content_info:8;	/* Info about content presence */
+};
+
+/*
+ * Cache files cache definition
+ */
+struct cachefiles_cache {
+	struct fscache_cache		*cache;		/* Cache cookie */
+	struct vfsmount			*mnt;		/* mountpoint holding the cache */
+	struct dentry			*store;		/* Directory into which live objects go */
+	struct dentry			*graveyard;	/* directory into which dead objects go */
+	struct file			*cachefilesd;	/* manager daemon handle */
+	struct list_head		volumes;	/* List of volume objects */
+	struct list_head		object_list;	/* List of active objects */
+	spinlock_t			object_list_lock;
+	const struct cred		*cache_cred;	/* security override for accessing cache */
+	struct mutex			daemon_mutex;	/* command serialisation mutex */
+	wait_queue_head_t		daemon_pollwq;	/* poll waitqueue for daemon */
+	atomic_t			gravecounter;	/* graveyard uniquifier */
+	atomic_t			f_released;	/* number of objects released lately */
+	atomic_long_t			b_released;	/* number of blocks released lately */
+	unsigned			frun_percent;	/* when to stop culling (% files) */
+	unsigned			fcull_percent;	/* when to start culling (% files) */
+	unsigned			fstop_percent;	/* when to stop allocating (% files) */
+	unsigned			brun_percent;	/* when to stop culling (% blocks) */
+	unsigned			bcull_percent;	/* when to start culling (% blocks) */
+	unsigned			bstop_percent;	/* when to stop allocating (% blocks) */
+	unsigned			bsize;		/* cache's block size */
+	unsigned			bshift;		/* min(ilog2(PAGE_SIZE / bsize), 0) */
+	uint64_t			frun;		/* when to stop culling */
+	uint64_t			fcull;		/* when to start culling */
+	uint64_t			fstop;		/* when to stop allocating */
+	sector_t			brun;		/* when to stop culling */
+	sector_t			bcull;		/* when to start culling */
+	sector_t			bstop;		/* when to stop allocating */
+	unsigned long			flags;
+#define CACHEFILES_READY		0	/* T if cache prepared */
+#define CACHEFILES_DEAD			1	/* T if cache dead */
+#define CACHEFILES_CULLING		2	/* T if cull engaged */
+#define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
+	char				*rootdirname;	/* name of cache root directory */
+	char				*secctx;	/* LSM security context */
+	char				*tag;		/* cache binding tag */
+};
+
 /*
  * error_inject.c
  */


