Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FA939BCB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhFDQOG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 4 Jun 2021 12:14:06 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:26589 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231281AbhFDQOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:14:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-_9AFksQQM9iDjBrWox_Xcg-1; Fri, 04 Jun 2021 12:12:14 -0400
X-MC-Unique: _9AFksQQM9iDjBrWox_Xcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80AF9801817;
        Fri,  4 Jun 2021 16:12:13 +0000 (UTC)
Received: from bahia.lan (ovpn-112-232.ams2.redhat.com [10.36.112.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15F3060CEC;
        Fri,  4 Jun 2021 16:12:11 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 2/7] fuse: Fix crash if superblock of submount gets killed early
Date:   Fri,  4 Jun 2021 18:11:51 +0200
Message-Id: <20210604161156.408496-3-groug@kaod.org>
In-Reply-To: <20210604161156.408496-1-groug@kaod.org>
References: <20210604161156.408496-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As soon as fuse_dentry_automount() does up_write(&sb->s_umount), the
superblock can theoretically be killed. If this happens before the
submount was added to the &fc->mounts list, fuse_mount_remove() later
crashes in list_del_init() because it assumes the submount to be
already there.

Add the submount before dropping sb->s_umount to fix the inconsistency.
It is okay to nest fc->killsb under sb->s_umount, we already do this
on the ->kill_sb() path.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/dir.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 01559061cbfb..3fd1b71e546b 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -346,15 +346,15 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 		goto out_put_sb;
 	}
 
+	down_write(&fc->killsb);
+	list_add_tail(&fm->fc_entry, &fc->mounts);
+	up_write(&fc->killsb);
+
 	sb->s_flags |= SB_ACTIVE;
 	fsc->root = dget(sb->s_root);
 	/* We are done configuring the superblock, so unlock it */
 	up_write(&sb->s_umount);
 
-	down_write(&fc->killsb);
-	list_add_tail(&fm->fc_entry, &fc->mounts);
-	up_write(&fc->killsb);
-
 	/* Create the submount */
 	mnt = vfs_create_mount(fsc);
 	if (IS_ERR(mnt)) {
-- 
2.31.1

