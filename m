Return-Path: <linux-fsdevel+bounces-32648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176179AC816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613ABB21FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D621A2658;
	Wed, 23 Oct 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/93F57Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362319CC32
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680020; cv=none; b=Ld63bYHBF6NkCmSrjCUGdt36QkLbKweAHG+Uc/16Fp0Jt0OZA0pGbS7I2vxDRQjFxySMqC5EAtws1m4pXU4csI6yaT39AGlEq6CdtEClPUwul+NqEBhzCqblIdLTlQQIDI7iSj+CJNqpOTFUi1KUIx/cTUXMxt/aTgSly1ks7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680020; c=relaxed/simple;
	bh=ibcMqYntbxBW8l8pzNlZek9na1BdV0viskcfDf1u53U=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=oWQ017iMQQT8/h3fd2qvw8Osul/5GWKq3COTPVWhhS4/kPz22BSHATbAcTk2E4vZjZur/DVDDFS+mtVwS1z/k5wInoY4bv+otKWFafejYkeaW1y+ay6M7NM0F6sVPkEcOJ2rfePgP0eabYxiMPDa2XxcecYNNpru6sEdPKupa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/93F57Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729680017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7NsCNuVkdUPhJRL8ZQj+L9UyuxE+nUqgXfeM9z04tmo=;
	b=d/93F57YRf4EPL7lwNX5JuZ+fmxeQJGJCkqaDxdoG30PpC8hMd/B51jsvLBKGQ2IS+8Fcu
	R+YIMdUOduQvJm3R6kR3iVdirjdKQ+G8FBvuczpMSMEAq174/A7kANwizXDDOKQm1WS6Zh
	916eTzil8T04A8MbsuByKf7BXwO1weU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-OJ_5-ZcrOdeB42L6YRIYDA-1; Wed,
 23 Oct 2024 06:40:14 -0400
X-MC-Unique: OJ_5-ZcrOdeB42L6YRIYDA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F1711955DAC;
	Wed, 23 Oct 2024 10:40:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC128300018D;
	Wed, 23 Oct 2024 10:40:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] afs: Fix missing subdir edit when renamed between parent dirs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3340430.1729680010.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Oct 2024 11:40:10 +0100
Message-ID: <3340431.1729680010@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When rename moves an AFS subdirectory between parent directories, the
subdir also needs a bit of editing: the ".." entry needs updating to point
to the new parent (though I don't make use of the info) and the DV needs
incrementing by 1 to reflect the change of content.  The server also sends
a callback break notification on the subdirectory if we have one, but we
can take care of recovering the promise next time we access the subdir.

This can be triggered by something like:

    mount -t afs %example.com:xfstest.test20 /xfstest.test/
    mkdir /xfstest.test/{aaa,bbb,aaa/ccc}
    touch /xfstest.test/bbb/ccc/d
    mv /xfstest.test/{aaa/ccc,bbb/ccc}
    touch /xfstest.test/bbb/ccc/e

When the pathwalk for the second touch hits "ccc", kafs spots that the DV
is incorrect and downloads it again (so the fix is not critical).

Fix this, if the rename target is a directory and the old and new
parents are different, by:

 (1) Incrementing the DV number of the target locally.

 (2) Editing the ".." entry in the target to refer to its new parent's
     vnode ID and uniquifier.

Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/un=
link/...")
cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 Changes
 =3D=3D=3D=3D=3D=3D=3D
 ver #2)
  - Improved the example test in the description.
  - Removed some extraneous whitespace.

 fs/afs/dir.c               |   25 ++++++++++++
 fs/afs/dir_edit.c          |   91 +++++++++++++++++++++++++++++++++++++++=
+++++-
 fs/afs/internal.h          |    2 =

 include/trace/events/afs.h |    7 ++-
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index f8622ed72e08..ada363af5aab 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/iversion.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "afs_fs.h"
@@ -1823,6 +1824,8 @@ static int afs_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
 =

 static void afs_rename_success(struct afs_operation *op)
 {
+	struct afs_vnode *vnode =3D AFS_FS_I(d_inode(op->dentry));
+
 	_enter("op=3D%08x", op->debug_id);
 =

 	op->ctime =3D op->file[0].scb.status.mtime_client;
@@ -1832,6 +1835,22 @@ static void afs_rename_success(struct afs_operation=
 *op)
 		op->ctime =3D op->file[1].scb.status.mtime_client;
 		afs_vnode_commit_status(op, &op->file[1]);
 	}
+
+	/* If we're moving a subdir between dirs, we need to update
+	 * its DV counter too as the ".." will be altered.
+	 */
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    op->file[0].vnode !=3D op->file[1].vnode) {
+		u64 new_dv;
+
+		write_seqlock(&vnode->cb_lock);
+
+		new_dv =3D vnode->status.data_version + 1;
+		vnode->status.data_version =3D new_dv;
+		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
+
+		write_sequnlock(&vnode->cb_lock);
+	}
 }
 =

 static void afs_rename_edit_dir(struct afs_operation *op)
@@ -1873,6 +1892,12 @@ static void afs_rename_edit_dir(struct afs_operatio=
n *op)
 				 &vnode->fid, afs_edit_dir_for_rename_2);
 	}
 =

+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    new_dvnode !=3D orig_dvnode &&
+	    test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+		afs_edit_dir_update_dotdot(vnode, new_dvnode,
+					   afs_edit_dir_for_rename_sub);
+
 	new_inode =3D d_inode(new_dentry);
 	if (new_inode) {
 		spin_lock(&new_inode->i_lock);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index a71bff10496b..fe223fb78111 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -127,10 +127,10 @@ static struct folio *afs_dir_get_folio(struct afs_vn=
ode *vnode, pgoff_t index)
 /*
  * Scan a directory block looking for a dirent of the right name.
  */
-static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr=
 *name,
+static int afs_dir_scan_block(const union afs_xdr_dir_block *block, const=
 struct qstr *name,
 			      unsigned int blocknum)
 {
-	union afs_xdr_dirent *de;
+	const union afs_xdr_dirent *de;
 	u64 bitmap;
 	int d, len, n;
 =

@@ -492,3 +492,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
+
+/*
+ * Edit a subdirectory that has been moved between directories to update =
the
+ * ".." entry.
+ */
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode=
 *new_dvnode,
+				enum afs_edit_dir_reason why)
+{
+	union afs_xdr_dir_block *block;
+	union afs_xdr_dirent *de;
+	struct folio *folio;
+	unsigned int nr_blocks, b;
+	pgoff_t index;
+	loff_t i_size;
+	int slot;
+
+	_enter("");
+
+	i_size =3D i_size_read(&vnode->netfs.inode);
+	if (i_size < AFS_DIR_BLOCK_SIZE) {
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		return;
+	}
+	nr_blocks =3D i_size / AFS_DIR_BLOCK_SIZE;
+
+	/* Find a block that has sufficient slots available.  Each folio
+	 * contains two or more directory blocks.
+	 */
+	for (b =3D 0; b < nr_blocks; b++) {
+		index =3D b / AFS_DIR_BLOCKS_PER_PAGE;
+		folio =3D afs_dir_get_folio(vnode, index);
+		if (!folio)
+			goto error;
+
+		block =3D kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(fo=
lio));
+
+		/* Abandon the edit if we got a callback break. */
+		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+			goto invalidated;
+
+		slot =3D afs_dir_scan_block(block, &dotdot_name, b);
+		if (slot >=3D 0)
+			goto found_dirent;
+
+		kunmap_local(block);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	/* Didn't find the dirent to clobber.  Download the directory again. */
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+found_dirent:
+	de =3D &block->dirents[slot];
+	de->u.vnode  =3D htonl(new_dvnode->fid.vnode);
+	de->u.unique =3D htonl(new_dvnode->fid.unique);
+
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
+			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
+
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
+
+out:
+	_leave("");
+	return;
+
+invalidated:
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+error:
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 52aab09a32a9..c9d620175e80 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1073,6 +1073,8 @@ extern void afs_check_for_remote_deletion(struct afs=
_operation *);
 extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct af=
s_fid *,
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum a=
fs_edit_dir_reason);
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode=
 *new_dvnode,
+				enum afs_edit_dir_reason why);
 =

 /*
  * dir_silly.c
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 450c44c83a5d..a0aed1a428a1 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -331,7 +331,11 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_delete,			"delete") \
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
-	E_(afs_edit_dir_delete_noent,		"d_nent")
+	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_update_dd,		"u_ddot") \
+	EM(afs_edit_dir_update_error,		"u_fail") \
+	EM(afs_edit_dir_update_inval,		"u_invl") \
+	E_(afs_edit_dir_update_nodd,		"u_nodd")
 =

 #define afs_edit_dir_reasons				  \
 	EM(afs_edit_dir_for_create,		"Create") \
@@ -340,6 +344,7 @@ enum yfs_cm_operation {
 	EM(afs_edit_dir_for_rename_0,		"Renam0") \
 	EM(afs_edit_dir_for_rename_1,		"Renam1") \
 	EM(afs_edit_dir_for_rename_2,		"Renam2") \
+	EM(afs_edit_dir_for_rename_sub,		"RnmSub") \
 	EM(afs_edit_dir_for_rmdir,		"RmDir ") \
 	EM(afs_edit_dir_for_silly_0,		"S_Ren0") \
 	EM(afs_edit_dir_for_silly_1,		"S_Ren1") \


