Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713C136EA5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhD2M0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236737AbhD2M0g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619699150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yW4OuKyN35nF4beRa4G0zG5E1KxLWubZR1ZjeP0KtI=;
        b=YfE4oZdXNKlICUEPNXNRa/7MhrKt/zOHHL43XtfnMZQIKy4EUhw41LPH4evd/Sq7+SFGQf
        7uzLLZQT9d2cfE4xAJpZwUWZWTGOtA+8IViaLuu0i+KTUrho3jeJ0Jeu4PlfvBZC5+P0M5
        4491uSgVq8tefpjyqZ7RyKHm8OhatLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-yxYYYYlMNcONjLFEyhJ5IQ-1; Thu, 29 Apr 2021 08:25:46 -0400
X-MC-Unique: yxYYYYlMNcONjLFEyhJ5IQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20248042A6;
        Thu, 29 Apr 2021 12:25:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C08A18796;
        Thu, 29 Apr 2021 12:25:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Date:   Thu, 29 Apr 2021 14:25:15 +0200
Message-Id: <20210429122519.15183-4-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
introduced page_is_poisoned(), however, v5 [1] of the patch used
"page_is_hwpoison()" and something went wrong while upstreaming. Rename the
function and move it to page-flags.h, from where it can be used in other
-- kcore -- context.

Move the comment to the place where it belongs and simplify.

[1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  7 +++++++
 mm/gup.c                   |  6 +++++-
 mm/internal.h              | 20 --------------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..b8c56672a588 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -694,6 +694,13 @@ PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
 #endif
 
+static inline bool is_page_hwpoison(struct page *page)
+{
+	if (PageHWPoison(page))
+		return true;
+	return PageHuge(page) && PageHWPoison(compound_head(page));
+}
+
 /*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
diff --git a/mm/gup.c b/mm/gup.c
index ef7d2da9f03f..000f3303e7f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,7 +1536,11 @@ struct page *get_dump_page(unsigned long addr)
 	if (locked)
 		mmap_read_unlock(mm);
 
-	if (ret == 1 && is_page_poisoned(page))
+	/*
+	 * We might have hwpoisoned pages still mapped into user space. Don't
+	 * read these pages when creating a coredump, access could be fatal.
+	 */
+	if (ret == 1 && is_page_hwpoison(page))
 		return NULL;
 
 	return (ret == 1) ? page : NULL;
diff --git a/mm/internal.h b/mm/internal.h
index cb3c5e0a7799..1432feec62df 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,26 +97,6 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
-/*
- * When kernel touch the user page, the user page may be have been marked
- * poison but still mapped in user space, if without this page, the kernel
- * can guarantee the data integrity and operation success, the kernel is
- * better to check the posion status and avoid touching it, be good not to
- * panic, coredump for process fatal signal is a sample case matching this
- * scenario. Or if kernel can't guarantee the data integrity, it's better
- * not to call this function, let kernel touch the poison page and get to
- * panic.
- */
-static inline bool is_page_poisoned(struct page *page)
-{
-	if (PageHWPoison(page))
-		return true;
-	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
-		return true;
-
-	return false;
-}
-
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
2.30.2

