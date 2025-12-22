Return-Path: <linux-fsdevel+bounces-71868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A7CD756A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757C3305B7C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56834D3BD;
	Mon, 22 Dec 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGXZq8bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107B34CFBC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442691; cv=none; b=AvYU2gRxgkB32Dl25bhpM2MGKoRWlJ2uNo3H/AnVFC79Y9CIRIxNFZJzyujg/CYF6lXVz1N18luvNe7ZPHB+Utw+FPLspdKQ2UrNw99+sLta5UAynCttEIt+tRepgyXQPcybBRs7wGUCmrXtgW5a/DxLqTc4AryYVPON0MaDTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442691; c=relaxed/simple;
	bh=YRUisPfZu/AQV0uuf0IzTu4Qpe3E5mjzYodKWFmosdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFc2Pr5ArqgfTJnf0iWY4mR6jhGIbE5iR9DW5zRAfxNG6XvqSs4l+bw0P1AURav1ZOmtTlTi3l2IBPzKEzRrCbi468vmX5H0CrjJ7wbF1FyM5b2nIRfiS4h8FOYABo/ifzEIqsEDgZM8NicS5d1BSe6/ii4WSEHw46FUVoEdVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGXZq8bq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AW7C8kDmu+70zsNdeONVj+m6HXmbipkdP4JqQmwQcA=;
	b=UGXZq8bqYjZjBKypvlX13jlkNfNCTu/DKJIoK43BrrYVQjLuyZ68wdUwoEgeKEorGKikrz
	4seBUKWARxm2YKv/2SfdPclrkjcsKHs6ajZXWF+6mSJjjHABd44+3fkdVpH4qfyaI8KIdP
	8HAf+4b85FXXBMrSwL8QJqX8kkGDGwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Qg6IjSpYN6aWwOR2s2BoTQ-1; Mon,
 22 Dec 2025 17:31:21 -0500
X-MC-Unique: Qg6IjSpYN6aWwOR2s2BoTQ-1
X-Mimecast-MFC-AGG-ID: Qg6IjSpYN6aWwOR2s2BoTQ_1766442680
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 836DC195605B;
	Mon, 22 Dec 2025 22:31:20 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD73C1955F43;
	Mon, 22 Dec 2025 22:31:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/37] cifs: SMB1 split: Move some SMB1 receive bits to smb1transport.c
Date: Mon, 22 Dec 2025 22:29:47 +0000
Message-ID: <20251222223006.1075635-23-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move some SMB1 receive bits to smb1transport.c from smb1ops.c where they're
mixed in with unrelated code to do with encoding, decoding and processing
PDUs.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/smb1ops.c       | 171 ----------------------------------
 fs/smb/client/smb1proto.h     |   2 +
 fs/smb/client/smb1transport.c | 171 ++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 171 deletions(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 9729b56bd9d4..2534113596c7 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -284,146 +284,6 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 	return mid;
 }
 
-/*
-	return codes:
-		0	not a transact2, or all data present
-		>0	transact2 with that much data missing
-		-EINVAL	invalid transact2
- */
-static int
-check2ndT2(char *buf)
-{
-	struct smb_hdr *pSMB = (struct smb_hdr *)buf;
-	struct smb_t2_rsp *pSMBt;
-	int remaining;
-	__u16 total_data_size, data_in_this_rsp;
-
-	if (pSMB->Command != SMB_COM_TRANSACTION2)
-		return 0;
-
-	/* check for plausible wct, bcc and t2 data and parm sizes */
-	/* check for parm and data offset going beyond end of smb */
-	if (pSMB->WordCount != 10) { /* coalesce_t2 depends on this */
-		cifs_dbg(FYI, "Invalid transact2 word count\n");
-		return -EINVAL;
-	}
-
-	pSMBt = (struct smb_t2_rsp *)pSMB;
-
-	total_data_size = get_unaligned_le16(&pSMBt->t2_rsp.TotalDataCount);
-	data_in_this_rsp = get_unaligned_le16(&pSMBt->t2_rsp.DataCount);
-
-	if (total_data_size == data_in_this_rsp)
-		return 0;
-	else if (total_data_size < data_in_this_rsp) {
-		cifs_dbg(FYI, "total data %d smaller than data in frame %d\n",
-			 total_data_size, data_in_this_rsp);
-		return -EINVAL;
-	}
-
-	remaining = total_data_size - data_in_this_rsp;
-
-	cifs_dbg(FYI, "missing %d bytes from transact2, check next response\n",
-		 remaining);
-	if (total_data_size > CIFSMaxBufSize) {
-		cifs_dbg(VFS, "TotalDataSize %d is over maximum buffer %d\n",
-			 total_data_size, CIFSMaxBufSize);
-		return -EINVAL;
-	}
-	return remaining;
-}
-
-static int
-coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
-{
-	struct smb_t2_rsp *pSMBs = (struct smb_t2_rsp *)second_buf;
-	struct smb_t2_rsp *pSMBt  = (struct smb_t2_rsp *)target_hdr;
-	char *data_area_of_tgt;
-	char *data_area_of_src;
-	int remaining;
-	unsigned int byte_count, total_in_tgt;
-	__u16 tgt_total_cnt, src_total_cnt, total_in_src;
-
-	src_total_cnt = get_unaligned_le16(&pSMBs->t2_rsp.TotalDataCount);
-	tgt_total_cnt = get_unaligned_le16(&pSMBt->t2_rsp.TotalDataCount);
-
-	if (tgt_total_cnt != src_total_cnt)
-		cifs_dbg(FYI, "total data count of primary and secondary t2 differ source=%hu target=%hu\n",
-			 src_total_cnt, tgt_total_cnt);
-
-	total_in_tgt = get_unaligned_le16(&pSMBt->t2_rsp.DataCount);
-
-	remaining = tgt_total_cnt - total_in_tgt;
-
-	if (remaining < 0) {
-		cifs_dbg(FYI, "Server sent too much data. tgt_total_cnt=%hu total_in_tgt=%u\n",
-			 tgt_total_cnt, total_in_tgt);
-		return -EPROTO;
-	}
-
-	if (remaining == 0) {
-		/* nothing to do, ignore */
-		cifs_dbg(FYI, "no more data remains\n");
-		return 0;
-	}
-
-	total_in_src = get_unaligned_le16(&pSMBs->t2_rsp.DataCount);
-	if (remaining < total_in_src)
-		cifs_dbg(FYI, "transact2 2nd response contains too much data\n");
-
-	/* find end of first SMB data area */
-	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
-				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
-
-	/* validate target area */
-	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
-				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
-
-	data_area_of_tgt += total_in_tgt;
-
-	total_in_tgt += total_in_src;
-	/* is the result too big for the field? */
-	if (total_in_tgt > USHRT_MAX) {
-		cifs_dbg(FYI, "coalesced DataCount too large (%u)\n",
-			 total_in_tgt);
-		return -EPROTO;
-	}
-	put_unaligned_le16(total_in_tgt, &pSMBt->t2_rsp.DataCount);
-
-	/* fix up the BCC */
-	byte_count = get_bcc(target_hdr);
-	byte_count += total_in_src;
-	/* is the result too big for the field? */
-	if (byte_count > USHRT_MAX) {
-		cifs_dbg(FYI, "coalesced BCC too large (%u)\n", byte_count);
-		return -EPROTO;
-	}
-	put_bcc(byte_count, target_hdr);
-
-	byte_count = *pdu_len;
-	byte_count += total_in_src;
-	/* don't allow buffer to overflow */
-	if (byte_count > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
-		cifs_dbg(FYI, "coalesced BCC exceeds buffer size (%u)\n",
-			 byte_count);
-		return -ENOBUFS;
-	}
-	*pdu_len = byte_count;
-
-	/* copy second buffer into end of first buffer */
-	memcpy(data_area_of_tgt, data_area_of_src, total_in_src);
-
-	if (remaining != total_in_src) {
-		/* more responses to go */
-		cifs_dbg(FYI, "waiting for more secondary responses\n");
-		return 1;
-	}
-
-	/* we are done */
-	cifs_dbg(FYI, "found the last secondary response\n");
-	return 0;
-}
-
 static void
 cifs_downgrade_oplock(struct TCP_Server_Info *server,
 		      struct cifsInodeInfo *cinode, __u32 oplock,
@@ -432,37 +292,6 @@ cifs_downgrade_oplock(struct TCP_Server_Info *server,
 	cifs_set_oplock_level(cinode, oplock);
 }
 
-static bool
-cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
-		  char *buf, int malformed)
-{
-	if (malformed)
-		return false;
-	if (check2ndT2(buf) <= 0)
-		return false;
-	mid->multiRsp = true;
-	if (mid->resp_buf) {
-		/* merge response - fix up 1st*/
-		malformed = coalesce_t2(buf, mid->resp_buf, &mid->response_pdu_len);
-		if (malformed > 0)
-			return true;
-		/* All parts received or packet is malformed. */
-		mid->multiEnd = true;
-		dequeue_mid(server, mid, malformed);
-		return true;
-	}
-	if (!server->large_buf) {
-		/*FIXME: switch to already allocated largebuf?*/
-		cifs_dbg(VFS, "1st trans2 resp needs bigbuf\n");
-	} else {
-		/* Have first buffer */
-		mid->resp_buf = buf;
-		mid->large_buf = true;
-		server->bigbuf = NULL;
-	}
-	return true;
-}
-
 static bool
 cifs_need_neg(struct TCP_Server_Info *server)
 {
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 1fd4fd0bbb7a..bf24974fbb00 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -233,6 +233,8 @@ int SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		struct smb_hdr *in_buf, unsigned int in_len,
 		struct smb_hdr *out_buf, int *pbytes_returned,
 		const int flags);
+bool cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		       char *buf, int malformed);
 
 
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 28d1cee90625..5f95bffc8e44 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -261,3 +261,174 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
+
+/*
+	return codes:
+		0	not a transact2, or all data present
+		>0	transact2 with that much data missing
+		-EINVAL	invalid transact2
+ */
+static int
+check2ndT2(char *buf)
+{
+	struct smb_hdr *pSMB = (struct smb_hdr *)buf;
+	struct smb_t2_rsp *pSMBt;
+	int remaining;
+	__u16 total_data_size, data_in_this_rsp;
+
+	if (pSMB->Command != SMB_COM_TRANSACTION2)
+		return 0;
+
+	/* check for plausible wct, bcc and t2 data and parm sizes */
+	/* check for parm and data offset going beyond end of smb */
+	if (pSMB->WordCount != 10) { /* coalesce_t2 depends on this */
+		cifs_dbg(FYI, "Invalid transact2 word count\n");
+		return -EINVAL;
+	}
+
+	pSMBt = (struct smb_t2_rsp *)pSMB;
+
+	total_data_size = get_unaligned_le16(&pSMBt->t2_rsp.TotalDataCount);
+	data_in_this_rsp = get_unaligned_le16(&pSMBt->t2_rsp.DataCount);
+
+	if (total_data_size == data_in_this_rsp)
+		return 0;
+	else if (total_data_size < data_in_this_rsp) {
+		cifs_dbg(FYI, "total data %d smaller than data in frame %d\n",
+			 total_data_size, data_in_this_rsp);
+		return -EINVAL;
+	}
+
+	remaining = total_data_size - data_in_this_rsp;
+
+	cifs_dbg(FYI, "missing %d bytes from transact2, check next response\n",
+		 remaining);
+	if (total_data_size > CIFSMaxBufSize) {
+		cifs_dbg(VFS, "TotalDataSize %d is over maximum buffer %d\n",
+			 total_data_size, CIFSMaxBufSize);
+		return -EINVAL;
+	}
+	return remaining;
+}
+
+static int
+coalesce_t2(char *second_buf, struct smb_hdr *target_hdr, unsigned int *pdu_len)
+{
+	struct smb_t2_rsp *pSMBs = (struct smb_t2_rsp *)second_buf;
+	struct smb_t2_rsp *pSMBt  = (struct smb_t2_rsp *)target_hdr;
+	char *data_area_of_tgt;
+	char *data_area_of_src;
+	int remaining;
+	unsigned int byte_count, total_in_tgt;
+	__u16 tgt_total_cnt, src_total_cnt, total_in_src;
+
+	src_total_cnt = get_unaligned_le16(&pSMBs->t2_rsp.TotalDataCount);
+	tgt_total_cnt = get_unaligned_le16(&pSMBt->t2_rsp.TotalDataCount);
+
+	if (tgt_total_cnt != src_total_cnt)
+		cifs_dbg(FYI, "total data count of primary and secondary t2 differ source=%hu target=%hu\n",
+			 src_total_cnt, tgt_total_cnt);
+
+	total_in_tgt = get_unaligned_le16(&pSMBt->t2_rsp.DataCount);
+
+	remaining = tgt_total_cnt - total_in_tgt;
+
+	if (remaining < 0) {
+		cifs_dbg(FYI, "Server sent too much data. tgt_total_cnt=%hu total_in_tgt=%u\n",
+			 tgt_total_cnt, total_in_tgt);
+		return -EPROTO;
+	}
+
+	if (remaining == 0) {
+		/* nothing to do, ignore */
+		cifs_dbg(FYI, "no more data remains\n");
+		return 0;
+	}
+
+	total_in_src = get_unaligned_le16(&pSMBs->t2_rsp.DataCount);
+	if (remaining < total_in_src)
+		cifs_dbg(FYI, "transact2 2nd response contains too much data\n");
+
+	/* find end of first SMB data area */
+	data_area_of_tgt = (char *)&pSMBt->hdr.Protocol +
+				get_unaligned_le16(&pSMBt->t2_rsp.DataOffset);
+
+	/* validate target area */
+	data_area_of_src = (char *)&pSMBs->hdr.Protocol +
+				get_unaligned_le16(&pSMBs->t2_rsp.DataOffset);
+
+	data_area_of_tgt += total_in_tgt;
+
+	total_in_tgt += total_in_src;
+	/* is the result too big for the field? */
+	if (total_in_tgt > USHRT_MAX) {
+		cifs_dbg(FYI, "coalesced DataCount too large (%u)\n",
+			 total_in_tgt);
+		return -EPROTO;
+	}
+	put_unaligned_le16(total_in_tgt, &pSMBt->t2_rsp.DataCount);
+
+	/* fix up the BCC */
+	byte_count = get_bcc(target_hdr);
+	byte_count += total_in_src;
+	/* is the result too big for the field? */
+	if (byte_count > USHRT_MAX) {
+		cifs_dbg(FYI, "coalesced BCC too large (%u)\n", byte_count);
+		return -EPROTO;
+	}
+	put_bcc(byte_count, target_hdr);
+
+	byte_count = *pdu_len;
+	byte_count += total_in_src;
+	/* don't allow buffer to overflow */
+	if (byte_count > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE) {
+		cifs_dbg(FYI, "coalesced BCC exceeds buffer size (%u)\n",
+			 byte_count);
+		return -ENOBUFS;
+	}
+	*pdu_len = byte_count;
+
+	/* copy second buffer into end of first buffer */
+	memcpy(data_area_of_tgt, data_area_of_src, total_in_src);
+
+	if (remaining != total_in_src) {
+		/* more responses to go */
+		cifs_dbg(FYI, "waiting for more secondary responses\n");
+		return 1;
+	}
+
+	/* we are done */
+	cifs_dbg(FYI, "found the last secondary response\n");
+	return 0;
+}
+
+bool
+cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+		  char *buf, int malformed)
+{
+	if (malformed)
+		return false;
+	if (check2ndT2(buf) <= 0)
+		return false;
+	mid->multiRsp = true;
+	if (mid->resp_buf) {
+		/* merge response - fix up 1st*/
+		malformed = coalesce_t2(buf, mid->resp_buf, &mid->response_pdu_len);
+		if (malformed > 0)
+			return true;
+		/* All parts received or packet is malformed. */
+		mid->multiEnd = true;
+		dequeue_mid(server, mid, malformed);
+		return true;
+	}
+	if (!server->large_buf) {
+		/*FIXME: switch to already allocated largebuf?*/
+		cifs_dbg(VFS, "1st trans2 resp needs bigbuf\n");
+	} else {
+		/* Have first buffer */
+		mid->resp_buf = buf;
+		mid->large_buf = true;
+		server->bigbuf = NULL;
+	}
+	return true;
+}


