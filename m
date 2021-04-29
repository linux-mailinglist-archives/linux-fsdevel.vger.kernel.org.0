Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62836EA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhD2M1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237142AbhD2M1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619699180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3IU63kGkBF+ogRqhIQp/uhSIS003Ny+/n/n+XU3YAE=;
        b=Oq2len8NqdARgRK8zax6I/WDPypb/GB769cTcNdhVOj9E/YanlvJBLiGNg9cZ2nNFrgu+J
        54HHYgDwdAHr1MkKBdPY+itk84ZwA1B7ItD97F/DfmnV1C7McjgDrNRL10hKAWNnTHY9T+
        Y+QV/DMvBLgO00kaXGZh+cdRmHA/o2A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Q7ZmTdkgPk2x6LTwQLPkjg-1; Thu, 29 Apr 2021 08:26:17 -0400
X-MC-Unique: Q7ZmTdkgPk2x6LTwQLPkjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA17E8049CE;
        Thu, 29 Apr 2021 12:26:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B31818796;
        Thu, 29 Apr 2021 12:25:43 +0000 (UTC)
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
Subject: [PATCH v1 4/7] fs/proc/kcore: don't read offline sections, logically offline pages and hwpoisoned pages
Date:   Thu, 29 Apr 2021 14:25:16 +0200
Message-Id: <20210429122519.15183-5-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's avoid reading:

1) Offline memory sections: the content of offline memory sections is stale
   as the memory is effectively unused by the kernel. On s390x with standby
   memory, offline memory sections (belonging to offline storage
   increments) are not accessible. With virtio-mem and the hyper-v balloon,
   we can have unavailable memory chunks that should not be accessed inside
   offline memory sections. Last but not least, offline memory sections
   might contain hwpoisoned pages which we can no longer identify
   because the memmap is stale.

2) PG_offline pages: logically offline pages that are documented as
   "The content of these pages is effectively stale. Such pages should not
    be touched (read/write/dump/save) except by their owner.".
   Examples include pages inflated in a balloon or unavailble memory
   ranges inside hotplugged memory sections with virtio-mem or the hyper-v
   balloon.

3) PG_hwpoison pages: Reading pages marked as hwpoisoned can be fatal.
   As documented: "Accessing is not safe since it may cause another machine
   check. Don't touch!"

Reading /proc/kcore now performs similar checks as when reading
/proc/vmcore for kdump via makedumpfile: problematic pages are exclude.
It's also similar to hibernation code, however, we don't skip hwpoisoned
pages when processing pages in kernel/power/snapshot.c:saveable_page() yet.

Note 1: we can race against memory offlining code, especially
memory going offline and getting unplugged: however, we will properly tear
down the identity mapping and handle faults gracefully when accessing
this memory from kcore code.

Note 2: we can race against drivers setting PageOffline() and turning
memory inaccessible in the hypervisor. We'll handle this in a follow-up
patch.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index ed6fbb3bd50c..92ff1e4436cb 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -465,6 +465,9 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 
 	m = NULL;
 	while (buflen) {
+		struct page *page;
+		unsigned long pfn;
+
 		/*
 		 * If this is the first iteration or the address is not within
 		 * the previous entry, search for a matching entry.
@@ -503,7 +506,16 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			}
 			break;
 		case KCORE_RAM:
-			if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+			pfn = __pa(start) >> PAGE_SHIFT;
+			page = pfn_to_online_page(pfn);
+
+			/*
+			 * Don't read offline sections, logically offline pages
+			 * (e.g., inflated in a balloon), hwpoisoned pages,
+			 * and explicitly excluded physical ranges.
+			 */
+			if (!page || PageOffline(page) ||
+			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
 				if (clear_user(buffer, tsz)) {
 					ret = -EFAULT;
 					goto out;
-- 
2.30.2

