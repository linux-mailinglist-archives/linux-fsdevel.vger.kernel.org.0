Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FF11D36D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfLLRN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:13:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730097AbfLLRNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576170804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0M4cPw5UPqfIP6A7Wi24/RJTAYGo9ErvDujysnPmZU=;
        b=ORafC3vWSR/nLxdMxm1IUY7KS3OVD25vLq4K+2EEr9UAq68Xbfq2cOjAn5rZvlNIuaG779
        RqXO9diO6tGa17sme+AERUMkXIFmll7l7/eHC1d9Bhvw3KU74kzX8I9BbltNaUU8bOAOsJ
        t9+U7Vkpvnqhc1a3v5gK5UWjNz3WkAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-kEdgr6KoPPGF7N8xPrxtsw-1; Thu, 12 Dec 2019 12:13:20 -0500
X-MC-Unique: kEdgr6KoPPGF7N8xPrxtsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82603107ACC4;
        Thu, 12 Dec 2019 17:13:18 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 544CE5C1C3;
        Thu, 12 Dec 2019 17:13:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v4 11/13] mm/vmscan: Move count_vm_event(DROP_SLAB) into drop_slab()
Date:   Thu, 12 Dec 2019 18:11:35 +0100
Message-Id: <20191212171137.13872-12-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's count within the function itself, so every invocation (of future
users) will be counted.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/drop_caches.c | 4 +---
 mm/vmscan.c      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..a042da782fcd 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -61,10 +61,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table=
, int write,
 			iterate_supers(drop_pagecache_sb, NULL);
 			count_vm_event(DROP_PAGECACHE);
 		}
-		if (sysctl_drop_caches & 2) {
+		if (sysctl_drop_caches & 2)
 			drop_slab();
-			count_vm_event(DROP_SLAB);
-		}
 		if (!stfu) {
 			pr_info("%s (%d): drop_caches: %d\n",
 				current->comm, task_pid_nr(current),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a6445e86328..c3e53502a84a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -726,6 +726,7 @@ void drop_slab(void)
=20
 	for_each_online_node(nid)
 		drop_slab_node(nid);
+	count_vm_event(DROP_SLAB);
 }
=20
 static inline int is_page_cache_freeable(struct page *page)
--=20
2.23.0

