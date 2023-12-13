Return-Path: <linux-fsdevel+bounces-5891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096118113A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5801F2259D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4182E635;
	Wed, 13 Dec 2023 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLMh0n0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B727123
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trkSrGHpwGl5JYVXDr68Z3gnjh2gsPsj3d8uQgvQ/lQ=;
	b=SLMh0n0kfxkoWBB7u0XekSfZXa67+MGwfOfyfOzsJ7bjnRQKwzwrmW2Ht2I7esoZxpz7Rf
	zv3Te2EP+xS7/JHuOeRgMdd/5HjGH3JggHn8n6s5mTRky1ZcdDfuOlqZed00wGkwfoL6Pi
	gOxP18IcZFZRGnPhVfOExx0+RM2vp0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-nfKa3B1kMgqg5m6UPIpeCA-1; Wed, 13 Dec 2023 08:51:02 -0500
X-MC-Unique: nfKa3B1kMgqg5m6UPIpeCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0259A185A784;
	Wed, 13 Dec 2023 13:51:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 309181121306;
	Wed, 13 Dec 2023 13:51:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 35/40] afs: Don't leave DONTUSE/NEWREPSITE servers out of server list
Date: Wed, 13 Dec 2023 13:49:57 +0000
Message-ID: <20231213135003.367397-36-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Don't leave servers that are marked VLSF_DONTUSE or VLSF_NEWREPSITE out of
the server list for a volume; rather, mark DONTUSE ones excluded and mark
either NEWREPSITE excluded if the number of updated servers is <50% of the
usable servers or mark !NEWREPSITE excluded otherwise.

Mark the server list as a whole with a 3-state flag to indicate whether we
think the RW volume is being replicated to the RO volume, and, if so,
whether we should switch to using updated replication sites
(VLSF_NEWREPSITE) or stick with the old for now.

This processing is pushed up from the VLDB RPC reply parser to the code
that generates the server list from that information.

Doing this allows the old list to be kept with just the exclusion flags
replaced and to keep the server records pinned and maintained.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/internal.h    | 10 ++++++++
 fs/afs/rotate.c      |  4 +++-
 fs/afs/server_list.c | 54 ++++++++++++++++++++++++++++++++++++--------
 fs/afs/vlclient.c    | 19 +++-------------
 4 files changed, 61 insertions(+), 26 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5ae4ca999d65..3d90415c2527 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -515,6 +515,7 @@ struct afs_vldb_entry {
 #define AFS_VOL_VTM_RW	0x01 /* R/W version of the volume is available (on this server) */
 #define AFS_VOL_VTM_RO	0x02 /* R/O version of the volume is available (on this server) */
 #define AFS_VOL_VTM_BAK	0x04 /* backup version of the volume is available (on this server) */
+	u8			vlsf_flags[AFS_NMAXNSERVERS];
 	short			error;
 	u8			nr_servers;	/* Number of server records */
 	u8			name_len;
@@ -601,6 +602,12 @@ struct afs_server {
 	spinlock_t		probe_lock;
 };
 
+enum afs_ro_replicating {
+	AFS_RO_NOT_REPLICATING,			/* Not doing replication */
+	AFS_RO_REPLICATING_USE_OLD,		/* Replicating; use old version */
+	AFS_RO_REPLICATING_USE_NEW,		/* Replicating; switch to new version */
+} __mode(byte);
+
 /*
  * Replaceable volume server list.
  */
@@ -608,12 +615,15 @@ struct afs_server_entry {
 	struct afs_server	*server;
 	struct afs_volume	*volume;
 	struct list_head	slink;		/* Link in server->volumes */
+	unsigned long		flags;
+#define AFS_SE_EXCLUDED		0		/* Set if server is to be excluded in rotation */
 };
 
 struct afs_server_list {
 	struct rcu_head		rcu;
 	refcount_t		usage;
 	bool			attached;	/* T if attached to servers */
+	enum afs_ro_replicating	ro_replicating;	/* RW->RO update (probably) in progress */
 	unsigned char		nr_servers;
 	unsigned char		preferred;	/* Preferred server */
 	unsigned short		vnovol_mask;	/* Servers to be skipped due to VNOVOL */
diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index e8635f60b97d..3ab85a907a1d 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -448,9 +448,11 @@ bool afs_select_fileserver(struct afs_operation *op)
 	op->server_index = -1;
 	rtt = UINT_MAX;
 	for (i = 0; i < op->server_list->nr_servers; i++) {
-		struct afs_server *s = op->server_list->servers[i].server;
+		struct afs_server_entry *se = &op->server_list->servers[i];
+		struct afs_server *s = se->server;
 
 		if (!test_bit(i, &op->untried_servers) ||
+		    test_bit(AFS_SE_EXCLUDED, &se->flags) ||
 		    !test_bit(AFS_SERVER_FL_RESPONDING, &s->flags))
 			continue;
 		if (s->rtt <= rtt) {
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index cfd900eb09ed..fb0f4afcb304 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -31,23 +31,53 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 	struct afs_server_list *slist;
 	struct afs_server *server;
 	unsigned int type_mask = 1 << volume->type;
-	int ret = -ENOMEM, nr_servers = 0, i, j;
-
-	for (i = 0; i < vldb->nr_servers; i++)
-		if (vldb->fs_mask[i] & type_mask)
-			nr_servers++;
+	bool use_newrepsites = false;
+	int ret = -ENOMEM, nr_servers = 0, newrep = 0, i, j, usable = 0;
+
+	/* Work out if we're going to restrict to NEWREPSITE-marked servers or
+	 * not.  If at least one site is marked as NEWREPSITE, then it's likely
+	 * that "vos release" is busy updating RO sites.  We cut over from one
+	 * to the other when >=50% of the sites have been updated.  Sites that
+	 * are in the process of being updated are marked DONTUSE.
+	 */
+	for (i = 0; i < vldb->nr_servers; i++) {
+		if (!(vldb->fs_mask[i] & type_mask))
+			continue;
+		nr_servers++;
+		if (vldb->vlsf_flags[i] & AFS_VLSF_DONTUSE)
+			continue;
+		usable++;
+		if (vldb->vlsf_flags[i] & AFS_VLSF_NEWREPSITE)
+			newrep++;
+	}
 
 	slist = kzalloc(struct_size(slist, servers, nr_servers), GFP_KERNEL);
 	if (!slist)
 		goto error;
 
+	if (newrep) {
+		if (newrep < usable / 2) {
+			slist->ro_replicating = AFS_RO_REPLICATING_USE_OLD;
+		} else {
+			slist->ro_replicating = AFS_RO_REPLICATING_USE_NEW;
+			use_newrepsites = true;
+		}
+	}
+
 	refcount_set(&slist->usage, 1);
 	rwlock_init(&slist->lock);
 
 	/* Make sure a records exists for each server in the list. */
 	for (i = 0; i < vldb->nr_servers; i++) {
+		unsigned long se_flags = 0;
+		bool newrepsite = vldb->vlsf_flags[i] & AFS_VLSF_NEWREPSITE;
+
 		if (!(vldb->fs_mask[i] & type_mask))
 			continue;
+		if (vldb->vlsf_flags[i] & AFS_VLSF_DONTUSE)
+			__set_bit(AFS_SE_EXCLUDED, &se_flags);
+		if (newrep && (newrepsite ^ use_newrepsites))
+			__set_bit(AFS_SE_EXCLUDED, &se_flags);
 
 		server = afs_lookup_server(volume->cell, key, &vldb->fs_server[i],
 					   vldb->addr_version[i]);
@@ -79,6 +109,7 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 
 		slist->servers[j].server = server;
 		slist->servers[j].volume = volume;
+		slist->servers[j].flags = se_flags;
 		slist->nr_servers++;
 	}
 
@@ -101,16 +132,20 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 bool afs_annotate_server_list(struct afs_server_list *new,
 			      struct afs_server_list *old)
 {
+	unsigned long mask = 1UL << AFS_SE_EXCLUDED;
 	struct afs_server *cur;
 	int i, j;
 
-	if (old->nr_servers != new->nr_servers)
+	if (old->nr_servers != new->nr_servers ||
+	    old->ro_replicating != new->ro_replicating)
 		goto changed;
 
-	for (i = 0; i < old->nr_servers; i++)
+	for (i = 0; i < old->nr_servers; i++) {
 		if (old->servers[i].server != new->servers[i].server)
 			goto changed;
-
+		if ((old->servers[i].flags & mask) != (new->servers[i].flags & mask))
+			goto changed;
+	}
 	return false;
 
 changed:
@@ -118,7 +153,8 @@ bool afs_annotate_server_list(struct afs_server_list *new,
 	cur = old->servers[old->preferred].server;
 	for (j = 0; j < new->nr_servers; j++) {
 		if (new->servers[j].server == cur) {
-			new->preferred = j;
+			if (!test_bit(AFS_SE_EXCLUDED, &new->servers[j].flags))
+				new->preferred = j;
 			break;
 		}
 	}
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index cef02a265edc..cac75f89b64a 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -18,8 +18,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 {
 	struct afs_uvldbentry__xdr *uvldb;
 	struct afs_vldb_entry *entry;
-	bool new_only = false;
-	u32 tmp, nr_servers, vlflags;
+	u32 nr_servers, vlflags;
 	int i, ret;
 
 	_enter("");
@@ -41,27 +40,14 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 	entry->name[i] = 0;
 	entry->name_len = strlen(entry->name);
 
-	/* If there is a new replication site that we can use, ignore all the
-	 * sites that aren't marked as new.
-	 */
-	for (i = 0; i < nr_servers; i++) {
-		tmp = ntohl(uvldb->serverFlags[i]);
-		if (!(tmp & AFS_VLSF_DONTUSE) &&
-		    (tmp & AFS_VLSF_NEWREPSITE))
-			new_only = true;
-	}
-
 	vlflags = ntohl(uvldb->flags);
 	for (i = 0; i < nr_servers; i++) {
 		struct afs_uuid__xdr *xdr;
 		struct afs_uuid *uuid;
+		u32 tmp = ntohl(uvldb->serverFlags[i]);
 		int j;
 		int n = entry->nr_servers;
 
-		tmp = ntohl(uvldb->serverFlags[i]);
-		if (tmp & AFS_VLSF_DONTUSE ||
-		    (new_only && !(tmp & AFS_VLSF_NEWREPSITE)))
-			continue;
 		if (tmp & AFS_VLSF_RWVOL) {
 			entry->fs_mask[n] |= AFS_VOL_VTM_RW;
 			if (vlflags & AFS_VLF_BACKEXISTS)
@@ -82,6 +68,7 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 		for (j = 0; j < 6; j++)
 			uuid->node[j] = (u8)ntohl(xdr->node[j]);
 
+		entry->vlsf_flags[n] = tmp;
 		entry->addr_version[n] = ntohl(uvldb->serverUnique[i]);
 		entry->nr_servers++;
 	}


