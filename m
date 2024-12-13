Return-Path: <linux-fsdevel+bounces-37295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD819F0DC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF1284828
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50F1E049C;
	Fri, 13 Dec 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO0bkw+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1231E1C33
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097854; cv=none; b=CPgcQbt1KRcuKP5McW+ZtAUWHQrAPvWBDU3n9/VQsY8kaz9hP+6ef9T53bSBBz/YO9ISBa10ho5alIZJZx9PDr9+kEWoozAoa6E+UiySIaQP987WPlA14YqY9GSIqW8urLJiNHtguHLbuDvBRPMz4yFJC7FxFz6SmZpYL19zN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097854; c=relaxed/simple;
	bh=HvL11uix8o0JbcFVHm8hJwACLUwwabNlTI8so0gPq0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsp+cxF18AzWrUPneWFB+EUygcOyu7bxaE1NUaLSIhFxfgugpRR8BMnJaGGdeuZcJfsLOWpbfVWfqkWA9rOZDNPSfvQ9mY69sgc8jkVq7Vxwf7c7iHihlWztHmvuRzicY3qa6ZVWbIC3XyJnhqxqfSSWAdMU3Q6gPKZNg0eCJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO0bkw+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EP45p+cLd1dDJ3/M9yBe/6nHDozsGhktItpu1CrIpGQ=;
	b=CO0bkw+2IN32CacE5Xxn+1DuWemOUAK0O7XtxM3uGzL+v80/yx1+6hC7Yv03reZxmzeZpC
	4I+ZWVzUdV8PsHJ1mbnWBsPFtVuhyFB6mKqVWe8MDcMfJwv82kuV9+QDldFw+mqNS55tja
	Gfe0xIRiFkoXnC/iNx/vie80ocXNnaY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-UcRIgQcnN_-cN26AjAuVpA-1; Fri,
 13 Dec 2024 08:50:46 -0500
X-MC-Unique: UcRIgQcnN_-cN26AjAuVpA-1
X-Mimecast-MFC-AGG-ID: UcRIgQcnN_-cN26AjAuVpA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96F4C1955F28;
	Fri, 13 Dec 2024 13:50:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C692F1956052;
	Fri, 13 Dec 2024 13:50:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
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
	syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 03/10] netfs: Fix enomem handling in buffered reads
Date: Fri, 13 Dec 2024 13:50:03 +0000
Message-ID: <20241213135013.2964079-4-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If netfs_read_to_pagecache() gets an error from either ->prepare_read() or
from netfs_prepare_read_iterator(), it needs to decrement ->nr_outstanding,
cancel the subrequest and break out of the issuing loop.  Currently, it
only does this for two of the cases, but there are two more that aren't
handled.

Fix this by moving the handling to a common place and jumping to it from
all four places.  This is in preference to inserting a wrapper around
netfs_prepare_read_iterator() as proposed by Dmitry Antipov[1].

Link: https://lore.kernel.org/r/20241202093943.227786-1-dmantipov@yandex.ru/ [1]

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dmitry Antipov <dmantipov@yandex.ru>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 7ac34550c403..4dc9b8286355 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -275,22 +275,14 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			netfs_stat(&netfs_n_rh_download);
 			if (rreq->netfs_ops->prepare_read) {
 				ret = rreq->netfs_ops->prepare_read(subreq);
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
 
 			slice = netfs_prepare_read_iterator(subreq);
-			if (slice < 0) {
-				atomic_dec(&rreq->nr_outstanding);
-				netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
-				ret = slice;
-				break;
-			}
+			if (slice < 0)
+				goto prep_iter_failed;
 
 			rreq->netfs_ops->issue_read(subreq);
 			goto done;
@@ -302,6 +294,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			netfs_stat(&netfs_n_rh_zero);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_iter_failed;
 			__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 			netfs_read_subreq_terminated(subreq, 0, false);
 			goto done;
@@ -310,6 +304,8 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		if (source == NETFS_READ_FROM_CACHE) {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
 			slice = netfs_prepare_read_iterator(subreq);
+			if (slice < 0)
+				goto prep_iter_failed;
 			netfs_read_cache_to_pagecache(rreq, subreq);
 			goto done;
 		}
@@ -318,6 +314,14 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq)
 		WARN_ON_ONCE(1);
 		break;
 
+	prep_iter_failed:
+		ret = slice;
+	prep_failed:
+		subreq->error = ret;
+		atomic_dec(&rreq->nr_outstanding);
+		netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_cancel);
+		break;
+
 	done:
 		size -= slice;
 		start += slice;


