Return-Path: <linux-fsdevel+bounces-26995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87895D794
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CD282CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28819EEB4;
	Fri, 23 Aug 2024 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9tr7PyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853A19EEA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443763; cv=none; b=NYCovuz2lGfHwvVpNF0aE98s22uYgEcoJw31S06BJdKkF98ecZ/9FaVf/u15B1h8Sv20/mnURoJeQHbRZY9eI7QhVHn66aIUTeSSJHnsBqpeccGcyFa/Hvp6PrXTcLRdiMiNnpsVpaXMwpRmGGax6bqILOQJDMOrMs5HAkE+MiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443763; c=relaxed/simple;
	bh=4IaS/r+06dw3dqC3E4QnsVrl684yRehCvqBZ6fcMoa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr8nP5MRX+jcwtPs8Ct1XRUpbq0pY9Y9pKF0yWSZPvevjbDz6nfgXKykcptY2sO2FHSV/4u0yKupyZeWaHTipXVb4NzV1ahw2e2oYDCBG2OD/6t2/3z9UaTUIRXdxi0oQYJ683T7Gk2IrIyIlfccbBy2r86+/nxUl8kT/BVFKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9tr7PyI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCLN+DgZIMYjLim8F8YFGy04wez+ty5Hq7K/oJiQsg4=;
	b=W9tr7PyIuHgI8My8Ycj7E3xnFev74XDAqFXHmCLGHJP21egPkwWkez/RiQOpUM6sEktTR6
	+0VfUYKI9daMYzg2efMLxYisMvVYBfUqFAkvvCJFGGUSpg3yo6b9OXBjG4S71UJ0rS+7bW
	TGR/MmB7ew6Fes6cfWodUXQWsPHJlaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-N2VgEkt9MmW_PQ0CeQQcEw-1; Fri,
 23 Aug 2024 16:09:18 -0400
X-MC-Unique: N2VgEkt9MmW_PQ0CeQQcEw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740711955D4D;
	Fri, 23 Aug 2024 20:09:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F201956053;
	Fri, 23 Aug 2024 20:09:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shyam Prasad N <nspmangalore@gmail.com>
Subject: [PATCH 8/9] cifs: Fix FALLOC_FL_PUNCH_HOLE support
Date: Fri, 23 Aug 2024 21:08:16 +0100
Message-ID: <20240823200819.532106-9-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The cifs filesystem doesn't quite emulate FALLOC_FL_PUNCH_HOLE correctly
(note that due to lack of protocol support, it can't actually implement it
directly).  Whilst it will (partially) invalidate dirty folios in the
pagecache, it doesn't write them back first, and so the EOF marker on the
server may be lower than inode->i_size.

This presents a problem, however, as if the punched hole invalidates the
tail of the locally cached dirty data, writeback won't know it needs to
move the EOF over to account for the hole punch (which isn't supposed to
move the EOF).  We could just write zeroes over the punched out region of
the pagecache and write that back - but this is supposed to be a
deallocatory operation.

Fix this by manually moving the EOF over on the server after the operation
if the hole punched would corrupt it.

Note that the FSCTL_SET_ZERO_DATA RPC and the setting of the EOF should
probably be compounded to stop a third party interfering (or, at least,
massively reduce the chance).

This was reproducible occasionally by using fsx with the following script:

	truncate 0x0 0x375e2 0x0
	punch_hole 0x2f6d3 0x6ab5 0x375e2
	truncate 0x0 0x3a71f 0x375e2
	mapread 0xee05 0xcf12 0x3a71f
	write 0x2078e 0x5604 0x3a71f
	write 0x3ebdf 0x1421 0x3a71f *
	punch_hole 0x379d0 0x8630 0x40000 *
	mapread 0x2aaa2 0x85b 0x40000
	fallocate 0x1b401 0x9ada 0x40000
	read 0x15f2 0x7d32 0x40000
	read 0x32f37 0x7a3b 0x40000 *

The second "write" should extend the EOF to 0x40000, and the "punch_hole"
should operate inside of that - but that depends on whether the VM gets in
and writes back the data first.  If it doesn't, the file ends up 0x3a71f in
size, not 0x40000.

Fixes: 31742c5a3317 ("enable fallocate punch hole ("fallocate -p") for SMB3")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
---
 fs/smb/client/smb2ops.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 14c3d11869ba..8fb68c47c218 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3305,6 +3305,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 	struct file_zero_data_information fsctl_buf;
+	unsigned long long end = offset + len, i_size, remote_i_size;
 	long rc;
 	unsigned int xid;
 	__u8 set_sparse = 1;
@@ -3336,6 +3337,27 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 			(char *)&fsctl_buf,
 			sizeof(struct file_zero_data_information),
 			CIFSMaxBufSize, NULL, NULL);
+
+	if (rc)
+		goto unlock;
+
+	/* If there's dirty data in the buffer that would extend the EOF if it
+	 * were written, then we need to move the EOF marker over to the lower
+	 * of the high end of the hole and the proposed EOF.  The problem is
+	 * that we locally hole-punch the tail of the dirty data, the proposed
+	 * EOF update will end up in the wrong place.
+	 */
+	i_size = i_size_read(inode);
+	remote_i_size = netfs_inode(inode)->remote_i_size;
+	if (end > remote_i_size && i_size > remote_i_size) {
+		unsigned long long extend_to = umin(end, i_size);
+		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
+				  cfile->fid.volatile_fid, cfile->pid, extend_to);
+		if (rc >= 0)
+			netfs_inode(inode)->remote_i_size = extend_to;
+	}
+
+unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 out:
 	inode_unlock(inode);


