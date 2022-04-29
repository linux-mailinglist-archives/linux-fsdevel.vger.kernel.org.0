Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901495151ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379646AbiD2RaC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379524AbiD2R30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF60985B5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fNlCZXPKuBm6VOqh/zfrwpxBSeDGW/beXlyZ2VpUwJ0=; b=Q39RMJ17cXlicAVx6LmOlUfYWp
        iR31she0yAXnXYbsTKyFBFR1rje2wl9yniNKaeA+HRFcrDTcOGVvDOqVA2YNP8Ym2lh2uFc29RdGW
        2MfoMZHArQEYXpIxONnAESJCQe1G0HxZZxidpYLlMpOs/PBnaStwFRpFM+QtCY3ZSUEPY0YWjjsJs
        DFQx2RUlrU6U8GjN3V0xj4/2bV6Gy/soQkPM54c5UVIr0MrZJpp6SvTqFmlSZi29YlqHzsq+6ueKY
        Jb6t24TrLnQXYyx9lOMjvwHaQrGoGyxbebqqvDMHThHF4j3KK6QJRMAoc9bptPTmj2GLm/+QMIKGQ
        UpIK5qgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNZ-00CdZ2-4W; Fri, 29 Apr 2022 17:26:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 24/69] i915: Call aops write_begin() and write_end() directly
Date:   Fri, 29 Apr 2022 18:25:11 +0100
Message-Id: <20220429172556.3011843-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pagecache_write_begin() and pagecache_write_end() are now trivial
wrappers, so call the aops directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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

