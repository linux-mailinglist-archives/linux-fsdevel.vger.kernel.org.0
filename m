Return-Path: <linux-fsdevel+bounces-16123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A9898B94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5861F21AA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DFA12AACB;
	Thu,  4 Apr 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9axgGGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293D9129E7C
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245900; cv=none; b=cTESnxC9LWStVwykbcwX+ZKC7hR7AkaYqjqfvMG+nrpXOVKU4a5eITFdusZ4gSZhsOHTjmQ+1oaMWmHdAYHh0iQuJBZxE3wzto3xJHG0x95+dX5hQZ+mMAhEyGxZUPxzY+EFi2YykQp5dR6BLpwwjm8NPP8OziUwfZAg3De4U+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245900; c=relaxed/simple;
	bh=nehAKTrSDrdVBevsMV13ZNWgWWF3C3SQ7HSog+0L+Ls=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=cfprmY2l3W5zqQHUSiYPmdEZlAG/XR/b5G6FaUR49mCNr7gMZxFrMFHddDsQa+fosUfM4NNozQq10Blw/rd5USEzxGElRGADgwT3Sag/7lPi8Ol+rj3BGu1n0X4X/Dq1AqbRAKm/tFin4BSv4gbez6X+RxmKOhawF1hZlP5iy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9axgGGu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712245897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WOWBnjTRQirIGLjv7S+UJJrjebfxgFhXIRZTGqOVSMA=;
	b=U9axgGGuZG15KaGaxQ/5tZpBsRK7IwqaWrXiAgj9I6gnCaFPWv14FZfEMvvOckvB9LtmWn
	yVZy5jRNKn/pwFh5TLXuq7NwKNHUn4gFmMAbPOFiymeIempmHPCff6JUbV6CHTAvkfJk2S
	rBhwxi/ouaZD1gWYcu194uuh6uyTbMI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-nkFRXYNsO1SZ02h86ZmVYw-1; Thu,
 04 Apr 2024 11:51:32 -0400
X-MC-Unique: nkFRXYNsO1SZ02h86ZmVYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 453BB3C00088;
	Thu,  4 Apr 2024 15:51:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1EC0A40C6CB3;
	Thu,  4 Apr 2024 15:51:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Add tracing for the cifs_tcon struct refcounting
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3781553.1712245869.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 16:51:09 +0100
Message-ID: <3781554.1712245869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add tracing for the refcounting/lifecycle of the cifs_tcon struct, marking
different events with different labels and giving each tcon its own debug
ID so that the tracelines corresponding to individual tcons can be
distinguished.  This can be enabled with:

        echo 1 >/sys/kernel/debug/tracing/events/cifs/smb3_tcon_ref/enable

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Paulo Alcantara <pc@manguebit.com>
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.c        |    2 =

 fs/smb/client/cifsglob.h      |    1 =

 fs/smb/client/cifsproto.h     |    9 +---
 fs/smb/client/connect.c       |   21 +++++----
 fs/smb/client/fscache.c       |    7 +++
 fs/smb/client/misc.c          |   10 +++-
 fs/smb/client/smb2misc.c      |   10 +++-
 fs/smb/client/smb2ops.c       |    7 ++-
 fs/smb/client/smb2pdu.c       |    8 ++-
 fs/smb/client/smb2transport.c |    2 =

 fs/smb/client/trace.h         |   92 ++++++++++++++++++++++++++++++++++++=
+++++-
 11 files changed, 143 insertions(+), 26 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index aa6f1ecb7c0e..b4b837594352 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -738,6 +738,8 @@ static void cifs_umount_begin(struct super_block *sb)
 =

 	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&tcon->tc_lock);
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+			    netfs_trace_tcon_ref_see_umount);
 	if ((tcon->tc_count > 1) || (tcon->status =3D=3D TID_EXITING)) {
 		/* we have other mounts to same share or we have
 		   already tried to umount this and woken up
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7ed9d05f6890..a0767174f29b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1189,6 +1189,7 @@ struct cifs_fattr {
  */
 struct cifs_tcon {
 	struct list_head tcon_list;
+	int debug_id;		/* Debugging for tracing */
 	int tc_count;
 	struct list_head rlist; /* reconnect list */
 	spinlock_t tc_lock;  /* protect anything here that is not protected */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 0723e1b57256..eb3735811cb1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -303,7 +303,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
 extern void cifs_put_tcp_session(struct TCP_Server_Info *server,
 				 int from_reconnect);
-extern void cifs_put_tcon(struct cifs_tcon *tcon);
+extern void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trac=
e trace);
 =

 extern void cifs_release_automount_timer(void);
 =

@@ -530,8 +530,9 @@ extern int CIFSSMBLogoff(const unsigned int xid, struc=
t cifs_ses *ses);
 =

 extern struct cifs_ses *sesInfoAlloc(void);
 extern void sesInfoFree(struct cifs_ses *);
-extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled);
-extern void tconInfoFree(struct cifs_tcon *);
+extern struct cifs_tcon *tcon_info_alloc(bool dir_leases_enabled,
+					 enum smb3_tcon_ref_trace trace);
+extern void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace=
 trace);
 =

 extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *=
server,
 		   __u32 *pexpected_response_sequence_number);
@@ -721,8 +722,6 @@ static inline int cifs_create_options(struct cifs_sb_i=
nfo *cifs_sb, int options)
 		return options;
 }
 =

-struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
-void cifs_put_tcon_super(struct super_block *sb);
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool r=
etry);
 =

 /* Put references of @ses and @ses->dfs_root_ses */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9b85b5341822..2d1e05bb28e6 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1932,7 +1932,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_=
context *ctx)
 	}
 =

 	/* no need to setup directory caching on IPC share, so pass in false */
-	tcon =3D tcon_info_alloc(false);
+	tcon =3D tcon_info_alloc(false, netfs_trace_tcon_ref_new_ipc);
 	if (tcon =3D=3D NULL)
 		return -ENOMEM;
 =

@@ -1949,7 +1949,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_=
context *ctx)
 =

 	if (rc) {
 		cifs_server_dbg(VFS, "failed to connect to IPC (rc=3D%d)\n", rc);
-		tconInfoFree(tcon);
+		tconInfoFree(tcon, netfs_trace_tcon_ref_free_ipc_fail);
 		goto out;
 	}
 =

@@ -1983,7 +1983,7 @@ cifs_free_ipc(struct cifs_ses *ses)
 	if (tcon =3D=3D NULL)
 		return 0;
 =

-	tconInfoFree(tcon);
+	tconInfoFree(tcon, netfs_trace_tcon_ref_free_ipc);
 	ses->tcon_ipc =3D NULL;
 	return 0;
 }
@@ -2434,6 +2434,8 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_=
context *ctx)
 			continue;
 		}
 		++tcon->tc_count;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_get_find);
 		spin_unlock(&tcon->tc_lock);
 		spin_unlock(&cifs_tcp_ses_lock);
 		return tcon;
@@ -2443,7 +2445,7 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_=
context *ctx)
 }
 =

 void
-cifs_put_tcon(struct cifs_tcon *tcon)
+cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 {
 	unsigned int xid;
 	struct cifs_ses *ses;
@@ -2459,6 +2461,7 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 	cifs_dbg(FYI, "%s: tc_count=3D%d\n", __func__, tcon->tc_count);
 	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&tcon->tc_lock);
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count - 1, trace);
 	if (--tcon->tc_count > 0) {
 		spin_unlock(&tcon->tc_lock);
 		spin_unlock(&cifs_tcp_ses_lock);
@@ -2495,7 +2498,7 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 	_free_xid(xid);
 =

 	cifs_fscache_release_super_cookie(tcon);
-	tconInfoFree(tcon);
+	tconInfoFree(tcon, netfs_trace_tcon_ref_free);
 	cifs_put_smb_ses(ses);
 }
 =

@@ -2549,7 +2552,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_c=
ontext *ctx)
 		nohandlecache =3D ctx->nohandlecache;
 	else
 		nohandlecache =3D true;
-	tcon =3D tcon_info_alloc(!nohandlecache);
+	tcon =3D tcon_info_alloc(!nohandlecache, netfs_trace_tcon_ref_new);
 	if (tcon =3D=3D NULL) {
 		rc =3D -ENOMEM;
 		goto out_fail;
@@ -2739,7 +2742,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_c=
ontext *ctx)
 	return tcon;
 =

 out_fail:
-	tconInfoFree(tcon);
+	tconInfoFree(tcon, netfs_trace_tcon_ref_free_fail);
 	return ERR_PTR(rc);
 }
 =

@@ -2756,7 +2759,7 @@ cifs_put_tlink(struct tcon_link *tlink)
 	}
 =

 	if (!IS_ERR(tlink_tcon(tlink)))
-		cifs_put_tcon(tlink_tcon(tlink));
+		cifs_put_tcon(tlink_tcon(tlink), netfs_trace_tcon_ref_put_tlink);
 	kfree(tlink);
 }
 =

@@ -3321,7 +3324,7 @@ void cifs_mount_put_conns(struct cifs_mount_ctx *mnt=
_ctx)
 	int rc =3D 0;
 =

 	if (mnt_ctx->tcon)
-		cifs_put_tcon(mnt_ctx->tcon);
+		cifs_put_tcon(mnt_ctx->tcon, netfs_trace_tcon_ref_put_mnt_ctx);
 	else if (mnt_ctx->ses)
 		cifs_put_smb_ses(mnt_ctx->ses);
 	else if (mnt_ctx->server)
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index 340efce8f052..8707f5a66e05 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -82,6 +82,11 @@ int cifs_fscache_get_super_cookie(struct cifs_tcon *tco=
n)
 		}
 		pr_err("Cache volume key already in use (%s)\n", key);
 		vcookie =3D NULL;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_see_fscache_collision);
+	} else {
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_see_fscache_okay);
 	}
 =

 	tcon->fscache =3D vcookie;
@@ -102,6 +107,8 @@ void cifs_fscache_release_super_cookie(struct cifs_tco=
n *tcon)
 	cifs_fscache_fill_volume_coherency(tcon, &cd);
 	fscache_relinquish_volume(tcon->fscache, &cd, false);
 	tcon->fscache =3D NULL;
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+			    netfs_trace_tcon_ref_see_fscache_relinq);
 }
 =

 void cifs_fscache_get_inode_cookie(struct inode *inode)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index c3771fc81328..0f20c6149638 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -110,9 +110,10 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 }
 =

 struct cifs_tcon *
-tcon_info_alloc(bool dir_leases_enabled)
+tcon_info_alloc(bool dir_leases_enabled, enum smb3_tcon_ref_trace trace)
 {
 	struct cifs_tcon *ret_buf;
+	static atomic_t tcon_debug_id;
 =

 	ret_buf =3D kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (!ret_buf)
@@ -129,7 +130,8 @@ tcon_info_alloc(bool dir_leases_enabled)
 =

 	atomic_inc(&tconInfoAllocCount);
 	ret_buf->status =3D TID_NEW;
-	++ret_buf->tc_count;
+	ret_buf->debug_id =3D atomic_inc_return(&tcon_debug_id);
+	ret_buf->tc_count =3D 1;
 	spin_lock_init(&ret_buf->tc_lock);
 	INIT_LIST_HEAD(&ret_buf->openFileList);
 	INIT_LIST_HEAD(&ret_buf->tcon_list);
@@ -141,17 +143,19 @@ tcon_info_alloc(bool dir_leases_enabled)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
 #endif
+	trace_smb3_tcon_ref(ret_buf->debug_id, ret_buf->tc_count, trace);
 =

 	return ret_buf;
 }
 =

 void
-tconInfoFree(struct cifs_tcon *tcon)
+tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 {
 	if (tcon =3D=3D NULL) {
 		cifs_dbg(FYI, "Null buffer passed to tconInfoFree\n");
 		return;
 	}
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count, trace);
 	free_cached_dirs(tcon->cfids);
 	atomic_dec(&tconInfoAllocCount);
 	kfree(tcon->nativeFileSystem);
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 82b84a4941dd..8544ac5914d6 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -763,7 +763,7 @@ smb2_cancelled_close_fid(struct work_struct *work)
 	if (rc)
 		cifs_tcon_dbg(VFS, "Close cancelled mid failed rc:%d\n", rc);
 =

-	cifs_put_tcon(tcon);
+	cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close_fid);
 	kfree(cancelled);
 }
 =

@@ -807,6 +807,8 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, __=
u64 persistent_fid,
 	if (tcon->tc_count <=3D 0) {
 		struct TCP_Server_Info *server =3D NULL;
 =

+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_see_cancelled_close);
 		WARN_ONCE(tcon->tc_count < 0, "tcon refcount is negative");
 		spin_unlock(&cifs_tcp_ses_lock);
 =

@@ -819,12 +821,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon, =
__u64 persistent_fid,
 		return 0;
 	}
 	tcon->tc_count++;
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+			    netfs_trace_tcon_ref_get_cancelled_close);
 	spin_unlock(&cifs_tcp_ses_lock);
 =

 	rc =3D __smb2_handle_cancelled_cmd(tcon, SMB2_CLOSE_HE, 0,
 					 persistent_fid, volatile_fid);
 	if (rc)
-		cifs_put_tcon(tcon);
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_close);
 =

 	return rc;
 }
@@ -852,7 +856,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, str=
uct TCP_Server_Info *serve
 					 rsp->PersistentFileId,
 					 rsp->VolatileFileId);
 	if (rc)
-		cifs_put_tcon(tcon);
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_cancelled_mid);
 =

 	return rc;
 }
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2ed456948f34..626001003583 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2912,8 +2912,11 @@ smb2_get_dfs_refer(const unsigned int xid, struct c=
ifs_ses *ses,
 		tcon =3D list_first_entry_or_null(&ses->tcon_list,
 						struct cifs_tcon,
 						tcon_list);
-		if (tcon)
+		if (tcon) {
 			tcon->tc_count++;
+			trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+					    netfs_trace_tcon_ref_get_dfs_refer);
+		}
 		spin_unlock(&cifs_tcp_ses_lock);
 	}
 =

@@ -2977,6 +2980,8 @@ smb2_get_dfs_refer(const unsigned int xid, struct ci=
fs_ses *ses,
 		/* ipc tcons are not refcounted */
 		spin_lock(&cifs_tcp_ses_lock);
 		tcon->tc_count--;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_dec_dfs_refer);
 		/* tc_count can never go negative */
 		WARN_ON(tcon->tc_count < 0);
 		spin_unlock(&cifs_tcp_ses_lock);
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 3ea688558e6c..68f8d0ece87b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4127,6 +4127,8 @@ void smb2_reconnect_server(struct work_struct *work)
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->need_reconnect || tcon->need_reopen_files) {
 				tcon->tc_count++;
+				trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+						    netfs_trace_tcon_ref_get_reconnect_server);
 				list_add_tail(&tcon->rlist, &tmp_list);
 				tcon_selected =3D true;
 			}
@@ -4165,14 +4167,14 @@ void smb2_reconnect_server(struct work_struct *wor=
k)
 		if (tcon->ipc)
 			cifs_put_smb_ses(tcon->ses);
 		else
-			cifs_put_tcon(tcon);
+			cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_reconnect_server);
 	}
 =

 	if (!ses_exist)
 		goto done;
 =

 	/* allocate a dummy tcon struct used for reconnect */
-	tcon =3D tcon_info_alloc(false);
+	tcon =3D tcon_info_alloc(false, netfs_trace_tcon_ref_new_reconnect_serve=
r);
 	if (!tcon) {
 		resched =3D true;
 		list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
@@ -4195,7 +4197,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		list_del_init(&ses->rlist);
 		cifs_put_smb_ses(ses);
 	}
-	tconInfoFree(tcon);
+	tconInfoFree(tcon, netfs_trace_tcon_ref_free_reconnect_server);
 =

 done:
 	cifs_dbg(FYI, "Reconnecting tcons and channels finished\n");
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 5a3ca62d2f07..8f346aafc4cf 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -189,6 +189,8 @@ smb2_find_smb_sess_tcon_unlocked(struct cifs_ses *ses,=
 __u32  tid)
 		if (tcon->tid !=3D tid)
 			continue;
 		++tcon->tc_count;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_get_find_sess_tcon);
 		return tcon;
 	}
 =

diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 5e83cb9da902..ae8a2fbf19f1 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -3,6 +3,9 @@
  *   Copyright (C) 2018, Microsoft Corporation.
  *
  *   Author(s): Steve French <stfrench@microsoft.com>
+ *
+ * Please use this 3-part article as a reference for writing new tracepoi=
nts:
+ * https://lwn.net/Articles/379903/
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cifs
@@ -15,9 +18,70 @@
 #include <linux/inet.h>
 =

 /*
- * Please use this 3-part article as a reference for writing new tracepoi=
nts:
- * https://lwn.net/Articles/379903/
+ * Specify enums for tracing information.
+ */
+#define smb3_tcon_ref_traces					      \
+	EM(netfs_trace_tcon_ref_dec_dfs_refer,		"DEC DfsRef") \
+	EM(netfs_trace_tcon_ref_free,			"FRE       ") \
+	EM(netfs_trace_tcon_ref_free_fail,		"FRE Fail  ") \
+	EM(netfs_trace_tcon_ref_free_ipc,		"FRE Ipc   ") \
+	EM(netfs_trace_tcon_ref_free_ipc_fail,		"FRE Ipc-F ") \
+	EM(netfs_trace_tcon_ref_free_reconnect_server,	"FRE Reconn") \
+	EM(netfs_trace_tcon_ref_get_cancelled_close,	"GET Cn-Cls") \
+	EM(netfs_trace_tcon_ref_get_dfs_refer,		"GET DfsRef") \
+	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
+	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
+	EM(netfs_trace_tcon_ref_get_reconnect_server,	"GET Reconn") \
+	EM(netfs_trace_tcon_ref_new,			"NEW       ") \
+	EM(netfs_trace_tcon_ref_new_ipc,		"NEW Ipc   ") \
+	EM(netfs_trace_tcon_ref_new_reconnect_server,	"NEW Reconn") \
+	EM(netfs_trace_tcon_ref_put_cancelled_close,	"PUT Cn-Cls") \
+	EM(netfs_trace_tcon_ref_put_cancelled_close_fid,"PUT Cn-Fid") \
+	EM(netfs_trace_tcon_ref_put_cancelled_mid,	"PUT Cn-Mid") \
+	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
+	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \
+	EM(netfs_trace_tcon_ref_put_tlink,		"PUT Tlink ") \
+	EM(netfs_trace_tcon_ref_see_cancelled_close,	"SEE Cn-Cls") \
+	EM(netfs_trace_tcon_ref_see_fscache_collision,	"SEE FV-CO!") \
+	EM(netfs_trace_tcon_ref_see_fscache_okay,	"SEE FV-Ok ") \
+	EM(netfs_trace_tcon_ref_see_fscache_relinq,	"SEE FV-Rlq") \
+	E_(netfs_trace_tcon_ref_see_umount,		"SEE Umount")
+
+#undef EM
+#undef E_
+
+/*
+ * Define those tracing enums.
+ */
+#ifndef __SMB3_DECLARE_TRACE_ENUMS_ONCE_ONLY
+#define __SMB3_DECLARE_TRACE_ENUMS_ONCE_ONLY
+
+#define EM(a, b) a,
+#define E_(a, b) a
+
+enum smb3_tcon_ref_trace { smb3_tcon_ref_traces } __mode(byte);
+
+#undef EM
+#undef E_
+#endif
+
+/*
+ * Export enum symbols via userspace.
+ */
+#define EM(a, b) TRACE_DEFINE_ENUM(a);
+#define E_(a, b) TRACE_DEFINE_ENUM(a);
+
+smb3_tcon_ref_traces;
+
+#undef EM
+#undef E_
+
+/*
+ * Now redefine the EM() and E_() macros to map the enums to the strings =
that
+ * will be printed in the output.
  */
+#define EM(a, b)	{ a, b },
+#define E_(a, b)	{ a, b }
 =

 /* For logging errors in read or write */
 DECLARE_EVENT_CLASS(smb3_rw_err_class,
@@ -1125,6 +1189,30 @@ DEFINE_SMB3_CREDIT_EVENT(waitff_credits);
 DEFINE_SMB3_CREDIT_EVENT(overflow_credits);
 DEFINE_SMB3_CREDIT_EVENT(set_credits);
 =

+
+TRACE_EVENT(smb3_tcon_ref,
+	    TP_PROTO(unsigned int tcon_debug_id, int ref,
+		     enum smb3_tcon_ref_trace trace),
+	    TP_ARGS(tcon_debug_id, ref, trace),
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		tcon		)
+		    __field(int,			ref		)
+		    __field(enum smb3_tcon_ref_trace,	trace		)
+			     ),
+	    TP_fast_assign(
+		    __entry->tcon	=3D tcon_debug_id;
+		    __entry->ref	=3D ref;
+		    __entry->trace	=3D trace;
+			   ),
+	    TP_printk("TC=3D%08x %s r=3D%u",
+		      __entry->tcon,
+		      __print_symbolic(__entry->trace, smb3_tcon_ref_traces),
+		      __entry->ref)
+	    );
+
+
+#undef EM
+#undef E_
 #endif /* _CIFS_TRACE_H */
 =

 #undef TRACE_INCLUDE_PATH


