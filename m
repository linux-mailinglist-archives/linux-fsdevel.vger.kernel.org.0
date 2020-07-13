Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E29021DD99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgGMQje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:39:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30181 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730343AbgGMQjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oaCTdM19WMNtk5n7WfsDY0jjk79XuarMYPGTkLXDeKs=;
        b=DsW52XOz5XFGVwY8ILOVu9we4YIZWYWzor2VYKscKUYrofq/jQGRhicjDO1igwhhv+74uq
        +FoPrwizS8VdfZssdyGVSa4ngqjUdDCAhJKVg35HNSCmozPtLV/mXI833AciWWjV8jjJwx
        MqNCKFHXaN6/28hAAw+Jk+GrRC6MYe0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-A6iXCXkrPfe5d0m4hJIjuQ-1; Mon, 13 Jul 2020 12:39:27 -0400
X-MC-Unique: A6iXCXkrPfe5d0m4hJIjuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DE988015CB;
        Mon, 13 Jul 2020 16:39:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C831660BF3;
        Mon, 13 Jul 2020 16:39:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/13] afs: Invoke fscache_resize_cookie() when handling
 ATTR_SIZE for setattr
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:39:18 +0100
Message-ID: <159465835897.1377938.1598226019201611820.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Invoke fscache_resize_cookie() to adjust the size of the backing cache
object when setattr is called with ATTR_SIZE.  This discards any data that
then lies beyond the revised EOF and frees up space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index eab191b9c01d..baaaa5e55f95 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -815,14 +815,19 @@ void afs_evict_inode(struct inode *inode)
 
 static void afs_setattr_success(struct afs_operation *op)
 {
-	struct inode *inode = &op->file[0].vnode->vfs_inode;
+	struct afs_vnode_param *vp = &op->file[0];
+	struct inode *inode = &vp->vnode->vfs_inode;
 
-	afs_vnode_commit_status(op, &op->file[0]);
+	afs_vnode_commit_status(op, vp);
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
 		loff_t i_size = inode->i_size, size = op->setattr.attr->ia_size;
+
 		if (size > i_size)
 			pagecache_isize_extended(inode, i_size, size);
 		truncate_pagecache(inode, size);
+
+		fscache_resize_cookie(afs_vnode_cache(vp->vnode),
+				      vp->scb.status.size);
 	}
 }
 
@@ -864,6 +869,8 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(vnode), true);
+
 	/* flush any dirty data outstanding on a regular file */
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
@@ -871,8 +878,10 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	op = afs_alloc_operation(((attr->ia_valid & ATTR_FILE) ?
 				  afs_file_key(attr->ia_file) : NULL),
 				 vnode->volume);
-	if (IS_ERR(op))
-		return PTR_ERR(op);
+	if (IS_ERR(op)) {
+		ret = PTR_ERR(op);
+		goto error_unuse;
+	}
 
 	afs_op_set_vnode(op, 0, vnode);
 	op->setattr.attr = attr;
@@ -885,5 +894,10 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	op->file[0].update_ctime = 1;
 
 	op->ops = &afs_setattr_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+
+error_unuse:
+	fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
+	_leave(" = %d", ret);
+	return ret;
 }


