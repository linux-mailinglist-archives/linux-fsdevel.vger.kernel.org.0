Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D062E47DB79
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbhLVXcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 18:32:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345480AbhLVXcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 18:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XfI7gqBYYhaYDC/XKjIvpYFWGl28/kPgLuT23IL8FM0=;
        b=P1oc1fVNcmVIZHtfMFqVYat+SMIZ+1xPwCeq/Ht5ITBcOmzO4Eysr3D0JhV8keRx+QBIwy
        DJwpt0lMi/Ell/QwZcP0W4whXfeojMil3w0CuJkZV/pKLloyYnSU9rhT9QeTQldHL8uDXE
        fwz8JLVAlRB9FCjxwVDmcKS9tJXP31s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-xqCE2pPyOEe1DQYWm9JOXg-1; Wed, 22 Dec 2021 18:31:58 -0500
X-MC-Unique: xqCE2pPyOEe1DQYWm9JOXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F358042E0;
        Wed, 22 Dec 2021 23:31:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B6667EFC3;
        Wed, 22 Dec 2021 23:31:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 68/68] 9p, afs, ceph, cifs,
 nfs: Use current_is_kswapd() rather than gfpflags_allow_blocking()
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
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
Date:   Wed, 22 Dec 2021 23:31:47 +0000
Message-ID: <164021590773.640689.16777975200823659231.stgit@warthog.procyon.org.uk>
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

In 9p, afs ceph, cifs and nfs, gfpflags_allow_blocking() (which wraps a
test for __GFP_DIRECT_RECLAIM being set) is used to determine if
->releasepage() should wait for the completion of a DIO write to fscache
with something like:

	if (folio_test_fscache(folio)) {
		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
			return false;
		folio_wait_fscache(folio);
	}

Instead, current_is_kswapd() should be used instead.

Note that this is based on a patch originally by Zhaoyang Huang[1].  In
addition to extending it to the other network filesystems and putting it on
top of my fscache rewrite, it also needs to include linux/swap.h in a bunch
of places.  Can current_is_kswapd() be moved to linux/mm.h?

Originally-signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: linux-cachefs@redhat.com
cc: v9fs-developer@lists.sourceforge.net
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/1638952658-20285-1-git-send-email-huangzhaoyang@gmail.com/ [1]
---

 fs/9p/vfs_addr.c |    3 ++-
 fs/afs/file.c    |    3 ++-
 fs/ceph/addr.c   |    3 ++-
 fs/cifs/file.c   |    2 +-
 fs/nfs/fscache.h |    3 ++-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index f3f349f460e5..c72e9f8f5f32 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/idr.h>
 #include <linux/sched.h>
+#include <linux/swap.h>
 #include <linux/uio.h>
 #include <linux/netfs.h>
 #include <net/9p/9p.h>
@@ -143,7 +144,7 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
 		return 0;
 #ifdef CONFIG_9P_FSCACHE
 	if (folio_test_fscache(folio)) {
-		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return 0;
 		folio_wait_fscache(folio);
 	}
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 572063dad0b3..5b98db127a1b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/netfs.h>
 #include "internal.h"
 
@@ -517,7 +518,7 @@ static int afs_releasepage(struct page *page, gfp_t gfp)
 	 * elected to wait */
 #ifdef CONFIG_AFS_FSCACHE
 	if (folio_test_fscache(folio)) {
-		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
 		folio_wait_fscache(folio);
 	}
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e836f8f1d4f8..b3d9459c9bbd 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -4,6 +4,7 @@
 #include <linux/backing-dev.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/swap.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/pagevec.h>
@@ -174,7 +175,7 @@ static int ceph_releasepage(struct page *page, gfp_t gfp)
 		return 0;
 
 	if (PageFsCache(page)) {
-		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return 0;
 		wait_on_page_fscache(page);
 	}
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 22b66ce10115..d872f6fe8e7d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4809,7 +4809,7 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
 	if (PagePrivate(page))
 		return 0;
 	if (PageFsCache(page)) {
-		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
 		wait_on_page_fscache(page);
 	}
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e0220fc40366..25a5c0f82392 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -8,6 +8,7 @@
 #ifndef _NFS_FSCACHE_H
 #define _NFS_FSCACHE_H
 
+#include <linux/swap.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
@@ -52,7 +53,7 @@ extern void __nfs_readpage_to_fscache(struct inode *, struct page *);
 static inline int nfs_fscache_release_page(struct page *page, gfp_t gfp)
 {
 	if (PageFsCache(page)) {
-		if (!gfpflags_allow_blocking(gfp) || !(gfp & __GFP_FS))
+		if (current_is_kswapd() || !(gfp & __GFP_FS))
 			return false;
 		wait_on_page_fscache(page);
 		fscache_note_page_release(nfs_i_fscache(page->mapping->host));


