Return-Path: <linux-fsdevel+bounces-52947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E853AE8A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FF4680E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556752ED859;
	Wed, 25 Jun 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLht+H10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB92D4B67
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869810; cv=none; b=NoA2DKhFi1AfNPFXjRZ12awNZQ7NFm68qfHnM4sgRzVUm3gqkXShxMeXyr0xXvXQDknA+6ns18DbwCUcOtRdeHm7I5TLNvD38tUbySMmw7A/XWw5PjfYDC57tBv8ed7u06clHNUtmHe/3q/yzuWUG5bdHb2iXzsVoCkGuttBlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869810; c=relaxed/simple;
	bh=SXgvElHG+rgpKsJbAG0nTmqC5C4ZMYho2SybTvsVsWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5WmAa/TfjMzAenLySYLQ25Yyp41faX5WApTNngioROYaJIwYmFUnJ/7zL+BL/h8s0UjSIQo2SV5Q+kj5gIo9o5LR7bYTjFo64H8hVPgbwdjmGBi/91Aacg+8tIv3i0K80+KRtM5buIQldri+y2bkJcqueHgKRV7FRLCsKhcmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLht+H10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIsFGLeExHe5sqFNaVeivDuS43dfh1gqeqA6FrJfFrA=;
	b=fLht+H107SWqw56jGeACCEbzlmmkqfpHJY8o8y6FWm25q9mbw8P4/aq3O7pLiiu3HRnpR2
	gLtUQ2nkfak7Qe75Zm9b8+t/9If78fBvCQm5C+QwIDAIdVxLifafmFEDPOJhZjW/cW5/Gm
	4bZMcyN3KvlpmLCvbcR6qtiJBYLni88=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-FDhUDpVvOaG5pNTOQr4ZMA-1; Wed,
 25 Jun 2025 12:43:20 -0400
X-MC-Unique: FDhUDpVvOaG5pNTOQr4ZMA-1
X-Mimecast-MFC-AGG-ID: FDhUDpVvOaG5pNTOQr4ZMA_1750869798
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 829C2180028D;
	Wed, 25 Jun 2025 16:43:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CECEA195608D;
	Wed, 25 Jun 2025 16:43:14 +0000 (UTC)
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
	Tom Talpey <tom@talpey.com>,
	stable+noautosel@kernel.org
Subject: [PATCH v2 11/16] smb: client: let smbd_post_send_iter() respect the peers max_send_size and transmit all data
Date: Wed, 25 Jun 2025 17:42:06 +0100
Message-ID: <20250625164213.1408754-12-dhowells@redhat.com>
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

From: Stefan Metzmacher <metze@samba.org>

We should not send smbdirect_data_transfer messages larger than
the negotiated max_send_size, typically 1364 bytes, which means
24 bytes of the smbdirect_data_transfer header + 1340 payload bytes.

This happened when doing an SMB2 write with more than 1340 bytes
(which is done inline as it's below rdma_readwrite_threshold).

It means the peer resets the connection.

When testing between cifs.ko and ksmbd.ko something like this
is logged:

client:

    CIFS: VFS: RDMA transport re-established
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    siw: got TERMINATE. layer 1, type 2, code 2
    CIFS: VFS: \\carina Send error in SessSetup = -11
    smb2_reconnect: 12 callbacks suppressed
    CIFS: VFS: reconnect tcon failed rc = -11
    CIFS: VFS: reconnect tcon failed rc = -11
    CIFS: VFS: reconnect tcon failed rc = -11
    CIFS: VFS: SMB: Zero rsize calculated, using minimum value 65536

and:

    CIFS: VFS: RDMA transport re-established
    siw: got TERMINATE. layer 1, type 2, code 2
    CIFS: VFS: smbd_recv:1894 disconnected
    siw: got TERMINATE. layer 1, type 2, code 2

The ksmbd dmesg is showing things like:

    smb_direct: Recv error. status='local length error (1)' opcode=128
    smb_direct: disconnected
    smb_direct: Recv error. status='local length error (1)' opcode=128
    ksmbd: smb_direct: disconnected
    ksmbd: sock_read failed: -107

As smbd_post_send_iter() limits the transmitted number of bytes
we need loop over it in order to transmit the whole iter.

Cc: Steve French <sfrench@samba.org>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: <stable+noautosel@kernel.org> # sp->max_send_size should be info->max_send_size in backports
Fixes: 3d78fe73fa12 ("cifs: Build the RDMA SGE list directly from an iterator")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/smb/client/smbdirect.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index cbc85bca006f..a976bcf61226 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -907,8 +907,10 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 			.local_dma_lkey	= sc->ib.pd->local_dma_lkey,
 			.direction	= DMA_TO_DEVICE,
 		};
+		size_t payload_len = umin(*_remaining_data_length,
+					  sp->max_send_size - sizeof(*packet));
 
-		rc = smb_extract_iter_to_rdma(iter, *_remaining_data_length,
+		rc = smb_extract_iter_to_rdma(iter, payload_len,
 					      &extract);
 		if (rc < 0)
 			goto err_dma;
@@ -1013,6 +1015,27 @@ static int smbd_post_send_empty(struct smbd_connection *info)
 	return smbd_post_send_iter(info, NULL, &remaining_data_length);
 }
 
+static int smbd_post_send_full_iter(struct smbd_connection *info,
+				    struct iov_iter *iter,
+				    int *_remaining_data_length)
+{
+	int rc = 0;
+
+	/*
+	 * smbd_post_send_iter() respects the
+	 * negotiated max_send_size, so we need to
+	 * loop until the full iter is posted
+	 */
+
+	while (iov_iter_count(iter) > 0) {
+		rc = smbd_post_send_iter(info, iter, _remaining_data_length);
+		if (rc < 0)
+			break;
+	}
+
+	return rc;
+}
+
 /*
  * Post a receive request to the transport
  * The remote peer can only send data when a receive request is posted
@@ -2032,14 +2055,14 @@ int smbd_send(struct TCP_Server_Info *server,
 			klen += rqst->rq_iov[i].iov_len;
 		iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, klen);
 
-		rc = smbd_post_send_iter(info, &iter, &remaining_data_length);
+		rc = smbd_post_send_full_iter(info, &iter, &remaining_data_length);
 		if (rc < 0)
 			break;
 
 		if (iov_iter_count(&rqst->rq_iter) > 0) {
 			/* And then the data pages if there are any */
-			rc = smbd_post_send_iter(info, &rqst->rq_iter,
-						 &remaining_data_length);
+			rc = smbd_post_send_full_iter(info, &rqst->rq_iter,
+						      &remaining_data_length);
 			if (rc < 0)
 				break;
 		}


