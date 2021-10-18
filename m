Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11322432204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhJRPKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232548AbhJRPKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S7tYvoqJuZNp85jt5vuBHAbTrQ0z769O2KLpPImxuDo=;
        b=NRCtYsk9hadMgwj1xeMEmooHEQWHNe76kO20drBjyBYNPizaiSo3piLt+V1oRGbNjGRuRr
        TeVcBRkOmCzUYVtB4cgbXGUPFJbUmRRezeDdr25SUlKv848F8nMbB5VSkC/8M5igJ3HX0W
        yc4tJpPNyUtEvY8EDBZB4+A2jBX9TCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-02JGHUnMOKqBhV6EK9P_0g-1; Mon, 18 Oct 2021 11:07:52 -0400
X-MC-Unique: 02JGHUnMOKqBhV6EK9P_0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 847E780A5C0;
        Mon, 18 Oct 2021 15:07:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB6C5DF56;
        Mon, 18 Oct 2021 15:06:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 59/67] NFS: Convert fscache_enable_cookie and
 fscache_disable_cookie
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Mon, 18 Oct 2021 16:06:59 +0100
Message-ID: <163456961924.2614702.6166404296569864407.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

The new FS-Cache API removes the fscache_enable_cookie() and
fscache_disable_cookie() in favor of the new APIs
fscache_use_cookie() and fscache_unuse_cookie(), so update these
areas as needed.

For NFS, we enable fscache on an inode only if the inode is open
readonly and not if the inode is open for write.  Use the new
APIs and change the existing logic slightly and make a decision
whether to "use" an inode based fscache cookie one time, by gating
the call to fscache_use_cookie() and fscache_unuse_cookie()
by the NFS_INO_FSCACHE flag on the nfs_inode.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna.schumaker@netapp.com>
cc: linux-nfs@vger.kernel.org
---

 fs/nfs/fscache.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 514d50d079a2..5e584f2e84a9 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -285,7 +285,10 @@ void nfs_fscache_clear_inode(struct inode *inode)
 
 	dfprintk(FSCACHE, "NFS: clear cookie (0x%p/0x%p)\n", nfsi, cookie);
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
+	if (test_and_clear_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags)) {
+		nfs_fscache_update_auxdata(&auxdata, nfsi);
+		fscache_unuse_cookie(cookie, &auxdata, NULL);
+	}
 	fscache_relinquish_cookie(cookie, false);
 	nfsi->fscache = NULL;
 }
@@ -325,18 +328,17 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	if (!fscache_cookie_valid(cookie))
 		return;
 
-	nfs_fscache_update_auxdata(&auxdata, nfsi);
-
 	if (inode_is_open_for_write(inode)) {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
-		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
-		fscache_disable_cookie(cookie, &auxdata, true);
+		if (test_and_clear_bit(NFS_INO_FSCACHE, &nfsi->flags)) {
+			dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
+			nfs_fscache_update_auxdata(&auxdata, nfsi);
+			fscache_unuse_cookie(cookie, &auxdata, NULL);
+		}
 	} else {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
-		fscache_enable_cookie(cookie, &auxdata, nfsi->vfs_inode.i_size,
-				      nfs_fscache_can_enable, inode);
-		if (fscache_cookie_enabled(cookie))
-			set_bit(NFS_INO_FSCACHE, &NFS_I(inode)->flags);
+		if (!test_and_set_bit(NFS_INO_FSCACHE, &nfsi->flags)) {
+			dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
+			fscache_use_cookie(cookie, false);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(nfs_fscache_open_file);


