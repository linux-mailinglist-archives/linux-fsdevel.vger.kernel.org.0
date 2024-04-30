Return-Path: <linux-fsdevel+bounces-18332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735338B782B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 813C3B23887
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0A181302;
	Tue, 30 Apr 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZdvyZ4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE4180A84
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485702; cv=none; b=CIz//2fUvqc8EPqF69T9ukjlEPyuJSjlG3ntmdQ3/nKqfB88ZDDVvLZaEy1T61AEFYzCEInHz4e6GLakzwiRbmJuBSryZJn/xy3VQhyctRBRUsFwIMxyvyEqWnk4JMJl/IEmJ8Z3hRCm/FnlkypgaUJADMM6R6Z8vN1opbnocaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485702; c=relaxed/simple;
	bh=3HD9QQ4J9i0DEnSvYhrZ9Tvedy7p3udCVmpxmS+rga4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP90LSF8V9NBVBWd0LgVJFCDocFPdgLVMg3+OlbaQZ/pTC/62yWISOLAiO6EnZucLOLVDKDUOrfVF0g9lZAyTFqfbHh7QV1IcEXHsgn9gZGDRablspLjjWvMg+s1Z31jQnQlnXfG+d6f3L87EUOSDUXL09A5YN2rng9NxGDpRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZdvyZ4O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fSmTGGISerpaaT9aJOrv4cy/yLYw7vFSX4krrCAu5wI=;
	b=AZdvyZ4OCrqJbGdqePZCvsbrLf/uwX5oLEOFhL+asABuiV9cXuwUXHD6RJuE9WuqpwYTOE
	0V2URLoHOn4H5bJ6pjISHyJ2c4iseTxToD/5URpbB9BzojN9jn7Ip5iZe/7Tw1NDZZ/1EQ
	4BUaBPFcd1BW6pi3NvAfhM72QSK7JSk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-dQcRgBBrN6WTDH9brex0BA-1; Tue,
 30 Apr 2024 10:01:34 -0400
X-MC-Unique: dQcRgBBrN6WTDH9brex0BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E49C29AC01C;
	Tue, 30 Apr 2024 14:01:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FC0020128EF;
	Tue, 30 Apr 2024 14:01:28 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH v2 07/22] mm: Provide a means of invalidation without using launder_folio
Date: Tue, 30 Apr 2024 15:00:38 +0100
Message-ID: <20240430140056.261997-8-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Implement a replacement for launder_folio.  The key feature of
invalidate_inode_pages2() is that it locks each folio individually, unmaps
it to prevent mmap'd accesses interfering and calls the ->launder_folio()
address_space op to flush it.  This has problems: firstly, each folio is
written individually as one or more small writes; secondly, adjacent folios
cannot be added so easily into the laundry; thirdly, it's yet another op to
implement.

Instead, use the invalidate lock to cause anyone wanting to add a folio to
the inode to wait, then unmap all the folios if we have mmaps, then,
conditionally, use ->writepages() to flush any dirty data back and then
discard all pages.

The invalidate lock prevents ->read_iter(), ->write_iter() and faulting
through mmap all from adding pages for the duration.

This is then used from netfslib to handle the flusing in unbuffered and
direct writes.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: devel@lists.orangefs.org
---

Notes:
    Changes
    =======
    ver #2)
     - Make filemap_invalidate_inode() take a range.
     - Make netfs_unbuffered_write_iter() use filemap_invalidate_inode().

 fs/netfs/direct_write.c | 28 ++++++++++++++++++---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 54 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index bee047e20f5d..2b81cd4aae6e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -132,12 +132,14 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	struct netfs_inode *ictx = netfs_inode(inode);
-	unsigned long long end;
 	ssize_t ret;
+	loff_t pos = iocb->ki_pos;
+	unsigned long long end = pos + iov_iter_count(from) - 1;
 
-	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+	_enter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
 
 	if (!iov_iter_count(from))
 		return 0;
@@ -157,7 +159,25 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ret = file_update_time(file);
 	if (ret < 0)
 		goto out;
-	ret = kiocb_invalidate_pages(iocb, iov_iter_count(from));
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		/* We could block if there are any pages in the range. */
+		ret = -EAGAIN;
+		if (filemap_range_has_page(mapping, pos, end))
+			if (filemap_invalidate_inode(inode, true, pos, end))
+				goto out;
+	} else {
+		ret = filemap_write_and_wait_range(mapping, pos, end);
+		if (ret < 0)
+			goto out;
+	}
+
+	/*
+	 * After a write we want buffered reads to be sure to go to disk to get
+	 * the new data.  We invalidate clean cached page from the region we're
+	 * about to write.  We do this *before* the write so that we can return
+	 * without clobbering -EIOCBQUEUED from ->direct_IO().
+	 */
+	ret = filemap_invalidate_inode(inode, true, pos, end);
 	if (ret < 0)
 		goto out;
 	end = iocb->ki_pos + iov_iter_count(from);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2df35e65557d..c5e33e2ca48a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -40,6 +40,8 @@ int filemap_fdatawait_keep_errors(struct address_space *mapping);
 int filemap_fdatawait_range(struct address_space *, loff_t lstart, loff_t lend);
 int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
 		loff_t start_byte, loff_t end_byte);
+int filemap_invalidate_inode(struct inode *inode, bool flush,
+			     loff_t start, loff_t end);
 
 static inline int filemap_fdatawait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 9a2e28bf298a..53516305b4b4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4134,6 +4134,60 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 }
 EXPORT_SYMBOL(filemap_release_folio);
 
+/**
+ * filemap_invalidate_inode - Invalidate/forcibly write back a range of an inode's pagecache
+ * @inode: The inode to flush
+ * @flush: Set to write back rather than simply invalidate.
+ * @start: First byte to in range.
+ * @end: Last byte in range (inclusive), or LLONG_MAX for everything from start
+ *       onwards.
+ *
+ * Invalidate all the folios on an inode that contribute to the specified
+ * range, possibly writing them back first.  Whilst the operation is
+ * undertaken, the invalidate lock is held to prevent new folios from being
+ * installed.
+ */
+int filemap_invalidate_inode(struct inode *inode, bool flush,
+			     loff_t start, loff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t first = start >> PAGE_SHIFT;
+	pgoff_t last = end >> PAGE_SHIFT;
+	pgoff_t nr = end == LLONG_MAX ? ULONG_MAX : last - first + 1;
+
+	if (!mapping || !mapping->nrpages || end < start)
+		goto out;
+
+	/* Prevent new folios from being added to the inode. */
+	filemap_invalidate_lock(mapping);
+
+	if (!mapping->nrpages)
+		goto unlock;
+
+	unmap_mapping_pages(mapping, first, nr, false);
+
+	/* Write back the data if we're asked to. */
+	if (flush) {
+		struct writeback_control wbc = {
+			.sync_mode	= WB_SYNC_ALL,
+			.nr_to_write	= LONG_MAX,
+			.range_start	= first,
+			.range_end	= last,
+		};
+
+		filemap_fdatawrite_wbc(mapping, &wbc);
+	}
+
+	/* Wait for writeback to complete on all folios and discard. */
+	truncate_inode_pages_range(mapping, first, last);
+
+unlock:
+	filemap_invalidate_unlock(mapping);
+out:
+	return filemap_check_errors(mapping);
+}
+EXPORT_SYMBOL(filemap_invalidate_inode);
+
 #ifdef CONFIG_CACHESTAT_SYSCALL
 /**
  * filemap_cachestat() - compute the page cache statistics of a mapping


