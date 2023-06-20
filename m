Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C873604C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 02:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFTABE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 20:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTABD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:01:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81951B6;
        Mon, 19 Jun 2023 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KKEFTk8JRt6auD81VmKR05IrMCjbBWj2nan8iYrIAco=; b=BkOXYWjJMwuH6Zf/knOFxYVi98
        fd+s04668WzEdHaEN9knVPmhJD88r5Szwp+63svW58n4YWbjfgEe5IUbE/4WcNI6oZPY2i6agFS+W
        5i7NMU95kpsHnNvQGotvj0CfVzaBAjxuMvkBRIv8u8F/dbtLUDW8bI7qJLuqflpUxilYGUY2S1k7p
        WYnZLwpdxquK22uwkYZ4u2WREnhvin0OQxu0LqII3DZ++DhdTDswWBJk9j35e0dkhGdbvV68Cj3n8
        96t48dolFnSI0lvPb64uVXfNLJP9FmSS4bTPQW1frFi5prRSOlsXarDZElqNB72Cb7uv8nthCP4v9
        edo1OPfg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBOnn-00CPuf-MT; Tue, 20 Jun 2023 00:00:55 +0000
Date:   Tue, 20 Jun 2023 01:00:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>, gost.dev@samsung.com
Subject: Re: [PATCH 6/7] mm/filemap: allocate folios with mapping blocksize
Message-ID: <ZJDsN3UHphxbFGDq@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-7-hare@suse.de>
 <CGME20230619080901eucas1p224e67aa31866d2ad8d259b2209c2db67@eucas1p2.samsung.com>
 <20230619080857.qxx5c7uaz6pm4h3m@localhost>
 <b6d982ce-3e7e-e433-8339-28ec8474df03@suse.de>
 <ZJDdbPwfXI6eR5vB@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XLFzhUqy5ZX2e7O9"
Content-Disposition: inline
In-Reply-To: <ZJDdbPwfXI6eR5vB@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XLFzhUqy5ZX2e7O9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2023 at 08:57:48AM +1000, Dave Chinner wrote:
> What is needed is a field into the mapping that defines the
> folio order that all folios allocated for the page cache must be
> aligned/sized to to allow them to be inserted into the mapping.

Attached patch from December 2020 ;-)

--XLFzhUqy5ZX2e7O9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fs-Allow-fine-grained-control-of-folio-sizes.patch"

From 1aeee696f4d322af5f34544e39fc00006c399fb8 Mon Sep 17 00:00:00 2001
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Date: Tue, 15 Dec 2020 10:57:34 -0500
Subject: [PATCH] fs: Allow fine-grained control of folio sizes

Some filesystems want to be able to limit the maximum size of folios,
and some want to be able to ensure that folios are at least a certain
size.  Add mapping_set_folio_orders() to allow this level of control
(although it is not yet honoured).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cad81db32e61..9cbb8bdbaee7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -198,9 +198,15 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
+	AS_FOLIO_ORDER_MIN = 8,
+	AS_FOLIO_ORDER_MAX = 13,
+	/* 8-17 are used for FOLIO_ORDER */
 };
 
+#define AS_FOLIO_ORDER_MIN_MASK	0x00001f00
+#define AS_FOLIO_ORDER_MAX_MASK 0x0002e000
+#define AS_FOLIO_ORDER_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
+
 /**
  * mapping_set_error - record a writeback error in the address_space
  * @mapping: the mapping in which an error should be set
@@ -290,6 +296,29 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
 	m->gfp_mask = mask;
 }
 
+/**
+ * mapping_set_folio_orders() - Set the range of folio sizes supported.
+ * @mapping: The file.
+ * @min: Minimum folio order (between 0-31 inclusive).
+ * @max: Maximum folio order (between 0-31 inclusive).
+ *
+ * The filesystem should call this function in its inode constructor to
+ * indicate which sizes of folio the VFS can use to cache the contents
+ * of the file.  This should only be used if the filesystem needs special
+ * handling of folio sizes (ie there is something the core cannot know).
+ * Do not tune it based on, eg, i_size.
+ * 
+ * Context: This should not be called while the inode is active as it
+ * is non-atomic.
+ */
+static inline void mapping_set_folio_orders(struct address_space *mapping,
+		unsigned int min, unsigned int max)
+{
+	mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+			(min << AS_FOLIO_ORDER_MIN) |
+			(max << AS_FOLIO_ORDER_MAX);
+}
+
 /**
  * mapping_set_large_folios() - Indicate the file supports large folios.
  * @mapping: The file.
@@ -303,7 +332,12 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
-	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	mapping_set_folio_orders(mapping, 0, 31);
+}
+
+static inline unsigned mapping_max_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MAX;
 }
 
 /*
@@ -312,8 +346,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.35.1


--XLFzhUqy5ZX2e7O9--
