Return-Path: <linux-fsdevel+bounces-38425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E285A02468
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1A160F97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40791DB924;
	Mon,  6 Jan 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+slmJug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623791D6182
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163457; cv=none; b=khhkF5OSdnquHHVz8T4UeryZAQZF3k4VXmIchOd0k70pw2zHs9BsDGEGCwVV83X/XCN9MlK/mqBbVk7/HcpII4QvhP0z1AEPtz42mVj9BWp0cJYdlRH+XurCR0tx/4NUX8Z54ECXhn/MYmXDcFjLkeN7GJ2D1sC+o4lBmJcRB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163457; c=relaxed/simple;
	bh=vSkL70mPa9ZU0T2jcqCFDByTZW4036xqdGj/g8j0Pcc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HvcmNH+IM/VpUD3Go6uXtA3BiAIrsjxFwGLM4HoPrAETswjQFxZkOiSaAVWPIXpg3dajuRrs5FWVmr0BE+wCFoshMkI/4YK0EyP6efCdNAWNPSRHAqxu5zqeZAZayh53axCi22KF67Vl4ixqcbcTe0FD4+mOVuUXGqCRffPfABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+slmJug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736163453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp15SreWS1fhtE7z/OTQXIsjz7AhnxT/exdmyKm2weg=;
	b=e+slmJugWOR4eZqRZ9JElrYZ0o7LQg6blsZdE36JSb5th4pBWBLv3fKjpsZDx+Jz+EtS54
	oDyQx6CEiOLyEmtB3ZB1x+IIlvnQNeZsZpbM+qQfyD/lTg5fJNID5BPc6+eWY2c39NUBIa
	ZykNv/teCDxQ41T+H7AdAuSTFpT8opM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-9tlihHwDM_G6dW8v7aOHtQ-1; Mon,
 06 Jan 2025 06:37:30 -0500
X-MC-Unique: 9tlihHwDM_G6dW8v7aOHtQ-1
X-Mimecast-MFC-AGG-ID: 9tlihHwDM_G6dW8v7aOHtQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 740D3195608C;
	Mon,  6 Jan 2025 11:37:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BC9D1956056;
	Mon,  6 Jan 2025 11:37:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <fedd8a40d54b2969097ffa4507979858@3xo.fr>
References: <fedd8a40d54b2969097ffa4507979858@3xo.fr> <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr>
To: nicolas.baranger@3xo.fr
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Christoph Hellwig <hch@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix kernel async DIO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <286637.1736163444.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jan 2025 11:37:24 +0000
Message-ID: <286638.1736163444@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Nicolas,

Does the attached fix your problem?

David
---
netfs: Fix kernel async DIO

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
Reported by: Nicolas Baranger <nicolas.baranger@3xo.fr>
Closes: https://lore.kernel.org/r/fedd8a40d54b2969097ffa4507979858@3xo.fr/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <smfrench@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index eded8afaa60b..42ce53cc216e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -67,7 +67,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb =
*iocb, struct iov_iter *
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
 		 */
-		if (async || user_backed_iter(iter)) {
+		if (user_backed_iter(iter)) {
 			n =3D netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
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
 			wreq->buffer.iter =3D *iter;
 		}
 	}


