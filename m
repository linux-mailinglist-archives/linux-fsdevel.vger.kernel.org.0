Return-Path: <linux-fsdevel+bounces-10383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49284A9B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99763B25C01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048B4E1C3;
	Mon,  5 Feb 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyOsQyxs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFF94D109
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173870; cv=none; b=jvlpNdcOOC2PT/zPVT5FgSFGmY36aC4QHFFLF5rVMO2hfn0oxrctV/N6L7MlL3ZMDIhmcIlyKAAxTLOTqp+q589KJDQBP6KfylTx5MWqm1PLVHdnUKT9CYOEjnPzbjjf5dzEMK1zdtNspsw70rwQtKIaBFq58TNg5AfXXjAjHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173870; c=relaxed/simple;
	bh=YnvrjpP+1mlPltPyneC8mOp31s+PrxG2XoHGAQxYZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEdwwwWDIsv13QrZwi0TYHlPg11b0XRxgPWnUwNhz62XD0wag913DpLtDFZpMpoYE8w4DeCKzLU79SZX7Vgbsf84i/lotJ8MqCQF99qlB6EFsyW+MCS1pEbuA87gwrit/d0prY5aS9eq68hKtBx98J5UgNL5X+ZhstwkzW8ri90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyOsQyxs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707173866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4I6fU7/4wPT+PYoUIdLLREVRUQVIkIPSriBzY+bMogw=;
	b=NyOsQyxse20utgho0P1R1x/eCPrurjYo+7BugLXD2K2pDHnB1oCAQ/+wNpuIDCvhfSWBNk
	UGv7WX6fVrHUeHHxndYalDHzSeuxlz/MNMAHS1/YuKZP56sTFoaYZwfR5IT+3MuO1aYXTZ
	i/Kgi/lsX5XCLTshDGtwAuBk34fMdyc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-OygGiR3FO4eTM_n7IadjIQ-1; Mon, 05 Feb 2024 17:57:43 -0500
X-MC-Unique: OygGiR3FO4eTM_n7IadjIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E7F08870E0;
	Mon,  5 Feb 2024 22:57:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F176C492BF0;
	Mon,  5 Feb 2024 22:57:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v5 04/12] cifs: Use more fields from netfs_io_subrequest
Date: Mon,  5 Feb 2024 22:57:16 +0000
Message-ID: <20240205225726.3104808-5-dhowells@redhat.com>
In-Reply-To: <20240205225726.3104808-1-dhowells@redhat.com>
References: <20240205225726.3104808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Use more fields from netfs_io_subrequest instead of those incorporated into
cifs_io_subrequest from cifs_readdata and cifs_writedata.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsglob.h  |   3 -
 fs/smb/client/cifssmb.c   |  52 +++++++++---------
 fs/smb/client/file.c      | 112 +++++++++++++++++++-------------------
 fs/smb/client/smb2ops.c   |   4 +-
 fs/smb/client/smb2pdu.c   |  52 +++++++++---------
 fs/smb/client/transport.c |   6 +-
 6 files changed, 113 insertions(+), 116 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7f7073813612..cac10f8e17e4 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1487,9 +1487,6 @@ struct cifs_io_subrequest {
 	struct list_head		list;
 	struct completion		done;
 	struct work_struct		work;
-	struct iov_iter			iter;
-	__u64				offset;
-	unsigned int			bytes;
 };
 
 /*
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 1ead867a0f4a..b1c33a624157 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1269,12 +1269,12 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
-				 .rq_iter = rdata->iter };
+				 .rq_iter = rdata->subreq.io_iter };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%u\n",
+	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
-		 rdata->bytes);
+		 rdata->subreq.len);
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -1322,14 +1322,14 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2 };
 
-	cifs_dbg(FYI, "%s: offset=%llu bytes=%u\n",
-		 __func__, rdata->offset, rdata->bytes);
+	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
+		 __func__, rdata->subreq.start, rdata->subreq.len);
 
 	if (tcon->ses->capabilities & CAP_LARGE_FILES)
 		wct = 12;
 	else {
 		wct = 10; /* old style read */
-		if ((rdata->offset >> 32) > 0)  {
+		if ((rdata->subreq.start >> 32) > 0)  {
 			/* can not handle this big offset for old */
 			return -EIO;
 		}
@@ -1344,12 +1344,12 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = rdata->cfile->fid.netfid;
-	smb->OffsetLow = cpu_to_le32(rdata->offset & 0xFFFFFFFF);
+	smb->OffsetLow = cpu_to_le32(rdata->subreq.start & 0xFFFFFFFF);
 	if (wct == 12)
-		smb->OffsetHigh = cpu_to_le32(rdata->offset >> 32);
+		smb->OffsetHigh = cpu_to_le32(rdata->subreq.start >> 32);
 	smb->Remaining = 0;
-	smb->MaxCount = cpu_to_le16(rdata->bytes & 0xFFFF);
-	smb->MaxCountHigh = cpu_to_le32(rdata->bytes >> 16);
+	smb->MaxCount = cpu_to_le16(rdata->subreq.len & 0xFFFF);
+	smb->MaxCountHigh = cpu_to_le32(rdata->subreq.len >> 16);
 	if (wct == 12)
 		smb->ByteCount = 0;
 	else {
@@ -1633,13 +1633,13 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		 * client. OS/2 servers are known to set incorrect
 		 * CountHigh values.
 		 */
-		if (written > wdata->bytes)
+		if (written > wdata->subreq.len)
 			written &= 0xFFFF;
 
-		if (written < wdata->bytes)
+		if (written < wdata->subreq.len)
 			wdata->result = -ENOSPC;
 		else
-			wdata->bytes = written;
+			wdata->subreq.len = written;
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
@@ -1670,7 +1670,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		wct = 14;
 	} else {
 		wct = 12;
-		if (wdata->offset >> 32 > 0) {
+		if (wdata->subreq.start >> 32 > 0) {
 			/* can not handle big offset for old srv */
 			return -EIO;
 		}
@@ -1685,9 +1685,9 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 
 	smb->AndXCommand = 0xFF;	/* none */
 	smb->Fid = wdata->cfile->fid.netfid;
-	smb->OffsetLow = cpu_to_le32(wdata->offset & 0xFFFFFFFF);
+	smb->OffsetLow = cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
 	if (wct == 14)
-		smb->OffsetHigh = cpu_to_le32(wdata->offset >> 32);
+		smb->OffsetHigh = cpu_to_le32(wdata->subreq.start >> 32);
 	smb->Reserved = 0xFFFFFFFF;
 	smb->WriteMode = 0;
 	smb->Remaining = 0;
@@ -1703,24 +1703,24 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
-	rqst.rq_iter = wdata->iter;
-	rqst.rq_iter_size = iov_iter_count(&wdata->iter);
+	rqst.rq_iter = wdata->subreq.io_iter;
+	rqst.rq_iter_size = iov_iter_count(&wdata->subreq.io_iter);
 
-	cifs_dbg(FYI, "async write at %llu %u bytes\n",
-		 wdata->offset, wdata->bytes);
+	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
+		 wdata->subreq.start, wdata->subreq.len);
 
-	smb->DataLengthLow = cpu_to_le16(wdata->bytes & 0xFFFF);
-	smb->DataLengthHigh = cpu_to_le16(wdata->bytes >> 16);
+	smb->DataLengthLow = cpu_to_le16(wdata->subreq.len & 0xFFFF);
+	smb->DataLengthHigh = cpu_to_le16(wdata->subreq.len >> 16);
 
 	if (wct == 14) {
-		inc_rfc1001_len(&smb->hdr, wdata->bytes + 1);
-		put_bcc(wdata->bytes + 1, &smb->hdr);
+		inc_rfc1001_len(&smb->hdr, wdata->subreq.len + 1);
+		put_bcc(wdata->subreq.len + 1, &smb->hdr);
 	} else {
 		/* wct == 12 */
 		struct smb_com_writex_req *smbw =
 				(struct smb_com_writex_req *)smb;
-		inc_rfc1001_len(&smbw->hdr, wdata->bytes + 5);
-		put_bcc(wdata->bytes + 5, &smbw->hdr);
+		inc_rfc1001_len(&smbw->hdr, wdata->subreq.len + 5);
+		put_bcc(wdata->subreq.len + 5, &smbw->hdr);
 		iov[1].iov_len += 4; /* pad bigger by four bytes */
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 6c7e6a513b90..6e53657154d6 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2440,8 +2440,8 @@ cifs_writev_requeue(struct cifs_io_subrequest *wdata)
 	int rc = 0;
 	struct inode *inode = d_inode(wdata->cfile->dentry);
 	struct TCP_Server_Info *server;
-	unsigned int rest_len = wdata->bytes;
-	loff_t fpos = wdata->offset;
+	unsigned int rest_len = wdata->subreq.len;
+	loff_t fpos = wdata->subreq.start;
 
 	server = tlink_tcon(wdata->cfile->tlink)->ses->server;
 	do {
@@ -2466,14 +2466,14 @@ cifs_writev_requeue(struct cifs_io_subrequest *wdata)
 		}
 
 		wdata2->sync_mode = wdata->sync_mode;
-		wdata2->offset	= fpos;
-		wdata2->bytes	= cur_len;
-		wdata2->iter = wdata->iter;
+		wdata2->subreq.start	= fpos;
+		wdata2->subreq.len	= cur_len;
+		wdata2->subreq.io_iter = wdata->subreq.io_iter;
 
-		iov_iter_advance(&wdata2->iter, fpos - wdata->offset);
-		iov_iter_truncate(&wdata2->iter, wdata2->bytes);
+		iov_iter_advance(&wdata2->subreq.io_iter, fpos - wdata->subreq.start);
+		iov_iter_truncate(&wdata2->subreq.io_iter, wdata2->subreq.len);
 
-		if (iov_iter_is_xarray(&wdata2->iter))
+		if (iov_iter_is_xarray(&wdata2->subreq.io_iter))
 			/* Check for pages having been redirtied and clean
 			 * them.  We can do this by walking the xarray.  If
 			 * it's not an xarray, then it's a DIO and we shouldn't
@@ -2507,7 +2507,7 @@ cifs_writev_requeue(struct cifs_io_subrequest *wdata)
 	} while (rest_len > 0);
 
 	/* Clean up remaining pages from the original wdata */
-	if (iov_iter_is_xarray(&wdata->iter))
+	if (iov_iter_is_xarray(&wdata->subreq.io_iter))
 		cifs_pages_write_failed(inode, fpos, rest_len);
 
 	if (rc != 0 && !is_retryable_error(rc))
@@ -2524,19 +2524,19 @@ cifs_writev_complete(struct work_struct *work)
 
 	if (wdata->result == 0) {
 		spin_lock(&inode->i_lock);
-		cifs_update_eof(CIFS_I(inode), wdata->offset, wdata->bytes);
+		cifs_update_eof(CIFS_I(inode), wdata->subreq.start, wdata->subreq.len);
 		spin_unlock(&inode->i_lock);
 		cifs_stats_bytes_written(tlink_tcon(wdata->cfile->tlink),
-					 wdata->bytes);
+					 wdata->subreq.len);
 	} else if (wdata->sync_mode == WB_SYNC_ALL && wdata->result == -EAGAIN)
 		return cifs_writev_requeue(wdata);
 
 	if (wdata->result == -EAGAIN)
-		cifs_pages_write_redirty(inode, wdata->offset, wdata->bytes);
+		cifs_pages_write_redirty(inode, wdata->subreq.start, wdata->subreq.len);
 	else if (wdata->result < 0)
-		cifs_pages_write_failed(inode, wdata->offset, wdata->bytes);
+		cifs_pages_write_failed(inode, wdata->subreq.start, wdata->subreq.len);
 	else
-		cifs_pages_written_back(inode, wdata->offset, wdata->bytes);
+		cifs_pages_written_back(inode, wdata->subreq.start, wdata->subreq.len);
 
 	if (wdata->result != -EAGAIN)
 		mapping_set_error(inode->i_mapping, wdata->result);
@@ -2768,7 +2768,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	}
 
 	wdata->sync_mode = wbc->sync_mode;
-	wdata->offset = folio_pos(folio);
+	wdata->subreq.start = folio_pos(folio);
 	wdata->pid = cfile->pid;
 	wdata->credits = credits_on_stack;
 	wdata->cfile = cfile;
@@ -2803,7 +2803,7 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 		len = min_t(loff_t, len, max_len);
 	}
 
-	wdata->bytes = len;
+	wdata->subreq.len = len;
 
 	/* We now have a contiguous set of dirty pages, each with writeback
 	 * set; the first page is still locked at this point, but all the rest
@@ -2812,10 +2812,10 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	folio_unlock(folio);
 
 	if (start < i_size) {
-		iov_iter_xarray(&wdata->iter, ITER_SOURCE, &mapping->i_pages,
+		iov_iter_xarray(&wdata->subreq.io_iter, ITER_SOURCE, &mapping->i_pages,
 				start, len);
 
-		rc = adjust_credits(wdata->server, &wdata->credits, wdata->bytes);
+		rc = adjust_credits(wdata->server, &wdata->credits, wdata->subreq.len);
 		if (rc)
 			goto err_wdata;
 
@@ -3234,7 +3234,7 @@ cifs_uncached_writev_complete(struct work_struct *work)
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 
 	spin_lock(&inode->i_lock);
-	cifs_update_eof(cifsi, wdata->offset, wdata->bytes);
+	cifs_update_eof(cifsi, wdata->subreq.start, wdata->subreq.len);
 	if (cifsi->netfs.remote_i_size > inode->i_size)
 		i_size_write(inode, cifsi->netfs.remote_i_size);
 	spin_unlock(&inode->i_lock);
@@ -3270,19 +3270,19 @@ cifs_resend_wdata(struct cifs_io_subrequest *wdata, struct list_head *wdata_list
 		 * segments
 		 */
 		do {
-			rc = server->ops->wait_mtu_credits(server, wdata->bytes,
+			rc = server->ops->wait_mtu_credits(server, wdata->subreq.len,
 						&wsize, &credits);
 			if (rc)
 				goto fail;
 
-			if (wsize < wdata->bytes) {
+			if (wsize < wdata->subreq.len) {
 				add_credits_and_wake_if(server, &credits, 0);
 				msleep(1000);
 			}
-		} while (wsize < wdata->bytes);
+		} while (wsize < wdata->subreq.len);
 		wdata->credits = credits;
 
-		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
+		rc = adjust_credits(server, &wdata->credits, wdata->subreq.len);
 
 		if (!rc) {
 			if (wdata->cfile->invalidHandle)
@@ -3429,19 +3429,19 @@ cifs_write_from_iter(loff_t fpos, size_t len, struct iov_iter *from,
 
 		wdata->uncached	= true;
 		wdata->sync_mode = WB_SYNC_ALL;
-		wdata->offset	= (__u64)fpos;
+		wdata->subreq.start	= (__u64)fpos;
 		wdata->cfile	= cifsFileInfo_get(open_file);
 		wdata->server	= server;
 		wdata->pid	= pid;
-		wdata->bytes	= cur_len;
+		wdata->subreq.len	= cur_len;
 		wdata->credits	= credits_on_stack;
-		wdata->iter	= *from;
+		wdata->subreq.io_iter	= *from;
 		wdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
-		iov_iter_truncate(&wdata->iter, cur_len);
+		iov_iter_truncate(&wdata->subreq.io_iter, cur_len);
 
-		rc = adjust_credits(server, &wdata->credits, wdata->bytes);
+		rc = adjust_credits(server, &wdata->credits, wdata->subreq.len);
 
 		if (!rc) {
 			if (wdata->cfile->invalidHandle)
@@ -3503,7 +3503,7 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 			if (wdata->result)
 				rc = wdata->result;
 			else
-				ctx->total_len += wdata->bytes;
+				ctx->total_len += wdata->subreq.len;
 
 			/* resend call if it's a retryable error */
 			if (rc == -EAGAIN) {
@@ -3518,10 +3518,10 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 						wdata, &tmp_list, ctx);
 				else {
 					iov_iter_advance(&tmp_from,
-						 wdata->offset - ctx->pos);
+						 wdata->subreq.start - ctx->pos);
 
-					rc = cifs_write_from_iter(wdata->offset,
-						wdata->bytes, &tmp_from,
+					rc = cifs_write_from_iter(wdata->subreq.start,
+						wdata->subreq.len, &tmp_from,
 						ctx->cfile, cifs_sb, &tmp_list,
 						ctx);
 
@@ -3844,20 +3844,20 @@ static int cifs_resend_rdata(struct cifs_io_subrequest *rdata,
 		 * segments
 		 */
 		do {
-			rc = server->ops->wait_mtu_credits(server, rdata->bytes,
+			rc = server->ops->wait_mtu_credits(server, rdata->subreq.len,
 						&rsize, &credits);
 
 			if (rc)
 				goto fail;
 
-			if (rsize < rdata->bytes) {
+			if (rsize < rdata->subreq.len) {
 				add_credits_and_wake_if(server, &credits, 0);
 				msleep(1000);
 			}
-		} while (rsize < rdata->bytes);
+		} while (rsize < rdata->subreq.len);
 		rdata->credits = credits;
 
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
 				rc = -EAGAIN;
@@ -3955,17 +3955,17 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 
 		rdata->server	= server;
 		rdata->cfile	= cifsFileInfo_get(open_file);
-		rdata->offset	= fpos;
-		rdata->bytes	= cur_len;
+		rdata->subreq.start	= fpos;
+		rdata->subreq.len	= cur_len;
 		rdata->pid	= pid;
 		rdata->credits	= credits_on_stack;
 		rdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
-		rdata->iter	= ctx->iter;
-		iov_iter_truncate(&rdata->iter, cur_len);
+		rdata->subreq.io_iter = ctx->iter;
+		iov_iter_truncate(&rdata->subreq.io_iter, cur_len);
 
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
 
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
@@ -4035,8 +4035,8 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 						&tmp_list, ctx);
 				} else {
 					rc = cifs_send_async_read(
-						rdata->offset + got_bytes,
-						rdata->bytes - got_bytes,
+						rdata->subreq.start + got_bytes,
+						rdata->subreq.len - got_bytes,
 						rdata->cfile, cifs_sb,
 						&tmp_list, ctx);
 
@@ -4050,7 +4050,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 				rc = rdata->result;
 
 			/* if there was a short read -- discard anything left */
-			if (rdata->got_bytes && rdata->got_bytes < rdata->bytes)
+			if (rdata->got_bytes && rdata->got_bytes < rdata->subreq.len)
 				rc = -ENODATA;
 
 			ctx->total_len += rdata->got_bytes;
@@ -4434,16 +4434,16 @@ static void cifs_readahead_complete(struct work_struct *work)
 	pgoff_t last;
 	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
 
-	XA_STATE(xas, &rdata->mapping->i_pages, rdata->offset / PAGE_SIZE);
+	XA_STATE(xas, &rdata->mapping->i_pages, rdata->subreq.start / PAGE_SIZE);
 
 	if (good)
 		cifs_readahead_to_fscache(rdata->mapping->host,
-					  rdata->offset, rdata->bytes);
+					  rdata->subreq.start, rdata->subreq.len);
 
-	if (iov_iter_count(&rdata->iter) > 0)
-		iov_iter_zero(iov_iter_count(&rdata->iter), &rdata->iter);
+	if (iov_iter_count(&rdata->subreq.io_iter) > 0)
+		iov_iter_zero(iov_iter_count(&rdata->subreq.io_iter), &rdata->subreq.io_iter);
 
-	last = (rdata->offset + rdata->bytes - 1) / PAGE_SIZE;
+	last = (rdata->subreq.start + rdata->subreq.len - 1) / PAGE_SIZE;
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, last) {
@@ -4582,8 +4582,8 @@ static void cifs_readahead(struct readahead_control *ractl)
 			break;
 		}
 
-		rdata->offset	= ra_index * PAGE_SIZE;
-		rdata->bytes	= nr_pages * PAGE_SIZE;
+		rdata->subreq.start	= ra_index * PAGE_SIZE;
+		rdata->subreq.len	= nr_pages * PAGE_SIZE;
 		rdata->cfile	= cifsFileInfo_get(open_file);
 		rdata->server	= server;
 		rdata->mapping	= ractl->mapping;
@@ -4597,10 +4597,10 @@ static void cifs_readahead(struct readahead_control *ractl)
 		ra_pages -= nr_pages;
 		ra_index += nr_pages;
 
-		iov_iter_xarray(&rdata->iter, ITER_DEST, &rdata->mapping->i_pages,
-				rdata->offset, rdata->bytes);
+		iov_iter_xarray(&rdata->subreq.io_iter, ITER_DEST, &rdata->mapping->i_pages,
+				rdata->subreq.start, rdata->subreq.len);
 
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
 		if (!rc) {
 			if (rdata->cfile->invalidHandle)
 				rc = -EAGAIN;
@@ -4611,8 +4611,8 @@ static void cifs_readahead(struct readahead_control *ractl)
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
 			cifs_unlock_folios(rdata->mapping,
-					   rdata->offset / PAGE_SIZE,
-					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
+					   rdata->subreq.start / PAGE_SIZE,
+					   (rdata->subreq.start + rdata->subreq.len - 1) / PAGE_SIZE);
 			/* Fallback to the readpage in error/reconnect cases */
 			cifs_put_readdata(rdata);
 			break;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9da9ee98ae39..8d674aef8dd9 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4580,7 +4580,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 		/* Copy the data to the output I/O iterator. */
 		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
-							cur_off, &rdata->iter);
+							cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4594,7 +4594,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		/* read response payload is in buf */
 		WARN_ONCE(pages && !xa_empty(pages),
 			  "read data can be either in buf or in pages");
-		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
+		length = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.io_iter);
 		if (length < 0)
 			return length;
 		rdata->got_bytes = data_len;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index db739806343d..2ecc5f210329 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4399,7 +4399,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 		struct smbd_buffer_descriptor_v1 *v1;
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->iter,
+		rdata->mr = smbd_register_mr(server->smbd_conn, &rdata->subreq.io_iter,
 					     true, need_invalidate);
 		if (!rdata->mr)
 			return -EAGAIN;
@@ -4459,17 +4459,17 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1], .rq_nvec = 1 };
 
 	if (rdata->got_bytes) {
-		rqst.rq_iter	  = rdata->iter;
-		rqst.rq_iter_size = iov_iter_count(&rdata->iter);
+		rqst.rq_iter	  = rdata->subreq.io_iter;
+		rqst.rq_iter_size = iov_iter_count(&rdata->subreq.io_iter);
 	}
 
 	WARN_ONCE(rdata->server != mid->server,
 		  "rdata server %p != mid server %p",
 		  rdata->server, mid->server);
 
-	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%u\n",
+	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
-		 rdata->bytes);
+		 rdata->subreq.len);
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -4522,13 +4522,13 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */,
 				    rdata->cfile->fid.persistent_fid,
-				    tcon->tid, tcon->ses->Suid, rdata->offset,
-				    rdata->bytes, rdata->result);
+				    tcon->tid, tcon->ses->Suid, rdata->subreq.start,
+				    rdata->subreq.len, rdata->result);
 	} else
 		trace_smb3_read_done(0 /* xid */,
 				     rdata->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
-				     rdata->offset, rdata->got_bytes);
+				     rdata->subreq.start, rdata->got_bytes);
 
 	queue_work(cifsiod_wq, &rdata->work);
 	release_mid(mid);
@@ -4550,16 +4550,16 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	unsigned int total_len;
 	int credit_request;
 
-	cifs_dbg(FYI, "%s: offset=%llu bytes=%u\n",
-		 __func__, rdata->offset, rdata->bytes);
+	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
+		 __func__, rdata->subreq.start, rdata->subreq.len);
 
 	if (!rdata->server)
 		rdata->server = cifs_pick_channel(tcon->ses);
 
 	io_parms.tcon = tlink_tcon(rdata->cfile->tlink);
 	io_parms.server = server = rdata->server;
-	io_parms.offset = rdata->offset;
-	io_parms.length = rdata->bytes;
+	io_parms.offset = rdata->subreq.start;
+	io_parms.length = rdata->subreq.len;
 	io_parms.persistent_fid = rdata->cfile->fid.persistent_fid;
 	io_parms.volatile_fid = rdata->cfile->fid.volatile_fid;
 	io_parms.pid = rdata->pid;
@@ -4578,7 +4578,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	shdr = (struct smb2_hdr *)buf;
 
 	if (rdata->credits.value > 0) {
-		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->bytes,
+		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->subreq.len,
 						SMB2_MAX_BUFFER_SIZE));
 		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
 		if (server->credits >= server->max_credits)
@@ -4588,7 +4588,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 				min_t(int, server->max_credits -
 						server->credits, credit_request));
 
-		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
+		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
 		if (rc)
 			goto async_readv_out;
 
@@ -4728,13 +4728,13 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		 * client. OS/2 servers are known to set incorrect
 		 * CountHigh values.
 		 */
-		if (written > wdata->bytes)
+		if (written > wdata->subreq.len)
 			written &= 0xFFFF;
 
-		if (written < wdata->bytes)
+		if (written < wdata->subreq.len)
 			wdata->result = -ENOSPC;
 		else
-			wdata->bytes = written;
+			wdata->subreq.len = written;
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
@@ -4765,8 +4765,8 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
 		trace_smb3_write_err(0 /* no xid */,
 				     wdata->cfile->fid.persistent_fid,
-				     tcon->tid, tcon->ses->Suid, wdata->offset,
-				     wdata->bytes, wdata->result);
+				     tcon->tid, tcon->ses->Suid, wdata->subreq.start,
+				     wdata->subreq.len, wdata->result);
 		if (wdata->result == -ENOSPC)
 			pr_warn_once("Out of space writing to %s\n",
 				     tcon->tree_name);
@@ -4774,7 +4774,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		trace_smb3_write_done(0 /* no xid */,
 				      wdata->cfile->fid.persistent_fid,
 				      tcon->tid, tcon->ses->Suid,
-				      wdata->offset, wdata->bytes);
+				      wdata->subreq.start, wdata->subreq.len);
 
 	queue_work(cifsiod_wq, &wdata->work);
 	release_mid(mid);
@@ -4807,8 +4807,8 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	_io_parms = (struct cifs_io_parms) {
 		.tcon = tcon,
 		.server = server,
-		.offset = wdata->offset,
-		.length = wdata->bytes,
+		.offset = wdata->subreq.start,
+		.length = wdata->subreq.len,
 		.persistent_fid = wdata->cfile->fid.persistent_fid,
 		.volatile_fid = wdata->cfile->fid.volatile_fid,
 		.pid = wdata->pid,
@@ -4850,10 +4850,10 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	 */
 	if (smb3_use_rdma_offload(io_parms)) {
 		struct smbd_buffer_descriptor_v1 *v1;
-		size_t data_size = iov_iter_count(&wdata->iter);
+		size_t data_size = iov_iter_count(&wdata->subreq.io_iter);
 		bool need_invalidate = server->dialect == SMB30_PROT_ID;
 
-		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->iter,
+		wdata->mr = smbd_register_mr(server->smbd_conn, &wdata->subreq.io_iter,
 					     false, need_invalidate);
 		if (!wdata->mr) {
 			rc = -EAGAIN;
@@ -4880,7 +4880,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 1;
-	rqst.rq_iter = wdata->iter;
+	rqst.rq_iter = wdata->subreq.io_iter;
 	rqst.rq_iter_size = iov_iter_count(&rqst.rq_iter);
 	if (wdata->replay)
 		smb2_set_replay(server, &rqst);
@@ -4900,7 +4900,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 #endif
 
 	if (wdata->credits.value > 0) {
-		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->bytes,
+		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(wdata->subreq.len,
 						    SMB2_MAX_BUFFER_SIZE));
 		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
 		if (server->credits >= server->max_credits)
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index a5bab478e6de..e52967de59e6 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1702,8 +1702,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
 	bool use_rdma_mr = false;
 
-	cifs_dbg(FYI, "%s: mid=%llu offset=%llu bytes=%u\n",
-		 __func__, mid->mid, rdata->offset, rdata->bytes);
+	cifs_dbg(FYI, "%s: mid=%llu offset=%llu bytes=%zu\n",
+		 __func__, mid->mid, rdata->subreq.start, rdata->subreq.len);
 
 	/*
 	 * read the rest of READ_RSP header (sans Data array), or whatever we
@@ -1808,7 +1808,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		length = data_len; /* An RDMA read is already done. */
 	else
 #endif
-		length = cifs_read_iter_from_socket(server, &rdata->iter,
+		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
 	if (length > 0)
 		rdata->got_bytes += length;


