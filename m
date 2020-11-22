Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E402BC5C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Nov 2020 14:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKVNNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 08:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727721AbgKVNNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 08:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606050831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2ZpaheZQd4ao1ows6/rlyuwIugzpOFEGvsgoNS41pDU=;
        b=VW0JcAZF0e/SvQVq90HqIGUlMMewTz0LzRP4vpNHHrWUs1JK4aYc+eGL/NjSqK/Xh6dcxi
        3y8y9BxGJwMYcY1kkeneAopUMNwMua5wGOMbFm95prf4n/25GhLS/+2g4nEpRUdFk5vWfV
        zW/cs+eH0bbEv8L0RG5BgiDFOHLVhqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-FjNuDw-WMWCuHrCkHSmPQg-1; Sun, 22 Nov 2020 08:13:49 -0500
X-MC-Unique: FjNuDw-WMWCuHrCkHSmPQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76CF68049E9;
        Sun, 22 Nov 2020 13:13:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3556F5D6CF;
        Sun, 22 Nov 2020 13:13:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix speculative status fetch going out of order wrt to
 modifications
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 22 Nov 2020 13:13:45 +0000
Message-ID: <160605082531.252452.14708077925602709042.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When doing a lookup in a directory, the afs filesystem uses a bulk status
fetch to speculatively retrieve the statuses of up to 48 other vnodes found
in the same directory and it will then either update extant inodes or
create new ones - effectively doing 'lookup ahead'.

To avoid the possibility of deadlocking itself, however, the filesystem
doesn't lock all of those inodes; rather just the directory inode is locked
(by the VFS).  When the operation completes, afs_inode_init_from_status()
or afs_apply_status() is called, depending on whether the inode already
exists, to commit the new status.

A case exists, however, where the speculative status fetch operation may
straddle a modification operation on one of those vnodes.  What can then
happen is that the speculative bulk status RPC retrieves the old status,
and whilst that is happening, the modification happens - which returns an
updated status, then the modification status is committed, then we attempt
to commit the speculative status.

This results in something like the following being seen in dmesg:

	kAFS: vnode modified {100058:861} 8->9 YFS.InlineBulkStatus

showing that for vnode 861 on volume 100058, we saw YFS.InlineBulkStatus
say that the vnode had data version 8 when we'd already recorded version 9
due to a local modification.  This was causing the cache to be invalidated
for that vnode when it shouldn't have been.  If it happens on a data file,
this might lead to local changes being lost.

Fix this by ignoring speculative status updates if the data version doesn't
match the expected value.

Note that it is possible to get a DV regression if a volume gets restored
from a backup - but we should get a callback break in such a case that
should trigger a recheck anyway.  It might be worth checking the volume
creation time in the volsync info and, if a change is observed in that (as
would happen on a restore), invalidate all caches associated with the
volume.

Fixes: 5cf9dd55a0ec ("afs: Prospectively look up extra files when doing a single lookup")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c      |    1 +
 fs/afs/inode.c    |    8 ++++++++
 fs/afs/internal.h |    1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1bb5b9d7f0a2..9068d5578a26 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -823,6 +823,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 				vp->cb_break_before = afs_calc_vnode_cb_break(vnode);
 				vp->vnode = vnode;
 				vp->put_vnode = true;
+				vp->speculative = true; /* vnode not locked */
 			}
 		}
 	}
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 0fe8844b4bee..b0d7b892090d 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -294,6 +294,13 @@ void afs_vnode_commit_status(struct afs_operation *op, struct afs_vnode_param *v
 			op->flags &= ~AFS_OPERATION_DIR_CONFLICT;
 		}
 	} else if (vp->scb.have_status) {
+		if (vp->dv_before + vp->dv_delta != vp->scb.status.data_version &&
+		    vp->speculative)
+			/* Ignore the result of a speculative bulk status fetch
+			 * if it splits around a modification op, thereby
+			 * appearing to regress the data version.
+			 */
+			goto out;
 		afs_apply_status(op, vp);
 		if (vp->scb.have_cb)
 			afs_apply_callback(op, vp);
@@ -305,6 +312,7 @@ void afs_vnode_commit_status(struct afs_operation *op, struct afs_vnode_param *v
 		}
 	}
 
+out:
 	write_sequnlock(&vnode->cb_lock);
 
 	if (vp->scb.have_status)
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 14d5d75f4b6e..0d150a29e39e 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -755,6 +755,7 @@ struct afs_vnode_param {
 	bool			update_ctime:1;	/* Need to update the ctime */
 	bool			set_size:1;	/* Must update i_size */
 	bool			op_unlinked:1;	/* True if file was unlinked by op */
+	bool			speculative:1;	/* T if speculative status fetch (no vnode lock) */
 };
 
 /*


