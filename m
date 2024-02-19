Return-Path: <linux-fsdevel+bounces-12024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99585A629
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617F2B21F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C40374FF;
	Mon, 19 Feb 2024 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1tz8Okq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AB1E864
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353558; cv=none; b=RvD6Sa+A7gLcOAKcKqutaWsZ71ZbDSY9hTGjVx8KvQwf8gZ/hL39dfTO1/9Ha3grzQgDINn+o/8O4g1e3s8IxR5Fkj23av6Tyd1RbiLuSdnBVROsase6WYqjZtIeXzGf5rIoTHqX1uhVrpndigiIY6OWCKpkUC7B+wAWNF8bpBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353558; c=relaxed/simple;
	bh=FQW538CkhbCyOjNCq4Mt7YkUrwTilVq9pXAfhbPQhsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZjjcZQUUNiB1Bnms30S9lun3dGm5cNKvx+FjO9313yrWWo2j09Nw5yZGMTtCYlAMOIzn1lm/q1/ZrEbx5yAsvTW0slybOBLEr3zgQ/cVQe5omeYWbVpvjFa3215JHkg1hfhancO2rVgomZpppL3sYAl2pMKKprjsXX5SqA6wuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1tz8Okq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708353554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61Y1ryM8fe/JjxMt1H4crmRFgXy4y3uGTZZvyqUo4+c=;
	b=L1tz8OkqBz7zZ9TD3FLlEfZMGx96UE+M7hY/3GjP+RKaMs8Z4Nvnx9qRRJ9O2o2SLoHhEa
	16I3JlK5Eexm23uYLyUb1JOxcbtyngf8r4ttObOnDqZG3wewlIrnNMtQ2VQ/kx3b6sBOXr
	8D5BPOeOMAhkSqNlznt33QBczAKoJ7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-4PV-VDJjOEmvnI60OKUorA-1; Mon,
 19 Feb 2024 09:39:11 -0500
X-MC-Unique: 4PV-VDJjOEmvnI60OKUorA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09E933C0ED57;
	Mon, 19 Feb 2024 14:39:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 030D71C060B2;
	Mon, 19 Feb 2024 14:39:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Daniil Dulov <d.dulov@aladdin.ru>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] afs: Fix ignored callbacks over ipv4
Date: Mon, 19 Feb 2024 14:39:02 +0000
Message-ID: <20240219143906.138346-2-dhowells@redhat.com>
In-Reply-To: <20240219143906.138346-1-dhowells@redhat.com>
References: <20240219143906.138346-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

From: Marc Dionne <marc.dionne@auristor.com>

When searching for a matching peer, all addresses need to be searched,
not just the ipv6 ones in the fs_addresses6 list.

Given that the lists no longer contain addresses, there is little
reason to splitting things between separate lists, so unify them
into a single list.

When processing an incoming callback from an ipv4 address, this would
lead to a failure to set call->server, resulting in the callback being
ignored and the client seeing stale contents.

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008035.html
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008037.html # v1
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008066.html # v2
---
 fs/afs/internal.h |  6 ++----
 fs/afs/main.c     |  3 +--
 fs/afs/server.c   | 14 +++++---------
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9c03fcf7ffaa..6ce5a612937c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -321,8 +321,7 @@ struct afs_net {
 	struct list_head	fs_probe_slow;	/* List of afs_server to probe at 5m intervals */
 	struct hlist_head	fs_proc;	/* procfs servers list */
 
-	struct hlist_head	fs_addresses4;	/* afs_server (by lowest IPv4 addr) */
-	struct hlist_head	fs_addresses6;	/* afs_server (by lowest IPv6 addr) */
+	struct hlist_head	fs_addresses;	/* afs_server (by lowest IPv6 addr) */
 	seqlock_t		fs_addr_lock;	/* For fs_addresses[46] */
 
 	struct work_struct	fs_manager;
@@ -561,8 +560,7 @@ struct afs_server {
 	struct afs_server __rcu	*uuid_next;	/* Next server with same UUID */
 	struct afs_server	*uuid_prev;	/* Previous server with same UUID */
 	struct list_head	probe_link;	/* Link in net->fs_probe_list */
-	struct hlist_node	addr4_link;	/* Link in net->fs_addresses4 */
-	struct hlist_node	addr6_link;	/* Link in net->fs_addresses6 */
+	struct hlist_node	addr_link;	/* Link in net->fs_addresses6 */
 	struct hlist_node	proc_link;	/* Link in net->fs_proc */
 	struct list_head	volumes;	/* RCU list of afs_server_entry objects */
 	struct afs_server	*gc_next;	/* Next server in manager's list */
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 1b3bd21c168a..a14f6013e316 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -90,8 +90,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	INIT_LIST_HEAD(&net->fs_probe_slow);
 	INIT_HLIST_HEAD(&net->fs_proc);
 
-	INIT_HLIST_HEAD(&net->fs_addresses4);
-	INIT_HLIST_HEAD(&net->fs_addresses6);
+	INIT_HLIST_HEAD(&net->fs_addresses);
 	seqlock_init(&net->fs_addr_lock);
 
 	INIT_WORK(&net->fs_manager, afs_manage_servers);
diff --git a/fs/afs/server.c b/fs/afs/server.c
index e169121f603e..038f9d0ae3af 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -38,7 +38,7 @@ struct afs_server *afs_find_server(struct afs_net *net, const struct rxrpc_peer
 		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
-		hlist_for_each_entry_rcu(server, &net->fs_addresses6, addr6_link) {
+		hlist_for_each_entry_rcu(server, &net->fs_addresses, addr_link) {
 			estate = rcu_dereference(server->endpoint_state);
 			alist = estate->addresses;
 			for (i = 0; i < alist->nr_addrs; i++)
@@ -177,10 +177,8 @@ static struct afs_server *afs_install_server(struct afs_cell *cell,
 	 * bit, but anything we might want to do gets messy and memory
 	 * intensive.
 	 */
-	if (alist->nr_ipv4 > 0)
-		hlist_add_head_rcu(&server->addr4_link, &net->fs_addresses4);
-	if (alist->nr_addrs > alist->nr_ipv4)
-		hlist_add_head_rcu(&server->addr6_link, &net->fs_addresses6);
+	if (alist->nr_addrs > 0)
+		hlist_add_head_rcu(&server->addr_link, &net->fs_addresses);
 
 	write_sequnlock(&net->fs_addr_lock);
 
@@ -511,10 +509,8 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
 
 			list_del(&server->probe_link);
 			hlist_del_rcu(&server->proc_link);
-			if (!hlist_unhashed(&server->addr4_link))
-				hlist_del_rcu(&server->addr4_link);
-			if (!hlist_unhashed(&server->addr6_link))
-				hlist_del_rcu(&server->addr6_link);
+			if (!hlist_unhashed(&server->addr_link))
+				hlist_del_rcu(&server->addr_link);
 		}
 		write_sequnlock(&net->fs_lock);
 


