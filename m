Return-Path: <linux-fsdevel+bounces-38572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B14A04320
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DB51880712
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474961E9B06;
	Tue,  7 Jan 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATFsUVlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0179B13A3EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261383; cv=none; b=BtceG+2UdKq3LMHtRof54AwIwWbt7pVis2uUROpEJrdw+4VKR0mhouwvMYnM6BcTbhHpoGczK5b2ERQf9c0C22lDK4Jv3WZ7z8ZQA4Hb/VSv9NQ9Su5q0s71gXQ5wHILlg9q6FxpWxo1dTd8/yJdbc1Q17YWvJi1r8Us8HxETNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261383; c=relaxed/simple;
	bh=TF0Gz84jRGrkGnZqNdmahY6EATRHL+OsW3Xa2ggzBeE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=U/s6EuKjjT7WhV9oC5vGeWMoKRvKmZ0crxpzQMaET9VMpC0b+lwOng6AbzTz9WtLXad/y3h46X3KCFaiQy5fIdNEgKNBOhAu6PFXj5o23WeBhl/5jWth1JKj3R0Fx+XBlFkj8NRMRs8/cVgUYdiN2J6EK0lxLePl317JRhpTLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATFsUVlL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teAJr1H0yek2ezTiflo93wXsSS9M7JgmNyDuPB+aFlQ=;
	b=ATFsUVlLd21TUZvQqu8k6BFwvLmM4jmhFOWcchusO1P9VHvPVLcx/UbjmHHCKnSJIGY+rr
	kAjm6YB6FFqkmaA1El++rOCBl6dzNEMJatcphozRQIP7bKUY7534bF/F7+WPg+bj1O49c2
	RXo6hsxS7th9TIqZ9YkI/4jlFBLCcS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-iQFec9jtNPScv5VC8Ded1w-1; Tue,
 07 Jan 2025 09:49:35 -0500
X-MC-Unique: iQFec9jtNPScv5VC8Ded1w-1
X-Mimecast-MFC-AGG-ID: iQFec9jtNPScv5VC8Ded1w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D5881955F44;
	Tue,  7 Jan 2025 14:49:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE5121956088;
	Tue,  7 Jan 2025 14:49:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <d98ca4470c447182020b576841115a20@3xo.fr>
References: <d98ca4470c447182020b576841115a20@3xo.fr> <fedd8a40d54b2969097ffa4507979858@3xo.fr> <669f22fc89e45dd4e56d75876dc8f2bf@3xo.fr> <286638.1736163444@warthog.procyon.org.uk> <b3e8129937055ff8971d8be44286f0b8@3xo.fr>
To: nicolas.baranger@3xo.fr
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Christoph Hellwig <hch@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix kernel async DIO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <529744.1736261367.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 14:49:28 +0000
Message-ID: <529745.1736261368@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Thanks!

I ported the patch to linus/master (see below) and it looks pretty much th=
e
same as yours, give or take tabs getting converted to spaces.

Could I put you down as a Tested-by?

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


