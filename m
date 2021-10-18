Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30B6432115
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhJRPBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhJRPBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K5FTLf3BYt9yC5gnmuuFov8Yi7OVdM9eRPeEUyTv68E=;
        b=B0ELvZRJNt5Rq7J2VGIl7cEtBzP6PNlKDDBZlBGT7YWUJQAYRLsSJNffwq6p2kDVQkzJGr
        H6MIDfD2gl09p1zb370I+F27yuaIDjbDhz5pXI8n8iJx98kfu6KiBsZuHlovrT8ApsMXf4
        DIDWO2Bh7l/KSgYmX9L5oYEw+9FcxZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-j8jdinTONVS7GUILmqYu9Q-1; Mon, 18 Oct 2021 10:58:48 -0400
X-MC-Unique: j8jdinTONVS7GUILmqYu9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E3E991278;
        Mon, 18 Oct 2021 14:58:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B9076788F;
        Mon, 18 Oct 2021 14:58:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/67] cachefiles: Round the cachefile size up to DIO block
 size
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Oct 2021 15:58:04 +0100
Message-ID: <163456908429.2614702.18199815281243741948.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Round the size of a cachefile up to DIO block size so that we can always
read back the last partial page of a file using direct I/O.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/bind.c      |    3 ++-
 fs/cachefiles/interface.c |    2 ++
 fs/cachefiles/internal.h  |    2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/bind.c b/fs/cachefiles/bind.c
index af7386ad14af..4ea8c93e14d8 100644
--- a/fs/cachefiles/bind.c
+++ b/fs/cachefiles/bind.c
@@ -126,7 +126,8 @@ static int cachefiles_daemon_add_cache(struct cachefiles_cache *cache)
 	    !d_backing_inode(root)->i_op->mkdir ||
 	    !(d_backing_inode(root)->i_opflags & IOP_XATTR) ||
 	    !root->d_sb->s_op->statfs ||
-	    !root->d_sb->s_op->sync_fs)
+	    !root->d_sb->s_op->sync_fs ||
+	    root->d_sb->s_blocksize > PAGE_SIZE)
 		goto error_unsupported;
 
 	ret = -EROFS;
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 8f98e5c27d66..3e678ab14c85 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -268,6 +268,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 	int ret;
 
 	ni_size = object->cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	_enter("{OBJ%x},[%llu]",
 	       object->debug_id, (unsigned long long) ni_size);
@@ -346,6 +347,7 @@ static void cachefiles_invalidate_object(struct cachefiles_object *object)
 				       cachefiles_trunc_invalidate);
 		ret = vfs_truncate(&file->f_path, 0);
 		if (ret == 0) {
+			ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 			trace_cachefiles_trunc(object, file_inode(file),
 					       0, ni_size,
 					       cachefiles_trunc_set_size);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4705f968e661..ff00c5249f4f 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,8 @@
 #include <linux/workqueue.h>
 #include <linux/security.h>
 
+#define CACHEFILES_DIO_BLOCK_SIZE 4096
+
 struct cachefiles_cache;
 struct cachefiles_object;
 


