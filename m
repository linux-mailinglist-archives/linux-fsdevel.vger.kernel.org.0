Return-Path: <linux-fsdevel+bounces-30312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F2989440
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 11:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3930D286511
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA51428FA;
	Sun, 29 Sep 2024 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9qxlis2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCEB14375C
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601172; cv=none; b=ebMhDSxG/YpJ4Faay+S1cqf1L4107BiF7jYgYTVY8cjzWARGhnrC2TAjRM1qUwbp9m8Dr0aIqGIR/yBybfpmudQiWaP/XMDjCsvbkvCYFylEF74b8K5UIBhcPpaFI3IBVoxaUe/q1fg9lCwogx8INfhm4fhLfe0GpLRU2hd5jbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601172; c=relaxed/simple;
	bh=f9dQE09AdUkmncuy/YNZ8fl3PlvEKyh1yrqvan2WfdA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=e/WID351WCseYEcTwTJ1sYhPE1GrkeAkcnZr2jyqVFAYJuFnhoV5if1JqWy22Lf+czU+GDiGrMejkzs9v/IuCXgUBjLCiEcWGo32FFshXr/AUmiqAOzXVQPipnEsySvxs9RUtrKLdvxSJwvfDlXfZAp4yiGhcL0OjzE3nB1Dyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9qxlis2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727601168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiqqlxmQYH/fiwHpJ0K7lC2A6lz/Rw3eIk1FtzNUMEY=;
	b=H9qxlis2y3VOGsiZ3bhL86nHU6iN0yBa1MCzv/Hd7lvs3cNOBUz+gTWyibgUe7hflptBNa
	HBiLgdEB6drxhp0N68kJdypgy/Q2O1FCy+VVlSM3+6w4w3mu+/4mZ2jEK2E33Qks+34rRZ
	lGCm4AbqSerwld8stht57TVSyPqzQOk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-ngDjsBEOMcCfzSSWO9NFYQ-1; Sun,
 29 Sep 2024 05:12:45 -0400
X-MC-Unique: ngDjsBEOMcCfzSSWO9NFYQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F5D4195FE25;
	Sun, 29 Sep 2024 09:12:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F1CB519560AE;
	Sun, 29 Sep 2024 09:12:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240925103118.GE967758@unreal>
References: <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: dhowells@redhat.com, Eduard Zingerman <eddyz87@gmail.com>,
    Christian Brauner <brauner@kernel.org>,
    Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2808174.1727601153.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 29 Sep 2024 10:12:33 +0100
Message-ID: <2808175.1727601153@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Can you try the attached?  I've also put it on my branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dnetfs-fixes

David
---
9p: Don't revert the I/O iterator after reading

Don't revert the I/O iterator before returning from p9_client_read_once().
netfslib doesn't require the reversion and nor doed 9P directory reading.

Make p9_client_read() use a temporary iterator to call down into
p9_client_read_once(), and advance that by the amount read.

Reported-by: Manu Bretelle <chantr4@gmail.com>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Reported-by: Leon Romanovsky <leon@kernel.org>
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


