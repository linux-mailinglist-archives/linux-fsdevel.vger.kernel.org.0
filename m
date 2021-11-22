Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E9459178
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbhKVPgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 10:36:03 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39853 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbhKVPf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 10:35:59 -0500
Received: by mail-ed1-f48.google.com with SMTP id w1so78818501edc.6;
        Mon, 22 Nov 2021 07:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8QBm+j0TklA89F5YujdZFJMji+n7PGQ6QO4Nu6Diks=;
        b=oO4dgJyIGi2xsG7FmpPJgrYtab1D/S7/VyZyGAz2oNpVW9OVxBK/Pu/vyC0NH4m8pF
         +YtdYcYRlFEuImJ5jpTB11xujWuJV4RFvfPHJPGdYPtoHadnINao5NJ6Yi4Xda54/z1z
         XduP2y3GusQPjWGzUwai6qWU+wrG1nVCxrBDW+yG/lL2MZNdMG7hGLjlyTsEn7wW5VQa
         MOmqbojGhlWGk7Im9t/escrvcAxjFi01y/oqnBZfAeYvspJOJ2qZa1GncN0tEfbr+n66
         WHiiXoP842jQwOhzM3inzFOhpklEfGv5GVPBrGY7+3xEWJBOipbzyaCtjkN6IXsls8E3
         ha0w==
X-Gm-Message-State: AOAM530t/ijPdjt/hsne37LRT1tzWoE/fkczJmP2IuuQ2AKukpRNdKXr
        UOW9IUeyaUgY7ZT2kYjZWVw=
X-Google-Smtp-Source: ABdhPJyrZ59goBTOtOeq5ZN98qlki8G/7NxPUJ41xf8jnZWrURoXBrw90PFMoBdBJ2nYjbq8b8unMw==
X-Received: by 2002:a17:907:168f:: with SMTP id hc15mr42177530ejc.115.1637595169842;
        Mon, 22 Nov 2021 07:32:49 -0800 (PST)
Received: from localhost.localdomain (ip-85-160-4-65.eurotel.cz. [85.160.4.65])
        by smtp.gmail.com with ESMTPSA id q7sm4247757edr.9.2021.11.22.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 07:32:49 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 3/4] mm/vmalloc: be more explicit about supported gfp flags.
Date:   Mon, 22 Nov 2021 16:32:32 +0100
Message-Id: <20211122153233.9924-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211122153233.9924-1-mhocko@kernel.org>
References: <20211122153233.9924-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

b7d90e7a5ea8 ("mm/vmalloc: be more explicit about supported gfp flags")
has been merged prematurely without the rest of the series and without
addressed review feedback from Neil. Fix that up now. Only wording is
changed slightly.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b6aed4f94a85..b1c115ec13be 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3021,12 +3021,14 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  *
  * Allocate enough pages to cover @size from the page level
  * allocator with @gfp_mask flags. Please note that the full set of gfp
- * flags are not supported. GFP_KERNEL would be a preferred allocation mode
- * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
- * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
- * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
- * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
- * __GFP_NOWARN can be used to suppress error messages about failures.
+ * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
+ * supported.
+ * Zone modifiers are not supported. From the reclaim modifiers
+ * __GFP_DIRECT_RECLAIM is required (aka GFP_NOWAIT is not supported)
+ * and only __GFP_NOFAIL is supported (i.e. __GFP_NORETRY and
+ * __GFP_RETRY_MAYFAIL are not supported).
+ *
+ * __GFP_NOWARN can be used to suppress failures messages.
  *
  * Map them into contiguous kernel virtual space, using a pagetable
  * protection of @prot.
-- 
2.30.2

