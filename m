Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF82E36D51D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbhD1JzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbhD1JzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:55:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DECC06138A
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t13so6440427pji.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tOlUteNHINhRpZtpztBeELGSpydzeET01dFGAMvcB9w=;
        b=LEEZH5u64AUh+ynJYV212VHcTTq3jo7SOak1Z80frSXjEr35j/gMZeBApZgIac5EtK
         oyQLEU220WgDEPzQQt937Zemxc7veTiPvTy2Rem1vxKR5EMp3d0T0RkE6upT1Nx13pd3
         ct69tBbCAl5PkeCcTgc9IYO1AqQ4C5KPm82xwGXsp+4PGuex1H2KlazxCnxlGyVZwc5j
         Fs3/VxauZ9qh06JmV+1Po+DoXkgn8GDqHvtx/snioyeBACqoFzuMhU4SBVX7lh2/yQ8s
         hU0c7U9jmWxlmiUBhSuIaccnhBlEYqFEurNWm6cRlhEbmb8D8OXWCCXdL2sH6LGIxV++
         yNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tOlUteNHINhRpZtpztBeELGSpydzeET01dFGAMvcB9w=;
        b=hEnDMayWGj6/B0xMP2YG5U3SAwplI1AB/SY3fNDfynJSUD1h5cUSWRO4scnowKcZLk
         Y0WptSm+2iNm+cevR0Uzt97a1Y9nppnladYMgYKifWhoe1qjKNEVywkNQ5fBz2HqiLTj
         Vau9ICZyf2eRrgsseKY5HY1wlOcXwR3kEpwdcQupmcSaherJnVslXIoTzGmqCql7J5P0
         Fu830Fn9++cTHwRFkkq9p5jFZuhf8ga71o2T4nByUNgOiQ8oPVNtC6Wwds+0ktdif/Ki
         i2+1qnshQ3qJvptZRi0rlOite1xyF7YcTFKxRDB7adX0c7PRPjfGflPtoaTYew102agC
         ENFQ==
X-Gm-Message-State: AOAM532mO0/YlKCKVUm5I0LBXQznLh/Ktk4+bQ20BuBKR7scnid/ndUH
        B3w4s2Hft20X7BuJf8nI+Thf9FZs2IBIMQ==
X-Google-Smtp-Source: ABdhPJyrBDmZk/mG3JBVhVPM7uIF8K2OuTdn8hm9YJpozguzJZ16PR0+D5tUGPQdGb8zskw4RSE7hg==
X-Received: by 2002:a17:90b:1bc1:: with SMTP id oa1mr30557077pjb.46.1619603677248;
        Wed, 28 Apr 2021 02:54:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.54.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:54:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 7/9] ida: introduce ida_max() to return the maximum allocated ID
Date:   Wed, 28 Apr 2021 17:49:47 +0800
Message-Id: <20210428094949.43579-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210428094949.43579-1-songmuchun@bytedance.com>
References: <20210428094949.43579-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce ida_max() to return the maximum allocated ID. This will be
used by memory cgroup in the later patch.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/idr.h |  1 +
 lib/idr.c           | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..c3968a6348d1 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -255,6 +255,7 @@ struct ida {
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
 void ida_free(struct ida *, unsigned int id);
 void ida_destroy(struct ida *ida);
+int ida_max(struct ida *ida);
 
 /**
  * ida_alloc() - Allocate an unused ID.
diff --git a/lib/idr.c b/lib/idr.c
index f4ab4f4aa3c7..bcfcaae89aa7 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -553,6 +553,46 @@ void ida_destroy(struct ida *ida)
 }
 EXPORT_SYMBOL(ida_destroy);
 
+/**
+ * ida_max() - Return the maximum allocated ID.
+ * @ida: IDA handle.
+ *
+ * Context: Any context. It is safe to call this function without
+ * locking in your code.
+ *
+ * Return: The maximum allocated ID, or %-ENOSPC if the @ida is empty
+ */
+int ida_max(struct ida *ida)
+{
+	XA_STATE(xas, &ida->xa, 0);
+	struct ida_bitmap *curr, *prev;
+	unsigned long flags;
+	unsigned int bit, index;
+
+	xas_lock_irqsave(&xas, flags);
+	if (ida_is_empty(ida)) {
+		xas_unlock_irqrestore(&xas, flags);
+		return -ENOSPC;
+	}
+
+	xas_for_each(&xas, curr, ULONG_MAX) {
+		prev = curr;
+		index = xas.xa_index;
+	}
+
+	if (xa_is_value(prev)) {
+		unsigned long val = xa_to_value(prev);
+
+		bit = find_last_bit(&val, BITS_PER_XA_VALUE);
+	} else {
+		bit = find_last_bit(prev->bitmap, IDA_BITMAP_BITS);
+	}
+
+	xas_unlock_irqrestore(&xas, flags);
+
+	return index * IDA_BITMAP_BITS + bit;
+}
+
 #ifndef __KERNEL__
 extern void xa_dump_index(unsigned long index, unsigned int shift);
 #define IDA_CHUNK_SHIFT		ilog2(IDA_BITMAP_BITS)
-- 
2.11.0

