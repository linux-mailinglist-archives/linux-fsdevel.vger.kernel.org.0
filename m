Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B4447DADC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbhLVXZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhLVXZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qlOPWgEuTiPLvVktnTJcmFg2tcfWOUQdMQU/CgQroqI=;
        b=bh8xHYHkxLdmyY8ukS9gT81y1WIyJYcK92hCbAUGRSy3ektvvAZKsieUcdUAZTKL0FLJlW
        r1+0qlRA/++PnzOAGNvQ8p1KqQBRd42VTCu53NsVTdDZiJmss6FTDEe6mQ435pV9ATC+7a
        1333Ak+l/GZnLrT6g4KHtv/pys2LyMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-8nLGaLbyP5GNBgGCGNKqRg-1; Wed, 22 Dec 2021 18:25:47 -0500
X-MC-Unique: 8nLGaLbyP5GNBgGCGNKqRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E77B104ECE7;
        Wed, 22 Dec 2021 23:25:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7D787EFF9;
        Wed, 22 Dec 2021 23:25:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 46/68] cachefiles: Mark a backing file in use with an inode
 flag
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
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:25:23 +0000
Message-ID: <164021552299.640689.10578652796777392062.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an inode flag, S_KERNEL_FILE, to mark that a backing file is in use by
the kernel to prevent cachefiles or other kernel services from interfering
with that file.

Using S_SWAPFILE instead isn't really viable as that has other effects in
the I/O paths.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819642273.215744.6414248677118690672.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906943215.143852.16972351425323967014.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967154118.1823006.13227551961786743991.stgit@warthog.procyon.org.uk/ # v3
---

 fs/cachefiles/internal.h |    2 ++
 fs/cachefiles/namei.c    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 01071e7a7c02..7c67a70a3dff 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -187,6 +187,8 @@ extern struct kmem_cache *cachefiles_object_jar;
 /*
  * namei.c
  */
+extern void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+					   struct file *file);
 extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       struct dentry *dir,
 					       const char *name,
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 11a33209ab5f..db60a671c3fc 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -31,6 +31,18 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 	return can_use;
 }
 
+static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
+					 struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	bool can_use;
+
+	inode_lock(inode);
+	can_use = __cachefiles_mark_inode_in_use(object, dentry);
+	inode_unlock(inode);
+	return can_use;
+}
+
 /*
  * Unmark a backing inode.  The caller must hold the inode lock.
  */
@@ -43,6 +55,29 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	trace_cachefiles_mark_inactive(object, inode);
 }
 
+/*
+ * Unmark a backing inode and tell cachefilesd that there's something that can
+ * be culled.
+ */
+void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
+				    struct file *file)
+{
+	struct cachefiles_cache *cache = object->volume->cache;
+	struct inode *inode = file_inode(file);
+
+	if (inode) {
+		inode_lock(inode);
+		__cachefiles_unmark_inode_in_use(object, file->f_path.dentry);
+		inode_unlock(inode);
+
+		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
+			atomic_long_add(inode->i_blocks, &cache->b_released);
+			if (atomic_inc_return(&cache->f_released))
+				cachefiles_state_changed(cache);
+		}
+	}
+}
+
 /*
  * get a subdirectory
  */


