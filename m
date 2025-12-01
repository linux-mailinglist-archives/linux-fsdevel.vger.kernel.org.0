Return-Path: <linux-fsdevel+bounces-70407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26598C9986F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 19C8E3452DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 23:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8028D850;
	Mon,  1 Dec 2025 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyYf7Jok"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3D288502
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630447; cv=none; b=L4cqkAE9q2nSy3MXeYfJwhipNIXmXPlv//j/5UF+eIzXzjCsy8tDDxeJ6vxgSVmDVs8nILCHZFncatyBsQtuF08/EEy7XPBkrk1fMskWSDgKRPtQFBRhsf1HBZIEDgrIrf50Ey9zTGoXaGh4yRG7OQ9Yko3Tuqp3v5+GluRy5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630447; c=relaxed/simple;
	bh=H369NedbiIRG68gpPI0s5nGpSt0zeTCRWwtVjbOUAsA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=owlht/W38/PxMnby5OyKxCsZwJRghMGNo9/Uu5qDBlearVozDsipcYYObn3zvf3VofP3oDQ7lpcwnB7RIEsX4h1yzkIaL7R9rhLoCgamBo0sOj9s1B384BJBdBpRz1wec6NfEKN5GCF1/73iuCQjojX7j3qj3qC+u6tHVw0INt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyYf7Jok; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764630441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4STDdYr75jyI2yFzikjkD1gzbwMxAaqcLnVkaRS6DGM=;
	b=DyYf7JokZB7+6V/oQOkhP3i+7mC8Jgmm3sRGuWA1jIJQoMWHGkFQWt3B3lO3yoEUscq1Ss
	rT4jHMSKluhB3KfwEe1/tCtbvyyCLGjjd1ppksTm3ERFR8DJYXAJqAV/HuVDsxIQW1WctF
	CJ+ZEWGDyR25YUVumY1fnwexSbhBpww=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-BT2e3KIgNyGD4FRHkNr0Dg-1; Mon,
 01 Dec 2025 18:07:17 -0500
X-MC-Unique: BT2e3KIgNyGD4FRHkNr0Dg-1
X-Mimecast-MFC-AGG-ID: BT2e3KIgNyGD4FRHkNr0Dg_1764630435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8672D19560A5;
	Mon,  1 Dec 2025 23:07:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B6D9195608E;
	Mon,  1 Dec 2025 23:07:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5msqbTY71hLk-OE1YNc7OxGU8x0JuwM8z-uEN6Xpsbh2=Q@mail.gmail.com>
References: <CAH2r5msqbTY71hLk-OE1YNc7OxGU8x0JuwM8z-uEN6Xpsbh2=Q@mail.gmail.com> <20251201094916.1418415-1-dhowells@redhat.com> <20251201094916.1418415-2-dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v5 1/9] cifs: Rename mid_q_entry to smb_message
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1520392.1764630430.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Dec 2025 23:07:10 +0000
Message-ID: <1520393.1764630430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Steve French <smfrench@gmail.com> wrote:

> I lean against the rename of the struct if it is going to still
> contain primarily the 'mid' (ie the 'multiplex identifier' - the thing
> used to track a request in flight).  The rest of the patch seems fine
> - but why do the extra rename of the struct if it is still primarily
> "the struct that tracks the info on the request in flight by its
> multiplex id" - wouldn't it be much smaller (and just as clear) if
> only the other part of this patch were included?  No strong opinions
> but could make the patch smaller and easier to review

I'm intending that the struct will become so much more than that.  It'll b=
e
used to convey the request block and parameters from the SMB marshalling c=
ode
(typically found in smb2pdu.c and cifssmb.c) down to the transmission laye=
r
and convey the response or error back up to the SMB marshalling code; it'l=
l be
used to chain requests together into compounds and coordinate encryption,
decryption and (de)compression across them.

But, for the moment, I've removed most of that patch, leaving just a bit t=
hat
normalises the definitions of the mid_*_t function pointers and posted it =
as
v6 of the patches.

Attached is a diff between v5 and v6 for reference.  The vast majority of
differences are unrenaming mid_q_entry and pointer variables (that got ren=
amed
to "smb"), though I did take the liberty of removing a couple of externs o=
n
functions that got modified.

David
---
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index 265832b8703e..2cb234d4bd2f 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -55,32 +55,33 @@ void cifs_dump_detail(void *buf, size_t buf_len, struc=
t TCP_Server_Info *server)
 void cifs_dump_mids(struct TCP_Server_Info *server)
 {
 #ifdef CONFIG_CIFS_DEBUG2
-	struct smb_message *smb;
+	struct mid_q_entry *mid_entry;
 =

 	if (server =3D=3D NULL)
 		return;
 =

 	cifs_dbg(VFS, "Dump pending requests:\n");
 	spin_lock(&server->mid_queue_lock);
-	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
+	list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
 		cifs_dbg(VFS, "State: %d Cmd: %d Pid: %d Cbdata: %p Mid %llu\n",
-			 smb->mid_state,
-			 le16_to_cpu(smb->command),
-			 smb->pid,
-			 smb->callback_data,
-			 smb->mid);
+			 mid_entry->mid_state,
+			 le16_to_cpu(mid_entry->command),
+			 mid_entry->pid,
+			 mid_entry->callback_data,
+			 mid_entry->mid);
 #ifdef CONFIG_CIFS_STATS2
 		cifs_dbg(VFS, "IsLarge: %d buf: %p time rcv: %ld now: %ld\n",
-			 smb->large_buf,
-			 smb->resp_buf,
-			 smb->when_received,
+			 mid_entry->large_buf,
+			 mid_entry->resp_buf,
+			 mid_entry->when_received,
 			 jiffies);
 #endif /* STATS2 */
 		cifs_dbg(VFS, "IsMult: %d IsEnd: %d\n",
-			 smb->multiRsp, smb->multiEnd);
-		if (smb->resp_buf) {
-			cifs_dump_detail(smb->resp_buf, smb->response_pdu_len, server);
-			cifs_dump_mem("existing buf: ", smb->resp_buf, 62);
+			 mid_entry->multiRsp, mid_entry->multiEnd);
+		if (mid_entry->resp_buf) {
+			cifs_dump_detail(mid_entry->resp_buf,
+					 mid_entry->response_pdu_len, server);
+			cifs_dump_mem("existing buf: ", mid_entry->resp_buf, 62);
 		}
 	}
 	spin_unlock(&server->mid_queue_lock);
@@ -405,7 +406,7 @@ static __always_inline const char *cipher_alg_str(__le=
16 cipher)
 =

 static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 {
-	struct smb_message *smb;
+	struct mid_q_entry *mid_entry;
 	struct TCP_Server_Info *server;
 	struct TCP_Server_Info *chan_server;
 	struct cifs_ses *ses;
@@ -726,13 +727,13 @@ static int cifs_debug_data_proc_show(struct seq_file=
 *m, void *v)
 				seq_printf(m, "\n\tServer ConnectionId: 0x%llx",
 					   chan_server->conn_id);
 				spin_lock(&chan_server->mid_queue_lock);
-				list_for_each_entry(smb, &chan_server->pending_mid_q, qhead) {
+				list_for_each_entry(mid_entry, &chan_server->pending_mid_q, qhead) {
 					seq_printf(m, "\n\t\tState: %d com: %d pid: %d cbdata: %p mid %llu",
-						   smb->mid_state,
-						   le16_to_cpu(smb->command),
-						   smb->pid,
-						   smb->callback_data,
-						   smb->mid);
+						   mid_entry->mid_state,
+						   le16_to_cpu(mid_entry->command),
+						   mid_entry->pid,
+						   mid_entry->callback_data,
+						   mid_entry->mid);
 				}
 				spin_unlock(&chan_server->mid_queue_lock);
 			}
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ab1f4bf3de92..00eef3a6dc0e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -437,13 +437,13 @@ static int cifs_permission(struct mnt_idmap *idmap,
 =

 static struct kmem_cache *cifs_inode_cachep;
 static struct kmem_cache *cifs_req_cachep;
-static struct kmem_cache *smb_message_cachep;
+static struct kmem_cache *cifs_mid_cachep;
 static struct kmem_cache *cifs_sm_req_cachep;
 static struct kmem_cache *cifs_io_request_cachep;
 static struct kmem_cache *cifs_io_subrequest_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
-mempool_t smb_message_pool;
+mempool_t cifs_mid_pool;
 mempool_t cifs_io_request_pool;
 mempool_t cifs_io_subrequest_pool;
 =

@@ -1836,27 +1836,27 @@ cifs_destroy_request_bufs(void)
 	kmem_cache_destroy(cifs_sm_req_cachep);
 }
 =

-static int init_smb_message(void)
+static int init_mids(void)
 {
-	smb_message_cachep =3D kmem_cache_create("cifs_smb_message",
-					       sizeof(struct smb_message), 0,
-					       SLAB_HWCACHE_ALIGN, NULL);
-	if (smb_message_cachep =3D=3D NULL)
+	cifs_mid_cachep =3D kmem_cache_create("cifs_mpx_ids",
+					    sizeof(struct mid_q_entry), 0,
+					    SLAB_HWCACHE_ALIGN, NULL);
+	if (cifs_mid_cachep =3D=3D NULL)
 		return -ENOMEM;
 =

 	/* 3 is a reasonable minimum number of simultaneous operations */
-	if (mempool_init_slab_pool(&smb_message_pool, 3, smb_message_cachep) < 0=
) {
-		kmem_cache_destroy(smb_message_cachep);
+	if (mempool_init_slab_pool(&cifs_mid_pool, 3, cifs_mid_cachep) < 0) {
+		kmem_cache_destroy(cifs_mid_cachep);
 		return -ENOMEM;
 	}
 =

 	return 0;
 }
 =

-static void destroy_smb_message(void)
+static void destroy_mids(void)
 {
-	mempool_exit(&smb_message_pool);
-	kmem_cache_destroy(smb_message_cachep);
+	mempool_exit(&cifs_mid_pool);
+	kmem_cache_destroy(cifs_mid_cachep);
 }
 =

 static int cifs_init_netfs(void)
@@ -2020,7 +2020,7 @@ init_cifs(void)
 	if (rc)
 		goto out_destroy_inodecache;
 =

-	rc =3D init_smb_message();
+	rc =3D init_mids();
 	if (rc)
 		goto out_destroy_netfs;
 =

@@ -2077,7 +2077,7 @@ init_cifs(void)
 #endif
 	cifs_destroy_request_bufs();
 out_destroy_mids:
-	destroy_smb_message();
+	destroy_mids();
 out_destroy_netfs:
 	cifs_destroy_netfs();
 out_destroy_inodecache:
@@ -2119,7 +2119,7 @@ exit_cifs(void)
 	dfs_cache_destroy();
 #endif
 	cifs_destroy_request_bufs();
-	destroy_smb_message();
+	destroy_mids();
 	cifs_destroy_netfs();
 	cifs_destroy_inodecache();
 	destroy_workqueue(deferredclose_wq);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 3dd25a68dd47..f9c1f553ffd0 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -294,7 +294,7 @@ struct smb_rqst {
 	struct folio_queue *rq_buffer;	/* Buffer for encryption */
 };
 =

-struct smb_message;
+struct mid_q_entry;
 struct TCP_Server_Info;
 struct cifsFileInfo;
 struct cifs_ses;
@@ -312,25 +312,25 @@ struct cifs_credits;
 =

 struct smb_version_operations {
 	int (*send_cancel)(struct cifs_ses *ses, struct TCP_Server_Info *server,
-			   struct smb_rqst *rqst, struct smb_message *smb,
+			   struct smb_rqst *rqst, struct mid_q_entry *mid,
 			   unsigned int xid);
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
 	/* setup request: allocate mid, sign message */
-	struct smb_message *(*setup_request)(struct cifs_ses *ses,
-					     struct TCP_Server_Info *server,
-					     struct smb_rqst *rqst);
+	struct mid_q_entry *(*setup_request)(struct cifs_ses *,
+					     struct TCP_Server_Info *,
+					     struct smb_rqst *);
 	/* setup async request: allocate mid, sign message */
-	struct smb_message *(*setup_async_request)(struct TCP_Server_Info *serve=
r,
-						   struct smb_rqst *rqst);
+	struct mid_q_entry *(*setup_async_request)(struct TCP_Server_Info *,
+						struct smb_rqst *);
 	/* check response: verify signature, map error */
-	int (*check_receive)(struct smb_message *mid, struct TCP_Server_Info *se=
rver,
-			     bool log_error);
+	int (*check_receive)(struct mid_q_entry *, struct TCP_Server_Info *,
+			     bool);
 	void (*add_credits)(struct TCP_Server_Info *server,
 			    struct cifs_credits *credits,
 			    const int optype);
 	void (*set_credits)(struct TCP_Server_Info *, const int);
 	int * (*get_credits_field)(struct TCP_Server_Info *, const int);
-	unsigned int (*get_credits)(struct smb_message *smb);
+	unsigned int (*get_credits)(struct mid_q_entry *);
 	__u64 (*get_next_mid)(struct TCP_Server_Info *);
 	void (*revert_current_mid)(struct TCP_Server_Info *server,
 				   const unsigned int val);
@@ -347,7 +347,7 @@ struct smb_version_operations {
 	/* map smb to linux error */
 	int (*map_error)(char *, bool);
 	/* find mid corresponding to the response message */
-	struct smb_message * (*find_mid)(struct TCP_Server_Info *server, char *b=
uf);
+	struct mid_q_entry *(*find_mid)(struct TCP_Server_Info *server, char *bu=
f);
 	void (*dump_detail)(void *buf, size_t buf_len, struct TCP_Server_Info *p=
tcp_info);
 	void (*clear_stats)(struct cifs_tcon *);
 	void (*print_stats)(struct seq_file *m, struct cifs_tcon *);
@@ -356,13 +356,13 @@ struct smb_version_operations {
 	int (*check_message)(char *buf, unsigned int pdu_len, unsigned int len,
 			     struct TCP_Server_Info *server);
 	bool (*is_oplock_break)(char *, struct TCP_Server_Info *);
-	int (*handle_cancelled_mid)(struct smb_message *smb, struct TCP_Server_I=
nfo *server);
+	int (*handle_cancelled_mid)(struct mid_q_entry *, struct TCP_Server_Info=
 *);
 	void (*downgrade_oplock)(struct TCP_Server_Info *server,
 				 struct cifsInodeInfo *cinode, __u32 oplock,
 				 __u16 epoch, bool *purge_cache);
 	/* process transaction2 response */
-	bool (*check_trans2)(struct smb_message *smb, struct TCP_Server_Info *se=
rver,
-			     char *buf, int malformed);
+	bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info *,
+			     char *, int);
 	/* check if we need to negotiate */
 	bool (*need_neg)(struct TCP_Server_Info *);
 	/* negotiate to the server */
@@ -596,7 +596,7 @@ struct smb_version_operations {
 				 struct smb_rqst *, struct smb_rqst *);
 	int (*is_transform_hdr)(void *buf);
 	int (*receive_transform)(struct TCP_Server_Info *,
-				 struct smb_message **smb, char **, int *);
+				 struct mid_q_entry **, char **, int *);
 	enum securityEnum (*select_sectype)(struct TCP_Server_Info *,
 			    enum securityEnum);
 	int (*next_header)(struct TCP_Server_Info *server, char *buf,
@@ -1661,7 +1661,7 @@ static inline void cifs_stats_bytes_read(struct cifs=
_tcon *tcon,
  * the TCP_Server_Info will also be updated.
  */
 typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
-			     struct smb_message *msg);
+			    struct mid_q_entry *mid);
 =

 /*
  * This is the prototype for the mid callback function. This is called on=
ce the
@@ -1671,17 +1671,17 @@ typedef int (*mid_receive_t)(struct TCP_Server_Inf=
o *server,
  * - it will be called by cifsd, with no locks held
  * - the mid will be removed from any lists
  */
-typedef void (*mid_callback_t)(struct TCP_Server_Info *srv, struct smb_me=
ssage *smb);
+typedef void (*mid_callback_t)(struct TCP_Server_Info *srv, struct mid_q_=
entry *mid);
 =

 /*
  * This is the protopyte for mid handle function. This is called once the=
 mid
  * has been recognized after decryption of the message.
  */
 typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
-			    struct smb_message *smb);
+			    struct mid_q_entry *mid);
 =

 /* one of these for every pending CIFS request to the server */
-struct smb_message {
+struct mid_q_entry {
 	struct list_head qhead;	/* mids waiting on reply from this server */
 	refcount_t refcount;
 	__u64 mid;		/* multiplex id */
@@ -1695,9 +1695,9 @@ struct smb_message {
 	unsigned long when_sent; /* time when smb send finished */
 	unsigned long when_received; /* when demux complete (taken off wire) */
 #endif
-	mid_receive_t receive; /* call receive callback */
+	mid_receive_t receive;	/* call receive callback */
 	mid_callback_t callback; /* call completion callback */
-	mid_handle_t handle; /* call handle mid callback */
+	mid_handle_t handle;	/* call handle mid callback */
 	void *callback_data;	  /* general purpose pointer for callback */
 	struct task_struct *creator;
 	void *resp_buf;		/* pointer to received SMB header */
@@ -1747,12 +1747,12 @@ static inline void cifs_num_waiters_dec(struct TCP=
_Server_Info *server)
 }
 =

 #ifdef CONFIG_CIFS_STATS2
-static inline void cifs_save_when_sent(struct smb_message *smb)
+static inline void cifs_save_when_sent(struct mid_q_entry *mid)
 {
-	smb->when_sent =3D jiffies;
+	mid->when_sent =3D jiffies;
 }
 #else
-static inline void cifs_save_when_sent(struct smb_message *smb)
+static inline void cifs_save_when_sent(struct mid_q_entry *mid)
 {
 }
 #endif
@@ -2108,7 +2108,7 @@ extern __u32 cifs_lock_secret;
 =

 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
-extern mempool_t smb_message_pool;
+extern mempool_t cifs_mid_pool;
 extern mempool_t cifs_io_request_pool;
 extern mempool_t cifs_io_subrequest_pool;
 =

@@ -2268,17 +2268,17 @@ static inline bool cifs_netbios_name(const char *n=
ame, size_t namelen)
  * and prevents sleeping in atomic context.
  */
 static inline void mid_execute_callback(struct TCP_Server_Info *server,
-					struct smb_message *smb)
+					struct mid_q_entry *mid)
 {
 	mid_callback_t callback;
 =

-	spin_lock(&smb->mid_lock);
-	callback =3D smb->callback;
-	smb->callback =3D NULL;  /* Mark as executed, */
-	spin_unlock(&smb->mid_lock);
+	spin_lock(&mid->mid_lock);
+	callback =3D mid->callback;
+	mid->callback =3D NULL;  /* Mark as executed, */
+	spin_unlock(&mid->mid_lock);
 =

 	if (callback)
-		callback(server, smb);
+		callback(server, mid);
 }
 =

 #define CIFS_REPARSE_SUPPORT(tcon) \
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 67de0d5fef6a..823ca4f36914 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -82,11 +82,11 @@ extern char *cifs_build_path_to_root(struct smb3_fs_co=
ntext *ctx,
 				     int add_treename);
 extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
 char *cifs_build_devname(char *nodename, const char *prepath);
-extern void delete_mid(struct TCP_Server_Info *server, struct smb_message=
 *smb);
-void __release_mid(struct TCP_Server_Info *server, struct smb_message *sm=
b);
-extern void cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_=
message *smb);
+void delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid);
+void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d);
+void cifs_wake_up_task(struct TCP_Server_Info *server, struct mid_q_entry=
 *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
-				struct smb_message *smb);
+				struct mid_q_entry *mid);
 extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
 				      char dirsep);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context=
 *ctx);
@@ -95,10 +95,10 @@ extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, s=
truct sockaddr *rhs);
 extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *=
rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
-			struct smb_rqst *rqst,
-			mid_receive_t receive, mid_callback_t callback,
-			mid_handle_t handle, void *cbdata, const int flags,
-			const struct cifs_credits *exist_credits);
+			   struct smb_rqst *rqst,
+			   mid_receive_t receive, mid_callback_t callback,
+			   mid_handle_t handle, void *cbdata, const int flags,
+			   const struct cifs_credits *exist_credits);
 extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
 extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			  struct TCP_Server_Info *server,
@@ -114,14 +114,14 @@ int SendReceive(const unsigned int xid, struct cifs_=
ses *ses,
 		struct smb_hdr *out_buf, int *pbytes_returned, const int flags);
 int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 		     char *in_buf, unsigned int in_len, int flags);
-int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info =
*server);
-struct smb_message *cifs_setup_request(struct cifs_ses *ses, struct TCP_S=
erver_Info *ignored,
+int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info =
*server);
+struct mid_q_entry *cifs_setup_request(struct cifs_ses *ses, struct TCP_S=
erver_Info *ignored,
 				       struct smb_rqst *rqst);
-struct smb_message *cifs_setup_async_request(struct TCP_Server_Info *serv=
er,
+struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *serv=
er,
 					     struct smb_rqst *rqst);
 int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		    struct smb_rqst *rqst);
-extern int cifs_check_receive(struct smb_message *msg,
+extern int cifs_check_receive(struct mid_q_entry *mid,
 			struct TCP_Server_Info *server, bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags=
,
 			  unsigned int *instance);
@@ -131,14 +131,14 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_I=
nfo *server,
 =

 static inline int
 send_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-	    struct smb_rqst *rqst, struct smb_message *smb,
+	    struct smb_rqst *rqst, struct mid_q_entry *mid,
 	    unsigned int xid)
 {
 	return server->ops->send_cancel ?
-		server->ops->send_cancel(ses, server, rqst, smb, xid) : 0;
+		server->ops->send_cancel(ses, server, rqst, mid, xid) : 0;
 }
 =

-int wait_for_response(struct TCP_Server_Info *server, struct smb_message =
*smb);
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry =
*midQ);
 extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
 			int * /* type of buf returned */, const int flags,
@@ -181,7 +181,7 @@ extern int cifs_convert_address(struct sockaddr *dst, =
const char *src, int len);
 extern void cifs_set_port(struct sockaddr *addr, const unsigned short int=
 port);
 extern int map_smb_to_linux_error(char *buf, bool logErr);
 extern int map_and_check_smb_error(struct TCP_Server_Info *server,
-				   struct smb_message *smb, bool logErr);
+				   struct mid_q_entry *mid, bool logErr);
 unsigned int header_assemble(struct smb_hdr *buffer, char smb_command,
 			     const struct cifs_tcon *treeCon, int word_count
 			     /* length of fixed section word count in two byte units  */);
@@ -264,7 +264,7 @@ extern unsigned int setup_special_mode_ACE(struct smb_=
ace *pace,
 					   __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 =

-void dequeue_mid(struct TCP_Server_Info *server, struct smb_message *smb,=
 bool malformed);
+void dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid,=
 bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *bu=
f,
 			         unsigned int to_read);
 extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
@@ -615,7 +615,7 @@ extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *=
ctx);
 =

 int cifs_async_readv(struct cifs_io_subrequest *rdata);
-int cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message=
 *smb);
+int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry=
 *mid);
 =

 void cifs_async_writev(struct cifs_io_subrequest *wdata);
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
@@ -763,15 +763,15 @@ static inline bool dfs_src_pathname_equal(const char=
 *s1, const char *s2)
 	return true;
 }
 =

-static inline void smb_get_mid(struct smb_message *smb)
+static inline void smb_get_mid(struct mid_q_entry *mid)
 {
-	refcount_inc(&smb->refcount);
+	refcount_inc(&mid->refcount);
 }
 =

-static inline void release_mid(struct TCP_Server_Info *server, struct smb=
_message *smb)
+static inline void release_mid(struct TCP_Server_Info *server, struct mid=
_q_entry *mid)
 {
-	if (refcount_dec_and_test(&smb->refcount))
-		__release_mid(server, smb);
+	if (refcount_dec_and_test(&mid->refcount))
+		__release_mid(server, mid);
 }
 =

 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 1c2f5767e045..defaf001e13f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -586,11 +586,11 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tcon=
 *tcon)
  * FIXME: maybe we should consider checking that the reply matches reques=
t?
  */
 static void
-cifs_echo_callback(struct TCP_Server_Info *server, struct smb_message *sm=
b)
+cifs_echo_callback(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d)
 {
 	struct cifs_credits credits =3D { .value =3D 1, .instance =3D 0 };
 =

-	release_mid(server, smb);
+	release_mid(server, mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 =

@@ -1319,9 +1319,9 @@ CIFS_open(const unsigned int xid, struct cifs_open_p=
arms *oparms, int *oplock,
 }
 =

 static void
-cifs_readv_callback(struct TCP_Server_Info *server, struct smb_message *s=
mb)
+cifs_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *m=
id)
 {
-	struct cifs_io_subrequest *rdata =3D smb->callback_data;
+	struct cifs_io_subrequest *rdata =3D mid->callback_data;
 	struct netfs_inode *ictx =3D netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon =3D tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst =3D { .rq_iov =3D rdata->iov,
@@ -1337,10 +1337,10 @@ cifs_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 	unsigned int subreq_debug_index =3D rdata->subreq.debug_index;
 =

 	cifs_dbg(FYI, "%s: mid=3D%llu state=3D%d result=3D%d bytes=3D%zu\n",
-		 __func__, smb->mid, smb->mid_state, rdata->result,
+		 __func__, mid->mid, mid->mid_state, rdata->result,
 		 rdata->subreq.len);
 =

-	switch (smb->mid_state) {
+	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		/* result already set, check signature */
 		if (server->sign) {
@@ -1348,7 +1348,7 @@ cifs_readv_callback(struct TCP_Server_Info *server, =
struct smb_message *smb)
 =

 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
 			rc =3D cifs_verify_signature(&rqst, server,
-						  smb->sequence_number);
+						  mid->sequence_number);
 			if (rc)
 				cifs_dbg(VFS, "SMB signature verification returned error =3D %d\n",
 					 rc);
@@ -1376,10 +1376,10 @@ cifs_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_malformed);
 		rdata->result =3D smb_EIO(smb_eio_trace_read_rsp_malformed);
 		break;
-	default:
+	default: =

 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
 		rdata->result =3D smb_EIO1(smb_eio_trace_read_mid_state_unknown,
-					 smb->mid_state);
+					 mid->mid_state);
 		break;
 	}
 =

@@ -1422,7 +1422,7 @@ cifs_readv_callback(struct TCP_Server_Info *server, =
struct smb_message *smb)
 	rdata->subreq.transferred +=3D rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(server, smb);
+	release_mid(server, mid);
 	add_credits(server, &credits, 0);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
@@ -1739,11 +1739,11 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_i=
o_parms *io_parms,
  * workqueue completion task.
  */
 static void
-cifs_writev_callback(struct TCP_Server_Info *server, struct smb_message *=
smb)
+cifs_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *=
mid)
 {
-	struct cifs_io_subrequest *wdata =3D smb->callback_data;
+	struct cifs_io_subrequest *wdata =3D mid->callback_data;
 	struct cifs_tcon *tcon =3D tlink_tcon(wdata->req->cfile->tlink);
-	WRITE_RSP *rsp =3D (WRITE_RSP *)smb->resp_buf;
+	WRITE_RSP *smb =3D (WRITE_RSP *)mid->resp_buf;
 	struct cifs_credits credits =3D {
 		.value =3D 1,
 		.instance =3D 0,
@@ -1753,15 +1753,15 @@ cifs_writev_callback(struct TCP_Server_Info *serve=
r, struct smb_message *smb)
 	ssize_t result;
 	size_t written;
 =

-	switch (smb->mid_state) {
+	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
-		result =3D cifs_check_receive(smb, tcon->ses->server, 0);
+		result =3D cifs_check_receive(mid, tcon->ses->server, 0);
 		if (result !=3D 0)
 			break;
 =

-		written =3D le16_to_cpu(rsp->CountHigh);
+		written =3D le16_to_cpu(smb->CountHigh);
 		written <<=3D 16;
-		written +=3D le16_to_cpu(rsp->Count);
+		written +=3D le16_to_cpu(smb->Count);
 		/*
 		 * Mask off high 16 bits when bytes written as returned
 		 * by the server is greater than bytes requested by the
@@ -1796,7 +1796,7 @@ cifs_writev_callback(struct TCP_Server_Info *server,=
 struct smb_message *smb)
 	default:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
 		result =3D smb_EIO1(smb_eio_trace_write_mid_state_unknown,
-				  smb->mid_state);
+				  mid->mid_state);
 		break;
 	}
 =

@@ -1806,7 +1806,7 @@ cifs_writev_callback(struct TCP_Server_Info *server,=
 struct smb_message *smb)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value =3D 0;
 	cifs_write_subrequest_terminated(wdata, result);
-	release_mid(server, smb);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index, 0=
,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index cfd877b0008a..28d1cee90625 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -33,44 +33,44 @@
 /* Max number of iovectors we can use off the stack when sending requests=
. */
 #define CIFS_MAX_IOV_SIZE 8
 =

-static struct smb_message *
+static struct mid_q_entry *
 alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *serve=
r)
 {
-	struct smb_message *smb;
+	struct mid_q_entry *temp;
 =

 	if (server =3D=3D NULL) {
 		cifs_dbg(VFS, "%s: null TCP session\n", __func__);
 		return NULL;
 	}
 =

-	smb =3D mempool_alloc(&smb_message_pool, GFP_NOFS);
-	memset(smb, 0, sizeof(struct smb_message));
-	refcount_set(&smb->refcount, 1);
-	spin_lock_init(&smb->mid_lock);
-	smb->mid =3D get_mid(smb_buffer);
-	smb->pid =3D current->pid;
-	smb->command =3D cpu_to_le16(smb_buffer->Command);
+	temp =3D mempool_alloc(&cifs_mid_pool, GFP_NOFS);
+	memset(temp, 0, sizeof(struct mid_q_entry));
+	refcount_set(&temp->refcount, 1);
+	spin_lock_init(&temp->mid_lock);
+	temp->mid =3D get_mid(smb_buffer);
+	temp->pid =3D current->pid;
+	temp->command =3D cpu_to_le16(smb_buffer->Command);
 	cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
 	/* easier to use jiffies */
 	/* when mid allocated can be before when sent */
-	smb->when_alloc =3D jiffies;
+	temp->when_alloc =3D jiffies;
 =

 	/*
 	 * The default is for the mid to be synchronous, so the
 	 * default callback just wakes up the current task.
 	 */
 	get_task_struct(current);
-	smb->creator =3D current;
-	smb->callback =3D cifs_wake_up_task;
-	smb->callback_data =3D current;
+	temp->creator =3D current;
+	temp->callback =3D cifs_wake_up_task;
+	temp->callback_data =3D current;
 =

 	atomic_inc(&mid_count);
-	smb->mid_state =3D MID_REQUEST_ALLOCATED;
-	return smb;
+	temp->mid_state =3D MID_REQUEST_ALLOCATED;
+	return temp;
 }
 =

 static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
-			struct smb_message **ppmidQ)
+			struct mid_q_entry **ppmidQ)
 {
 	spin_lock(&ses->ses_lock);
 	if (ses->ses_status =3D=3D SES_NEW) {
@@ -101,28 +101,28 @@ static int allocate_mid(struct cifs_ses *ses, struct=
 smb_hdr *in_buf,
 	return 0;
 }
 =

-struct smb_message *
+struct mid_q_entry *
 cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst =
*rqst)
 {
 	int rc;
 	struct smb_hdr *hdr =3D (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 =

 	/* enable signing if server requires it */
 	if (server->sign)
 		hdr->Flags2 |=3D SMBFLG2_SECURITY_SIGNATURE;
 =

-	smb =3D alloc_mid(hdr, server);
-	if (smb =3D=3D NULL)
+	mid =3D alloc_mid(hdr, server);
+	if (mid =3D=3D NULL)
 		return ERR_PTR(-ENOMEM);
 =

-	rc =3D cifs_sign_rqst(rqst, server, &smb->sequence_number);
+	rc =3D cifs_sign_rqst(rqst, server, &mid->sequence_number);
 	if (rc) {
-		release_mid(server, smb);
+		release_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 =

-	return smb;
+	return mid;
 }
 =

 /*
@@ -153,12 +153,12 @@ SendReceiveNoRsp(const unsigned int xid, struct cifs=
_ses *ses,
 }
 =

 int
-cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *serve=
r,
+cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *serve=
r,
 		   bool log_error)
 {
-	unsigned int len =3D smb->response_pdu_len;
+	unsigned int len =3D mid->response_pdu_len;
 =

-	dump_smb(smb->resp_buf, min_t(u32, 92, len));
+	dump_smb(mid->resp_buf, min_t(u32, 92, len));
 =

 	/* convert the length into a more usable form */
 	if (server->sign) {
@@ -167,37 +167,37 @@ cifs_check_receive(struct smb_message *smb, struct T=
CP_Server_Info *server,
 		struct smb_rqst rqst =3D { .rq_iov =3D iov,
 					 .rq_nvec =3D ARRAY_SIZE(iov) };
 =

-		iov[0].iov_base =3D smb->resp_buf;
+		iov[0].iov_base =3D mid->resp_buf;
 		iov[0].iov_len =3D len;
 		/* FIXME: add code to kill session */
 		rc =3D cifs_verify_signature(&rqst, server,
-					   smb->sequence_number);
+					   mid->sequence_number);
 		if (rc)
 			cifs_server_dbg(VFS, "SMB signature verification returned error =3D %d=
\n",
 				 rc);
 	}
 =

 	/* BB special case reconnect tid and uid here? */
-	return map_and_check_smb_error(server, smb, log_error);
+	return map_and_check_smb_error(server, mid, log_error);
 }
 =

-struct smb_message *
+struct mid_q_entry *
 cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb_hdr *hdr =3D (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 =

-	rc =3D allocate_mid(ses, hdr, &smb);
+	rc =3D allocate_mid(ses, hdr, &mid);
 	if (rc)
 		return ERR_PTR(rc);
-	rc =3D cifs_sign_rqst(rqst, server, &smb->sequence_number);
+	rc =3D cifs_sign_rqst(rqst, server, &mid->sequence_number);
 	if (rc) {
-		delete_mid(server, smb);
+		delete_mid(server, mid);
 		return ERR_PTR(rc);
 	}
-	return smb;
+	return mid;
 }
 =

 int
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index b6d1f2cf3edf..70e56d980ba8 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -293,7 +293,7 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Serve=
r_Info *server,
 static void
 cifs_abort_connection(struct TCP_Server_Info *server)
 {
-	struct smb_message *smb, *nsmb;
+	struct mid_q_entry *mid, *nmid;
 	struct list_head retry_list;
 =

 	server->maxBuf =3D 0;
@@ -324,21 +324,21 @@ cifs_abort_connection(struct TCP_Server_Info *server=
)
 	INIT_LIST_HEAD(&retry_list);
 	cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
 	spin_lock(&server->mid_queue_lock);
-	list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-		smb_get_mid(smb);
-		if (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED)
-			smb->mid_state =3D MID_RETRY_NEEDED;
-		list_move(&smb->qhead, &retry_list);
-		smb->deleted_from_q =3D true;
+	list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
+		smb_get_mid(mid);
+		if (mid->mid_state =3D=3D MID_REQUEST_SUBMITTED)
+			mid->mid_state =3D MID_RETRY_NEEDED;
+		list_move(&mid->qhead, &retry_list);
+		mid->deleted_from_q =3D true;
 	}
 	spin_unlock(&server->mid_queue_lock);
 	cifs_server_unlock(server);
 =

 	cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
-	list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
-		list_del_init(&smb->qhead);
-		mid_execute_callback(server, smb);
-		release_mid(server, smb);
+	list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
+		list_del_init(&mid->qhead);
+		mid_execute_callback(server, mid);
+		release_mid(server, mid);
 	}
 }
 =

@@ -868,7 +868,7 @@ is_smb_response(struct TCP_Server_Info *server, unsign=
ed char type)
 		    !server->with_rfc1001 &&
 		    server->rfc1001_sessinit !=3D 0) {
 			int rc, mid_rc;
-			struct smb_message *smb, *nsmb;
+			struct mid_q_entry *mid, *nmid;
 			LIST_HEAD(dispose_list);
 =

 			cifs_dbg(FYI, "RFC 1002 negative session response during SMB Negotiate=
, retrying with NetBIOS session\n");
@@ -881,10 +881,10 @@ is_smb_response(struct TCP_Server_Info *server, unsi=
gned char type)
 			 * corresponding to SMB1/SMB2 Negotiate packet.
 			 */
 			spin_lock(&server->mid_queue_lock);
-			list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead) {
-				smb_get_mid(smb);
-				list_move(&smb->qhead, &dispose_list);
-				smb->deleted_from_q =3D true;
+			list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead) {
+				smb_get_mid(mid);
+				list_move(&mid->qhead, &dispose_list);
+				mid->deleted_from_q =3D true;
 			}
 			spin_unlock(&server->mid_queue_lock);
 =

@@ -911,12 +911,12 @@ is_smb_response(struct TCP_Server_Info *server, unsi=
gned char type)
 			 * callback. Use MID_RC state which indicates that the
 			 * return code should be read from mid_rc member.
 			 */
-			list_for_each_entry_safe(smb, nsmb, &dispose_list, qhead) {
-				list_del_init(&smb->qhead);
-				smb->mid_rc =3D mid_rc;
-				smb->mid_state =3D MID_RC;
-				mid_execute_callback(server, smb);
-				release_mid(server, smb);
+			list_for_each_entry_safe(mid, nmid, &dispose_list, qhead) {
+				list_del_init(&mid->qhead);
+				mid->mid_rc =3D mid_rc;
+				mid->mid_state =3D MID_RC;
+				mid_execute_callback(server, mid);
+				release_mid(server, mid);
 			}
 =

 			/*
@@ -948,26 +948,26 @@ is_smb_response(struct TCP_Server_Info *server, unsi=
gned char type)
 }
 =

 void
-dequeue_mid(struct TCP_Server_Info *server, struct smb_message *smb, bool=
 malformed)
+dequeue_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid, bool=
 malformed)
 {
 #ifdef CONFIG_CIFS_STATS2
-	smb->when_received =3D jiffies;
+	mid->when_received =3D jiffies;
 #endif
 	spin_lock(&server->mid_queue_lock);
 	if (!malformed)
-		smb->mid_state =3D MID_RESPONSE_RECEIVED;
+		mid->mid_state =3D MID_RESPONSE_RECEIVED;
 	else
-		smb->mid_state =3D MID_RESPONSE_MALFORMED;
+		mid->mid_state =3D MID_RESPONSE_MALFORMED;
 	/*
 	 * Trying to handle/dequeue a mid after the send_recv()
 	 * function has finished processing it is a bug.
 	 */
-	if (smb->deleted_from_q) {
+	if (mid->deleted_from_q =3D=3D true) {
 		spin_unlock(&server->mid_queue_lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
 	} else {
-		list_del_init(&smb->qhead);
-		smb->deleted_from_q =3D true;
+		list_del_init(&mid->qhead);
+		mid->deleted_from_q =3D true;
 		spin_unlock(&server->mid_queue_lock);
 	}
 }
@@ -987,24 +987,24 @@ smb2_get_credits_from_hdr(char *buffer, struct TCP_S=
erver_Info *server)
 }
 =

 static void
-handle_mid(struct smb_message *smb, struct TCP_Server_Info *server,
+handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 	   char *buf, int malformed)
 {
 	if (server->ops->check_trans2 &&
-	    server->ops->check_trans2(smb, server, buf, malformed))
+	    server->ops->check_trans2(mid, server, buf, malformed))
 		return;
-	smb->credits_received =3D smb2_get_credits_from_hdr(buf, server);
-	smb->resp_buf =3D buf;
-	smb->large_buf =3D server->large_buf;
+	mid->credits_received =3D smb2_get_credits_from_hdr(buf, server);
+	mid->resp_buf =3D buf;
+	mid->large_buf =3D server->large_buf;
 	/* Was previous buf put in mpx struct for multi-rsp? */
-	if (!smb->multiRsp) {
+	if (!mid->multiRsp) {
 		/* smb buffer will be freed by user thread */
 		if (server->large_buf)
 			server->bigbuf =3D NULL;
 		else
 			server->smallbuf =3D NULL;
 	}
-	dequeue_mid(server, smb, malformed);
+	dequeue_mid(server, mid, malformed);
 }
 =

 int
@@ -1093,28 +1093,28 @@ clean_demultiplex_info(struct TCP_Server_Info *ser=
ver)
 	}
 =

 	if (!list_empty(&server->pending_mid_q)) {
-		struct smb_message *smb;
+		struct mid_q_entry *mid_entry;
 		struct list_head *tmp, *tmp2;
 		LIST_HEAD(dispose_list);
 =

 		spin_lock(&server->mid_queue_lock);
 		list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
-			smb =3D list_entry(tmp, struct smb_message, qhead);
-			cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
-			smb_get_mid(smb);
-			smb->mid_state =3D MID_SHUTDOWN;
-			list_move(&smb->qhead, &dispose_list);
-			smb->deleted_from_q =3D true;
+			mid_entry =3D list_entry(tmp, struct mid_q_entry, qhead);
+			cifs_dbg(FYI, "Clearing mid %llu\n", mid_entry->mid);
+			smb_get_mid(mid_entry);
+			mid_entry->mid_state =3D MID_SHUTDOWN;
+			list_move(&mid_entry->qhead, &dispose_list);
+			mid_entry->deleted_from_q =3D true;
 		}
 		spin_unlock(&server->mid_queue_lock);
 =

 		/* now walk dispose list and issue callbacks */
 		list_for_each_safe(tmp, tmp2, &dispose_list) {
-			smb =3D list_entry(tmp, struct smb_message, qhead);
-			cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
-			list_del_init(&smb->qhead);
-			mid_execute_callback(server, smb);
-			release_mid(server, smb);
+			mid_entry =3D list_entry(tmp, struct mid_q_entry, qhead);
+			cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
+			list_del_init(&mid_entry->qhead);
+			mid_execute_callback(server, mid_entry);
+			release_mid(server, mid_entry);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1148,7 +1148,7 @@ clean_demultiplex_info(struct TCP_Server_Info *serve=
r)
 }
 =

 static int
-standard_receive3(struct TCP_Server_Info *server, struct smb_message *smb=
)
+standard_receive3(struct TCP_Server_Info *server, struct mid_q_entry *mid=
)
 {
 	int length;
 	char *buf =3D server->smallbuf;
@@ -1178,11 +1178,11 @@ standard_receive3(struct TCP_Server_Info *server, =
struct smb_message *smb)
 =

 	dump_smb(buf, server->total_read);
 =

-	return cifs_handle_standard(server, smb);
+	return cifs_handle_standard(server, mid);
 }
 =

 int
-cifs_handle_standard(struct TCP_Server_Info *server, struct smb_message *=
smb)
+cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *=
mid)
 {
 	char *buf =3D server->large_buf ? server->bigbuf : server->smallbuf;
 	int rc;
@@ -1211,10 +1211,10 @@ cifs_handle_standard(struct TCP_Server_Info *serve=
r, struct smb_message *smb)
 	    server->ops->is_status_pending(buf, server))
 		return -1;
 =

-	if (!smb)
+	if (!mid)
 		return rc;
 =

-	handle_mid(smb, server, buf, rc);
+	handle_mid(mid, server, buf, rc);
 	return 0;
 }
 =

@@ -1251,13 +1251,13 @@ smb2_add_credits_from_hdr(char *buffer, struct TCP=
_Server_Info *server)
 static int
 cifs_demultiplex_thread(void *p)
 {
-	int i, num_smbs, length;
+	int i, num_mids, length;
 	struct TCP_Server_Info *server =3D p;
 	unsigned int pdu_length;
 	unsigned int next_offset;
 	char *buf =3D NULL;
 	struct task_struct *task_to_wake =3D NULL;
-	struct smb_message *smbs[MAX_COMPOUND];
+	struct mid_q_entry *mids[MAX_COMPOUND];
 	char *bufs[MAX_COMPOUND];
 	unsigned int noreclaim_flag, num_io_timeout =3D 0;
 	bool pending_reconnect =3D false;
@@ -1328,34 +1328,34 @@ cifs_demultiplex_thread(void *p)
 				server->pdu_size =3D next_offset;
 		}
 =

-		memset(smbs, 0, sizeof(smbs));
+		memset(mids, 0, sizeof(mids));
 		memset(bufs, 0, sizeof(bufs));
-		num_smbs =3D 0;
+		num_mids =3D 0;
 =

 		if (server->ops->is_transform_hdr &&
 		    server->ops->receive_transform &&
 		    server->ops->is_transform_hdr(buf)) {
 			length =3D server->ops->receive_transform(server,
-								smbs,
+								mids,
 								bufs,
-								&num_smbs);
+								&num_mids);
 		} else {
-			smbs[0] =3D server->ops->find_mid(server, buf);
+			mids[0] =3D server->ops->find_mid(server, buf);
 			bufs[0] =3D buf;
-			num_smbs =3D 1;
+			num_mids =3D 1;
 =

-			if (smbs[0])
-				smbs[0]->response_pdu_len =3D pdu_length;
-			if (!smbs[0] || !smbs[0]->receive)
-				length =3D standard_receive3(server, smbs[0]);
+			if (mids[0])
+				mids[0]->response_pdu_len =3D pdu_length;
+			if (!mids[0] || !mids[0]->receive)
+				length =3D standard_receive3(server, mids[0]);
 			else
-				length =3D smbs[0]->receive(server, smbs[0]);
+				length =3D mids[0]->receive(server, mids[0]);
 		}
 =

 		if (length < 0) {
-			for (i =3D 0; i < num_smbs; i++)
-				if (smbs[i])
-					release_mid(server, smbs[i]);
+			for (i =3D 0; i < num_mids; i++)
+				if (mids[i])
+					release_mid(server, mids[i]);
 			continue;
 		}
 =

@@ -1374,9 +1374,9 @@ cifs_demultiplex_thread(void *p)
 =

 		server->lstrp =3D jiffies;
 =

-		for (i =3D 0; i < num_smbs; i++) {
-			if (smbs[i] !=3D NULL) {
-				smbs[i]->resp_buf_size =3D server->pdu_size;
+		for (i =3D 0; i < num_mids; i++) {
+			if (mids[i] !=3D NULL) {
+				mids[i]->resp_buf_size =3D server->pdu_size;
 =

 				if (bufs[i] !=3D NULL) {
 					if (server->ops->is_network_name_deleted &&
@@ -1387,10 +1387,10 @@ cifs_demultiplex_thread(void *p)
 					}
 				}
 =

-				if (!smbs[i]->multiRsp || smbs[i]->multiEnd)
-					mid_execute_callback(server, smbs[i]);
+				if (!mids[i]->multiRsp || mids[i]->multiEnd)
+					mid_execute_callback(server, mids[i]);
 =

-				release_mid(server, smbs[i]);
+				release_mid(server, mids[i]);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
index 4a98b71288d6..ae15f0bef009 100644
--- a/fs/smb/client/netmisc.c
+++ b/fs/smb/client/netmisc.c
@@ -894,16 +894,16 @@ map_smb_to_linux_error(char *buf, bool logErr)
 =

 int
 map_and_check_smb_error(struct TCP_Server_Info *server,
-			struct smb_message *smb, bool logErr)
+			struct mid_q_entry *mid, bool logErr)
 {
 	int rc;
-	struct smb_hdr *rhdr =3D (struct smb_hdr *)smb->resp_buf;
+	struct smb_hdr *smb =3D (struct smb_hdr *)mid->resp_buf;
 =

-	rc =3D map_smb_to_linux_error((char *)rhdr, logErr);
-	if (rc =3D=3D -EACCES && !(rhdr->Flags2 & SMBFLG2_ERR_STATUS)) {
+	rc =3D map_smb_to_linux_error((char *)smb, logErr);
+	if (rc =3D=3D -EACCES && !(smb->Flags2 & SMBFLG2_ERR_STATUS)) {
 		/* possible ERRBaduid */
-		__u8 class =3D rhdr->Status.DosError.ErrorClass;
-		__u16 code =3D le16_to_cpu(rhdr->Status.DosError.Error);
+		__u8 class =3D smb->Status.DosError.ErrorClass;
+		__u16 code =3D le16_to_cpu(smb->Status.DosError.Error);
 =

 		/* switch can be used to handle different errors */
 		if (class =3D=3D ERRSRV && code =3D=3D ERRbaduid) {
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index bc179c8ad70d..53c77db552da 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -30,7 +30,7 @@
  */
 static int
 send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-	       struct smb_rqst *rqst, struct smb_message *smb,
+	       struct smb_rqst *rqst, struct mid_q_entry *mid,
 	       unsigned int xid)
 {
 	struct smb_hdr *in_buf =3D (struct smb_hdr *)rqst->rq_iov[0].iov_base;
@@ -47,7 +47,7 @@ send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_I=
nfo *server,
 	iov[0].iov_len  =3D sizeof(struct smb_hdr) + 2;
 =

 	cifs_server_lock(server);
-	rc =3D cifs_sign_rqst(&crqst, server, &smb->sequence_number);
+	rc =3D cifs_sign_rqst(&crqst, server, &mid->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
@@ -77,7 +77,7 @@ send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_I=
nfo *server,
  */
 static int
 send_lock_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		 struct smb_rqst *rqst, struct smb_message *smb,
+		 struct smb_rqst *rqst, struct mid_q_entry *mid,
 		 unsigned int xid)
 {
 	struct smb_hdr *in_buf =3D (struct smb_hdr *)rqst->rq_iov[0].iov_base;
@@ -103,12 +103,12 @@ send_lock_cancel(struct cifs_ses *ses, struct TCP_Se=
rver_Info *server,
 }
 =

 static int cifs_send_cancel(struct cifs_ses *ses, struct TCP_Server_Info =
*server,
-			    struct smb_rqst *rqst, struct smb_message *smb,
+			    struct smb_rqst *rqst, struct mid_q_entry *mid,
 			    unsigned int xid)
 {
-	if (smb->sr_flags & CIFS_WINDOWS_LOCK)
-		return send_lock_cancel(ses, server, rqst, smb, xid);
-	return send_nt_cancel(ses, server, rqst, smb, xid);
+	if (mid->sr_flags & CIFS_WINDOWS_LOCK)
+		return send_lock_cancel(ses, server, rqst, mid, xid);
+	return send_nt_cancel(ses, server, rqst, mid, xid);
 }
 =

 static bool
@@ -134,20 +134,20 @@ cifs_read_data_length(char *buf, bool in_remaining)
 	       le16_to_cpu(rsp->DataLength);
 }
 =

-static struct smb_message *
+static struct mid_q_entry *
 cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 {
 	struct smb_hdr *buf =3D (struct smb_hdr *)buffer;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 =

 	spin_lock(&server->mid_queue_lock);
-	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
-		if (compare_mid(smb->mid, buf) &&
-		    smb->mid_state =3D=3D MID_REQUEST_SUBMITTED &&
-		    le16_to_cpu(smb->command) =3D=3D buf->Command) {
-			smb_get_mid(smb);
+	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
+		if (compare_mid(mid->mid, buf) &&
+		    mid->mid_state =3D=3D MID_REQUEST_SUBMITTED &&
+		    le16_to_cpu(mid->command) =3D=3D buf->Command) {
+			smb_get_mid(mid);
 			spin_unlock(&server->mid_queue_lock);
-			return smb;
+			return mid;
 		}
 	}
 	spin_unlock(&server->mid_queue_lock);
@@ -181,7 +181,7 @@ cifs_get_credits_field(struct TCP_Server_Info *server,=
 const int optype)
 }
 =

 static unsigned int
-cifs_get_credits(struct smb_message *smb)
+cifs_get_credits(struct mid_q_entry *mid)
 {
 	return 1;
 }
@@ -234,7 +234,7 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 	 * did not time out).
 	 */
 	while (cur_mid !=3D last_mid) {
-		struct smb_message *smb;
+		struct mid_q_entry *mid_entry;
 		unsigned int num_mids;
 =

 		collision =3D false;
@@ -243,10 +243,10 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
 =

 		num_mids =3D 0;
 		spin_lock(&server->mid_queue_lock);
-		list_for_each_entry(smb, &server->pending_mid_q, qhead) {
+		list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
 			++num_mids;
-			if (smb->mid =3D=3D cur_mid &&
-			    smb->mid_state =3D=3D MID_REQUEST_SUBMITTED) {
+			if (mid_entry->mid =3D=3D cur_mid &&
+			    mid_entry->mid_state =3D=3D MID_REQUEST_SUBMITTED) {
 				/* This mid is in use, try a different one */
 				collision =3D true;
 				break;
@@ -432,22 +432,22 @@ cifs_downgrade_oplock(struct TCP_Server_Info *server=
,
 }
 =

 static bool
-cifs_check_trans2(struct smb_message *smb, struct TCP_Server_Info *server=
,
+cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server=
,
 		  char *buf, int malformed)
 {
 	if (malformed)
 		return false;
 	if (check2ndT2(buf) <=3D 0)
 		return false;
-	smb->multiRsp =3D true;
-	if (smb->resp_buf) {
+	mid->multiRsp =3D true;
+	if (mid->resp_buf) {
 		/* merge response - fix up 1st*/
-		malformed =3D coalesce_t2(buf, smb->resp_buf, &smb->response_pdu_len);
+		malformed =3D coalesce_t2(buf, mid->resp_buf, &mid->response_pdu_len);
 		if (malformed > 0)
 			return true;
 		/* All parts received or packet is malformed. */
-		smb->multiEnd =3D true;
-		dequeue_mid(server, smb, malformed);
+		mid->multiEnd =3D true;
+		dequeue_mid(server, mid, malformed);
 		return true;
 	}
 	if (!server->large_buf) {
@@ -455,8 +455,8 @@ cifs_check_trans2(struct smb_message *smb, struct TCP_=
Server_Info *server,
 		cifs_dbg(VFS, "1st trans2 resp needs bigbuf\n");
 	} else {
 		/* Have first buffer */
-		smb->resp_buf =3D buf;
-		smb->large_buf =3D true;
+		mid->resp_buf =3D buf;
+		mid->large_buf =3D true;
 		server->bigbuf =3D NULL;
 	}
 	return true;
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 84e6b01000c6..f3cb62d91450 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -852,14 +852,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, =
__u64 persistent_fid,
 }
 =

 int
-smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Info=
 *server)
+smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info=
 *server)
 {
-	struct smb2_hdr *hdr =3D smb->resp_buf;
-	struct smb2_create_rsp *rsp =3D smb->resp_buf;
+	struct smb2_hdr *hdr =3D mid->resp_buf;
+	struct smb2_create_rsp *rsp =3D mid->resp_buf;
 	struct cifs_tcon *tcon;
 	int rc;
 =

-	if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command !=3D SMB2_CR=
EATE ||
+	if ((mid->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command !=3D SMB2_CR=
EATE ||
 	    hdr->Status !=3D STATUS_SUCCESS)
 		return 0;
 =

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 9c830fff2c81..a16ded46b5a2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -226,9 +226,9 @@ smb2_get_credits_field(struct TCP_Server_Info *server,=
 const int optype)
 }
 =

 static unsigned int
-smb2_get_credits(struct smb_message *smb)
+smb2_get_credits(struct mid_q_entry *mid)
 {
-	return smb->credits_received;
+	return mid->credits_received;
 }
 =

 static int
@@ -389,10 +389,10 @@ smb2_revert_current_mid(struct TCP_Server_Info *serv=
er, const unsigned int val)
 	spin_unlock(&server->mid_counter_lock);
 }
 =

-static struct smb_message *
+static struct mid_q_entry *
 __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 {
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 	struct smb2_hdr *shdr =3D (struct smb2_hdr *)buf;
 	__u64 wire_mid =3D le64_to_cpu(shdr->MessageId);
 =

@@ -402,30 +402,30 @@ __smb2_find_mid(struct TCP_Server_Info *server, char=
 *buf, bool dequeue)
 	}
 =

 	spin_lock(&server->mid_queue_lock);
-	list_for_each_entry(smb, &server->pending_mid_q, qhead) {
-		if ((smb->mid =3D=3D wire_mid) &&
-		    (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED) &&
-		    (smb->command =3D=3D shdr->Command)) {
-			smb_get_mid(smb);
+	list_for_each_entry(mid, &server->pending_mid_q, qhead) {
+		if ((mid->mid =3D=3D wire_mid) &&
+		    (mid->mid_state =3D=3D MID_REQUEST_SUBMITTED) &&
+		    (mid->command =3D=3D shdr->Command)) {
+			smb_get_mid(mid);
 			if (dequeue) {
-				list_del_init(&smb->qhead);
-				smb->deleted_from_q =3D true;
+				list_del_init(&mid->qhead);
+				mid->deleted_from_q =3D true;
 			}
 			spin_unlock(&server->mid_queue_lock);
-			return smb;
+			return mid;
 		}
 	}
 	spin_unlock(&server->mid_queue_lock);
 	return NULL;
 }
 =

-static struct smb_message *
+static struct mid_q_entry *
 smb2_find_mid(struct TCP_Server_Info *server, char *buf)
 {
 	return __smb2_find_mid(server, buf, false);
 }
 =

-static struct smb_message *
+static struct mid_q_entry *
 smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
 {
 	return __smb2_find_mid(server, buf, true);
@@ -4676,7 +4676,7 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq,=
 size_t data_size,
 }
 =

 static int
-handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb,
+handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		 char *buf, unsigned int buf_len, struct folio_queue *buffer,
 		 unsigned int buffer_len, bool is_offloaded)
 {
@@ -4685,7 +4685,7 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_io_subrequest *rdata =3D smb->callback_data;
+	struct cifs_io_subrequest *rdata =3D mid->callback_data;
 	struct smb2_hdr *shdr =3D (struct smb2_hdr *)buf;
 	size_t copied;
 	bool use_rdma_mr =3D false;
@@ -4723,9 +4723,9 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 			 __func__, rdata->result);
 		/* normal error on read response */
 		if (is_offloaded)
-			smb->mid_state =3D MID_RESPONSE_RECEIVED;
+			mid->mid_state =3D MID_RESPONSE_RECEIVED;
 		else
-			dequeue_mid(server, smb, false);
+			dequeue_mid(server, mid, false);
 		return 0;
 	}
 =

@@ -4750,9 +4750,9 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 			 __func__, data_offset);
 		rdata->result =3D smb_EIO1(smb_eio_trace_rx_overlong, data_offset);
 		if (is_offloaded)
-			smb->mid_state =3D MID_RESPONSE_MALFORMED;
+			mid->mid_state =3D MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(server, smb, rdata->result);
+			dequeue_mid(server, mid, rdata->result);
 		return 0;
 	}
 =

@@ -4769,9 +4769,9 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 				 __func__, data_offset);
 			rdata->result =3D smb_EIO1(smb_eio_trace_rx_overpage, data_offset);
 			if (is_offloaded)
-				smb->mid_state =3D MID_RESPONSE_MALFORMED;
+				mid->mid_state =3D MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(server, smb, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 =

@@ -4779,9 +4779,9 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 			/* data_len is corrupt -- discard frame */
 			rdata->result =3D smb_EIO1(smb_eio_trace_rx_bad_datalen, data_len);
 			if (is_offloaded)
-				smb->mid_state =3D MID_RESPONSE_MALFORMED;
+				mid->mid_state =3D MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(server, smb, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 =

@@ -4790,9 +4790,9 @@ handle_read_data(struct TCP_Server_Info *server, str=
uct smb_message *smb,
 							 cur_off, &rdata->subreq.io_iter);
 		if (rdata->result !=3D 0) {
 			if (is_offloaded)
-				smb->mid_state =3D MID_RESPONSE_MALFORMED;
+				mid->mid_state =3D MID_RESPONSE_MALFORMED;
 			else
-				dequeue_mid(server, smb, rdata->result);
+				dequeue_mid(server, mid, rdata->result);
 			return 0;
 		}
 		rdata->got_bytes =3D buffer_len;
@@ -4809,16 +4809,16 @@ handle_read_data(struct TCP_Server_Info *server, s=
truct smb_message *smb,
 		WARN_ONCE(1, "buf can not contain only a part of read data");
 		rdata->result =3D smb_EIO(smb_eio_trace_rx_both_buf);
 		if (is_offloaded)
-			smb->mid_state =3D MID_RESPONSE_MALFORMED;
+			mid->mid_state =3D MID_RESPONSE_MALFORMED;
 		else
-			dequeue_mid(server, smb, rdata->result);
+			dequeue_mid(server, mid, rdata->result);
 		return 0;
 	}
 =

 	if (is_offloaded)
-		smb->mid_state =3D MID_RESPONSE_RECEIVED;
+		mid->mid_state =3D MID_RESPONSE_RECEIVED;
 	else
-		dequeue_mid(server, smb, false);
+		dequeue_mid(server, mid, false);
 	return 0;
 }
 =

@@ -4836,7 +4836,7 @@ static void smb2_decrypt_offload(struct work_struct =
*work)
 	struct smb2_decrypt_work *dw =3D container_of(work,
 				struct smb2_decrypt_work, decrypt);
 	int rc;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 	struct iov_iter iter;
 =

 	iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len);
@@ -4848,43 +4848,43 @@ static void smb2_decrypt_offload(struct work_struc=
t *work)
 	}
 =

 	dw->server->lstrp =3D jiffies;
-	smb =3D smb2_find_dequeue_mid(dw->server, dw->buf);
-	if (smb =3D=3D NULL)
+	mid =3D smb2_find_dequeue_mid(dw->server, dw->buf);
+	if (mid =3D=3D NULL)
 		cifs_dbg(FYI, "mid not found\n");
 	else {
-		smb->decrypted =3D true;
-		rc =3D handle_read_data(dw->server, smb, dw->buf,
+		mid->decrypted =3D true;
+		rc =3D handle_read_data(dw->server, mid, dw->buf,
 				      dw->server->vals->read_rsp_size,
 				      dw->buffer, dw->len,
 				      true);
 		if (rc >=3D 0) {
 #ifdef CONFIG_CIFS_STATS2
-			smb->when_received =3D jiffies;
+			mid->when_received =3D jiffies;
 #endif
 			if (dw->server->ops->is_network_name_deleted)
 				dw->server->ops->is_network_name_deleted(dw->buf,
 									 dw->server);
 =

-			mid_execute_callback(dw->server, smb);
+			mid_execute_callback(dw->server, mid);
 		} else {
 			spin_lock(&dw->server->srv_lock);
 			if (dw->server->tcpStatus =3D=3D CifsNeedReconnect) {
 				spin_lock(&dw->server->mid_queue_lock);
-				smb->mid_state =3D MID_RETRY_NEEDED;
+				mid->mid_state =3D MID_RETRY_NEEDED;
 				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
-				mid_execute_callback(dw->server, smb);
+				mid_execute_callback(dw->server, mid);
 			} else {
 				spin_lock(&dw->server->mid_queue_lock);
-				smb->mid_state =3D MID_REQUEST_SUBMITTED;
-				smb->deleted_from_q =3D false;
-				list_add_tail(&smb->qhead,
+				mid->mid_state =3D MID_REQUEST_SUBMITTED;
+				mid->deleted_from_q =3D false;
+				list_add_tail(&mid->qhead,
 					&dw->server->pending_mid_q);
 				spin_unlock(&dw->server->mid_queue_lock);
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		release_mid(dw->server, smb);
+		release_mid(dw->server, mid);
 	}
 =

 free_pages:
@@ -4895,7 +4895,7 @@ static void smb2_decrypt_offload(struct work_struct =
*work)
 =

 =

 static int
-receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message=
 **smb,
+receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry=
 **mid,
 		       int *num_mids)
 {
 	char *buf =3D server->smallbuf;
@@ -4971,13 +4971,13 @@ receive_encrypted_read(struct TCP_Server_Info *ser=
ver, struct smb_message **smb,
 	if (rc)
 		goto free_pages;
 =

-	*smb =3D smb2_find_mid(server, buf);
-	if (*smb =3D=3D NULL) {
+	*mid =3D smb2_find_mid(server, buf);
+	if (*mid =3D=3D NULL) {
 		cifs_dbg(FYI, "mid not found\n");
 	} else {
 		cifs_dbg(FYI, "mid found\n");
-		(*smb)->decrypted =3D true;
-		rc =3D handle_read_data(server, *smb, buf,
+		(*mid)->decrypted =3D true;
+		rc =3D handle_read_data(server, *mid, buf,
 				      server->vals->read_rsp_size,
 				      dw->buffer, dw->len, false);
 		if (rc >=3D 0) {
@@ -5000,7 +5000,7 @@ receive_encrypted_read(struct TCP_Server_Info *serve=
r, struct smb_message **smb,
 =

 static int
 receive_encrypted_standard(struct TCP_Server_Info *server,
-			   struct smb_message **mids, char **bufs,
+			   struct mid_q_entry **mids, char **bufs,
 			   int *num_mids)
 {
 	int ret, length;
@@ -5009,7 +5009,7 @@ receive_encrypted_standard(struct TCP_Server_Info *s=
erver,
 	unsigned int pdu_length =3D server->pdu_size;
 	unsigned int buf_size;
 	unsigned int next_cmd;
-	struct smb_message *smb;
+	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer =3D NULL;
 =

@@ -5052,13 +5052,13 @@ receive_encrypted_standard(struct TCP_Server_Info =
*server,
 		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 =

-	smb =3D smb2_find_mid(server, buf);
-	if (smb =3D=3D NULL)
+	mid_entry =3D smb2_find_mid(server, buf);
+	if (mid_entry =3D=3D NULL)
 		cifs_dbg(FYI, "mid not found\n");
 	else {
 		cifs_dbg(FYI, "mid found\n");
-		smb->decrypted =3D true;
-		smb->resp_buf_size =3D server->pdu_size;
+		mid_entry->decrypted =3D true;
+		mid_entry->resp_buf_size =3D server->pdu_size;
 	}
 =

 	if (*num_mids >=3D MAX_COMPOUND) {
@@ -5066,12 +5066,12 @@ receive_encrypted_standard(struct TCP_Server_Info =
*server,
 		return -1;
 	}
 	bufs[*num_mids] =3D buf;
-	mids[(*num_mids)++] =3D smb;
+	mids[(*num_mids)++] =3D mid_entry;
 =

-	if (smb && smb->handle)
-		ret =3D smb->handle(server, smb);
+	if (mid_entry && mid_entry->handle)
+		ret =3D mid_entry->handle(server, mid_entry);
 	else
-		ret =3D cifs_handle_standard(server, smb);
+		ret =3D cifs_handle_standard(server, mid_entry);
 =

 	if (ret =3D=3D 0 && next_cmd) {
 		pdu_length -=3D next_cmd;
@@ -5099,7 +5099,7 @@ receive_encrypted_standard(struct TCP_Server_Info *s=
erver,
 =

 static int
 smb3_receive_transform(struct TCP_Server_Info *server,
-		       struct smb_message **mids, char **bufs, int *num_mids)
+		       struct mid_q_entry **mids, char **bufs, int *num_mids)
 {
 	char *buf =3D server->smallbuf;
 	unsigned int pdu_length =3D server->pdu_size;
@@ -5129,11 +5129,11 @@ smb3_receive_transform(struct TCP_Server_Info *ser=
ver,
 }
 =

 int
-smb3_handle_read_data(struct TCP_Server_Info *server, struct smb_message =
*smb)
+smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry =
*mid)
 {
 	char *buf =3D server->large_buf ? server->bigbuf : server->smallbuf;
 =

-	return handle_read_data(server, smb, buf, server->pdu_size,
+	return handle_read_data(server, mid, buf, server->pdu_size,
 				NULL, 0, false);
 }
 =

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index ce56237928a0..2a822a5188aa 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4128,18 +4128,18 @@ SMB2_change_notify(const unsigned int xid, struct =
cifs_tcon *tcon,
  * FIXME: maybe we should consider checking that the reply matches reques=
t?
  */
 static void
-smb2_echo_callback(struct TCP_Server_Info *server, struct smb_message *sm=
b)
+smb2_echo_callback(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d)
 {
-	struct smb2_echo_rsp *rsp =3D (struct smb2_echo_rsp *)smb->resp_buf;
+	struct smb2_echo_rsp *rsp =3D (struct smb2_echo_rsp *)mid->resp_buf;
 	struct cifs_credits credits =3D { .value =3D 0, .instance =3D 0 };
 =

-	if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED
-	    || smb->mid_state =3D=3D MID_RESPONSE_MALFORMED) {
+	if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED
+	    || mid->mid_state =3D=3D MID_RESPONSE_MALFORMED) {
 		credits.value =3D le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance =3D server->reconnect_instance;
 	}
 =

-	release_mid(server, smb);
+	release_mid(server, mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 =

@@ -4554,9 +4554,9 @@ smb2_new_read_req(void **buf, unsigned int *total_le=
n,
 }
 =

 static void
-smb2_readv_callback(struct TCP_Server_Info *server, struct smb_message *s=
mb)
+smb2_readv_callback(struct TCP_Server_Info *server, struct mid_q_entry *m=
id)
 {
-	struct cifs_io_subrequest *rdata =3D smb->callback_data;
+	struct cifs_io_subrequest *rdata =3D mid->callback_data;
 	struct netfs_inode *ictx =3D netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon =3D tlink_tcon(rdata->req->cfile->tlink);
 	struct smb2_hdr *shdr =3D (struct smb2_hdr *)rdata->iov[0].iov_base;
@@ -4579,15 +4579,15 @@ smb2_readv_callback(struct TCP_Server_Info *server=
, struct smb_message *smb)
 		  rdata->server, server);
 =

 	cifs_dbg(FYI, "%s: mid=3D%llu state=3D%d result=3D%d bytes=3D%zu/%zu\n",
-		 __func__, smb->mid, smb->mid_state, rdata->result,
+		 __func__, mid->mid, mid->mid_state, rdata->result,
 		 rdata->got_bytes, rdata->subreq.len - rdata->subreq.transferred);
 =

-	switch (smb->mid_state) {
+	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		credits.value =3D le16_to_cpu(shdr->CreditRequest);
 		credits.instance =3D server->reconnect_instance;
 		/* result already set, check signature */
-		if (server->sign && !smb->decrypted) {
+		if (server->sign && !mid->decrypted) {
 			int rc;
 =

 			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
@@ -4624,7 +4624,7 @@ smb2_readv_callback(struct TCP_Server_Info *server, =
struct smb_message *smb)
 	default:
 		trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_unknown);
 		rdata->result =3D smb_EIO1(smb_eio_trace_read_mid_state_unknown,
-					 smb->mid_state);
+					 mid->mid_state);
 		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -4678,7 +4678,7 @@ smb2_readv_callback(struct TCP_Server_Info *server, =
struct smb_message *smb)
 	rdata->subreq.transferred +=3D rdata->got_bytes;
 	trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 	netfs_read_subreq_terminated(&rdata->subreq);
-	release_mid(server, smb);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_read_response_add);
@@ -4856,11 +4856,11 @@ SMB2_read(const unsigned int xid, struct cifs_io_p=
arms *io_parms,
  * workqueue completion task.
  */
 static void
-smb2_writev_callback(struct TCP_Server_Info *server, struct smb_message *=
smb)
+smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *=
mid)
 {
-	struct cifs_io_subrequest *wdata =3D smb->callback_data;
+	struct cifs_io_subrequest *wdata =3D mid->callback_data;
 	struct cifs_tcon *tcon =3D tlink_tcon(wdata->req->cfile->tlink);
-	struct smb2_write_rsp *rsp =3D (struct smb2_write_rsp *)smb->resp_buf;
+	struct smb2_write_rsp *rsp =3D (struct smb2_write_rsp *)mid->resp_buf;
 	struct cifs_credits credits =3D {
 		.value =3D 0,
 		.instance =3D 0,
@@ -4876,12 +4876,12 @@ smb2_writev_callback(struct TCP_Server_Info *serve=
r, struct smb_message *smb)
 		  "wdata server %p !=3D mid server %p",
 		  wdata->server, server);
 =

-	switch (smb->mid_state) {
+	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_progress);
 		credits.value =3D le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance =3D server->reconnect_instance;
-		result =3D smb2_check_receive(smb, server, 0);
+		result =3D smb2_check_receive(mid, server, 0);
 		if (result !=3D 0) {
 			trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_bad);
 			break;
@@ -4925,7 +4925,7 @@ smb2_writev_callback(struct TCP_Server_Info *server,=
 struct smb_message *smb)
 	default:
 		trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_unknown);
 		result =3D smb_EIO1(smb_eio_trace_write_mid_state_unknown,
-				  smb->mid_state);
+				  mid->mid_state);
 		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -4965,7 +4965,7 @@ smb2_writev_callback(struct TCP_Server_Info *server,=
 struct smb_message *smb)
 			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value =3D 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written);
-	release_mid(server, smb);
+	release_mid(server, mid);
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
 			      server->credits, server->in_flight,
 			      credits.value, cifs_trace_rw_credits_write_response_add);
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 1a5b65e0860a..152e888512aa 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -32,12 +32,12 @@ extern __le16 *cifs_convert_path_to_utf16(const char *=
from,
 					  struct cifs_sb_info *cifs_sb);
 =

 extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_Inf=
o *);
-extern int smb2_check_receive(struct smb_message *smb,
+extern int smb2_check_receive(struct mid_q_entry *mid,
 			      struct TCP_Server_Info *server, bool log_error);
-struct smb_message *smb2_setup_request(struct cifs_ses *ses,
-				       struct TCP_Server_Info *server,
-				       struct smb_rqst *rqst);
-extern struct smb_message *smb2_setup_async_request(
+extern struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses,
+					      struct TCP_Server_Info *,
+					      struct smb_rqst *rqst);
+extern struct mid_q_entry *smb2_setup_async_request(
 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *serve=
r,
 						__u64 ses_id, __u32  tid);
@@ -46,7 +46,7 @@ extern __le32 smb2_get_lease_state(struct cifsInodeInfo =
*cinode);
 extern bool smb2_is_valid_oplock_break(char *buffer,
 				       struct TCP_Server_Info *srv);
 extern int smb3_handle_read_data(struct TCP_Server_Info *server,
-				 struct smb_message *smb);
+				 struct mid_q_entry *mid);
 extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tco=
n *tcon,
 				struct cifs_sb_info *cifs_sb, const char *path,
 				__u32 *reparse_tag);
@@ -253,7 +253,7 @@ extern int SMB2_oplock_break(const unsigned int xid, s=
truct cifs_tcon *tcon,
 extern int smb2_handle_cancelled_close(struct cifs_tcon *tcon,
 				       __u64 persistent_fid,
 				       __u64 volatile_fid);
-extern int smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_=
Server_Info *server);
+extern int smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_=
Server_Info *server);
 void smb2_cancelled_close_fid(struct work_struct *work);
 extern int SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tcon=
 *tcon,
 			 u64 persistent_file_id, u64 volatile_file_id,
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index b5bd450d30a8..8b9000a83181 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -641,11 +641,11 @@ smb2_seq_num_into_buf(struct TCP_Server_Info *server=
,
 		get_next_mid(server);
 }
 =

-static struct smb_message *
+static struct mid_q_entry *
 smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 		     struct TCP_Server_Info *server)
 {
-	struct smb_message *smb;
+	struct mid_q_entry *temp;
 	unsigned int credits =3D le16_to_cpu(shdr->CreditCharge);
 =

 	if (server =3D=3D NULL) {
@@ -653,36 +653,36 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
 		return NULL;
 	}
 =

-	smb =3D mempool_alloc(&smb_message_pool, GFP_NOFS);
-	memset(smb, 0, sizeof(*smb));
-	refcount_set(&smb->refcount, 1);
-	spin_lock_init(&smb->mid_lock);
-	smb->mid =3D le64_to_cpu(shdr->MessageId);
-	smb->credits =3D credits > 0 ? credits : 1;
-	smb->pid =3D current->pid;
-	smb->command =3D shdr->Command; /* Always LE */
-	smb->when_alloc =3D jiffies;
+	temp =3D mempool_alloc(&cifs_mid_pool, GFP_NOFS);
+	memset(temp, 0, sizeof(struct mid_q_entry));
+	refcount_set(&temp->refcount, 1);
+	spin_lock_init(&temp->mid_lock);
+	temp->mid =3D le64_to_cpu(shdr->MessageId);
+	temp->credits =3D credits > 0 ? credits : 1;
+	temp->pid =3D current->pid;
+	temp->command =3D shdr->Command; /* Always LE */
+	temp->when_alloc =3D jiffies;
 =

 	/*
 	 * The default is for the mid to be synchronous, so the
 	 * default callback just wakes up the current task.
 	 */
 	get_task_struct(current);
-	smb->creator =3D current;
-	smb->callback =3D cifs_wake_up_task;
-	smb->callback_data =3D current;
+	temp->creator =3D current;
+	temp->callback =3D cifs_wake_up_task;
+	temp->callback_data =3D current;
 =

 	atomic_inc(&mid_count);
-	smb->mid_state =3D MID_REQUEST_ALLOCATED;
+	temp->mid_state =3D MID_REQUEST_ALLOCATED;
 	trace_smb3_cmd_enter(le32_to_cpu(shdr->Id.SyncId.TreeId),
 			     le64_to_cpu(shdr->SessionId),
-			     le16_to_cpu(shdr->Command), smb->mid);
-	return smb;
+			     le16_to_cpu(shdr->Command), temp->mid);
+	return temp;
 }
 =

 static int
 smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
-		   struct smb2_hdr *shdr, struct smb_message **smb)
+		   struct smb2_hdr *shdr, struct mid_q_entry **mid)
 {
 	switch (READ_ONCE(server->tcpStatus)) {
 	case CifsExiting:
@@ -714,18 +714,18 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_=
Server_Info *server,
 		break;
 	}
 =

-	*smb =3D smb2_mid_entry_alloc(shdr, server);
-	if (*smb =3D=3D NULL)
+	*mid =3D smb2_mid_entry_alloc(shdr, server);
+	if (*mid =3D=3D NULL)
 		return -ENOMEM;
 	spin_lock(&server->mid_queue_lock);
-	list_add_tail(&(*smb)->qhead, &server->pending_mid_q);
+	list_add_tail(&(*mid)->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_queue_lock);
 =

 	return 0;
 }
 =

 int
-smb2_check_receive(struct smb_message *mid, struct TCP_Server_Info *serve=
r,
+smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *serve=
r,
 		   bool log_error)
 {
 	unsigned int len =3D mid->resp_buf_size;
@@ -750,14 +750,14 @@ smb2_check_receive(struct smb_message *mid, struct T=
CP_Server_Info *server,
 	return map_smb2_to_linux_error(mid->resp_buf, log_error);
 }
 =

-struct smb_message *
+struct mid_q_entry *
 smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		   struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb2_hdr *shdr =3D
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *mid;
+	struct mid_q_entry *mid;
 =

 	smb2_seq_num_into_buf(server, shdr);
 =

@@ -777,13 +777,13 @@ smb2_setup_request(struct cifs_ses *ses, struct TCP_=
Server_Info *server,
 	return mid;
 }
 =

-struct smb_message *
+struct mid_q_entry *
 smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst =
*rqst)
 {
 	int rc;
 	struct smb2_hdr *shdr =3D
 			(struct smb2_hdr *)rqst->rq_iov[0].iov_base;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 =

 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus =3D=3D CifsNeedNegotiate &&
@@ -795,8 +795,8 @@ smb2_setup_async_request(struct TCP_Server_Info *serve=
r, struct smb_rqst *rqst)
 =

 	smb2_seq_num_into_buf(server, shdr);
 =

-	smb =3D smb2_mid_entry_alloc(shdr, server);
-	if (smb =3D=3D NULL) {
+	mid =3D smb2_mid_entry_alloc(shdr, server);
+	if (mid =3D=3D NULL) {
 		revert_current_mid_from_hdr(server, shdr);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -804,11 +804,11 @@ smb2_setup_async_request(struct TCP_Server_Info *ser=
ver, struct smb_rqst *rqst)
 	rc =3D smb2_sign_rqst(rqst, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		release_mid(server, smb);
+		release_mid(server, mid);
 		return ERR_PTR(rc);
 	}
 =

-	return smb;
+	return mid;
 }
 =

 int
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index ff034a0422c0..cb24659df134 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -32,39 +32,39 @@
 #include "compress.h"
 =

 void
-cifs_wake_up_task(struct TCP_Server_Info *server, struct smb_message *smb=
)
+cifs_wake_up_task(struct TCP_Server_Info *server, struct mid_q_entry *mid=
)
 {
-	if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED)
-		smb->mid_state =3D MID_RESPONSE_READY;
-	wake_up_process(smb->callback_data);
+	if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED)
+		mid->mid_state =3D MID_RESPONSE_READY;
+	wake_up_process(mid->callback_data);
 }
 =

-void __release_mid(struct TCP_Server_Info *server, struct smb_message *sm=
b)
+void __release_mid(struct TCP_Server_Info *server, struct mid_q_entry *mi=
dEntry)
 {
 #ifdef CONFIG_CIFS_STATS2
 	__le16 command =3D server->vals->lock_cmd;
-	__u16 smb_cmd =3D le16_to_cpu(smb->command);
+	__u16 smb_cmd =3D le16_to_cpu(midEntry->command);
 	unsigned long now;
 	unsigned long roundtrip_time;
 #endif
 =

-	if (smb->resp_buf && smb->wait_cancelled &&
-	    (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED ||
-	     smb->mid_state =3D=3D MID_RESPONSE_READY) &&
+	if (midEntry->resp_buf && (midEntry->wait_cancelled) &&
+	    (midEntry->mid_state =3D=3D MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state =3D=3D MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
-		server->ops->handle_cancelled_mid(smb, server);
+		server->ops->handle_cancelled_mid(midEntry, server);
 =

-	smb->mid_state =3D MID_FREE;
+	midEntry->mid_state =3D MID_FREE;
 	atomic_dec(&mid_count);
-	if (smb->large_buf)
-		cifs_buf_release(smb->resp_buf);
+	if (midEntry->large_buf)
+		cifs_buf_release(midEntry->resp_buf);
 	else
-		cifs_small_buf_release(smb->resp_buf);
+		cifs_small_buf_release(midEntry->resp_buf);
 #ifdef CONFIG_CIFS_STATS2
 	now =3D jiffies;
-	if (now < smb->when_alloc)
+	if (now < midEntry->when_alloc)
 		cifs_server_dbg(VFS, "Invalid mid allocation time\n");
-	roundtrip_time =3D now - smb->when_alloc;
+	roundtrip_time =3D now - midEntry->when_alloc;
 =

 	if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
 		if (atomic_read(&server->num_cmds[smb_cmd]) =3D=3D 0) {
@@ -90,8 +90,8 @@ void __release_mid(struct TCP_Server_Info *server, struc=
t smb_message *smb)
 	 * checks
 	 */
 	if ((slow_rsp_threshold !=3D 0) &&
-	    time_after(now, smb->when_alloc + (slow_rsp_threshold * HZ)) &&
-	    (smb->command !=3D command)) {
+	    time_after(now, midEntry->when_alloc + (slow_rsp_threshold * HZ)) &&
+	    (midEntry->command !=3D command)) {
 		/*
 		 * smb2slowcmd[NUMBER_OF_SMB2_COMMANDS] counts by command
 		 * NB: le16_to_cpu returns unsigned so can not be negative below
@@ -99,35 +99,35 @@ void __release_mid(struct TCP_Server_Info *server, str=
uct smb_message *smb)
 		if (smb_cmd < NUMBER_OF_SMB2_COMMANDS)
 			cifs_stats_inc(&server->smb2slowcmd[smb_cmd]);
 =

-		trace_smb3_slow_rsp(smb_cmd, smb->mid, smb->pid,
-				    smb->when_sent, smb->when_received);
+		trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid,
+			       midEntry->when_sent, midEntry->when_received);
 		if (cifsFYI & CIFS_TIMER) {
 			pr_debug("slow rsp: cmd %d mid %llu",
-				 smb->command, smb->mid);
+				 midEntry->command, midEntry->mid);
 			cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
-				  now - smb->when_alloc,
-				  now - smb->when_sent,
-				  now - smb->when_received);
+				  now - midEntry->when_alloc,
+				  now - midEntry->when_sent,
+				  now - midEntry->when_received);
 		}
 	}
 #endif
-	put_task_struct(smb->creator);
+	put_task_struct(midEntry->creator);
 =

-	mempool_free(smb, &smb_message_pool);
+	mempool_free(midEntry, &cifs_mid_pool);
 }
 =

 void
-delete_mid(struct TCP_Server_Info *server, struct smb_message *smb)
+delete_mid(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	spin_lock(&server->mid_queue_lock);
 =

-	if (!smb->deleted_from_q) {
-		list_del_init(&smb->qhead);
-		smb->deleted_from_q =3D true;
+	if (!mid->deleted_from_q) {
+		list_del_init(&mid->qhead);
+		mid->deleted_from_q =3D true;
 	}
 	spin_unlock(&server->mid_queue_lock);
 =

-	release_mid(server, smb);
+	release_mid(server, mid);
 }
 =

 /*
@@ -638,17 +638,17 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *server=
, size_t size,
 	return 0;
 }
 =

-int wait_for_response(struct TCP_Server_Info *server, struct smb_message =
*smb)
+int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry =
*mid)
 {
 	unsigned int sleep_state =3D TASK_KILLABLE;
 	int error;
 =

-	if (smb->sr_flags & CIFS_INTERRUPTIBLE_WAIT)
+	if (mid->sr_flags & CIFS_INTERRUPTIBLE_WAIT)
 		sleep_state =3D TASK_INTERRUPTIBLE;
 =

 	error =3D wait_event_state(server->response_q,
-				 smb->mid_state !=3D MID_REQUEST_SUBMITTED &&
-				 smb->mid_state !=3D MID_RESPONSE_RECEIVED,
+				 mid->mid_state !=3D MID_REQUEST_SUBMITTED &&
+				 mid->mid_state !=3D MID_RESPONSE_RECEIVED,
 				 (sleep_state | TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
@@ -667,7 +667,7 @@ cifs_call_async(struct TCP_Server_Info *server, struct=
 smb_rqst *rqst,
 		const struct cifs_credits *exist_credits)
 {
 	int rc;
-	struct smb_message *smb;
+	struct mid_q_entry *mid;
 	struct cifs_credits credits =3D { .value =3D 0, .instance =3D 0 };
 	unsigned int instance;
 	int optype;
@@ -696,36 +696,36 @@ cifs_call_async(struct TCP_Server_Info *server, stru=
ct smb_rqst *rqst,
 		return -EAGAIN;
 	}
 =

-	smb =3D server->ops->setup_async_request(server, rqst);
-	if (IS_ERR(smb)) {
+	mid =3D server->ops->setup_async_request(server, rqst);
+	if (IS_ERR(mid)) {
 		cifs_server_unlock(server);
 		add_credits_and_wake_if(server, &credits, optype);
-		return PTR_ERR(smb);
+		return PTR_ERR(mid);
 	}
 =

-	smb->sr_flags =3D flags;
-	smb->receive =3D receive;
-	smb->callback =3D callback;
-	smb->callback_data =3D cbdata;
-	smb->handle =3D handle;
-	smb->mid_state =3D MID_REQUEST_SUBMITTED;
+	mid->sr_flags =3D flags;
+	mid->receive =3D receive;
+	mid->callback =3D callback;
+	mid->callback_data =3D cbdata;
+	mid->handle =3D handle;
+	mid->mid_state =3D MID_REQUEST_SUBMITTED;
 =

 	/* put it on the pending_mid_q */
 	spin_lock(&server->mid_queue_lock);
-	list_add_tail(&smb->qhead, &server->pending_mid_q);
+	list_add_tail(&mid->qhead, &server->pending_mid_q);
 	spin_unlock(&server->mid_queue_lock);
 =

 	/*
 	 * Need to store the time in mid before calling I/O. For call_async,
 	 * I/O response may come back and free the mid entry on another thread.
 	 */
-	cifs_save_when_sent(smb);
+	cifs_save_when_sent(mid);
 	rc =3D smb_send_rqst(server, 1, rqst, flags);
 =

 	if (rc < 0) {
-		revert_current_mid(server, smb->credits);
+		revert_current_mid(server, mid->credits);
 		server->sequence_number -=3D 2;
-		delete_mid(server, smb);
+		delete_mid(server, mid);
 	}
 =

 	cifs_server_unlock(server);
@@ -737,15 +737,15 @@ cifs_call_async(struct TCP_Server_Info *server, stru=
ct smb_rqst *rqst,
 	return rc;
 }
 =

-int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info =
*server)
+int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info =
*server)
 {
 	int rc =3D 0;
 =

 	cifs_dbg(FYI, "%s: cmd=3D%d mid=3D%llu state=3D%d\n",
-		 __func__, le16_to_cpu(smb->command), smb->mid, smb->mid_state);
+		 __func__, le16_to_cpu(mid->command), mid->mid, mid->mid_state);
 =

 	spin_lock(&server->mid_queue_lock);
-	switch (smb->mid_state) {
+	switch (mid->mid_state) {
 	case MID_RESPONSE_READY:
 		spin_unlock(&server->mid_queue_lock);
 		return rc;
@@ -759,52 +759,52 @@ int cifs_sync_mid_result(struct smb_message *smb, st=
ruct TCP_Server_Info *server
 		rc =3D -EHOSTDOWN;
 		break;
 	case MID_RC:
-		rc =3D smb->mid_rc;
+		rc =3D mid->mid_rc;
 		break;
 	default:
-		if (smb->deleted_from_q =3D=3D false) {
-			list_del_init(&smb->qhead);
-			smb->deleted_from_q =3D true;
+		if (mid->deleted_from_q =3D=3D false) {
+			list_del_init(&mid->qhead);
+			mid->deleted_from_q =3D true;
 		}
 		spin_unlock(&server->mid_queue_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=3D%llu state=3D%d\n",
-			 __func__, smb->mid, smb->mid_state);
-		rc =3D smb_EIO1(smb_eio_trace_rx_sync_mid_invalid, smb->mid_state);
+			 __func__, mid->mid, mid->mid_state);
+		rc =3D smb_EIO1(smb_eio_trace_rx_sync_mid_invalid, mid->mid_state);
 		goto sync_mid_done;
 	}
 	spin_unlock(&server->mid_queue_lock);
 =

 sync_mid_done:
-	release_mid(server, smb);
+	release_mid(server, mid);
 	return rc;
 }
 =

 static void
-cifs_compound_callback(struct TCP_Server_Info *server, struct smb_message=
 *smb)
+cifs_compound_callback(struct TCP_Server_Info *server, struct mid_q_entry=
 *mid)
 {
 	struct cifs_credits credits =3D {
-		.value =3D server->ops->get_credits(smb),
+		.value =3D server->ops->get_credits(mid),
 		.instance =3D server->reconnect_instance,
 	};
 =

-	add_credits(server, &credits, smb->optype);
+	add_credits(server, &credits, mid->optype);
 =

-	if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED)
-		smb->mid_state =3D MID_RESPONSE_READY;
+	if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED)
+		mid->mid_state =3D MID_RESPONSE_READY;
 }
 =

 static void
-cifs_compound_last_callback(struct TCP_Server_Info *server, struct smb_me=
ssage *smb)
+cifs_compound_last_callback(struct TCP_Server_Info *server, struct mid_q_=
entry *mid)
 {
-	cifs_compound_callback(server, smb);
-	cifs_wake_up_task(server, smb);
+	cifs_compound_callback(server, mid);
+	cifs_wake_up_task(server, mid);
 }
 =

 static void
-cifs_cancelled_callback(struct TCP_Server_Info *server, struct smb_messag=
e *smb)
+cifs_cancelled_callback(struct TCP_Server_Info *server, struct mid_q_entr=
y *mid)
 {
-	cifs_compound_callback(server, smb);
-	release_mid(server, smb);
+	cifs_compound_callback(server, mid);
+	release_mid(server, mid);
 }
 =

 /*
@@ -868,7 +868,7 @@ compound_send_recv(const unsigned int xid, struct cifs=
_ses *ses,
 		   int *resp_buf_type, struct kvec *resp_iov)
 {
 	int i, j, optype, rc =3D 0;
-	struct smb_message *smb[MAX_COMPOUND];
+	struct mid_q_entry *mid[MAX_COMPOUND];
 	bool cancelled_mid[MAX_COMPOUND] =3D {false};
 	struct cifs_credits credits[MAX_COMPOUND] =3D {
 		{ .value =3D 0, .instance =3D 0 }
@@ -934,36 +934,36 @@ compound_send_recv(const unsigned int xid, struct ci=
fs_ses *ses,
 	}
 =

 	for (i =3D 0; i < num_rqst; i++) {
-		smb[i] =3D server->ops->setup_request(ses, server, &rqst[i]);
-		if (IS_ERR(smb[i])) {
+		mid[i] =3D server->ops->setup_request(ses, server, &rqst[i]);
+		if (IS_ERR(mid[i])) {
 			revert_current_mid(server, i);
 			for (j =3D 0; j < i; j++)
-				delete_mid(server, smb[j]);
+				delete_mid(server, mid[j]);
 			cifs_server_unlock(server);
 =

 			/* Update # of requests on wire to server */
 			for (j =3D 0; j < num_rqst; j++)
 				add_credits(server, &credits[j], optype);
-			return PTR_ERR(smb[i]);
+			return PTR_ERR(mid[i]);
 		}
 =

-		smb[i]->sr_flags =3D flags;
-		smb[i]->mid_state =3D MID_REQUEST_SUBMITTED;
-		smb[i]->optype =3D optype;
+		mid[i]->sr_flags =3D flags;
+		mid[i]->mid_state =3D MID_REQUEST_SUBMITTED;
+		mid[i]->optype =3D optype;
 		/*
 		 * Invoke callback for every part of the compound chain
 		 * to calculate credits properly. Wake up this thread only when
 		 * the last element is received.
 		 */
 		if (i < num_rqst - 1)
-			smb[i]->callback =3D cifs_compound_callback;
+			mid[i]->callback =3D cifs_compound_callback;
 		else
-			smb[i]->callback =3D cifs_compound_last_callback;
+			mid[i]->callback =3D cifs_compound_last_callback;
 	}
 	rc =3D smb_send_rqst(server, num_rqst, rqst, flags);
 =

 	for (i =3D 0; i < num_rqst; i++)
-		cifs_save_when_sent(smb[i]);
+		cifs_save_when_sent(mid[i]);
 =

 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
@@ -1009,24 +1009,24 @@ compound_send_recv(const unsigned int xid, struct =
cifs_ses *ses,
 	spin_unlock(&ses->ses_lock);
 =

 	for (i =3D 0; i < num_rqst; i++) {
-		rc =3D wait_for_response(server, smb[i]);
+		rc =3D wait_for_response(server, mid[i]);
 		if (rc !=3D 0)
 			break;
 	}
 	if (rc !=3D 0) {
 		for (; i < num_rqst; i++) {
 			cifs_server_dbg(FYI, "Cancelling wait for mid %llu cmd: %d\n",
-				 smb[i]->mid, le16_to_cpu(smb[i]->command));
-			send_cancel(ses, server, &rqst[i], smb[i], xid);
-			spin_lock(&smb[i]->mid_lock);
-			smb[i]->wait_cancelled =3D true;
-			if (smb[i]->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
-			    smb[i]->mid_state =3D=3D MID_RESPONSE_RECEIVED) {
-				smb[i]->callback =3D cifs_cancelled_callback;
+				 mid[i]->mid, le16_to_cpu(mid[i]->command));
+			send_cancel(ses, server, &rqst[i], mid[i], xid);
+			spin_lock(&mid[i]->mid_lock);
+			mid[i]->wait_cancelled =3D true;
+			if (mid[i]->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
+			    mid[i]->mid_state =3D=3D MID_RESPONSE_RECEIVED) {
+				mid[i]->callback =3D cifs_cancelled_callback;
 				cancelled_mid[i] =3D true;
 				credits[i].value =3D 0;
 			}
-			spin_unlock(&smb[i]->mid_lock);
+			spin_unlock(&mid[i]->mid_lock);
 		}
 	}
 =

@@ -1034,36 +1034,36 @@ compound_send_recv(const unsigned int xid, struct =
cifs_ses *ses,
 		if (rc < 0)
 			goto out;
 =

-		rc =3D cifs_sync_mid_result(smb[i], server);
+		rc =3D cifs_sync_mid_result(mid[i], server);
 		if (rc !=3D 0) {
 			/* mark this mid as cancelled to not free it below */
 			cancelled_mid[i] =3D true;
 			goto out;
 		}
 =

-		if (!smb[i]->resp_buf ||
-		    smb[i]->mid_state !=3D MID_RESPONSE_READY) {
-			rc =3D smb_EIO1(smb_eio_trace_rx_mid_unready, smb[i]->mid_state);
+		if (!mid[i]->resp_buf ||
+		    mid[i]->mid_state !=3D MID_RESPONSE_READY) {
+			rc =3D smb_EIO1(smb_eio_trace_rx_mid_unready, mid[i]->mid_state);
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
 		}
 =

-		rc =3D server->ops->check_receive(smb[i], server,
-						     flags & CIFS_LOG_ERROR);
+		rc =3D server->ops->check_receive(mid[i], server,
+						flags & CIFS_LOG_ERROR);
 =

 		if (resp_iov) {
-			buf =3D (char *)smb[i]->resp_buf;
+			buf =3D (char *)mid[i]->resp_buf;
 			resp_iov[i].iov_base =3D buf;
-			resp_iov[i].iov_len =3D smb[i]->resp_buf_size;
+			resp_iov[i].iov_len =3D mid[i]->resp_buf_size;
 =

-			if (smb[i]->large_buf)
+			if (mid[i]->large_buf)
 				resp_buf_type[i] =3D CIFS_LARGE_BUFFER;
 			else
 				resp_buf_type[i] =3D CIFS_SMALL_BUFFER;
 =

 			/* mark it so buf will not be freed by delete_mid */
 			if ((flags & CIFS_NO_RSP_BUF) =3D=3D 0)
-				smb[i]->resp_buf =3D NULL;
+				mid[i]->resp_buf =3D NULL;
 		}
 	}
 =

@@ -1093,7 +1093,7 @@ compound_send_recv(const unsigned int xid, struct ci=
fs_ses *ses,
 	 */
 	for (i =3D 0; i < num_rqst; i++) {
 		if (!cancelled_mid[i])
-			delete_mid(server, smb[i]);
+			delete_mid(server, mid[i]);
 	}
 =

 	return rc;
@@ -1136,38 +1136,38 @@ cifs_discard_remaining_data(struct TCP_Server_Info=
 *server)
 }
 =

 static int
-__cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *=
smb,
+__cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *=
mid,
 		     bool malformed)
 {
 	int length;
 =

 	length =3D cifs_discard_remaining_data(server);
-	dequeue_mid(server, smb, malformed);
-	smb->resp_buf =3D server->smallbuf;
+	dequeue_mid(server, mid, malformed);
+	mid->resp_buf =3D server->smallbuf;
 	server->smallbuf =3D NULL;
 	return length;
 }
 =

 static int
-cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *sm=
b)
+cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d)
 {
-	struct cifs_io_subrequest *rdata =3D smb->callback_data;
+	struct cifs_io_subrequest *rdata =3D mid->callback_data;
 =

-	return  __cifs_readv_discard(server, smb, rdata->result);
+	return  __cifs_readv_discard(server, mid, rdata->result);
 }
 =

 int
-cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *sm=
b)
+cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_io_subrequest *rdata =3D smb->callback_data;
+	struct cifs_io_subrequest *rdata =3D mid->callback_data;
 	char *buf =3D server->smallbuf;
 	unsigned int buflen =3D server->pdu_size;
 	bool use_rdma_mr =3D false;
 =

 	cifs_dbg(FYI, "%s: mid=3D%llu offset=3D%llu bytes=3D%zu\n",
-		 __func__, smb->mid, rdata->subreq.start, rdata->subreq.len);
+		 __func__, mid->mid, rdata->subreq.start, rdata->subreq.len);
 =

 	/*
 	 * read the rest of READ_RSP header (sans Data array), or whatever we
@@ -1207,7 +1207,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
 		/* normal error on read response */
-		return __cifs_readv_discard(server, smb, false);
+		return __cifs_readv_discard(server, mid, false);
 	}
 =

 	/* Is there enough to get to the rest of the READ_RSP header? */
@@ -1217,7 +1217,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 			 server->vals->read_rsp_size);
 		rdata->result =3D smb_EIO2(smb_eio_trace_read_rsp_short,
 					 server->total_read, server->vals->read_rsp_size);
-		return cifs_readv_discard(server, smb);
+		return cifs_readv_discard(server, mid);
 	}
 =

 	data_offset =3D server->ops->read_data_offset(buf);
@@ -1236,7 +1236,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 			 __func__, data_offset);
 		rdata->result =3D smb_EIO1(smb_eio_trace_read_overlarge,
 					 data_offset);
-		return cifs_readv_discard(server, smb);
+		return cifs_readv_discard(server, mid);
 	}
 =

 	cifs_dbg(FYI, "%s: total_read=3D%u data_offset=3D%u\n",
@@ -1261,7 +1261,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, s=
truct smb_message *smb)
 		/* data_len is corrupt -- discard frame */
 		rdata->result =3D smb_EIO2(smb_eio_trace_read_rsp_malformed,
 					 data_offset + data_len, buflen);
-		return cifs_readv_discard(server, smb);
+		return cifs_readv_discard(server, mid);
 	}
 =

 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -1280,10 +1280,10 @@ cifs_readv_receive(struct TCP_Server_Info *server,=
 struct smb_message *smb)
 =

 	/* discard anything left over */
 	if (server->total_read < buflen)
-		return cifs_readv_discard(server, smb);
+		return cifs_readv_discard(server, mid);
 =

-	dequeue_mid(server, smb, false);
-	smb->resp_buf =3D server->smallbuf;
+	dequeue_mid(server, mid, false);
+	mid->resp_buf =3D server->smallbuf;
 	server->smallbuf =3D NULL;
 	return length;
 }


