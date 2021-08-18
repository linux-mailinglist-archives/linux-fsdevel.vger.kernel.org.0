Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BBB3F0352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhHRMIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhHRMIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:08:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096A0C0613D9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:07:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o10so1723244plg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPJJmxsVnbJuWsaYefx+5ABSk3S/ct0HfhPILPNJBeY=;
        b=Il0dp2rPVUCBMX9KFhOtzGkP3WKDoZ1ZKEgN6kb2agZ8E5jDQdBcduO5z6+043hYpd
         Ufi8v00bjhHrLaYO9v2rUWDcl6NeckWKR50ZAjIC4vGPqrrZlcIMPniKBTLz+M0Ac2wW
         lvt2CQw2pwEwtNNuWnZO45Lx2NonUj7axKrI0LbgxlcXYK2MJA/2Yj/CJqtxZihF5DCw
         5ze/wh02hcvuQ7d/Huk7Si32RAeQhRmnTq9PC//bqKcyMAfDvauBXt0nHLNbXlQDNDnQ
         4Dsqf33aSduXN3Dv/itwrQsG8YwGNPtTScyWKAk0xLEiH1aFKpXXhY26VsmpguruySKm
         AP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPJJmxsVnbJuWsaYefx+5ABSk3S/ct0HfhPILPNJBeY=;
        b=qYoOApMvZQlBAwj5w0RrJDbx3h/IGFH0sTn/spbBDzyeXBNXlkvMoWsNw61e8wIX/d
         dPtPsjPSa6TPb7St2x4qUc4qj37y9QJdDJD7fpiOX6as/8nNEn9cd+3V0VVeYCKNJ39R
         So3YUYWLt63txZW3STqRKlRfJ/biaoaBwKSVdJge3Ble4KMnF00+lPEu5br3iFOsVSqT
         nwiqqSAab8KMKa6HSyf/DGoH/3Bu0MixU3732mkBkFMSOUuGzefqO8F1aM/YMgoU0WR0
         0Y+afroKsQzU8jRuESwt818JWz4/MhmipZHbSpMaWrFvgP/BccBRRCAsdMTUuG+to755
         Egsg==
X-Gm-Message-State: AOAM533QHcbq0q7uc3yLlCdrPqZDBnaoqUwJRelKRfHi8u8yIIhDfbNm
        qrITNn0bjlxTwaniLuXDkVCe
X-Google-Smtp-Source: ABdhPJwcXSEuwzRnGhI2y+Q5IbLvbn5O9K+BcqEVJ6ubab8h4kSTKekrk2aFvZ2U2B+Ykcq6j6DPIA==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr8802850pjb.187.1629288468662;
        Wed, 18 Aug 2021 05:07:48 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id c15sm5205386pjr.22.2021.08.18.05.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 05:07:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/12] iova: Export alloc_iova_fast() and free_iova_fast()
Date:   Wed, 18 Aug 2021 20:06:31 +0800
Message-Id: <20210818120642.165-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818120642.165-1-xieyongji@bytedance.com>
References: <20210818120642.165-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export alloc_iova_fast() and free_iova_fast() so that
some modules can make use of the per-CPU cache to get
rid of rbtree spinlock in alloc_iova() and free_iova()
during IOVA allocation.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/iova.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b6cf5f16123b..3941ed6bb99b 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -521,6 +521,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -538,6 +539,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
 	free_iova(iovad, pfn);
 }
+EXPORT_SYMBOL_GPL(free_iova_fast);
 
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-- 
2.11.0

