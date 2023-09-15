Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B777A264D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjIOSmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbjIOSmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:42:24 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768214680;
        Fri, 15 Sep 2023 11:39:05 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RnNJ229ddz9sb6;
        Fri, 15 Sep 2023 20:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=brBNMMPFZ5PlP6sQBgu5Kl4G5NsTW4oPgHcishpd4rM=;
        b=H7FtLCnsLxyZnEESEUmlYWwS3HUNf7y+ztfA2o6k0H9UD8DCi3iwUcQnp3b4jG22OqxQbD
        QFM0/lErD72ozGWznO0iOZsF/atrGWdf8N0u0R3Hkq8bk4gUT8aW8HcT+jRBFgWwrxd5Uu
        Vus+AuRm5kbgPF1yfrMOE6cGiK4o8d/jv+ywz+Xqn4cOuOZ1fLpob2vRdUi+oU+M3pmIxD
        7LGMNt7s1tjXR7rXizanhCgb+FofT9t8HGdpJGNM+Kvt4gFJP8E3aU4RSYvWNgOL3dM2Cw
        rRU9mtKpZUVYEbkvs1/Q3spYJvwdrLhTQ+XZxP+V81DGW/fDC1ukMiA9Fhc+fQ==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 02/23] pagemap: use mapping_min_order in fgf_set_order()
Date:   Fri, 15 Sep 2023 20:38:27 +0200
Message-Id: <20230915183848.1018717-3-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

fgf_set_order() encodes optimal order in fgp flags. Set it to at least
mapping_min_order from the page cache. Default to the old behaviour if
min_order is not set.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/iomap/buffered-io.c  | 2 +-
 include/linux/pagemap.h | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ae8673ce08b1..d4613fd550c4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -549,7 +549,7 @@ struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len)
 
 	if (iter->flags & IOMAP_NOWAIT)
 		fgp |= FGP_NOWAIT;
-	fgp |= fgf_set_order(len);
+	fgp |= fgf_set_order(iter->inode->i_mapping, len);
 
 	return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
 			fgp, mapping_gfp_mask(iter->inode->i_mapping));
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d2b5308cc59e..5d392366420a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -620,6 +620,7 @@ typedef unsigned int __bitwise fgf_t;
 
 /**
  * fgf_set_order - Encode a length in the fgf_t flags.
+ * @mapping: address_space struct from the inode
  * @size: The suggested size of the folio to create.
  *
  * The caller of __filemap_get_folio() can use this to suggest a preferred
@@ -629,13 +630,13 @@ typedef unsigned int __bitwise fgf_t;
  * due to alignment constraints, memory pressure, or the presence of
  * other folios at nearby indices.
  */
-static inline fgf_t fgf_set_order(size_t size)
+static inline fgf_t fgf_set_order(struct address_space *mapping, size_t size)
 {
 	unsigned int shift = ilog2(size);
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	int order = max(min_order, shift - PAGE_SHIFT);
 
-	if (shift <= PAGE_SHIFT)
-		return 0;
-	return (__force fgf_t)((shift - PAGE_SHIFT) << 26);
+	return (__force fgf_t)((order) << 26);
 }
 
 void *filemap_get_entry(struct address_space *mapping, pgoff_t index);
-- 
2.40.1

