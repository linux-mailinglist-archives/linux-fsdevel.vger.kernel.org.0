Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5079136FADB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhD3MsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 08:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhD3MsC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619786834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ICE4gsyWD3Jf/PdV6lkuOTdEcfDUow7eaHMByfqKnf0=;
        b=IPTOFV/ybI6M8ZVqFAsrnTI37iE8DsFXXoq8hv8XJOo/0Wfa5z+gm8Ki/YM7VRMleSI2Cp
        fVODOC2C8AvzkRS1LQbgRG1qYp52UFvPmwWe0sooMAKaeFM2pkxlqXQf68HfM5DGOvv2Ui
        Vc+tFLvWhUZpczzcYom8Ma4pG6qb4MY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-jZ0YKtvEPkmEtTIRdRIeEw-1; Fri, 30 Apr 2021 08:47:12 -0400
X-MC-Unique: jZ0YKtvEPkmEtTIRdRIeEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0CEA1922046;
        Fri, 30 Apr 2021 12:47:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96AF29CA0;
        Fri, 30 Apr 2021 12:47:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix speculative status fetches
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <622681.1619786828.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 30 Apr 2021 13:47:08 +0100
Message-ID: <622682.1619786828@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

The generic/464 xfstest causes kAFS to emit occasional warnings of the
form:

        kAFS: vnode modified {100055:8a} 30->31 YFS.StoreData64 (c=3D6015)

This indicates that the data version received back from the server did not
match the expected value (the DV should be incremented monotonically for
each individual modification op committed to a vnode).

What is happening is that a lookup call is doing a bulk status fetch
speculatively on a bunch of vnodes in a directory besides getting the
status of the vnode it's actually interested in.  This is racing with a
StoreData operation (though it could also occur with, say, a MakeDir op).

On the client, a modification operation locks the vnode, but the bulk
status fetch only locks the parent directory, so no ordering is imposed
there (thereby avoiding an avenue to deadlock).

On the server, the StoreData op handler doesn't lock the vnode until it's
received all the request data, and downgrades the lock after committing th=
e
data until it has finished sending change notifications to other clients -
which allows the status fetch to occur before it has finished.

This means that:

 - a status fetch can access the target vnode either side of the exclusive
   section of the modification

 - the status fetch could start before the modification, yet finish after,
   and vice-versa.

 - the status fetch and the modification RPCs can complete in either order=
.

 - the status fetch can return either the before or the after DV from the
   modification.

 - the status fetch might regress the locally cached DV.

Some of these are handled by the previous fix[1], but that's not sufficien=
t
because it checks the DV it received against the DV it cached at the start
of the op, but the DV might've been updated in the meantime by a locally
generated modification op.

Fix this by the following means:

 (1) Keep track of when we're performing a modification operation on a
     vnode.  This is done by marking vnode parameters with a 'modification=
'
     note that causes the AFS_VNODE_MODIFYING flag to be set on the vnode
     for the duration.

 (2) Alter the speculation race detection to ignore speculative status
     fetches if either the vnode is marked as being modified or the data
     version number is not what we expected.

Note that whilst the "vnode modified" warning does get recovered from as i=
t
causes the client to refetch the status at the next opportunity, it will
also invalidate the pagecache, so changes might get lost.

Fixes: a9e5c87ca744 ("afs: Fix speculative status fetch going out of order=
 wrt to modifications")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-and-reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/160605082531.252452.14708077925602709042.s=
tgit@warthog.procyon.org.uk/ [1]
Link: https://lore.kernel.org/linux-fsdevel/161961335926.39335.25526539721=
95467566.stgit@warthog.procyon.org.uk/ # v1
---
 fs/afs/dir.c          |    7 +++++++
 fs/afs/dir_silly.c    |    3 +++
 fs/afs/fs_operation.c |    6 ++++++
 fs/afs/inode.c        |    6 ++++--
 fs/afs/internal.h     |    2 ++
 fs/afs/write.c        |    1 +
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 117df15e5367..9fbe5a5ec9bd 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1419,6 +1419,7 @@ static int afs_mkdir(struct user_namespace *mnt_user=
ns, struct inode *dir,
 =

 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->dentry	=3D dentry;
 	op->create.mode	=3D S_IFDIR | mode;
@@ -1500,6 +1501,7 @@ static int afs_rmdir(struct inode *dir, struct dentr=
y *dentry)
 =

 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 =

 	op->dentry	=3D dentry;
@@ -1636,6 +1638,7 @@ static int afs_unlink(struct inode *dir, struct dent=
ry *dentry)
 =

 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 =

 	/* Try to make sure we have a callback promise on the victim. */
@@ -1718,6 +1721,7 @@ static int afs_create(struct user_namespace *mnt_use=
rns, struct inode *dir,
 =

 	afs_op_set_vnode(op, 0, dvnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 =

 	op->dentry	=3D dentry;
@@ -1792,6 +1796,7 @@ static int afs_link(struct dentry *from, struct inod=
e *dir,
 	afs_op_set_vnode(op, 0, dvnode);
 	afs_op_set_vnode(op, 1, vnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].update_ctime =3D true;
 =

@@ -1987,6 +1992,8 @@ static int afs_rename(struct user_namespace *mnt_use=
rns, struct inode *old_dir,
 	afs_op_set_vnode(op, 1, new_dvnode); /* May be same as orig_dvnode */
 	op->file[0].dv_delta =3D 1;
 	op->file[1].dv_delta =3D 1;
+	op->file[0].modification =3D true;
+	op->file[1].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].update_ctime =3D true;
 =

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 04f75a44f243..dae9a57d7ec0 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -73,6 +73,8 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode,=
 struct afs_vnode *vnode
 	afs_op_set_vnode(op, 1, dvnode);
 	op->file[0].dv_delta =3D 1;
 	op->file[1].dv_delta =3D 1;
+	op->file[0].modification =3D true;
+	op->file[1].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].update_ctime =3D true;
 =

@@ -201,6 +203,7 @@ static int afs_do_silly_unlink(struct afs_vnode *dvnod=
e, struct afs_vnode *vnode
 	afs_op_set_vnode(op, 0, dvnode);
 	afs_op_set_vnode(op, 1, vnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->file[0].update_ctime =3D true;
 	op->file[1].op_unlinked =3D true;
 	op->file[1].update_ctime =3D true;
diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 2cb0951acca6..d222dfbe976b 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -118,6 +118,8 @@ static void afs_prepare_vnode(struct afs_operation *op=
, struct afs_vnode_param *
 		vp->cb_break_before	=3D afs_calc_vnode_cb_break(vnode);
 		if (vnode->lock_state !=3D AFS_VNODE_LOCK_NONE)
 			op->flags	|=3D AFS_OPERATION_CUR_ONLY;
+		if (vp->modification)
+			set_bit(AFS_VNODE_MODIFYING, &vnode->flags);
 	}
 =

 	if (vp->fid.vnode)
@@ -225,6 +227,10 @@ int afs_put_operation(struct afs_operation *op)
 =

 	if (op->ops && op->ops->put)
 		op->ops->put(op);
+	if (op->file[0].modification)
+		clear_bit(AFS_VNODE_MODIFYING, &op->file[0].vnode->flags);
+	if (op->file[1].modification && op->file[1].vnode !=3D op->file[0].vnode=
)
+		clear_bit(AFS_VNODE_MODIFYING, &op->file[1].vnode->flags);
 	if (op->file[0].put_vnode)
 		iput(&op->file[0].vnode->vfs_inode);
 	if (op->file[1].put_vnode)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3a129b9fd9b8..80b6c8d967d5 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -294,8 +294,9 @@ void afs_vnode_commit_status(struct afs_operation *op,=
 struct afs_vnode_param *v
 			op->flags &=3D ~AFS_OPERATION_DIR_CONFLICT;
 		}
 	} else if (vp->scb.have_status) {
-		if (vp->dv_before + vp->dv_delta !=3D vp->scb.status.data_version &&
-		    vp->speculative)
+		if (vp->speculative &&
+		    (test_bit(AFS_VNODE_MODIFYING, &vnode->flags) ||
+		     vp->dv_before !=3D vnode->status.data_version))
 			/* Ignore the result of a speculative bulk status fetch
 			 * if it splits around a modification op, thereby
 			 * appearing to regress the data version.
@@ -911,6 +912,7 @@ int afs_setattr(struct user_namespace *mnt_userns, str=
uct dentry *dentry,
 	}
 	op->ctime =3D attr->ia_ctime;
 	op->file[0].update_ctime =3D 1;
+	op->file[0].modification =3D true;
 =

 	op->ops =3D &afs_setattr_operation;
 	ret =3D afs_do_sync_operation(op);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 52157a05796a..5ed416f4ff33 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -645,6 +645,7 @@ struct afs_vnode {
 #define AFS_VNODE_PSEUDODIR	7 		/* set if Vnode is a pseudo directory */
 #define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/t=
runc-0) */
 #define AFS_VNODE_SILLY_DELETED	9		/* Set if file has been silly-deleted =
*/
+#define AFS_VNODE_MODIFYING	10		/* Set if we're performing a modification=
 op */
 =

 	struct list_head	wb_keys;	/* List of keys available for writeback */
 	struct list_head	pending_locks;	/* locks waiting to be granted */
@@ -762,6 +763,7 @@ struct afs_vnode_param {
 	bool			set_size:1;	/* Must update i_size */
 	bool			op_unlinked:1;	/* True if file was unlinked by op */
 	bool			speculative:1;	/* T if speculative status fetch (no vnode lock) *=
/
+	bool			modification:1;	/* Set if the content gets modified */
 };
 =

 /*
diff --git a/fs/afs/write.c b/fs/afs/write.c
index dc66ff15dd16..3edb6204b937 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -377,6 +377,7 @@ static int afs_store_data(struct afs_vnode *vnode, str=
uct iov_iter *iter, loff_t
 =

 	afs_op_set_vnode(op, 0, vnode);
 	op->file[0].dv_delta =3D 1;
+	op->file[0].modification =3D true;
 	op->store.write_iter =3D iter;
 	op->store.pos =3D pos;
 	op->store.size =3D size;

