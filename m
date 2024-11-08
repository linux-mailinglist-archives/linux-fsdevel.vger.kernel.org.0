Return-Path: <linux-fsdevel+bounces-34026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E79C22A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2375B23EFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485B1F4722;
	Fri,  8 Nov 2024 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6qgXWuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D81991D7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731085422; cv=none; b=fGPMFg6zci5q/EzabSmAquge0JelIDqpvKFF8rYFPRbahQfGaHjuZ28ttTtLl0kpPRpyE6AjZzEhpx3IvZuA5e20f6bz1ZDNKPgXAejqt60lRd4zGI6U5MIYmgGfVOngEz1S0Dj1T4w7SqmQFpHMggGG06Rp7dv6aoGMFTkGsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731085422; c=relaxed/simple;
	bh=DkLkcpSACAPOkdSqpA50/En10RaBzQkMrlzGe67Uqfk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=InC1gPSffkfFLXiTD9/Kqx9VzA6c9sFQfpA6w8bEUHvcJ6OEUryItRjIeNNv3FP3oG3qC/dbr/jW+beWv0siSLjNyK9VKd942cZpkBiax/k2nmkKNcMUxCCPZhcImcNIyyFY+kMCt2w8MvMYM+t13M+ktMlD9+q6f+CzM+Ynwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6qgXWuX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731085419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTE7HN+soO/Za76tq6046j/ukmrXopkun1LVu89YTbU=;
	b=T6qgXWuXIaXxnI2eW9WKV/AmKfOKS2YBliK/5XAu/N5yENxsHnR8Q1OD66feCJ7afKNNQ0
	DHcbC6T2trSZVIP6SVywfNpWs9Gb3GjVtaKt31lrtK5teI+zww8NR4iMfFiXyI9VkA82Vv
	bjYt2GOlUghFOa9Z6Whot8YmBwm3EJc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-d2vfCBO4PnGWgeJI8QflhA-1; Fri,
 08 Nov 2024 12:03:36 -0500
X-MC-Unique: d2vfCBO4PnGWgeJI8QflhA-1
X-Mimecast-MFC-AGG-ID: d2vfCBO4PnGWgeJI8QflhA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE2041955EA1;
	Fri,  8 Nov 2024 17:03:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03B2C1953880;
	Fri,  8 Nov 2024 17:03:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-29-dhowells@redhat.com>
References: <20241106123559.724888-29-dhowells@redhat.com> <20241106123559.724888-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/33] netfs: Change the read result collector to only use one work item
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1321311.1731085403.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 17:03:23 +0000
Message-ID: <1321312.1731085403@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch needs the attached adjustment folding in.

David
---
commit 2c0cccc7b29a051fadb6816d31f526e4dd45ddf5
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 7 22:22:49 2024 +0000

    netfs: Fix folio abandonment
    =

    The mechanism to handle the abandonment of a folio being read due to a=
n
    error occurring in a subrequest (such as if a signal occurs) will corr=
ectly
    abandon folios if they're entirely processed in one go; but if the
    constituent subrequests aren't processed in the same scheduled work it=
em,
    the note that the first one failed will get lost if no folios are proc=
essed
    (the ABANDON_SREQ note isn't transferred to the NETFS_RREQ_FOLIO_ABAND=
ON
    flag unless we process a folio).
    =

    Fix this by simplifying the way the mechanism works.  Replace the flag=
 with
    a variable that records the file position to which we should abandon
    folios.  Any folio that overlaps this region at the time of unlocking =
must
    be abandoned (and reread).
    =

    This works because subrequests are processed in order of file position=
 and
    each folio is processed as soon as enough subrequest transference is
    available to cover it - so when the abandonment point is moved, it cov=
ers
    only folios that draw data from the dodgy region.
    =

    Also make sure that NETFS_SREQ_FAILED is set on failure and that
    stream->failed is set when we cut the stream short.
    =

    Signed-off: David Howells <dhowells@redhat.com>
    cc: Jeff Layton <jlayton@kernel.org>
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 73f51039c2fe..7f3a3c056c6e 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -46,7 +46,7 @@ static void netfs_unlock_read_folio(struct netfs_io_requ=
est *rreq,
 	struct netfs_folio *finfo;
 	struct folio *folio =3D folioq_folio(folioq, slot);
 =

-	if (unlikely(test_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags))) {
+	if (unlikely(folio_pos(folio) < rreq->abandon_to)) {
 		trace_netfs_folio(folio, netfs_folio_trace_abandon);
 		goto just_unlock;
 	}
@@ -126,8 +126,6 @@ static void netfs_read_unlock_folios(struct netfs_io_r=
equest *rreq,
 =

 		if (*notes & COPY_TO_CACHE)
 			set_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
-		if (*notes & ABANDON_SREQ)
-			set_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags);
 =

 		folio =3D folioq_folio(folioq, slot);
 		if (WARN_ONCE(!folio_test_locked(folio),
@@ -152,7 +150,6 @@ static void netfs_read_unlock_folios(struct netfs_io_r=
equest *rreq,
 		*notes |=3D MADE_PROGRESS;
 =

 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
-		clear_bit(NETFS_RREQ_FOLIO_ABANDON, &rreq->flags);
 =

 		/* Clean up the head folioq.  If we clear an entire folioq, then
 		 * we can get rid of it provided it's not also the tail folioq
@@ -251,6 +248,12 @@ static void netfs_collect_read_results(struct netfs_i=
o_request *rreq)
 			if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &front->flags))
 				notes |=3D COPY_TO_CACHE;
 =

+			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
+				rreq->abandon_to =3D front->start + front->len;
+				front->transferred =3D front->len;
+				transferred =3D front->len;
+				trace_netfs_rreq(rreq, netfs_rreq_trace_set_abandon);
+			}
 			if (front->start + transferred >=3D rreq->cleaned_to + fsize ||
 			    test_bit(NETFS_SREQ_HIT_EOF, &front->flags))
 				netfs_read_unlock_folios(rreq, &notes);
@@ -268,6 +271,7 @@ static void netfs_collect_read_results(struct netfs_io=
_request *rreq)
 				stream->error =3D front->error;
 				rreq->error =3D front->error;
 				set_bit(NETFS_RREQ_FAILED, &rreq->flags);
+				stream->failed =3D true;
 			}
 			notes |=3D MADE_PROGRESS | ABANDON_SREQ;
 		} else if (test_bit(NETFS_SREQ_NEED_RETRY, &front->flags)) {
@@ -566,6 +570,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subr=
equest *subreq)
 			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		} else {
 			netfs_stat(&netfs_n_rh_download_failed);
+			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		}
 		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
 		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c00cffa1da13..4af7208e1360 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -260,6 +260,7 @@ struct netfs_io_request {
 	atomic64_t		issued_to;	/* Write issuer folio cursor */
 	unsigned long long	collected_to;	/* Point we've collected to */
 	unsigned long long	cleaned_to;	/* Position we've cleaned folios to */
+	unsigned long long	abandon_to;	/* Position to abandon folios to */
 	pgoff_t			no_unlock_folio; /* Don't unlock this folio after read */
 	unsigned char		front_folio_order; /* Order (size) of front folio */
 	refcount_t		ref;
@@ -271,7 +272,6 @@ struct netfs_io_request {
 #define NETFS_RREQ_FAILED		4	/* The request failed */
 #define NETFS_RREQ_IN_PROGRESS		5	/* Unlocked when the request completes =
*/
 #define NETFS_RREQ_FOLIO_COPY_TO_CACHE	6	/* Copy current folio to cache f=
rom read */
-#define NETFS_RREQ_FOLIO_ABANDON	7	/* Abandon failed folio from read */
 #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
 #define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) */
 #define NETFS_RREQ_BLOCKED		10	/* We blocked */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index cf14545ca2bd..22eb77b1f5e6 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -56,6 +56,7 @@
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
 	EM(netfs_rreq_trace_resubmit,		"RESUBMT")	\
+	EM(netfs_rreq_trace_set_abandon,	"S-ABNDN")	\
 	EM(netfs_rreq_trace_set_pause,		"PAUSE  ")	\
 	EM(netfs_rreq_trace_unlock,		"UNLOCK ")	\
 	EM(netfs_rreq_trace_unlock_pgpriv2,	"UNLCK-2")	\


