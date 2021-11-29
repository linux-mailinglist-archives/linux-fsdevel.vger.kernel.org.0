Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE24461982
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbhK2OjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378218AbhK2OhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIl6S6tLnztbwnZQ+D2ARsxxfs4zSEMjqZeJuEcCUYE=;
        b=QtgcR+9W4Xmqsy0hqAwxzTgTkiMBqzSxrO2fybbKFCphbfFi30PNoeWEx8koDVimUzXAdP
        S8svUO6DMB6j3sPTmNKMJz+LspkaK+DgNtAOqYSVh7Mv1hIdMelR+rCHipO8RDy6nHuBci
        XuAa1Xu3q0H9uLVFSWVp4V96aXa3BFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-ZN8XkOn9OLmvKlAlXSDyhA-1; Mon, 29 Nov 2021 09:33:48 -0500
X-MC-Unique: ZN8XkOn9OLmvKlAlXSDyhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F8D7835E2F;
        Mon, 29 Nov 2021 14:33:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868716060F;
        Mon, 29 Nov 2021 14:33:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 46/64] cachefiles: Mark a backing file in use with an inode
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:33:42 +0000
Message-ID: <163819642273.215744.6414248677118690672.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use an inode flag, S_KERNEL_FILE, to mark that a backing file is in use by
the kernel to prevent cachefiles or other kernel services from interfering
with that file.

Using S_SWAPFILE instead isn't really viable as that has other effects in
the I/O paths.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/internal.h |    2 ++
 fs/cachefiles/namei.c    |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index fbb38d3e6cac..ebb39373716b 100644
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
 					       const char *name);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 25ca41952dab..2e209e403713 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -32,6 +32,18 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
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
@@ -44,6 +56,29 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
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


