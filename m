Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240FE718ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjEaWvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 18:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaWvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 18:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A1D124
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685573417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zpHJAAZtdS1eGDoBPdNCfJy7V4CHGDGY+NY0zDJG5HY=;
        b=K+rimdo8uWAlhWrvxbBsjEDBWEdHywAhlpoNQrVJadUCtumTG7DENQNlDvzwDSF1cmNvQh
        gFLlLHdtCG6OhQ8xioxRMAYkdrVlRxDm2Cld+VBAQjAOOJZBNC0Zdk+o3d/4PlikZHiK5E
        7LXCUeJFb468zCi6GMTesrXwQP2SlbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-7f37sz9DMzaFOEFZovZXsQ-1; Wed, 31 May 2023 18:50:14 -0400
X-MC-Unique: 7f37sz9DMzaFOEFZovZXsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 948E6800159;
        Wed, 31 May 2023 22:50:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE2932166B25;
        Wed, 31 May 2023 22:50:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix setting of mtime when creating a file/dir/symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <808139.1685573412.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 31 May 2023 23:50:12 +0100
Message-ID: <808140.1685573412@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

kafs incorrectly passes a zero mtime (ie. 1st Jan 1970) to the server when
creating a file, dir or symlink because commit 52af7105eceb caused the
mtime recorded in the afs_operation struct to be passed to the server, but
didn't modify the afs_mkdir(), afs_create() and afs_symlink() functions to
set it first.

Those functions were written with the assumption that the mtime would be
obtained from the server - but that fell foul of malsynchronised clocks, s=
o
it was decided that the mtime should be set from the client instead.

Fix this by filling in op->mtime before calling the create op.

Fixes: 52af7105eceb ("afs: Set mtime from the client for yfs create operat=
ions")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
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

