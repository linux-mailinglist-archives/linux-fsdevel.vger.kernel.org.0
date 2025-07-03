Return-Path: <linux-fsdevel+bounces-53810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71AAF78C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F10485D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC346126BFF;
	Thu,  3 Jul 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eJHfbN2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF32EF9B3;
	Thu,  3 Jul 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554346; cv=none; b=IqV6aYY3AzxlLoieAPRZLQlg9RyS59gFrMrTno50rO8T/13AaIGhOquW9GiLIHPPtT7cIiARdno5Lc3r/wTPshvwujUDtPFyWRz5yawO4gu2Q+cHt4rsgA8tPDAhEFdkC0rqDCYEwR3nw0H0akbrnzoGfuKewc6f3kIIwNdePEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554346; c=relaxed/simple;
	bh=eRgT+2Gph9S7743DvzrG0+LQa+QYTUPzMjRICc6+qns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku/GGh89/FRehi8zLcKS1pljRPcm9s1YddvK5m5k6WwvwAdgZM8fqRcrBI21DeBu+RQbIjoD3zdCuaPoox5UnaEXg/6nou2z/23bK8zIT72O/wiUISFVTfA+vkafIsdUzpILit3upz88xxK3+EX0ok0USRvX7y7Z3sTuBNzfH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eJHfbN2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59886C4CEE3;
	Thu,  3 Jul 2025 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554345;
	bh=eRgT+2Gph9S7743DvzrG0+LQa+QYTUPzMjRICc6+qns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJHfbN2vVpoQ9v/GzP9DpWLYONyCS+ELxH+fBoFgk2KrqhJxj3UF+Jn6ecusxMDR3
	 wxnVoqNyyaoZoXyYGD/80HW5tvMbdgvh6lk5CJPx+Qg3kOiWJ0MGGxxacbOVLmmWFt
	 aBmyZnkTOXFI3mzo/j2L2+7/srGb/0kRoz0JatFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	David Howells <dhowells@redhat.com>,
	Tom Talpey <tom@talpey.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 126/218] cifs: Fix reading into an ITER_FOLIOQ from the smbdirect code
Date: Thu,  3 Jul 2025 16:41:14 +0200
Message-ID: <20250703144001.150104592@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 263debecb4aa7cec0a86487e6f409814f6194a21 ]

When performing a file read from RDMA, smbd_recv() prints an "Invalid msg
type 4" error and fails the I/O.  This is due to the switch-statement there
not handling the ITER_FOLIOQ handed down from netfslib.

Fix this by collapsing smbd_recv_buf() and smbd_recv_page() into
smbd_recv() and just using copy_to_iter() instead of memcpy().  This
future-proofs the function too, in case more ITER_* types are added.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tom Talpey <tom@talpey.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smbdirect.c | 112 ++++++--------------------------------
 1 file changed, 17 insertions(+), 95 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index b7932f63b4650..ac06f2617f346 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1755,35 +1755,39 @@ struct smbd_connection *smbd_get_connection(
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
@@ -1821,7 +1825,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
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
@@ -1830,10 +1837,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
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
@@ -1898,90 +1904,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
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
-- 
2.39.5




