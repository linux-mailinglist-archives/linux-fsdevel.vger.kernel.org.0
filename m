Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C726356611E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 04:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiGECWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiGECWg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FBD210AD
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 19:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656987754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ylg4Pau4j+0Wi3P+QdsHAP6IDPjCd7WkHJuN8xLKC3I=;
        b=Hm7uQkdD/22A7oy+raJpgeKQEwqobOcCVJtIDefVRd9TwredsJ43vMMTUjE8eJR4hk+oZK
        Evk1hwLVjq3NIdTYzFgyAPfGvPABp9ZoM7lZ+pGD5NcDqKVU42EMXwdCViBjGODEi96fbV
        sgoM2ZAQwQ43I8kC/7/tsEkgPAEuEDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-duY3c0KQNwWyZbH2abTbOg-1; Mon, 04 Jul 2022 22:22:30 -0400
X-MC-Unique: duY3c0KQNwWyZbH2abTbOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53541804181;
        Tue,  5 Jul 2022 02:22:30 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6571121315;
        Tue,  5 Jul 2022 02:22:27 +0000 (UTC)
From:   xiubli@redhat.com
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [RFC PATCH] netfs: do not get the folio reference twice
Date:   Tue,  5 Jul 2022 10:22:19 +0800
Message-Id: <20220705022219.286459-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

And also the comment said it will drop the folio references but
the code was increasing it.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/netfs/buffered_read.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 5b93e22397fe..a44a5b3b8d4c 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -396,9 +396,6 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	 */
 	ractl._nr_pages = folio_nr_pages(folio);
 	netfs_rreq_expand(rreq, &ractl);
-
-	/* We hold the folio locks, so we can drop the references */
-	folio_get(folio);
 	while (readahead_folio(&ractl))
 		;
 
-- 
2.36.0.rc1

