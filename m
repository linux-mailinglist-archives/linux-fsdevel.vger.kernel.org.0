Return-Path: <linux-fsdevel+bounces-71878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D7CD76E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 00:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F96230380FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5C34EF05;
	Mon, 22 Dec 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuemNAvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2034E760
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442718; cv=none; b=DPpVR3q/ItQdQMf9grp2So7wvUAdyHoNTXef54V73pl5sUzS+w61ptIkPDoiaZJc0JWTY7SZaC+dmXgQbIAeb6DO7rymDv9KcoPNHa0omdZHp/skRD0s3nicwIfGjcqay7V+8SHAVHC6tEWh/Xs9USl7TsUjWrTE+9j4ZcYlaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442718; c=relaxed/simple;
	bh=ZDKu2++B7BFkwdi1cw+860rqZEWpPkElme+Du6P9Xos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCsAwKATcnzWtsuXWI3lfvFPhkUjPnvhv0mYo698rpIV6CECybD0iUQLgL9mGmvRFZZmhB9Ik0PWgUoalMC9ax7fGWnsSPiqh3prv9r49V+morGEn8eXrUKjnuCguJLJxKGtEIJSYakL3Yd8vHBnhNKYnu2W++fOX7TwaWItCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuemNAvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766442716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2bHUFjgtHnt0pzv9uZhJdA2s3CnNTbaaTJ1v0TSe+M=;
	b=IuemNAvd8VHXyGYHt5Q7oqNXibhkvf9AYt0hCBY58TZ+7PqS3gMcbkQvmZVElwQJ65hM9w
	OO1RaCXDaVrScsjJX755zBtQi+zfp/ADFdTExCHop1a1GUO296pzGixToGKU9zGxIZqaUA
	nuHHdhtrZsS2fJx4StYke7YETKhGKL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-xicOQjEKMWaWPOP1ZFxkAw-1; Mon,
 22 Dec 2025 17:31:52 -0500
X-MC-Unique: xicOQjEKMWaWPOP1ZFxkAw-1
X-Mimecast-MFC-AGG-ID: xicOQjEKMWaWPOP1ZFxkAw_1766442711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9943618002C9;
	Mon, 22 Dec 2025 22:31:51 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D844519560A7;
	Mon, 22 Dec 2025 22:31:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 32/37] cifs: SMB1 split: misc.c
Date: Mon, 22 Dec 2025 22:29:57 +0000
Message-ID: <20251222223006.1075635-33-dhowells@redhat.com>
In-Reply-To: <20251222223006.1075635-1-dhowells@redhat.com>
References: <20251222223006.1075635-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Split SMB1 bits from misc.c to smb1misc.c.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 fs/smb/client/Makefile    |   1 +
 fs/smb/client/cifsproto.h |   4 -
 fs/smb/client/misc.c      | 165 -----------------------------------
 fs/smb/client/smb1misc.c  | 177 ++++++++++++++++++++++++++++++++++++++
 fs/smb/client/smb1proto.h |   7 ++
 5 files changed, 185 insertions(+), 169 deletions(-)
 create mode 100644 fs/smb/client/smb1misc.c

diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
index c51f67a5caaa..5288f9de07cd 100644
--- a/fs/smb/client/Makefile
+++ b/fs/smb/client/Makefile
@@ -35,6 +35,7 @@ cifs-$(CONFIG_CIFS_ROOT) += cifsroot.o
 cifs-$(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) += \
 	cifssmb.o \
 	smb1debug.o \
+	smb1misc.o \
 	smb1ops.o \
 	smb1transport.o
 
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 6cf084aeb30e..fc97c6c452d2 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -131,7 +131,6 @@ void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 void cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 					   bool mark_smb_session);
 int cifs_reconnect(struct TCP_Server_Info *server, bool mark_smb_session);
-bool is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv);
 bool backup_cred(struct cifs_sb_info *cifs_sb);
 bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
 			    bool from_readdir);
@@ -157,9 +156,6 @@ void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 int map_smb_to_linux_error(char *buf, bool logErr);
 int map_and_check_smb_error(struct TCP_Server_Info *server,
 			    struct mid_q_entry *mid, bool logErr);
-unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
-			     const struct cifs_tcon *treeCon, int word_count
-			     /* length of fixed section (word count) in two byte units  */);
 int CIFS_SessSetup(const unsigned int xid, struct cifs_ses *ses,
 		   struct TCP_Server_Info *server,
 		   const struct nls_table *nls_cp);
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 273c54d39857..1773e3b471aa 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -262,171 +262,6 @@ free_rsp_buf(int resp_buftype, void *rsp)
 		cifs_buf_release(rsp);
 }
 
-/* NB: MID can not be set if treeCon not passed in, in that
-   case it is responsibility of caller to set the mid */
-unsigned int
-header_assemble(struct smb_hdr *buffer, char smb_command,
-		const struct cifs_tcon *treeCon, int word_count
-		/* length of fixed section (word count) in two byte units  */)
-{
-	unsigned int in_len;
-	char *temp = (char *) buffer;
-
-	memset(temp, 0, 256); /* bigger than MAX_CIFS_HDR_SIZE */
-
-	in_len = (2 * word_count) + sizeof(struct smb_hdr) +
-		2 /* for bcc field itself */;
-
-	buffer->Protocol[0] = 0xFF;
-	buffer->Protocol[1] = 'S';
-	buffer->Protocol[2] = 'M';
-	buffer->Protocol[3] = 'B';
-	buffer->Command = smb_command;
-	buffer->Flags = 0x00;	/* case sensitive */
-	buffer->Flags2 = SMBFLG2_KNOWS_LONG_NAMES;
-	buffer->Pid = cpu_to_le16((__u16)current->tgid);
-	buffer->PidHigh = cpu_to_le16((__u16)(current->tgid >> 16));
-	if (treeCon) {
-		buffer->Tid = treeCon->tid;
-		if (treeCon->ses) {
-			if (treeCon->ses->capabilities & CAP_UNICODE)
-				buffer->Flags2 |= SMBFLG2_UNICODE;
-			if (treeCon->ses->capabilities & CAP_STATUS32)
-				buffer->Flags2 |= SMBFLG2_ERR_STATUS;
-
-			/* Uid is not converted */
-			buffer->Uid = treeCon->ses->Suid;
-			if (treeCon->ses->server)
-				buffer->Mid = get_next_mid(treeCon->ses->server);
-		}
-		if (treeCon->Flags & SMB_SHARE_IS_IN_DFS)
-			buffer->Flags2 |= SMBFLG2_DFS;
-		if (treeCon->nocase)
-			buffer->Flags  |= SMBFLG_CASELESS;
-		if ((treeCon->ses) && (treeCon->ses->server))
-			if (treeCon->ses->server->sign)
-				buffer->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
-	}
-
-/*  endian conversion of flags is now done just before sending */
-	buffer->WordCount = (char) word_count;
-	return in_len;
-}
-
-bool
-is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
-{
-	struct smb_hdr *buf = (struct smb_hdr *)buffer;
-	struct smb_com_lock_req *pSMB = (struct smb_com_lock_req *)buf;
-	struct TCP_Server_Info *pserver;
-	struct cifs_ses *ses;
-	struct cifs_tcon *tcon;
-	struct cifsInodeInfo *pCifsInode;
-	struct cifsFileInfo *netfile;
-
-	cifs_dbg(FYI, "Checking for oplock break or dnotify response\n");
-	if ((pSMB->hdr.Command == SMB_COM_NT_TRANSACT) &&
-	   (pSMB->hdr.Flags & SMBFLG_RESPONSE)) {
-		struct smb_com_transaction_change_notify_rsp *pSMBr =
-			(struct smb_com_transaction_change_notify_rsp *)buf;
-		struct file_notify_information *pnotify;
-		__u32 data_offset = 0;
-		size_t len = srv->total_read - srv->pdu_size;
-
-		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
-			data_offset = le32_to_cpu(pSMBr->DataOffset);
-
-			if (data_offset >
-			    len - sizeof(struct file_notify_information)) {
-				cifs_dbg(FYI, "Invalid data_offset %u\n",
-					 data_offset);
-				return true;
-			}
-			pnotify = (struct file_notify_information *)
-				((char *)&pSMBr->hdr.Protocol + data_offset);
-			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",
-				 pnotify->FileName, pnotify->Action);
-			/*   cifs_dump_mem("Rcvd notify Data: ",buf,
-				sizeof(struct smb_hdr)+60); */
-			return true;
-		}
-		if (pSMBr->hdr.Status.CifsError) {
-			cifs_dbg(FYI, "notify err 0x%x\n",
-				 pSMBr->hdr.Status.CifsError);
-			return true;
-		}
-		return false;
-	}
-	if (pSMB->hdr.Command != SMB_COM_LOCKING_ANDX)
-		return false;
-	if (pSMB->hdr.Flags & SMBFLG_RESPONSE) {
-		/* no sense logging error on invalid handle on oplock
-		   break - harmless race between close request and oplock
-		   break response is expected from time to time writing out
-		   large dirty files cached on the client */
-		if ((NT_STATUS_INVALID_HANDLE) ==
-		   le32_to_cpu(pSMB->hdr.Status.CifsError)) {
-			cifs_dbg(FYI, "Invalid handle on oplock break\n");
-			return true;
-		} else if (ERRbadfid ==
-		   le16_to_cpu(pSMB->hdr.Status.DosError.Error)) {
-			return true;
-		} else {
-			return false; /* on valid oplock brk we get "request" */
-		}
-	}
-	if (pSMB->hdr.WordCount != 8)
-		return false;
-
-	cifs_dbg(FYI, "oplock type 0x%x level 0x%x\n",
-		 pSMB->LockType, pSMB->OplockLevel);
-	if (!(pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE))
-		return false;
-
-	/* If server is a channel, select the primary channel */
-	pserver = SERVER_IS_CHAN(srv) ? srv->primary_server : srv;
-
-	/* look up tcon based on tid & uid */
-	spin_lock(&cifs_tcp_ses_lock);
-	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
-		if (cifs_ses_exiting(ses))
-			continue;
-		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
-			if (tcon->tid != buf->Tid)
-				continue;
-
-			cifs_stats_inc(&tcon->stats.cifs_stats.num_oplock_brks);
-			spin_lock(&tcon->open_file_lock);
-			list_for_each_entry(netfile, &tcon->openFileList, tlist) {
-				if (pSMB->Fid != netfile->fid.netfid)
-					continue;
-
-				cifs_dbg(FYI, "file id match, oplock break\n");
-				pCifsInode = CIFS_I(d_inode(netfile->dentry));
-
-				set_bit(CIFS_INODE_PENDING_OPLOCK_BREAK,
-					&pCifsInode->flags);
-
-				netfile->oplock_epoch = 0;
-				netfile->oplock_level = pSMB->OplockLevel;
-				netfile->oplock_break_cancelled = false;
-				cifs_queue_oplock_break(netfile);
-
-				spin_unlock(&tcon->open_file_lock);
-				spin_unlock(&cifs_tcp_ses_lock);
-				return true;
-			}
-			spin_unlock(&tcon->open_file_lock);
-			spin_unlock(&cifs_tcp_ses_lock);
-			cifs_dbg(FYI, "No matching file for oplock break\n");
-			return true;
-		}
-	}
-	spin_unlock(&cifs_tcp_ses_lock);
-	cifs_dbg(FYI, "Can not process oplock break for non-existent connection\n");
-	return true;
-}
-
 void
 dump_smb(void *buf, int smb_buf_length)
 {
diff --git a/fs/smb/client/smb1misc.c b/fs/smb/client/smb1misc.c
new file mode 100644
index 000000000000..d73ef87f55d0
--- /dev/null
+++ b/fs/smb/client/smb1misc.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ *
+ *   Copyright (C) International Business Machines  Corp., 2002,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ */
+
+#include "smb1proto.h"
+#include "smberr.h"
+#include "nterr.h"
+#include "cifs_debug.h"
+
+/* NB: MID can not be set if treeCon not passed in, in that
+   case it is responsibility of caller to set the mid */
+unsigned int
+header_assemble(struct smb_hdr *buffer, char smb_command,
+		const struct cifs_tcon *treeCon, int word_count
+		/* length of fixed section (word count) in two byte units  */)
+{
+	unsigned int in_len;
+	char *temp = (char *) buffer;
+
+	memset(temp, 0, 256); /* bigger than MAX_CIFS_HDR_SIZE */
+
+	in_len = (2 * word_count) + sizeof(struct smb_hdr) +
+		2 /* for bcc field itself */;
+
+	buffer->Protocol[0] = 0xFF;
+	buffer->Protocol[1] = 'S';
+	buffer->Protocol[2] = 'M';
+	buffer->Protocol[3] = 'B';
+	buffer->Command = smb_command;
+	buffer->Flags = 0x00;	/* case sensitive */
+	buffer->Flags2 = SMBFLG2_KNOWS_LONG_NAMES;
+	buffer->Pid = cpu_to_le16((__u16)current->tgid);
+	buffer->PidHigh = cpu_to_le16((__u16)(current->tgid >> 16));
+	if (treeCon) {
+		buffer->Tid = treeCon->tid;
+		if (treeCon->ses) {
+			if (treeCon->ses->capabilities & CAP_UNICODE)
+				buffer->Flags2 |= SMBFLG2_UNICODE;
+			if (treeCon->ses->capabilities & CAP_STATUS32)
+				buffer->Flags2 |= SMBFLG2_ERR_STATUS;
+
+			/* Uid is not converted */
+			buffer->Uid = treeCon->ses->Suid;
+			if (treeCon->ses->server)
+				buffer->Mid = get_next_mid(treeCon->ses->server);
+		}
+		if (treeCon->Flags & SMB_SHARE_IS_IN_DFS)
+			buffer->Flags2 |= SMBFLG2_DFS;
+		if (treeCon->nocase)
+			buffer->Flags  |= SMBFLG_CASELESS;
+		if ((treeCon->ses) && (treeCon->ses->server))
+			if (treeCon->ses->server->sign)
+				buffer->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
+	}
+
+/*  endian conversion of flags is now done just before sending */
+	buffer->WordCount = (char) word_count;
+	return in_len;
+}
+
+bool
+is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
+{
+	struct smb_hdr *buf = (struct smb_hdr *)buffer;
+	struct smb_com_lock_req *pSMB = (struct smb_com_lock_req *)buf;
+	struct TCP_Server_Info *pserver;
+	struct cifs_ses *ses;
+	struct cifs_tcon *tcon;
+	struct cifsInodeInfo *pCifsInode;
+	struct cifsFileInfo *netfile;
+
+	cifs_dbg(FYI, "Checking for oplock break or dnotify response\n");
+	if ((pSMB->hdr.Command == SMB_COM_NT_TRANSACT) &&
+	   (pSMB->hdr.Flags & SMBFLG_RESPONSE)) {
+		struct smb_com_transaction_change_notify_rsp *pSMBr =
+			(struct smb_com_transaction_change_notify_rsp *)buf;
+		struct file_notify_information *pnotify;
+		__u32 data_offset = 0;
+		size_t len = srv->total_read - srv->pdu_size;
+
+		if (get_bcc(buf) > sizeof(struct file_notify_information)) {
+			data_offset = le32_to_cpu(pSMBr->DataOffset);
+
+			if (data_offset >
+			    len - sizeof(struct file_notify_information)) {
+				cifs_dbg(FYI, "Invalid data_offset %u\n",
+					 data_offset);
+				return true;
+			}
+			pnotify = (struct file_notify_information *)
+				((char *)&pSMBr->hdr.Protocol + data_offset);
+			cifs_dbg(FYI, "dnotify on %s Action: 0x%x\n",
+				 pnotify->FileName, pnotify->Action);
+			/*   cifs_dump_mem("Rcvd notify Data: ",buf,
+				sizeof(struct smb_hdr)+60); */
+			return true;
+		}
+		if (pSMBr->hdr.Status.CifsError) {
+			cifs_dbg(FYI, "notify err 0x%x\n",
+				 pSMBr->hdr.Status.CifsError);
+			return true;
+		}
+		return false;
+	}
+	if (pSMB->hdr.Command != SMB_COM_LOCKING_ANDX)
+		return false;
+	if (pSMB->hdr.Flags & SMBFLG_RESPONSE) {
+		/* no sense logging error on invalid handle on oplock
+		   break - harmless race between close request and oplock
+		   break response is expected from time to time writing out
+		   large dirty files cached on the client */
+		if ((NT_STATUS_INVALID_HANDLE) ==
+		   le32_to_cpu(pSMB->hdr.Status.CifsError)) {
+			cifs_dbg(FYI, "Invalid handle on oplock break\n");
+			return true;
+		} else if (ERRbadfid ==
+		   le16_to_cpu(pSMB->hdr.Status.DosError.Error)) {
+			return true;
+		} else {
+			return false; /* on valid oplock brk we get "request" */
+		}
+	}
+	if (pSMB->hdr.WordCount != 8)
+		return false;
+
+	cifs_dbg(FYI, "oplock type 0x%x level 0x%x\n",
+		 pSMB->LockType, pSMB->OplockLevel);
+	if (!(pSMB->LockType & LOCKING_ANDX_OPLOCK_RELEASE))
+		return false;
+
+	/* If server is a channel, select the primary channel */
+	pserver = SERVER_IS_CHAN(srv) ? srv->primary_server : srv;
+
+	/* look up tcon based on tid & uid */
+	spin_lock(&cifs_tcp_ses_lock);
+	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
+		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
+			if (tcon->tid != buf->Tid)
+				continue;
+
+			cifs_stats_inc(&tcon->stats.cifs_stats.num_oplock_brks);
+			spin_lock(&tcon->open_file_lock);
+			list_for_each_entry(netfile, &tcon->openFileList, tlist) {
+				if (pSMB->Fid != netfile->fid.netfid)
+					continue;
+
+				cifs_dbg(FYI, "file id match, oplock break\n");
+				pCifsInode = CIFS_I(d_inode(netfile->dentry));
+
+				set_bit(CIFS_INODE_PENDING_OPLOCK_BREAK,
+					&pCifsInode->flags);
+
+				netfile->oplock_epoch = 0;
+				netfile->oplock_level = pSMB->OplockLevel;
+				netfile->oplock_break_cancelled = false;
+				cifs_queue_oplock_break(netfile);
+
+				spin_unlock(&tcon->open_file_lock);
+				spin_unlock(&cifs_tcp_ses_lock);
+				return true;
+			}
+			spin_unlock(&tcon->open_file_lock);
+			spin_unlock(&cifs_tcp_ses_lock);
+			cifs_dbg(FYI, "No matching file for oplock break\n");
+			return true;
+		}
+	}
+	spin_unlock(&cifs_tcp_ses_lock);
+	cifs_dbg(FYI, "Can not process oplock break for non-existent connection\n");
+	return true;
+}
diff --git a/fs/smb/client/smb1proto.h b/fs/smb/client/smb1proto.h
index de021e17dc4b..259cfafacfab 100644
--- a/fs/smb/client/smb1proto.h
+++ b/fs/smb/client/smb1proto.h
@@ -220,6 +220,13 @@ int CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 void cifs_dump_detail(void *buf, size_t buf_len,
 		      struct TCP_Server_Info *server);
 
+/*
+ * smb1misc.c
+ */
+unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
+			     const struct cifs_tcon *treeCon, int word_count);
+bool is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv);
+
 /*
  * smb1ops.c
  */


