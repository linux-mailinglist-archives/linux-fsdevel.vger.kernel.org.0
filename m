Return-Path: <linux-fsdevel+bounces-20026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636758CC942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 00:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B52825A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 22:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471C1494BC;
	Wed, 22 May 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+RYVuQg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F0146A71
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418748; cv=none; b=q2fMMk291lhZoxMru2UsS+erPCSYrilhrI6KCAB4z0Rhvk/KX58WPlLg1H2PIV7Ajd0uKHpdHCN0ydE9qWejQS/56e2/VBWgjz9Mcs4KnNL1nGr6uCXa+VQqCnm1ljQ34ifY9FDI21xw17gl2cwcHjt+vu/Ay8JnWh6EyTynMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418748; c=relaxed/simple;
	bh=lUyseyhrTphGdKiHxqU49ao7Ry2K6n4epBhRL331XWI=;
	h=To:cc:Subject:MIME-Version:Content-Type:From:Date:Message-ID; b=FJJNPqZXchxXhejwY0aQ5ASIkcP4+/e8G5wi5mN9GRPXYKyYpADZho8NnXo114++gPneoGkqE5/Vll4ICHe2XNz5NsMyLamqxw49IulhXP/bYoffXu8X2fBQqBYgq5Fb+rxSgK0OZjHmIq5gkNOxIVu6uYjFZd1YrzHc6szIq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+RYVuQg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716418746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aLGhBNxsqVskXvt4vSfXPq+TZr8BC8vuqNTuesM2U10=;
	b=H+RYVuQgcS5/+RCMUvdwlYcx9J3hmch6SrXCqk74tndkFZNGYmezxSel52njgrURhxjpNF
	9xeYdUJKxidg1V+lswy7oiwLzWHkgwb+7b5k5vfE1HFZg8izrEfWbsA7qPF9jeHRgm6NfK
	A2/NqvjGUVdCxpZz15NQrrX61v5WriM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-N82oH1LtPryF20wyqw928w-1; Wed, 22 May 2024 18:59:04 -0400
X-MC-Unique: N82oH1LtPryF20wyqw928w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E4BA800169;
	Wed, 22 May 2024 22:59:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0871C561A;
	Wed, 22 May 2024 22:59:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [RFC PATCH] cifs: Fix credit handling in cifs_io_subrequest cleanup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <469429.1716418699.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2024 23:59:02 +0100
Message-ID: <469451.1716418742@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

    =

When a cifs_io_subrequest (wrapping a netfs_io_subrequest) is cleaned up i=
n
cifs_free_subrequest(), it releases any credits that are left in
rdata->credits.  However, this is a problem because smb2_writev_callback()
calls add_credits() to add the new credits from the response header
CreditRequest to the available pool.

This can cause a warning to be emitted in smb2_add_credits() as
server->in_flight gets doubly decremented and a later operation sees it
having prematurely reached 0.

Fix this by clearing the credit count after actually issuing the request o=
n
the assumption that we've given the credits back to the server (it will
give us new credits in the reply).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/file.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9d5c2440abfc..73e2765c4d2f 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -110,6 +110,7 @@ static void cifs_issue_write(struct netfs_io_subreques=
t *subreq)
 		goto fail;
 =

 	wdata->server->ops->async_writev(wdata);
+	wdata->credits.value =3D 0;
 out:
 	return;
 =

@@ -205,10 +206,12 @@ static void cifs_req_issue_read(struct netfs_io_subr=
equest *subreq)
 =

 	rc =3D adjust_credits(rdata->server, &rdata->credits, rdata->subreq.len)=
;
 	if (!rc) {
-		if (rdata->req->cfile->invalidHandle)
+		if (rdata->req->cfile->invalidHandle) {
 			rc =3D -EAGAIN;
-		else
+		} else {
 			rc =3D rdata->server->ops->async_readv(rdata);
+			rdata->credits.value =3D 0;
+		}
 	}
 =

 out:


