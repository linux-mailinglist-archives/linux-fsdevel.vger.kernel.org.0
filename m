Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C6346CD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhCWWZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234401AbhCWWX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616538207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzyDRjNln59tYvqxcGyAAjCd5GRakMWrJZ3j1Fuw07M=;
        b=JUHzEt27D5Q+XsDnHmQQt8gQdUrTJRE0oS2NL3MP/G/A5taeJlFttMMSFOTw+wtfcATaFk
        kqY79yg2M16knEcDN6c99TGk/6EJfqiHyt6VQg3pqOkr/x+tPlW9qa6XCBaSkgEBnAa64E
        PPDmtbbQBn4ZdSi7gCjxguAhGyiomTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-wdCXXR0NNYm7LB0fSsBiqw-1; Tue, 23 Mar 2021 18:23:23 -0400
X-MC-Unique: wdCXXR0NNYm7LB0fSsBiqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548001853022;
        Tue, 23 Mar 2021 22:23:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B65596087C;
        Tue, 23 Mar 2021 22:23:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 28/28] afs: Use the fscache_write_begin() helper
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:23:12 +0000
Message-ID: <161653819291.2770958.406013201547420544.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make AFS use the new fscache_write_begin() helper to do the pre-reading
required before the write.  If successful, the helper returns with the
required page filled in and locked.  It may read more than just one page,
expanding the read to meet cache granularity requirements as necessary.

Note: A more advanced version of this could be made that does
generic_perform_write() for a whole cache granule.  This would make it
easier to avoid doing the download/read for the data to be overwritten.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588546422.3465195.1546354372589291098.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161539563244.286939.16537296241609909980.stgit@warthog.procyon.org.uk/ # v4
---

 fs/afs/file.c     |   19 +++++++++
 fs/afs/internal.h |    1 
 fs/afs/write.c    |  108 ++++++-----------------------------------------------
 3 files changed, 31 insertions(+), 97 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 99bb4649a306..cf2b664a68a5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -334,6 +334,13 @@ static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
 	rreq->netfs_priv = key_get(afs_file_key(file));
 }
 
+static bool afs_is_cache_enabled(struct inode *inode)
+{
+	struct fscache_cookie *cookie = afs_vnode_cache(AFS_FS_I(inode));
+
+	return fscache_cookie_enabled(cookie) && !hlist_empty(&cookie->backing_objects);
+}
+
 static int afs_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
@@ -341,14 +348,24 @@ static int afs_begin_cache_operation(struct netfs_read_request *rreq)
 	return fscache_begin_read_operation(rreq, afs_vnode_cache(vnode));
 }
 
+static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
+				 struct page *page, void **_fsdata)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+
+	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
+}
+
 static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 {
 	key_put(netfs_priv);
 }
 
-static const struct netfs_read_request_ops afs_req_ops = {
+const struct netfs_read_request_ops afs_req_ops = {
 	.init_rreq		= afs_init_rreq,
+	.is_cache_enabled	= afs_is_cache_enabled,
 	.begin_cache_operation	= afs_begin_cache_operation,
+	.check_write_begin	= afs_check_write_begin,
 	.issue_op		= afs_req_issue_op,
 	.cleanup		= afs_priv_cleanup,
 };
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 96b33d2e3116..9f4040724318 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1045,6 +1045,7 @@ extern void afs_dynroot_depopulate(struct super_block *);
 extern const struct address_space_operations afs_fs_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
+extern const struct netfs_read_request_ops afs_req_ops;
 
 extern int afs_cache_wb_key(struct afs_vnode *, struct afs_file *);
 extern void afs_put_wb_key(struct afs_wb_key *);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index f55b48e2db29..f0f0496f1a7b 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -11,6 +11,8 @@
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
+#include <linux/netfs.h>
+#include <linux/fscache.h>
 #include "internal.h"
 
 /*
@@ -22,68 +24,6 @@ int afs_set_page_dirty(struct page *page)
 	return __set_page_dirty_nobuffers(page);
 }
 
-/*
- * Handle completion of a read operation to fill a page.
- */
-static void afs_fill_hole(struct afs_read *req)
-{
-	if (iov_iter_count(req->iter) > 0)
-		/* The read was short - clear the excess buffer. */
-		iov_iter_zero(iov_iter_count(req->iter), req->iter);
-}
-
-/*
- * partly or wholly fill a page that's under preparation for writing
- */
-static int afs_fill_page(struct file *file,
-			 loff_t pos, unsigned int len, struct page *page)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct afs_read *req;
-	size_t p;
-	void *data;
-	int ret;
-
-	_enter(",,%llu", (unsigned long long)pos);
-
-	if (pos >= vnode->vfs_inode.i_size) {
-		p = pos & ~PAGE_MASK;
-		ASSERTCMP(p + len, <=, PAGE_SIZE);
-		data = kmap(page);
-		memset(data + p, 0, len);
-		kunmap(page);
-		return 0;
-	}
-
-	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	refcount_set(&req->usage, 1);
-	req->vnode	= vnode;
-	req->done	= afs_fill_hole;
-	req->key	= key_get(afs_file_key(file));
-	req->pos	= pos;
-	req->len	= len;
-	req->nr_pages	= 1;
-	req->iter	= &req->def_iter;
-	iov_iter_xarray(&req->def_iter, READ, &file->f_mapping->i_pages, pos, len);
-
-	ret = afs_fetch_data(vnode, req);
-	afs_put_read(req);
-	if (ret < 0) {
-		if (ret == -ENOENT) {
-			_debug("got NOENT from server"
-			       " - marking file deleted and stale");
-			set_bit(AFS_VNODE_DELETED, &vnode->flags);
-			ret = -ESTALE;
-		}
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * prepare to perform part of a write to a page
  */
@@ -102,24 +42,14 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	_enter("{%llx:%llu},%llx,%x",
 	       vnode->fid.vid, vnode->fid.vnode, pos, len);
 
-	page = grab_cache_page_write_begin(mapping, pos / PAGE_SIZE, flags);
-	if (!page)
-		return -ENOMEM;
-
-	if (!PageUptodate(page) && len != PAGE_SIZE) {
-		ret = afs_fill_page(file, pos & PAGE_MASK, PAGE_SIZE, page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
-			_leave(" = %d [prep]", ret);
-			return ret;
-		}
-		SetPageUptodate(page);
-	}
-
-#ifdef CONFIG_AFS_FSCACHE
-	wait_on_page_fscache(page);
-#endif
+	/* Prefetch area to be written into the cache if we're caching this
+	 * file.  We need to do this before we get a lock on the page in case
+	 * there's more than one writer competing for the same cache block.
+	 */
+	ret = netfs_write_begin(file, mapping, pos, len, flags, &page, fsdata,
+				&afs_req_ops, NULL);
+	if (ret < 0)
+		return ret;
 
 	index = page->index;
 	from = pos - index * PAGE_SIZE;
@@ -184,7 +114,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 	unsigned int f, from = pos & (thp_size(page) - 1);
 	unsigned int t, to = from + copied;
 	loff_t i_size, maybe_i_size;
-	int ret = 0;
 
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
@@ -203,19 +132,7 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_sequnlock(&vnode->cb_lock);
 	}
 
-	if (!PageUptodate(page)) {
-		if (copied < len) {
-			/* Try and load any missing data from the server.  The
-			 * unmarshalling routine will take care of clearing any
-			 * bits that are beyond the EOF.
-			 */
-			ret = afs_fill_page(file, pos + copied,
-					    len - copied, page);
-			if (ret < 0)
-				goto out;
-		}
-		SetPageUptodate(page);
-	}
+	ASSERT(PageUptodate(page));
 
 	if (PagePrivate(page)) {
 		priv = page_private(page);
@@ -236,12 +153,11 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 
 	if (set_page_dirty(page))
 		_debug("dirtied %lx", page->index);
-	ret = copied;
 
 out:
 	unlock_page(page);
 	put_page(page);
-	return ret;
+	return copied;
 }
 
 /*


