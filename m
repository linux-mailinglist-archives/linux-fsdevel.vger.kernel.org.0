Return-Path: <linux-fsdevel+bounces-36522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BFC9E5183
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF091880682
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D41D5AD3;
	Thu,  5 Dec 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG6eKz69"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2718FC70
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391555; cv=none; b=Ftval+lf+ci6VEwPDMCWWO6exnlSdFezkeF8XS/UB8GktglMcjGXSxc3AKW4KAEUp6rwYikYjoZ5ttzJ5CgfHTAMtZxdDrYVN6X2jXenvj4pEUXoAqFSKTiRZxaxNrgAS/qN1xE9wweeX+/M7nUhvvFQFeBmn8iiLQDq7UW1vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391555; c=relaxed/simple;
	bh=oZtKuhzxajYCrnXbWpf2HCVAwSMjzBBKh+xdSWz7Fak=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=SPn18pPoufuU/vBF0SugwM5TrB1DkZtbuw7Jr6Dvh4VyS3tTD76lvL5WPaXnpXO/5uqF6UTtUMv6eDhum47/lr1pKCPVniIyEIO2ZYi8+y/0Rae+AWxlwcR+vXJMf0NE7gekb6+HNmyLV3c8B0mPZKL4y4wnRatDve3V9/Bv7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG6eKz69; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733391553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bmHCospEdUEWKsCE26X0+djAl1wpJXnOUHyXQH8b74=;
	b=SG6eKz6988GALdwEtyC+9f6t/vWGqBDA7isNpQeu786/5YXxXrQ/U8JHYt8Y/r++42C5qG
	k6On4GLumsTXLeLgv8+PF7pRtDqQUjhlCXzQQ7BLWLt7QCgTqgZZSx9JOPtOu95Y63lfI/
	RdbDKybPHKaOYMrWMSRXzvUMt1mhrwg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-cw055EATNByoGgUX5-Rsjw-1; Thu,
 05 Dec 2024 04:39:11 -0500
X-MC-Unique: cw055EATNByoGgUX5-Rsjw-1
X-Mimecast-MFC-AGG-ID: cw055EATNByoGgUX5-Rsjw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC001944DD8;
	Thu,  5 Dec 2024 09:39:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3978F1955F3F;
	Thu,  5 Dec 2024 09:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67506987.050a0220.17bd51.006f.GAE@google.com>
References: <67506987.050a0220.17bd51.006f.GAE@google.com>
To: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org,
    Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
    netfs@lists.linux.dev, linux-block@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1757418.1733391531.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Dec 2024 09:38:51 +0000
Message-ID: <1757419.1733391531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-blo=
ck.git for-6.14/block

netfs: Fix enomem handling in buffered reads

If netfs_read_to_pagecache() gets an error from either ->prepare_read() or
from netfs_prepare_read_iterator(), it needs to decrement ->nr_outstanding=
,
cancel the subrequest and break out of the issuing loop.  Currently, it
only does this for two of the cases, but there are two more that aren't
handled.

Fix this by moving the handling to a common place and jumping to it from
all four places.  This is in preference to inserting a wrapper around
netfs_prepare_read_iterator() as proposed by Dmitry Antipov[1].

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D404b4b745080b6210c6c
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dmitry Antipov <dmantipov@yandex.ru>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241202093943.227786-1-dmantipov@yandex.r=
u/ [1]
---
 fs/netfs/buffered_read.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..4dc9b8286355 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -275,22 +275,14 @@ static void netfs_read_to_pagecache(struct netfs_io_=
request *rreq)
 			netfs_stat(&netfs_n_rh_download);
 			if (rreq->netfs_ops->prepare_read) {
 				ret =3D rreq->netfs_ops->prepare_read(subreq);
-				if (ret < 0) {
-					atomic_dec(&rreq->nr_outstanding);
-					netfs_put_subrequest(subreq, false,
-							     netfs_sreq_trace_put_cancel);
-					break;
-				}
+				if (ret < 0)
+					goto prep_failed;
 				trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
 			}
 =

 			slice =3D netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
-				ret =3D slice;
-				break;
-			}
+			if (slice < 0)
+				goto prep_iter_failed;
 =

 			rreq->netfs_ops->issue_read(subreq);
 			goto done;
@@ -302,6 +294,8 @@ static void netfs_read_to_pagecache(struct netfs_io_re=
quest *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
 			slice =3D netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_iter_failed;
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -310,6 +304,8 @@ static void netfs_read_to_pagecache(struct netfs_io_re=
quest *rreq)
 		if (source =3D=3D NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice =3D netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_iter_failed;
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
@@ -318,6 +314,14 @@ static void netfs_read_to_pagecache(struct netfs_io_r=
equest *rreq)
 		WARN_ON_ONCE(1);
 		break;
 =

+	prep_iter_failed:
+		ret =3D slice;
+	prep_failed:
+		subreq->error =3D ret;
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+		break;
+
 	done:
 		size -=3D slice;
 		start +=3D slice;


