Return-Path: <linux-fsdevel+bounces-5859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FAC811361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD8B28251F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06742E40C;
	Wed, 13 Dec 2023 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ro8tuo5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2EB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExN3aXWl+sIeMUeAn84eZ7A4PvMHoy42dD/Wo7lzJak=;
	b=Ro8tuo5Y6TxBFIVsVjZPSsKqPyleOoColEjqudPxKL02eiSgTT6FvW8FH2VtQr/9D8mjZs
	QAx067pSoAJWgPzkwsJtwMum7FIxqR4DjpFVkg+EuTAilRpUA4E4y2mb+q6qRWIf4+dF8T
	JgWRZ/+fnvxOWRYEAF96EX55491FFFE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-lg-8yNpGM3GXbqS7N0i_IQ-1; Wed, 13 Dec 2023 08:50:10 -0500
X-MC-Unique: lg-8yNpGM3GXbqS7N0i_IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13EAE83718B;
	Wed, 13 Dec 2023 13:50:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2723840C6EBA;
	Wed, 13 Dec 2023 13:50:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2 02/40] afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
Date: Wed, 13 Dec 2023 13:49:24 +0000
Message-ID: <20231213135003.367397-3-dhowells@redhat.com>
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

From: Oleg Nesterov <oleg@redhat.com>

David Howells says:

 (5) afs_find_server().

     There could be a lot of servers in the list and each server can have
     multiple addresses, so I think this would be better with an exclusive
     second pass.

     The server list isn't likely to change all that often, but when it does
     change, there's a good chance several servers are going to be
     added/removed one after the other.  Further, this is only going to be
     used for incoming cache management/callback requests from the server,
     which hopefully aren't going to happen too often - but it is remotely
     drivable.

 (6) afs_find_server_by_uuid().

     Similarly to (5), there could be a lot of servers to search through, but
     they are in a tree not a flat list, so it should be faster to process.
     Again, it's not likely to change that often and, again, when it does
     change it's likely to involve multiple changes.  This can be driven
     remotely by an incoming cache management request but is mostly going to
     be driven by setting up or reconfiguring a volume's server list -
     something that also isn't likely to happen often.

Make the "seq" counter odd on the 2nd pass, otherwise read_seqbegin_or_lock()
never takes the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20231130115614.GA21581@redhat.com/
---
 fs/afs/server.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index b5237206eac3..0bd2f5ba6900 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -27,7 +27,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 1, diff;
 
 	rcu_read_lock();
 
@@ -35,6 +35,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_unuse_server_notime(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		if (srx->transport.family == AF_INET6) {
@@ -90,7 +91,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq = 1;
 
 	_enter("%pU", uuid);
 
@@ -102,7 +103,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		if (server)
 			afs_unuse_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
-
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
 
 		p = net->fs_servers.rb_node;


