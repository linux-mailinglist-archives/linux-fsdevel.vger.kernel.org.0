Return-Path: <linux-fsdevel+bounces-38603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920F3A04961
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DBE166774
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5C1F37C8;
	Tue,  7 Jan 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SL6NOU3h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3AB1F2C35
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275181; cv=none; b=mD9FskN1N7CiveUbC3czfgwG1sitNHa1K8EfaiBFz0wzBlwbRrH5W5R/3dRvqh2OzV3t0uG8mJtDIxUymkYO5dGUHdILc/RA3yfzZq1/YmFaLAdHMuECVh+qN26NNi3b/FoweTH1+h6Np6wqOmeUEfYca1bYLMhYU90TiOETEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275181; c=relaxed/simple;
	bh=5WYXUpQPGVXhqaV9VdfXAy839GK5dHFgwTrPjPlMdXA=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=kalMSucVb+CC6ARgOBxKjGlv1/U1ugzSh7I+n7vDfeQoYLjs4YtVblethYAvoP1+Yu7x9EdjALLTLKlTwic6DAsw0HO+wAr/8mcoKr1xurrirGNtDNpT6yn7s5r7XH6O7y4jnQFUt6YAtnPyOpBYOwKb8KJsqb5v3h31jX8ONxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SL6NOU3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736275176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P1+ypZtOfhvrgbMyRTn27M8yHHraLIlusZRvt7dT4ko=;
	b=SL6NOU3hx119crocT4/Ym3IhsUbrLCOK2tDqHvrHEEG+sVGVSzNM90oJPfJRJZk40YgP5G
	QXQRSIDiK0K/t0WXxseMHiRjhpaZoqYhRHWUBA6a0tSbqaYfdiIeS39uh0pyqgAXn6rptF
	EIksU/QvbaCRXbMGyOlDBnfPkPcJNd4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-C6BJI74wO4id5nc8uicbFQ-1; Tue,
 07 Jan 2025 13:39:33 -0500
X-MC-Unique: C6BJI74wO4id5nc8uicbFQ-1
X-Mimecast-MFC-AGG-ID: C6BJI74wO4id5nc8uicbFQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4645A1956089;
	Tue,  7 Jan 2025 18:39:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 821BC3000197;
	Tue,  7 Jan 2025 18:39:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Nicolas Baranger <nicolas.baranger@3xo.fr>,
    Paulo Alcantara (Red Hat) <pc@manguebit.com>,
    Steve French <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix kernel async DIO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <608724.1736275167.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 18:39:27 +0000
Message-ID: <608725.1736275167@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Netfslib needs to be able to handle kernel-initiated asynchronous DIO that
is supplied with a bio_vec[] array.  Currently, because of the async flag,
this gets passed to netfs_extract_user_iter() which throws a warning and
fails because it only handles IOVEC and UBUF iterators.  This can be
triggered through a combination of cifs and a loopback blockdev with
something like:

        mount //my/cifs/share /foo
        dd if=3D/dev/zero of=3D/foo/m0 bs=3D4K count=3D1K
        losetup --sector-size 4096 --direct-io=3Don /dev/loop2046 /foo/m0
        echo hello >/dev/loop2046

This causes the following to appear in syslog:

        WARNING: CPU: 2 PID: 109 at fs/netfs/iterator.c:50 netfs_extract_u=
ser_iter+0x170/0x250 [netfs]

and the write to fail.

Fix this by removing the check in netfs_unbuffered_write_iter_locked() tha=
t
causes async kernel DIO writes to be handled as userspace writes.  Note
that this change relies on the kernel caller maintaining the existence of
the bio_vec array (or kvec[] or folio_queue) until the op is complete.

Fixes: 153a9961b551 ("netfs: Implement unbuffered/DIO write support")
Reported-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Closes: https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Steve French <smfrench@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 173e8b5e6a93..f9421f3e6d37 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb =
*iocb, struct iov_iter *
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
 		 */
-		if (async || user_backed_iter(iter)) {
+		if (user_backed_iter(iter)) {
 			n =3D netfs_extract_user_iter(iter, len, &wreq->iter, 0);
 			if (n < 0) {
 				ret =3D n;
@@ -77,6 +77,11 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb=
 *iocb, struct iov_iter *
 			wreq->direct_bv_count =3D n;
 			wreq->direct_bv_unpin =3D iov_iter_extract_will_pin(iter);
 		} else {
+			/* If this is a kernel-generated async DIO request,
+			 * assume that any resources the iterator points to
+			 * (eg. a bio_vec array) will persist till the end of
+			 * the op.
+			 */
 			wreq->iter =3D *iter;
 		}
 =


