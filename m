Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF14346D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJTI2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 04:28:12 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53229 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhJTI2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:28:09 -0400
Received: by mail-wm1-f47.google.com with SMTP id m42so17060694wms.2;
        Wed, 20 Oct 2021 01:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgSRS53yor4/W1ex9Z2HbXrLEzhX0+rUSDcCEksYWe4=;
        b=ab0piIwAYH3jFHS9Pz+jFFY/gLaaGlcODscVoFh3F5cg1S1O/qYm4WZ+paWorhgzFA
         zHgiCXqV0ui89twdVA2oabevd9eLMzg3KnOk0ut5MPRj50PPac4SUkK0bVAXD7Rja94t
         gpBpJmWYwZLFruwN05CxE3EnzxihPWaTPCPU2x9BtCM8jQ4HWTlg+nRCucUVy6Wuc6NH
         x0BjGSih+gWsZZWyvBpbdj6HgR4Aac4w8LZToIsKWbzGhxuhPpmNFgS3H+9djUtqdfjM
         /qm7BVCKPAcT9JMrfdoDTsOHpAxVF1BeU6/cor7TICj5/R2rh2W1teBS9+3zD6wvLBv2
         Kpxw==
X-Gm-Message-State: AOAM533hInBkcR9eS+wYSrS/wjMypz3+w7PtYTZSloTIy5PIqWnDfvIs
        4WJ+PUjjiUl4nTmjGa5r1Ts=
X-Google-Smtp-Source: ABdhPJxl0jyUaqcSoVWh1W6m5L4Ui22r9rjXIiIIZ3g6VlfISOH+EXu59dakftSR4S7bCig4eGmg6g==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr11968924wmi.67.1634718354848;
        Wed, 20 Oct 2021 01:25:54 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-35-99.eurotel.cz. [85.160.35.99])
        by smtp.gmail.com with ESMTPSA id c3sm1317047wrw.66.2021.10.20.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 01:25:54 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm/vmalloc: be more explicit about supported gfp flags.
Date:   Wed, 20 Oct 2021 10:25:45 +0200
Message-Id: <20211020082545.4830-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018114712.9802-3-mhocko@kernel.org>
References: <20211018114712.9802-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

The core of the vmalloc allocator __vmalloc_area_node doesn't say
anything about gfp mask argument. Not all gfp flags are supported
though. Be more explicit about constrains.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmalloc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f7098e616883..f57c09e98977 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2979,8 +2979,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  * @caller:		  caller's return address
  *
  * Allocate enough pages to cover @size from the page level
- * allocator with @gfp_mask flags.  Map them into contiguous
- * kernel virtual space, using a pagetable protection of @prot.
+ * allocator with @gfp_mask flags. Please note that the full set of gfp
+ * flags are not supported. GFP_KERNEL would be a preferred allocation mode
+ * but GFP_NOFS and GFP_NOIO are supported as well. Zone modifiers are not
+ * supported. From the reclaim modifiers__GFP_DIRECT_RECLAIM is required (aka
+ * GFP_NOWAIT is not supported) and only __GFP_NOFAIL is supported (aka
+ * __GFP_NORETRY and __GFP_RETRY_MAYFAIL are not supported).
+ * __GFP_NOWARN can be used to suppress error messages about failures.
+ * 
+ * Map them into contiguous kernel virtual space, using a pagetable
+ * protection of @prot.
  *
  * Return: the address of the area or %NULL on failure
  */
-- 
2.30.2

