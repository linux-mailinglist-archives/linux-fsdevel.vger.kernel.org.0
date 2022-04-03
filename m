Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E514F0B98
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Apr 2022 19:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357406AbiDCRkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Apr 2022 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiDCRkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FBFFBC30
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Apr 2022 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649007534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WfEGj5ceG/p9FhPNlbBqjh31Kc/B9BLJj4tt8CIkko4=;
        b=ZDNwMxt35CTaXZ0DMYYBSdi6h+n95eQuuQ/ovvPw/H7PdIbG1/Exte9Tf2pP449TxhCmdU
        a4EdrQRfqGqmkLKBidNoL+GSbXvLFl+uCHtq48NQPcrpztWFyQpa5gE60VgCs3gj/l+RuX
        oQtKLSXGGy5Rqbb/AptPYAtc44HGnoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-2NLJVWj6NIWamtIelkQ4ag-1; Sun, 03 Apr 2022 13:38:53 -0400
X-MC-Unique: 2NLJVWj6NIWamtIelkQ4ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 991B7811E75;
        Sun,  3 Apr 2022 17:38:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 827ED202E4A0;
        Sun,  3 Apr 2022 17:38:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Enable multipage folio support
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        kafs-testing@auristor.com, Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 03 Apr 2022 18:38:50 +0100
Message-ID: <164900753080.506134.4043293668627017602.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable multipage folio support for the afs filesystem.  This makes use of
Matthew Wilcox's latest folio changes.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: kafs-testing@auristor.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/lkml/2274528.1645833226@warthog.procyon.org.uk/
---

 fs/afs/inode.c |    2 ++
 fs/afs/write.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 2fe402483ad5..c899977493b4 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -104,12 +104,14 @@ static int afs_inode_init_from_status(struct afs_operation *op,
 		inode->i_op	= &afs_file_inode_operations;
 		inode->i_fop	= &afs_file_operations;
 		inode->i_mapping->a_ops	= &afs_file_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	= S_IFDIR |  (status->mode & S_IALLUGO);
 		inode->i_op	= &afs_dir_inode_operations;
 		inode->i_fop	= &afs_dir_file_operations;
 		inode->i_mapping->a_ops	= &afs_dir_aops;
+		mapping_set_large_folios(inode->i_mapping);
 		break;
 	case AFS_FTYPE_SYMLINK:
 		/* Symlinks with a mode of 0644 are actually mountpoints. */
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 6bcf1475511b..445a79db0192 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -91,7 +91,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 			goto flush_conflicting_write;
 	}
 
-	*_page = &folio->page;
+	*_page = folio_file_page(folio, pos / PAGE_SIZE);
 	_leave(" = 0");
 	return 0;
 


