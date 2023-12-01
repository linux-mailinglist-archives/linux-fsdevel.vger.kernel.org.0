Return-Path: <linux-fsdevel+bounces-4528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E621A80004D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C09281696
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0CE1CA8C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFAgcmD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268071B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701390134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVjzGyuYK3szIKJT4ymdAj2FadLtKdoBcYO36fgupWk=;
	b=VFAgcmD5oQNb1BzrOpBjD2p2eMccUVYJIuZsEb8+fVReqpctR89/vdIMeveVCGir336Lhx
	CJv6mpRsmQogr6jQZ/2oJHINNq4nPlrnMIhZfRAxdNr2VVq8Kop2yaNSTzaI4r6tSyQval
	//LqY+jENkqcpO3l3Zlcjh9ExQdrKxc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-yY5Fe2XEMJ2SSHuRINZ4Lg-1; Thu,
 30 Nov 2023 19:22:10 -0500
X-MC-Unique: yY5Fe2XEMJ2SSHuRINZ4Lg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 589D51C0690A;
	Fri,  1 Dec 2023 00:22:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 055512026D4C;
	Fri,  1 Dec 2023 00:22:07 +0000 (UTC)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] cifs: Fix flushing, invalidation and file size with copy_file_range()
Date: Fri,  1 Dec 2023 00:22:00 +0000
Message-ID: <20231201002201.2981258-2-dhowells@redhat.com>
In-Reply-To: <20231201002201.2981258-1-dhowells@redhat.com>
References: <20231201002201.2981258-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Fix a number of issues in the cifs filesystem implementation of the
copy_file_range() syscall in cifs_file_copychunk_range().

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
idea of the EOF at a later point than the server's EOF.  If a copy request
is issued, this will fail on the server with STATUS_INVALID_VIEW_SIZE
(which gets translated to -EIO locally) if the copy source extends past the
server's EOF.

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

 (4) Then perform the copy.

Thirdly, set i_size after doing the copychunk_range operation as this value
may be used by various things internally.  stat() hides the issue because
setting ->time to 0 causes cifs_getatr() to revalidate the attributes.

These were causing the generic/075 xfstest to fail.

Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c | 102 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea3a7a668b45..8097a9b3e98c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1196,6 +1196,72 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.listxattr = cifs_listxattr,
 };
 
+/*
+ * Advance the EOF marker to after the source range.
+ */
+static int cifs_precopy_set_eof(struct inode *src_inode, struct cifsInodeInfo *src_cifsi,
+				struct cifs_tcon *src_tcon,
+				unsigned int xid, loff_t src_end)
+{
+	struct cifsFileInfo *writeable_srcfile;
+	int rc = -EINVAL;
+
+	writeable_srcfile = find_writable_file(src_cifsi, FIND_WR_FSUID_ONLY);
+	if (writeable_srcfile) {
+		if (src_tcon->ses->server->ops->set_file_size)
+			rc = src_tcon->ses->server->ops->set_file_size(
+				xid, src_tcon, writeable_srcfile,
+				src_inode->i_size, true /* no need to set sparse */);
+		else
+			rc = -ENOSYS;
+		cifsFileInfo_put(writeable_srcfile);
+		cifs_dbg(FYI, "SetFSize for copychunk rc = %d\n", rc);
+	}
+
+	if (rc < 0)
+		goto set_failed;
+
+	netfs_resize_file(&src_cifsi->netfs, src_end);
+	fscache_resize_cookie(cifs_inode_cookie(src_inode), src_end);
+	return 0;
+
+set_failed:
+	return filemap_write_and_wait(src_inode->i_mapping);
+}
+
+/*
+ * Flush out either the folio that overlaps the beginning of a range in which
+ * pos resides or the folio that overlaps the end of a range unless that folio
+ * is entirely within the range we're going to invalidate.  We extend the flush
+ * bounds to encompass the folio.
+ */
+static int cifs_flush_folio(struct inode *inode, loff_t pos, loff_t *_fstart, loff_t *_fend,
+			    bool first)
+{
+	struct folio *folio;
+	unsigned long long fpos, fend;
+	pgoff_t index = pos / PAGE_SIZE;
+	size_t size;
+	int rc = 0;
+
+	folio = filemap_get_folio(inode->i_mapping, index);
+	if (IS_ERR(folio))
+		return 0;
+
+	size = folio_size(folio);
+	fpos = folio_pos(folio);
+	fend = fpos + size - 1;
+	*_fstart = min_t(unsigned long long, *_fstart, fpos);
+	*_fend   = max_t(unsigned long long, *_fend, fend);
+	if ((first && pos == fpos) || (!first && pos == fend))
+		goto out;
+
+	rc = filemap_write_and_wait_range(inode->i_mapping, fpos, fend);
+out:
+	folio_put(folio);
+	return rc;
+}
+
 static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 		struct file *dst_file, loff_t destoff, loff_t len,
 		unsigned int remap_flags)
@@ -1263,10 +1329,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
+	struct cifsInodeInfo *src_cifsi = CIFS_I(src_inode);
 	struct cifsFileInfo *smb_file_src;
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
+	unsigned long long destend, fstart, fend;
 	ssize_t rc;
 
 	cifs_dbg(FYI, "copychunk range\n");
@@ -1306,13 +1374,41 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	if (rc)
 		goto unlock;
 
-	/* should we flush first and last page first */
-	truncate_inode_pages(&target_inode->i_data, 0);
+	/* The server-side copy will fail if the source crosses the EOF marker.
+	 * Advance the EOF marker after the flush above to the end of the range
+	 * if it's short of that.
+	 */
+	if (src_cifsi->server_eof < off + len) {
+		rc = cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off + len);
+		if (rc < 0)
+			goto unlock;
+	}
+
+	destend = destoff + len - 1;
+
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
+	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 
 	rc = file_modified(dst_file);
-	if (!rc)
+	if (!rc) {
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
+		if (rc > 0 && destoff + rc > i_size_read(target_inode))
+			truncate_setsize(target_inode, destoff + rc);
+	}
 
 	file_accessed(src_file);
 


