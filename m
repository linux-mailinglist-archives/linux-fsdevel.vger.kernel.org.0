Return-Path: <linux-fsdevel+bounces-30709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C698DD6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F4C1F214AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749301D0F7A;
	Wed,  2 Oct 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q164X5Iv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8E1D0E04
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880370; cv=none; b=NA4owPwoRpHX/fmYkMO3STgrPuu1A3KU6RlIA1NnEZxjTkqB2bLE7/ROoS4CEPypXwsMOHdlTR2o1FbHFY60ZA3l5Nd8ACVJQHvKG6KclllX0Y6JiSnkfr/PGbudG9X9Bj1qpZ7SRNlq7cws7ggOnMpcTSFh/sIDKvrlOWxYh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880370; c=relaxed/simple;
	bh=sNh/AIa+JnaRrSjGaa32yEPyaI6KwqBpjQs1HPPeD+s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BDGMaqlwaABMt1A5ZmMQNA9lZ0ZBMW7H5nZeU8h3zb5agiS3JelzU2fuGrBgBF7DdlMzFXwb7wSTnKuKcVGv9Nqj3pyBGY9KuL5u860YRmeV2gx9TD7OHDhy1ee01UVCzoe0gnCFfEhvDAgfwD6+FwXCGKBrJqKjuIVadVhZsFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q164X5Iv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727880367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wx+Qy/zl06Mj2fY6S2Q/NqjkDcK+6NpSkSBNzQEim2o=;
	b=Q164X5Iv6f1tNWZ21OXFYAR1c22D7gqqUH1zmRpuxW40rNZ/v5yT7lBRc0lMsbPCxGqTxH
	hzGpQlncHSy0OCuewx9ts+AIhWq5oNMfLoMYT59NNOvXS+dzXFWFF/LQUr0saSyKoQPSki
	wORhQbf9wpI7PNzDjfN/fL+I26+ctgA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-Kr-4CUsINVKkZ5xCKWvUgQ-1; Wed,
 02 Oct 2024 10:45:57 -0400
X-MC-Unique: Kr-4CUsINVKkZ5xCKWvUgQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEFCB1955DE0;
	Wed,  2 Oct 2024 14:45:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AA043000198;
	Wed,  2 Oct 2024 14:45:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix missing wakeup after issuing writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3317783.1727880350.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Oct 2024 15:45:50 +0100
Message-ID: <3317784.1727880350@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

After dividing up a proposed write into subrequests, netfslib sets
NETFS_RREQ_ALL_QUEUED to indicate to the collector that it can move on to
the final cleanup once it has emptied the subrequest queues.

Now, whilst the collector will normally end up running at least once after
this bit is set just because it takes a while to process all the write
subrequests before the collector runs out of subrequests, there exists the
possibility that the issuing thread will be forced to sleep and the
collector thread will clean up all the subrequests before ALL_QUEUED gets
set.

In such a case, the collector thread will not get triggered again and will
never clear NETFS_RREQ_IN_PROGRESS thus leaving a request uncompleted and
causing a potential futute hang.

Fix this by scheduling the write collector if all the subrequest queues ar=
e
empty (and thus no writes pending issuance).

Note that we'd do this ideally before queuing the subrequest, but in the
case of buffered writeback, at least, we can't find out that we've run out
of folios until after we've called writeback_iter() and it has returned
NULL - at which point we might not actually have any subrequests still
under construction.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 6293f547e4c3..bf6d507578e5 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -508,6 +508,30 @@ static int netfs_write_folio(struct netfs_io_request =
*wreq,
 	return 0;
 }
 =

+/*
+ * End the issuing of writes, letting the collector know we're done.
+ */
+static void netfs_end_issue_write(struct netfs_io_request *wreq)
+{
+	bool needs_poke =3D true;
+
+	smp_wmb(); /* Write subreq lists before ALL_QUEUED. */
+	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+
+	for (int s =3D 0; s < NR_IO_STREAMS; s++) {
+		struct netfs_io_stream *stream =3D &wreq->io_streams[s];
+
+		if (!stream->active)
+			continue;
+		if (!list_empty(&stream->subrequests))
+			needs_poke =3D false;
+		netfs_issue_write(wreq, stream);
+	}
+
+	if (needs_poke)
+		netfs_wake_write_collector(wreq, false);
+}
+
 /*
  * Write some of the pending data back to the server
  */
@@ -559,10 +583,7 @@ int netfs_writepages(struct address_space *mapping,
 			break;
 	} while ((folio =3D writeback_iter(mapping, wbc, folio, &error)));
 =

-	for (int s =3D 0; s < NR_IO_STREAMS; s++)
-		netfs_issue_write(wreq, &wreq->io_streams[s]);
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+	netfs_end_issue_write(wreq);
 =

 	mutex_unlock(&ictx->wb_lock);
 =

@@ -650,10 +671,7 @@ int netfs_end_writethrough(struct netfs_io_request *w=
req, struct writeback_contr
 	if (writethrough_cache)
 		netfs_write_folio(wreq, wbc, writethrough_cache);
 =

-	netfs_issue_write(wreq, &wreq->io_streams[0]);
-	netfs_issue_write(wreq, &wreq->io_streams[1]);
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
+	netfs_end_issue_write(wreq);
 =

 	mutex_unlock(&ictx->wb_lock);
 =

@@ -699,13 +717,7 @@ int netfs_unbuffered_write(struct netfs_io_request *w=
req, bool may_wait, size_t
 			break;
 	}
 =

-	netfs_issue_write(wreq, upload);
-
-	smp_wmb(); /* Write lists before ALL_QUEUED. */
-	set_bit(NETFS_RREQ_ALL_QUEUED, &wreq->flags);
-	if (list_empty(&upload->subrequests))
-		netfs_wake_write_collector(wreq, false);
-
+	netfs_end_issue_write(wreq);
 	_leave(" =3D %d", error);
 	return error;
 }


