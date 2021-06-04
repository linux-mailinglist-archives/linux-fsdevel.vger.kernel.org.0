Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4799739BCBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFDQOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Jun 2021 12:14:14 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:39339 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231364AbhFDQOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:14:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-_RUPiRYdMxioWwaBmDx_Hw-1; Fri, 04 Jun 2021 12:12:23 -0400
X-MC-Unique: _RUPiRYdMxioWwaBmDx_Hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE2D080293B;
        Fri,  4 Jun 2021 16:12:22 +0000 (UTC)
Received: from bahia.lan (ovpn-112-232.ams2.redhat.com [10.36.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65DBE60D06;
        Fri,  4 Jun 2021 16:12:21 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 6/7] fuse: Switch to fc_mount() for submounts
Date:   Fri,  4 Jun 2021 18:11:55 +0200
Message-Id: <20210604161156.408496-7-groug@kaod.org>
In-Reply-To: <20210604161156.408496-1-groug@kaod.org>
References: <20210604161156.408496-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fc_mount() already handles the vfs_get_tree(), sb->s_umount
unlocking and vfs_create_mount() sequence. Using it greatly
simplifies fuse_dentry_automount().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b88e5785a3dd..fc9eddf7f9b2 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -311,38 +311,22 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 	struct fs_context *fsc;
 	struct vfsmount *mnt;
 	struct fuse_inode *mp_fi = get_fuse_inode(d_inode(path->dentry));
-	int err;
 
 	fsc = fs_context_for_submount(path->mnt->mnt_sb->s_type, path->dentry);
-	if (IS_ERR(fsc)) {
-		err = PTR_ERR(fsc);
-		goto out;
-	}
+	if (IS_ERR(fsc))
+		return (struct vfsmount *) fsc;
 
 	/* Pass the FUSE inode of the mount for fuse_get_tree_submount() */
 	fsc->fs_private = mp_fi;
 
-	err = vfs_get_tree(fsc);
-	if (err)
-		goto out_put_fsc;
-
-	/* We are done configuring the superblock, so unlock it */
-	up_write(&fsc->root->d_sb->s_umount);
-
 	/* Create the submount */
-	mnt = vfs_create_mount(fsc);
-	if (IS_ERR(mnt)) {
-		err = PTR_ERR(mnt);
+	mnt = fc_mount(fsc);
+	if (IS_ERR(mnt))
 		goto out_put_fsc;
-	}
 	mntget(mnt);
-	put_fs_context(fsc);
-	return mnt;
-
 out_put_fsc:
 	put_fs_context(fsc);
-out:
-	return ERR_PTR(err);
+	return mnt;
 }
 
 const struct dentry_operations fuse_dentry_operations = {
-- 
2.31.1

