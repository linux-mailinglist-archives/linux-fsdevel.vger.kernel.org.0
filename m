Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812801C4222
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgEDRQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:16:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730442AbgEDRQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LhWlx2Ll5MCOg+oPWlbdnb6jX8iPT9XI75bmO3tipj0=;
        b=YlKfCjXPamyY83UjGpMF3TNXFRqkEu8MLXeZV9HdS+Feq+UVOq6CecCtf6NkGd+Vtp9RVe
        VjgFd+IgplQC2u66rclYpjtkbJn87ZLuuOGUdSAo4Xdo6fKiqe7KqM+E7qwOZB71IrWvLc
        S5Zs5ifzPs7V6Iln6t+Blsgq3wVj/Sw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-EGtm6iJ_NgCUhQWQql-cVA-1; Mon, 04 May 2020 13:16:20 -0400
X-MC-Unique: EGtm6iJ_NgCUhQWQql-cVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C188B107B270;
        Mon,  4 May 2020 17:16:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700715C1B2;
        Mon,  4 May 2020 17:16:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 57/61] afs: Invoke fscache_resize_cookie() when handling
 ATTR_SIZE for setattr
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:16:07 +0100
Message-ID: <158861256762.340223.10583346645344676649.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Invoke fscache_resize_cookie() to adjust the size of the backing cache
object when setattr is called with ATTR_SIZE.  This discards any data that
then lies beyond the revised EOF and frees up space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 59dc179b40cb..21a48ab74d2b 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -838,6 +838,8 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!scb)
 		goto error;
 
+	fscache_use_cookie(afs_vnode_cache(vnode), true);
+
 	/* flush any dirty data outstanding on a regular file */
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
@@ -848,7 +850,7 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 		key = afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
-			goto error_scb;
+			goto error_unuse;
 		}
 	}
 
@@ -873,7 +875,11 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(attr->ia_valid & ATTR_FILE))
 		key_put(key);
 
-error_scb:
+	if ((attr->ia_valid & ATTR_SIZE) && ret == 0)
+		fscache_resize_cookie(afs_vnode_cache(vnode), scb->status.size);
+
+error_unuse:
+	fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
 	kfree(scb);
 error:
 	_leave(" = %d", ret);


