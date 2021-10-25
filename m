Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28A8439996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhJYPGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:06:24 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:41930 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhJYPGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:06:21 -0400
Received: by mail-ed1-f48.google.com with SMTP id l13so616967edi.8;
        Mon, 25 Oct 2021 08:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Nyn6pHF6WFrGnwPiamzO3XhnQYlE9zJJoQ3+36HnQU=;
        b=VLtU1Q2oa2yfkz/EiocMzSMJ21Fdpj0urDpjzZXuwe0Kd7i2lDq2rv+kKo+FDKMcF/
         BXBg75RYinmRwK1AA3K3L0WTmRCc17w/uLGW5BHUsZynmUlcjJZI6LbRKkGQQ2LDPXh7
         H9VBEMT1GNkoL6BaMnWMMMwO1lc3aiAagO1jDWVi2SZ7Nu1hGnNeftQn9OjHjCX11OxB
         ck/rm6B1tra1JDvkpeuHy22V7GQ1RlIj7wfG71lOx2EPtGHm9MhdRVLr1qYx+Ouej4w+
         f2v0K4ZzeXQ3d+Jlj2hjC7MgNEUeY9TzmCaMh8xHf5BvU1E4T949N8JT9VUNTWwfcyxZ
         K8zQ==
X-Gm-Message-State: AOAM532tzIV6WQ5swOtR/rpOkRrFChGF5lT/xSoOwAOxk1PeSzobDVwg
        wvd942KBYEgjqAGsw4BycVU=
X-Google-Smtp-Source: ABdhPJxI4FD3ukf0VFAW0c5yyigvsk8/K8td5hXew4yerhP9Ku9zWHE1t3ZhRDT1nwO0o435re+ehg==
X-Received: by 2002:aa7:dbc1:: with SMTP id v1mr2472050edt.49.1635174162116;
        Mon, 25 Oct 2021 08:02:42 -0700 (PDT)
Received: from localhost.localdomain (ip-85-160-34-175.eurotel.cz. [85.160.34.175])
        by smtp.gmail.com with ESMTPSA id u23sm9098221edr.97.2021.10.25.08.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 08:02:41 -0700 (PDT)
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
Subject: [PATCH 3/4] mm/vmalloc: be more explicit about supported gfp flags.
Date:   Mon, 25 Oct 2021 17:02:22 +0200
Message-Id: <20211025150223.13621-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025150223.13621-1-mhocko@kernel.org>
References: <20211025150223.13621-1-mhocko@kernel.org>
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
index 602649919a9d..2199d821c981 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2980,8 +2980,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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

