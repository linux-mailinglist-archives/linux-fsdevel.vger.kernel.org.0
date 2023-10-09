Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FA27BEBFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 22:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378037AbjJIUxl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIUxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:53:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E80A6;
        Mon,  9 Oct 2023 13:53:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3226cc3e324so4909135f8f.3;
        Mon, 09 Oct 2023 13:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696884815; x=1697489615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jochmgf2oxyHl1Fdsf6/Z0vhz675AmN7EMJ3Y7JXYH0=;
        b=BlWJ928czCmxUXHE9yDaFekmYQwrwx2M2dTJanSHnTnpcm46T43q+2BbSriIBCggCI
         omrl1Hfstn+EySkzfXES7l05BZrUMEGxPu8Ctszr2DakSA0ODmPzjdFBXTqAawUwHmj0
         4ORfBid86/rdQzFAwUQ90zyDRafz5K+7ZXTPbB90eSciLoYvtUbwOyIqLea37vvXaIRV
         u4Yop//TPjkvD+Y+86Nk4OW2s8f1IRQ9IZE65DweR1lLxBE5qsI+2pmQkjcqsY2ThOBx
         7HKphHQvdAo3ajbOjGs2/Mi81owBKUhZqXPYT+fFTG1yYOIVdbmAifiaWe2+DSEeKRuk
         bTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696884815; x=1697489615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jochmgf2oxyHl1Fdsf6/Z0vhz675AmN7EMJ3Y7JXYH0=;
        b=hUBdnKbt1nxxm0tYc9wLT6/QT3L4uAetdR/b0h9wAZpIhQ5S8g+GnSGLldFnGReWwd
         fxl3m9vERc6Gx1ZYIxorP0nEpuKJ8u9xaF7uDND+Jzsc64TiSo+bCmoc8IWkQsWE/lQQ
         Lds3dU+PzyoGUepjAD1mFDMOqSOOJicqIDnvdKzmVfEhrYw4HetlfK6oF9el+oor7DOZ
         z2nKpaG8ITgBX0frc2PaZVprazC8cyPpeqFcytVJ9sS1u2GZN6BvGdpvL8E/zB/bXeTQ
         cn5vqGrkJ0IWSObPLGOg5NPmqQX8l61HL2R8TVmTHH/eJ5ywUNXJ1DangG23B4EKONOV
         aTgg==
X-Gm-Message-State: AOJu0YzsRxZC4gVm4uXNZtcea7uKnBBXfJVx7kK5yXHt1NosP11fPoe5
        seK08Ze2CG0Fs6xrhsJJu/8=
X-Google-Smtp-Source: AGHT+IEili6yjcpf1CIpTHpX1KIvbP9i7YisloKuaIxOeqWIbartUF3HE3nQKw8VeOEZ+cxXGxy9ng==
X-Received: by 2002:a5d:4dcc:0:b0:321:62b0:7ad8 with SMTP id f12-20020a5d4dcc000000b0032162b07ad8mr14148854wru.16.1696884814438;
        Mon, 09 Oct 2023 13:53:34 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm10578130wrq.11.2023.10.09.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:53:33 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 1/5] mm: move vma_policy() and anon_vma_name() decls to mm_types.h
Date:   Mon,  9 Oct 2023 21:53:16 +0100
Message-ID: <4f1063f9c0e05ada89458083476e03434498e81e.1696884493.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696884493.git.lstoakes@gmail.com>
References: <cover.1696884493.git.lstoakes@gmail.com>
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

