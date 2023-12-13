Return-Path: <linux-fsdevel+bounces-5895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7B8113A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D11F2279F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3CA2F535;
	Wed, 13 Dec 2023 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoYj1rOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0471728
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2ZPB2Sqot0p4TOyHCibD/tw6vL1F8SxZQh+gHOn/Ek=;
	b=OoYj1rOzvijFp0tev/YPhRKRI7iNvY69MTuSEt8Ahea7LFNGtlKMZLxN9sh4KoayCm+S/Z
	FtEGKTwazZ1o5fBrCLUayUtb0wQdhD2S7OtT4qo8cEAErH8d2+ZOm7cA8eLGhVlIr6qXOD
	cQw/Smr52h+zkHDO72AAB+BCYw60AO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-7mEwBPkDN8ifMnrgBIHurg-1; Wed, 13 Dec 2023 08:51:10 -0500
X-MC-Unique: 7mEwBPkDN8ifMnrgBIHurg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66700837193;
	Wed, 13 Dec 2023 13:51:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71A462166B31;
	Wed, 13 Dec 2023 13:51:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/40] afs: trace: Log afs_make_call(), including server address
Date: Wed, 13 Dec 2023 13:50:02 +0000
Message-ID: <20231213135003.367397-41-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add a tracepoint to log calls to afs_make_call(), including the destination
server address.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fsclient.c          | 22 ++++++++++++++++++++++
 fs/afs/internal.h          |  1 +
 fs/afs/rxrpc.c             |  2 ++
 fs/afs/yfsclient.c         | 20 ++++++++++++++++++++
 include/trace/events/afs.h | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 80f7d9e796e3..79cd30775b7a 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -290,6 +290,7 @@ void afs_fs_fetch_status(struct afs_operation *op)
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -442,6 +443,7 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	bp[6] = 0;
 	bp[7] = htonl(lower_32_bits(req->len));
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -476,6 +478,7 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	bp[4] = htonl(lower_32_bits(req->pos));
 	bp[5] = htonl(lower_32_bits(req->len));
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -559,6 +562,7 @@ void afs_fs_create_file(struct afs_operation *op)
 	*bp++ = htonl(op->create.mode & S_IALLUGO); /* unix mode */
 	*bp++ = 0; /* segment size */
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -612,6 +616,7 @@ void afs_fs_make_dir(struct afs_operation *op)
 	*bp++ = htonl(op->create.mode & S_IALLUGO); /* unix mode */
 	*bp++ = 0; /* segment size */
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -685,6 +690,7 @@ void afs_fs_remove_file(struct afs_operation *op)
 		bp = (void *) bp + padsz;
 	}
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -732,6 +738,7 @@ void afs_fs_remove_dir(struct afs_operation *op)
 		bp = (void *) bp + padsz;
 	}
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -812,6 +819,7 @@ void afs_fs_link(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.vnode);
 	*bp++ = htonl(vp->fid.unique);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call1(call, &vp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -907,6 +915,7 @@ void afs_fs_symlink(struct afs_operation *op)
 	*bp++ = htonl(S_IRWXUGO); /* unix mode */
 	*bp++ = 0; /* segment size */
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1003,6 +1012,7 @@ void afs_fs_rename(struct afs_operation *op)
 		bp = (void *) bp + n_padsz;
 	}
 
+	call->fid = orig_dvp->fid;
 	trace_afs_make_fs_call2(call, &orig_dvp->fid, orig_name, new_name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1090,6 +1100,7 @@ static void afs_fs_store_data64(struct afs_operation *op)
 	*bp++ = htonl(upper_32_bits(op->store.i_size));
 	*bp++ = htonl(lower_32_bits(op->store.i_size));
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1140,6 +1151,7 @@ void afs_fs_store_data(struct afs_operation *op)
 	*bp++ = htonl(lower_32_bits(op->store.size));
 	*bp++ = htonl(lower_32_bits(op->store.i_size));
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1206,6 +1218,7 @@ static void afs_fs_setattr_size64(struct afs_operation *op)
 	*bp++ = htonl(upper_32_bits(attr->ia_size));	/* new file length */
 	*bp++ = htonl(lower_32_bits(attr->ia_size));
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1247,6 +1260,7 @@ static void afs_fs_setattr_size(struct afs_operation *op)
 	*bp++ = 0;				/* size of write */
 	*bp++ = htonl(attr->ia_size);		/* new file length */
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1283,6 +1297,7 @@ void afs_fs_setattr(struct afs_operation *op)
 
 	xdr_encode_AFS_StoreStatus(&bp, op->setattr.attr);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1446,6 +1461,7 @@ void afs_fs_get_volume_status(struct afs_operation *op)
 	bp[0] = htonl(FSGETVOLUMESTATUS);
 	bp[1] = htonl(vp->fid.vid);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1528,6 +1544,7 @@ void afs_fs_set_lock(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.unique);
 	*bp++ = htonl(op->lock.type);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_calli(call, &vp->fid, op->lock.type);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1554,6 +1571,7 @@ void afs_fs_extend_lock(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.vnode);
 	*bp++ = htonl(vp->fid.unique);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1580,6 +1598,7 @@ void afs_fs_release_lock(struct afs_operation *op)
 	*bp++ = htonl(vp->fid.vnode);
 	*bp++ = htonl(vp->fid.unique);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1948,6 +1967,7 @@ void afs_fs_inline_bulk_status(struct afs_operation *op)
 		*bp++ = htonl(op->more_files[i].fid.unique);
 	}
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -2053,6 +2073,7 @@ void afs_fs_fetch_acl(struct afs_operation *op)
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_KERNEL);
 }
@@ -2098,6 +2119,7 @@ void afs_fs_store_acl(struct afs_operation *op)
 	if (acl->size != size)
 		memset((void *)&bp[5] + acl->size, 0, size - acl->size);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_KERNEL);
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a6a4fc417dba..e33ace259cc6 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -153,6 +153,7 @@ struct afs_call {
 		struct afs_vldb_entry	*ret_vldb;
 		char			*ret_str;
 	};
+	struct afs_fid		fid;		/* Primary vnode ID (or all zeroes) */
 	unsigned char		probe_index;	/* Address in ->probe_alist */
 	struct afs_operation	*op;
 	unsigned int		server_index;
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 81013bc8bbfd..c453428f3c8b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -313,6 +313,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
 	       call, call->type->name, key_serial(call->key),
 	       atomic_read(&call->net->nr_outstanding_calls));
 
+	trace_afs_make_call(call);
+
 	/* Work out the length we're going to transmit.  This is awkward for
 	 * calls such as FS.StoreData where there's an extra injection of data
 	 * after the initial fixed part.
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 2d6943f05ea5..f521e66d3bf6 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -493,6 +493,7 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	bp = xdr_encode_u64(bp, req->len);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -575,6 +576,7 @@ void yfs_fs_create_file(struct afs_operation *op)
 	bp = xdr_encode_u32(bp, yfs_LockNone); /* ViceLockType */
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -623,6 +625,7 @@ void yfs_fs_make_dir(struct afs_operation *op)
 	bp = xdr_encode_YFSStoreStatus(bp, &op->create.mode, &op->mtime);
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -707,6 +710,7 @@ void yfs_fs_remove_file2(struct afs_operation *op)
 	bp = xdr_encode_name(bp, name);
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -776,6 +780,7 @@ void yfs_fs_remove_file(struct afs_operation *op)
 	bp = xdr_encode_name(bp, name);
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -817,6 +822,7 @@ void yfs_fs_remove_dir(struct afs_operation *op)
 	bp = xdr_encode_name(bp, name);
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -890,6 +896,7 @@ void yfs_fs_link(struct afs_operation *op)
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call1(call, &vp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -971,6 +978,7 @@ void yfs_fs_symlink(struct afs_operation *op)
 	bp = xdr_encode_YFSStoreStatus(bp, &mode, &op->mtime);
 	yfs_check_req(call, bp);
 
+	call->fid = dvp->fid;
 	trace_afs_make_fs_call1(call, &dvp->fid, name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1050,6 +1058,7 @@ void yfs_fs_rename(struct afs_operation *op)
 	bp = xdr_encode_name(bp, new_name);
 	yfs_check_req(call, bp);
 
+	call->fid = orig_dvp->fid;
 	trace_afs_make_fs_call2(call, &orig_dvp->fid, orig_name, new_name);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1105,6 +1114,7 @@ void yfs_fs_store_data(struct afs_operation *op)
 	bp = xdr_encode_u64(bp, op->store.i_size);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1161,6 +1171,7 @@ static void yfs_fs_setattr_size(struct afs_operation *op)
 	bp = xdr_encode_u64(bp, attr->ia_size);	/* new file length */
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1199,6 +1210,7 @@ void yfs_fs_setattr(struct afs_operation *op)
 	bp = xdr_encode_YFS_StoreStatus(bp, attr);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1369,6 +1381,7 @@ void yfs_fs_get_volume_status(struct afs_operation *op)
 	bp = xdr_encode_u64(bp, vp->fid.vid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1433,6 +1446,7 @@ void yfs_fs_set_lock(struct afs_operation *op)
 	bp = xdr_encode_u32(bp, op->lock.type);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_calli(call, &vp->fid, op->lock.type);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1463,6 +1477,7 @@ void yfs_fs_extend_lock(struct afs_operation *op)
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1493,6 +1508,7 @@ void yfs_fs_release_lock(struct afs_operation *op)
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1559,6 +1575,7 @@ void yfs_fs_fetch_status(struct afs_operation *op)
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1739,6 +1756,7 @@ void yfs_fs_inline_bulk_status(struct afs_operation *op)
 		bp = xdr_encode_YFSFid(bp, &op->more_files[i].fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
 }
@@ -1901,6 +1919,7 @@ void yfs_fs_fetch_opaque_acl(struct afs_operation *op)
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_KERNEL);
 }
@@ -1951,6 +1970,7 @@ void yfs_fs_store_opaque_acl2(struct afs_operation *op)
 	bp += size / sizeof(__be32);
 	yfs_check_req(call, bp);
 
+	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_KERNEL);
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index b2e0847eca47..5194b7e6dc8d 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1576,6 +1576,42 @@ TRACE_EVENT(afs_rotate,
 		      __entry->extra)
 	    );
 
+TRACE_EVENT(afs_make_call,
+	    TP_PROTO(struct afs_call *call),
+
+	    TP_ARGS(call),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		call)
+		    __field(bool,			is_vl)
+		    __field(enum afs_fs_operation,	op)
+		    __field_struct(struct afs_fid,	fid)
+		    __field_struct(struct sockaddr_rxrpc, srx)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->call = call->debug_id;
+		    __entry->op = call->operation_ID;
+		    __entry->fid = call->fid;
+		    memcpy(&__entry->srx, rxrpc_kernel_remote_srx(call->peer),
+			   sizeof(__entry->srx));
+		    __entry->srx.srx_service = call->service_id;
+		    __entry->is_vl = (__entry->srx.srx_service == VL_SERVICE ||
+				      __entry->srx.srx_service == YFS_VL_SERVICE);
+			   ),
+
+	    TP_printk("c=%08x %pISpc+%u %s %llx:%llx:%x",
+		      __entry->call,
+		      &__entry->srx.transport,
+		      __entry->srx.srx_service,
+		      __entry->is_vl ?
+		      __print_symbolic(__entry->op, afs_vl_operations) :
+		      __print_symbolic(__entry->op, afs_fs_operations),
+		      __entry->fid.vid,
+		      __entry->fid.vnode,
+		      __entry->fid.unique)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */


