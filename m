Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956B6E75BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjDSIzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 04:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjDSIzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68594C0B
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681894457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J099iEeGas8X+c0Ugwu2YYwSR8o/a4NF1OsG1hAhZcc=;
        b=E1NxjYf//Dyhe34vdpIDycJkEsXgLmnhsduRP5H+RdrVxE35yRS1qs6AlV5n9FlMQpTEhQ
        vf4ZyM/SIcMEsz74DD0fUXW9r4ri46WH+9eLUY/Vn6FD5gtk8wTV4gKJ8xUd0/PswStvoe
        p4YypG+37HREIjMuh8uA6eMEwUpgpb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-1ikd473jN-q5I59GX08wYA-1; Wed, 19 Apr 2023 04:54:14 -0400
X-MC-Unique: 1ikd473jN-q5I59GX08wYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 532FE101A557;
        Wed, 19 Apr 2023 08:54:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A32BA1121314;
        Wed, 19 Apr 2023 08:54:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     dhowells@redhat.com, Ayush Jain <ayush.jain3@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Steve French <stfrench@microsoft.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] splice: Fix filemap of a blockdev
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1770754.1681894451.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 19 Apr 2023 09:54:11 +0100
Message-ID: <1770755.1681894451@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the new filemap_splice_read() function to get i_size from
in->f_mapping->host, not in->f_inode so that it works with block devices
too (in->f_inode points to the device file, which is typically zero size).

Fixes: 07073eb01c5f ("splice: Add a func to do a splice from a buffered fi=
le without ITER_PIPE")
Link: https://lore.kernel.org/r/0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.c=
om/
Reported-by: Ayush Jain <ayush.jain3@amd.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Steve French <stfrench@microsoft.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 470be06b6096..f86cc8acf33a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2902,7 +2902,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t =
*ppos,
 	do {
 		cond_resched();
 =

-		if (*ppos >=3D i_size_read(file_inode(in)))
+		if (*ppos >=3D i_size_read(in->f_mapping->host))
 			break;
 =

 		iocb.ki_pos =3D *ppos;
@@ -2918,7 +2918,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t =
*ppos,
 		 * part of the page is not copied back to userspace (unless
 		 * another truncate extends the file - this is desired though).
 		 */
-		isize =3D i_size_read(file_inode(in));
+		isize =3D i_size_read(in->f_mapping->host);
 		if (unlikely(*ppos >=3D isize))
 			break;
 		end_offset =3D min_t(loff_t, isize, *ppos + len);

