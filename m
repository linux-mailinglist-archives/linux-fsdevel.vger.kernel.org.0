Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB67C0355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 20:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjJJSXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbjJJSXU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:23:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9DAC;
        Tue, 10 Oct 2023 11:23:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4075c58ac39so4068025e9.3;
        Tue, 10 Oct 2023 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696962197; x=1697566997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMA7kWpWolO6o46k4syPx6Ijzen7WBJLxGU37wBIQCk=;
        b=k0poowsHvG8WaWKjxGDXJCPHXy3n7T8gxk3TPrThbGhgGQU8HzY25xEEuSFY3MHMzP
         ysMu33LWDsRG067OG/CL1v1jqiDeg3kpat8czY58R/WxGlILLaNN7/Erfo09E3891Q8Y
         wmqORgj5q/uVRIurZOhWKZnHmAVK/RvK/ECjD40o/hVzHWjwM1SB/EevTeZhupMNn1Ku
         1ZFkIdmfLI7k00pWgBiNNKgrjPLV0dOtgOwgN9j2x+VtY5Teb2AJM2dchFsK/eDYTGd8
         85QKdxKtgwjs40UgPIjUzCaYWFbtCGmwlN36q9Dcf4DcOnl8xkoqSlUbpUz99Pc9aGCP
         3lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696962197; x=1697566997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMA7kWpWolO6o46k4syPx6Ijzen7WBJLxGU37wBIQCk=;
        b=LmS5+xHEkxG+yKZVRca7blBFOOuTKHufG8L0WIct1cVjSA8IoVxmA5WzQxojD5XLqX
         Hper/DndLCnk/dcTQQ4DPkH1p2DLL+RiVmeN/b/14IFJnezT7uQhgUEpyf0KzYWaYkWJ
         9kF1l5Tzon/1ozqzoEK8GBP799cLv8KZUTRUGkOIu0QyQFKeACW/5a4j3j9z8HwXZ/DM
         EOh+ZGOYJY4f2KqYlkyr4Fc8vOPO3wFol/qcv/d9AfErQmSTCk2BQ5fEnzyaHpYZuXj9
         d55q2JGp4lNR6NCld/hE7bj18JowpKHJMsU+c9GyCWCwMqwZZiI4ybF2kCS0RHFllrEt
         NQSA==
X-Gm-Message-State: AOJu0Yxyuh+3wWv1F4O8/okLwIJ/3t2+4s9dyrhcwvc09vHrdD0npX+i
        ngkkIfPgXP0SycEth81et7Q=
X-Google-Smtp-Source: AGHT+IGLDXNqqFWzIJ3E5UNJ3YGOQGfTcbbOw8jJXvvcOCrF/m9VHiUs0OpxJ5FyKLoXpbpIYlkq4w==
X-Received: by 2002:adf:8b95:0:b0:32d:81f7:d6f2 with SMTP id o21-20020adf8b95000000b0032d81f7d6f2mr464917wra.30.1696962197081;
        Tue, 10 Oct 2023 11:23:17 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j16-20020a5d6190000000b003217cbab88bsm13225312wru.16.2023.10.10.11.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 11:23:15 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 1/5] mm: move vma_policy() and anon_vma_name() decls to mm_types.h
Date:   Tue, 10 Oct 2023 19:23:04 +0100
Message-ID: <24bfc6c9e382fffbcb0ea8d424392c27d56cc8ca.1696929425.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696929425.git.lstoakes@gmail.com>
References: <cover.1696929425.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vma_policy() define is a helper specifically for a VMA field so it
makes sense to host it in the memory management types header.

The anon_vma_name(), anon_vma_name_alloc() and anon_vma_name_free()
functions are a little out of place in mm_inline.h as they define external
functions, and so it makes sense to locate them in mm_types.h.

The purpose of these relocations is to make it possible to abstract static
inline wrappers which invoke both of these helpers.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mempolicy.h |  4 ----
 include/linux/mm_inline.h | 20 +-------------------
 include/linux/mm_types.h  | 27 +++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 3c208d4f0ee9..2801d5b0a4e9 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -89,8 +89,6 @@ static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
 	return pol;
 }
 
-#define vma_policy(vma) ((vma)->vm_policy)
-
 static inline void mpol_get(struct mempolicy *pol)
 {
 	if (pol)
@@ -222,8 +220,6 @@ static inline struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	return NULL;
 }
 
-#define vma_policy(vma) NULL
-
 static inline int
 vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst)
 {
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8148b30a9df1..9ae7def16cb2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/huge_mm.h>
+#include <linux/mm_types.h>
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
@@ -352,15 +353,6 @@ void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
-/*
- * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
- * either keep holding the lock while using the returned pointer or it should
- * raise anon_vma_name refcount before releasing the lock.
- */
-extern struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
-extern struct anon_vma_name *anon_vma_name_alloc(const char *name);
-extern void anon_vma_name_free(struct kref *kref);
-
 /* mmap_lock should be read-locked */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
 {
@@ -415,16 +407,6 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 }
 
 #else /* CONFIG_ANON_VMA_NAME */
-static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
-static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
-{
-	return NULL;
-}
-
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
 static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 36c5b43999e6..21eb56145f57 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -546,6 +546,27 @@ struct anon_vma_name {
 	char name[];
 };
 
+#ifdef CONFIG_ANON_VMA_NAME
+/*
+ * mmap_lock should be read-locked when calling anon_vma_name(). Caller should
+ * either keep holding the lock while using the returned pointer or it should
+ * raise anon_vma_name refcount before releasing the lock.
+ */
+struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma);
+struct anon_vma_name *anon_vma_name_alloc(const char *name);
+void anon_vma_name_free(struct kref *kref);
+#else /* CONFIG_ANON_VMA_NAME */
+static inline struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
+{
+	return NULL;
+}
+#endif
+
 struct vma_lock {
 	struct rw_semaphore lock;
 };
@@ -662,6 +683,12 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 } __randomize_layout;
 
+#ifdef CONFIG_NUMA
+#define vma_policy(vma) ((vma)->vm_policy)
+#else
+#define vma_policy(vma) NULL
+#endif
+
 #ifdef CONFIG_SCHED_MM_CID
 struct mm_cid {
 	u64 time;
-- 
2.42.0

