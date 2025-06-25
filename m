Return-Path: <linux-fsdevel+bounces-52958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DFBAE8BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E01BC58C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEF02D5C61;
	Wed, 25 Jun 2025 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6sb1Rau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F562D4B66
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874149; cv=none; b=q2WYtEkjtnd2eRoMDx/7oYRfw68KBWwuaxtgdYe00AMqlFsNRRkvvQZxy0usnWmq1Ux/a+aguoGCdjeGV3QaBvadBO8wUq110if/bEUWle6DbEiBCwZzQojZj1Z82CsVs4mH4FpETkdx/5myf25xBi8GwmUiq2+BlSCO1Ell8VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874149; c=relaxed/simple;
	bh=aCS4w1p/m9vmvmXRKmRbwkoccBqVIla1N5bIJ8vNO48=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=awKShzASFLFWQRiHvJRUcwbVC4+TilUtwIr9BmP/aDy3gAAy0gUKvYBcb/lqjSqx7pxJGEF50rQ37cmXiYif/kQ/v2RZbNQUKMdS//2pEGQnqgjQ9NLw+HVdeXNfTT5sXF0khStc+g0SnNwKUtUUxggLMLK1iaGu6WvzwP3KqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6sb1Rau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750874145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RUOylqOVWor4uhe+5G+Td0bk7o0Xqga9derNiT+GMEo=;
	b=H6sb1Rauef6134B+XTRdNbQCyQIC8MU4LVZWrf6hKoRCzjaYAq30bR4vTr5Yzzf4uCs2gk
	s1wqsqP5kbCr6V2L+UgvG9d4448IaMgQLoGi6A9sOz7ls0s9Q5ooY4LoWtoDFS8kyzrzHN
	M3TQDWhxA9yObvUwum07H85FHaudEXw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-tarC-zOmOh6BfV6hTK0Rkw-1; Wed,
 25 Jun 2025 13:55:44 -0400
X-MC-Unique: tarC-zOmOh6BfV6hTK0Rkw-1
X-Mimecast-MFC-AGG-ID: tarC-zOmOh6BfV6hTK0Rkw_1750874141
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A637D180047F;
	Wed, 25 Jun 2025 17:55:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4A8A19560A3;
	Wed, 25 Jun 2025 17:55:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org>
References: <658c6f4f-468b-4233-b49a-4c39a7ab03ab@samba.org> <20250625164213.1408754-1-dhowells@redhat.com> <20250625164213.1408754-13-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
    netfs@lists.linux.dev, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Steve French <stfrench@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 12/16] cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1422740.1750874135.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Jun 2025 18:55:35 +0100
Message-ID: <1422741.1750874135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Stefan Metzmacher <metze@samba.org> wrote:

> >   read_rfc1002_done:
> > +		/* SMBDirect will read it all or nothing */
> > +		msg->msg_iter.count =3D 0;
>
> I think we should be remove this.
> =

> And I think this patch should come after the
> CONFIG_HARDENED_USERCOPY change otherwise a bisect will trigger the prob=
lem.

Okay, done.  I've attached the revised version here.  I've also pushed it =
to
my git branch and switched patches 12 & 13 there.

David
---
cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code

When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
type 4" error and fails the I/O.  This is due to the switch-statement ther=
e
not handling the ITER_FOLIOQ handed down from netfslib.

Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
smbd_recv() and just using copy_to_iter() instead of memcpy().  This
future-proofs the function too, in case more ITER_* types are added.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smbdirect.c |  112 ++++++----------------------------------=
------
 1 file changed, 17 insertions(+), 95 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 0a9fd6c399f6..754e94a0e07f 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1778,35 +1778,39 @@ struct smbd_connection *smbd_get_connection(
 }
 =

 /*
- * Receive data from receive reassembly queue
+ * Receive data from the transport's receive reassembly queue
  * All the incoming data packets are placed in reassembly queue
- * buf: the buffer to read data into
+ * iter: the buffer to read data into
  * size: the length of data to read
  * return value: actual data read
- * Note: this implementation copies the data from reassebmly queue to rec=
eive
+ *
+ * Note: this implementation copies the data from reassembly queue to rec=
eive
  * buffers used by upper layer. This is not the optimal code path. A bett=
er way
  * to do it is to not have upper layer allocate its receive buffers but r=
ather
  * borrow the buffer from reassembly queue, and return it after data is
  * consumed. But this will require more changes to upper layer code, and =
also
  * need to consider packet boundaries while they still being reassembled.
  */
-static int smbd_recv_buf(struct smbd_connection *info, char *buf,
-		unsigned int size)
+int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 {
 	struct smbdirect_socket *sc =3D &info->socket;
 	struct smbd_response *response;
 	struct smbdirect_data_transfer *data_transfer;
+	size_t size =3D iov_iter_count(&msg->msg_iter);
 	int to_copy, to_read, data_read, offset;
 	u32 data_length, remaining_data_length, data_offset;
 	int rc;
 =

+	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) =3D=3D WRITE))
+		return -EINVAL; /* It's a bug in upper layer to get there */
+
 again:
 	/*
 	 * No need to hold the reassembly queue lock all the time as we are
 	 * the only one reading from the front of the queue. The transport
 	 * may add more entries to the back of the queue at the same time
 	 */
-	log_read(INFO, "size=3D%d info->reassembly_data_length=3D%d\n", size,
+	log_read(INFO, "size=3D%zd info->reassembly_data_length=3D%d\n", size,
 		info->reassembly_data_length);
 	if (info->reassembly_data_length >=3D size) {
 		int queue_length;
@@ -1844,7 +1848,10 @@ static int smbd_recv_buf(struct smbd_connection *in=
fo, char *buf,
 			if (response->first_segment && size =3D=3D 4) {
 				unsigned int rfc1002_len =3D
 					data_length + remaining_data_length;
-				*((__be32 *)buf) =3D cpu_to_be32(rfc1002_len);
+				__be32 rfc1002_hdr =3D cpu_to_be32(rfc1002_len);
+				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
+						 &msg->msg_iter) !=3D sizeof(rfc1002_hdr))
+					return -EFAULT;
 				data_read =3D 4;
 				response->first_segment =3D false;
 				log_read(INFO, "returning rfc1002 length %d\n",
@@ -1853,10 +1860,9 @@ static int smbd_recv_buf(struct smbd_connection *in=
fo, char *buf,
 			}
 =

 			to_copy =3D min_t(int, data_length - offset, to_read);
-			memcpy(
-				buf + data_read,
-				(char *)data_transfer + data_offset + offset,
-				to_copy);
+			if (copy_to_iter((char *)data_transfer + data_offset + offset,
+					 to_copy, &msg->msg_iter) !=3D to_copy)
+				return -EFAULT;
 =

 			/* move on to the next buffer? */
 			if (to_copy =3D=3D data_length - offset) {
@@ -1921,90 +1927,6 @@ static int smbd_recv_buf(struct smbd_connection *in=
fo, char *buf,
 	goto again;
 }
 =

-/*
- * Receive a page from receive reassembly queue
- * page: the page to read data into
- * to_read: the length of data to read
- * return value: actual data read
- */
-static int smbd_recv_page(struct smbd_connection *info,
-		struct page *page, unsigned int page_offset,
-		unsigned int to_read)
-{
-	struct smbdirect_socket *sc =3D &info->socket;
-	int ret;
-	char *to_address;
-	void *page_address;
-
-	/* make sure we have the page ready for read */
-	ret =3D wait_event_interruptible(
-		info->wait_reassembly_queue,
-		info->reassembly_data_length >=3D to_read ||
-			sc->status !=3D SMBDIRECT_SOCKET_CONNECTED);
-	if (ret)
-		return ret;
-
-	/* now we can read from reassembly queue and not sleep */
-	page_address =3D kmap_atomic(page);
-	to_address =3D (char *) page_address + page_offset;
-
-	log_read(INFO, "reading from page=3D%p address=3D%p to_read=3D%d\n",
-		page, to_address, to_read);
-
-	ret =3D smbd_recv_buf(info, to_address, to_read);
-	kunmap_atomic(page_address);
-
-	return ret;
-}
-
-/*
- * Receive data from transport
- * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
- * return: total bytes read, or 0. SMB Direct will not do partial read.
- */
-int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
-{
-	char *buf;
-	struct page *page;
-	unsigned int to_read, page_offset;
-	int rc;
-
-	if (iov_iter_rw(&msg->msg_iter) =3D=3D WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc =3D -EINVAL;
-		goto out;
-	}
-
-	switch (iov_iter_type(&msg->msg_iter)) {
-	case ITER_KVEC:
-		buf =3D msg->msg_iter.kvec->iov_base;
-		to_read =3D msg->msg_iter.kvec->iov_len;
-		rc =3D smbd_recv_buf(info, buf, to_read);
-		break;
-
-	case ITER_BVEC:
-		page =3D msg->msg_iter.bvec->bv_page;
-		page_offset =3D msg->msg_iter.bvec->bv_offset;
-		to_read =3D msg->msg_iter.bvec->bv_len;
-		rc =3D smbd_recv_page(info, page, page_offset, to_read);
-		break;
-
-	default:
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg type %d\n",
-			 iov_iter_type(&msg->msg_iter));
-		rc =3D -EINVAL;
-	}
-
-out:
-	/* SMBDirect will read it all or nothing */
-	if (rc > 0)
-		msg->msg_iter.count =3D 0;
-	return rc;
-}
-
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload


