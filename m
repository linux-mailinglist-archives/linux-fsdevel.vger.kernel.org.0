Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7BB63F4D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 17:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiLAQIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 11:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiLAQIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC3E00
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669910852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqommci96us+QVDcXaQm47rsizn+sT4z8GqL5KIOQ8U=;
        b=fI2eG2QIOnhah48j25e69uL647LB7FKbpOG/XSd9woM9ROr4ISTi0fj0LSa8eN2QhWxY4j
        zZl+WeQtBF66ZMOSTZzoREHFBD43EC3bURv1++CXkwphRMOSclRGxbXHGhyVxAGeposI4v
        xcw1Rvv3BHsTlUrkJuQARjli8Ueh9vU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-qMK60ov8MSi3UZwPT7S-dA-1; Thu, 01 Dec 2022 11:07:00 -0500
X-MC-Unique: qMK60ov8MSi3UZwPT7S-dA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30959800186;
        Thu,  1 Dec 2022 16:06:29 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-141.brq.redhat.com [10.40.192.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB4D111E3FA;
        Thu,  1 Dec 2022 16:06:27 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC 3/3] gfs2: Fix race between shrinker and gfs2_iomap_folio_done
Date:   Thu,  1 Dec 2022 17:06:19 +0100
Message-Id: <20221201160619.1247788-4-agruenba@redhat.com>
In-Reply-To: <20221201160619.1247788-1-agruenba@redhat.com>
References: <20221201160619.1247788-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In gfs2_iomap_folio_done(), add the modified buffer heads to the current
transaction while the folio is still locked.  Otherwise, the shrinker
can come in and free them before we get to gfs2_page_add_databufs().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 18dcaa95408e..d8d9ee843ac9 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -990,18 +990,17 @@ gfs2_iomap_folio_done(struct inode *inode, struct folio *folio,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 
-	folio_unlock(folio);
-
 	if (!gfs2_is_stuffed(ip))
 		gfs2_page_add_databufs(ip, &folio->page, offset_in_page(pos),
 				       copied);
 
+	folio_unlock(folio);
+	folio_put(folio);
+
 	if (tr->tr_num_buf_new)
 		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
 
 	gfs2_trans_end(sdp);
-
-	folio_put(folio);
 }
 
 static const struct iomap_folio_ops gfs2_iomap_folio_ops = {
-- 
2.38.1

