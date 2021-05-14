Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08AF380ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhENRZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231250AbhENRZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621013043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5uvq7/HzHxoBsPRM6oyLa2n9DVz25WrcnXOXa28LPqo=;
        b=hSv7EFkJELVGa3/P5dMCLGiMGaxh4QD8E4VgLexVRYQNvmORPfpZ6dBfyovzy6pndZ3Rnk
        8Ieewhl3jqpW1iIJwODSvnrH/vHkWA6YnlDdhcX2AwMGZznYb9iParjWH4feG4z/a7aQei
        CmAPT8bUD/SnzmuKSeBHzne8ypYzeJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-bmhtkxP6O3aGBDbCC145OQ-1; Fri, 14 May 2021 13:23:57 -0400
X-MC-Unique: bmhtkxP6O3aGBDbCC145OQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7731107ACE3;
        Fri, 14 May 2021 17:23:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B3F61F4;
        Fri, 14 May 2021 17:23:48 +0000 (UTC)
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
Subject: [PATCH v2 5/6] virtio-mem: use page_offline_(start|end) when setting PageOffline()
Date:   Fri, 14 May 2021 19:22:46 +0200
Message-Id: <20210514172247.176750-6-david@redhat.com>
In-Reply-To: <20210514172247.176750-1-david@redhat.com>
References: <20210514172247.176750-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's properly use page_offline_(start|end) to synchronize setting
PageOffline(), so we won't have valid page access to unplugged memory
regions from /proc/kcore.

Existing balloon implementations usually allow reading inflated memory;
doing so might result in unnecessary overhead in the hypervisor, which
is currently the case with virtio-mem.

For future virtio-mem use cases, it will be different when using shmem,
huge pages, !anonymous private mappings, ... as backing storage for a VM.
virtio-mem unplugged memory must no longer be accessed and access might
result in undefined behavior. There will be a virtio spec extension to
document this change, including a new feature flag indicating the
changed behavior. We really don't want to race against PFN walkers
reading random page content.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 2 ++
 1 file changed, 2 insertions(+)

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
-- 
2.31.1

