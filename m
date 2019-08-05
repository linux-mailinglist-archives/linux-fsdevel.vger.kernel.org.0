Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB98277E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfHEWUY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 18:20:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33828 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfHEWUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:20:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so37019075plt.1;
        Mon, 05 Aug 2019 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0Etnn7JHR8H7TocLV05oLauZ77NAi3PGTTr9FTaKTw=;
        b=UDZlgD2PuMBL9wl0f5xLH0x3A9s2q8HxsLrdHjkNK3SOB297SiXK4eDKAmDpzpVl0F
         w7RtBptvOSgkgei6aCHdJWFPpiqgXwXMNIebxu8QlDbK5Z8t4BrWzhYzunccIgMaW8sK
         sJyVIrDqI91Tqqq6buzI8UfXtB++A6hs6LheT/4+zFBgv64RCVjx8Owi0ChVufpwkbpZ
         2LuojDoYd+Vezc8faHDhkX/SZFHfkDc9OvfLKQ1u3UmYn4TNLMhIXBDbIlyGr5GhOr/h
         91/w2XsHFuoxIezqA/+us5UPVxiek/AM5+fz4RZ2lX85C4K/JJ/R/Pbt2SvrRyWhAfUi
         723Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0Etnn7JHR8H7TocLV05oLauZ77NAi3PGTTr9FTaKTw=;
        b=RhUtVZJF52BiwxCWc1F5ogKyE48XR3LPnV4pjn49OK2UmwY1VHRFQel0spPMTgVRoH
         ag8976+zMVPA7uASSDH81yGDgB6o6ujoveIaL1KCoAwaVZPYXmMKeex/zlPYhlrrYUaS
         61pYAtoRUzGpmTRx6uAxcDAYr/BcJTPYbpiZkuShKqav0JqGXXcnvTcd5QbRwBD3Wcq0
         b3vw2h4zAHXq0VgnmQzjkxV5TDHjKfrnY9Xx8IozL0WUqcQp6fVWEDYLtRXhgHA9hb71
         e6/hs+cqejRQ27M4MRz8wggyzkonUf4Flyx3H969TyMZyt2/nbHLBmGaywv2vpnQl9om
         oMVg==
X-Gm-Message-State: APjAAAWfgRFlG8Q5lQgPzlqLN1+KoY0pO103ZE1IsPyiL/D8as/gsAtv
        FL9YPQTqJa+jdEQ+nSyTYck=
X-Google-Smtp-Source: APXvYqzK4StBi4Z2q8H3xlbnqk9w5/yLbcwYtlETk2LVzUgJMZXcQMZS+fz6Zg+ZAAI3Y1k3oX59Ow==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr34877pld.340.1565043622624;
        Mon, 05 Aug 2019 15:20:22 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 185sm85744057pfd.125.2019.08.05.15.20.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 15:20:22 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Date:   Mon,  5 Aug 2019 15:20:17 -0700
Message-Id: <20190805222019.28592-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805222019.28592-1-jhubbard@nvidia.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Black <daniel@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mlock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..b980e6270e8a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -345,7 +345,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 				get_page(page); /* for putback_lru_page() */
 				__munlock_isolated_page(page);
 				unlock_page(page);
-				put_page(page); /* from follow_page_mask() */
+				put_user_page(page); /* from follow_page_mask() */
 			}
 		}
 	}
@@ -467,7 +467,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
 		if (page && !IS_ERR(page)) {
 			if (PageTransTail(page)) {
 				VM_BUG_ON_PAGE(PageMlocked(page), page);
-				put_page(page); /* follow_page_mask() */
+				put_user_page(page); /* follow_page_mask() */
 			} else if (PageTransHuge(page)) {
 				lock_page(page);
 				/*
@@ -478,7 +478,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
 				 */
 				page_mask = munlock_vma_page(page);
 				unlock_page(page);
-				put_page(page); /* follow_page_mask() */
+				put_user_page(page); /* follow_page_mask() */
 			} else {
 				/*
 				 * Non-huge pages are handled in batches via
-- 
2.22.0

