Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2714321EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhJRPJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232628AbhJRPHo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCtXt/S98B8O04e5eLfCRcYEGlq2GeHKHWlj3+Qmlnw=;
        b=dSG9lLilqzKM9fuQ8O4Fw/z8dv7uwZNHWVctLdMobhbJapuyq3uYQmMdPdB8o6fCXn9UPR
        u3zzA9RmUdNC9Zh2sHS1TN+kX0A0o3XPErCq483N0A7LNWQOSzZIl7Drsz6IxzvQXcVGuX
        EHs1BqZjeQ64TJHnhic2YFiyL5KEDjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-eqeM14vVO2quZOXq8ExUyA-1; Mon, 18 Oct 2021 11:05:29 -0400
X-MC-Unique: eqeM14vVO2quZOXq8ExUyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7272910151E0;
        Mon, 18 Oct 2021 15:05:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A12FE57CA4;
        Mon, 18 Oct 2021 15:05:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 55/67] afs: Skip truncation on the server of data we haven't
 written yet
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
Date:   Mon, 18 Oct 2021 16:05:11 +0100
Message-ID: <163456951186.2614702.16840420880926305225.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't send a truncation RPC to the server if we're only shortening data
that's in the pagecache and is beyond the server's EOF.

Also don't automatically force writeback on setattr, but do wait to store
RPCs that are in the region to be removed on a shortening truncation.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index c4af4fda37dd..4c66a2b86add 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -848,42 +848,67 @@ static const struct afs_operation_ops afs_setattr_operation = {
 int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct iattr *attr)
 {
+	const unsigned int supported =
+		ATTR_SIZE | ATTR_MODE | ATTR_UID | ATTR_GID |
+		ATTR_MTIME | ATTR_MTIME_SET | ATTR_TIMES_SET | ATTR_TOUCH;
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
+	struct inode *inode = &vnode->vfs_inode;
+	loff_t i_size;
 	int ret;
 
 	_enter("{%llx:%llu},{n=%pd},%x",
 	       vnode->fid.vid, vnode->fid.vnode, dentry,
 	       attr->ia_valid);
 
-	if (!(attr->ia_valid & (ATTR_SIZE | ATTR_MODE | ATTR_UID | ATTR_GID |
-				ATTR_MTIME | ATTR_MTIME_SET | ATTR_TIMES_SET |
-				ATTR_TOUCH))) {
+	if (!(attr->ia_valid & supported)) {
 		_leave(" = 0 [unsupported]");
 		return 0;
 	}
 
+	i_size = i_size_read(inode);
 	if (attr->ia_valid & ATTR_SIZE) {
-		if (!S_ISREG(vnode->vfs_inode.i_mode))
+		if (!S_ISREG(inode->i_mode))
 			return -EISDIR;
 
-		ret = inode_newsize_ok(&vnode->vfs_inode, attr->ia_size);
+		ret = inode_newsize_ok(inode, attr->ia_size);
 		if (ret)
 			return ret;
 
-		if (attr->ia_size == i_size_read(&vnode->vfs_inode))
+		if (attr->ia_size == i_size)
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
 	fscache_use_cookie(afs_vnode_cache(vnode), true);
 
-	/* flush any dirty data outstanding on a regular file */
-	if (S_ISREG(vnode->vfs_inode.i_mode))
-		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
-
 	/* Prevent any new writebacks from starting whilst we do this. */
 	down_write(&vnode->validate_lock);
 
+	if ((attr->ia_valid & ATTR_SIZE) && S_ISREG(inode->i_mode)) {
+		loff_t size = attr->ia_size;
+
+		/* Wait for any outstanding writes to the server to complete */
+		loff_t from = min(size, i_size);
+		loff_t to = max(size, i_size);
+		ret = filemap_fdatawait_range(inode->i_mapping, from, to);
+		if (ret < 0)
+			goto out_unlock;
+
+		/* Don't talk to the server if we're just shortening in-memory
+		 * writes that haven't gone to the server yet.
+		 */
+		if (!(attr->ia_valid & (supported & ~ATTR_SIZE & ~ATTR_MTIME)) &&
+		    attr->ia_size < i_size &&
+		    attr->ia_size > vnode->status.size) {
+			truncate_pagecache(inode, attr->ia_size);
+			fscache_resize_cookie(afs_vnode_cache(vnode),
+					      attr->ia_size);
+			i_size_write(inode, attr->ia_size);
+			ret = 0;
+			goto out_unlock;
+		}
+	}
+
 	op = afs_alloc_operation(((attr->ia_valid & ATTR_FILE) ?
 				  afs_file_key(attr->ia_file) : NULL),
 				 vnode->volume);


