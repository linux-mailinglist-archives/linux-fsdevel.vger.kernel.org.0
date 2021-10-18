Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5B432229
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhJRPLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 11:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233405AbhJRPKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634569716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtI7Re191AUvPZ/vtkvuZ2gD0a/mQddwHsEF9A3Bt0M=;
        b=hGhKj+i8c+gXQC5UuKrIVw/V3fLLb0/EbkkU0NTKyhAWBhT+cxFDS3jXHB1Pjl2vDvhs1e
        kClpm2HfYcZ6O77oACtmqXoJkyd/yTLvMRF/A+vf4VA1vapNStU/RwW+vZQ4qHoNzx2o9v
        /tzWD4whscLb5eKDGgckb5IiqAl+XXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-vP4jBK5XNHiQwY3ewo9Qbg-1; Mon, 18 Oct 2021 11:08:31 -0400
X-MC-Unique: vP4jBK5XNHiQwY3ewo9Qbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05D99107B27D;
        Mon, 18 Oct 2021 15:08:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8060E60D30;
        Mon, 18 Oct 2021 15:08:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 63/67] 9p: Copy local writes to the cache when writing to the
 server
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net, dhowells@redhat.com,
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
Date:   Mon, 18 Oct 2021 16:08:24 +0100
Message-ID: <163456970473.2614702.16723673129113194320.stgit@warthog.procyon.org.uk>
In-Reply-To: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
References: <163456861570.2614702.14754548462706508617.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When writing to the server from v9fs_vfs_writepage(), copy the data to the
cache object too.

To make this possible, the cookie must have its active users count
incremented when the page is dirtied and kept incremented until we manage
to clean up all the pages.  This allows the writeback to take place after
the last file struct is released.

This is done by taking a use on the cookie in v9fs_set_page_dirty() if we
haven't already done so (controlled by the I_PINNING_FSCACHE_WB flag) and
dropping the pin in v9fs_write_inode() if __writeback_single_inode() clears
all the outstanding dirty pages (conveyed by the unpinned_fscache_wb flag
in the writeback_control struct).

Inode eviction must also clear the flag after truncating away all the
outstanding pages.

In the future this will be handled more gracefully by netfslib.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@gmail.com>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: v9fs-developer@lists.sourceforge.net
---

 fs/9p/vfs_addr.c  |   53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/9p/vfs_inode.c |    2 ++
 fs/9p/vfs_super.c |    3 +++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index de857fa4629b..2d1577538cde 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -132,15 +132,17 @@ static void v9fs_vfs_readahead(struct readahead_control *ractl)
 
 static int v9fs_release_page(struct page *page, gfp_t gfp)
 {
+	struct inode *inode = page->mapping->host;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+
 	if (PagePrivate(page))
 		return 0;
-#ifdef CONFIG_9P_FSCACHE
 	if (PageFsCache(page)) {
 		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
 			return 0;
 		wait_on_page_fscache(page);
 	}
-#endif
+	fscache_note_page_release(v9fs_inode_cookie(v9inode));
 	return 1;
 }
 
@@ -157,10 +159,23 @@ static void v9fs_invalidate_page(struct page *page, unsigned int offset,
 	wait_on_page_fscache(page);
 }
 
+static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
+				     bool was_async)
+{
+	struct v9fs_inode *v9inode = priv;
+
+	if (IS_ERR_VALUE(transferred_or_error) &&
+	    transferred_or_error != -ENOBUFS)
+		fscache_invalidate(v9fs_inode_cookie(v9inode),
+				   &v9inode->qid.version,
+				   i_size_read(&v9inode->vfs_inode), 0);
+}
+
 static int v9fs_vfs_writepage_locked(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct fscache_cookie *cookie = v9fs_inode_cookie(v9inode);
 	loff_t start = page_offset(page);
 	loff_t size = i_size_read(inode);
 	struct iov_iter from;
@@ -176,10 +191,21 @@ static int v9fs_vfs_writepage_locked(struct page *page)
 	/* We should have writeback_fid always set */
 	BUG_ON(!v9inode->writeback_fid);
 
+	wait_on_page_fscache(page);
+
 	set_page_writeback(page);
 
 	p9_client_write(v9inode->writeback_fid, start, &from, &err);
 
+	if (err == 0 &&
+	    fscache_cookie_enabled(cookie) &&
+	    test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
+		set_page_fscache(page);
+		fscache_write_to_cache(v9fs_inode_cookie(v9inode),
+				       page->mapping, start, len, size,
+				       v9fs_write_to_cache_done, v9inode);
+	}
+
 	end_page_writeback(page);
 	return err;
 }
@@ -290,10 +316,12 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 
 static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 			  loff_t pos, unsigned len, unsigned copied,
-			  struct page *page, void *fsdata)
+			  struct page *subpage, void *fsdata)
 {
+	struct page *page = thp_head(subpage);
 	loff_t last_pos = pos + copied;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = mapping->host;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 
 	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
 
@@ -313,6 +341,7 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	if (last_pos > inode->i_size) {
 		inode_add_bytes(inode, last_pos - inode->i_size);
 		i_size_write(inode, last_pos);
+		fscache_update_cookie(v9fs_inode_cookie(v9inode), NULL, &last_pos);
 	}
 	set_page_dirty(page);
 out:
@@ -322,11 +351,25 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	return copied;
 }
 
+#ifdef CONFIG_9P_FSCACHE
+/*
+ * Mark a page as having been made dirty and thus needing writeback.  We also
+ * need to pin the cache object to write back to.
+ */
+static int v9fs_set_page_dirty(struct page *page)
+{
+	struct v9fs_inode *v9inode = V9FS_I(page->mapping->host);
+
+	return fscache_set_page_dirty(page, v9fs_inode_cookie(v9inode));
+}
+#else
+#define v9fs_set_page_dirty __set_page_dirty_nobuffers
+#endif
 
 const struct address_space_operations v9fs_addr_operations = {
 	.readpage = v9fs_vfs_readpage,
 	.readahead = v9fs_vfs_readahead,
-	.set_page_dirty = __set_page_dirty_nobuffers,
+	.set_page_dirty = v9fs_set_page_dirty,
 	.writepage = v9fs_vfs_writepage,
 	.write_begin = v9fs_write_begin,
 	.write_end = v9fs_write_end,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 83db37bd4252..a990c50cc27d 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -377,6 +377,8 @@ void v9fs_evict_inode(struct inode *inode)
 	struct v9fs_inode *v9inode = V9FS_I(inode);
 
 	truncate_inode_pages_final(&inode->i_data);
+	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
+				      &v9inode->qid.version);
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);
 
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 5fce6e30bc5a..3721098e0992 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/magic.h>
+#include <linux/fscache.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -307,6 +308,7 @@ static int v9fs_write_inode(struct inode *inode,
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 		return ret;
 	}
+	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
 	return 0;
 }
 
@@ -330,6 +332,7 @@ static int v9fs_write_inode_dotl(struct inode *inode,
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 		return ret;
 	}
+	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
 	return 0;
 }
 


