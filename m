Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3448A4C524C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 00:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiBYXya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 18:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbiBYXya (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2A862118D7
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 15:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645833235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GrI8ebRYRbXaMx78aEKS9TwwZap85Vbp7OV2dX4WbXo=;
        b=LtmtKArmEBtUhFYM386XOuvf4a3ZwWKF98UsHGMxkN/4EvyWwBJf+x5bzJkQUS/KsW/WGg
        pFT/4htjTd/8LKmTruOfVNoeWMXCjGI6h3Bzggs68/yqW4tbU/qWPt6bjvpnbXKhcP3g0v
        IqqZIOR60oaaBPhhxBuvToQ/ogc/vDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-3-pF4w_JMh6873ybvnYtww-1; Fri, 25 Feb 2022 18:53:52 -0500
X-MC-Unique: 3-pF4w_JMh6873ybvnYtww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C3D801AAD;
        Fri, 25 Feb 2022 23:53:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B44E34B5D;
        Fri, 25 Feb 2022 23:53:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
cc:     dhowells@redhat.com, jlayton@kernel.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Enable multipage folio support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2274527.1645833226.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 25 Feb 2022 23:53:46 +0000
Message-ID: <2274528.1645833226@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable multipage folio support for the afs filesystem.  This is on top of
Matthew Wilcox's for-next branch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c |    2 ++
 fs/afs/write.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 5964f8aee090..7dc7eb5f8e63 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -96,12 +96,14 @@ static int afs_inode_init_from_status(struct afs_opera=
tion *op,
 		inode->i_op	=3D &afs_file_inode_operations;
 		inode->i_fop	=3D &afs_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_file_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	=3D S_IFDIR |  (status->mode & S_IALLUGO);
 		inode->i_op	=3D &afs_dir_inode_operations;
 		inode->i_fop	=3D &afs_dir_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_dir_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_SYMLINK:
 		/* Symlinks with a mode of 0644 are actually mountpoints. */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 5e9157d0da29..d6cc0fa44316 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -91,7 +91,7 @@ int afs_write_begin(struct file *file, struct address_sp=
ace *mapping,
 			goto flush_conflicting_write;
 	}
 =

-	*_page =3D &folio->page;
+	*_page =3D folio_file_page(folio, pos / PAGE_SIZE);
 	_leave(" =3D 0");
 	return 0;
 =

