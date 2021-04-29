Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3836EA62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhD2M10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 08:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231343AbhD2M10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619699199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqK47sG85aZfcKTSSN25XorwOXhWot6GcaTYJAm0h7w=;
        b=BMUB1aYEJXWkmgtPRK/lvs/unrJ2bPdaBzYuCWVwX0d8MoyVX5/5pLvoRnA3PMdVvzXkRn
        G5UuDRcdd6AeCE6k+lhy5QdE7pmWi2p28wu0A+RWrGht8XGpxDFIBi2DsKg+03+O7RXLD2
        ol6HFHLNpKsGkeMAuLxDBNIjm4KlFXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BOB6ZMW4OPaam5VXHtscdg-1; Thu, 29 Apr 2021 08:26:37 -0400
X-MC-Unique: BOB6ZMW4OPaam5VXHtscdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0763910054F6;
        Thu, 29 Apr 2021 12:26:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8A118796;
        Thu, 29 Apr 2021 12:26:15 +0000 (UTC)
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
Subject: [PATCH v1 5/7] mm: introduce page_offline_(begin|end|freeze|unfreeze) to synchronize setting PageOffline()
Date:   Thu, 29 Apr 2021 14:25:17 +0200
Message-Id: <20210429122519.15183-6-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A driver might set a page logically offline -- PageOffline() -- and
turn the page inaccessible in the hypervisor; after that, access to page
content can be fatal. One example is virtio-mem; while unplugged memory
-- marked as PageOffline() can currently be read in the hypervisor, this
will no longer be the case in the future; for example, when having
a virtio-mem device backed by huge pages in the hypervisor.

Some special PFN walkers -- i.e., /proc/kcore -- read content of random
pages after checking PageOffline(); however, these PFN walkers can race
with drivers that set PageOffline().

Let's introduce page_offline_(begin|end|freeze|unfreeze) for
synchronizing.

page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
synchronize with such drivers, achieving that a page cannot be set
PageOffline() while frozen.

page_offline_begin()/page_offline_end() is used by drivers that care about
such races when setting a page PageOffline().

For simplicity, use a rwsem for now; neither drivers nor users are
performance sensitive.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  5 +++++
 mm/util.c                  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b8c56672a588..e3d00c72f459 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -767,6 +767,11 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+extern void page_offline_freeze(void);
+extern void page_offline_unfreeze(void);
+extern void page_offline_begin(void);
+extern void page_offline_end(void);
+
 /*
  * Marks pages in use as page tables.
  */
diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..95395d4e4209 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1013,3 +1013,41 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+
+/*
+ * A driver might set a page logically offline -- PageOffline() -- and
+ * turn the page inaccessible in the hypervisor; after that, access to page
+ * content can be fatal.
+ *
+ * Some special PFN walkers -- i.e., /proc/kcore -- read content of random
+ * pages after checking PageOffline(); however, these PFN walkers can race
+ * with drivers that set PageOffline().
+ *
+ * page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
+ * synchronize with such drivers, achieving that a page cannot be set
+ * PageOffline() while frozen.
+ *
+ * page_offline_begin()/page_offline_end() is used by drivers that care about
+ * such races when setting a page PageOffline().
+ */
+static DECLARE_RWSEM(page_offline_rwsem);
+
+void page_offline_freeze(void)
+{
+	down_read(&page_offline_rwsem);
+}
+
+void page_offline_unfreeze(void)
+{
+	up_read(&page_offline_rwsem);
+}
+
+void page_offline_begin(void)
+{
+	down_write(&page_offline_rwsem);
+}
+
+void page_offline_end(void)
+{
+	up_write(&page_offline_rwsem);
+}
-- 
2.30.2

