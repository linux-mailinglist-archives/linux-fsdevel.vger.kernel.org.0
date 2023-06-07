Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B123725867
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbjFGIsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 04:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbjFGIsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987A1712
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686127642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8b14LlHo3zt86QE7i50t7gWF3Pe+IncdMmgq5VH/CA4=;
        b=MWPsrQdcsKzUKkNS+vS+Lfq/0sLRKVzv4hlG9gucV1d3hvcKgIB1tXu8wqgMBKosRTKos+
        r3FmOZcsD5Hk+M01KE7iNEK0P7hGF1BYVST9MWsDTd3hdizCfdsKXoUPVT/7vm7a4VmE0E
        +DKqcG5v1JP0n/YLUwgtsPopHAvjTZY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-xw3_LTiZMzKbmW33Oy1jXQ-1; Wed, 07 Jun 2023 04:47:15 -0400
X-MC-Unique: xw3_LTiZMzKbmW33Oy1jXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9527B1C0171B;
        Wed,  7 Jun 2023 08:47:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE3AB40CFD46;
        Wed,  7 Jun 2023 08:47:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix setting of mtime when creating a file/dir/symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2004569.1686127633.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 07 Jun 2023 09:47:13 +0100
Message-ID: <2004570.1686127633@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kafs incorrectly passes a zero mtime (ie. 1st Jan 1970) to the server when
creating a file, dir or symlink because the mtime recorded in the
afs_operation struct gets passed to the server by the marshalling routines=
,
but the afs_mkdir(), afs_create() and afs_symlink() functions don't set it=
.

This gets masked if a file or directory is subsequently modified.

Fix this by filling in op->mtime before calling the create op.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" conc=
ept")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 4dd97afa536c..5219182e52e1 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1358,6 +1358,7 @@ static int afs_mkdir(struct mnt_idmap *idmap, struct=
 inode *dir,
 	op->dentry	=3D dentry;
 	op->create.mode	=3D S_IFDIR | mode;
 	op->create.reason =3D afs_edit_dir_for_mkdir;
+	op->mtime	=3D current_time(dir);
 	op->ops		=3D &afs_mkdir_operation;
 	return afs_do_sync_operation(op);
 }
@@ -1661,6 +1662,7 @@ static int afs_create(struct mnt_idmap *idmap, struc=
t inode *dir,
 	op->dentry	=3D dentry;
 	op->create.mode	=3D S_IFREG | mode;
 	op->create.reason =3D afs_edit_dir_for_create;
+	op->mtime	=3D current_time(dir);
 	op->ops		=3D &afs_create_operation;
 	return afs_do_sync_operation(op);
 =

@@ -1796,6 +1798,7 @@ static int afs_symlink(struct mnt_idmap *idmap, stru=
ct inode *dir,
 	op->ops			=3D &afs_symlink_operation;
 	op->create.reason	=3D afs_edit_dir_for_symlink;
 	op->create.symlink	=3D content;
+	op->mtime		=3D current_time(dir);
 	return afs_do_sync_operation(op);
 =

 error:

