Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704B6757546
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 09:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGRH0u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjGRH0q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BF8EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689665163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a2DjjjM4FGyKHuuM5I0RdnKN+Rz/1iCrCtnKqTggf0w=;
        b=d5oId6SnVsywQNkuBnO5jZkLcBsuCdRET3Me4HIYFNCNOruX4tNpozQABCTyZIeixq5GXj
        XhiAbTZcqDjy4FhDLRFXNXCCqYjVyFVppABxCg8JQLJQNxLw4kiPybchrlPjyiJMj4Uotw
        y8GF+nD5BVqLL4hM4iTbgpnGb8L1VUk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-iBgJyNXFMd2Bc7GWA-cV6w-1; Tue, 18 Jul 2023 03:25:59 -0400
X-MC-Unique: iBgJyNXFMd2Bc7GWA-cV6w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993b803c391so60399066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 00:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689665158; x=1690269958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2DjjjM4FGyKHuuM5I0RdnKN+Rz/1iCrCtnKqTggf0w=;
        b=hoK7j7IsjJEHvqExsxgY1u9dZJl7eC8+GGr1hKqEQLQtx2fra69mXVY9yh6CVUxhEQ
         cQVk/0PpyzK9ouIw/kpH5GTEuacjz2M78bwPjScAVEe9/YczJo+wXI+EU8Tiy5yI38Wo
         iOqvYSqyOsiByNxZS/HqUJJWsc8ir8Vt90PyV25Xcn7QcPlYxYpacrs+J10d1xbNVD3D
         G1lp92l7Rm8i+9gJNN5WbiNuTWbUDG6UjBJBo9+TvmWwoPFDII9ZQ6Skj997WAFSwtc6
         CPiAw+g+28X1XE7G7pAmlSVJv7tZErTC+cjiyKZio1RxPcB6apmtlwLV4ziaN/vsAG7q
         Y21Q==
X-Gm-Message-State: ABy/qLauN9w44CrXTdirhFjbtyaRfLmHuuYaE0eUFQTqPxgw8KDbwKwA
        CNkFgxO4y+Gwui8Fid0TouDOa+08fLhE4rZuFHa8I7mihZwM/BiSmEhUHu5CS4jSv7AMBjggxfw
        JuqeEXwqAkS/jyMILe+ourWHA1w==
X-Received: by 2002:a17:906:54:b0:993:f349:c989 with SMTP id 20-20020a170906005400b00993f349c989mr10269303ejg.7.1689665158577;
        Tue, 18 Jul 2023 00:25:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrcxToIhvi9pZkYvgvkHEy7/T+z+0ZGTKH6gDMN7h9Tf78M3vRIMAt9t7XyJ2PXGXp2U1Bjw==
X-Received: by 2002:a17:906:54:b0:993:f349:c989 with SMTP id 20-20020a170906005400b00993f349c989mr10269288ejg.7.1689665158219;
        Tue, 18 Jul 2023 00:25:58 -0700 (PDT)
Received: from fedora.fritz.box ([2001:9e8:32ec:1b00:f440:b055:3d37:de8])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906378a00b00992025654c1sm632721ejc.179.2023.07.18.00.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:25:57 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2] xarray: Document necessary flag in alloc functions
Date:   Tue, 18 Jul 2023 09:25:34 +0200
Message-ID: <20230718072533.4305-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds a new line to the docstrings of functions wrapping __xa_alloc() and
__xa_alloc_cyclic(), informing about the necessity of flag XA_FLAGS_ALLOC
being set previously.

The documentation so far says that functions wrapping __xa_alloc() and
__xa_alloc_cyclic() are supposed to return either -ENOMEM or -EBUSY in
case of an error. If the xarray has been initialized without the flag
XA_FLAGS_ALLOC, however, they fail with a different, undocumented error
code.

As hinted at in Documentation/core-api/xarray.rst, wrappers around these
functions should only be invoked when the flag has been set. The
functions' documentation should reflect that as well.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Version 2 of the proposed documentation update. As Matthew requested, I
added the sentence to all functions wrapping the above mentioned two
core functions.
Additionally, I added it to themselves, too, as these functions can also
be called by the user directly.
I also rephrased the commit message so that the implemented change is
mentioned first.
---
 include/linux/xarray.h | 18 ++++++++++++++++++
 lib/xarray.c           |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 741703b45f61..cb571dfcf4b1 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,9 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -886,6 +889,9 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -916,6 +922,9 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -949,6 +958,9 @@ static inline int __must_check xa_alloc_irq(struct xarray *xa, u32 *id,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock.  May sleep if
  * the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -983,6 +995,9 @@ static inline int xa_alloc_cyclic(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Takes and releases the xa_lock while
  * disabling softirqs.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
@@ -1017,6 +1032,9 @@ static inline int xa_alloc_cyclic_bh(struct xarray *xa, u32 *id, void *entry,
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Process context.  Takes and releases the xa_lock while
  * disabling interrupts.  May sleep if the @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
diff --git a/lib/xarray.c b/lib/xarray.c
index 2071a3718f4e..73b3f8b33a56 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,9 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 on success, -ENOMEM if memory could not be allocated or
@@ -1850,6 +1853,9 @@ EXPORT_SYMBOL(__xa_alloc);
  * The search for an empty entry will start at @next and will wrap
  * around if necessary.
  *
+ * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
+ * in xa_init_flags().
+ *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
  * Return: 0 if the allocation succeeded without wrapping.  1 if the
-- 
2.41.0

