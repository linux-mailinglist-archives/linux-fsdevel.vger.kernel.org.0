Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5A2E0C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgLVOxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbgLVOxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:53:52 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B8C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so8499624pgj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuS4MFGKOQ6wZmoJNuNdlFGLh2OpeJDnVRbM2jvzhBQ=;
        b=m4BAjxY/bQAuznhNdZPDHhxtD84Rnr52bsUNHZeWViOotIiiTQcYTFBGdhnZndjKLk
         OHw+OvpgKjX75tPYqSWtJWfbTAWdQQ/+lPFV0tb2pxQHf18C1jEL2rmD3GJOTJNJYw/r
         DfCFn95QHf56eVVAIb+nAOSxLi3jNYzogNHRvfiVvQJEPMO7nwk2+TZIV7gEvKeGxPHN
         0WWGOplq7NJVzbKmLM2RQs5OLK/X4a5JNAuoZ3Y9vW7v8dFfOxRwVQJzFHrg/vSKPVPa
         J3jnFdGx9AEYV1P1K+DxYo5Z2ZC7lJV5eYuCYuifIINKBww+dPW6mJzHxgD1lPM9W7c7
         lC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuS4MFGKOQ6wZmoJNuNdlFGLh2OpeJDnVRbM2jvzhBQ=;
        b=ndWIc4qwI47bTVLETbkPwScSmYTD275YCWdA4cgyfv+daThNfySBOdOKiqIT4GWY+e
         KCCN7b9Lmjef6uBInon4jTldxpsesQRd4ScXHOWrDBRnY1c/vccQbEO6s6x6yf6Gsaui
         AgoOzjt1fdVJI0TCt9YF4aiDJs4VMqNORSSKTJqwCgJfbSyLnu+1b06ol3jZkEmDA6p/
         5/6WGxNfv6j4QlKOsJKJ76VYwEht/Vcai4NhsQGrh9gsffxP90fD5YQfP6cg6Ff6hnSa
         yx6xYFiSlzfD7Is1uYNb7dorcJFtwMrEWVl9AeFfyfH3MUQFWeF1GQnKfmpUEy5pBd4U
         /JWQ==
X-Gm-Message-State: AOAM5304doGXWAOPGZJQ8UyMvr5dAx2t1EFE6Us8q1zCy+Fdy13jVbX9
        QhWcilw1AqKl2prE9dsPCDev
X-Google-Smtp-Source: ABdhPJwd0YzlNwNtksNu/va7c2CbgxXpbU4AvnZQJsZ90ddeykZ7FJJwEJpyVaPIxgF6wF8TuDIQsg==
X-Received: by 2002:a63:2406:: with SMTP id k6mr20214091pgk.453.1608648791343;
        Tue, 22 Dec 2020 06:53:11 -0800 (PST)
Received: from localhost ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id w63sm20402234pfc.20.2020.12.22.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:53:10 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, akpm@linux-foundation.org,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC v2 01/13] mm: export zap_page_range() for driver use
Date:   Tue, 22 Dec 2020 22:52:09 +0800
Message-Id: <20201222145221.711-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222145221.711-1-xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Export zap_page_range() for use in VDUSE.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index 7d608765932b..edd2d6497bb3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1542,6 +1542,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb, start, range.end);
 }
+EXPORT_SYMBOL(zap_page_range);
 
 /**
  * zap_page_range_single - remove user pages in a given range
-- 
2.11.0

