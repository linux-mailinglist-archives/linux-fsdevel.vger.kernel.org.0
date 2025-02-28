Return-Path: <linux-fsdevel+bounces-42864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8784A4A034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70B81758B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BE1EF38C;
	Fri, 28 Feb 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFkVrRiD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6581F4C81
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763358; cv=none; b=IAy+iukOHIELf/I0SQsl80piDZqHOFzr7UI8piPVY1WZZqM79KI+c0s2a8UHyhXETSBuDe9jKN8PbyoGvWAtQK6uWXmVjGsDtwm2NGkm/j0iQGZ3jtNFZVWCSgnkE4J+sk6y3/AZ0cGnM45fEtqlZL658k31hChfRu/HXGJX5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763358; c=relaxed/simple;
	bh=kwZmIkwzYjRWwThM1im9I9qfIAHi7RG664PWhS4MdN4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=M1Pgfv5uAP29WCocqN0jrWssLCzGeoeYclbVNOUi5L7Y63bBYA1LKV0QUxZVsG/c8fTGyUFniDKEV+etyNarab+FfahgzuMhfOoodrDV9llGpa8wOvXDtxv0F8PtY9V1lJYytOB+Ntda0YR6NqfFtQ3FIVg+WmIlcZKRUln1S0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFkVrRiD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740763353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o2q1F4ZnYfypORf6nY9lGLVyvRQqsUPpbxegTdItZ+s=;
	b=dFkVrRiDP213TJKCi00EO1/Q9z6r5BqhKlSNr76LMq6HgL4mhkwqRFTaGwtcdqrDgC8LMg
	HD2pdfIeK6OKjPycISotc1/ufeKAxjCiwEyiSmJ7dv22U6A8GRuI7iziRtg3gkgUgh1O+k
	uL+Ontf5Bi+jT1XueaHZui8l4JEztxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-5sVICdX5MRGKvMlj2Bnj7A-1; Fri,
 28 Feb 2025 12:22:32 -0500
X-MC-Unique: 5sVICdX5MRGKvMlj2Bnj7A-1
X-Mimecast-MFC-AGG-ID: 5sVICdX5MRGKvMlj2Bnj7A_1740763350
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9875D1800874;
	Fri, 28 Feb 2025 17:22:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89444180176B;
	Fri, 28 Feb 2025 17:22:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix collection of results during pause when collection offloaded
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3431540.1740763345.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 17:22:25 +0000
Message-ID: <3431541.1740763345@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

    =

A netfs read request can run in one of two modes: for synchronous reads
writes, the app thread does the collection of results and for asynchronous
reads, this is offloaded to a worker thread.  This is controlled by the
NETFS_RREQ_OFFLOAD_COLLECTION flag.

Now, if a subrequest incurs an error, the NETFS_RREQ_PAUSE flag is set to
stop the issuing loop temporarily from issuing more subrequests until a
retry is successful or the request is abandoned.

When the issuing loop sees NETFS_RREQ_PAUSE, it jumps to
netfs_wait_for_pause() which will wait for the PAUSE flag to be cleared -
and whilst it is waiting, it will call out to the collector as more result=
s
acrue...  But this is the wrong thing to do if OFFLOAD_COLLECTION is set a=
s
we can then end up with both the app thread and the work item collecting
results simultaneously.

This manifests itself occasionally when running the generic/323 xfstest
against multichannel cifs as an oops that's a bit random but frequently
involving io_submit() (the test does lots of simultaneous async DIO reads)=
.

Fix this by only doing the collection in netfs_wait_for_pause() if the
NETFS_RREQ_OFFLOAD_COLLECTION is not set.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use =
one work item")
Reported-by: Steve French <stfrench@microsoft.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 636cc5a98ef5..23c75755ad4e 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -682,14 +682,16 @@ void netfs_wait_for_pause(struct netfs_io_request *r=
req)
 		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
 		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 =

-		subreq =3D list_first_entry_or_null(&stream->subrequests,
-						  struct netfs_io_subrequest, rreq_link);
-		if (subreq &&
-		    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
-		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
-			__set_current_state(TASK_RUNNING);
-			netfs_read_collection(rreq);
-			continue;
+		if (!test_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &rreq->flags)) {
+			subreq =3D list_first_entry_or_null(&stream->subrequests,
+							  struct netfs_io_subrequest, rreq_link);
+			if (subreq &&
+			    (!test_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags) ||
+			     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags))) {
+				__set_current_state(TASK_RUNNING);
+				netfs_read_collection(rreq);
+				continue;
+			}
 		}
 =

 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags) ||


