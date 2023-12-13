Return-Path: <linux-fsdevel+bounces-5877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E2811387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963481F21EE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7742E845;
	Wed, 13 Dec 2023 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXLsOnZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC310E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmTCmlX4lZl7P2Vj72SHk6r4dvh7rcubOpN6X02yzKI=;
	b=KXLsOnZ9Ga+qqFodIQ4n/OdY6fYdjSjqnYiTWs/J7dkfT0Ei5T7Qv/PFkASNn5a8v8qXKS
	uapWJXmLK5wBLKYX1j29yMC/E5f4GzGXYQzMDCYB8XhLuCuLdq7hamKPOGkRCWrrq3nPHw
	6dIeTviwUqzXGNcQwXX6sehxIPP47uI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-rOMX1xUVPMmZgouvnKpkTQ-1; Wed, 13 Dec 2023 08:50:43 -0500
X-MC-Unique: rOMX1xUVPMmZgouvnKpkTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 213B8185A782;
	Wed, 13 Dec 2023 13:50:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5667E40C6EB9;
	Wed, 13 Dec 2023 13:50:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/40] afs: Add some more info to /proc/net/afs/servers
Date: Wed, 13 Dec 2023 13:49:44 +0000
Message-ID: <20231213135003.367397-23-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

In /proc/net/afs/servers, show the cell name and the last error for each
address in the server's list.

cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c |  2 --
 fs/afs/fs_probe.c     |  2 ++
 fs/afs/proc.c         | 24 ++++++++++++++++--------
 fs/afs/rotate.c       |  2 ++
 fs/afs/vl_rotate.c    |  2 ++
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 00e22259be36..e760e11d5bcb 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -196,8 +196,6 @@ void afs_wait_for_operation(struct afs_operation *op)
 			op->call_abort_code = op->call->abort_code;
 			op->call_error = op->call->error;
 			op->call_responded = op->call->responded;
-			WRITE_ONCE(op->alist->addrs[op->addr_index].last_error,
-				   op->call_error);
 			afs_put_call(op->call);
 		}
 	}
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index aef16ac3f577..8008d3ecabab 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -107,6 +107,8 @@ void afs_fileserver_probe_result(struct afs_call *call)
 
 	_enter("%pU,%u", &server->uuid, index);
 
+	WRITE_ONCE(addr->last_error, ret);
+
 	spin_lock(&server->probe_lock);
 
 	switch (ret) {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 16d93fa6396f..0b43bb9b0260 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -377,31 +377,39 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 {
 	struct afs_server *server;
 	struct afs_addr_list *alist;
+	unsigned long failed;
 	int i;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(m, "UUID                                 REF ACT\n");
+		seq_puts(m, "UUID                                 REF ACT CELL\n");
 		return 0;
 	}
 
 	server = list_entry(v, struct afs_server, proc_link);
 	alist = rcu_dereference(server->addresses);
-	seq_printf(m, "%pU %3d %3d\n",
+	seq_printf(m, "%pU %3d %3d %s\n",
 		   &server->uuid,
 		   refcount_read(&server->ref),
-		   atomic_read(&server->active));
+		   atomic_read(&server->active),
+		   server->cell->name);
 	seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
 		   server->flags, server->rtt, server->cb_s_break);
 	seq_printf(m, "  - probe: last=%d out=%d\n",
 		   (int)(jiffies - server->probed_at) / HZ,
 		   atomic_read(&server->probe_outstanding));
+	failed = alist->probe_failed;
 	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx\n",
 		   alist->version, alist->responded, alist->probe_failed);
-	for (i = 0; i < alist->nr_addrs; i++)
-		seq_printf(m, "    [%x] %pISpc%s rtt=%d\n",
-			   i, rxrpc_kernel_remote_addr(alist->addrs[i].peer),
-			   alist->preferred == i ? "*" : "",
-			   rxrpc_kernel_get_srtt(alist->addrs[i].peer));
+	for (i = 0; i < alist->nr_addrs; i++) {
+		const struct afs_address *addr = &alist->addrs[i];
+
+		seq_printf(m, "    [%x] %pISpc%s rtt=%d err=%d\n",
+			   i, rxrpc_kernel_remote_addr(addr->peer),
+			   alist->preferred == i ? "*" :
+			   test_bit(i, &failed) ? "!" : "",
+			   rxrpc_kernel_get_srtt(addr->peer),
+			   addr->last_error);
+	}
 	return 0;
 }
 
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index a6bda8f44c0f..5423ac80f4e0 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -133,6 +133,8 @@ bool afs_select_fileserver(struct afs_operation *op)
 	if (op->nr_iterations == 0)
 		goto start;
 
+	WRITE_ONCE(alist->addrs[op->addr_index].last_error, error);
+
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (op->call_error) {
 	case 0:
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 91168528179c..d8f79f6ada3d 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -114,6 +114,8 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
 	if (vc->nr_iterations == 0)
 		goto start;
 
+	WRITE_ONCE(alist->addrs[vc->addr_index].last_error, error);
+
 	/* Evaluate the result of the previous operation, if there was one. */
 	switch (error) {
 	default:


