Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B53A826A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhFOOSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhFOORE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6DC06114D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:13:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k22-20020a17090aef16b0290163512accedso1890405pjz.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqLi4n/sYt1V7zlXO7PEWrtyAjrct3aaeB0JWe6pldc=;
        b=hdxih8MIuJMG7DQ8ZmQrXh42xZ0vXefzPJ9Is4yeGeXwK9ruXKC6EBFn8DHqD+qX4B
         mXWvCicjq9IAlBh5wT9cKgIXtBv2V1Jt8Ml734PbO5KZR6ZfwAOwp2HqEzKJFVZ6LEjc
         jpr3DR3C7jV6q+xycSeDEyiUG5tdTsrQyhBszjQhllpSC6ihPrnYO3rbVtT0URaBUp8J
         Cbzhv1Hxb4BR27Ug0G/lD303gI6VNhL+3mm6r0pj60g/Lc5g3jB3iCJcKlWZyawmvu9X
         Mql527KcPIDMqPFgJV5a0yXFc8HVrjnBAmxl4aFB4nfYUtPTjOuU1i+1kYhrIB4V+EUy
         44+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqLi4n/sYt1V7zlXO7PEWrtyAjrct3aaeB0JWe6pldc=;
        b=KVDlnJbExF7BNTH1cucynMJO1uQ1RwzGYRZwj6fHYw/fa1SUa5dcIhnPYwtyApUvkV
         OHsMlDjv3ubnnBS64/aUfKd6iFoFWi7UEraE5PFJSvRpJnq/JuIYTMEx0QAZw7GGD/oC
         aODZXJaGI57cCW7tRnfZVA4EuU5I+Vd//tCKHy5JarmAo+q95VJ2xdXQb4yRGPwKD46z
         2AlHnXrH+3wtq99dwYxBy9r5z8AIIkwMbq0oyL9JZ+f+BhRNrvFKRWxjZNa4HFLUg1vW
         ukx7SK4F09UdPeho+SJhz5W0oZwNb/V2VmqajXxsAXO8PYOqMErDDXBV57Yyq2O4Oir9
         gW0A==
X-Gm-Message-State: AOAM532Cc2aSNd/tLl4YYPG2h9aZwi8ifAemO1nU+bqTGKsja1M6Tbxv
        G50e2w4s0rWjOvvvTmW3Vqdi
X-Google-Smtp-Source: ABdhPJwxO854wUtIh12JMTHVMysUOJZdmysPCLLcn5itcs7UedE9FRLaM9NJQ6d/dAmz1Dc2dO9hng==
X-Received: by 2002:a17:903:152:b029:10f:f6f7:ede5 with SMTP id r18-20020a1709030152b029010ff6f7ede5mr4636909plc.20.1623766437651;
        Tue, 15 Jun 2021 07:13:57 -0700 (PDT)
Received: from localhost ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id t14sm17322236pgm.9.2021.06.15.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:13:57 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/10] iova: Export alloc_iova_fast() and free_iova_fast();
Date:   Tue, 15 Jun 2021 22:13:22 +0800
Message-Id: <20210615141331.407-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210615141331.407-1-xieyongji@bytedance.com>
References: <20210615141331.407-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export alloc_iova_fast() and free_iova_fast() so that
some modules can use it to improve iova allocation efficiency.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/iommu/iova.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b7ecd5b08039..59916b4b7fe9 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -518,6 +518,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
+EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -535,6 +536,7 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
 	free_iova(iovad, pfn);
 }
+EXPORT_SYMBOL_GPL(free_iova_fast);
 
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
-- 
2.11.0

