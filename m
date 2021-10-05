Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F2422622
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 14:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhJEMSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 08:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33118 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234460AbhJEMSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633436207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNI9g9wwmQcdN9iXnExKxfHZe2dTuiVg+oq/PzETzdk=;
        b=UcY48XgkpPwIp3OqMCvxJE5kCfDlgHdIpVWKZWLXnbQJfUkh+yJXVXwbH96eU+7HxbnsLI
        3QbxSyhKRliGSHRh4dElFbBbrotN2ulxqeELqoOhHaaWFOgB+tI3++qviDU9yweW83ZTm3
        eFnAeXatucqIe2VlBn5itqHbZKL47ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-fIbnxzTSOKeOo2Y7cHkiOw-1; Tue, 05 Oct 2021 08:16:46 -0400
X-MC-Unique: fIbnxzTSOKeOo2Y7cHkiOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A66F1084683;
        Tue,  5 Oct 2021 12:16:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A421F436;
        Tue,  5 Oct 2021 12:16:12 +0000 (UTC)
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
Subject: [PATCH v2 3/9] x86/xen: print a warning when HVMOP_get_mem_type fails
Date:   Tue,  5 Oct 2021 14:14:24 +0200
Message-Id: <20211005121430.30136-4-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HVMOP_get_mem_type is not expected to fail, "This call failing is
indication of something going quite wrong and it would be good to know
about this." [1]

Let's add a pr_warn_once().

[1] https://lkml.kernel.org/r/3b935aa0-6d85-0bcd-100e-15098add3c4c@oracle.com

Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index d1b38c77352b..6ba8826dcdcc 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -22,8 +22,10 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
 		.pfn = pfn,
 	};
 
-	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
+	if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a)) {
+		pr_warn_once("Unexpected HVMOP_get_mem_type failure\n");
 		return -ENXIO;
+	}
 	return a.mem_type != HVMMEM_mmio_dm;
 }
 #endif
-- 
2.31.1

