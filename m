Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66648403D1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbhIHP7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352287AbhIHP7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XjM7hos/bk6GSEHMb1C4W4dz9En6EZ5b52WIsghKhKw=;
        b=ZjJghVQKPf9os+sjEVQVaNf7MoMdxTS00mNw4Jc+1aRmv6b+I648pduB6BGz/1IEQRtNCj
        lb0sseKN79Dy1XkkA4J1QrAUMdP/YDpdhWpQO/cST5LBLR1UZuBPF7kL185lNFy34jPN+c
        aPOrGc+MoEpbsznXQ2cGUcKyXLRkJas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-JScYIEKeOf2qXhsPbEOKRg-1; Wed, 08 Sep 2021 11:58:04 -0400
X-MC-Unique: JScYIEKeOf2qXhsPbEOKRg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B1A384A5E1;
        Wed,  8 Sep 2021 15:58:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC841100E107;
        Wed,  8 Sep 2021 15:58:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/6] afs: Fix incorrect triggering of sillyrename on 3rd-party
 invalidation
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Markus Suvanto <markus.suvanto@gmail.com>, dhowells@redhat.com,
        markus.suvanto@gmail.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:58:01 +0100
Message-ID: <163111668100.283156.3851669884664475428.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The AFS filesystem is currently triggering the silly-rename cleanup from
afs_d_revalidate() when it sees that a dentry has been changed by a third
party[1].  It should not be doing this as the cleanup includes deleting the
silly-rename target file on iput.

Fix this by removing the places in the d_revalidate handling that validate
anything other than the directory and the dirent.  It probably should not
be looking to validate the target inode of the dentry also.

This includes removing the point in afs_d_revalidate() where the inode that
a dentry used to point to was marked as being deleted (AFS_VNODE_DELETED).
We don't know it got deleted.  It could have been renamed or it could have
hard links remaining.

This was reproduced by cloning a git repo onto an afs volume on one
machine, switching to another machine and doing "git status", then
switching back to the first and doing "git status".  The second status
would show weird output due to ".git/index" getting deleted by the above
mentioned mechanism.

A simpler way to do it is to do:

	machine 1: touch a
	machine 2: touch b; mv -f b a
	machine 1: stat a

on an afs volume.  The bug shows up as the stat failing with ENOENT and the
file server log showing that machine 1 deleted "a".

Fixes: 79ddbfa500b3 ("afs: Implement sillyrename for unlink and rename")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214217#c4 [1]
---

 fs/afs/dir.c |   46 +++++++---------------------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a8e3ae55f1f9..4579bbda4634 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1077,9 +1077,9 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
  */
 static int afs_d_revalidate_rcu(struct dentry *dentry)
 {
-	struct afs_vnode *dvnode, *vnode;
+	struct afs_vnode *dvnode;
 	struct dentry *parent;
-	struct inode *dir, *inode;
+	struct inode *dir;
 	long dir_version, de_version;
 
 	_enter("%p", dentry);
@@ -1109,18 +1109,6 @@ static int afs_d_revalidate_rcu(struct dentry *dentry)
 			return -ECHILD;
 	}
 
-	/* Check to see if the vnode referred to by the dentry still
-	 * has a callback.
-	 */
-	if (d_really_is_positive(dentry)) {
-		inode = d_inode_rcu(dentry);
-		if (inode) {
-			vnode = AFS_FS_I(inode);
-			if (!afs_check_validity(vnode))
-				return -ECHILD;
-		}
-	}
-
 	return 1; /* Still valid */
 }
 
@@ -1156,17 +1144,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	if (IS_ERR(key))
 		key = NULL;
 
-	if (d_really_is_positive(dentry)) {
-		inode = d_inode(dentry);
-		if (inode) {
-			vnode = AFS_FS_I(inode);
-			afs_validate(vnode, key);
-			if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
-				goto out_bad;
-		}
-	}
-
-	/* lock down the parent dentry so we can peer at it */
+	/* Hold the parent dentry so we can peer at it */
 	parent = dget_parent(dentry);
 	dir = AFS_FS_I(d_inode(parent));
 
@@ -1175,7 +1153,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 
 	if (test_bit(AFS_VNODE_DELETED, &dir->flags)) {
 		_debug("%pd: parent dir deleted", dentry);
-		goto out_bad_parent;
+		goto not_found;
 	}
 
 	/* We only need to invalidate a dentry if the server's copy changed
@@ -1201,12 +1179,12 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	case 0:
 		/* the filename maps to something */
 		if (d_really_is_negative(dentry))
-			goto out_bad_parent;
+			goto not_found;
 		inode = d_inode(dentry);
 		if (is_bad_inode(inode)) {
 			printk("kAFS: afs_d_revalidate: %pd2 has bad inode\n",
 			       dentry);
-			goto out_bad_parent;
+			goto not_found;
 		}
 
 		vnode = AFS_FS_I(inode);
@@ -1228,9 +1206,6 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 			       dentry, fid.unique,
 			       vnode->fid.unique,
 			       vnode->vfs_inode.i_generation);
-			write_seqlock(&vnode->cb_lock);
-			set_bit(AFS_VNODE_DELETED, &vnode->flags);
-			write_sequnlock(&vnode->cb_lock);
 			goto not_found;
 		}
 		goto out_valid;
@@ -1245,7 +1220,7 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	default:
 		_debug("failed to iterate dir %pd: %d",
 		       parent, ret);
-		goto out_bad_parent;
+		goto not_found;
 	}
 
 out_valid:
@@ -1256,16 +1231,9 @@ static int afs_d_revalidate(struct dentry *dentry, unsigned int flags)
 	_leave(" = 1 [valid]");
 	return 1;
 
-	/* the dirent, if it exists, now points to a different vnode */
 not_found:
-	spin_lock(&dentry->d_lock);
-	dentry->d_flags |= DCACHE_NFSFS_RENAMED;
-	spin_unlock(&dentry->d_lock);
-
-out_bad_parent:
 	_debug("dropping dentry %pd2", dentry);
 	dput(parent);
-out_bad:
 	key_put(key);
 
 	_leave(" = 0 [bad]");


