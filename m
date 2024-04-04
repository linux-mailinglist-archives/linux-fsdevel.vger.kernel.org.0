Return-Path: <linux-fsdevel+bounces-16115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC8898948
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 15:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0418D1F22212
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6461812880A;
	Thu,  4 Apr 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/xAMFRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870AA18AF6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238835; cv=none; b=hKLmW8K0P9AHW7ksFsufrKGXcubw1m4SgM1Vad20NIMsMck/rPmpyxJUWsRUmgyec4XZdxj1dxJDTwbpQHt5Z2gFcKfwvn9Kk1iBgVDLBd270fMufbyOlZDRCAVLqRssTPKETFpP6pBmcaiaXaYjhKvNIGlokjzHcrRkZOEZMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238835; c=relaxed/simple;
	bh=P0yKAWqDVkxXdRXt9RBOkwNBn3vqoOhrtqrHGpUzMCc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=beJAJrO8hP82BLG2ZVE3xXNc79QtZpv7J486KafecDODSGlIVLOeVm6gQNXPRN4draXQAToNjvLtH8MST3YsQVrMbsoNo3KsfRwDeoZ5J9UCSI+6WekYZypM/V73+7xIQay/dDGBbLfb85AHk4iuEAjnEWImal35qG0bNKTb7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/xAMFRl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VGBxwfiAT7oJmQliLNxkXtOi8snxECSBgihaOl9vVCU=;
	b=J/xAMFRl+rLlkzwXy6MIoE6chSO+0UBp98dhPPP1wJ1LiTTzYpjCc0R8BH/RSkUQwgP5Bn
	RNKqyDAXlwdLuQq8/CF95yIP5E8X8bgA6RSMhOmpRI+gTtGGr6v2IsKmtDx8mTVV3rIdri
	p1STDV3pCNZVadxY8CPjiLlAH8jEe4M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116--bYrZ5hyOR61OAngCX6-xw-1; Thu,
 04 Apr 2024 09:53:47 -0400
X-MC-Unique: -bYrZ5hyOR61OAngCX6-xw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D93363C29864;
	Thu,  4 Apr 2024 13:53:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB09B492BD7;
	Thu,  4 Apr 2024 13:53:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Paulo Alcantara <pc@manguebit.com>
cc: dhowells@redhat.com, jlayton@kernel.org, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: cifs_mount_get_tcon() is broken?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3749391.1712238821.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Apr 2024 14:53:41 +0100
Message-ID: <3749392.1712238821@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Steve, Shyam, Paulo,

I've been looking into the duplicate fscache volume cookie message I see w=
hen
running the generic/013 xfstest on cifs with a "-o fsc" mount option.  It
turns out that in this particular case, cifs_mount_get_tcon() finds a tcon=
 it
can reuse... and then partially reinitialises it - whilst it is still in u=
se
by another mount.

This is probably a bad idea because it's resetting/changing various values=
 on
the tcon without any locking - whilst it may be being accessed by other
filesystem operations.

Probably the function should more or less drop straight out if the tcon is
already set up - as cifs_get_tcon() (which it calls to get a tcon) does.  =
That
said, there is the possibility that the second mount wants different
parameters - but I'm not sure how that affects things.

I added a tracepoint (see attached patch) that allows the evolution of the
tcon refcount to be followed.  With:

	echo 1 > /sys/kernel/debug/tracing/events/fscache/fscache_volume/enable
	echo 1 > /sys/kernel/debug/tracing/events/cifs/smb3_tcon_ref/enable
	mount //carina/test /xfstest.test -o user=3Dshares,pass=3Dxxx,fsc
	mount //carina/test /mnt -o user=3Dshares,pass=3Dxxx,fsc
	umount /xfstest.test =

	umount /mnt

I see:

    mount.cifs-5744 ...    50.282306: smb3_tcon_ref: TC=3D00000001 NEW    =
   r=3D1
    mount.cifs-5744 ...    50.283215: smb3_tcon_ref: TC=3D00000002 NEW    =
   r=3D1
    mount.cifs-5744 ...    50.286871: fscache_volume: V=3D00000001 NEW acq=
   u=3D1
    mount.cifs-5744 ...    50.286872: smb3_tcon_ref: TC=3D00000002 SEE_F_O=
k  r=3D1
    mount.cifs-5744 ...    50.288346: fscache_volume: V=3D00000001 GET coo=
k  u=3D2
    mount.cifs-5810 ...   344.536761: smb3_tcon_ref: TC=3D00000002 GET_Fin=
d  r=3D2
    mount.cifs-5810 ...   344.538981: fscache_volume: V=3D00000002 NEW acq=
   u=3D1
    mount.cifs-5810 ...   344.538982: fscache_volume: V=3D00000001 *COLLID=
E* u=3D2
    mount.cifs-5810 ...   344.538982: fscache_volume: V=3D00000002 PUT hco=
ll u=3D0
    mount.cifs-5810 ...   344.538983: fscache_volume: V=3D00000002 FREE   =
   u=3D0
    mount.cifs-5810 ...   344.544859: smb3_tcon_ref: TC=3D00000002 SEE_F_C=
O! r=3D2
    mount.cifs-5810 ...   344.546497: smb3_tcon_ref: TC=3D00000002 PUT_Tli=
nk r=3D1
        umount-6054 ...  1609.705106: fscache_volume: V=3D00000001 PUT coo=
k  u=3D1
        umount-6054 ...  1609.705237: smb3_tcon_ref: TC=3D00000002 PUT_Tli=
nk r=3D0
        umount-6054 ...  1609.706098: smb3_tcon_ref: TC=3D00000002 SEE_F_R=
lq r=3D0
        umount-6054 ...  1609.706099: smb3_tcon_ref: TC=3D00000002 FREE   =
   r=3D0
        umount-6054 ...  1609.706101: smb3_tcon_ref: TC=3D00000001 FREE   =
   r=3D1

in the tracebuffer.  tcons get labelled with integer debugging IDs as they=
 are
created, which you can see in TC=3Dnnnnnnnn.  fscache volume cookies simil=
arly
get labelled as V=3Dnnnnnnnn.

The "GET_Find" line corresponds to the refcount increment in cifs_find_tco=
n()
where it finds an already live tcon and reuses it.

This is then followed by fscache attempting to create a second volume cook=
ie
because that's driven from cifs_mount_get_tcon() - and cifs reports this a=
s
the "SEE_F_CO!" line.

Both tcons that were created are freed, but TC=3D00000001 does not get a f=
inal
put, but is rather freed directly with a ref still attached - presumably b=
y
design.

The simplest fix I can make is to take a mutex around the acquisition of t=
he
volume cookie, and check to see if I've tried to get one before.  That sai=
d,
it looks like cifs_mount_get_tcon() may have other problems too and a more
general solution may be required.

David
---
commit 072e0337280fb1f1dcca883ca1e6340eb9be265c
Author: David Howells <dhowells@redhat.com>
Date:   Thu Apr 4 13:51:36 2024 +0100

    cifs: Add tracing for the tcon struct refcounting

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5ce2f54cb086..abbfb5138ee2 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -742,6 +742,8 @@ static void cifs_umount_begin(struct super_block *sb)
 =

 	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&tcon->tc_lock);
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+			    netfs_trace_tcon_ref_see_umount);
 	if ((tcon->tc_count > 1) || (tcon->status =3D=3D TID_EXITING)) {
 		/* we have other mounts to same share or we have
 		   already tried to umount this and woken up
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 94885bf86ff2..22325fec7eb1 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1188,6 +1188,7 @@ struct cifs_fattr {
  */
 struct cifs_tcon {
 	struct list_head tcon_list;
+	int debug_id;		/* Debugging for tracing */
 	int tc_count;
 	struct list_head rlist; /* reconnect list */
 	spinlock_t tc_lock;  /* protect anything here that is not protected */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 57ec67cdc31e..f49a63aed4dd 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -305,7 +305,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 		     struct TCP_Server_Info *primary_server);
 extern void cifs_put_tcp_session(struct TCP_Server_Info *server,
 				 int from_reconnect);
-extern void cifs_put_tcon(struct cifs_tcon *tcon);
+extern void cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trac=
e trace);
 =

 extern void cifs_release_automount_timer(void);
 =

@@ -719,8 +719,6 @@ static inline int cifs_create_options(struct cifs_sb_i=
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
index 9b85b5341822..7502792a9c89 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
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
index 147e8cd38fe1..9bf8a4fb06bd 100644
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
index c3771fc81328..746f127e080d 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -113,6 +113,7 @@ struct cifs_tcon *
 tcon_info_alloc(bool dir_leases_enabled)
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
@@ -141,6 +143,8 @@ tcon_info_alloc(bool dir_leases_enabled)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
 #endif
+	trace_smb3_tcon_ref(ret_buf->debug_id, ret_buf->tc_count,
+			    netfs_trace_tcon_ref_new);
 =

 	return ret_buf;
 }
@@ -152,6 +156,8 @@ tconInfoFree(struct cifs_tcon *tcon)
 		cifs_dbg(FYI, "Null buffer passed to tconInfoFree\n");
 		return;
 	}
+	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+			    netfs_trace_tcon_ref_free);
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
index 2413006e5f39..0700ced3106b 100644
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
index 96a23a26d205..f3d3895d6461 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4129,6 +4129,8 @@ void smb2_reconnect_server(struct work_struct *work)
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 			if (tcon->need_reconnect || tcon->need_reopen_files) {
 				tcon->tc_count++;
+				trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+						    netfs_trace_tcon_ref_get_reconnect_server);
 				list_add_tail(&tcon->rlist, &tmp_list);
 				tcon_selected =3D true;
 			}
@@ -4167,7 +4169,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		if (tcon->ipc)
 			cifs_put_smb_ses(tcon->ses);
 		else
-			cifs_put_tcon(tcon);
+			cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_reconnect_server);
 	}
 =

 	if (!ses_exist)
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 5a3ca62d2f07..8402077b855b 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -189,6 +189,8 @@ smb2_find_smb_sess_tcon_unlocked(struct cifs_ses *ses,=
 __u32  tid)
 		if (tcon->tid !=3D tid)
 			continue;
 		++tcon->tc_count;
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_get_find_smb2);
 		return tcon;
 	}
 =

diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 3972638c308f..dc84c0eef56c 100644
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
@@ -15,9 +18,64 @@
 #include <linux/inet.h>
 =

 /*
- * Please use this 3-part article as a reference for writing new tracepoi=
nts:
- * https://lwn.net/Articles/379903/
+ * Specify enums for tracing information.
+ */
+#define smb3_tcon_ref_traces					    \
+	EM(netfs_trace_tcon_ref_dec_dfs_refer,		"DEC_DfsRf") \
+	EM(netfs_trace_tcon_ref_free,			"FREE     ") \
+	EM(netfs_trace_tcon_ref_get_cancelled_close,	"GET_C_Cls") \
+	EM(netfs_trace_tcon_ref_get_dfs_refer,		"GET_DfsRe") \
+	EM(netfs_trace_tcon_ref_get_find,		"GET_Find ") \
+	EM(netfs_trace_tcon_ref_get_find_smb2,		"GET_Find2") \
+	EM(netfs_trace_tcon_ref_get_reconnect_server,	"GET_Recon") \
+	EM(netfs_trace_tcon_ref_new,			"NEW      ") \
+	EM(netfs_trace_tcon_ref_put_cancelled_close,	"PUT_C_Cls") \
+	EM(netfs_trace_tcon_ref_put_cancelled_close_fid,"PUT_C_Fid") \
+	EM(netfs_trace_tcon_ref_put_cancelled_mid,	"PUT_C_Mid") \
+	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT_MntCx") \
+	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT_Recon") \
+	EM(netfs_trace_tcon_ref_put_tlink,		"PUT_Tlink") \
+	EM(netfs_trace_tcon_ref_see_cancelled_close,	"SEE_C_Cls") \
+	EM(netfs_trace_tcon_ref_see_fscache_collision,	"SEE_F_CO!") \
+	EM(netfs_trace_tcon_ref_see_fscache_okay,	"SEE_F_Ok ") \
+	EM(netfs_trace_tcon_ref_see_fscache_relinq,	"SEE_F_Rlq") \
+	E_(netfs_trace_tcon_ref_see_umount,		"SEE_Umnt ")
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
@@ -1231,6 +1289,30 @@ DEFINE_SMB3_CREDIT_EVENT(waitff_credits);
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


