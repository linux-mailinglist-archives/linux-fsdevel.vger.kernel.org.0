Return-Path: <linux-fsdevel+bounces-52950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C12DEAE8AB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379951BC6CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D602EF9DF;
	Wed, 25 Jun 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkNPF1ND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E62EF9C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869821; cv=none; b=KYbb6b1ddzpKIcQ1qNS9nJfBE7hwLjHVcElVUsah5knquT+6jWAy3tri3i7AXIIS7it2SBAV4nmGCbXhuO+bukmH7p+eeRTZiROwQBIcFz9ZO/VUAfcGCKUdkDTpOF7Qz08yPRFRE4hTdDNb/zdcga6sXPDPdBKSnyVtgjHqtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869821; c=relaxed/simple;
	bh=JVhZg1PMZk5m5hcAGMSKkIGHxadGEXg7VEEy+Jz7GCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+ruaAPB3LU+ptq1ktsNWZSIIc+LkV3J87UbwL2yzuNnKX7HLwdaHHeNN7Qa8NWSWb9sKH68wMYQHYYhR9PS5cEHQQESibfro6aMWV7NeRJoxB9crLUdBFwNBSWzrkrrryS4gDfZ+FkxWPtUeo49vSjyVm8wxiX6nPlDuEMV2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkNPF1ND; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750869819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyPG80PW4IJ/xS4M21DeICw+sKXCpLWOr1kJSqwjliw=;
	b=bkNPF1NDHFsKhfGVYlGeSskQdo/oCkiCmwdSauEMP1X0LxamxbzrU4efjY1NCVp4GkcCGU
	7Dnze+PGJ1AqjMs5bZoIEnKGMpOk/xc+9xkmhioUJq181B9fymiEiYs4v5vTt7TaOl2dq5
	yZRak6omvf9+xByYS9Z4JHeEENeGmSU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-3vK0jWK7P6yEyM03HIOmvA-1; Wed,
 25 Jun 2025 12:43:35 -0400
X-MC-Unique: 3vK0jWK7P6yEyM03HIOmvA-1
X-Mimecast-MFC-AGG-ID: 3vK0jWK7P6yEyM03HIOmvA_1750869813
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADFEC180034E;
	Wed, 25 Jun 2025 16:43:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F44319560A3;
	Wed, 25 Jun 2025 16:43:30 +0000 (UTC)
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
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH v2 14/16] smb: client: fix potential deadlock when reconnecting channels
Date: Wed, 25 Jun 2025 17:42:09 +0100
Message-ID: <20250625164213.1408754-15-dhowells@redhat.com>
In-Reply-To: <20250625164213.1408754-1-dhowells@redhat.com>
References: <20250625164213.1408754-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Paulo Alcantara <pc@manguebit.org>

Fix cifs_signal_cifsd_for_reconnect() to take the correct lock order
and prevent the following deadlock from happening

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc3-build2+ #1301 Tainted: G S      W
------------------------------------------------------
cifsd/6055 is trying to acquire lock:
ffff88810ad56038 (&tcp_ses->srv_lock){+.+.}-{3:3}, at: cifs_signal_cifsd_for_reconnect+0x134/0x200

but task is already holding lock:
ffff888119c64330 (&ret_buf->chan_lock){+.+.}-{3:3}, at: cifs_signal_cifsd_for_reconnect+0xcf/0x200

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (&ret_buf->chan_lock){+.+.}-{3:3}:
       validate_chain+0x1cf/0x270
       __lock_acquire+0x60e/0x780
       lock_acquire.part.0+0xb4/0x1f0
       _raw_spin_lock+0x2f/0x40
       cifs_setup_session+0x81/0x4b0
       cifs_get_smb_ses+0x771/0x900
       cifs_mount_get_session+0x7e/0x170
       cifs_mount+0x92/0x2d0
       cifs_smb3_do_mount+0x161/0x460
       smb3_get_tree+0x55/0x90
       vfs_get_tree+0x46/0x180
       do_new_mount+0x1b0/0x2e0
       path_mount+0x6ee/0x740
       do_mount+0x98/0xe0
       __do_sys_mount+0x148/0x180
       do_syscall_64+0xa4/0x260
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #1 (&ret_buf->ses_lock){+.+.}-{3:3}:
       validate_chain+0x1cf/0x270
       __lock_acquire+0x60e/0x780
       lock_acquire.part.0+0xb4/0x1f0
       _raw_spin_lock+0x2f/0x40
       cifs_match_super+0x101/0x320
       sget+0xab/0x270
       cifs_smb3_do_mount+0x1e0/0x460
       smb3_get_tree+0x55/0x90
       vfs_get_tree+0x46/0x180
       do_new_mount+0x1b0/0x2e0
       path_mount+0x6ee/0x740
       do_mount+0x98/0xe0
       __do_sys_mount+0x148/0x180
       do_syscall_64+0xa4/0x260
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #0 (&tcp_ses->srv_lock){+.+.}-{3:3}:
       check_noncircular+0x95/0xc0
       check_prev_add+0x115/0x2f0
       validate_chain+0x1cf/0x270
       __lock_acquire+0x60e/0x780
       lock_acquire.part.0+0xb4/0x1f0
       _raw_spin_lock+0x2f/0x40
       cifs_signal_cifsd_for_reconnect+0x134/0x200
       __cifs_reconnect+0x8f/0x500
       cifs_handle_standard+0x112/0x280
       cifs_demultiplex_thread+0x64d/0xbc0
       kthread+0x2f7/0x310
       ret_from_fork+0x2a/0x230
       ret_from_fork_asm+0x1a/0x30

other info that might help us debug this:

Chain exists of:
  &tcp_ses->srv_lock --> &ret_buf->ses_lock --> &ret_buf->chan_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ret_buf->chan_lock);
                               lock(&ret_buf->ses_lock);
                               lock(&ret_buf->chan_lock);
  lock(&tcp_ses->srv_lock);

 *** DEADLOCK ***

3 locks held by cifsd/6055:
 #0: ffffffff857de398 (&cifs_tcp_ses_lock){+.+.}-{3:3}, at: cifs_signal_cifsd_for_reconnect+0x7b/0x200
 #1: ffff888119c64060 (&ret_buf->ses_lock){+.+.}-{3:3}, at: cifs_signal_cifsd_for_reconnect+0x9c/0x200
 #2: ffff888119c64330 (&ret_buf->chan_lock){+.+.}-{3:3}, at: cifs_signal_cifsd_for_reconnect+0xcf/0x200

Cc: linux-cifs@vger.kernel.org
Reported-by: David Howells <dhowells@redhat.com>
Fixes: d7d7a66aacd6 ("cifs: avoid use of global locks for high contention data")
Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/connect.c  | 53 +++++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index da963294a573..fdd95e5100cd 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -709,6 +709,7 @@ inc_rfc1001_len(void *buf, int count)
 struct TCP_Server_Info {
 	struct list_head tcp_ses_list;
 	struct list_head smb_ses_list;
+	struct list_head rlist; /* reconnect list */
 	spinlock_t srv_lock;  /* protect anything here that is not protected */
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c48869c29e15..864de24e23d5 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -124,6 +124,13 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 			   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 }
 
+#define set_need_reco(server) \
+do { \
+	guard(spinlock)(&server->srv_lock); \
+	if (server->tcpStatus != CifsExiting) \
+		server->tcpStatus = CifsNeedReconnect; \
+} while (0)
+
 /*
  * Update the tcpStatus for the server.
  * This is used to signal the cifsd thread to call cifs_reconnect
@@ -137,39 +144,41 @@ void
 cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 				bool all_channels)
 {
-	struct TCP_Server_Info *pserver;
+	struct TCP_Server_Info *nserver;
 	struct cifs_ses *ses;
+	LIST_HEAD(reco);
 	int i;
 
-	/* If server is a channel, select the primary channel */
-	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
-
 	/* if we need to signal just this channel */
 	if (!all_channels) {
-		spin_lock(&server->srv_lock);
-		if (server->tcpStatus != CifsExiting)
-			server->tcpStatus = CifsNeedReconnect;
-		spin_unlock(&server->srv_lock);
+		set_need_reco(server);
 		return;
 	}
 
-	spin_lock(&cifs_tcp_ses_lock);
-	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
-		if (cifs_ses_exiting(ses))
-			continue;
-		spin_lock(&ses->chan_lock);
-		for (i = 0; i < ses->chan_count; i++) {
-			if (!ses->chans[i].server)
+	if (SERVER_IS_CHAN(server))
+		server = server->primary_server;
+	scoped_guard(spinlock, &cifs_tcp_ses_lock) {
+		set_need_reco(server);
+		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			guard(spinlock)(&ses->ses_lock);
+			if (ses->ses_status == SES_EXITING)
 				continue;
-
-			spin_lock(&ses->chans[i].server->srv_lock);
-			if (ses->chans[i].server->tcpStatus != CifsExiting)
-				ses->chans[i].server->tcpStatus = CifsNeedReconnect;
-			spin_unlock(&ses->chans[i].server->srv_lock);
+			guard(spinlock)(&ses->chan_lock);
+			for (i = 1; i < ses->chan_count; i++) {
+				nserver = ses->chans[i].server;
+				if (!nserver)
+					continue;
+				nserver->srv_count++;
+				list_add(&nserver->rlist, &reco);
+			}
 		}
-		spin_unlock(&ses->chan_lock);
 	}
-	spin_unlock(&cifs_tcp_ses_lock);
+
+	list_for_each_entry_safe(server, nserver, &reco, rlist) {
+		list_del_init(&server->rlist);
+		set_need_reco(server);
+		cifs_put_tcp_session(server, 0);
+	}
 }
 
 /*


