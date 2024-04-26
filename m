Return-Path: <linux-fsdevel+bounces-17886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3388B366A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF307283B00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5F144D34;
	Fri, 26 Apr 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EveQUKaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D1B144D2F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130128; cv=none; b=QvCwwqCjg/0Cpp5uZYik8h1gRX+BdZWRruPPp0+zIaiSAkcrYPtuW+6GYDgb6Am8oateC62wY/GSy9K1H2lt+Vpvf6/KDx3ah9SiBRRQeI7c70BKIbOYndb5hAAByd5df4SOWdjzx0MI9GcPsoGuk8YATjiOBbrcX999OdNrKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130128; c=relaxed/simple;
	bh=qLKSvAMidi73Dhn76RHSTn7YHvsi8/0CtMU1zgA3J74=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=a49IKIP9DiSSsvPpXGKV00i2oKx++o324To5Jz67TXF2rXkuOVj6v/gsZi/WAQ76r3k/T0qiDAOC4NfzoOkc/iEMN1axUlaWl6wUz5u3QvScJ5LwYzhovGrqu/IcSZ90M8o6YSETKOWX+FyGwNrxnL8QLRvU0p3w97O0Ei784Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EveQUKaH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714130125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V5UQl+A/q/jFNTFxR4sxGrh2z0OS8H/kdmBGvgOenXw=;
	b=EveQUKaH5Amb63B7Wp8xU2d5tskoP03e2T76GWLoCm4SZnw2iVCPOA2wcGd6Ln5s2SVH2h
	TK02iRpEqgrueFSm9hdBwvC0IVpRt3HjIVbdrG9oEsULVEbSj6kDAOmv42+bWas1zRsyWl
	CqintaKC1T4RrLipt0HZaa/RKneZIfw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-pPepkYvEP3aJNht168TYdQ-1; Fri, 26 Apr 2024 07:15:20 -0400
X-MC-Unique: pPepkYvEP3aJNht168TYdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B15918065AD;
	Fri, 26 Apr 2024 11:15:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0034AC68;
	Fri, 26 Apr 2024 11:15:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Marc Dionne <marc.dionne@auristor.com>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the pre-flush when appending to a file in writethrough mode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2150447.1714130115.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Apr 2024 12:15:15 +0100
Message-ID: <2150448.1714130115@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

In netfs_perform_write(), when the file is marked NETFS_ICTX_WRITETHROUGH
or O_*SYNC or RWF_*SYNC was specified, write-through caching is performed
on a buffered file.  When setting up for write-through, we flush any
conflicting writes in the region and wait for the write to complete,
failing if there's a write error to return.

The issue arises if we're writing at or above the EOF position because we
skip the flush and - more importantly - the wait.  This becomes a problem
if there's a partial folio at the end of the file that is being written ou=
t
and we want to make a write to it too.  Both the already-running write and
the write we start both want to clear the writeback mark, but whoever is
second causes a warning looking something like:

    ------------[ cut here ]------------
    R=3D00000012: folio 11 is not under writeback
    WARNING: CPU: 34 PID: 654 at fs/netfs/write_collect.c:105
    ...
    CPU: 34 PID: 654 Comm: kworker/u386:27 Tainted: G S ...
    ...
    Workqueue: events_unbound netfs_write_collection_worker
    ...
    RIP: 0010:netfs_writeback_lookup_folio

Fix this by making the flush-and-wait unconditional.  It will do nothing i=
f
there are no folios in the pagecache and will return quickly if there are
no folios in the region specified.

Further, move the WBC attachment above the flush call as the flush is goin=
g
to attach a WBC and detach it again if it is not present - and since we
need one anyway we might as well share it.

Fixes: 41d8e7673a77 ("netfs: Implement a write-through caching option")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404161031.468b84f-oliver.sang@in=
tel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
---
 fs/netfs/buffered_write.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..07aff231926c 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -172,15 +172,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
 	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
 		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
 	    ) {
-		if (pos < i_size_read(inode)) {
-			ret =3D filemap_write_and_wait_range(mapping, pos, pos + iter->count);
-			if (ret < 0) {
-				goto out;
-			}
-		}
-
 		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
 =

+		ret =3D filemap_write_and_wait_range(mapping, pos, pos + iter->count);
+		if (ret < 0) {
+			wbc_detach_inode(&wbc);
+			goto out;
+		}
+
 		wreq =3D netfs_begin_writethrough(iocb, iter->count);
 		if (IS_ERR(wreq)) {
 			wbc_detach_inode(&wbc);


