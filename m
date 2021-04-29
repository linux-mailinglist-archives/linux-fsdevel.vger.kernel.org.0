Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975FE36EA67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhD2M1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237206AbhD2M1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619699209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ba5FM83Cpmj9gJNSK1p4e73c9iU8c7zv5ZhHHm+jp5A=;
        b=cdzjZB9+OS7X7ncEdezdyDbxdJ8y6myUQtRaXAK631ZQa4wAwlZuxYkobshgMKZrG7GH2v
        FEJ+afzzW+9DSvEw4XizITHNWL+wZUutAkmkVDrjHX8O9FgDrEd5Qdq2O4lybC2/n+sbpE
        M89b/dRKh8CI4bsuVNXXKUj8gGboB6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-61zoBJZfO3q1P9IGYPwAlA-1; Thu, 29 Apr 2021 08:26:45 -0400
X-MC-Unique: 61zoBJZfO3q1P9IGYPwAlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 679691926DA3;
        Thu, 29 Apr 2021 12:26:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6529C18796;
        Thu, 29 Apr 2021 12:26:35 +0000 (UTC)
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
Subject: [PATCH v1 6/7] virtio-mem: use page_offline_(start|end) when setting PageOffline()
Date:   Thu, 29 Apr 2021 14:25:18 +0200
Message-Id: <20210429122519.15183-7-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's properly use page_offline_(start|end) to synchronize setting
PageOffline(), so we won't have valid page access to unplugged memory
regions from /proc/kcore.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 2 ++
 mm/util.c                   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 10ec60d81e84..dc2a2e2b2ff8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1065,6 +1065,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 static void virtio_mem_set_fake_offline(unsigned long pfn,
 					unsigned long nr_pages, bool onlined)
 {
+	page_offline_begin();
 	for (; nr_pages--; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
@@ -1075,6 +1076,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
 			ClearPageReserved(page);
 		}
 	}
+	page_offline_end();
 }
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 95395d4e4209..d0e357bd65e6 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1046,8 +1046,10 @@ void page_offline_begin(void)
 {
 	down_write(&page_offline_rwsem);
 }
+EXPORT_SYMBOL(page_offline_begin);
 
 void page_offline_end(void)
 {
 	up_write(&page_offline_rwsem);
 }
+EXPORT_SYMBOL(page_offline_end);
-- 
2.30.2

