Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A29380ED4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhENRZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 13:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235137AbhENRZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 13:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621013034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEjfdN7WDOCwIANaVcEla+LFmI77UwSVcSaIVJi2J6A=;
        b=J+TEFM7exjypQ3dflTR3wo50eaEtjv6momDADFWDd4BOr711BwyrBUtjW+SV4pRKd/7izf
        oAiO8C7jAYslWQZiykE3zzlXImteD2/IEIF381xrPgrGyHyhIjhfh3nFuk26RB5dju6NAc
        CPkfXav3vcOo4w3lx8SZ2bvgfwSynX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ICjzE1FlNMSXmzI9CyvjLQ-1; Fri, 14 May 2021 13:23:51 -0400
X-MC-Unique: ICjzE1FlNMSXmzI9CyvjLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2632100747B;
        Fri, 14 May 2021 17:23:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C39C1A868;
        Fri, 14 May 2021 17:23:36 +0000 (UTC)
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
Subject: [PATCH v2 4/6] mm: introduce page_offline_(begin|end|freeze|thaw) to synchronize setting PageOffline()
Date:   Fri, 14 May 2021 19:22:45 +0200
Message-Id: <20210514172247.176750-5-david@redhat.com>
In-Reply-To: <20210514172247.176750-1-david@redhat.com>
References: <20210514172247.176750-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Let's introduce page_offline_(begin|end|freeze|thaw) for
synchronizing.

page_offline_freeze()/page_offline_thaw() allows for a subsystem to
synchronize with such drivers, achieving that a page cannot be set
PageOffline() while frozen.

page_offline_begin()/page_offline_end() is used by drivers that care about
such races when setting a page PageOffline().

For simplicity, use a rwsem for now; neither drivers nor users are
performance sensitive.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 10 ++++++++++
 mm/util.c                  | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index daed82744f4b..ea2df9a247b3 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -769,9 +769,19 @@ PAGE_TYPE_OPS(Buddy, buddy)
  * relies on this feature is aware that re-onlining the memory block will
  * require to re-set the pages PageOffline() and not giving them to the
  * buddy via online_page_callback_t.
+ *
+ * There are drivers that mark a page PageOffline() and do not expect any
+ * further access to page content. PFN walkers that read content of random
+ * pages should check PageOffline() and synchronize with such drivers using
+ * page_offline_freeze()/page_offline_thaw().
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+extern void page_offline_freeze(void);
+extern void page_offline_thaw(void);
+extern void page_offline_begin(void);
+extern void page_offline_end(void);
+
 /*
  * Marks pages in use as page tables.
  */
diff --git a/mm/util.c b/mm/util.c
index a8bf17f18a81..a034525e7ba2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1010,3 +1010,43 @@ void mem_dump_obj(void *object)
 }
 EXPORT_SYMBOL_GPL(mem_dump_obj);
 #endif
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
+ * page_offline_freeze()/page_offline_thaw() allows for a subsystem to
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
+void page_offline_thaw(void)
+{
+	up_read(&page_offline_rwsem);
+}
+
+void page_offline_begin(void)
+{
+	down_write(&page_offline_rwsem);
+}
+EXPORT_SYMBOL(page_offline_begin);
+
+void page_offline_end(void)
+{
+	up_write(&page_offline_rwsem);
+}
+EXPORT_SYMBOL(page_offline_end);
-- 
2.31.1

