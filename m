Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CA51F13F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiEHUea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiEHUdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F730E0B4
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y7ANhKBEeOL+HpxLMBbN76BQItszULMjrcPRRXnozKI=; b=leYMjraW6pWHlJrncaJD0Vv/DS
        S+hX3WJD0IRBfG8Ut87eO0Rt6COr82vwP/UcEIT7EOgRK9yBl0OEfiKOoajoEVkAqlJUe1SxeSwXC
        eCBiatExw3V/IYsk8CwE+tugGv1jGF21aA6VJ6L34COh7gCd0NePL3jL5iGFLLICwHXb6FKJcvYnq
        gARC2ARVqJ3tm1XsNeJX1Rrxh4zLFYh9uBWFG21LySlKmmINe07SBVSg982ReZBQAaOqdYWp5eL8S
        kjAUAZC6yhEYKO8zfR5bCsrxwM0ajl5lXMzSWxRrKAvAsTsnHcce8CicNHArT3q8W0WKkjiTrdxxO
        7ZGIwEBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXU-002nZy-F7; Sun, 08 May 2022 20:30:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 24/25] i915: Call aops write_begin() and write_end() directly
Date:   Sun,  8 May 2022 21:29:40 +0100
Message-Id: <20220508202941.667024-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508202941.667024-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508202941.667024-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 3a1c782ed791..e92cc9d7257c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -408,6 +408,7 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 	     const struct drm_i915_gem_pwrite *arg)
 {
 	struct address_space *mapping = obj->base.filp->f_mapping;
+	const struct address_space_operations *aops = mapping->a_ops;
 	char __user *user_data = u64_to_user_ptr(arg->data_ptr);
 	u64 remain, offset;
 	unsigned int pg;
@@ -465,9 +466,8 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err)
 			return err;
 
-		err = pagecache_write_begin(obj->base.filp, mapping,
-					    offset, len, 0,
-					    &page, &data);
+		err = aops->write_begin(obj->base.filp, mapping, offset, len,
+					&page, &data);
 		if (err < 0)
 			return err;
 
@@ -477,9 +477,8 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 						      len);
 		kunmap_atomic(vaddr);
 
-		err = pagecache_write_end(obj->base.filp, mapping,
-					  offset, len, len - unwritten,
-					  page, data);
+		err = aops->write_end(obj->base.filp, mapping, offset, len,
+				      len - unwritten, page, data);
 		if (err < 0)
 			return err;
 
@@ -622,6 +621,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
 {
 	struct drm_i915_gem_object *obj;
 	struct file *file;
+	const struct address_space_operations *aops;
 	resource_size_t offset;
 	int err;
 
@@ -633,15 +633,15 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
 	GEM_BUG_ON(obj->write_domain != I915_GEM_DOMAIN_CPU);
 
 	file = obj->base.filp;
+	aops = file->f_mapping->a_ops;
 	offset = 0;
 	do {
 		unsigned int len = min_t(typeof(size), size, PAGE_SIZE);
 		struct page *page;
 		void *pgdata, *vaddr;
 
-		err = pagecache_write_begin(file, file->f_mapping,
-					    offset, len, 0,
-					    &page, &pgdata);
+		err = aops->write_begin(file, file->f_mapping, offset, len,
+					&page, &pgdata);
 		if (err < 0)
 			goto fail;
 
@@ -649,9 +649,8 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *dev_priv,
 		memcpy(vaddr, data, len);
 		kunmap(page);
 
-		err = pagecache_write_end(file, file->f_mapping,
-					  offset, len, len,
-					  page, pgdata);
+		err = aops->write_end(file, file->f_mapping, offset, len, len,
+				      page, pgdata);
 		if (err < 0)
 			goto fail;
 
-- 
2.34.1

