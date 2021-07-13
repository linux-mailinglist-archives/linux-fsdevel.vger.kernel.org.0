Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF293C6C4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhGMIuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbhGMIuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039BAC0613F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b12so18896500pfv.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
        b=NFS9sf7oZs6OfC3ePyWxWOFYPRWYuHJEmSuowU4+A/AN9SkO5oklzsdY2KXu8XLaK/
         RtjCDzBNyMsdIgaq+gdMB7X3iSEzGHSn43PT3yYRI1O50eXo3lcMJohxW+FjS73Fgzhz
         cByWfSfvdlPZnHSM2paax8FVHByTKAKS59DKXws2obexLNMYBSz4JwJpnlbAFJbXemnl
         muonmUyFpQcCa6tNLtEtmhQrzdudI5qv9lDhSdlcAC7ix0U02RmFBKcz7hR6i8/sr/Il
         miY9BiEVBFNOzq9HdHWN3Ltqrr/qolEO7tzr92l33+PTeqr/Mh3jyfO+z8sDGyszPXwg
         lRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omwDqSVrMraB8zPCmbagpNybYhuwUgLxPSaQSPVKs0I=;
        b=S15e7CoiY4bpz55EJvVdazdY8LBbZABBJ6l/AK56yeZi3k5xJxJBqFbVQSpO4efvtK
         mLy2IRt3Ell0QKNzJFQ99DD0qQU/n/qOxG3nku3RgIAPgaqHFCRZaQ31OR0HUir3eU7l
         IXzYzGXDQoxeUxTpXdrbpqzuxljaKBzCskHlhO4xCpaJjGmXfcy+OGw7P9Tgokg1PL1+
         G5xLK0IONgTl/2Gtq4A9jhhJqt3xlDm5h/grieNDKJQNr8c+350T3RESxqOwZ+BpPzzP
         r4EXHpJmeDceejsiR8gyDOlo5p66oOJnHjKaebuuSsL7XcOkOPC7O7ch1gABoBdlGdve
         CmlQ==
X-Gm-Message-State: AOAM533m/hcTo08tEVm3fii5SFvOUrL9yU4zIgmemOeXBDz2pphn05lN
        PYEOPzHYSMO61q4bP2dbPHpW
X-Google-Smtp-Source: ABdhPJy1XC0KnBeCN6bWa8CB2iE99dOa7TYAMnl/f4lHXuMSNKXTJU6n9g1wg0BApWWsX8PXSpPEXw==
X-Received: by 2002:a63:1266:: with SMTP id 38mr3331831pgs.154.1626166046577;
        Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j21sm18231301pfn.35.2021.07.13.01.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:26 -0700 (PDT)
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
Subject: [PATCH v9 01/17] iova: Export alloc_iova_fast() and free_iova_fast()
Date:   Tue, 13 Jul 2021 16:46:40 +0800
Message-Id: <20210713084656.232-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
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

