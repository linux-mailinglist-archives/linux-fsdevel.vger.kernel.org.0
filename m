Return-Path: <linux-fsdevel+bounces-27391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA0961334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7926D28227B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467F1C93B0;
	Tue, 27 Aug 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOM4mHZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C94264A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773674; cv=none; b=hb56k+jsRK2m9axNxoc80uI6Xr3lcO/J8ERZvyNxW8UdhpLkgoJxAzQsS/kuWdl89eoJGIdgMDch6WT1lHSpgM3VXsln7tU52zH3yoRGlq3JvH5tHqg0gj0GBy8qNyL/NdP3NNqtaTznL8Qr7l0ShCvmEaR/qawFbPb9baMPzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773674; c=relaxed/simple;
	bh=mX7nfHXld2mBFsl25w8MwO1IRuyNcp/OiOqnPdEVX/U=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=VjeUlppdacPKmvRUUZuUp/ja59EDZTAhPs46D7G7mJM37QUt+WtDzLZJwNtxypU6H2814UxiYT/tyqfXiBlKwIxtT8Ja+NxkRiw6usUizgPB28ZCW/jkwJB/3QxD2Wq6KAhrIvYQHEJMH9M+rX6t+oI8pKZDrETgu0uN9Wal88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOM4mHZr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724773671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DWBRfGjoLyD8v0ummSlyJMhm9Y7pJVqza2oUVXSgR2s=;
	b=hOM4mHZrsWHCHpRa9SoB2bwTwpN0y+LzWPWks+G62rqFcq0rGPwQI0tGjbanfk8L2VTLPm
	PZ+bOx0F1ZwhEYU+E2EYl8n26hY2WIYcqvlLDnGvndhrOWJgXy4GRBYNAcWYeAMg0ZaIjw
	07jSY/y/FV/Geyw/BUraLEr4L1nj6Mk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-cxr-aK1BMeO3_XGtL99SmQ-1; Tue,
 27 Aug 2024 11:47:46 -0400
X-MC-Unique: cxr-aK1BMeO3_XGtL99SmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F84D1955F56;
	Tue, 27 Aug 2024 15:47:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67F811955F1B;
	Tue, 27 Aug 2024 15:47:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix copy offload to flush destination region
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <861651.1724773660.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Aug 2024 16:47:40 +0100
Message-ID: <861652.1724773660@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

    =

Fix cifs_file_copychunk_range() to flush the destination region before
invalidating it to avoid potential loss of data should the copy fail, in
whole or in part, in some way.

Fixes: 7b2404a886f8 ("cifs: Fix flushing, invalidation and file size with =
copy_file_range()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d89485235425..2a2523c93944 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1341,7 +1341,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
 	struct cifs_tcon *target_tcon;
-	unsigned long long destend, fstart, fend;
 	ssize_t rc;
 =

 	cifs_dbg(FYI, "copychunk range\n");
@@ -1391,25 +1390,13 @@ ssize_t cifs_file_copychunk_range(unsigned int xid=
,
 			goto unlock;
 	}
 =

-	destend =3D destoff + len - 1;
-
-	/* Flush the folios at either end of the destination range to prevent
-	 * accidental loss of dirty data outside of the range.
+	/* Flush and invalidate all the folios in the destination region.  If
+	 * the copy was successful, then some of the flush is extra overhead,
+	 * but we need to allow for the copy failing in some way (eg. ENOSPC).
 	 */
-	fstart =3D destoff;
-	fend =3D destend;
-
-	rc =3D cifs_flush_folio(target_inode, destoff, &fstart, &fend, true);
+	rc =3D filemap_invalidate_inode(target_inode, true, destoff, destoff + l=
en - 1);
 	if (rc)
 		goto unlock;
-	rc =3D cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
-	if (rc)
-		goto unlock;
-	if (fend > target_cifsi->netfs.zero_point)
-		target_cifsi->netfs.zero_point =3D fend + 1;
-
-	/* Discard all the folios that overlap the destination region. */
-	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 =

 	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
 			   i_size_read(target_inode), 0);


