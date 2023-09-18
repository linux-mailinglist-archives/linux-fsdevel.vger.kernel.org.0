Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE77A47E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbjIRLGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjIRLFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC52FF;
        Mon, 18 Sep 2023 04:05:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7888321AB1;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695035117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQdnjHkpphpTUZvovpEEYbCyA4aD++DzvNzuV2MwetQ=;
        b=x6juv+yivgnzd1s2Cvo7yOHmPrQzRukbHDxCP1y1H/pXLOOkZnZSNPwQEi97Y5v7s/2ln8
        XZyyhroVs6lVY5TuobUIO0zBWsWuQCgGsq/DQXqJitW7DUN4avEjD1N/vqTFXUTBqmhHv5
        nP3RbTFVLiKCp8E/uw/Dl9VAsKfTKkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695035117;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQdnjHkpphpTUZvovpEEYbCyA4aD++DzvNzuV2MwetQ=;
        b=RNvEEQaqux8fUEAdfZUqsWWhx/kfpzRGbBVsEB8v0U6oh8r/nvHAHQ/dSF5jtFSCz8w7bE
        ofp/aLks2o/8V3Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 618C52C14F;
        Mon, 18 Sep 2023 11:05:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1AE0351CD149; Mon, 18 Sep 2023 13:05:17 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/18] fs: Allow fine-grained control of folio sizes
Date:   Mon, 18 Sep 2023 13:04:58 +0200
Message-Id: <20230918110510.66470-7-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110510.66470-1-hare@suse.de>
References: <20230918110510.66470-1-hare@suse.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Some filesystems want to be able to limit the maximum size of folios,
and some want to be able to ensure that folios are at least a certain
size.  Add mapping_set_folio_orders() to allow this level of control
(although it is not yet honoured).

[Pankaj]: added mapping_min_folio_order()

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/pagemap.h | 48 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 351c3b7f93a1..129d62a891be 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -202,10 +202,16 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
-	AS_LARGE_FOLIO_SUPPORT = 6,
-	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
+	AS_RELEASE_ALWAYS = 6,	/* Call ->release_folio(), even if no private data */
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
@@ -310,6 +316,29 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
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
@@ -323,7 +352,17 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
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
+}
+
+static inline unsigned mapping_min_folio_order(struct address_space *mapping)
+{
+	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MIN;
 }
 
 /*
@@ -332,8 +371,7 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
  */
 static inline bool mapping_large_folio_support(struct address_space *mapping)
 {
-	return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-		test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+	return mapping_max_folio_order(mapping) > 0;
 }
 
 static inline int filemap_nr_thps(struct address_space *mapping)
-- 
2.35.3

