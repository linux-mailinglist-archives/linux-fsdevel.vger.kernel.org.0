Return-Path: <linux-fsdevel+bounces-52948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B9AE8A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1606F3B498A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B72ED175;
	Wed, 25 Jun 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHAP5aJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820432DFA2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869812; cv=none; b=uYW3TV9ETXHzTax7VgIoQMT+4ZT5a//ewP1tQTfH900PwaZs/w09KMiDhanUVvhbCchg/RkmTO5HR2WNiC8U/K9DpryneNPTR6VuId/ltdBdHJbDl5iEBWe9KkUx4g6zOgyYG2YNIiEiqz1hK+Yaf97wg9nRCM7IxKa9fMfFXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869812; c=relaxed/simple;
	bh=0S7Wb2Ayru7zxU3qzn80qEG3N84qFnB6/qthu5wYMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQwpluRHaOJhpQ9a8oB2bduu5fMqbkxu8spbD6ZUuSHjRsK9zhB/B77WYxm1EdN18kGVYYn0WXNavGB+yXTj9omT9mPqwn/5t+iXxLfqbiw1uIyBGAhuXxYPuIMO1Msu+PAOnlk+WzylKYv2ORqPhlsxZoMFFduE0IwbJJUSva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHAP5aJ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4v+u+1rM8Ekf5NVVpiW18gc8WO84+L9XnF1ABQbI6tU=;
	b=jHAP5aJ6JomxIQtqEEs5VoGHgG9J6FcS1AAl6SBEIcF4laNCmE5S83PMp8Clmc3ZxFc9Pe
	dY9MuS83OAIGFkE2x2zS6doWN4AaNcw2nq81o0Ak+QU1zByLal9rj69/XJaFZT6sew//gT
	JiZZWWo5ncaTpFwpTWCXXxjH6Li6o9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-0vhc79CuOq6KNev3OCSRqw-1; Wed,
 25 Jun 2025 12:43:26 -0400
X-MC-Unique: 0vhc79CuOq6KNev3OCSRqw-1
X-Mimecast-MFC-AGG-ID: 0vhc79CuOq6KNev3OCSRqw_1750869804
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 105CF1800268;
	Wed, 25 Jun 2025 16:43:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBC3A195608D;
	Wed, 25 Jun 2025 16:43:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 12/16] cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
Date: Wed, 25 Jun 2025 17:42:07 +0100
Message-ID: <20250625164213.1408754-13-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
type 4" error and fails the I/O.  This is due to the switch-statement there
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
 fs/smb/client/smbdirect.c | 114 +++++++-------------------------------
 1 file changed, 19 insertions(+), 95 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index a976bcf61226..5fa46b2e682c 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1770,35 +1770,39 @@ struct smbd_connection *smbd_get_connection(
 }
 
 /*
- * Receive data from receive reassembly queue
+ * Receive data from the transport's receive reassembly queue
  * All the incoming data packets are placed in reassembly queue
- * buf: the buffer to read data into
+ * iter: the buffer to read data into
  * size: the length of data to read
  * return value: actual data read
- * Note: this implementation copies the data from reassebmly queue to receive
+ *
+ * Note: this implementation copies the data from reassembly queue to receive
  * buffers used by upper layer. This is not the optimal code path. A better way
  * to do it is to not have upper layer allocate its receive buffers but rather
  * borrow the buffer from reassembly queue, and return it after data is
  * consumed. But this will require more changes to upper layer code, and also
  * need to consider packet boundaries while they still being reassembled.
  */
-static int smbd_recv_buf(struct smbd_connection *info, char *buf,
-		unsigned int size)
+int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 {
 	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_response *response;
 	struct smbdirect_data_transfer *data_transfer;
+	size_t size = iov_iter_count(&msg->msg_iter);
 	int to_copy, to_read, data_read, offset;
 	u32 data_length, remaining_data_length, data_offset;
 	int rc;
 
+	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
+		return -EINVAL; /* It's a bug in upper layer to get there */
+
 again:
 	/*
 	 * No need to hold the reassembly queue lock all the time as we are
 	 * the only one reading from the front of the queue. The transport
 	 * may add more entries to the back of the queue at the same time
 	 */
-	log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
+	log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
 		info->reassembly_data_length);
 	if (info->reassembly_data_length >= size) {
 		int queue_length;
@@ -1836,7 +1840,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			if (response->first_segment && size == 4) {
 				unsigned int rfc1002_len =
 					data_length + remaining_data_length;
-				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+				__be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
+				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
+						 &msg->msg_iter) != sizeof(rfc1002_hdr))
+					return -EFAULT;
 				data_read = 4;
 				response->first_segment = false;
 				log_read(INFO, "returning rfc1002 length %d\n",
@@ -1845,10 +1852,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			}
 
 			to_copy = min_t(int, data_length - offset, to_read);
-			memcpy(
-				buf + data_read,
-				(char *)data_transfer + data_offset + offset,
-				to_copy);
+			if (copy_to_iter((char *)data_transfer + data_offset + offset,
+					 to_copy, &msg->msg_iter) != to_copy)
+				return -EFAULT;
 
 			/* move on to the next buffer? */
 			if (to_copy == data_length - offset) {
@@ -1893,6 +1899,8 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			 data_read, info->reassembly_data_length,
 			 info->first_entry_offset);
 read_rfc1002_done:
+		/* SMBDirect will read it all or nothing */
+		msg->msg_iter.count = 0;
 		return data_read;
 	}
 
@@ -1913,90 +1921,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 	goto again;
 }
 
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
-	struct smbdirect_socket *sc = &info->socket;
-	int ret;
-	char *to_address;
-	void *page_address;
-
-	/* make sure we have the page ready for read */
-	ret = wait_event_interruptible(
-		info->wait_reassembly_queue,
-		info->reassembly_data_length >= to_read ||
-			sc->status != SMBDIRECT_SOCKET_CONNECTED);
-	if (ret)
-		return ret;
-
-	/* now we can read from reassembly queue and not sleep */
-	page_address = kmap_atomic(page);
-	to_address = (char *) page_address + page_offset;
-
-	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
-		page, to_address, to_read);
-
-	ret = smbd_recv_buf(info, to_address, to_read);
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
-	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc = -EINVAL;
-		goto out;
-	}
-
-	switch (iov_iter_type(&msg->msg_iter)) {
-	case ITER_KVEC:
-		buf = msg->msg_iter.kvec->iov_base;
-		to_read = msg->msg_iter.kvec->iov_len;
-		rc = smbd_recv_buf(info, buf, to_read);
-		break;
-
-	case ITER_BVEC:
-		page = msg->msg_iter.bvec->bv_page;
-		page_offset = msg->msg_iter.bvec->bv_offset;
-		to_read = msg->msg_iter.bvec->bv_len;
-		rc = smbd_recv_page(info, page, page_offset, to_read);
-		break;
-
-	default:
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg type %d\n",
-			 iov_iter_type(&msg->msg_iter));
-		rc = -EINVAL;
-	}
-
-out:
-	/* SMBDirect will read it all or nothing */
-	if (rc > 0)
-		msg->msg_iter.count = 0;
-	return rc;
-}
-
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload


