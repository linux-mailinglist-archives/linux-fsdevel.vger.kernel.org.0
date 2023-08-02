Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7B76D063
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjHBOox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjHBOov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C8E0
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690987442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lfsx7YMT1/nkAsgMqwMqDMIEJirhc7YJPrz4OW1nZfo=;
        b=ZDl3eriLs9LZhkNlVclb9zL0v80Kmrb/PL8gYHlRxPYbH9hAT59RBP5snjJvh6uGUPVcYz
        bZWp0UqBafa7Q8VErKPQ4edAZNAInvHfOeguW4CXVUtwihVAwwHB/63D/0XBonyXqXUyVX
        GnpMAzCJvdGXEupw5z5KbUoWpdbcDVQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-mTic3aWOO7WXjzYQIN77zA-1; Wed, 02 Aug 2023 10:43:57 -0400
X-MC-Unique: mTic3aWOO7WXjzYQIN77zA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5A73806705;
        Wed,  2 Aug 2023 14:43:56 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.225.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 019401121325;
        Wed,  2 Aug 2023 14:43:54 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] highmem: memcpy_{from,to}_folio() fix
Date:   Wed,  2 Aug 2023 16:43:54 +0200
Message-Id: <20230802144354.1023099-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memcpy_to_folio() and memcpy_from_folio() compute the size of the chunk
of memory they can copy for each page, but then they don't use the chunk
size in the actual memcpy.  Fix that.

Also, git rid of superfluous parentheses in these two functions.

Fixes: 520a10fe2d72 ("highmem: add memcpy_to_folio() and memcpy_from_folio()")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/highmem.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0280f57d4744..99c474de800d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -445,13 +445,13 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 	VM_BUG_ON(offset + len > folio_size(folio));
 
 	do {
-		char *from = kmap_local_folio(folio, offset);
+		const char *from = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
 		if (folio_test_highmem(folio) &&
-		    (chunk > (PAGE_SIZE - offset_in_page(offset))))
+		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
-		memcpy(to, from, len);
+		memcpy(to, from, chunk);
 		kunmap_local(from);
 
 		from += chunk;
@@ -470,9 +470,9 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 		size_t chunk = len;
 
 		if (folio_test_highmem(folio) &&
-		    (chunk > (PAGE_SIZE - offset_in_page(offset))))
+		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
-		memcpy(to, from, len);
+		memcpy(to, from, chunk);
 		kunmap_local(to);
 
 		from += chunk;
-- 
2.40.1

