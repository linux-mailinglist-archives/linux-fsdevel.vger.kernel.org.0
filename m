Return-Path: <linux-fsdevel+bounces-56887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AFCB1CD96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE0A18C5E88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D552BE7C6;
	Wed,  6 Aug 2025 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMnKmnJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7F2BE65F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512680; cv=none; b=pn0j+raAd819V7UD+Xp6+4s2kQQGDVcioOOFtyKhmalO8UfWocYWjwBJWqGdLMbfbllR4j1xlNBKe1gbjmZku9nCjxVXDBML57zK43n2yZp2c+FO/OW92xLR9H1HZN8S75Nd/DFus7xumc7d4amn6SaAL6cA34X+Ke7uCROrqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512680; c=relaxed/simple;
	bh=lqFiNLUvfj7Kj5KBjGf43wU7EG+QnbUsCo8T20T8CAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL4fyUd6ORN8Xd0seAw2P2+Q4WybJ3uNbZ9rFtdTl+6RZOr2L4oOjvLnv/tA6SR+gdXHo5ldD4ryP/bfN2b/jmY316OdpLSO5vAKOkXiXZ9mBIcvX5q4E0yolzW8RU0VEXNy+I+UU02KUby5gtm+6CoV+tD4ebsEwAhYajollcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMnKmnJi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oW29u+3N9bVMFcNgz7z1d16605kAQozM5Ws5N/FAW5s=;
	b=cMnKmnJim2fqtZ9xFgeNfLA2E1kLvScMI1Sg6spWwepJ9FyVSfPOrYzo+eqtG4tV38sLAU
	MzvNkEAZq4zGlmMwKvKqjsXuL73a78H1TcNr/WJw0WrkHK6HykGCOJx0HAJ8dqNjfnfZN7
	7uuySDpNS9Vvp84US6y5HOQ67WdIBwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-9vzpHMUANYGtuCfOAi7J6w-1; Wed,
 06 Aug 2025 16:37:50 -0400
X-MC-Unique: 9vzpHMUANYGtuCfOAi7J6w-1
X-Mimecast-MFC-AGG-ID: 9vzpHMUANYGtuCfOAi7J6w_1754512669
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2252B1955F44;
	Wed,  6 Aug 2025 20:37:49 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 955DB1800446;
	Wed,  6 Aug 2025 20:37:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 07/31] cifs: Rename mid_q_entry to smb_message
Date: Wed,  6 Aug 2025 21:36:28 +0100
Message-ID: <20250806203705.2560493-8-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifs_debug.c    |  14 +-
 fs/smb/client/cifsfs.c        |  31 +++--
 fs/smb/client/cifsglob.h      |  48 +++----
 fs/smb/client/cifsproto.h     |  34 ++---
 fs/smb/client/cifssmb.c       |  82 ++++++------
 fs/smb/client/cifstransport.c | 156 +++++++++++-----------
 fs/smb/client/connect.c       | 152 +++++++++++-----------
 fs/smb/client/netmisc.c       |  14 +-
 fs/smb/client/smb1ops.c       |  46 +++----
 fs/smb/client/smb2misc.c      |   8 +-
 fs/smb/client/smb2ops.c       | 122 +++++++++---------
 fs/smb/client/smb2pdu.c       |  47 ++++---
 fs/smb/client/smb2proto.h     |  10 +-
 fs/smb/client/smb2transport.c |  60 ++++-----
 fs/smb/client/transport.c     | 235 +++++++++++++++++-----------------
 15 files changed, 529 insertions(+), 530 deletions(-)

diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 3fdf75737d43..163e8954b940 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -300,7 +300,7 @@ static __always_inline const char *compression_alg_str(__le16 alg)
 
 static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 {
-	struct mid_q_entry *mid_entry;
+	struct smb_message *smb;
 	struct TCP_Server_Info *server;
 	struct TCP_Server_Info *chan_server;
 	struct cifs_ses *ses;
@@ -624,13 +624,13 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				seq_printf(m, "\n\tServer ConnectionId: 0x%llx",
 					   chan_server->conn_id);
 				spin_lock(&chan_server->mid_lock);
-				list_for_each_entry(mid_entry, &chan_server->pending_mid_q, qhead) {
+				list_for_each_entry(smb, &chan_server->pending_mid_q, qhead) {
 					seq_printf(m, "\n\t\tState: %d com: %d pid: %d cbdata: %p mid %llu",
-						   mid_entry->mid_state,
-						   le16_to_cpu(mid_entry->command),
-						   mid_entry->pid,
-						   mid_entry->callback_data,
-						   mid_entry->mid);
+						   smb->mid_state,
+						   le16_to_cpu(smb->command),
+						   smb->pid,
+						   smb->callback_data,
+						   smb->mid);
 				}
 				spin_unlock(&chan_server->mid_lock);
 			}
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0a5266ecfd15..4e2a1d07125b 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -380,13 +380,13 @@ static int cifs_permission(struct mnt_idmap *idmap,
 
 static struct kmem_cache *cifs_inode_cachep;
 static struct kmem_cache *cifs_req_cachep;
-static struct kmem_cache *cifs_mid_cachep;
+static struct kmem_cache *smb_message_cachep;
 static struct kmem_cache *cifs_sm_req_cachep;
 static struct kmem_cache *cifs_io_request_cachep;
 static struct kmem_cache *cifs_io_subrequest_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
-mempool_t *cifs_mid_poolp;
+mempool_t smb_message_pool;
 mempool_t cifs_io_request_pool;
 mempool_t cifs_io_subrequest_pool;
 
@@ -1765,28 +1765,27 @@ cifs_destroy_request_bufs(void)
 	kmem_cache_destroy(cifs_sm_req_cachep);
 }
 
-static int init_mids(void)
+static int init_smb_message(void)
 {
-	cifs_mid_cachep = kmem_cache_create("cifs_mpx_ids",
-					    sizeof(struct mid_q_entry), 0,
-					    SLAB_HWCACHE_ALIGN, NULL);
-	if (cifs_mid_cachep == NULL)
+	smb_message_cachep = kmem_cache_create("cifs_smb_message",
+					       sizeof(struct smb_message), 0,
+					       SLAB_HWCACHE_ALIGN, NULL);
+	if (smb_message_cachep == NULL)
 		return -ENOMEM;
 
 	/* 3 is a reasonable minimum number of simultaneous operations */
-	cifs_mid_poolp = mempool_create_slab_pool(3, cifs_mid_cachep);
-	if (cifs_mid_poolp == NULL) {
-		kmem_cache_destroy(cifs_mid_cachep);
+	if (mempool_init_slab_pool(&smb_message_pool, 3, smb_message_cachep) < 0) {
+		kmem_cache_destroy(smb_message_cachep);
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void destroy_mids(void)
+static void destroy_smb_message(void)
 {
-	mempool_destroy(cifs_mid_poolp);
-	kmem_cache_destroy(cifs_mid_cachep);
+	mempool_exit(&smb_message_pool);
+	kmem_cache_destroy(smb_message_cachep);
 }
 
 static int cifs_init_netfs(void)
@@ -1946,7 +1945,7 @@ init_cifs(void)
 	if (rc)
 		goto out_destroy_inodecache;
 
-	rc = init_mids();
+	rc = init_smb_message();
 	if (rc)
 		goto out_destroy_netfs;
 
@@ -2003,7 +2002,7 @@ init_cifs(void)
 #endif
 	cifs_destroy_request_bufs();
 out_destroy_mids:
-	destroy_mids();
+	destroy_smb_message();
 out_destroy_netfs:
 	cifs_destroy_netfs();
 out_destroy_inodecache:
@@ -2045,7 +2044,7 @@ exit_cifs(void)
 	dfs_cache_destroy();
 #endif
 	cifs_destroy_request_bufs();
-	destroy_mids();
+	destroy_smb_message();
 	cifs_destroy_netfs();
 	cifs_destroy_inodecache();
 	destroy_workqueue(deferredclose_wq);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 67c1a63a08ba..5d523099e298 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -295,7 +295,7 @@ struct smb_rqst {
 	struct folio_queue *rq_buffer;	/* Buffer for encryption */
 };
 
-struct mid_q_entry;
+struct smb_message;
 struct TCP_Server_Info;
 struct cifsFileInfo;
 struct cifs_ses;
@@ -313,24 +313,24 @@ struct cifs_credits;
 
 struct smb_version_operations {
 	int (*send_cancel)(struct TCP_Server_Info *, struct smb_rqst *,
-			   struct mid_q_entry *);
+			   struct smb_message *smb);
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
 	/* setup request: allocate mid, sign message */
-	struct mid_q_entry *(*setup_request)(struct cifs_ses *,
+	struct smb_message *(*setup_request)(struct cifs_ses *,
 					     struct TCP_Server_Info *,
 					     struct smb_rqst *);
 	/* setup async request: allocate mid, sign message */
-	struct mid_q_entry *(*setup_async_request)(struct TCP_Server_Info *,
-						struct smb_rqst *);
+	struct smb_message *(*setup_async_request)(struct TCP_Server_Info *,
+						   struct smb_rqst *);
 	/* check response: verify signature, map error */
-	int (*check_receive)(struct mid_q_entry *, struct TCP_Server_Info *,
+	int (*check_receive)(struct smb_message *, struct TCP_Server_Info *,
 			     bool);
 	void (*add_credits)(struct TCP_Server_Info *server,
 			    struct cifs_credits *credits,
 			    const int optype);
 	void (*set_credits)(struct TCP_Server_Info *, const int);
 	int * (*get_credits_field)(struct TCP_Server_Info *, const int);
-	unsigned int (*get_credits)(struct mid_q_entry *);
+	unsigned int (*get_credits)(struct smb_message *smb);
 	__u64 (*get_next_mid)(struct TCP_Server_Info *);
 	void (*revert_current_mid)(struct TCP_Server_Info *server,
 				   const unsigned int val);
@@ -347,7 +347,7 @@ struct smb_version_operations {
 	/* map smb to linux error */
 	int (*map_error)(char *, bool);
 	/* find mid corresponding to the response message */
-	struct mid_q_entry * (*find_mid)(struct TCP_Server_Info *, char *);
+	struct smb_message * (*find_mid)(struct TCP_Server_Info *, char *);
 	void (*dump_detail)(void *buf, struct TCP_Server_Info *ptcp_info);
 	void (*clear_stats)(struct cifs_tcon *);
 	void (*print_stats)(struct seq_file *m, struct cifs_tcon *);
@@ -355,12 +355,12 @@ struct smb_version_operations {
 	/* verify the message */
 	int (*check_message)(char *, unsigned int, struct TCP_Server_Info *);
 	bool (*is_oplock_break)(char *, struct TCP_Server_Info *);
-	int (*handle_cancelled_mid)(struct mid_q_entry *, struct TCP_Server_Info *);
+	int (*handle_cancelled_mid)(struct smb_message *smb, struct TCP_Server_Info *server);
 	void (*downgrade_oplock)(struct TCP_Server_Info *server,
 				 struct cifsInodeInfo *cinode, __u32 oplock,
 				 __u16 epoch, bool *purge_cache);
 	/* process transaction2 response */
-	bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info *,
+	bool (*check_trans2)(struct smb_message *smb, struct TCP_Server_Info *server,
 			     char *, int);
 	/* check if we need to negotiate */
 	bool (*need_neg)(struct TCP_Server_Info *);
@@ -597,7 +597,7 @@ struct smb_version_operations {
 				 struct smb_rqst *, struct smb_rqst *);
 	int (*is_transform_hdr)(void *buf);
 	int (*receive_transform)(struct TCP_Server_Info *,
-				 struct mid_q_entry **, char **, int *);
+				 struct smb_message **smb, char **, int *);
 	enum securityEnum (*select_sectype)(struct TCP_Server_Info *,
 			    enum securityEnum);
 	int (*next_header)(struct TCP_Server_Info *server, char *buf,
@@ -1683,8 +1683,8 @@ static inline void cifs_stats_bytes_read(struct cifs_tcon *tcon,
  * Returns zero on a successful receive, or an error. The receive state in
  * the TCP_Server_Info will also be updated.
  */
-typedef int (mid_receive_t)(struct TCP_Server_Info *server,
-			    struct mid_q_entry *mid);
+typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
+			    struct smb_message *msg);
 
 /*
  * This is the prototype for the mid callback function. This is called once the
@@ -1694,17 +1694,17 @@ typedef int (mid_receive_t)(struct TCP_Server_Info *server,
  * - it will be called by cifsd, with no locks held
  * - the mid will be removed from any lists
  */
-typedef void (mid_callback_t)(struct mid_q_entry *mid);
+typedef void (*mid_callback_t)(struct smb_message *smb);
 
 /*
  * This is the protopyte for mid handle function. This is called once the mid
  * has been recognized after decryption of the message.
  */
-typedef int (mid_handle_t)(struct TCP_Server_Info *server,
-			    struct mid_q_entry *mid);
+typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
+			    struct smb_message *smb);
 
 /* one of these for every pending CIFS request to the server */
-struct mid_q_entry {
+struct smb_message {
 	struct list_head qhead;	/* mids waiting on reply from this server */
 	struct kref refcount;
 	struct TCP_Server_Info *server;	/* server corresponding to this mid */
@@ -1718,9 +1718,9 @@ struct mid_q_entry {
 	unsigned long when_sent; /* time when smb send finished */
 	unsigned long when_received; /* when demux complete (taken off wire) */
 #endif
-	mid_receive_t *receive; /* call receive callback */
-	mid_callback_t *callback; /* call completion callback */
-	mid_handle_t *handle; /* call handle mid callback */
+	mid_receive_t receive; /* call receive callback */
+	mid_callback_t callback; /* call completion callback */
+	mid_handle_t handle; /* call handle mid callback */
 	void *callback_data;	  /* general purpose pointer for callback */
 	struct task_struct *creator;
 	void *resp_buf;		/* pointer to received SMB header */
@@ -1767,12 +1767,12 @@ static inline void cifs_num_waiters_dec(struct TCP_Server_Info *server)
 }
 
 #ifdef CONFIG_CIFS_STATS2
-static inline void cifs_save_when_sent(struct mid_q_entry *mid)
+static inline void cifs_save_when_sent(struct smb_message *smb)
 {
-	mid->when_sent = jiffies;
+	smb->when_sent = jiffies;
 }
 #else
-static inline void cifs_save_when_sent(struct mid_q_entry *mid)
+static inline void cifs_save_when_sent(struct smb_message *smb)
 {
 }
 #endif
@@ -2124,7 +2124,7 @@ extern __u32 cifs_lock_secret;
 
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
-extern mempool_t *cifs_mid_poolp;
+extern mempool_t smb_message_pool;
 extern mempool_t cifs_io_request_pool;
 extern mempool_t cifs_io_subrequest_pool;
 
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 8661ab105b4f..1126feb4ba5f 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -83,11 +83,11 @@ extern char *cifs_build_path_to_root(struct smb3_fs_context *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct mid_q_entry *mid);
+extern void delete_mid(struct smb_message *smb);
 void __release_mid(struct kref *refcount);
-extern void cifs_wake_up_task(struct mid_q_entry *mid);
+extern void cifs_wake_up_task(struct smb_message *smb);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
-				struct mid_q_entry *mid);
+				struct smb_message *smb);
 extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
 				      char dirsep);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
@@ -97,8 +97,8 @@ extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
 			struct smb_rqst *rqst,
-			mid_receive_t *receive, mid_callback_t *callback,
-			mid_handle_t *handle, void *cbdata, const int flags,
+			mid_receive_t receive, mid_callback_t callback,
+			mid_handle_t handle, void *cbdata, const int flags,
 			const struct cifs_credits *exist_credits);
 extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
 extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
@@ -116,15 +116,15 @@ extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
 			int * /* bytes returned */ , const int);
 extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 			    char *in_buf, int flags);
-int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server);
-extern struct mid_q_entry *cifs_setup_request(struct cifs_ses *,
+int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server);
+extern struct smb_message *cifs_setup_request(struct cifs_ses *,
 				struct TCP_Server_Info *,
 				struct smb_rqst *);
-extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *,
+extern struct smb_message *cifs_setup_async_request(struct TCP_Server_Info *,
 						struct smb_rqst *);
 int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		    struct smb_rqst *rqst);
-extern int cifs_check_receive(struct mid_q_entry *mid,
+extern int cifs_check_receive(struct smb_message *msg,
 			struct TCP_Server_Info *server, bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
 			  unsigned int *instance);
@@ -134,13 +134,13 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
 
 static inline int
 send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	    struct mid_q_entry *mid)
+	    struct smb_message *smb)
 {
 	return server->ops->send_cancel ?
-				server->ops->send_cancel(server, rqst, mid) : 0;
+				server->ops->send_cancel(server, rqst, smb) : 0;
 }
 
-int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ);
+int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb);
 extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
 			int * /* type of buf returned */, const int flags,
@@ -186,7 +186,7 @@ extern int decode_negTokenInit(unsigned char *security_blob, int length,
 extern int cifs_convert_address(struct sockaddr *dst, const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
-extern int map_and_check_smb_error(struct mid_q_entry *mid, bool logErr);
+extern int map_and_check_smb_error(struct smb_message *smb, bool logErr);
 extern void header_assemble(struct smb_hdr *, char /* command */ ,
 			    const struct cifs_tcon *, int /* length of
 			    fixed section (word count) in two byte units */);
@@ -269,7 +269,7 @@ extern unsigned int setup_special_mode_ACE(struct smb_ace *pace,
 					   __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
-extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
+extern void dequeue_mid(struct smb_message *smb, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 			         unsigned int to_read);
 extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
@@ -613,7 +613,7 @@ extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
 
 int cifs_async_readv(struct cifs_io_subrequest *rdata);
-int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+int cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb);
 
 void cifs_async_writev(struct cifs_io_subrequest *wdata);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
@@ -762,9 +762,9 @@ static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
 	return true;
 }
 
-static inline void release_mid(struct mid_q_entry *mid)
+static inline void release_mid(struct smb_message *smb)
 {
-	kref_put(&mid->refcount, __release_mid);
+	kref_put(&smb->refcount, __release_mid);
 }
 
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 75142f49d65d..879fa0ad6e44 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -577,12 +577,12 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon *tcon)
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-cifs_echo_callback(struct mid_q_entry *mid)
+cifs_echo_callback(struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = mid->callback_data;
+	struct TCP_Server_Info *server = smb->callback_data;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	release_mid(mid);
+	release_mid(smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -1296,9 +1296,9 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 }
 
 static void
-cifs_readv_callback(struct mid_q_entry *mid)
+cifs_readv_callback(struct smb_message *smb)
 {
-	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = smb->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
@@ -1313,10 +1313,10 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	};
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
-		 __func__, mid->mid, mid->mid_state, rdata->result,
+		 __func__, smb->mid, smb->mid_state, rdata->result,
 		 rdata->subreq.len);
 
-	switch (mid->mid_state) {
+	switch (smb->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		/* result already set, check signature */
 		if (server->sign) {
@@ -1324,7 +1324,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 
 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
 			rc = cifs_verify_signature(&rqst, server,
-						  mid->sequence_number);
+						  smb->sequence_number);
 			if (rc)
 				cifs_dbg(VFS, "SMB signature verification returned error = %d\n",
 					 rc);
@@ -1379,7 +1379,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(mid);
+	release_mid(smb);
 	add_credits(server, &credits, 0);
 }
 
@@ -1682,12 +1682,12 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-cifs_writev_callback(struct mid_q_entry *mid)
+cifs_writev_callback(struct smb_message *smb)
 {
-	struct cifs_io_subrequest *wdata = mid->callback_data;
+	struct cifs_io_subrequest *wdata = smb->callback_data;
 	struct TCP_Server_Info *server = wdata->server;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	WRITE_RSP *smb = (WRITE_RSP *)mid->resp_buf;
+	WRITE_RSP *rsp = (WRITE_RSP *)smb->resp_buf;
 	struct cifs_credits credits = {
 		.value = 1,
 		.instance = 0,
@@ -1697,15 +1697,15 @@ cifs_writev_callback(struct mid_q_entry *mid)
 	ssize_t result;
 	size_t written;
 
-	switch (mid->mid_state) {
+	switch (smb->mid_state) {
 	case MID_RESPONSE_RECEIVED:
-		result = cifs_check_receive(mid, tcon->ses->server, 0);
+		result = cifs_check_receive(smb, tcon->ses->server, 0);
 		if (result != 0)
 			break;
 
-		written = le16_to_cpu(smb->CountHigh);
+		written = le16_to_cpu(rsp->CountHigh);
 		written <<= 16;
-		written += le16_to_cpu(smb->Count);
+		written += le16_to_cpu(rsp->Count);
 		/*
 		 * Mask off high 16 bits when bytes written as returned
 		 * by the server is greater than bytes requested by the
@@ -1749,7 +1749,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result);
-	release_mid(mid);
+	release_mid(smb);
 	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
@@ -1761,7 +1761,7 @@ void
 cifs_async_writev(struct cifs_io_subrequest *wdata)
 {
 	int rc = -EACCES;
-	WRITE_REQ *smb = NULL;
+	WRITE_REQ *req = NULL;
 	int wct;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct kvec iov[2];
@@ -1778,30 +1778,30 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		}
 	}
 
-	rc = small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **)&smb);
+	rc = small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **)&req);
 	if (rc)
 		goto async_writev_out;
 
-	smb->hdr.Pid = cpu_to_le16((__u16)wdata->req->pid);
-	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->req->pid >> 16));
+	req->hdr.Pid = cpu_to_le16((__u16)wdata->req->pid);
+	req->hdr.PidHigh = cpu_to_le16((__u16)(wdata->req->pid >> 16));
 
-	smb->AndXCommand = 0xFF;	/* none */
-	smb->Fid = wdata->req->cfile->fid.netfid;
-	smb->OffsetLow = cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
+	req->AndXCommand = 0xFF;	/* none */
+	req->Fid = wdata->req->cfile->fid.netfid;
+	req->OffsetLow = cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
 	if (wct == 14)
-		smb->OffsetHigh = cpu_to_le32(wdata->subreq.start >> 32);
-	smb->Reserved = 0xFFFFFFFF;
-	smb->WriteMode = 0;
-	smb->Remaining = 0;
+		req->OffsetHigh = cpu_to_le32(wdata->subreq.start >> 32);
+	req->Reserved = 0xFFFFFFFF;
+	req->WriteMode = 0;
+	req->Remaining = 0;
 
-	smb->DataOffset =
+	req->DataOffset =
 	    cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
 
 	/* 4 for RFC1001 length + 1 for BCC */
 	iov[0].iov_len = 4;
-	iov[0].iov_base = smb;
-	iov[1].iov_len = get_rfc1002_length(smb) + 1;
-	iov[1].iov_base = (char *)smb + 4;
+	iov[0].iov_base = req;
+	iov[1].iov_len = get_rfc1002_length(req) + 1;
+	iov[1].iov_base = (char *)req + 4;
 
 	rqst.rq_iov = iov;
 	rqst.rq_nvec = 2;
@@ -1810,18 +1810,18 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
 		 wdata->subreq.start, wdata->subreq.len);
 
-	smb->DataLengthLow = cpu_to_le16(wdata->subreq.len & 0xFFFF);
-	smb->DataLengthHigh = cpu_to_le16(wdata->subreq.len >> 16);
+	req->DataLengthLow = cpu_to_le16(wdata->subreq.len & 0xFFFF);
+	req->DataLengthHigh = cpu_to_le16(wdata->subreq.len >> 16);
 
 	if (wct == 14) {
-		inc_rfc1001_len(&smb->hdr, wdata->subreq.len + 1);
-		put_bcc(wdata->subreq.len + 1, &smb->hdr);
+		inc_rfc1001_len(&req->hdr, wdata->subreq.len + 1);
+		put_bcc(wdata->subreq.len + 1, &req->hdr);
 	} else {
 		/* wct == 12 */
-		struct smb_com_writex_req *smbw =
-				(struct smb_com_writex_req *)smb;
-		inc_rfc1001_len(&smbw->hdr, wdata->subreq.len + 5);
-		put_bcc(wdata->subreq.len + 5, &smbw->hdr);
+		struct smb_com_writex_req *reqw =
+				(struct smb_com_writex_req *)req;
+		inc_rfc1001_len(&reqw->hdr, wdata->subreq.len + 5);
+		put_bcc(wdata->subreq.len + 5, &reqw->hdr);
 		iov[1].iov_len += 4; /* pad bigger by four bytes */
 	}
 
@@ -1832,7 +1832,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		cifs_stats_inc(&tcon->stats.cifs_stats.num_writes);
 
 async_writev_out:
-	cifs_small_buf_release(smb);
+	cifs_small_buf_release(req);
 out:
 	if (rc) {
 		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index 241e0b427357..20709ae52d26 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -33,40 +33,40 @@
 /* Max number of iovectors we can use off the stack when sending requests. */
 #define CIFS_MAX_IOV_SIZE 8
 
-static struct mid_q_entry *
+static struct smb_message *
 alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 {
-	struct mid_q_entry *temp;
+	struct smb_message *smb;
 
 	if (server == NULL) {
 		cifs_dbg(VFS, "%s: null TCP session\n", __func__);
 		return NULL;
 	}
 
-	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
-	memset(temp, 0, sizeof(struct mid_q_entry));
-	kref_init(&temp->refcount);
-	temp->mid = get_mid(smb_buffer);
-	temp->pid = current->pid;
-	temp->command = cpu_to_le16(smb_buffer->Command);
+	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
+	memset(smb, 0, sizeof(struct smb_message));
+	kref_init(&smb->refcount);
+	smb->mid = get_mid(smb_buffer);
+	smb->pid = current->pid;
+	smb->command = cpu_to_le16(smb_buffer->Command);
 	cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
 	/* easier to use jiffies */
 	/* when mid allocated can be before when sent */
-	temp->when_alloc = jiffies;
-	temp->server = server;
+	smb->when_alloc = jiffies;
+	smb->server = server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
 	 * default callback just wakes up the current task.
 	 */
 	get_task_struct(current);
-	temp->creator = current;
-	temp->callback = cifs_wake_up_task;
-	temp->callback_data = current;
+	smb->creator = current;
+	smb->callback = cifs_wake_up_task;
+	smb->callback_data = current;
 
 	atomic_inc(&mid_count);
-	temp->mid_state = MID_REQUEST_ALLOCATED;
-	return temp;
+	smb->mid_state = MID_REQUEST_ALLOCATED;
+	return smb;
 }
 
 int
@@ -86,7 +86,7 @@ smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
 }
 
 static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
-			struct mid_q_entry **ppmidQ)
+			struct smb_message **ppmidQ)
 {
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status == SES_NEW) {
@@ -117,12 +117,12 @@ static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 	return 0;
 }
 
-struct mid_q_entry *
+struct smb_message *
 cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 
 	if (rqst->rq_iov[0].iov_len != 4 ||
 	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
@@ -132,17 +132,17 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	if (server->sign)
 		hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
 
-	mid = alloc_mid(hdr, server);
-	if (mid == NULL)
+	smb = alloc_mid(hdr, server);
+	if (smb == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
+	rc = cifs_sign_rqst(rqst, server, &smb->sequence_number);
 	if (rc) {
-		release_mid(mid);
+		release_mid(smb);
 		return ERR_PTR(rc);
 	}
 
-	return mid;
+	return smb;
 }
 
 /*
@@ -173,12 +173,12 @@ SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 }
 
 int
-cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 		   bool log_error)
 {
-	unsigned int len = get_rfc1002_length(mid->resp_buf) + 4;
+	unsigned int len = get_rfc1002_length(smb->resp_buf) + 4;
 
-	dump_smb(mid->resp_buf, min_t(u32, 92, len));
+	dump_smb(smb->resp_buf, min_t(u32, 92, len));
 
 	/* convert the length into a more usable form */
 	if (server->sign) {
@@ -187,43 +187,43 @@ cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		struct smb_rqst rqst = { .rq_iov = iov,
 					 .rq_nvec = 2 };
 
-		iov[0].iov_base = mid->resp_buf;
+		iov[0].iov_base = smb->resp_buf;
 		iov[0].iov_len = 4;
-		iov[1].iov_base = (char *)mid->resp_buf + 4;
+		iov[1].iov_base = (char *)smb->resp_buf + 4;
 		iov[1].iov_len = len - 4;
 		/* FIXME: add code to kill session */
 		rc = cifs_verify_signature(&rqst, server,
-					   mid->sequence_number);
+					   smb->sequence_number);
 		if (rc)
 			cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
 				 rc);
 	}
 
 	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(mid, log_error);
+	return map_and_check_smb_error(smb, log_error);
 }
 
-struct mid_q_entry *
+struct smb_message *
 cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
 		   struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 
 	if (rqst->rq_iov[0].iov_len != 4 ||
 	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
 		return ERR_PTR(-EIO);
 
-	rc = allocate_mid(ses, hdr, &mid);
+	rc = allocate_mid(ses, hdr, &smb);
 	if (rc)
 		return ERR_PTR(rc);
-	rc = cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
+	rc = cifs_sign_rqst(rqst, ses->server, &smb->sequence_number);
 	if (rc) {
-		delete_mid(mid);
+		delete_mid(smb);
 		return ERR_PTR(rc);
 	}
-	return mid;
+	return smb;
 }
 
 int
@@ -271,7 +271,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	    int *pbytes_returned, const int flags)
 {
 	int rc = 0;
-	struct mid_q_entry *midQ;
+	struct smb_message *smb;
 	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
 	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
@@ -315,7 +315,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 
 	cifs_server_lock(server);
 
-	rc = allocate_mid(ses, in_buf, &midQ);
+	rc = allocate_mid(ses, in_buf, &smb);
 	if (rc) {
 		cifs_server_unlock(server);
 		/* Update # of requests on wire to server */
@@ -323,16 +323,16 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
+	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		goto out;
 	}
 
-	midQ->mid_state = MID_REQUEST_SUBMITTED;
+	smb->mid_state = MID_REQUEST_SUBMITTED;
 
 	rc = smb_send(server, in_buf, len);
-	cifs_save_when_sent(midQ);
+	cifs_save_when_sent(smb);
 
 	if (rc < 0)
 		server->sequence_number -= 2;
@@ -342,14 +342,14 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0)
 		goto out;
 
-	rc = wait_for_response(server, midQ);
+	rc = wait_for_response(server, smb);
 	if (rc != 0) {
-		send_cancel(server, &rqst, midQ);
+		send_cancel(server, &rqst, smb);
 		spin_lock(&server->mid_lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
+		if (smb->mid_state == MID_REQUEST_SUBMITTED ||
+		    smb->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
-			midQ->callback = release_mid;
+			smb->callback = release_mid;
 			spin_unlock(&server->mid_lock);
 			add_credits(server, &credits, 0);
 			return rc;
@@ -357,24 +357,24 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		spin_unlock(&server->mid_lock);
 	}
 
-	rc = cifs_sync_mid_result(midQ, server);
+	rc = cifs_sync_mid_result(smb, server);
 	if (rc != 0) {
 		add_credits(server, &credits, 0);
 		return rc;
 	}
 
-	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_READY) {
+	if (!smb->resp_buf || !out_buf ||
+	    smb->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
-	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
-	rc = cifs_check_receive(midQ, server, 0);
+	*pbytes_returned = get_rfc1002_length(smb->resp_buf);
+	memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
+	rc = cifs_check_receive(smb, server, 0);
 out:
-	delete_mid(midQ);
+	delete_mid(smb);
 	add_credits(server, &credits, 0);
 
 	return rc;
@@ -412,7 +412,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	int rc = 0;
 	int rstart = 0;
-	struct mid_q_entry *midQ;
+	struct smb_message *smb;
 	struct cifs_ses *ses;
 	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
 	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
@@ -459,22 +459,22 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	cifs_server_lock(server);
 
-	rc = allocate_mid(ses, in_buf, &midQ);
+	rc = allocate_mid(ses, in_buf, &smb);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, server, &midQ->sequence_number);
+	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
 	if (rc) {
-		delete_mid(midQ);
+		delete_mid(smb);
 		cifs_server_unlock(server);
 		return rc;
 	}
 
-	midQ->mid_state = MID_REQUEST_SUBMITTED;
+	smb->mid_state = MID_REQUEST_SUBMITTED;
 	rc = smb_send(server, in_buf, len);
-	cifs_save_when_sent(midQ);
+	cifs_save_when_sent(smb);
 
 	if (rc < 0)
 		server->sequence_number -= 2;
@@ -482,22 +482,22 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	cifs_server_unlock(server);
 
 	if (rc < 0) {
-		delete_mid(midQ);
+		delete_mid(smb);
 		return rc;
 	}
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
+		(!(smb->mid_state == MID_REQUEST_SUBMITTED ||
+		   smb->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	spin_lock(&server->srv_lock);
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
-		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
+		(smb->mid_state == MID_REQUEST_SUBMITTED ||
+		 smb->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 		spin_unlock(&server->srv_lock);
@@ -505,9 +505,9 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (in_buf->Command == SMB_COM_TRANSACTION2) {
 			/* POSIX lock. We send a NT_CANCEL SMB to cause the
 			   blocking lock to return. */
-			rc = send_cancel(server, &rqst, midQ);
+			rc = send_cancel(server, &rqst, smb);
 			if (rc) {
-				delete_mid(midQ);
+				delete_mid(smb);
 				return rc;
 			}
 		} else {
@@ -519,19 +519,19 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 			/* If we get -ENOLCK back the lock may have
 			   already been removed. Don't exit in this case. */
 			if (rc && rc != -ENOLCK) {
-				delete_mid(midQ);
+				delete_mid(smb);
 				return rc;
 			}
 		}
 
-		rc = wait_for_response(server, midQ);
+		rc = wait_for_response(server, smb);
 		if (rc) {
-			send_cancel(server, &rqst, midQ);
+			send_cancel(server, &rqst, smb);
 			spin_lock(&server->mid_lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
-			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
+			if (smb->mid_state == MID_REQUEST_SUBMITTED ||
+			    smb->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
-				midQ->callback = release_mid;
+				smb->callback = release_mid;
 				spin_unlock(&server->mid_lock);
 				return rc;
 			}
@@ -544,22 +544,22 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	spin_unlock(&server->srv_lock);
 
-	rc = cifs_sync_mid_result(midQ, server);
+	rc = cifs_sync_mid_result(smb, server);
 	if (rc != 0)
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
+	if (out_buf == NULL || smb->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
 	}
 
-	*pbytes_returned = get_rfc1002_length(midQ->resp_buf);
-	memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
-	rc = cifs_check_receive(midQ, server, 0);
+	*pbytes_returned = get_rfc1002_length(smb->resp_buf);
+	memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
+	rc = cifs_check_receive(smb, server, 0);
 out:
-	delete_mid(midQ);
+	delete_mid(smb);
 	if (rstart && rc == -EACCES)
 		return -ERESTARTSYS;
 	return rc;
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 205f547ca49e..9abaca4c8eba 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -293,7 +293,7 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 static void
 cifs_abort_connection(struct TCP_Server_Info *server)
 {
-	struct mid_q_entry *mid, *nmid;
+	struct smb_message *smb, *nsmb;
 	struct list_head retry_list;
 
 	server->maxBuf = 0;
@@ -322,21 +322,21 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	INIT_LIST_HEAD(&retry_list);
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_lock);
-	list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
-		kref_get(&mid->refcount);
-		if (mid->mid_state == MID_REQUEST_SUBMITTED)
-			mid->mid_state = MID_RETRY_NEEDED;
-		list_move(&mid->qhead, &retry_list);
-		mid->mid_flags |= MID_DELETED;
+	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
+		kref_get(&smb->refcount);
+		if (smb->mid_state == MID_REQUEST_SUBMITTED)
+			smb->mid_state = MID_RETRY_NEEDED;
+		list_move(&smb->qhead, &retry_list);
+		smb->mid_flags |= MID_DELETED;
 	}
 	spin_unlock(&server->mid_lock);
 	cifs_server_unlock(server);
 
 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
-	list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
-		list_del_init(&mid->qhead);
-		mid->callback(mid);
-		release_mid(mid);
+	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
+		list_del_init(&smb->qhead);
+		smb->callback(smb);
+		release_mid(smb);
 	}
 
 	if (cifs_rdma_enabled(server)) {
@@ -872,7 +872,7 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 		    !server->with_rfc1001 &&
 		    server->rfc1001_sessinit != 0) {
 			int rc, mid_rc;
-			struct mid_q_entry *mid, *nmid;
+			struct smb_message *smb, *nsmb;
 			LIST_HEAD(dispose_list);
 
 			cifs_dbg(FYI, "RFC 1002 negative session response during SMB Negotiate, retrying with NetBIOS session\n");
@@ -885,10 +885,10 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 * corresponding to SMB1/SMB2 Negotiate packet.
 			 */
 			spin_lock(&server->mid_lock);
-			list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
-				kref_get(&mid->refcount);
-				list_move(&mid->qhead, &dispose_list);
-				mid->mid_flags |= MID_DELETED;
+			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
+				kref_get(&smb->refcount);
+				list_move(&smb->qhead, &dispose_list);
+				smb->mid_flags |= MID_DELETED;
 			}
 			spin_unlock(&server->mid_lock);
 
@@ -915,12 +915,12 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 			 * callback. Use MID_RC state which indicates that the
 			 * return code should be read from mid_rc member.
 			 */
-			list_for_each_entry_safe(mid, nmid, &dispose_list, qhead) {
-				list_del_init(&mid->qhead);
-				mid->mid_rc = mid_rc;
-				mid->mid_state = MID_RC;
-				mid->callback(mid);
-				release_mid(mid);
+			list_for_each_entry_safe(smb, nsmb, &dispose_list, qhead) {
+				list_del_init(&smb->qhead);
+				smb->mid_rc = mid_rc;
+				smb->mid_state = MID_RC;
+				smb->callback(smb);
+				release_mid(smb);
 			}
 
 			/*
@@ -952,27 +952,27 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 }
 
 void
-dequeue_mid(struct mid_q_entry *mid, bool malformed)
+dequeue_mid(struct smb_message *smb, bool malformed)
 {
 #ifdef CONFIG_CIFS_STATS2
-	mid->when_received = jiffies;
+	smb->when_received = jiffies;
 #endif
-	spin_lock(&mid->server->mid_lock);
+	spin_lock(&smb->server->mid_lock);
 	if (!malformed)
-		mid->mid_state = MID_RESPONSE_RECEIVED;
+		smb->mid_state = MID_RESPONSE_RECEIVED;
 	else
-		mid->mid_state = MID_RESPONSE_MALFORMED;
+		smb->mid_state = MID_RESPONSE_MALFORMED;
 	/*
 	 * Trying to handle/dequeue a mid after the send_recv()
 	 * function has finished processing it is a bug.
 	 */
-	if (mid->mid_flags & MID_DELETED) {
-		spin_unlock(&mid->server->mid_lock);
+	if (smb->mid_flags & MID_DELETED) {
+		spin_unlock(&smb->server->mid_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
-		list_del_init(&mid->qhead);
-		mid->mid_flags |= MID_DELETED;
-		spin_unlock(&mid->server->mid_lock);
+		list_del_init(&smb->qhead);
+		smb->mid_flags |= MID_DELETED;
+		spin_unlock(&smb->server->mid_lock);
 	}
 }
 
@@ -991,24 +991,24 @@ smb2_get_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 }
 
 static void
-handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+handle_mid(struct smb_message *smb, struct TCP_Server_Info *server,
 	   char *buf, int malformed)
 {
 	if (server->ops->check_trans2 &&
-	    server->ops->check_trans2(mid, server, buf, malformed))
+	    server->ops->check_trans2(smb, server, buf, malformed))
 		return;
-	mid->credits_received = smb2_get_credits_from_hdr(buf, server);
-	mid->resp_buf = buf;
-	mid->large_buf = server->large_buf;
+	smb->credits_received = smb2_get_credits_from_hdr(buf, server);
+	smb->resp_buf = buf;
+	smb->large_buf = server->large_buf;
 	/* Was previous buf put in mpx struct for multi-rsp? */
-	if (!mid->multiRsp) {
+	if (!smb->multiRsp) {
 		/* smb buffer will be freed by user thread */
 		if (server->large_buf)
 			server->bigbuf = NULL;
 		else
 			server->smallbuf = NULL;
 	}
-	dequeue_mid(mid, malformed);
+	dequeue_mid(smb, malformed);
 }
 
 int
@@ -1097,28 +1097,28 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 	}
 
 	if (!list_empty(&server->pending_mid_q)) {
-		struct mid_q_entry *mid_entry;
+		struct smb_message *smb;
 		struct list_head *tmp, *tmp2;
 		LIST_HEAD(dispose_list);
 
 		spin_lock(&server->mid_lock);
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
-			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
-			cifs_dbg(FYI, "Clearing mid %llu\n", mid_entry->mid);
-			kref_get(&mid_entry->refcount);
-			mid_entry->mid_state = MID_SHUTDOWN;
-			list_move(&mid_entry->qhead, &dispose_list);
-			mid_entry->mid_flags |= MID_DELETED;
+			smb = list_entry(tmp, struct smb_message, qhead);
+			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
+			kref_get(&smb->refcount);
+			smb->mid_state = MID_SHUTDOWN;
+			list_move(&smb->qhead, &dispose_list);
+			smb->mid_flags |= MID_DELETED;
 		}
 		spin_unlock(&server->mid_lock);
 
 		/* now walk dispose list and issue callbacks */
 		list_for_each_safe(tmp, tmp2, &dispose_list) {
-			mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
-			cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
-			list_del_init(&mid_entry->qhead);
-			mid_entry->callback(mid_entry);
-			release_mid(mid_entry);
+			smb = list_entry(tmp, struct smb_message, qhead);
+			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
+			list_del_init(&smb->qhead);
+			smb->callback(smb);
+			release_mid(smb);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1152,7 +1152,7 @@ clean_demultiplex_info(struct TCP_Server_Info *server)
 }
 
 static int
-standard_receive3(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+standard_receive3(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	int length;
 	char *buf = server->smallbuf;
@@ -1183,11 +1183,11 @@ standard_receive3(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 
 	dump_smb(buf, server->total_read);
 
-	return cifs_handle_standard(server, mid);
+	return cifs_handle_standard(server, smb);
 }
 
 int
-cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+cifs_handle_standard(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	char *buf = server->large_buf ? server->bigbuf : server->smallbuf;
 	int rc;
@@ -1215,10 +1215,10 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	    server->ops->is_status_pending(buf, server))
 		return -1;
 
-	if (!mid)
+	if (!smb)
 		return rc;
 
-	handle_mid(mid, server, buf, rc);
+	handle_mid(smb, server, buf, rc);
 	return 0;
 }
 
@@ -1255,13 +1255,13 @@ smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 static int
 cifs_demultiplex_thread(void *p)
 {
-	int i, num_mids, length;
+	int i, num_smbs, length;
 	struct TCP_Server_Info *server = p;
 	unsigned int pdu_length;
 	unsigned int next_offset;
 	char *buf = NULL;
 	struct task_struct *task_to_wake = NULL;
-	struct mid_q_entry *mids[MAX_COMPOUND];
+	struct smb_message *smbs[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout = 0;
 	bool pending_reconnect = false;
@@ -1336,32 +1336,32 @@ cifs_demultiplex_thread(void *p)
 				server->pdu_size = next_offset;
 		}
 
-		memset(mids, 0, sizeof(mids));
+		memset(smbs, 0, sizeof(smbs));
 		memset(bufs, 0, sizeof(bufs));
-		num_mids = 0;
+		num_smbs = 0;
 
 		if (server->ops->is_transform_hdr &&
 		    server->ops->receive_transform &&
 		    server->ops->is_transform_hdr(buf)) {
 			length = server->ops->receive_transform(server,
-								mids,
+								smbs,
 								bufs,
-								&num_mids);
+								&num_smbs);
 		} else {
-			mids[0] = server->ops->find_mid(server, buf);
+			smbs[0] = server->ops->find_mid(server, buf);
 			bufs[0] = buf;
-			num_mids = 1;
+			num_smbs = 1;
 
-			if (!mids[0] || !mids[0]->receive)
-				length = standard_receive3(server, mids[0]);
+			if (!smbs[0] || !smbs[0]->receive)
+				length = standard_receive3(server, smbs[0]);
 			else
-				length = mids[0]->receive(server, mids[0]);
+				length = smbs[0]->receive(server, smbs[0]);
 		}
 
 		if (length < 0) {
-			for (i = 0; i < num_mids; i++)
-				if (mids[i])
-					release_mid(mids[i]);
+			for (i = 0; i < num_smbs; i++)
+				if (smbs[i])
+					release_mid(smbs[i]);
 			continue;
 		}
 
@@ -1380,9 +1380,9 @@ cifs_demultiplex_thread(void *p)
 
 		server->lstrp = jiffies;
 
-		for (i = 0; i < num_mids; i++) {
-			if (mids[i] != NULL) {
-				mids[i]->resp_buf_size = server->pdu_size;
+		for (i = 0; i < num_smbs; i++) {
+			if (smbs[i] != NULL) {
+				smbs[i]->resp_buf_size = server->pdu_size;
 
 				if (bufs[i] != NULL) {
 					if (server->ops->is_network_name_deleted &&
@@ -1393,10 +1393,10 @@ cifs_demultiplex_thread(void *p)
 					}
 				}
 
-				if (!mids[i]->multiRsp || mids[i]->multiEnd)
-					mids[i]->callback(mids[i]);
+				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
+					smbs[i]->callback(smbs[i]);
 
-				release_mid(mids[i]);
+				release_mid(smbs[i]);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 9ec20601cee2..b34d2b91cf5a 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -889,22 +889,22 @@ map_smb_to_linux_error(char *buf, bool logErr)
 }
 
 int
-map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
+map_and_check_smb_error(struct smb_message *smb, bool logErr)
 {
 	int rc;
-	struct smb_hdr *smb = (struct smb_hdr *)mid->resp_buf;
+	struct smb_hdr *rhdr = (struct smb_hdr *)smb->resp_buf;
 
-	rc = map_smb_to_linux_error((char *)smb, logErr);
-	if (rc == -EACCES && !(smb->Flags2 & SMBFLG2_ERR_STATUS)) {
+	rc = map_smb_to_linux_error((char *)rhdr, logErr);
+	if (rc == -EACCES && !(rhdr->Flags2 & SMBFLG2_ERR_STATUS)) {
 		/* possible ERRBaduid */
-		__u8 class = smb->Status.DosError.ErrorClass;
-		__u16 code = le16_to_cpu(smb->Status.DosError.Error);
+		__u8 class = rhdr->Status.DosError.ErrorClass;
+		__u16 code = le16_to_cpu(rhdr->Status.DosError.Error);
 
 		/* switch can be used to handle different errors */
 		if (class == ERRSRV && code == ERRbaduid) {
 			cifs_dbg(FYI, "Server returned 0x%x, reconnecting session...\n",
 				code);
-			cifs_signal_cifsd_for_reconnect(mid->server, false);
+			cifs_signal_cifsd_for_reconnect(smb->server, false);
 		}
 	}
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index b27a182629ec..ba301c94d4ff 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -29,7 +29,7 @@
  */
 static int
 send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-	       struct mid_q_entry *mid)
+	       struct smb_message *smb)
 {
 	int rc = 0;
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
@@ -41,7 +41,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	put_bcc(0, in_buf);
 
 	cifs_server_lock(server);
-	rc = cifs_sign_smb(in_buf, server, &mid->sequence_number);
+	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
@@ -88,20 +88,20 @@ cifs_read_data_length(char *buf, bool in_remaining)
 	       le16_to_cpu(rsp->DataLength);
 }
 
-static struct mid_q_entry *
+static struct smb_message *
 cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 {
 	struct smb_hdr *buf = (struct smb_hdr *)buffer;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 
 	spin_lock(&server->mid_lock);
-	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
-		if (compare_mid(mid->mid, buf) &&
-		    mid->mid_state == MID_REQUEST_SUBMITTED &&
-		    le16_to_cpu(mid->command) == buf->Command) {
-			kref_get(&mid->refcount);
+	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
+		if (compare_mid(smb->mid, buf) &&
+		    smb->mid_state == MID_REQUEST_SUBMITTED &&
+		    le16_to_cpu(smb->command) == buf->Command) {
+			kref_get(&smb->refcount);
 			spin_unlock(&server->mid_lock);
-			return mid;
+			return smb;
 		}
 	}
 	spin_unlock(&server->mid_lock);
@@ -135,7 +135,7 @@ cifs_get_credits_field(struct TCP_Server_Info *server, const int optype)
 }
 
 static unsigned int
-cifs_get_credits(struct mid_q_entry *mid)
+cifs_get_credits(struct smb_message *smb)
 {
 	return 1;
 }
@@ -189,7 +189,7 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 	 * did not time out).
 	 */
 	while (cur_mid != last_mid) {
-		struct mid_q_entry *mid_entry;
+		struct smb_message *smb;
 		unsigned int num_mids;
 
 		collision = false;
@@ -197,10 +197,10 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 			cur_mid++;
 
 		num_mids = 0;
-		list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
+		list_for_each_entry(smb, &server->pending_mid_q, qhead) {
 			++num_mids;
-			if (mid_entry->mid == cur_mid &&
-			    mid_entry->mid_state == MID_REQUEST_SUBMITTED) {
+			if (smb->mid == cur_mid &&
+			    smb->mid_state == MID_REQUEST_SUBMITTED) {
 				/* This mid is in use, try a different one */
 				collision = true;
 				break;
@@ -385,22 +385,22 @@ cifs_downgrade_oplock(struct TCP_Server_Info *server,
 }
 
 static bool
-cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+cifs_check_trans2(struct smb_message *smb, struct TCP_Server_Info *server,
 		  char *buf, int malformed)
 {
 	if (malformed)
 		return false;
 	if (check2ndT2(buf) <= 0)
 		return false;
-	mid->multiRsp = true;
-	if (mid->resp_buf) {
+	smb->multiRsp = true;
+	if (smb->resp_buf) {
 		/* merge response - fix up 1st*/
-		malformed = coalesce_t2(buf, mid->resp_buf);
+		malformed = coalesce_t2(buf, smb->resp_buf);
 		if (malformed > 0)
 			return true;
 		/* All parts received or packet is malformed. */
-		mid->multiEnd = true;
-		dequeue_mid(mid, malformed);
+		smb->multiEnd = true;
+		dequeue_mid(smb, malformed);
 		return true;
 	}
 	if (!server->large_buf) {
@@ -408,8 +408,8 @@ cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		cifs_dbg(VFS, "1st trans2 resp needs bigbuf\n");
 	} else {
 		/* Have first buffer */
-		mid->resp_buf = buf;
-		mid->large_buf = true;
+		smb->resp_buf = buf;
+		smb->large_buf = true;
 		server->bigbuf = NULL;
 	}
 	return true;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 93ce9fc7b4a4..f1b0546c7858 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -839,14 +839,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __u64 persistent_fid,
 }
 
 int
-smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server)
+smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info *server)
 {
-	struct smb2_hdr *hdr = mid->resp_buf;
-	struct smb2_create_rsp *rsp = mid->resp_buf;
+	struct smb2_hdr *hdr = smb->resp_buf;
+	struct smb2_create_rsp *rsp = smb->resp_buf;
 	struct cifs_tcon *tcon;
 	int rc;
 
-	if ((mid->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command != SMB2_CREATE ||
+	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command != SMB2_CREATE ||
 	    hdr->Status != STATUS_SUCCESS)
 		return 0;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 1468c16ea9b8..a7ba4a77721e 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -226,9 +226,9 @@ smb2_get_credits_field(struct TCP_Server_Info *server, const int optype)
 }
 
 static unsigned int
-smb2_get_credits(struct mid_q_entry *mid)
+smb2_get_credits(struct smb_message *smb)
 {
-	return mid->credits_received;
+	return smb->credits_received;
 }
 
 static int
@@ -389,10 +389,10 @@ smb2_revert_current_mid(struct TCP_Server_Info *server, const unsigned int val)
 	spin_unlock(&server->mid_lock);
 }
 
-static struct mid_q_entry *
+static struct smb_message *
 __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 {
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	__u64 wire_mid = le64_to_cpu(shdr->MessageId);
 
@@ -402,30 +402,30 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 	}
 
 	spin_lock(&server->mid_lock);
-	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
-		if ((mid->mid == wire_mid) &&
-		    (mid->mid_state == MID_REQUEST_SUBMITTED) &&
-		    (mid->command == shdr->Command)) {
-			kref_get(&mid->refcount);
+	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
+		if ((smb->mid == wire_mid) &&
+		    (smb->mid_state == MID_REQUEST_SUBMITTED) &&
+		    (smb->command == shdr->Command)) {
+			kref_get(&smb->refcount);
 			if (dequeue) {
-				list_del_init(&mid->qhead);
-				mid->mid_flags |= MID_DELETED;
+				list_del_init(&smb->qhead);
+				smb->mid_flags |= MID_DELETED;
 			}
 			spin_unlock(&server->mid_lock);
-			return mid;
+			return smb;
 		}
 	}
 	spin_unlock(&server->mid_lock);
 	return NULL;
 }
 
-static struct mid_q_entry *
+static struct smb_message *
 smb2_find_mid(struct TCP_Server_Info *server, char *buf)
 {
 	return __smb2_find_mid(server, buf, false);
 }
 
-static struct mid_q_entry *
+static struct smb_message *
 smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
 {
 	return __smb2_find_mid(server, buf, true);
@@ -4611,7 +4611,7 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq, size_t data_size,
 }
 
 static int
-handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
+handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
 		 char *buf, unsigned int buf_len, struct folio_queue *buffer,
 		 unsigned int buffer_len, bool is_offloaded)
 {
@@ -4620,7 +4620,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = smb->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	int length;
 	bool use_rdma_mr = false;
@@ -4658,9 +4658,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			 __func__, rdata->result);
 		/* normal error on read response */
 		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_RECEIVED;
+			smb->mid_state = MID_RESPONSE_RECEIVED;
 		else
-			dequeue_mid(mid, false);
+			dequeue_mid(smb, false);
 		return 0;
 	}
 
@@ -4685,9 +4685,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			 __func__, data_offset);
 		rdata->result = -EIO;
 		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_MALFORMED;
+			smb->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(mid, rdata->result);
+			dequeue_mid(smb, rdata->result);
 		return 0;
 	}
 
@@ -4704,9 +4704,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 				 __func__, data_offset);
 			rdata->result = -EIO;
 			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
+				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(smb, rdata->result);
 			return 0;
 		}
 
@@ -4714,9 +4714,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			/* data_len is corrupt -- discard frame */
 			rdata->result = -EIO;
 			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
+				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(smb, rdata->result);
 			return 0;
 		}
 
@@ -4725,9 +4725,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 							 cur_off, &rdata->subreq.io_iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
+				smb->mid_state = MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(mid, rdata->result);
+				dequeue_mid(smb, rdata->result);
 			return 0;
 		}
 		rdata->got_bytes = buffer_len;
@@ -4744,16 +4744,16 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		WARN_ONCE(1, "buf can not contain only a part of read data");
 		rdata->result = -EIO;
 		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_MALFORMED;
+			smb->mid_state = MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(mid, rdata->result);
+			dequeue_mid(smb, rdata->result);
 		return 0;
 	}
 
 	if (is_offloaded)
-		mid->mid_state = MID_RESPONSE_RECEIVED;
+		smb->mid_state = MID_RESPONSE_RECEIVED;
 	else
-		dequeue_mid(mid, false);
+		dequeue_mid(smb, false);
 	return 0;
 }
 
@@ -4771,7 +4771,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	struct smb2_decrypt_work *dw = container_of(work,
 				struct smb2_decrypt_work, decrypt);
 	int rc;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 	struct iov_iter iter;
 
 	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
@@ -4783,43 +4783,43 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 	dw->server->lstrp = jiffies;
-	mid = smb2_find_dequeue_mid(dw->server, dw->buf);
-	if (mid == NULL)
+	smb = smb2_find_dequeue_mid(dw->server, dw->buf);
+	if (smb == NULL)
 		cifs_dbg(FYI, "mid not found\n");
 	else {
-		mid->decrypted = true;
-		rc = handle_read_data(dw->server, mid, dw->buf,
+		smb->decrypted = true;
+		rc = handle_read_data(dw->server, smb, dw->buf,
 				      dw->server->vals->read_rsp_size,
 				      dw->buffer, dw->len,
 				      true);
 		if (rc >= 0) {
 #ifdef CONFIG_CIFS_STATS2
-			mid->when_received = jiffies;
+			smb->when_received = jiffies;
 #endif
 			if (dw->server->ops->is_network_name_deleted)
 				dw->server->ops->is_network_name_deleted(dw->buf,
 									 dw->server);
 
-			mid->callback(mid);
+			smb->callback(smb);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus == CifsNeedReconnect) {
 				spin_lock(&dw->server->mid_lock);
-				mid->mid_state = MID_RETRY_NEEDED;
+				smb->mid_state = MID_RETRY_NEEDED;
 				spin_unlock(&dw->server->mid_lock);
 				spin_unlock(&dw->server->srv_lock);
-				mid->callback(mid);
+				smb->callback(smb);
 			} else {
 				spin_lock(&dw->server->mid_lock);
-				mid->mid_state = MID_REQUEST_SUBMITTED;
-				mid->mid_flags &= ~(MID_DELETED);
-				list_add_tail(&mid->qhead,
+				smb->mid_state = MID_REQUEST_SUBMITTED;
+				smb->mid_flags &= ~(MID_DELETED);
+				list_add_tail(&smb->qhead,
 					&dw->server->pending_mid_q);
 				spin_unlock(&dw->server->mid_lock);
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		release_mid(mid);
+		release_mid(smb);
 	}
 
 free_pages:
@@ -4830,7 +4830,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
 
 static int
-receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
+receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
 		       int *num_mids)
 {
 	char *buf = server->smallbuf;
@@ -4906,13 +4906,13 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	if (rc)
 		goto free_pages;
 
-	*mid = smb2_find_mid(server, buf);
-	if (*mid == NULL) {
+	*smb = smb2_find_mid(server, buf);
+	if (*smb == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
 	} else {
 		cifs_dbg(FYI, "mid found\n");
-		(*mid)->decrypted = true;
-		rc = handle_read_data(server, *mid, buf,
+		(*smb)->decrypted = true;
+		rc = handle_read_data(server, *smb, buf,
 				      server->vals->read_rsp_size,
 				      dw->buffer, dw->len, false);
 		if (rc >= 0) {
@@ -4935,7 +4935,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 
 static int
 receive_encrypted_standard(struct TCP_Server_Info *server,
-			   struct mid_q_entry **mids, char **bufs,
+			   struct smb_message **mids, char **bufs,
 			   int *num_mids)
 {
 	int ret, length;
@@ -4944,7 +4944,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
 	unsigned int next_cmd;
-	struct mid_q_entry *mid_entry;
+	struct smb_message *smb;
 	int next_is_large;
 	char *next_buffer = NULL;
 
@@ -4987,13 +4987,13 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
-	mid_entry = smb2_find_mid(server, buf);
-	if (mid_entry == NULL)
+	smb = smb2_find_mid(server, buf);
+	if (smb == NULL)
 		cifs_dbg(FYI, "mid not found\n");
 	else {
 		cifs_dbg(FYI, "mid found\n");
-		mid_entry->decrypted = true;
-		mid_entry->resp_buf_size = server->pdu_size;
+		smb->decrypted = true;
+		smb->resp_buf_size = server->pdu_size;
 	}
 
 	if (*num_mids >= MAX_COMPOUND) {
@@ -5001,12 +5001,12 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		return -1;
 	}
 	bufs[*num_mids] = buf;
-	mids[(*num_mids)++] = mid_entry;
+	mids[(*num_mids)++] = smb;
 
-	if (mid_entry && mid_entry->handle)
-		ret = mid_entry->handle(server, mid_entry);
+	if (smb && smb->handle)
+		ret = smb->handle(server, smb);
 	else
-		ret = cifs_handle_standard(server, mid_entry);
+		ret = cifs_handle_standard(server, smb);
 
 	if (ret == 0 && next_cmd) {
 		pdu_length -= next_cmd;
@@ -5034,7 +5034,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 
 static int
 smb3_receive_transform(struct TCP_Server_Info *server,
-		       struct mid_q_entry **mids, char **bufs, int *num_mids)
+		       struct smb_message **mids, char **bufs, int *num_mids)
 {
 	char *buf = server->smallbuf;
 	unsigned int pdu_length = server->pdu_size;
@@ -5064,11 +5064,11 @@ smb3_receive_transform(struct TCP_Server_Info *server,
 }
 
 int
-smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+smb3_handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	char *buf = server->large_buf ? server->bigbuf : server->smallbuf;
 
-	return handle_read_data(server, mid, buf, server->pdu_size,
+	return handle_read_data(server, smb, buf, server->pdu_size,
 				NULL, 0, false);
 }
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 96df4aa7a7af..645d67d04a8d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4089,19 +4089,19 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
  * FIXME: maybe we should consider checking that the reply matches request?
  */
 static void
-smb2_echo_callback(struct mid_q_entry *mid)
+smb2_echo_callback(struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = mid->callback_data;
-	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)mid->resp_buf;
+	struct TCP_Server_Info *server = smb->callback_data;
+	struct smb2_echo_rsp *rsp = (struct smb2_echo_rsp *)smb->resp_buf;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 
-	if (mid->mid_state == MID_RESPONSE_RECEIVED
-	    || mid->mid_state == MID_RESPONSE_MALFORMED) {
+	if (smb->mid_state == MID_RESPONSE_RECEIVED
+	    || smb->mid_state == MID_RESPONSE_MALFORMED) {
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
 	}
 
-	release_mid(mid);
+	release_mid(smb);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -4516,14 +4516,13 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 }
 
 static void
-smb2_readv_callback(struct mid_q_entry *mid)
+smb2_readv_callback(struct smb_message *smb)
 {
-	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = smb->callback_data;
 	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
-	struct smb2_hdr *shdr =
-				(struct smb2_hdr *)rdata->iov[0].iov_base;
+	struct smb2_hdr *shdr = (struct smb2_hdr *)rdata->iov[0].iov_base;
 	struct cifs_credits credits = {
 		.value = 0,
 		.instance = 0,
@@ -4538,20 +4537,20 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		rqst.rq_iter	  = rdata->subreq.io_iter;
 	}
 
-	WARN_ONCE(rdata->server != mid->server,
+	WARN_ONCE(rdata->server != smb->server,
 		  "rdata server %p != mid server %p",
-		  rdata->server, mid->server);
+		  rdata->server, smb->server);
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu/%zu\n",
-		 __func__, mid->mid, mid->mid_state, rdata->result,
+		 __func__, smb->mid, smb->mid_state, rdata->result,
 		 rdata->got_bytes, rdata->subreq.len - rdata->subreq.transferred);
 
-	switch (mid->mid_state) {
+	switch (smb->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		credits.value = le16_to_cpu(shdr->CreditRequest);
 		credits.instance = server->reconnect_instance;
 		/* result already set, check signature */
-		if (server->sign && !mid->decrypted) {
+		if (server->sign && !smb->decrypted) {
 			int rc;
 
 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
@@ -4641,7 +4640,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	rdata->subreq.transferred += rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(mid);
+	release_mid(smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_read_response_add);
@@ -4818,12 +4817,12 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
  * workqueue completion task.
  */
 static void
-smb2_writev_callback(struct mid_q_entry *mid)
+smb2_writev_callback(struct smb_message *smb)
 {
-	struct cifs_io_subrequest *wdata = mid->callback_data;
+	struct cifs_io_subrequest *wdata = smb->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = wdata->server;
-	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
+	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)smb->resp_buf;
 	struct cifs_credits credits = {
 		.value = 0,
 		.instance = 0,
@@ -4835,16 +4834,16 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	ssize_t result = 0;
 	size_t written;
 
-	WARN_ONCE(wdata->server != mid->server,
+	WARN_ONCE(wdata->server != smb->server,
 		  "wdata server %p != mid server %p",
-		  wdata->server, mid->server);
+		  wdata->server, smb->server);
 
-	switch (mid->mid_state) {
+	switch (smb->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
-		result = smb2_check_receive(mid, server, 0);
+		result = smb2_check_receive(smb, server, 0);
 		if (result != 0) {
 			trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_bad);
 			break;
@@ -4927,7 +4926,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written);
-	release_mid(mid);
+	release_mid(smb);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 035aa1624053..6f1ce0399334 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -30,12 +30,12 @@ extern __le16 *cifs_convert_path_to_utf16(const char *from,
 					  struct cifs_sb_info *cifs_sb);
 
 extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_Info *);
-extern int smb2_check_receive(struct mid_q_entry *mid,
+extern int smb2_check_receive(struct smb_message *smb,
 			      struct TCP_Server_Info *server, bool log_error);
-extern struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses,
+extern struct smb_message *smb2_setup_request(struct cifs_ses *ses,
 					      struct TCP_Server_Info *,
 					      struct smb_rqst *rqst);
-extern struct mid_q_entry *smb2_setup_async_request(
+extern struct smb_message *smb2_setup_async_request(
 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *server,
 						__u64 ses_id, __u32  tid);
@@ -50,7 +50,7 @@ extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
 extern bool smb2_is_valid_oplock_break(char *buffer,
 				       struct TCP_Server_Info *srv);
 extern int smb3_handle_read_data(struct TCP_Server_Info *server,
-				 struct mid_q_entry *mid);
+				 struct smb_message *smb);
 extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 				struct cifs_sb_info *cifs_sb, const char *path,
 				__u32 *reparse_tag);
@@ -257,7 +257,7 @@ extern int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 extern int smb2_handle_cancelled_close(struct cifs_tcon *tcon,
 				       __u64 persistent_fid,
 				       __u64 volatile_fid);
-extern int smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server);
+extern int smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info *server);
 void smb2_cancelled_close_fid(struct work_struct *work);
 extern int SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon *tcon,
 			 u64 persistent_file_id, u64 volatile_file_id,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 475b36c27f65..5348bfd5fad0 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -756,11 +756,11 @@ smb2_seq_num_into_buf(struct TCP_Server_Info *server,
 		get_next_mid(server);
 }
 
-static struct mid_q_entry *
+static struct smb_message *
 smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 		     struct TCP_Server_Info *server)
 {
-	struct mid_q_entry *temp;
+	struct smb_message *smb;
 	unsigned int credits = le16_to_cpu(shdr->CreditCharge);
 
 	if (server == NULL) {
@@ -768,36 +768,36 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 		return NULL;
 	}
 
-	temp = mempool_alloc(cifs_mid_poolp, GFP_NOFS);
-	memset(temp, 0, sizeof(struct mid_q_entry));
-	kref_init(&temp->refcount);
-	temp->mid = le64_to_cpu(shdr->MessageId);
-	temp->credits = credits > 0 ? credits : 1;
-	temp->pid = current->pid;
-	temp->command = shdr->Command; /* Always LE */
-	temp->when_alloc = jiffies;
-	temp->server = server;
+	smb = mempool_alloc(&smb_message_pool, GFP_NOFS);
+	memset(smb, 0, sizeof(*smb));
+	kref_init(&smb->refcount);
+	smb->mid = le64_to_cpu(shdr->MessageId);
+	smb->credits = credits > 0 ? credits : 1;
+	smb->pid = current->pid;
+	smb->command = shdr->Command; /* Always LE */
+	smb->when_alloc = jiffies;
+	smb->server = server;
 
 	/*
 	 * The default is for the mid to be synchronous, so the
 	 * default callback just wakes up the current task.
 	 */
 	get_task_struct(current);
-	temp->creator = current;
-	temp->callback = cifs_wake_up_task;
-	temp->callback_data = current;
+	smb->creator = current;
+	smb->callback = cifs_wake_up_task;
+	smb->callback_data = current;
 
 	atomic_inc(&mid_count);
-	temp->mid_state = MID_REQUEST_ALLOCATED;
+	smb->mid_state = MID_REQUEST_ALLOCATED;
 	trace_smb3_cmd_enter(le32_to_cpu(shdr->Id.SyncId.TreeId),
 			     le64_to_cpu(shdr->SessionId),
-			     le16_to_cpu(shdr->Command), temp->mid);
-	return temp;
+			     le16_to_cpu(shdr->Command), smb->mid);
+	return smb;
 }
 
 static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		   struct smb2_hdr *shdr, struct mid_q_entry **mid)
+		   struct smb2_hdr *shdr, struct smb_message **smb)
 {
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsExiting) {
@@ -837,18 +837,18 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	}
 	spin_unlock(&ses->ses_lock);
 
-	*mid = smb2_mid_entry_alloc(shdr, server);
-	if (*mid == NULL)
+	*smb = smb2_mid_entry_alloc(shdr, server);
+	if (*smb == NULL)
 		return -ENOMEM;
 	spin_lock(&server->mid_lock);
-	list_add_tail(&(*mid)->qhead, &server->pending_mid_q);
+	list_add_tail(&(*smb)->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
 
 	return 0;
 }
 
 int
-smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
+smb2_check_receive(struct smb_message *mid, struct TCP_Server_Info *server,
 		   bool log_error)
 {
 	unsigned int len = mid->resp_buf_size;
@@ -873,14 +873,14 @@ smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 	return map_smb2_to_linux_error(mid->resp_buf, log_error);
 }
 
-struct mid_q_entry *
+struct smb_message *
 smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb2_hdr *shdr =
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
+	struct smb_message *mid;
 
 	smb2_seq_num_into_buf(server, shdr);
 
@@ -900,13 +900,13 @@ smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	return mid;
 }
 
-struct mid_q_entry *
+struct smb_message *
 smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb2_hdr *shdr =
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus == CifsNeedNegotiate &&
@@ -918,8 +918,8 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	smb2_seq_num_into_buf(server, shdr);
 
-	mid = smb2_mid_entry_alloc(shdr, server);
-	if (mid == NULL) {
+	smb = smb2_mid_entry_alloc(shdr, server);
+	if (smb == NULL) {
 		revert_current_mid_from_hdr(server, shdr);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -927,11 +927,11 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		release_mid(mid);
+		release_mid(smb);
 		return ERR_PTR(rc);
 	}
 
-	return mid;
+	return smb;
 }
 
 int
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 68c73e22c3c9..a105e0ddf81a 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -31,42 +31,42 @@
 #include "compress.h"
 
 void
-cifs_wake_up_task(struct mid_q_entry *mid)
+cifs_wake_up_task(struct smb_message *smb)
 {
-	if (mid->mid_state == MID_RESPONSE_RECEIVED)
-		mid->mid_state = MID_RESPONSE_READY;
-	wake_up_process(mid->callback_data);
+	if (smb->mid_state == MID_RESPONSE_RECEIVED)
+		smb->mid_state = MID_RESPONSE_READY;
+	wake_up_process(smb->callback_data);
 }
 
 void __release_mid(struct kref *refcount)
 {
-	struct mid_q_entry *midEntry =
-			container_of(refcount, struct mid_q_entry, refcount);
+	struct smb_message *smb =
+			container_of(refcount, struct smb_message, refcount);
 #ifdef CONFIG_CIFS_STATS2
-	__le16 command = midEntry->server->vals->lock_cmd;
-	__u16 smb_cmd = le16_to_cpu(midEntry->command);
+	__le16 command = smb->server->vals->lock_cmd;
+	__u16 smb_cmd = le16_to_cpu(smb->command);
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
-	struct TCP_Server_Info *server = midEntry->server;
+	struct TCP_Server_Info *server = smb->server;
 
-	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
-	     midEntry->mid_state == MID_RESPONSE_READY) &&
+	if (smb->resp_buf && (smb->mid_flags & MID_WAIT_CANCELLED) &&
+	    (smb->mid_state == MID_RESPONSE_RECEIVED ||
+	     smb->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
-		server->ops->handle_cancelled_mid(midEntry, server);
+		server->ops->handle_cancelled_mid(smb, server);
 
-	midEntry->mid_state = MID_FREE;
+	smb->mid_state = MID_FREE;
 	atomic_dec(&mid_count);
-	if (midEntry->large_buf)
-		cifs_buf_release(midEntry->resp_buf);
+	if (smb->large_buf)
+		cifs_buf_release(smb->resp_buf);
 	else
-		cifs_small_buf_release(midEntry->resp_buf);
+		cifs_small_buf_release(smb->resp_buf);
 #ifdef CONFIG_CIFS_STATS2
 	now = jiffies;
-	if (now < midEntry->when_alloc)
+	if (now < smb->when_alloc)
 		cifs_server_dbg(VFS, "Invalid mid allocation time\n");
-	roundtrip_time = now - midEntry->when_alloc;
+	roundtrip_time = now - smb->when_alloc;
 
 	if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
 		if (atomic_read(&server->num_cmds[smb_cmd]) == 0) {
@@ -92,8 +92,8 @@ void __release_mid(struct kref *refcount)
 	 * checks
 	 */
 	if ((slow_rsp_threshold != 0) &&
-	    time_after(now, midEntry->when_alloc + (slow_rsp_threshold * HZ)) &&
-	    (midEntry->command != command)) {
+	    time_after(now, smb->when_alloc + (slow_rsp_threshold * HZ)) &&
+	    (smb->command != command)) {
 		/*
 		 * smb2slowcmd[NUMBER_OF_SMB2_COMMANDS] counts by command
 		 * NB: le16_to_cpu returns unsigned so can not be negative below
@@ -101,34 +101,35 @@ void __release_mid(struct kref *refcount)
 		if (smb_cmd < NUMBER_OF_SMB2_COMMANDS)
 			cifs_stats_inc(&server->smb2slowcmd[smb_cmd]);
 
-		trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid,
-			       midEntry->when_sent, midEntry->when_received);
+		trace_smb3_slow_rsp(smb_cmd, smb->mid, smb->pid,
+				    smb->when_sent, smb->when_received);
 		if (cifsFYI & CIFS_TIMER) {
 			pr_debug("slow rsp: cmd %d mid %llu",
-				 midEntry->command, midEntry->mid);
+				 smb->command, smb->mid);
 			cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
-				  now - midEntry->when_alloc,
-				  now - midEntry->when_sent,
-				  now - midEntry->when_received);
+				  now - smb->when_alloc,
+				  now - smb->when_sent,
+				  now - smb->when_received);
 		}
 	}
 #endif
-	put_task_struct(midEntry->creator);
+	put_task_struct(smb->creator);
 
-	mempool_free(midEntry, cifs_mid_poolp);
+	mempool_free(smb, &smb_message_pool);
 }
 
 void
-delete_mid(struct mid_q_entry *mid)
+delete_mid(struct smb_message *smb)
 {
-	spin_lock(&mid->server->mid_lock);
-	if (!(mid->mid_flags & MID_DELETED)) {
-		list_del_init(&mid->qhead);
-		mid->mid_flags |= MID_DELETED;
+	spin_lock(&smb->server->mid_lock);
+
+	if (!(smb->mid_flags & MID_DELETED)) {
+		list_del_init(&smb->qhead);
+		smb->mid_flags |= MID_DELETED;
 	}
-	spin_unlock(&mid->server->mid_lock);
+	spin_unlock(&smb->server->mid_lock);
 
-	release_mid(mid);
+	release_mid(smb);
 }
 
 /*
@@ -633,13 +634,13 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
 	return 0;
 }
 
-int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
+int wait_for_response(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	int error;
 
 	error = wait_event_state(server->response_q,
-				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
-				 midQ->mid_state != MID_RESPONSE_RECEIVED,
+				 smb->mid_state != MID_REQUEST_SUBMITTED &&
+				 smb->mid_state != MID_RESPONSE_RECEIVED,
 				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
@@ -653,12 +654,12 @@ int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
  */
 int
 cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
-		mid_receive_t *receive, mid_callback_t *callback,
-		mid_handle_t *handle, void *cbdata, const int flags,
+		mid_receive_t receive, mid_callback_t callback,
+		mid_handle_t handle, void *cbdata, const int flags,
 		const struct cifs_credits *exist_credits)
 {
 	int rc;
-	struct mid_q_entry *mid;
+	struct smb_message *smb;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 	unsigned int instance;
 	int optype;
@@ -687,35 +688,35 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 		return -EAGAIN;
 	}
 
-	mid = server->ops->setup_async_request(server, rqst);
-	if (IS_ERR(mid)) {
+	smb = server->ops->setup_async_request(server, rqst);
+	if (IS_ERR(smb)) {
 		cifs_server_unlock(server);
 		add_credits_and_wake_if(server, &credits, optype);
-		return PTR_ERR(mid);
+		return PTR_ERR(smb);
 	}
 
-	mid->receive = receive;
-	mid->callback = callback;
-	mid->callback_data = cbdata;
-	mid->handle = handle;
-	mid->mid_state = MID_REQUEST_SUBMITTED;
+	smb->receive = receive;
+	smb->callback = callback;
+	smb->callback_data = cbdata;
+	smb->handle = handle;
+	smb->mid_state = MID_REQUEST_SUBMITTED;
 
 	/* put it on the pending_mid_q */
 	spin_lock(&server->mid_lock);
-	list_add_tail(&mid->qhead, &server->pending_mid_q);
+	list_add_tail(&smb->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_lock);
 
 	/*
 	 * Need to store the time in mid before calling I/O. For call_async,
 	 * I/O response may come back and free the mid entry on another thread.
 	 */
-	cifs_save_when_sent(mid);
+	cifs_save_when_sent(smb);
 	rc = smb_send_rqst(server, 1, rqst, flags);
 
 	if (rc < 0) {
-		revert_current_mid(server, mid->credits);
+		revert_current_mid(server, smb->credits);
 		server->sequence_number -= 2;
-		delete_mid(mid);
+		delete_mid(smb);
 	}
 
 	cifs_server_unlock(server);
@@ -727,15 +728,15 @@ cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	return rc;
 }
 
-int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
+int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info *server)
 {
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: cmd=%d mid=%llu state=%d\n",
-		 __func__, le16_to_cpu(mid->command), mid->mid, mid->mid_state);
+		 __func__, le16_to_cpu(smb->command), smb->mid, smb->mid_state);
 
 	spin_lock(&server->mid_lock);
-	switch (mid->mid_state) {
+	switch (smb->mid_state) {
 	case MID_RESPONSE_READY:
 		spin_unlock(&server->mid_lock);
 		return rc;
@@ -749,53 +750,53 @@ int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server
 		rc = -EHOSTDOWN;
 		break;
 	case MID_RC:
-		rc = mid->mid_rc;
+		rc = smb->mid_rc;
 		break;
 	default:
-		if (!(mid->mid_flags & MID_DELETED)) {
-			list_del_init(&mid->qhead);
-			mid->mid_flags |= MID_DELETED;
+		if (!(smb->mid_flags & MID_DELETED)) {
+			list_del_init(&smb->qhead);
+			smb->mid_flags |= MID_DELETED;
 		}
 		spin_unlock(&server->mid_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
-			 __func__, mid->mid, mid->mid_state);
+			 __func__, smb->mid, smb->mid_state);
 		rc = -EIO;
 		goto sync_mid_done;
 	}
 	spin_unlock(&server->mid_lock);
 
 sync_mid_done:
-	release_mid(mid);
+	release_mid(smb);
 	return rc;
 }
 
 static void
-cifs_compound_callback(struct mid_q_entry *mid)
+cifs_compound_callback(struct smb_message *smb)
 {
-	struct TCP_Server_Info *server = mid->server;
+	struct TCP_Server_Info *server = smb->server;
 	struct cifs_credits credits = {
-		.value = server->ops->get_credits(mid),
+		.value = server->ops->get_credits(smb),
 		.instance = server->reconnect_instance,
 	};
 
-	add_credits(server, &credits, mid->optype);
+	add_credits(server, &credits, smb->optype);
 
-	if (mid->mid_state == MID_RESPONSE_RECEIVED)
-		mid->mid_state = MID_RESPONSE_READY;
+	if (smb->mid_state == MID_RESPONSE_RECEIVED)
+		smb->mid_state = MID_RESPONSE_READY;
 }
 
 static void
-cifs_compound_last_callback(struct mid_q_entry *mid)
+cifs_compound_last_callback(struct smb_message *smb)
 {
-	cifs_compound_callback(mid);
-	cifs_wake_up_task(mid);
+	cifs_compound_callback(smb);
+	cifs_wake_up_task(smb);
 }
 
 static void
-cifs_cancelled_callback(struct mid_q_entry *mid)
+cifs_cancelled_callback(struct smb_message *smb)
 {
-	cifs_compound_callback(mid);
-	release_mid(mid);
+	cifs_compound_callback(smb);
+	release_mid(smb);
 }
 
 /*
@@ -859,7 +860,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc = 0;
-	struct mid_q_entry *midQ[MAX_COMPOUND];
+	struct smb_message *smb[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] = {false};
 	struct cifs_credits credits[MAX_COMPOUND] = {
 		{ .value = 0, .instance = 0 }
@@ -925,35 +926,35 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	for (i = 0; i < num_rqst; i++) {
-		midQ[i] = server->ops->setup_request(ses, server, &rqst[i]);
-		if (IS_ERR(midQ[i])) {
+		smb[i] = server->ops->setup_request(ses, server, &rqst[i]);
+		if (IS_ERR(smb[i])) {
 			revert_current_mid(server, i);
 			for (j = 0; j < i; j++)
-				delete_mid(midQ[j]);
+				delete_mid(smb[j]);
 			cifs_server_unlock(server);
 
 			/* Update # of requests on wire to server */
 			for (j = 0; j < num_rqst; j++)
 				add_credits(server, &credits[j], optype);
-			return PTR_ERR(midQ[i]);
+			return PTR_ERR(smb[i]);
 		}
 
-		midQ[i]->mid_state = MID_REQUEST_SUBMITTED;
-		midQ[i]->optype = optype;
+		smb[i]->mid_state = MID_REQUEST_SUBMITTED;
+		smb[i]->optype = optype;
 		/*
 		 * Invoke callback for every part of the compound chain
 		 * to calculate credits properly. Wake up this thread only when
 		 * the last element is received.
 		 */
 		if (i < num_rqst - 1)
-			midQ[i]->callback = cifs_compound_callback;
+			smb[i]->callback = cifs_compound_callback;
 		else
-			midQ[i]->callback = cifs_compound_last_callback;
+			smb[i]->callback = cifs_compound_last_callback;
 	}
 	rc = smb_send_rqst(server, num_rqst, rqst, flags);
 
 	for (i = 0; i < num_rqst; i++)
-		cifs_save_when_sent(midQ[i]);
+		cifs_save_when_sent(smb[i]);
 
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
@@ -996,20 +997,20 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	spin_unlock(&ses->ses_lock);
 
 	for (i = 0; i < num_rqst; i++) {
-		rc = wait_for_response(server, midQ[i]);
+		rc = wait_for_response(server, smb[i]);
 		if (rc != 0)
 			break;
 	}
 	if (rc != 0) {
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
-				 midQ[i]->mid, le16_to_cpu(midQ[i]->command));
-			send_cancel(server, &rqst[i], midQ[i]);
+				 smb[i]->mid, le16_to_cpu(smb[i]->command));
+			send_cancel(server, &rqst[i], smb[i]);
 			spin_lock(&server->mid_lock);
-			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
-			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
-				midQ[i]->callback = cifs_cancelled_callback;
+			smb[i]->mid_flags |= MID_WAIT_CANCELLED;
+			if (smb[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    smb[i]->mid_state == MID_RESPONSE_RECEIVED) {
+				smb[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
 			}
@@ -1021,36 +1022,36 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		if (rc < 0)
 			goto out;
 
-		rc = cifs_sync_mid_result(midQ[i], server);
+		rc = cifs_sync_mid_result(smb[i], server);
 		if (rc != 0) {
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] = true;
 			goto out;
 		}
 
-		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_READY) {
+		if (!smb[i]->resp_buf ||
+		    smb[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
 		}
 
-		buf = (char *)midQ[i]->resp_buf;
+		buf = (char *)smb[i]->resp_buf;
 		resp_iov[i].iov_base = buf;
-		resp_iov[i].iov_len = midQ[i]->resp_buf_size +
+		resp_iov[i].iov_len = smb[i]->resp_buf_size +
 			HEADER_PREAMBLE_SIZE(server);
 
-		if (midQ[i]->large_buf)
+		if (smb[i]->large_buf)
 			resp_buf_type[i] = CIFS_LARGE_BUFFER;
 		else
 			resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
-		rc = server->ops->check_receive(midQ[i], server,
+		rc = server->ops->check_receive(smb[i], server,
 						     flags & CIFS_LOG_ERROR);
 
 		/* mark it so buf will not be freed by delete_mid */
 		if ((flags & CIFS_NO_RSP_BUF) == 0)
-			midQ[i]->resp_buf = NULL;
+			smb[i]->resp_buf = NULL;
 
 	}
 
@@ -1080,7 +1081,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	 */
 	for (i = 0; i < num_rqst; i++) {
 		if (!cancelled_mid[i])
-			delete_mid(midQ[i]);
+			delete_mid(smb[i]);
 	}
 
 	return rc;
@@ -1123,38 +1124,38 @@ cifs_discard_remaining_data(struct TCP_Server_Info *server)
 }
 
 static int
-__cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
+__cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *smb,
 		     bool malformed)
 {
 	int length;
 
 	length = cifs_discard_remaining_data(server);
-	dequeue_mid(mid, malformed);
-	mid->resp_buf = server->smallbuf;
+	dequeue_mid(smb, malformed);
+	smb->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
 }
 
 static int
-cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *smb)
 {
-	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = smb->callback_data;
 
-	return  __cifs_readv_discard(server, mid, rdata->result);
+	return  __cifs_readv_discard(server, smb, rdata->result);
 }
 
 int
-cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
+cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *smb)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = smb->callback_data;
 	char *buf = server->smallbuf;
 	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
 	bool use_rdma_mr = false;
 
 	cifs_dbg(FYI, "%s: mid=%llu offset=%llu bytes=%zu\n",
-		 __func__, mid->mid, rdata->subreq.start, rdata->subreq.len);
+		 __func__, smb->mid, rdata->subreq.start, rdata->subreq.len);
 
 	/*
 	 * read the rest of READ_RSP header (sans Data array), or whatever we
@@ -1199,7 +1200,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
 		/* normal error on read response */
-		return __cifs_readv_discard(server, mid, false);
+		return __cifs_readv_discard(server, smb, false);
 	}
 
 	/* Is there enough to get to the rest of the READ_RSP header? */
@@ -1208,7 +1209,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 			 __func__, server->total_read,
 			 server->vals->read_rsp_size);
 		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		return cifs_readv_discard(server, smb);
 	}
 
 	data_offset = server->ops->read_data_offset(buf) +
@@ -1227,7 +1228,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
 			 __func__, data_offset);
 		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		return cifs_readv_discard(server, smb);
 	}
 
 	cifs_dbg(FYI, "%s: total_read=%u data_offset=%u\n",
@@ -1251,7 +1252,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	if (!use_rdma_mr && (data_offset + data_len > buflen)) {
 		/* data_len is corrupt -- discard frame */
 		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		return cifs_readv_discard(server, smb);
 	}
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -1270,10 +1271,10 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 
 	/* discard anything left over */
 	if (server->total_read < buflen)
-		return cifs_readv_discard(server, mid);
+		return cifs_readv_discard(server, smb);
 
-	dequeue_mid(mid, false);
-	mid->resp_buf = server->smallbuf;
+	dequeue_mid(smb, false);
+	smb->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
 }


