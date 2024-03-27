Return-Path: <linux-fsdevel+bounces-15446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2536688E879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFA12A66BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E01411F5;
	Wed, 27 Mar 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6fM3g9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613B1411CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711551859; cv=none; b=oiAZDzEufPmh3mMMsRHoaoqq7XVFMb7EQht8zIhjHS6bvslnKc4JFSskG4DVFCektWvs3reNIR7/0E6CozTppi2zAvACzxXMtQCjFVuuEIbO6uHfzqmj4tGh5XN/wVNj6yLcgkjjX39Bssf6UGXplgBVGF9wY/+E7ylwoCVwqA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711551859; c=relaxed/simple;
	bh=lKYcHiXaapYY9EDdipb2qGnG72rc4km3T4CzGt+fgpQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ECyZLNpOZ2nOqLmc0+2RewfclgTi52I985VCmix5AlDo1/D1Z4lK91WQD1NJr5ARzNof+JcnsjUv/LrljaUGznvplU9QjFG+MD5RuaQ03fTLw+aRBkHITAJHOtPePutRZCIHCFilR2ozkvx00E5hWZdZphe7Xp1iXjcwa2ardl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6fM3g9X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711551855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bWNSBg8at2ybCmMWCY4Y8Gsbxal/bw2ZagDjU70FTzA=;
	b=g6fM3g9X3JnKG7ENbqN6LAkz+26yF6s31eyLqPo5Vo5bwe+e4V0uc5RpIr2hIAFxxJhxxw
	bHr+Zo9VhnrPovSGggRrfaoReyqxWZXjagrUctf3rUZcDjw5sP4CUWUvCvZPKd+Rs2dI6P
	ggqc4iFdwnkMSccsvgNWmxpCAxYpl/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-hpxMHw0oNR6KhiHzPfvrXw-1; Wed, 27 Mar 2024 11:04:12 -0400
X-MC-Unique: hpxMHw0oNR6KhiHzPfvrXw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87AEC801900;
	Wed, 27 Mar 2024 15:04:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0A18492BC9;
	Wed, 27 Mar 2024 15:04:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
    Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>
cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm, netfs: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2318297.1711551844.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 Mar 2024 15:04:04 +0000
Message-ID: <2318298.1711551844@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Implement a replacement for launder_folio[1].  The key feature of
invalidate_inode_pages2() is that it locks each folio individually, unmaps
it to prevent mmap'd accesses interfering and calls the ->launder_folio()
address_space op to flush it.  This has problems: firstly, each folio is
written individually as one or more small writes; secondly, adjacent folio=
s
cannot be added so easily into the laundry; thirdly, it's yet another op t=
o
implement.

Here's a bit of a hacked together solution which should probably be moved
to mm/:

Use the mmap lock to cause future faulting to wait, then unmap all the
folios if we have mmaps, then, conditionally, use ->writepages() to flush
any dirty data back and then discard all pages.  The caller needs to hold =
a
lock to prevent ->write_iter() getting underfoot.

Note that this does not prevent ->read_iter() from accessing the file
whilst we do this since that may operate without locking.

We also have the writeback_control available and so have the opportunity t=
o
set a flag in it to tell the filesystem that we're doing an invalidation.

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
Link: https://lore.kernel.org/r/1668172.1709764777@warthog.procyon.org.uk/=
 [1]
---
 fs/netfs/misc.c       |   56 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/linux/netfs.h |    3 ++
 mm/memory.c           |    3 +-
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index bc1fc54fb724..774ce825fbec 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -250,3 +250,59 @@ bool netfs_release_folio(struct folio *folio, gfp_t g=
fp)
 	return true;
 }
 EXPORT_SYMBOL(netfs_release_folio);
+
+extern void unmap_mapping_range_tree(struct rb_root_cached *root,
+				     pgoff_t first_index,
+				     pgoff_t last_index,
+				     struct zap_details *details);
+
+/**
+ * netfs_invalidate_inode - Invalidate/forcibly write back an inode's pag=
ecache
+ * @inode: The inode to flush
+ * @flush: Set to write back rather than simply invalidate.
+ *
+ * Invalidate all the folios on an inode, possibly writing them back firs=
t.
+ * Whilst the operation is undertaken, the mmap lock is held to prevent
+ * ->fault() from reinstalling the folios.  The caller must hold a lock o=
n the
+ * inode sufficient to prevent ->write_iter() from dirtying more folios.
+ */
+int netfs_invalidate_inode(struct inode *inode, bool flush)
+{
+	struct address_space *mapping =3D inode->i_mapping;
+
+	if (!mapping || !mapping->nrpages)
+		goto out;
+
+	/* Prevent folios from being faulted in. */
+	i_mmap_lock_write(mapping);
+
+	if (!mapping->nrpages)
+		goto unlock;
+
+	/* Assume there are probably PTEs only if there are mmaps. */
+	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))) {
+		struct zap_details details =3D { };
+
+		unmap_mapping_range_tree(&mapping->i_mmap, 0, LLONG_MAX, &details);
+	}
+
+	/* Write back the data if we're asked to. */
+	if (flush) {
+		struct writeback_control wbc =3D {
+			.sync_mode	=3D WB_SYNC_ALL,
+			.nr_to_write	=3D LONG_MAX,
+			.range_start	=3D 0,
+			.range_end	=3D LLONG_MAX,
+		};
+
+		filemap_fdatawrite_wbc(mapping, &wbc);
+	}
+
+	/* Wait for writeback to complete on all folios and discard. */
+	truncate_inode_pages_range(mapping, 0, LLONG_MAX);
+
+unlock:
+	i_mmap_unlock_write(mapping);
+out:
+	return filemap_check_errors(mapping);
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 298552f5122c..40dc34ee291d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -400,6 +400,9 @@ ssize_t netfs_buffered_write_iter_locked(struct kiocb =
*iocb, struct iov_iter *fr
 ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *=
from);
 ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 =

+/* High-level invalidation API */
+int netfs_invalidate_inode(struct inode *inode, bool flush);
+
 /* Address operations API */
 struct readahead_control;
 void netfs_readahead(struct readahead_control *);
diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..106f32c7d7fb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3665,7 +3665,7 @@ static void unmap_mapping_range_vma(struct vm_area_s=
truct *vma,
 	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
 }
 =

-static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
+inline void unmap_mapping_range_tree(struct rb_root_cached *root,
 					    pgoff_t first_index,
 					    pgoff_t last_index,
 					    struct zap_details *details)
@@ -3685,6 +3685,7 @@ static inline void unmap_mapping_range_tree(struct r=
b_root_cached *root,
 				details);
 	}
 }
+EXPORT_SYMBOL_GPL(unmap_mapping_range_tree);
 =

 /**
  * unmap_mapping_folio() - Unmap single folio from processes.


