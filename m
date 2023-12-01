Return-Path: <linux-fsdevel+bounces-4529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047680004E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C582816A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B471CA84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCC9UBRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC3133
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701390136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2yTYr3KftluiwYoCkfMV91Sd6LolaqDTMgOggSylC8E=;
	b=CCC9UBRaqbB0K/G2LNfSyJ24D4upG18BMxu8mHwYldIL23HvN6mFMbPbgrD3/3XzOr12tY
	14D05EQgvR4N4QpDpYr1W+m/9gbU48JPukPVx4/PGhix2NJvXyW39kOfQdlC8xhTBZUoMO
	lfiSgayL/vvWdNkJhf2kYwT6qBReEyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-mReTnv-1MCGaXfLSS9L65Q-1; Thu, 30 Nov 2023 19:22:12 -0500
X-MC-Unique: mReTnv-1MCGaXfLSS9L65Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95331814086;
	Fri,  1 Dec 2023 00:22:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05280492BFC;
	Fri,  1 Dec 2023 00:22:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] cifs: Fix flushing, invalidation and file size with FICLONE
Date: Fri,  1 Dec 2023 00:22:01 +0000
Message-ID: <20231201002201.2981258-3-dhowells@redhat.com>
In-Reply-To: <20231201002201.2981258-1-dhowells@redhat.com>
References: <20231201002201.2981258-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Fix a number of issues in the cifs filesystem implementation of the FICLONE
ioctl in cifs_remap_file_range().  This is analogous to the previously
fixed bug in cifs_file_copychunk_range() and can share the helper
functions.

Firstly, the invalidation of the destination range is handled incorrectly:
We shouldn't just invalidate the whole file as dirty data in the file may
get lost and we can't just call truncate_inode_pages_range() to invalidate
the destination range as that will erase parts of a partial folio at each
end whilst invalidating and discarding all the folios in the middle.  We
need to force all the folios covering the range to be reloaded, but we
mustn't lose dirty data in them that's not in the destination range.

Further, we shouldn't simply round out the range to PAGE_SIZE at each end
as cifs should move to support multipage folios.

Secondly, there's an issue whereby a write may have extended the file
locally, but not have been written back yet.  This can leaves the local
idea of the EOF at a later point than the server's EOF.  If a clone request
is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
(which gets translated to -EIO locally) if the clone source extends past
the server's EOF.

Fix this by:

 (0) Flush the source region (already done).  The flush does nothing and
     the EOF isn't moved if the source region has no dirty data.

 (1) Move the EOF to the end of the source region if it isn't already at
     least at this point.  If we can't do this, for instance if the server
     doesn't support it, just flush the entire source file.

 (2) Find the folio (if present) at each end of the range, flushing it and
     increasing the region-to-be-invalidated to cover those in their
     entirety.

 (3) Fully discard all the folios covering the range as we want them to be
     reloaded.

 (4) Then perform the extent duplication.

Thirdly, set i_size after doing the duplicate_extents operation as this
value may be used by various things internally.  stat() hides the issue
because setting ->time to 0 causes cifs_getatr() to revalidate the
attributes.

These were causing the cifs/001 xfstest to fail.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c | 68 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 8097a9b3e98c..c5fc0a35bb19 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1268,9 +1268,12 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
+	struct cifsInodeInfo *src_cifsi = CIFS_I(src_inode);
+	struct cifsInodeInfo *target_cifsi = CIFS_I(target_inode);
 	struct cifsFileInfo *smb_file_src = src_file->private_data;
-	struct cifsFileInfo *smb_file_target;
-	struct cifs_tcon *target_tcon;
+	struct cifsFileInfo *smb_file_target = dst_file->private_data;
+	struct cifs_tcon *target_tcon, *src_tcon;
+	unsigned long long destend, fstart, fend, new_size;
 	unsigned int xid;
 	int rc;
 
@@ -1281,13 +1284,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 
 	xid = get_xid();
 
-	if (!src_file->private_data || !dst_file->private_data) {
+	if (!smb_file_src || !smb_file_target) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
 		goto out;
 	}
 
-	smb_file_target = dst_file->private_data;
+	src_tcon = tlink_tcon(smb_file_src->tlink);
 	target_tcon = tlink_tcon(smb_file_target->tlink);
 
 	/*
@@ -1300,20 +1303,63 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	if (len == 0)
 		len = src_inode->i_size - off;
 
-	cifs_dbg(FYI, "about to flush pages\n");
-	/* should we flush first and last page first */
-	truncate_inode_pages_range(&target_inode->i_data, destoff,
-				   PAGE_ALIGN(destoff + len)-1);
+	cifs_dbg(FYI, "clone range\n");
+
+	/* Flush the source buffer */
+	rc = filemap_write_and_wait_range(src_inode->i_mapping, off,
+					  off + len - 1);
+	if (rc)
+		goto unlock;
+
+	/* The server-side copy will fail if the source crosses the EOF marker.
+	 * Advance the EOF marker after the flush above to the end of the range
+	 * if it's short of that.
+	 */
+	if (src_cifsi->netfs.remote_i_size < off + len) {
+		rc = cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off + len);
+		if (rc < 0)
+			goto unlock;
+	}
+
+	new_size = destoff + len;
+	destend = destoff + len - 1;
 
-	if (target_tcon->ses->server->ops->duplicate_extents)
+	/* Flush the folios at either end of the destination range to prevent
+	 * accidental loss of dirty data outside of the range.
+	 */
+	fstart = destoff;
+	fend = destend;
+
+	rc = cifs_flush_folio(target_inode, destoff, &fstart, &fend, true);
+	if (rc)
+		goto unlock;
+	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
+	if (rc)
+		goto unlock;
+
+	/* Discard all the folios that overlap the destination region. */
+	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
+	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
+
+	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
+			   i_size_read(target_inode), 0);
+
+	rc = -EOPNOTSUPP;
+	if (target_tcon->ses->server->ops->duplicate_extents) {
 		rc = target_tcon->ses->server->ops->duplicate_extents(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-	else
-		rc = -EOPNOTSUPP;
+		if (rc == 0 && new_size > i_size_read(target_inode)) {
+			truncate_setsize(target_inode, new_size);
+			netfs_resize_file(&target_cifsi->netfs, new_size);
+			fscache_resize_cookie(cifs_inode_cookie(target_inode),
+					      new_size);
+		}
+	}
 
 	/* force revalidate of size and timestamps of target file now
 	   that target is updated on the server */
 	CIFS_I(target_inode)->time = 0;
+unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
 	unlock_two_nondirectories(src_inode, target_inode);


