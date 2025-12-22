Return-Path: <linux-fsdevel+bounces-71877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C82A9CD76E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5F9930D7324
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC1D34EEF3;
	Mon, 22 Dec 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIBbn0f/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD734E749
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442717; cv=none; b=eO5tP9tmjUV9wfrQcLgQpDWL7mUom7H7tUmOxF1aaG2Co32VxDeuNW7f/9g0tjv1xrwoU9GnJ2KhhAJHuaYETfJ6mTouqQpVCK1rKfBCUnsGEx686j2wQGWZEaVC+5jRmcKsHFJPj410JagMWq7AbnCbV5F4fEJfxST8uUTJRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442717; c=relaxed/simple;
	bh=NVRdEtktZJbq6fC7cfl9h8+h45P8Bi3Lwe/HQM1YgVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fubI/DtRVfmbsdGwvjxODZHEDZ8ODCA0CFoNCUu0+8cRLttFAzpd6WZJ85j08xEHGPfUB0l/NwUY9VGYGXnrVux28olMJM2GRyEHVq4+uD3qCUDRTxQ5HgRVBOLvi7xb6V7Sm1VX8C5czE/eKMKRNdu0Qi9xQg1CCc8qXYtFVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIBbn0f/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rNakbEn6u9cRJzFiPY9ezVnD3Yta7m0219OSft6suU=;
	b=AIBbn0f/2uiIPYlketIGwrC06vRJxuSBCi9UgZFR8zcLr/9l7bZcXkfl4W6eCpBqwQGLw1
	1Gpf3eEZIINQDZJ52CfWDKVwuesIjlMVGag0j66qWv4XsSBbwpVp5hNKvQnad7c0uTguG0
	YyWkuV3t6yCQLn1/IkazmhIQXm4SBr4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-F6xs7XQ7M-qZJl0XLqLHfA-1; Mon,
 22 Dec 2025 17:31:50 -0500
X-MC-Unique: F6xs7XQ7M-qZJl0XLqLHfA-1
X-Mimecast-MFC-AGG-ID: F6xs7XQ7M-qZJl0XLqLHfA_1766442708
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B406D195608E;
	Mon, 22 Dec 2025 22:31:48 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3AB230001A2;
	Mon, 22 Dec 2025 22:31:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/37] cifs: SMB1 split: cifs_debug.c
Date: Mon, 22 Dec 2025 22:29:56 +0000
Message-ID: <20251222223006.1075635-32-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Split SMB1 bits from cifs_debug.c to smb1debug.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/Makefile     |  1 +
 fs/smb/client/cifs_debug.c | 15 ---------------
 fs/smb/client/cifs_debug.h |  2 --
 fs/smb/client/smb1debug.c  | 25 +++++++++++++++++++++++++
 fs/smb/client/smb1proto.h  |  8 ++++++++
 fs/smb/common/smb2pdu.h    |  3 +++
 6 files changed, 37 insertions(+), 17 deletions(-)
 create mode 100644 fs/smb/client/smb1debug.c

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index 9754b4776df8..c51f67a5caaa 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -34,6 +34,7 @@ cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
 
 cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += \
 	cifssmb.o \
+	smb1debug.o \
 	smb1ops.o \
 	smb1transport.o
 
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index b21444777872..b5917329fd48 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -36,21 +36,6 @@ cifs_dump_mem(char *label, void *data, int length)
 		       data, length, true);
 }
 
-void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server)
-{
-#ifdef CONFIG_CIFS_DEBUG2
-	struct smb_hdr *smb = buf;
-
-	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d Wct: %d\n",
-		 smb->Command, smb->Status.CifsError, smb->Flags,
-		 smb->Flags2, smb->Mid, smb->Pid, smb->WordCount);
-	if (!server->ops->check_message(buf, buf_len, server->total_read, server)) {
-		cifs_dbg(VFS, "smb buf %p len %u\n", smb,
-			 server->ops->calc_smb_size(smb));
-	}
-#endif /* CONFIG_CIFS_DEBUG2 */
-}
-
 void cifs_dump_mids(struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_DEBUG2
diff --git a/fs/smb/client/cifs_debug.h b/fs/smb/client/cifs_debug.h
index 35bd5c8e1d71..00650929a133 100644
--- a/fs/smb/client/cifs_debug.h
+++ b/fs/smb/client/cifs_debug.h
@@ -15,8 +15,6 @@
 #define pr_fmt(fmt) "CIFS: " fmt
 
 void cifs_dump_mem(char *label, void *data, int length);
-void cifs_dump_detail(void *buf, size_t buf_len,
-		      struct TCP_Server_Info *server);
 void cifs_dump_mids(struct TCP_Server_Info *server);
 extern bool traceSMB;		/* flag which enables the function below */
 void dump_smb(void *buf, int smb_buf_length);
diff --git a/fs/smb/client/smb1debug.c b/fs/smb/client/smb1debug.c
new file mode 100644
index 000000000000..e2d013e751e5
--- /dev/null
+++ b/fs/smb/client/smb1debug.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *   Copyright (C) International Business Machines  Corp., 2000,2005
+ *
+ *   Modified by Steve French (sfrench@us.ibm.com)
+ */
+#include "cifsproto.h"
+#include "smb1proto.h"
+#include "cifs_debug.h"
+
+void cifs_dump_detail(void *buf, size_t buf_len, struct TCP_Server_Info *server)
+{
+#ifdef CONFIG_CIFS_DEBUG2
+	struct smb_hdr *smb = buf;
+
+	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Flgs2: 0x%x Mid: %d Pid: %d Wct: %d\n",
+		 smb->Command, smb->Status.CifsError, smb->Flags,
+		 smb->Flags2, smb->Mid, smb->Pid, smb->WordCount);
+	if (!server->ops->check_message(buf, buf_len, server->total_read, server)) {
+		cifs_dbg(VFS, "smb buf %p len %u\n", smb,
+			 server->ops->calc_smb_size(smb));
+	}
+#endif /* CONFIG_CIFS_DEBUG2 */
+}
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index abbc3db11743..de021e17dc4b 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -8,10 +8,12 @@
 #ifndef _SMB1PROTO_H
 #define _SMB1PROTO_H
 
+#include <linux/uidgid_types.h>
 #include "../common/smb2pdu.h"
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 
+#include "cifsglob.h"
 #include <linux/unaligned.h>
 
 struct cifs_unix_set_info_args {
@@ -212,6 +214,12 @@ int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 		 const struct nls_table *nls_codepage,
 		 struct cifs_sb_info *cifs_sb);
 
+/*
+ * smb1debug.c
+ */
+void cifs_dump_detail(void *buf, size_t buf_len,
+		      struct TCP_Server_Info *server);
+
 /*
  * smb1ops.c
  */
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index f5ebbe31384a..e482c86ceb00 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -2,6 +2,9 @@
 #ifndef _COMMON_SMB2PDU_H
 #define _COMMON_SMB2PDU_H
 
+#include <linux/types.h>
+#include <linux/build_bug.h>
+
 /*
  * Note that, due to trying to use names similar to the protocol specifications,
  * there are many mixed case field names in the structures below.  Although


