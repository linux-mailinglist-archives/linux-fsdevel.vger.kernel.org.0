Return-Path: <linux-fsdevel+bounces-5880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B681138D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C031F21FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E72E85E;
	Wed, 13 Dec 2023 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed+SP3ad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D662912E
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxknlvC/si6svtnBVShJ/D8TPx6S78MICdfSTIeGIDk=;
	b=Ed+SP3adio7qlHsCRyCTs1bpN5v1U8MBbCThjyIw0oAf8BiX0iZA0aNycvZZAHMCm0ybJY
	LPX8VdNG8A4IMSWBizKr4le1FpKt348fiiDCRiU+YygZgoO+OSCFFGC8kAtbt86bFBrX/C
	DHMiW8TEw7TomOvGONEcdXOCvuytIys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-dLyoTIeVP4iDT8venuAoPw-1; Wed, 13 Dec 2023 08:50:47 -0500
X-MC-Unique: dLyoTIeVP4iDT8venuAoPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B21DC837193;
	Wed, 13 Dec 2023 13:50:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6D933C25;
	Wed, 13 Dec 2023 13:50:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/40] afs: Mark address lists with configured priorities
Date: Wed, 13 Dec 2023 13:49:47 +0000
Message-ID: <20231213135003.367397-26-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Add a field to each address in an address list (afs_addr_list struct) that
records the current priority for that address according to the address
preference table.  We don't want to do this every time we use an address
list, so the version number of the address preference table is recorded in
the address list too and we only re-mark the list when we see the version
change.

These numbers are then displayed through /proc/net/afs/servers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_prefs.c | 82 +++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/internal.h   |  4 +++
 fs/afs/proc.c       |  9 ++---
 3 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/fs/afs/addr_prefs.c b/fs/afs/addr_prefs.c
index c6dcff4f8aa1..a189ff8a5034 100644
--- a/fs/afs/addr_prefs.c
+++ b/fs/afs/addr_prefs.c
@@ -447,3 +447,85 @@ int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size)
 	ret = -EINVAL;
 	goto done;
 }
+
+/*
+ * Mark the priorities on an address list if the address preferences table has
+ * changed.  The caller must hold the RCU read lock.
+ */
+void afs_get_address_preferences_rcu(struct afs_net *net, struct afs_addr_list *alist)
+{
+	const struct afs_addr_preference_list *preflist =
+		rcu_dereference(net->address_prefs);
+	const struct sockaddr_in6 *sin6;
+	const struct sockaddr_in *sin;
+	const struct sockaddr *sa;
+	struct afs_addr_preference test;
+	enum cmp_ret cmp;
+	int i, j;
+
+	if (!preflist || !preflist->nr || !alist->nr_addrs ||
+	    smp_load_acquire(&alist->addr_pref_version) == preflist->version)
+		return;
+
+	test.family = AF_INET;
+	test.subnet_mask = 32;
+	test.prio = 0;
+	for (i = 0; i < alist->nr_ipv4; i++) {
+		sa = rxrpc_kernel_remote_addr(alist->addrs[i].peer);
+		sin = (const struct sockaddr_in *)sa;
+		test.ipv4_addr = sin->sin_addr;
+		for (j = 0; j < preflist->ipv6_off; j++) {
+			cmp = afs_cmp_address_pref(&test, &preflist->prefs[j]);
+			switch (cmp) {
+			case CONTINUE_SEARCH:
+				continue;
+			case INSERT_HERE:
+				break;
+			case EXACT_MATCH:
+			case SUBNET_MATCH:
+				WRITE_ONCE(alist->addrs[i].prio, preflist->prefs[j].prio);
+				break;
+			}
+		}
+	}
+
+	test.family = AF_INET6;
+	test.subnet_mask = 128;
+	test.prio = 0;
+	for (; i < alist->nr_addrs; i++) {
+		sa = rxrpc_kernel_remote_addr(alist->addrs[i].peer);
+		sin6 = (const struct sockaddr_in6 *)sa;
+		test.ipv6_addr = sin6->sin6_addr;
+		for (j = preflist->ipv6_off; j < preflist->nr; j++) {
+			cmp = afs_cmp_address_pref(&test, &preflist->prefs[j]);
+			switch (cmp) {
+			case CONTINUE_SEARCH:
+				continue;
+			case INSERT_HERE:
+				break;
+			case EXACT_MATCH:
+			case SUBNET_MATCH:
+				WRITE_ONCE(alist->addrs[i].prio, preflist->prefs[j].prio);
+				break;
+			}
+		}
+	}
+
+	smp_store_release(&alist->addr_pref_version, preflist->version);
+}
+
+/*
+ * Mark the priorities on an address list if the address preferences table has
+ * changed.  Avoid taking the RCU read lock if we can.
+ */
+void afs_get_address_preferences(struct afs_net *net, struct afs_addr_list *alist)
+{
+	if (!net->address_prefs ||
+	    /* Load version before prefs */
+	    smp_load_acquire(&net->address_pref_version) == alist->addr_pref_version)
+		return;
+
+	rcu_read_lock();
+	afs_get_address_preferences_rcu(net, alist);
+	rcu_read_unlock();
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 4445c734cdcd..9a1e151e77e7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -97,6 +97,7 @@ struct afs_addr_preference_list {
 struct afs_address {
 	struct rxrpc_peer	*peer;
 	short			last_error;	/* Last error from this address */
+	u16			prio;		/* Address priority */
 };
 
 /*
@@ -107,6 +108,7 @@ struct afs_addr_list {
 	refcount_t		usage;
 	u32			version;	/* Version */
 	unsigned int		debug_id;
+	unsigned int		addr_pref_version; /* Version of address preference list */
 	unsigned char		max_addrs;
 	unsigned char		nr_addrs;
 	unsigned char		preferred;	/* Preferred address */
@@ -1010,6 +1012,8 @@ extern int afs_merge_fs_addr6(struct afs_net *net, struct afs_addr_list *addr,
  * addr_prefs.c
  */
 int afs_proc_addr_prefs_write(struct file *file, char *buf, size_t size);
+void afs_get_address_preferences_rcu(struct afs_net *net, struct afs_addr_list *alist);
+void afs_get_address_preferences(struct afs_net *net, struct afs_addr_list *alist);
 
 /*
  * callback.c
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 2e63c99a4f1e..944eb51e75a1 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -447,17 +447,18 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
 		   (int)(jiffies - server->probed_at) / HZ,
 		   atomic_read(&server->probe_outstanding));
 	failed = alist->probe_failed;
-	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx\n",
-		   alist->version, alist->responded, alist->probe_failed);
+	seq_printf(m, "  - ALIST v=%u rsp=%lx f=%lx ap=%u\n",
+		   alist->version, alist->responded, alist->probe_failed,
+		   alist->addr_pref_version);
 	for (i = 0; i < alist->nr_addrs; i++) {
 		const struct afs_address *addr = &alist->addrs[i];
 
-		seq_printf(m, "    [%x] %pISpc%s rtt=%d err=%d\n",
+		seq_printf(m, "    [%x] %pISpc%s rtt=%d err=%d p=%u\n",
 			   i, rxrpc_kernel_remote_addr(addr->peer),
 			   alist->preferred == i ? "*" :
 			   test_bit(i, &failed) ? "!" : "",
 			   rxrpc_kernel_get_srtt(addr->peer),
-			   addr->last_error);
+			   addr->last_error, addr->prio);
 	}
 	return 0;
 }


