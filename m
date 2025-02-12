Return-Path: <linux-fsdevel+bounces-41570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF40BA322B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 10:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20A01888176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBC82063CA;
	Wed, 12 Feb 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh2vJJtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC151EF090
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353691; cv=none; b=ptwGjbpD4WEHt0SukMqYMgv32yTRVPANL+gGBE5dTykkHx4P0dmK3TZlPqFQh8kGvIFn4iqVeKOSE1OV5HZaTNqvla5M8BTLnpqR8h2apaRnN1UJxDExPg8+nM6jtyzxzu+hv7cSH+pymca+gev5AreqhQas7z6yclTH6/x/Fj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353691; c=relaxed/simple;
	bh=t21f2MlAY3g2CSPYzZV3AriCFj+8Z2TJBntSa10C5sU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lJi6mtmnlNo4giINUzYG2MgdY3PH5DMsee4lC8eUnW6pXxWXNcNMJ9cS6TJAOZTZiFWquEprGWqcQFDp/e3A8NWtS1rfxG8upl2IESnL1TdIvny/vrq/W8rV7xLQHe+Ka0L8CuTdW6n91gSPB1aM2MjzAGNxfGbEqYJnEUpfd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh2vJJtx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739353688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Aijtv05rg723WjyQX24R00qxSJTFgnmIWhfrftmGQQ=;
	b=Yh2vJJtxgABXDq5y0u9MdOCDtAMzvXoXlcs74UYyAhoyF/f8wAk9SrXfEnMN2R084UomYn
	B+fQ06KBpHPj6yHKlCxyHVQtqUIrfIrEdJZtksgK2zprLI8SvFwZIca88HgL89P9gmtvQ8
	QhAX4HxhRfyOSWjNqKWIvagxcxnDl1k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-WxTxF7viNq-keyChg0rYOw-1; Wed,
 12 Feb 2025 04:48:06 -0500
X-MC-Unique: WxTxF7viNq-keyChg0rYOw-1
X-Mimecast-MFC-AGG-ID: WxTxF7viNq-keyChg0rYOw_1739353684
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9BF19560B2;
	Wed, 12 Feb 2025 09:48:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C11E1800873;
	Wed, 12 Feb 2025 09:47:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <84a8e6737fca05dd3ec234760f1c77901d915ef9@linux.dev>
References: <84a8e6737fca05dd3ec234760f1c77901d915ef9@linux.dev> <8d8a5d5b00688ea553b106db690e8a01f15b1410@linux.dev> <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev> <3173328.1738024385@warthog.procyon.org.uk> <3187377.1738056789@warthog.procyon.org.uk> <2986469.1739185956@warthog.procyon.org.uk> <3210864.1739229537@warthog.procyon.org.uk>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
    "Steve
 French" <stfrench@microsoft.com>,
    "Eric Van Hensbergen" <ericvh@kernel.org>,
    "Latchesar  Ionkov" <lucho@ionkov.net>,
    "Dominique Martinet" <asmadeus@codewreck.org>,
    "Christian Schoenebeck" <linux_oss@crudebyte.com>,
    "Paulo Alcantara" <pc@manguebit.com>,
    "Jeff Layton" <jlayton@kernel.org>,
    "Christian Brauner" <brauner@kernel.org>, v9fs@lists.linux.dev,
    linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    ast@kernel.org, bpf@vger.kernel.org
Subject: [PATCH] netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3459754.1739353676.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2025 09:47:56 +0000
Message-ID: <3459755.1739353676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Ihor,

Okay, the bug you're hitting appears to be a different one to the one I
thought first.  Can you try the attached patch?  I managed to reproduce it
with AFS by injecting a delay.

Grepping your logs for the stuck request, you can see the issue:

          ip: netfs_rreq_ref: R=3D00002152 NEW         r=3D1
          ip: netfs_read: R=3D00002152 READAHEAD c=3D00000000 ni=3D1034fe3=
 s=3D4000 l=3D3000 sz=3D6898
          ip: netfs_rreq_ref: R=3D00002152 GET SUBREQ  r=3D2

Subrequest 1 completes synchronously and queues the collector work item:

          ip: netfs_sreq: R=3D00002152[1] DOWN TERM  f=3D192 s=3D4000 2898=
/2898 s=3D2 e=3D0
          ip: netfs_rreq_ref: R=3D00002152 GET WORK    r=3D3
kworker/u8:3: netfs_rreq_ref: R=3D00002152 SEE WORK    r=3D3
          ip: netfs_sreq_ref: R=3D00002152[1] PUT TERM    r=3D1
          ip: netfs_rreq_ref: R=3D00002152 GET SUBREQ  r=3D4

Then proposed a new subreq to clear the end of the page, but it's not queu=
ed
at this point:

          ip: netfs_sreq: R=3D00002152[2] ZERO SUBMT f=3D00 s=3D6898 0/768=
 s=3D0 e=3D0

(I should probably move the tracepoint to the queue point to make it more
obvious).  The collector processes the subrequests it can see, and
NETFS_RREQ_ALL_QUEUED (0x2000) is set in the flags (f=3D2021):

kworker/u8:3: netfs_rreq: R=3D00002152 RA COLLECT f=3D2021
kworker/u8:3: netfs_collect: R=3D00002152 s=3D4000-7000
kworker/u8:3: netfs_collect_sreq: R=3D00002152[0:01] s=3D4000 t=3D2898/289=
8
kworker/u8:3: netfs_sreq: R=3D00002152[1] DOWN DSCRD f=3D92 s=3D4000 2898/=
2898 s=3D2 e=3D0
kworker/u8:3: netfs_sreq_ref: R=3D00002152[1] PUT DONE    r=3D0
kworker/u8:3: netfs_sreq: R=3D00002152[1] DOWN FREE  f=3D92 s=3D4000 2898/=
2898 s=3D2 e=3D0
kworker/u8:3: netfs_rreq_ref: R=3D00002152 PUT SUBREQ  r=3D3

The notes (n=3Dx) indicate that the collector didn't see subreq 2 (bit 0,
HIT_PENDING, wasn't set)...:

kworker/u8:3: netfs_collect_state: R=3D00002152 col=3D6898 cln=3D7000 n=3D=
c
kworker/u8:3: netfs_collect_state: R=3D00002152 col=3D6898 cln=3D7000 n=3D=
8

... and so it completed the request:

kworker/u8:3: netfs_rreq: R=3D00002152 RA COMPLET f=3D2021
kworker/u8:3: netfs_rreq: R=3D00002152 RA WAKE-IP f=3D2021

And now, NETFS_RREQ_IN_PROGRESS has been cleared, which means we can't get
back into the read collector.

kworker/u8:3: netfs_rreq: R=3D00002152 RA DONE    f=3D2001
kworker/u8:3: netfs_rreq_ref: R=3D00002152 PUT WORK    r=3D2

Then subreq 2 finishes and you can see the worker happen, but do nothing:

          ip: netfs_sreq: R=3D00002152[2] ZERO TERM  f=3D102 s=3D6898 768/=
768 s=3D2 e=3D0
          ip: netfs_rreq_ref: R=3D00002152 GET WORK    r=3D3
kworker/u8:3: netfs_rreq_ref: R=3D00002152 SEE WORK    r=3D3
kworker/u8:3: netfs_rreq_ref: R=3D00002152 PUT WORK    r=3D2

David
---
netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued

Due to the code that queues a subreq on the active subrequest list getting
moved to netfs_issue_read(), the NETFS_RREQ_ALL_QUEUED flag may now get se=
t
before the list-add actually happens.  This is not a problem if the
collection worker happens after the list-add, but it's a race - and, for
9P, where the read from the server is synchronous and done in the
submitting thread, this is a lot more likely.

The result is that, if the timing is wrong, a ref gets leaked because the
collector thinks that all the subreqs have completed (because it can't see
the last one yet) and clears NETFS_RREQ_IN_PROGRESS - at which point, the
collection worker no longer goes into the collector.

This can be provoked with AFS by injecting an msleep() right before the
final subreq is queued.

Fix this by splitting the queuing part out of netfs_issue_read() into a ne=
w
function, netfs_queue_read(), and calling it separately.  The setting of
NETFS_RREQ_ALL_QUEUED is then done by netfs_queue_read() whilst it is
holding the spinlock (that's probably unnecessary, but shouldn't hurt).

It might be better to set a flag on the final subreq, but this could be a
problem if an error occurs and we can't queue it.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use =
one work item")
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Closes: https://lore.kernel.org/r/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_x=
wDAhLvgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.=
me/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index f761d44b3436..0d1b6d35ff3b 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -155,8 +155,9 @@ static void netfs_read_cache_to_pagecache(struct netfs=
_io_request *rreq,
 			netfs_cache_read_terminated, subreq);
 }
 =

-static void netfs_issue_read(struct netfs_io_request *rreq,
-			     struct netfs_io_subrequest *subreq)
+static void netfs_queue_read(struct netfs_io_request *rreq,
+			     struct netfs_io_subrequest *subreq,
+			     bool last_subreq)
 {
 	struct netfs_io_stream *stream =3D &rreq->io_streams[0];
 =

@@ -177,8 +178,17 @@ static void netfs_issue_read(struct netfs_io_request =
*rreq,
 		}
 	}
 =

+	if (last_subreq) {
+		smp_wmb(); /* Write lists before ALL_QUEUED. */
+		set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
+	}
+
 	spin_unlock(&rreq->lock);
+}
 =

+static void netfs_issue_read(struct netfs_io_request *rreq,
+			     struct netfs_io_subrequest *subreq)
+{
 	switch (subreq->source) {
 	case NETFS_DOWNLOAD_FROM_SERVER:
 		rreq->netfs_ops->issue_read(subreq);
@@ -293,11 +303,8 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
 		}
 		size -=3D slice;
 		start +=3D slice;
-		if (size <=3D 0) {
-			smp_wmb(); /* Write lists before ALL_QUEUED. */
-			set_bit(NETFS_RREQ_ALL_QUEUED, &rreq->flags);
-		}
 =

+		netfs_queue_read(rreq, subreq, size <=3D 0);
 		netfs_issue_read(rreq, subreq);
 		cond_resched();
 	} while (size > 0);


