Return-Path: <linux-fsdevel+bounces-71872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFFCD7691
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8011A30215FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B634D3A7;
	Mon, 22 Dec 2025 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H10nFiy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8834678C
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442705; cv=none; b=mE6RkGLh6OnzdzCHKmpZ3SbhIj3l8RKlkWmUeFJK0LhL+plrwZXoubS0i+Rl68fWpo2B9Br1SSuFunXDGCOMdC8l4dy0FQ17EgGe3PRecu8JIqK8aX5hwGGtpda24SnCBbds0ULkOXA1WGV12sLGz4MsRohxNO2j3+iuHUBpeHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442705; c=relaxed/simple;
	bh=v6XUfqsxGfDcxih3YUwBt2ds2mBBaoPyIte4MhEPus0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYZkkC8r3uJTX5b1MviH6HFpPrLIdxdniQLs195bIdVy/rAlt+kbsSZ+SnBxb3mfUxuoezhm3ay4r9OTBlPh20lwPYz/fZqMOlddquAK8Adi/UPQiyfy88CTCl2HqrDnazu1cp0gxR/ptsqNpG+oAcDRfP594UVfZnFY+GlGJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H10nFiy4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JYYMSse3oodIxM/AA0UcpSiq0y1d7sFfiQEXTbMGnVg=;
	b=H10nFiy4X+8pTI9sxyQvDZrjN5A40QLIib3wFmm0QeeQosGAkrx1mp2jI7m8oQ0aOj2Afp
	jkUa8ikwOJq5TaCkhzgY0ZO9lu26g7jrRWg9Jh8A3Cq30co9j3E5MXQFHPUyaeaa9ZfMI9
	A1A7nmFR0i+Xgj2hDUG8OSX92xIO4Ls=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-oZMo1kr3OEeF6vUlvDF1_A-1; Mon,
 22 Dec 2025 17:31:38 -0500
X-MC-Unique: oZMo1kr3OEeF6vUlvDF1_A-1
X-Mimecast-MFC-AGG-ID: oZMo1kr3OEeF6vUlvDF1_A_1766442696
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE93D1956088;
	Mon, 22 Dec 2025 22:31:36 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E137319560AB;
	Mon, 22 Dec 2025 22:31:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/37] cifs: SMB1 split: Move BCC access functions
Date: Mon, 22 Dec 2025 22:29:52 +0000
Message-ID: <20251222223006.1075635-28-dhowells@redhat.com>
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

Move the BCC access functions to smb1proto.h as they're only applicable to
SMB1.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/cifspdu.h   | 34 ----------------------------------
 fs/smb/client/smb1proto.h | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index de061247ecd7..78512af18d96 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -9,38 +9,4 @@
 #ifndef _CIFSPDU_H
 #define _CIFSPDU_H
 
-#include <linux/unaligned.h>
-#include "../common/smb1pdu.h"
-
-#define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */
-#define GETU32(var)  (*((__u32 *)var))	/* BB check for endian issues */
-
-/* given a pointer to an smb_hdr, retrieve a void pointer to the ByteCount */
-static inline void *
-BCC(struct smb_hdr *smb)
-{
-	return (void *)smb + sizeof(*smb) + 2 * smb->WordCount;
-}
-
-/* given a pointer to an smb_hdr retrieve the pointer to the byte area */
-#define pByteArea(smb_var) (BCC(smb_var) + 2)
-
-/* get the unconverted ByteCount for a SMB packet and return it */
-static inline __u16
-get_bcc(struct smb_hdr *hdr)
-{
-	__le16 *bc_ptr = (__le16 *)BCC(hdr);
-
-	return get_unaligned_le16(bc_ptr);
-}
-
-/* set the ByteCount for a SMB packet in little-endian */
-static inline void
-put_bcc(__u16 count, struct smb_hdr *hdr)
-{
-	__le16 *bc_ptr = (__le16 *)BCC(hdr);
-
-	put_unaligned_le16(count, bc_ptr);
-}
-
 #endif /* _CIFSPDU_H */
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index 916030b1d635..eaf317a53b76 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -8,10 +8,12 @@
 #ifndef _SMB1PROTO_H
 #define _SMB1PROTO_H
 
-#include "cifspdu.h"
+#include "../common/smb2pdu.h"
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 
+#include <linux/unaligned.h>
+
 struct cifs_unix_set_info_args {
 	__u64	ctime;
 	__u64	atime;
@@ -242,4 +244,36 @@ int checkSMB(char *buf, unsigned int pdu_len, unsigned int total_read,
 
 
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
+
+#define GETU16(var)  (*((__u16 *)var))	/* BB check for endian issues */
+#define GETU32(var)  (*((__u32 *)var))	/* BB check for endian issues */
+
+/* given a pointer to an smb_hdr, retrieve a void pointer to the ByteCount */
+static inline void *
+BCC(struct smb_hdr *smb)
+{
+	return (void *)smb + sizeof(*smb) + 2 * smb->WordCount;
+}
+
+/* given a pointer to an smb_hdr retrieve the pointer to the byte area */
+#define pByteArea(smb_var) (BCC(smb_var) + 2)
+
+/* get the unconverted ByteCount for a SMB packet and return it */
+static inline __u16
+get_bcc(struct smb_hdr *hdr)
+{
+	__le16 *bc_ptr = (__le16 *)BCC(hdr);
+
+	return get_unaligned_le16(bc_ptr);
+}
+
+/* set the ByteCount for a SMB packet in little-endian */
+static inline void
+put_bcc(__u16 count, struct smb_hdr *hdr)
+{
+	__le16 *bc_ptr = (__le16 *)BCC(hdr);
+
+	put_unaligned_le16(count, bc_ptr);
+}
+
 #endif /* _SMB1PROTO_H */


