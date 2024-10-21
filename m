Return-Path: <linux-fsdevel+bounces-32518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C39A9161
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 22:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB2C2820AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 20:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D51FDF85;
	Mon, 21 Oct 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo+h687T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB51FCF57
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543115; cv=none; b=f63yrvsqs83Ex4XqU06v7fTlxmblBh7rk1/g8sQn+MCifFmyvEMB4pJsw64+TKL9PzLg8jQtdJfR4UlxGGYirO3Gkdo8sypXcqGXc5wl5IfiLOKSn6r9/EPKdg+RIkC9xroO+t6v/YC8YSNZpVZ6uwC1Duvuehfr+CXsUC+guWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543115; c=relaxed/simple;
	bh=Cos8ohnYr0F4jqaXj+BTslQpRTXcBuFfx3VTxeLwQTk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=GOm5rWlUWwtELYVqTNuLreM4SQ5MHmYi378Y9hDLnJjouJM+vP5oAHSspMwJpPtH4JXGs1Z/5Y7tD7tZ/yHXtd9n8zisEeuL21trKxRl+WO+4ftdZB0TAX3d2tF7pC70CjwNrB91uRYTfVYZtnZUjwMF5Ho/dzxqzQTwvtQUZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wo+h687T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729543113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hFqUYZDvnqQ0+7pFuY+npHBOiAQbpvlJjd9i7zKW2g=;
	b=Wo+h687Tch78PoS+au1mvc3Ozfzc6x31e7KHDaFOe7lxqrArPhIWdS4PVX0Gz+VWjRkZQk
	YfFgfuTGsvpCkJBRIDmcdximQxPk0/wGa+p/bvo8RsBAz+ewk+Gu6IKq/l6wJ8pYPACsYK
	XVfAFaHTMrQL4dvQW5r5hA/hxTzsbE4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-MlI_3gj7OBqbeg-NnrihHA-1; Mon,
 21 Oct 2024 16:38:29 -0400
X-MC-Unique: MlI_3gj7OBqbeg-NnrihHA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30B681955D55;
	Mon, 21 Oct 2024 20:38:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99AC119560A2;
	Mon, 21 Oct 2024 20:38:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxFQw4OI9rrc7UYc@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
To: Antony Antony <antony@phenome.org>
Cc: dhowells@redhat.com, Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>,
    Linux regressions mailing list <regressions@lists.linux.dev>,
    LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>
Subject: [PATCH] 9p: Don't revert the I/O iterator after reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2299158.1729543103.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Oct 2024 21:38:23 +0100
Message-ID: <2299159.1729543103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Antony,

I think I may have a fix already lurking on my netfs-writeback branch for =
the
next merge window.  Can you try the attached?

David
---
Don't revert the I/O iterator before returning from p9_client_read_once().
netfslib doesn't require the reversion and nor doed 9P directory reading.

Make p9_client_read() use a temporary iterator to call down into
p9_client_read_once(), and advance that by the amount read.

Reported-by: Antony Antony <antony@phenome.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 net/9p/client.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5cd94721d974..be59b0a94eaf 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1519,13 +1519,15 @@ p9_client_read(struct p9_fid *fid, u64 offset, str=
uct iov_iter *to, int *err)
 	*err =3D 0;
 =

 	while (iov_iter_count(to)) {
+		struct iov_iter tmp =3D *to;
 		int count;
 =

-		count =3D p9_client_read_once(fid, offset, to, err);
+		count =3D p9_client_read_once(fid, offset, &tmp, err);
 		if (!count || *err)
 			break;
 		offset +=3D count;
 		total +=3D count;
+		iov_iter_advance(to, count);
 	}
 	return total;
 }
@@ -1567,16 +1569,12 @@ p9_client_read_once(struct p9_fid *fid, u64 offset=
, struct iov_iter *to,
 	}
 	if (IS_ERR(req)) {
 		*err =3D PTR_ERR(req);
-		if (!non_zc)
-			iov_iter_revert(to, count - iov_iter_count(to));
 		return 0;
 	}
 =

 	*err =3D p9pdu_readf(&req->rc, clnt->proto_version,
 			   "D", &received, &dataptr);
 	if (*err) {
-		if (!non_zc)
-			iov_iter_revert(to, count - iov_iter_count(to));
 		trace_9p_protocol_dump(clnt, &req->rc);
 		p9_req_put(clnt, req);
 		return 0;
@@ -1596,8 +1594,6 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, =
struct iov_iter *to,
 			p9_req_put(clnt, req);
 			return n;
 		}
-	} else {
-		iov_iter_revert(to, count - received - iov_iter_count(to));
 	}
 	p9_req_put(clnt, req);
 	return received;


