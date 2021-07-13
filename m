Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B583C6C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhGMIvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhGMIvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:51:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B8C0613B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:48:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so1655767pju.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGl/RjOOzzXlpDeA69Ku950YCkBGnktZEIYihkRI6vQ=;
        b=f2iY73K9/iJbrFo2MgGFRZQ2tnpbs3ImXGvgYWrH8jbRwZtYrG0H49iFKE/gsgwKLy
         wVtyRbuwPA0zRTedHVys3XUYskroarJowEQpt+ZqI5TnDw7Zp23rmxpefDYE2fUT31OK
         Yx8EzxFOTu/Y54tuXZUybHIRyzZazhpojXPhI62Q8vKEpNQgs633F50M2v6JbT1SWtju
         /ZtqBhhqTVZGT9Le/4u/OKCsHRigEKlFME1X9DTpvhSS8l1I7+BAFOhoRdXOT1yNydWd
         YxmuE2ov3/MNlpLC8cpCwId08XpgeT4hgIX6doOocMtwfbp46o2SIwhFi6wDRfTBj+Ar
         hnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGl/RjOOzzXlpDeA69Ku950YCkBGnktZEIYihkRI6vQ=;
        b=stX6qccSLjcZxVi/4jvbFniQYUzuUe7lUr2w0EOh1xMAjfzLMjsqoc1ueGbODSKVLz
         fcXx5ea+7Ira56aMb1wkvH34/HvMj0myNOuOwnJTwEk2HgMYmO16F+3esKMPxb69A1HR
         d8gQ+hG0bKwG4XVDslwqNLhLvqAXvmiebZ3GsxkDM/OXgtnzzj1Tl75e8/x9KRSuxVUa
         4YSj1rp3FbL73TrKjb5dCa8L+cfIE2AsZsZ6uFw2LF2Uj0x92Tqy4BOTORwpotSYdQTm
         T7EbI+4Oup3zzsK25F0Z/tabsr6O7qmMA9c9fooVr/hBrZR+309EVTP/2fzgmUj647mG
         Dl+Q==
X-Gm-Message-State: AOAM5318olqKpxbQi/Fcb05QOEEFqJphn0aFYEof6hqIB9viY96BvqOm
        7cxjZL9dSztX8O6ZWqzdDVNP
X-Google-Smtp-Source: ABdhPJxyTVjwlLv6HFUW/HmnbuC6yzJVkXeQ5coeCepXZBwWX13HH6cyjAijtoaEpSnWsq9zQv6N4Q==
X-Received: by 2002:a17:903:4051:b029:12a:181c:9305 with SMTP id n17-20020a1709034051b029012a181c9305mr2713300pla.25.1626166083725;
        Tue, 13 Jul 2021 01:48:03 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id s15sm18640281pfw.207.2021.07.13.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:48:03 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/17] vhost-iotlb: Add an opaque pointer for vhost IOTLB
Date:   Tue, 13 Jul 2021 16:46:50 +0800
Message-Id: <20210713084656.232-12-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
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
index 0582079e4bcc..670d56c879e5 100644
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

