Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517E46618BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jan 2023 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjAHTnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 14:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjAHTnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A2BC91
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673206860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jtakh2AgEDKVCPUWaoe26OrkTCvuUUh6tKhp0SuOyNE=;
        b=UFUEfFnzu+apLBgsLR9/miU6HsYdY2+5USMIXDmQZg0tz8miBCzUU8XOTg33YmY5vnv6UZ
        yCGEWxQoxa/UbCUlD+l3DIx1R9a0VkSFvwZQOIL7ooJO6wFXFL6sDAU/b4/uiUmYF4XxOj
        OYRyl/K9CqMb0OQPgoQpc02MswTSArA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-xSd0PQZENraCFS7Qx9oJQg-1; Sun, 08 Jan 2023 14:40:56 -0500
X-MC-Unique: xSd0PQZENraCFS7Qx9oJQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F161875043;
        Sun,  8 Jan 2023 19:40:55 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-3.brq.redhat.com [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53A01492B06;
        Sun,  8 Jan 2023 19:40:53 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Subject: [RFC v6 06/10] iomap: Add __iomap_get_folio helper
Date:   Sun,  8 Jan 2023 20:40:30 +0100
Message-Id: <20230108194034.1444764-7-agruenba@redhat.com>
In-Reply-To: <20230108194034.1444764-1-agruenba@redhat.com>
References: <20230108194034.1444764-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an __iomap_get_folio() helper as the counterpart of the existing
__iomap_put_folio() helper.  Use the new helper in iomap_write_begin().
Not a functional change.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 418519dea2ce..666107c3a385 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -602,6 +602,17 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	return 0;
 }
 
+static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
+		size_t len)
+{
+	const struct iomap_page_ops *page_ops = iter->iomap.page_ops;
+
+	if (page_ops && page_ops->page_prepare)
+		return page_ops->page_prepare(iter, pos, len);
+	else
+		return iomap_get_folio(iter, pos);
+}
+
 static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
 		struct folio *folio)
 {
@@ -642,10 +653,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
 	if (!mapping_large_folio_support(iter->inode->i_mapping))
 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
 
-	if (page_ops && page_ops->page_prepare)
-		folio = page_ops->page_prepare(iter, pos, len);
-	else
-		folio = iomap_get_folio(iter, pos);
+	folio = __iomap_get_folio(iter, pos, len);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-- 
2.38.1

