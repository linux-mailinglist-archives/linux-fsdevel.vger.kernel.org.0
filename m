Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBC390483
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhEYPE0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 11:04:26 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:57635 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhEYPEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 11:04:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-C27MM2WqM9uHvpWp9PG4Lw-1; Tue, 25 May 2021 11:02:48 -0400
X-MC-Unique: C27MM2WqM9uHvpWp9PG4Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F161C801AF2;
        Tue, 25 May 2021 15:02:47 +0000 (UTC)
Received: from bahia.lan (ovpn-113-46.ams2.redhat.com [10.36.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DD3D5D6AC;
        Tue, 25 May 2021 15:02:46 +0000 (UTC)
From:   Greg Kurz <groug@kaod.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vivek Goyal <vgoyal@redhat.com>, virtio-fs@redhat.com,
        Greg Kurz <groug@kaod.org>
Subject: [PATCH 4/4] fuse: Make fuse_fill_super_submount() static
Date:   Tue, 25 May 2021 17:02:30 +0200
Message-Id: <20210525150230.157586-5-groug@kaod.org>
In-Reply-To: <20210525150230.157586-1-groug@kaod.org>
References: <20210525150230.157586-1-groug@kaod.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function used to be called from fuse_dentry_automount(). This code
was moved to fuse_get_tree_submount() in the same file since then. It
is unlikely there will ever be another user. No need to be extern in
this case.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fs/fuse/fuse_i.h | 9 ---------
 fs/fuse/inode.c  | 4 ++--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d7fcf59a6a0e..e2f5c8617e0d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1081,15 +1081,6 @@ void fuse_send_init(struct fuse_mount *fm);
  */
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx);
 
-/*
- * Fill in superblock for submounts
- * @sb: partially-initialized superblock to fill in
- * @parent_fi: The fuse_inode of the parent filesystem where this submount is
- * 	       mounted
- */
-int fuse_fill_super_submount(struct super_block *sb,
-			     struct fuse_inode *parent_fi);
-
 /*
  * Get the mountable root for the submount
  * @fsc: superblock configuration context
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 433ca2b13046..f591956c01b3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1275,8 +1275,8 @@ static void fuse_sb_defaults(struct super_block *sb)
 		sb->s_xattr = fuse_no_acl_xattr_handlers;
 }
 
-int fuse_fill_super_submount(struct super_block *sb,
-			     struct fuse_inode *parent_fi)
+static int fuse_fill_super_submount(struct super_block *sb,
+				    struct fuse_inode *parent_fi)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
-- 
2.31.1

