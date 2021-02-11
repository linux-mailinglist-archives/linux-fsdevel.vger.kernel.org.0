Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17600318866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 11:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBKKmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 05:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhBKKj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613039840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+SyF2BtAE/25+uPwUADIprxwsW3nW9d5uxrpM+pqMWk=;
        b=M2NcEz/JWSNYKYFHw0XW4SotG2ey0rGPGAHIG6BNgxRM9VnFnmWKin4z54TZGooWI4cFqD
        jurOxgK39zPbzxNua+ncQ/wk9xeRYUsSfygNNuYJ32tauSn6r9OBDGLOunQwnfd/NpVHNy
        KGrZuIyYk0HvCcP2szCLU6SV4cMCXKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-IGQ8H91jP_aFvh3dBB3pjg-1; Thu, 11 Feb 2021 05:37:18 -0500
X-MC-Unique: IGQ8H91jP_aFvh3dBB3pjg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDAB593B4;
        Thu, 11 Feb 2021 10:37:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D9460BF1;
        Thu, 11 Feb 2021 10:37:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix updating of i_mode due to 3rd party change
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 Feb 2021 10:37:14 +0000
Message-ID: <161303983470.1573213.1242074078169410167.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix afs_apply_status() to mask off the irrelevant bits from status->mode
when OR'ing them into i_mode.  This can happen when a 3rd party chmod
occurs.

Also fix afs_inode_init_from_status() to mask off the mode bits when
initialising i_mode.

Fixes: 260a980317da ("[AFS]: Add "directory write" support.")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index b0d7b892090d..d68abb9804b6 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -74,6 +74,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 	struct afs_file_status *status = &vp->scb.status;
 	struct inode *inode = AFS_VNODE_TO_I(vnode);
 	struct timespec64 t;
+	mode_t mode = status->mode & S_IALLUGO;
 
 	_enter("{%llx:%llu.%u} %s",
 	       vp->fid.vid, vp->fid.vnode, vp->fid.unique,
@@ -103,13 +104,13 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 
 	switch (status->type) {
 	case AFS_FTYPE_FILE:
-		inode->i_mode	= S_IFREG | status->mode;
+		inode->i_mode	= S_IFREG | mode;
 		inode->i_op	= &afs_file_inode_operations;
 		inode->i_fop	= &afs_file_operations;
 		inode->i_mapping->a_ops	= &afs_fs_aops;
 		break;
 	case AFS_FTYPE_DIR:
-		inode->i_mode	= S_IFDIR | status->mode;
+		inode->i_mode	= S_IFDIR | mode;
 		inode->i_op	= &afs_dir_inode_operations;
 		inode->i_fop	= &afs_dir_file_operations;
 		inode->i_mapping->a_ops	= &afs_dir_aops;
@@ -126,7 +127,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 			inode->i_fop	= &afs_mntpt_file_operations;
 			inode->i_mapping->a_ops	= &afs_fs_aops;
 		} else {
-			inode->i_mode	= S_IFLNK | status->mode;
+			inode->i_mode	= S_IFLNK | mode;
 			inode->i_op	= &afs_symlink_inode_operations;
 			inode->i_mapping->a_ops	= &afs_fs_aops;
 		}
@@ -199,7 +200,7 @@ static void afs_apply_status(struct afs_operation *op,
 	if (status->mode != vnode->status.mode) {
 		mode = inode->i_mode;
 		mode &= ~S_IALLUGO;
-		mode |= status->mode;
+		mode |= status->mode & S_IALLUGO;
 		WRITE_ONCE(inode->i_mode, mode);
 	}
 


