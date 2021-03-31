Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999BC34FB17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 10:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhCaIGu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhCaIGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:06:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC25C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so749843pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWAi/i4+n9XG5D57vjCca2tNocYxaQJOYj5KH2bJ384=;
        b=RZluAmpVPY/CbIlIbdA+0c62E3RaPK7X2kaPMug+6FT1IdkqdLbD0JDQ/1qB0GTaLd
         3xWHfPP5ix1qLir1bh7GYWeeYSAyxgOoeneQhQ8C+rSbOVEvhsVIzTuNLjpZ75OZVz/1
         gjzVL64yoeihWGQttXTnmAFeBtV+kinB6o78cOXEeVF2qQcvP9SZvpe9kKZKBzy+iaYr
         DzSr4pM0otEObT7ZB7P2AaK8kfRjIRdTsKYTEm5NvCMt55BUfrumthb8igtzGcYfBU/0
         62TKBP1DXW1GHoAuCiRmURQ/QX/Wow6dnbXeiBxe7vfssgzh3PZAqzyCEJ6smTaXXORz
         1+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWAi/i4+n9XG5D57vjCca2tNocYxaQJOYj5KH2bJ384=;
        b=nPfQeIeI8FwCaaWSqc5CQJt7/IIwF1LaMnVeg1ZI0TaU7P+ts5vIoXV5xMXvAylpuu
         3UJ6Olf65Nti7se1fY6jRw9O1Na41xSOQkgmRyQXwNd/A9IR+wdA3Wzhk/60hbuulNqv
         NSndXd6HdieS07w0e7xKriZrwSHkMHL8J3re+cEQ+J089W8KTyvD73SmFmfLJ/hLPYfP
         DJO5djaqzrKPCMw3ckdKQBR/YZ0w6v7s1mNCg3rG6g2Y0Jq3BqbXAVpHpYdxWtLw81+O
         R59TwtVW+bBDUPdQa3CslaJiZ5cY9KQiu1rwPllsN6sNu3zO14zZjSMh0B7VoGSZb0wk
         YZyg==
X-Gm-Message-State: AOAM532sy+/YKCpgohAEkpt+FJf9m7EzHieeoc4iJPD81Ib9/ORVDr5R
        +p+J8j+p2LrvgVnsW+h/y4Xk
X-Google-Smtp-Source: ABdhPJy3zFXXY94dCfgdghyfBaBWmPxAwVoqJ1iw33xWHFE3N73rNivZ2bfmtjndrUUi51+8gKxZKw==
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr2251426pjb.60.1617177992113;
        Wed, 31 Mar 2021 01:06:32 -0700 (PDT)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id z25sm1310985pfn.37.2021.03.31.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 01:06:31 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 04/10] vhost-iotlb: Add an opaque pointer for vhost IOTLB
Date:   Wed, 31 Mar 2021 16:05:13 +0800
Message-Id: <20210331080519.172-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210331080519.172-1-xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an opaque pointer for vhost IOTLB. And introduce
vhost_iotlb_add_range_ctx() to accept it.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/iotlb.c       | 20 ++++++++++++++++----
 include/linux/vhost_iotlb.h |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..5c99e1112cbb 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -36,19 +36,21 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 EXPORT_SYMBOL_GPL(vhost_iotlb_map_free);
 
 /**
- * vhost_iotlb_add_range - add a new range to vhost IOTLB
+ * vhost_iotlb_add_range_ctx - add a new range to vhost IOTLB
  * @iotlb: the IOTLB
  * @start: start of the IOVA range
  * @last: last of IOVA range
  * @addr: the address that is mapped to @start
  * @perm: access permission of this range
+ * @opaque: the opaque pointer for the new mapping
  *
  * Returns an error last is smaller than start or memory allocation
  * fails
  */
-int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
-			  u64 start, u64 last,
-			  u64 addr, unsigned int perm)
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
+			      u64 start, u64 last,
+			      u64 addr, unsigned int perm,
+			      void *opaque)
 {
 	struct vhost_iotlb_map *map;
 
@@ -71,6 +73,7 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 	map->last = last;
 	map->addr = addr;
 	map->perm = perm;
+	map->opaque = opaque;
 
 	iotlb->nmaps++;
 	vhost_iotlb_itree_insert(map, &iotlb->root);
@@ -80,6 +83,15 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vhost_iotlb_add_range_ctx);
+
+int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
+			  u64 start, u64 last,
+			  u64 addr, unsigned int perm)
+{
+	return vhost_iotlb_add_range_ctx(iotlb, start, last,
+					 addr, perm, NULL);
+}
 EXPORT_SYMBOL_GPL(vhost_iotlb_add_range);
 
 /**
diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..2d0e2f52f938 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -17,6 +17,7 @@ struct vhost_iotlb_map {
 	u32 perm;
 	u32 flags_padding;
 	u64 __subtree_last;
+	void *opaque;
 };
 
 #define VHOST_IOTLB_FLAG_RETIRE 0x1
@@ -29,6 +30,8 @@ struct vhost_iotlb {
 	unsigned int flags;
 };
 
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb, u64 start, u64 last,
+			      u64 addr, unsigned int perm, void *opaque);
 int vhost_iotlb_add_range(struct vhost_iotlb *iotlb, u64 start, u64 last,
 			  u64 addr, unsigned int perm);
 void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last);
-- 
2.11.0

