Return-Path: <linux-fsdevel+bounces-2550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DC7E6D97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9731B212E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B820B07;
	Thu,  9 Nov 2023 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eC2txvys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86711208B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:40:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1843435B0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699544436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0LIe3EKWZUtaP/jgL9SLQB7mffREMgGCD+56/5jcaw=;
	b=eC2txvysHagx5Rk3MHkMwqyivP4UqIxqH4HfM0uW8X23HDsK5ixOFNPaKD6KEvtCQii5tg
	ZkRzfaE3skQQf7UrOCBfZnZFHnVnDd6d5w3EvsMfF9z4hpKIRcIrkgmgtbYqDRL4gJMwlu
	a1Xa6lt0resdHRN/M2MKEstS6Y0Z138=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-LmiM7grOMT2RP_6UO_A-jg-1; Thu, 09 Nov 2023 10:40:34 -0500
X-MC-Unique: LmiM7grOMT2RP_6UO_A-jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D240101B058;
	Thu,  9 Nov 2023 15:40:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 44D33366;
	Thu,  9 Nov 2023 15:40:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/41] afs: Rename addr_list::failed to probe_failed
Date: Thu,  9 Nov 2023 15:39:35 +0000
Message-ID: <20231109154004.3317227-13-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Rename the failed member of struct addr_list to probe_failed as it's
specifically related to probe failures.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c | 2 +-
 fs/afs/fs_probe.c  | 6 +++---
 fs/afs/internal.h  | 2 +-
 fs/afs/proc.c      | 2 +-
 fs/afs/rotate.c    | 2 +-
 fs/afs/vl_probe.c  | 4 ++--
 fs/afs/vl_rotate.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 519821f5aedc..b76abf500713 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -367,7 +367,7 @@ bool afs_iterate_addresses(struct afs_addr_cursor *ac)
 		return false;
 
 	set = ac->alist->responded;
-	failed = ac->alist->failed;
+	failed = ac->alist->probe_failed;
 	_enter("%lx-%lx-%lx,%d", set, failed, ac->tried, ac->index);
 
 	ac->nr_iterations++;
diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 58d28b82571e..fbb91ad775b9 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -88,7 +88,7 @@ static void afs_fs_probe_not_done(struct afs_net *net,
 	if (server->probe.error == 0)
 		server->probe.error = -ENOMEM;
 
-	set_bit(index, &alist->failed);
+	set_bit(index, &alist->probe_failed);
 
 	spin_unlock(&server->probe_lock);
 	return afs_done_one_fs_probe(net, server);
@@ -138,7 +138,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	case -ETIME:
 	default:
 		clear_bit(index, &alist->responded);
-		set_bit(index, &alist->failed);
+		set_bit(index, &alist->probe_failed);
 		if (!server->probe.responded &&
 		    (server->probe.error == 0 ||
 		     server->probe.error == -ETIMEDOUT ||
@@ -149,7 +149,7 @@ void afs_fileserver_probe_result(struct afs_call *call)
 	}
 
 responded:
-	clear_bit(index, &alist->failed);
+	clear_bit(index, &alist->probe_failed);
 
 	if (call->service_id == YFS_FS_SERVICE) {
 		server->probe.is_yfs = true;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index caf89edc0644..9182bd410bbd 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -90,7 +90,7 @@ struct afs_addr_list {
 	unsigned char		nr_ipv4;	/* Number of IPv4 addresses */
 	enum dns_record_source	source:8;
 	enum dns_lookup_status	status:8;
-	unsigned long		failed;		/* Mask of addrs that failed locally/ICMP */
+	unsigned long		probe_failed;	/* Mask of addrs that failed locally/ICMP */
 	unsigned long		responded;	/* Mask of addrs that responded */
 	struct afs_address	addrs[] __counted_by(max_addrs);
 #define AFS_MAX_ADDRESSES ((unsigned int)(sizeof(unsigned long) * 8))
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 8a65a06908d2..16d93fa6396f 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -396,7 +396,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   (int)(jiffies - server->probed_at) / HZ,
 		   atomic_read(&server->probe_outstanding));
 	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx\n",
-		   alist->version, alist->responded, alist->failed);
+		   alist->version, alist->responded, alist->probe_failed);
 	for (i = 0; i < alist->nr_addrs; i++)
 		seq_printf(m, "    [%x] %pISpc%s rtt=%d\n",
 			   i, rxrpc_kernel_remote_addr(alist->addrs[i].peer),
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 689acb0ad64b..0f59f2a81f23 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -582,7 +582,7 @@ void afs_dump_edestaddrreq(const struct afs_operation *op)
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
 					  a->preferred);
 				pr_notice("FC:  - R=%lx F=%lx\n",
-					  a->responded, a->failed);
+					  a->responded, a->probe_failed);
 				if (a == op->ac.alist)
 					pr_notice("FC:  - current\n");
 			}
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index 9551aef07cee..44bff3a2a5ac 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -90,7 +90,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 	case -ETIME:
 	default:
 		clear_bit(index, &alist->responded);
-		set_bit(index, &alist->failed);
+		set_bit(index, &alist->probe_failed);
 		if (!(server->probe.flags & AFS_VLSERVER_PROBE_RESPONDED) &&
 		    (server->probe.error == 0 ||
 		     server->probe.error == -ETIMEDOUT ||
@@ -102,7 +102,7 @@ void afs_vlserver_probe_result(struct afs_call *call)
 
 responded:
 	set_bit(index, &alist->responded);
-	clear_bit(index, &alist->failed);
+	clear_bit(index, &alist->probe_failed);
 
 	if (call->service_id == YFS_VL_SERVICE) {
 		server->probe.flags |= AFS_VLSERVER_PROBE_IS_YFS;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 6e29272ffa8e..af5c6cd1ed44 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -312,7 +312,7 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 					  a->nr_ipv4, a->nr_addrs, a->max_addrs,
 					  a->preferred);
 				pr_notice("VC:  - R=%lx F=%lx\n",
-					  a->responded, a->failed);
+					  a->responded, a->probe_failed);
 				if (a == vc->ac.alist)
 					pr_notice("VC:  - current\n");
 			}


