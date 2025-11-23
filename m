Return-Path: <linux-fsdevel+bounces-69603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36BC7EA17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004044E40F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56B27FD4B;
	Sun, 23 Nov 2025 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnVuTFfU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01427FD43
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763941994; cv=none; b=K2YIBJn3Ewu1RbFNazS/tXrxWJh1KIrAhcZe74spxB82AOf8UY1O0cvKaPhftHI9NObjW994wR+yHNcYfQyzR+CzsRVoO7ic80kepr1/6Jzdw7M7X2xjO+7KbRDnfcamZ7EPAzxNJx7BbZRW5sVamamfZVHqUBSSys6DEgAqI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763941994; c=relaxed/simple;
	bh=xqcrAzwyu6PJTKMic7E+ngGvK2OC3eql8ueETdsh8Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9vcuVkSqjMS0hfKzf9r/sKF3oWHHagJ0HkEAj1dcj4cl3aso9jshY58//FvogmEoTmp9G2SyEnXQ0N4LMPcW99Vj15H4z5rkpAqbtCfxKHUbeWxuVkziVzKNMOJO8GJ9P3PAtbN/6TRpGT9ukmkqT0x2tJu+RjZW6sE1JxMwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnVuTFfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763941991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/Qm2Otykpepgw8gQn2DPDBJGCPk2dpzDg9ieuKF6EU=;
	b=AnVuTFfUAtx5WL4llj4JlAgQkH+vdfZGGp4zZGCJZ9cUIvob23DkxbyvGC22vkW7UMKTSf
	WrPMzJY3MwHmtTchz7TIbCiL9AHRmTG5kOjQ1qMf4ld44y+fHGpFoM6I6Jeknqwo0+1p4/
	vcg/hMkeQQ7mobVHkeIhT0pq03y7Ck8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-C_WyT0X2MTGhnu4ALkuzVg-1; Sun,
 23 Nov 2025 18:53:06 -0500
X-MC-Unique: C_WyT0X2MTGhnu4ALkuzVg-1
X-Mimecast-MFC-AGG-ID: C_WyT0X2MTGhnu4ALkuzVg_1763941983
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDFF1800452;
	Sun, 23 Nov 2025 23:53:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6FD0219560A7;
	Sun, 23 Nov 2025 23:53:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v3 04/12] cifs: Use netfs_alloc/free_folioq_buffer()
Date: Sun, 23 Nov 2025 23:52:31 +0000
Message-ID: <20251123235242.3361706-5-dhowells@redhat.com>
In-Reply-To: <20251123235242.3361706-1-dhowells@redhat.com>
References: <20251123235242.3361706-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use netfs_alloc/free_folioq_buffer() rather than doing its own version.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com> (RDMA, smbdirect)
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2ops.c | 75 +++++++----------------------------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4b005a7adce0..549fffbca246 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4484,61 +4484,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	return rc;
 }
 
-/*
- * Clear a read buffer, discarding the folios which have the 1st mark set.
- */
-static void cifs_clear_folioq_buffer(struct folio_queue *buffer)
-{
-	struct folio_queue *folioq;
-
-	while ((folioq = buffer)) {
-		for (int s = 0; s < folioq_count(folioq); s++)
-			if (folioq_is_marked(folioq, s))
-				folio_put(folioq_folio(folioq, s));
-		buffer = folioq->next;
-		kfree(folioq);
-	}
-}
-
-/*
- * Allocate buffer space into a folio queue.
- */
-static struct folio_queue *cifs_alloc_folioq_buffer(ssize_t size)
-{
-	struct folio_queue *buffer = NULL, *tail = NULL, *p;
-	struct folio *folio;
-	unsigned int slot;
-
-	do {
-		if (!tail || folioq_full(tail)) {
-			p = kmalloc(sizeof(*p), GFP_NOFS);
-			if (!p)
-				goto nomem;
-			folioq_init(p, 0);
-			if (tail) {
-				tail->next = p;
-				p->prev = tail;
-			} else {
-				buffer = p;
-			}
-			tail = p;
-		}
-
-		folio = folio_alloc(GFP_KERNEL|__GFP_HIGHMEM, 0);
-		if (!folio)
-			goto nomem;
-
-		slot = folioq_append_mark(tail, folio);
-		size -= folioq_folio_size(tail, slot);
-	} while (size > 0);
-
-	return buffer;
-
-nomem:
-	cifs_clear_folioq_buffer(buffer);
-	return NULL;
-}
-
 /*
  * Copy data from an iterator to the folios in a folio queue buffer.
  */
@@ -4564,7 +4509,7 @@ void
 smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
 {
 	for (int i = 0; i < num_rqst; i++)
-		cifs_clear_folioq_buffer(rqst[i].rq_buffer);
+		netfs_free_folioq_buffer(rqst[i].rq_buffer);
 }
 
 /*
@@ -4599,8 +4544,11 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 		new->rq_nvec = old->rq_nvec;
 
 		if (size > 0) {
-			buffer = cifs_alloc_folioq_buffer(size);
-			if (!buffer)
+			size_t cur_size = 0;
+
+			rc = netfs_alloc_folioq_buffer(NULL, &buffer, &cur_size,
+						       size, GFP_NOFS);
+			if (rc < 0)
 				goto err_free;
 
 			new->rq_buffer = buffer;
@@ -4932,7 +4880,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 free_pages:
-	cifs_clear_folioq_buffer(dw->buffer);
+	netfs_free_folioq_buffer(dw->buffer);
 	cifs_small_buf_release(dw->buf);
 	kfree(dw);
 }
@@ -4970,9 +4918,10 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	dw->len = len;
 	len = round_up(dw->len, PAGE_SIZE);
 
-	rc = -ENOMEM;
-	dw->buffer = cifs_alloc_folioq_buffer(len);
-	if (!dw->buffer)
+	size_t cur_size = 0;
+
+	rc = netfs_alloc_folioq_buffer(NULL, &dw->buffer, &cur_size, len, GFP_NOFS);
+	if (rc < 0)
 		goto discard_data;
 
 	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, len);
@@ -5033,7 +4982,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	}
 
 free_pages:
-	cifs_clear_folioq_buffer(dw->buffer);
+	netfs_free_folioq_buffer(dw->buffer);
 free_dw:
 	kfree(dw);
 	return rc;


