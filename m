Return-Path: <linux-fsdevel+bounces-13899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F80D875404
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C00288315
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B712C7EB;
	Thu,  7 Mar 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wnq0h7mO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2E12FB15
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828155; cv=none; b=YkimaX2UsDAlbIZNfnunDwaAabSdN3DyP3OPsQn2A0BJZ1D/lgIsGHKhWIVhuvcFicVsg2PWKNCPUzzfu4qf931W6jA93VVObPTaawTNhvZYJ0wo9z5UDucDGxYeQnHs1xzLpfnWm4uddR3SAh62dX1jELHXRDEeaZHP2ps12Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828155; c=relaxed/simple;
	bh=OF3gy9SzyOaeI2t/bY+jBGdJdan/1bfw9NrDzOw0hWI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZgMDzvtNpujOr8mN5M27YFQBgCo1f3JeruIFLSPL9N+ZbDSeGFrTbaGVvrd46TgCxbWm79sPZvNnMfwDREF33M0xSmDjlngWaz9ujNE8/BtuuVJG+6tB7GRdIc5a2d5c/qvUsq1sfk5pgxYO0wTq2gNAS7KD7OAtWl+G01lvJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wnq0h7mO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709828151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Et76IymZiZsyfFbZyBv4jwcv2zyo3UBKmPaoFDfXMXo=;
	b=Wnq0h7mOUGkk0r4Ji6ivYi/mhDvUddH6rz18kwe72UQUZGKSG1sKfAl7XUMh3gxgozN6Z+
	QBQLjTq3tskxsJZDaU30uL4u8ECzmrKSDrfaP1n+JdD++Wr1b8d+lnoYT7cTufyVUB+aF1
	ZAiZHJ22Tk4wplAL4qJ4wnw9KSYJZNY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-u7GkFLqyNkerzYs9G-jYLw-1; Thu, 07 Mar 2024 11:15:49 -0500
X-MC-Unique: u7GkFLqyNkerzYs9G-jYLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0149081B8BE;
	Thu,  7 Mar 2024 16:15:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5591B37FC;
	Thu,  7 Mar 2024 16:15:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1668172.1709764777@warthog.procyon.org.uk>
References: <1668172.1709764777@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] mm: Kill ->launder_folio()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1941113.1709828144.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 16:15:44 +0000
Message-ID: <1941114.1709828144@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

invalidate_inode_pages2_range() and its wrappers are frequently used to
invalidate overlapping folios prior to and after doing direct I/O.  This
calls ->launder_folio() to flush dirty folios out to the backing store,
keeping the folio lock across the I/O - presumably to prevent the folio
from being redirtied and thereby prevent it from being removed.

However...  If we're doing this prior to doing DIO on a file, there may be
nothing preventing an mmapped write from recreating and redirtying the
folio the moment it is removed from the mapping lest the kernel deadlock o=
n
doing DIO to/from a buffer mmapped from the target file.

Further, invalidate_inode_pages2_range() is permitted to fail - and half
the callers don't even check to see if it *did* fail, probably not
unreasonably.

In which case, there's no point doing the laundry there; better to call
something like filemap_fdatawrite() beforehand.  If mmap is going to
interfere, we can't stop it.

There are some other cases in which this is used:

 (1) In fuse_do_setattr(), when the size of a file is changed.  Calling
     invalidate_inode_pages2() here is probably the wrong thing to do as
     the preceding truncate_pagecache() should do the appropriate page
     trimming and this would just seem to reduce performance for no good
     reason.

 (2) In some network filesystems, when the server informs the client of a
     third-party modification to a file, the local pagecache is zapped wit=
h
     invalidate_inode_pages2() rather than invalidate_remote_inode().  The
     former writes back the dirty data whereas the latter retains it plus
     surrounding obsolete data in the same folio.  Maybe this should be
     done by filemap_fdatawrite() followed by invalidate_inode_pages2().

     Possibly, ->page_mkwrite() could be used to hold off mmap writes unti=
l
     remote invalidation-induced writeback is achieved.

 (3) In NFS, this is used to attempt to save the data when some sort of
     fatal error occurs.  It may be sufficient to do a filemap_fdatawrite(=
)
     before calling invalidate_inode_pages2().  nfs_writepages() can
     observe the error state and do the laundering thing.  Again, maybe,
     ->page_mkwrite() could be used to hold off mmap writes until the
     pagecache has been invalidated.

Note that this only affects 9p, afs, cifs, fuse, nfs and orangefs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Matthew Wilcox <willy@infradead.org>
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
 Documentation/filesystems/locking.rst |    8 --
 Documentation/filesystems/vfs.rst     |    6 -
 fs/9p/vfs_addr.c                      |    2 =

 fs/afs/file.c                         |    1 =

 fs/afs/internal.h                     |    1 =

 fs/afs/write.c                        |   10 --
 fs/ceph/file.c                        |    6 -
 fs/fuse/file.c                        |   16 ----
 fs/netfs/buffered_write.c             |   74 --------------------
 fs/netfs/main.c                       |    1 =

 fs/nfs/file.c                         |   23 ------
 fs/nfs/inode.c                        |    4 -
 fs/nfs/nfstrace.h                     |    1 =

 fs/orangefs/inode.c                   |    1 =

 fs/smb/client/file.c                  |  122 ----------------------------=
------
 include/linux/fs.h                    |    1 =

 include/linux/netfs.h                 |    2 =

 include/trace/events/netfs.h          |    3 =

 mm/truncate.c                         |   25 +-----
 19 files changed, 14 insertions(+), 293 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesys=
tems/locking.rst
index d5bf4b6b7509..139554d1ab51 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -262,7 +262,6 @@ prototypes::
 	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count)=
;
 	int (*error_remove_folio)(struct address_space *, struct folio *);
 	int (*swap_activate)(struct swap_info_struct *sis, struct file *f, secto=
r_t *span)
@@ -288,7 +287,6 @@ release_folio:		yes
 free_folio:		yes
 direct_IO:
 migrate_folio:		yes (both)
-launder_folio:		yes
 is_partially_uptodate:	yes
 error_remove_folio:	yes
 swap_activate:		no
@@ -394,12 +392,6 @@ try_to_free_buffers().
 ->free_folio() is called when the kernel has dropped the folio
 from the page cache.
 =

-->launder_folio() may be called prior to releasing a folio if
-it is still found to be dirty. It returns zero if the folio was successfu=
lly
-cleaned, or an error value if not. Note that in order to prevent the foli=
o
-getting mapped back in and redirtied, it needs to be kept locked
-across the entire operation.
-
 ->swap_activate() will be called to prepare the given file for swap.  It
 should perform any validation and preparation necessary to ensure that
 writes can be performed with minimal memory allocation.  It should call
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems=
/vfs.rst
index eebcc0f9e2bc..b2af9ee6515a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -818,7 +818,6 @@ cache in your filesystem.  The following members are d=
efined:
 		ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 		int (*migrate_folio)(struct mapping *, struct folio *dst,
 				struct folio *src, enum migrate_mode);
-		int (*launder_folio) (struct folio *);
 =

 		bool (*is_partially_uptodate) (struct folio *, size_t from,
 					       size_t count);
@@ -1012,11 +1011,6 @@ cache in your filesystem.  The following members ar=
e defined:
 	folio to this function.  migrate_folio should transfer any private
 	data across and update any references that it has to the folio.
 =

-``launder_folio``
-	Called before freeing a folio - it writes back the dirty folio.
-	To prevent redirtying the folio, it is kept locked during the
-	whole operation.
-
 ``is_partially_uptodate``
 	Called by the VM when reading a file through the pagecache when
 	the underlying blocksize is smaller than the size of the folio.
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 047855033d32..5a943c122d83 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -89,7 +89,6 @@ static int v9fs_init_request(struct netfs_io_request *rr=
eq, struct file *file)
 	bool writing =3D (rreq->origin =3D=3D NETFS_READ_FOR_WRITE ||
 			rreq->origin =3D=3D NETFS_WRITEBACK ||
 			rreq->origin =3D=3D NETFS_WRITETHROUGH ||
-			rreq->origin =3D=3D NETFS_LAUNDER_WRITE ||
 			rreq->origin =3D=3D NETFS_UNBUFFERED_WRITE ||
 			rreq->origin =3D=3D NETFS_DIO_WRITE);
 =

@@ -141,7 +140,6 @@ const struct address_space_operations v9fs_addr_operat=
ions =3D {
 	.dirty_folio		=3D netfs_dirty_folio,
 	.release_folio		=3D netfs_release_folio,
 	.invalidate_folio	=3D netfs_invalidate_folio,
-	.launder_folio		=3D netfs_launder_folio,
 	.direct_IO		=3D noop_direct_IO,
 	.writepages		=3D netfs_writepages,
 };
diff --git a/fs/afs/file.c b/fs/afs/file.c
index ef2cc8f565d2..dfd8f60f5e1f 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -54,7 +54,6 @@ const struct address_space_operations afs_file_aops =3D =
{
 	.read_folio	=3D netfs_read_folio,
 	.readahead	=3D netfs_readahead,
 	.dirty_folio	=3D netfs_dirty_folio,
-	.launder_folio	=3D netfs_launder_folio,
 	.release_folio	=3D netfs_release_folio,
 	.invalidate_folio =3D netfs_invalidate_folio,
 	.migrate_folio	=3D filemap_migrate_folio,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 6ce5a612937c..b93aa026daa4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -916,7 +916,6 @@ struct afs_operation {
 			loff_t	pos;
 			loff_t	size;
 			loff_t	i_size;
-			bool	laundering;	/* Laundering page, PG_writeback not set */
 		} store;
 		struct {
 			struct iattr	*attr;
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 74402d95a884..1bc26466eb72 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -75,8 +75,7 @@ static void afs_store_data_success(struct afs_operation =
*op)
 	op->ctime =3D op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	if (!afs_op_error(op)) {
-		if (!op->store.laundering)
-			afs_pages_written_back(vnode, op->store.pos, op->store.size);
+		afs_pages_written_back(vnode, op->store.pos, op->store.size);
 		afs_stat_v(vnode, n_stores);
 		atomic_long_add(op->store.size, &afs_v2net(vnode)->n_store_bytes);
 	}
@@ -91,8 +90,7 @@ static const struct afs_operation_ops afs_store_data_ope=
ration =3D {
 /*
  * write to a file
  */
-static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,=
 loff_t pos,
-			  bool laundering)
+static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter,=
 loff_t pos)
 {
 	struct afs_operation *op;
 	struct afs_wb_key *wbk =3D NULL;
@@ -123,7 +121,6 @@ static int afs_store_data(struct afs_vnode *vnode, str=
uct iov_iter *iter, loff_t
 	op->file[0].modification =3D true;
 	op->store.pos =3D pos;
 	op->store.size =3D size;
-	op->store.laundering =3D laundering;
 	op->flags |=3D AFS_OPERATION_UNINTR;
 	op->ops =3D &afs_store_data_operation;
 =

@@ -168,8 +165,7 @@ static void afs_upload_to_server(struct netfs_io_subre=
quest *subreq)
 	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.coun=
t);
 =

 	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	ret =3D afs_store_data(vnode, &subreq->io_iter, subreq->start,
-			     subreq->rreq->origin =3D=3D NETFS_LAUNDER_WRITE);
+	ret =3D afs_store_data(vnode, &subreq->io_iter, subreq->start);
 	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
 					  false);
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index abe8028d95bf..6af96c154f81 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1450,11 +1450,9 @@ ceph_direct_read_write(struct kiocb *iocb, struct i=
ov_iter *iter,
 =

 		ceph_fscache_invalidate(inode, true);
 =

-		ret2 =3D invalidate_inode_pages2_range(inode->i_mapping,
-					pos >> PAGE_SHIFT,
-					(pos + count - 1) >> PAGE_SHIFT);
+		ret2 =3D kiocb_invalidate_pages(iocb, count);
 		if (ret2 < 0)
-			doutc(cl, "invalidate_inode_pages2_range returned %d\n",
+			doutc(cl, "kiocb_invalidate_pages returned %d\n",
 			      ret2);
 =

 		flags =3D /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..43411f0d3ce1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2393,21 +2393,6 @@ static int fuse_write_end(struct file *file, struct=
 address_space *mapping,
 	return copied;
 }
 =

-static int fuse_launder_folio(struct folio *folio)
-{
-	int err =3D 0;
-	if (folio_clear_dirty_for_io(folio)) {
-		struct inode *inode =3D folio->mapping->host;
-
-		/* Serialize with pending writeback for the same page */
-		fuse_wait_on_page_writeback(inode, folio->index);
-		err =3D fuse_writepage_locked(&folio->page);
-		if (!err)
-			fuse_wait_on_page_writeback(inode, folio->index);
-	}
-	return err;
-}
-
 /*
  * Write back dirty data/metadata now (there may not be any suitable
  * open files later for data)
@@ -3227,7 +3212,6 @@ static const struct address_space_operations fuse_fi=
le_aops  =3D {
 	.readahead	=3D fuse_readahead,
 	.writepage	=3D fuse_writepage,
 	.writepages	=3D fuse_writepages,
-	.launder_folio	=3D fuse_launder_folio,
 	.dirty_folio	=3D filemap_dirty_folio,
 	.bmap		=3D fuse_bmap,
 	.direct_IO	=3D fuse_direct_IO,
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..4bdd427035de 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1181,77 +1181,3 @@ int netfs_writepages(struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_writepages);
-
-/*
- * Deal with the disposition of a laundered folio.
- */
-static void netfs_cleanup_launder_folio(struct netfs_io_request *wreq)
-{
-	if (wreq->error) {
-		pr_notice("R=3D%08x Laundering error %d\n", wreq->debug_id, wreq->error=
);
-		mapping_set_error(wreq->mapping, wreq->error);
-	}
-}
-
-/**
- * netfs_launder_folio - Clean up a dirty folio that's being invalidated
- * @folio: The folio to clean
- *
- * This is called to write back a folio that's being invalidated when an =
inode
- * is getting torn down.  Ideally, writepages would be used instead.
- */
-int netfs_launder_folio(struct folio *folio)
-{
-	struct netfs_io_request *wreq;
-	struct address_space *mapping =3D folio->mapping;
-	struct netfs_folio *finfo =3D netfs_folio_info(folio);
-	struct netfs_group *group =3D netfs_folio_group(folio);
-	struct bio_vec bvec;
-	unsigned long long i_size =3D i_size_read(mapping->host);
-	unsigned long long start =3D folio_pos(folio);
-	size_t offset =3D 0, len;
-	int ret =3D 0;
-
-	if (finfo) {
-		offset =3D finfo->dirty_offset;
-		start +=3D offset;
-		len =3D finfo->dirty_len;
-	} else {
-		len =3D folio_size(folio);
-	}
-	len =3D min_t(unsigned long long, len, i_size - start);
-
-	wreq =3D netfs_alloc_request(mapping, NULL, start, len, NETFS_LAUNDER_WR=
ITE);
-	if (IS_ERR(wreq)) {
-		ret =3D PTR_ERR(wreq);
-		goto out;
-	}
-
-	if (!folio_clear_dirty_for_io(folio))
-		goto out_put;
-
-	trace_netfs_folio(folio, netfs_folio_trace_launder);
-
-	_debug("launder %llx-%llx", start, start + len - 1);
-
-	/* Speculatively write to the cache.  We have to fix this up later if
-	 * the store fails.
-	 */
-	wreq->cleanup =3D netfs_cleanup_launder_folio;
-
-	bvec_set_folio(&bvec, folio, len, offset);
-	iov_iter_bvec(&wreq->iter, ITER_SOURCE, &bvec, 1, len);
-	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	ret =3D netfs_begin_write(wreq, true, netfs_write_trace_launder);
-
-out_put:
-	folio_detach_private(folio);
-	netfs_put_group(group);
-	kfree(finfo);
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-out:
-	folio_wait_fscache(folio);
-	_leave(" =3D %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_launder_folio);
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5e77618a7940..dd4bbdc1a4d0 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,7 +33,6 @@ static const char *netfs_origins[nr__netfs_io_origin] =3D=
 {
 	[NETFS_READ_FOR_WRITE]		=3D "RW",
 	[NETFS_WRITEBACK]		=3D "WB",
 	[NETFS_WRITETHROUGH]		=3D "WT",
-	[NETFS_LAUNDER_WRITE]		=3D "LW",
 	[NETFS_UNBUFFERED_WRITE]	=3D "UW",
 	[NETFS_DIO_READ]		=3D "DR",
 	[NETFS_DIO_WRITE]		=3D "DW",
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8577ccf621f5..6efe0af3ba80 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -484,28 +484,6 @@ static void nfs_check_dirty_writeback(struct folio *f=
olio,
 		*dirty =3D true;
 }
 =

-/*
- * Attempt to clear the private state associated with a page when an erro=
r
- * occurs that requires the cached contents of an inode to be written bac=
k or
- * destroyed
- * - Called if either PG_private or fscache is set on the page
- * - Caller holds page lock
- * - Return 0 if successful, -error otherwise
- */
-static int nfs_launder_folio(struct folio *folio)
-{
-	struct inode *inode =3D folio->mapping->host;
-	int ret;
-
-	dfprintk(PAGECACHE, "NFS: launder_folio(%ld, %llu)\n",
-		inode->i_ino, folio_pos(folio));
-
-	folio_wait_fscache(folio);
-	ret =3D nfs_wb_folio(inode, folio);
-	trace_nfs_launder_folio_done(inode, folio, ret);
-	return ret;
-}
-
 static int nfs_swap_activate(struct swap_info_struct *sis, struct file *f=
ile,
 						sector_t *span)
 {
@@ -564,7 +542,6 @@ const struct address_space_operations nfs_file_aops =3D=
 {
 	.invalidate_folio =3D nfs_invalidate_folio,
 	.release_folio =3D nfs_release_folio,
 	.migrate_folio =3D nfs_migrate_folio,
-	.launder_folio =3D nfs_launder_folio,
 	.is_dirty_writeback =3D nfs_check_dirty_writeback,
 	.error_remove_folio =3D generic_error_remove_folio,
 	.swap_activate =3D nfs_swap_activate,
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..898f65784fae 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1162,8 +1162,10 @@ void nfs_file_clear_open_context(struct file *filp)
 		 * We fatal error on write before. Try to writeback
 		 * every page again.
 		 */
-		if (ctx->error < 0)
+		if (ctx->error < 0) {
+			filemap_fdatawrite(inode->i_mapping);
 			invalidate_inode_pages2(inode->i_mapping);
+		}
 		filp->private_data =3D NULL;
 		put_nfs_open_context_sync(ctx);
 	}
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index afedb449b54f..f0e8c0fb9447 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1039,7 +1039,6 @@ DEFINE_NFS_FOLIO_EVENT(nfs_writeback_folio);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_writeback_folio_done);
 =

 DEFINE_NFS_FOLIO_EVENT(nfs_invalidate_folio);
-DEFINE_NFS_FOLIO_EVENT_DONE(nfs_launder_folio_done);
 =

 TRACE_EVENT(nfs_aop_readahead,
 		TP_PROTO(
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 085912268442..d78876d08175 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -626,7 +626,6 @@ static const struct address_space_operations orangefs_=
address_operations =3D {
 	.invalidate_folio =3D orangefs_invalidate_folio,
 	.release_folio =3D orangefs_release_folio,
 	.free_folio =3D orangefs_free_folio,
-	.launder_folio =3D orangefs_launder_folio,
 	.direct_IO =3D orangefs_direct_IO,
 };
 =

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f391c9b803d8..f5d5efeba5e9 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2561,64 +2561,6 @@ struct cifs_writedata *cifs_writedata_alloc(work_fu=
nc_t complete)
 	return wdata;
 }
 =

-static int cifs_partialpagewrite(struct page *page, unsigned from, unsign=
ed to)
-{
-	struct address_space *mapping =3D page->mapping;
-	loff_t offset =3D (loff_t)page->index << PAGE_SHIFT;
-	char *write_data;
-	int rc =3D -EFAULT;
-	int bytes_written =3D 0;
-	struct inode *inode;
-	struct cifsFileInfo *open_file;
-
-	if (!mapping || !mapping->host)
-		return -EFAULT;
-
-	inode =3D page->mapping->host;
-
-	offset +=3D (loff_t)from;
-	write_data =3D kmap(page);
-	write_data +=3D from;
-
-	if ((to > PAGE_SIZE) || (from > to)) {
-		kunmap(page);
-		return -EIO;
-	}
-
-	/* racing with truncate? */
-	if (offset > mapping->host->i_size) {
-		kunmap(page);
-		return 0; /* don't care */
-	}
-
-	/* check to make sure that we are not extending the file */
-	if (mapping->host->i_size - offset < (loff_t)to)
-		to =3D (unsigned)(mapping->host->i_size - offset);
-
-	rc =3D cifs_get_writable_file(CIFS_I(mapping->host), FIND_WR_ANY,
-				    &open_file);
-	if (!rc) {
-		bytes_written =3D cifs_write(open_file, open_file->pid,
-					   write_data, to - from, &offset);
-		cifsFileInfo_put(open_file);
-		/* Does mm or vfs already set times? */
-		simple_inode_init_ts(inode);
-		if ((bytes_written > 0) && (offset))
-			rc =3D 0;
-		else if (bytes_written < 0)
-			rc =3D bytes_written;
-		else
-			rc =3D -EFAULT;
-	} else {
-		cifs_dbg(FYI, "No writable handle for write page rc=3D%d\n", rc);
-		if (!is_retryable_error(rc))
-			rc =3D -EIO;
-	}
-
-	kunmap(page);
-	return rc;
-}
-
 /*
  * Extend the region to be written back to include subsequent contiguousl=
y
  * dirty pages if possible, but don't sleep while doing so.
@@ -3001,47 +2943,6 @@ static int cifs_writepages(struct address_space *ma=
pping,
 	return ret;
 }
 =

-static int
-cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
-{
-	int rc;
-	unsigned int xid;
-
-	xid =3D get_xid();
-/* BB add check for wbc flags */
-	get_page(page);
-	if (!PageUptodate(page))
-		cifs_dbg(FYI, "ppw - page not up to date\n");
-
-	/*
-	 * Set the "writeback" flag, and clear "dirty" in the radix tree.
-	 *
-	 * A writepage() implementation always needs to do either this,
-	 * or re-dirty the page with "redirty_page_for_writepage()" in
-	 * the case of a failure.
-	 *
-	 * Just unlocking the page will cause the radix tree tag-bits
-	 * to fail to update with the state of the page correctly.
-	 */
-	set_page_writeback(page);
-retry_write:
-	rc =3D cifs_partialpagewrite(page, 0, PAGE_SIZE);
-	if (is_retryable_error(rc)) {
-		if (wbc->sync_mode =3D=3D WB_SYNC_ALL && rc =3D=3D -EAGAIN)
-			goto retry_write;
-		redirty_page_for_writepage(wbc, page);
-	} else if (rc !=3D 0) {
-		SetPageError(page);
-		mapping_set_error(page->mapping, rc);
-	} else {
-		SetPageUptodate(page);
-	}
-	end_page_writeback(page);
-	put_page(page);
-	free_xid(xid);
-	return rc;
-}
-
 static int cifs_write_end(struct file *file, struct address_space *mappin=
g,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
@@ -4858,27 +4759,6 @@ static void cifs_invalidate_folio(struct folio *fol=
io, size_t offset,
 	folio_wait_fscache(folio);
 }
 =

-static int cifs_launder_folio(struct folio *folio)
-{
-	int rc =3D 0;
-	loff_t range_start =3D folio_pos(folio);
-	loff_t range_end =3D range_start + folio_size(folio);
-	struct writeback_control wbc =3D {
-		.sync_mode =3D WB_SYNC_ALL,
-		.nr_to_write =3D 0,
-		.range_start =3D range_start,
-		.range_end =3D range_end,
-	};
-
-	cifs_dbg(FYI, "Launder page: %lu\n", folio->index);
-
-	if (folio_clear_dirty_for_io(folio))
-		rc =3D cifs_writepage_locked(&folio->page, &wbc);
-
-	folio_wait_fscache(folio);
-	return rc;
-}
-
 void cifs_oplock_break(struct work_struct *work)
 {
 	struct cifsFileInfo *cfile =3D container_of(work, struct cifsFileInfo,
@@ -5057,7 +4937,6 @@ const struct address_space_operations cifs_addr_ops =
=3D {
 	.release_folio =3D cifs_release_folio,
 	.direct_IO =3D cifs_direct_io,
 	.invalidate_folio =3D cifs_invalidate_folio,
-	.launder_folio =3D cifs_launder_folio,
 	.migrate_folio =3D filemap_migrate_folio,
 	/*
 	 * TODO: investigate and if useful we could add an is_dirty_writeback
@@ -5080,6 +4959,5 @@ const struct address_space_operations cifs_addr_ops_=
smallbuf =3D {
 	.dirty_folio =3D netfs_dirty_folio,
 	.release_folio =3D cifs_release_folio,
 	.invalidate_folio =3D cifs_invalidate_folio,
-	.launder_folio =3D cifs_launder_folio,
 	.migrate_folio =3D filemap_migrate_folio,
 };
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1fbc72c5f112..ded54555ab30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -432,7 +432,6 @@ struct address_space_operations {
 	 */
 	int (*migrate_folio)(struct address_space *, struct folio *dst,
 			struct folio *src, enum migrate_mode);
-	int (*launder_folio)(struct folio *);
 	bool (*is_partially_uptodate) (struct folio *, size_t from,
 			size_t count);
 	void (*is_dirty_writeback) (struct folio *, bool *dirty, bool *wb);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 100cbb261269..7bd2aeccb299 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -232,7 +232,6 @@ enum netfs_io_origin {
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
-	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
@@ -410,7 +409,6 @@ int netfs_unpin_writeback(struct inode *inode, struct =
writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t le=
ngth);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
-int netfs_launder_folio(struct folio *folio);
 =

 /* VMA operations API. */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *n=
etfs_group);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 447a8c21cf57..57ed767f0230 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -25,7 +25,6 @@
 =

 #define netfs_write_traces					\
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
-	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
 	EM(netfs_write_trace_writeback,		"WRITEBACK")	\
 	E_(netfs_write_trace_writethrough,	"WRITETHRU")
@@ -36,7 +35,6 @@
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
-	EM(NETFS_LAUNDER_WRITE,			"LW")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	E_(NETFS_DIO_WRITE,			"DW")
@@ -131,7 +129,6 @@
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
-	EM(netfs_folio_trace_launder,		"launder")	\
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\
diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..dab17b926991 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -561,10 +561,10 @@ static int invalidate_complete_folio2(struct address=
_space *mapping,
 					struct folio *folio)
 {
 	if (folio->mapping !=3D mapping)
-		return 0;
+		return -EBUSY;
 =

 	if (!filemap_release_folio(folio, GFP_KERNEL))
-		return 0;
+		return -EBUSY;
 =

 	spin_lock(&mapping->host->i_lock);
 	xa_lock_irq(&mapping->i_pages);
@@ -579,20 +579,11 @@ static int invalidate_complete_folio2(struct address=
_space *mapping,
 	spin_unlock(&mapping->host->i_lock);
 =

 	filemap_free_folio(mapping, folio);
-	return 1;
+	return 0;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
 	spin_unlock(&mapping->host->i_lock);
-	return 0;
-}
-
-static int folio_launder(struct address_space *mapping, struct folio *fol=
io)
-{
-	if (!folio_test_dirty(folio))
-		return 0;
-	if (folio->mapping !=3D mapping || mapping->a_ops->launder_folio =3D=3D =
NULL)
-		return 0;
-	return mapping->a_ops->launder_folio(folio);
+	return -EBUSY;
 }
 =

 /**
@@ -657,12 +648,8 @@ int invalidate_inode_pages2_range(struct address_spac=
e *mapping,
 				unmap_mapping_folio(folio);
 			BUG_ON(folio_mapped(folio));
 =

-			ret2 =3D folio_launder(mapping, folio);
-			if (ret2 =3D=3D 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 =3D -EBUSY;
-			}
-			if (ret2 < 0)
+			ret2 =3D invalidate_complete_folio2(mapping, folio);
+			if (ret2)
 				ret =3D ret2;
 			folio_unlock(folio);
 		}


