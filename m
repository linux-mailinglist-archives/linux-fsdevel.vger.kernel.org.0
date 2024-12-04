Return-Path: <linux-fsdevel+bounces-36461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DF9E3C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447DC2813A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6251FA16B;
	Wed,  4 Dec 2024 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMgHRE3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F111F7096
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321496; cv=none; b=jq+1d5A/cFVNyK8Iecd4FMclSj5XBwnecNPHrsMui7S/OfD649TApriQ6jjFq8R0L3WwzNXKwWvqbMqoQXsiMMGaFbuq0LHrlnPf4OQu6ge9UfrDKFRMFPnPP1pEntepw9awH0CHel4HUQoi7EvltogDCvtFE2n+8sUjdhZfOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321496; c=relaxed/simple;
	bh=Olq8n9V/c4ByFTjwghd3RJxLHgwGeb1Qki0jTylZSXg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hgdIUnFJK5y0jqtpJhD15zm+M1WFOgdVbHPFBqxremyEOlHJ++saLtgBZRhBs5S/fPjGte11n1IAbPeMJMlFDuhxe5l4N2T68c5S3EoR5XAP6Whzh3oQEyTjOvD1rkfpKSWiLGCqrv7QhP87+KYHe5lxU5ZSwvaJuwomvQezGMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMgHRE3B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733321492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bC3keQdTl30q+RF/rmG2+pay8wGwfywBaMyPdC8zJk=;
	b=EMgHRE3BiDb1ZUSyDvQIbcI4UGeFUIIpC5Fi9dcq1DKYuYnCKMAXwjT4s1owS0yp5Xls+U
	jqyK0zFXFYtuVOClGb0C4Egi11yT4VoPBwjSGZT2g/YCW+8BmEsZ4VJCklWYt63oDenAUa
	tFOFIeCgwi5Q9+wIhgd2YvX6KfX3+MY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-kpMovubyMEK9BYAP0K7I0w-1; Wed,
 04 Dec 2024 09:11:31 -0500
X-MC-Unique: kpMovubyMEK9BYAP0K7I0w-1
X-Mimecast-MFC-AGG-ID: kpMovubyMEK9BYAP0K7I0w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3B571955F40;
	Wed,  4 Dec 2024 14:11:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA46D19560A2;
	Wed,  4 Dec 2024 14:11:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <67238110.050a0220.35b515.015e.GAE@google.com>
References: <67238110.050a0220.35b515.015e.GAE@google.com>
To: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1129890.1733321485.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Dec 2024 14:11:25 +0000
Message-ID: <1129891.1733321485@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t v6.13-rc1

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


