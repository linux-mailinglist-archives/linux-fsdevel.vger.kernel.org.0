Return-Path: <linux-fsdevel+bounces-71797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB7CD2EB2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC83A3011B3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 12:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C550274B2A;
	Sat, 20 Dec 2025 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrnVZpla"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8439286A4
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766233914; cv=none; b=m09MyqQ352bjE0r2yY+xF6JnumywKzYI5nl6velFsF6s+4SJ8RZGe1saQql7LJ6PBClg+LKyXt7Hl2JaMVe4XBHf/NMBChc4dCzMZhGhtWmNeHbNXxV1w7veHf4vt1FDeekqqySOSQ39eGId8S2vbOMP9ooeC0Iv/K5oao2SFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766233914; c=relaxed/simple;
	bh=HiiZAKxtpNKLnOYl0GWimjE9g7TIzc3F5OFiwHQimaQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Xhc+PN9PlSYppxAXIVsD0v+hHj6T7c6PGYA3sIuVaUSIzpNVn0Rx59oFI0WPNmdLOM5xvT8Vp3/vR/biWsTHscYuWzXhoI9JCzyAPM4fnBqez2mGNTAgsNokboc/TUNeIGn3fvywOa6R2RYlH82HDcI8XtkOPynh6tagym6PKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrnVZpla; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766233912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EttdANpspnOT+Dim2C1JuGnSPCut69JUBFoLijH19Yo=;
	b=LrnVZplasxSNO3oMeeqt+5+xaoNv7p6q0CgKJdRyxeoCAm15Gervj3kvYgfxlO8NVd4bf+
	dxPY1UX4McHa9gb/OldkiwUyXh2XuHsOeiPAbfDqeyG6lpcP/TR8UwPK1vD3Cs0YBRLnAR
	4NC0GEa1oqzaDuA4XqraD0es5K9/ZW0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-LDDRf5UqNd635L2LF0Sa9w-1; Sat,
 20 Dec 2025 07:31:48 -0500
X-MC-Unique: LDDRf5UqNd635L2LF0Sa9w-1
X-Mimecast-MFC-AGG-ID: LDDRf5UqNd635L2LF0Sa9w_1766233906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5C0C1800343;
	Sat, 20 Dec 2025 12:31:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 769F030001A2;
	Sat, 20 Dec 2025 12:31:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: David Howells <dhowells@redhat.com>,
    Christian Schoenebeck <linux_oss@crudebyte.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Chris Arges <carges@cloudflare.com>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <sfrench@samba.org>, v9fs@lists.linux.dev,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <938161.1766233898.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Dec 2025 12:31:40 +0000
Message-ID: <938162.1766233900@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The read result collection for buffered reads seems to run ahead of the
completion of subrequests under some circumstances, as can be seen in the
following log snippet:

    9p_client_res: client 18446612686390831168 response P9_TREAD tag  0 er=
r 0
    ...
    netfs_sreq: R=3D00001b55[1] DOWN TERM  f=3D192 s=3D0 5fb2/5fb2 s=3D5 e=
=3D0
    ...
    netfs_collect_folio: R=3D00001b55 ix=3D00004 r=3D4000-5000 t=3D4000/5f=
b2
    netfs_folio: i=3D157f3 ix=3D00004-00004 read-done
    netfs_folio: i=3D157f3 ix=3D00004-00004 read-unlock
    netfs_collect_folio: R=3D00001b55 ix=3D00005 r=3D5000-5fb2 t=3D5000/5f=
b2
    netfs_folio: i=3D157f3 ix=3D00005-00005 read-done
    netfs_folio: i=3D157f3 ix=3D00005-00005 read-unlock
    ...
    netfs_collect_stream: R=3D00001b55[0:] cto=3D5fb2 frn=3Dffffffff
    netfs_collect_state: R=3D00001b55 col=3D5fb2 cln=3D6000 n=3Dc
    netfs_collect_stream: R=3D00001b55[0:] cto=3D5fb2 frn=3Dffffffff
    netfs_collect_state: R=3D00001b55 col=3D5fb2 cln=3D6000 n=3D8
    ...
    netfs_sreq: R=3D00001b55[2] ZERO SUBMT f=3D000 s=3D5fb2 0/4e s=3D0 e=3D=
0
    netfs_sreq: R=3D00001b55[2] ZERO TERM  f=3D102 s=3D5fb2 4e/4e s=3D5 e=3D=
0

The 'cto=3D5fb2' indicates the collected file pos we've collected results =
to
so far - but we still have 0x4e more bytes to go - so we shouldn't have
collected folio ix=3D00005 yet.  The 'ZERO' subreq that clears the tail
happens after we unlock the folio, allowing the application to see the
uncleared tail through mmap.

The problem is that netfs_read_unlock_folios() will unlock a folio in whic=
h
the amount of read results collected hits EOF position - but the ZERO
subreq lies beyond that and so happens after.

Fix this by changing the end check to always be the end of the folio and
never the end of the file.

In the future, I should look at clearing to the end of the folio here rath=
er
than adding a ZERO subreq to do this.  On the other hand, the ZERO subreq =
can
run in parallel with an async READ subreq.  Further, the ZERO subreq may s=
till
be necessary to, say, handle extents in a ceph file that don't have any
backing store and are thus implicitly all zeros.

This can be reproduced by creating a file, the size of which doesn't align
to a page boundary, e.g. 24998 (0x5fb2) bytes and then doing something
like:

    xfs_io -c "mmap -r 0 0x6000" -c "madvise -d 0 0x6000" \
           -c "mread -v 0 0x6000" /xfstest.test/x

The last 0x4e bytes should all be 00, but if the tail hasn't been cleared
yet, you may see rubbish there.  This can be reproduced with kafs by
modifying the kernel to disable the call to netfs_read_subreq_progress()
and to stop afs_issue_read() from doing the async call for NETFS_READAHEAD=
.
Reproduction can be made easier by inserting an mdelay(100) in
netfs_issue_read() for the ZERO-subreq case.

AFS and CIFS are normally unlikely to show this as they dispatch READ ops
asynchronously, which allows the ZERO-subreq to finish first.  9P's READ o=
p is
completely synchronous, so the ZERO-subreq will always happen after.  It i=
sn't
seen all the time, though, because the collection may be done in a worker
thread.

Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Link: https://lore.kernel.org/r/8622834.T7Z3S40VBb@weasel/
Signed-off-by: David Howells <dhowells@redhat.com>
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index a95e7aadafd0..7a0ffa675fb1 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -137,7 +137,7 @@ static void netfs_read_unlock_folios(struct netfs_io_r=
equest *rreq,
 		rreq->front_folio_order =3D order;
 		fsize =3D PAGE_SIZE << order;
 		fpos =3D folio_pos(folio);
-		fend =3D umin(fpos + fsize, rreq->i_size);
+		fend =3D fpos + fsize;
 =

 		trace_netfs_collect_folio(rreq, folio, fend, collected_to);
 =


