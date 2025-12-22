Return-Path: <linux-fsdevel+bounces-71869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753BCD76CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25B530C211A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35F3446D4;
	Mon, 22 Dec 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdS8Uz/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953034D388
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442696; cv=none; b=RXV6XfOUelaOpcj66DL9t1i4ABMfTup9fIGgNjwpXNrl3l/iacSZafDFPfzr1XSULBB0E6BuYfX50v5PLbRk+ano9W5D4mx+o1E8vbBFWmEz0pgRR8wEA7soJBKCfvPs2Psf2sevwiuDjr97eTaUh8M8c51gnHTN+7mBPWCKNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442696; c=relaxed/simple;
	bh=WuCdX1Gr3eK2igEkrEvo43FQ+Th3pZP7uuTQnDF6RXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baO7CG2CsfMIpDUhlocoLFHupSRCPNvFK3pEXWxLXHpmzpTKw9lVrJsLYnzF8k+0tUsF8B4JbpfUMJquCtXPbKu7sXDNPc5cmC8qcWkK/QhG7X3MWnPFmWA3JghY7Q7ku++3iaOVsoOV6EGuMt4Wu+71qLLqXy9x+RuM/7LLGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdS8Uz/D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3J/CY11n9q3K0X0HaiY/3k1uvSwwiXgGKpnLN4g85nk=;
	b=FdS8Uz/Don2NjQmgRbMTmGVu4ClfjRLcq22wfqLEu1+eW7o5vfJHTUPgA3d17MW0PywpSl
	VQrZwRGzNU2qwEAqu8C5Y2cykEYegQo1z1njWD92q32YQOydavDaGNKZtgsv24/FLqcuNj
	4XmA2ODywG5Ci/hdsGbUlCDbAYjrmkQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-s1AuyS8sMw-cUGLdQMRboQ-1; Mon,
 22 Dec 2025 17:31:24 -0500
X-MC-Unique: s1AuyS8sMw-cUGLdQMRboQ-1
X-Mimecast-MFC-AGG-ID: s1AuyS8sMw-cUGLdQMRboQ_1766442683
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68185195605A;
	Mon, 22 Dec 2025 22:31:23 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3D9A1800664;
	Mon, 22 Dec 2025 22:31:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 23/37] cifs: SMB1 split: Move some SMB1 received PDU checking bits to smb1transport.c
Date: Mon, 22 Dec 2025 22:29:48 +0000
Message-ID: <20251222223006.1075635-24-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move some SMB1 received checking bits to smb1transport.c from misc.c
so that they're with the rest of the receive handling code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifsproto.h     |   2 -
 fs/smb/client/misc.c          | 126 ----------------------------------
 fs/smb/client/smb1proto.h     |   2 +
 fs/smb/client/smb1transport.c | 126 ++++++++++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index b151796b3ba5..53d23958b9da 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -131,8 +131,6 @@ void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 void cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 					   bool mark_smb_session);
 int cifs_reconnect(struct TCP_Server_Info *server, bool mark_smb_session);
-int checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
-	     struct TCP_Server_Info *server);
 bool is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv);
 bool backup_cred(struct cifs_sb_info *cifs_sb);
 bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 9529fa385938..f3ecdf20dbe0 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -314,132 +314,6 @@ header_assemble(struct smb_hdr *buffer, char smb_command,
 	return in_len;
 }
 
-static int
-check_smb_hdr(struct smb_hdr *smb)
-{
-	/* does it have the right SMB "signature" ? */
-	if (*(__le32 *) smb->Protocol != SMB1_PROTO_NUMBER) {
-		cifs_dbg(VFS, "Bad protocol string signature header 0x%x\n",
-			 *(unsigned int *)smb->Protocol);
-		return 1;
-	}
-
-	/* if it's a response then accept */
-	if (smb->Flags & SMBFLG_RESPONSE)
-		return 0;
-
-	/* only one valid case where server sends us request */
-	if (smb->Command == SMB_COM_LOCKING_ANDX)
-		return 0;
-
-	/*
-	 * Windows NT server returns error resposne (e.g. STATUS_DELETE_PENDING
-	 * or STATUS_OBJECT_NAME_NOT_FOUND or ERRDOS/ERRbadfile or any other)
-	 * for some TRANS2 requests without the RESPONSE flag set in header.
-	 */
-	if (smb->Command == SMB_COM_TRANSACTION2 && smb->Status.CifsError != 0)
-		return 0;
-
-	cifs_dbg(VFS, "Server sent request, not response. mid=%u\n",
-		 get_mid(smb));
-	return 1;
-}
-
-int
-checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
-	 struct TCP_Server_Info *server)
-{
-	struct smb_hdr *smb = (struct smb_hdr *)buf;
-	__u32 rfclen = pdu_len;
-	__u32 clc_len;  /* calculated length */
-	cifs_dbg(FYI, "checkSMB Length: 0x%x, smb_buf_length: 0x%x\n",
-		 total_read, rfclen);
-
-	/* is this frame too small to even get to a BCC? */
-	if (total_read < 2 + sizeof(struct smb_hdr)) {
-		if ((total_read >= sizeof(struct smb_hdr) - 1)
-			    && (smb->Status.CifsError != 0)) {
-			/* it's an error return */
-			smb->WordCount = 0;
-			/* some error cases do not return wct and bcc */
-			return 0;
-		} else if ((total_read == sizeof(struct smb_hdr) + 1) &&
-				(smb->WordCount == 0)) {
-			char *tmp = (char *)smb;
-			/* Need to work around a bug in two servers here */
-			/* First, check if the part of bcc they sent was zero */
-			if (tmp[sizeof(struct smb_hdr)] == 0) {
-				/* some servers return only half of bcc
-				 * on simple responses (wct, bcc both zero)
-				 * in particular have seen this on
-				 * ulogoffX and FindClose. This leaves
-				 * one byte of bcc potentially uninitialized
-				 */
-				/* zero rest of bcc */
-				tmp[sizeof(struct smb_hdr)+1] = 0;
-				return 0;
-			}
-			cifs_dbg(VFS, "rcvd invalid byte count (bcc)\n");
-			return smb_EIO1(smb_eio_trace_rx_inv_bcc, tmp[sizeof(struct smb_hdr)]);
-		} else {
-			cifs_dbg(VFS, "Length less than smb header size\n");
-			return smb_EIO2(smb_eio_trace_rx_too_short,
-					total_read, smb->WordCount);
-		}
-	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
-		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
-			 __func__, smb->WordCount);
-		return smb_EIO2(smb_eio_trace_rx_check_rsp,
-				total_read, 2 + sizeof(struct smb_hdr));
-	}
-
-	/* otherwise, there is enough to get to the BCC */
-	if (check_smb_hdr(smb))
-		return smb_EIO1(smb_eio_trace_rx_rfc1002_magic, *(u32 *)smb->Protocol);
-	clc_len = smbCalcSize(smb);
-
-	if (rfclen != total_read) {
-		cifs_dbg(VFS, "Length read does not match RFC1001 length %d/%d\n",
-			 rfclen, total_read);
-		return smb_EIO2(smb_eio_trace_rx_check_rsp,
-				total_read, rfclen);
-	}
-
-	if (rfclen != clc_len) {
-		__u16 mid = get_mid(smb);
-		/* check if bcc wrapped around for large read responses */
-		if ((rfclen > 64 * 1024) && (rfclen > clc_len)) {
-			/* check if lengths match mod 64K */
-			if (((rfclen) & 0xFFFF) == (clc_len & 0xFFFF))
-				return 0; /* bcc wrapped */
-		}
-		cifs_dbg(FYI, "Calculated size %u vs length %u mismatch for mid=%u\n",
-			 clc_len, rfclen, mid);
-
-		if (rfclen < clc_len) {
-			cifs_dbg(VFS, "RFC1001 size %u smaller than SMB for mid=%u\n",
-				 rfclen, mid);
-			return smb_EIO2(smb_eio_trace_rx_calc_len_too_big,
-					rfclen, clc_len);
-		} else if (rfclen > clc_len + 512) {
-			/*
-			 * Some servers (Windows XP in particular) send more
-			 * data than the lengths in the SMB packet would
-			 * indicate on certain calls (byte range locks and
-			 * trans2 find first calls in particular). While the
-			 * client can handle such a frame by ignoring the
-			 * trailing data, we choose limit the amount of extra
-			 * data to 512 bytes.
-			 */
-			cifs_dbg(VFS, "RFC1001 size %u more than 512 bytes larger than SMB for mid=%u\n",
-				 rfclen, mid);
-			return smb_EIO2(smb_eio_trace_rx_overlong,
-					rfclen, clc_len + 512);
-		}
-	}
-	return 0;
-}
-
 bool
 is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 {
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index bf24974fbb00..c73cc10dfcc8 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -235,6 +235,8 @@ int SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		const int flags);
 bool cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		       char *buf, int malformed);
+int checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
+	     struct TCP_Server_Info *server);
 
 
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 5f95bffc8e44..5e508b2c661f 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -432,3 +432,129 @@ cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 	}
 	return true;
 }
+
+static int
+check_smb_hdr(struct smb_hdr *smb)
+{
+	/* does it have the right SMB "signature" ? */
+	if (*(__le32 *) smb->Protocol != SMB1_PROTO_NUMBER) {
+		cifs_dbg(VFS, "Bad protocol string signature header 0x%x\n",
+			 *(unsigned int *)smb->Protocol);
+		return 1;
+	}
+
+	/* if it's a response then accept */
+	if (smb->Flags & SMBFLG_RESPONSE)
+		return 0;
+
+	/* only one valid case where server sends us request */
+	if (smb->Command == SMB_COM_LOCKING_ANDX)
+		return 0;
+
+	/*
+	 * Windows NT server returns error resposne (e.g. STATUS_DELETE_PENDING
+	 * or STATUS_OBJECT_NAME_NOT_FOUND or ERRDOS/ERRbadfile or any other)
+	 * for some TRANS2 requests without the RESPONSE flag set in header.
+	 */
+	if (smb->Command == SMB_COM_TRANSACTION2 && smb->Status.CifsError != 0)
+		return 0;
+
+	cifs_dbg(VFS, "Server sent request, not response. mid=%u\n",
+		 get_mid(smb));
+	return 1;
+}
+
+int
+checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
+	 struct TCP_Server_Info *server)
+{
+	struct smb_hdr *smb = (struct smb_hdr *)buf;
+	__u32 rfclen = pdu_len;
+	__u32 clc_len;  /* calculated length */
+	cifs_dbg(FYI, "checkSMB Length: 0x%x, smb_buf_length: 0x%x\n",
+		 total_read, rfclen);
+
+	/* is this frame too small to even get to a BCC? */
+	if (total_read < 2 + sizeof(struct smb_hdr)) {
+		if ((total_read >= sizeof(struct smb_hdr) - 1)
+			    && (smb->Status.CifsError != 0)) {
+			/* it's an error return */
+			smb->WordCount = 0;
+			/* some error cases do not return wct and bcc */
+			return 0;
+		} else if ((total_read == sizeof(struct smb_hdr) + 1) &&
+				(smb->WordCount == 0)) {
+			char *tmp = (char *)smb;
+			/* Need to work around a bug in two servers here */
+			/* First, check if the part of bcc they sent was zero */
+			if (tmp[sizeof(struct smb_hdr)] == 0) {
+				/* some servers return only half of bcc
+				 * on simple responses (wct, bcc both zero)
+				 * in particular have seen this on
+				 * ulogoffX and FindClose. This leaves
+				 * one byte of bcc potentially uninitialized
+				 */
+				/* zero rest of bcc */
+				tmp[sizeof(struct smb_hdr)+1] = 0;
+				return 0;
+			}
+			cifs_dbg(VFS, "rcvd invalid byte count (bcc)\n");
+			return smb_EIO1(smb_eio_trace_rx_inv_bcc, tmp[sizeof(struct smb_hdr)]);
+		} else {
+			cifs_dbg(VFS, "Length less than smb header size\n");
+			return smb_EIO2(smb_eio_trace_rx_too_short,
+					total_read, smb->WordCount);
+		}
+	} else if (total_read < sizeof(*smb) + 2 * smb->WordCount) {
+		cifs_dbg(VFS, "%s: can't read BCC due to invalid WordCount(%u)\n",
+			 __func__, smb->WordCount);
+		return smb_EIO2(smb_eio_trace_rx_check_rsp,
+				total_read, 2 + sizeof(struct smb_hdr));
+	}
+
+	/* otherwise, there is enough to get to the BCC */
+	if (check_smb_hdr(smb))
+		return smb_EIO1(smb_eio_trace_rx_rfc1002_magic, *(u32 *)smb->Protocol);
+	clc_len = smbCalcSize(smb);
+
+	if (rfclen != total_read) {
+		cifs_dbg(VFS, "Length read does not match RFC1001 length %d/%d\n",
+			 rfclen, total_read);
+		return smb_EIO2(smb_eio_trace_rx_check_rsp,
+				total_read, rfclen);
+	}
+
+	if (rfclen != clc_len) {
+		__u16 mid = get_mid(smb);
+		/* check if bcc wrapped around for large read responses */
+		if ((rfclen > 64 * 1024) && (rfclen > clc_len)) {
+			/* check if lengths match mod 64K */
+			if (((rfclen) & 0xFFFF) == (clc_len & 0xFFFF))
+				return 0; /* bcc wrapped */
+		}
+		cifs_dbg(FYI, "Calculated size %u vs length %u mismatch for mid=%u\n",
+			 clc_len, rfclen, mid);
+
+		if (rfclen < clc_len) {
+			cifs_dbg(VFS, "RFC1001 size %u smaller than SMB for mid=%u\n",
+				 rfclen, mid);
+			return smb_EIO2(smb_eio_trace_rx_calc_len_too_big,
+					rfclen, clc_len);
+		} else if (rfclen > clc_len + 512) {
+			/*
+			 * Some servers (Windows XP in particular) send more
+			 * data than the lengths in the SMB packet would
+			 * indicate on certain calls (byte range locks and
+			 * trans2 find first calls in particular). While the
+			 * client can handle such a frame by ignoring the
+			 * trailing data, we choose limit the amount of extra
+			 * data to 512 bytes.
+			 */
+			cifs_dbg(VFS, "RFC1001 size %u more than 512 bytes larger than SMB for mid=%u\n",
+				 rfclen, mid);
+			return smb_EIO2(smb_eio_trace_rx_overlong,
+					rfclen, clc_len + 512);
+		}
+	}
+	return 0;
+}


