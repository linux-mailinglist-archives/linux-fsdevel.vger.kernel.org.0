Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2464A41B612
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 20:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbhI1SZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 14:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242153AbhI1SZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632853425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXipVHA7HDBxHYsFQ8A47J68c7im5DD1EeD2KWkQL+g=;
        b=LpJTz1uGsziiZ185xv3fNcqHaXbhuTXq0cAUbF6brEUYvl4hrhukpgOC+EQjvTX3IZYCz9
        KZl5xw2TPg8ePtcTRu3FsSFyzXPu+rAL0hyAB6rPbFjqetroq+H57YxDn9h9Axf9hlfuxP
        RyB4vH39NI3QkpnP+7/TOWxmdoW+Aac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-5NJ-y1XEOa2GaoLjlra03g-1; Tue, 28 Sep 2021 14:23:44 -0400
X-MC-Unique: 5NJ-y1XEOa2GaoLjlra03g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A7EA40C6;
        Tue, 28 Sep 2021 18:23:41 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A78BE60877;
        Tue, 28 Sep 2021 18:23:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
Date:   Tue, 28 Sep 2021 20:22:52 +0200
Message-Id: <20210928182258.12451-3-david@redhat.com>
In-Reply-To: <20210928182258.12451-1-david@redhat.com>
References: <20210928182258.12451-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's simplify return handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index b242d1f4b426..eb61622df75b 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -21,23 +21,16 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
 		.domid = DOMID_SELF,
 		.pfn = pfn,
 	};
-	int ram;
 
 	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
 		return -ENXIO;
 
 	switch (a.mem_type) {
 	case HVMMEM_mmio_dm:
-		ram = 0;
-		break;
-	case HVMMEM_ram_rw:
-	case HVMMEM_ram_ro:
+		return 0;
 	default:
-		ram = 1;
-		break;
+		return 1;
 	}
-
-	return ram;
 }
 #endif
 
-- 
2.31.1

