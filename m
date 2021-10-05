Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D34422618
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 14:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhJEMRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 08:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhJEMRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633436148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBxtf9cAE1Ob9GyuKdaY249ysRz4C6IB01yDqx20w58=;
        b=AUopRkNq5+IXC7fw+AdpgcQLyCUcZhgGjo7OFm2sLBDdbl/daI6Hlh4i6c0e+hUFLBLWtT
        vlqgjIRInbPrrb+N7rArABzRElIFLcp1Xg/mno5wi3aQL2A1CsNbyllcyamCpKXRFmzJXK
        gihrLAbMN5gMTg1cn4hLi7WMqMV2Xz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-3iNft1SuOOCFeMn2zDAogw-1; Tue, 05 Oct 2021 08:15:47 -0400
X-MC-Unique: 3iNft1SuOOCFeMn2zDAogw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898E81922036;
        Tue,  5 Oct 2021 12:15:44 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3DBAE73F;
        Tue,  5 Oct 2021 12:15:08 +0000 (UTC)
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
        linux-mm@kvack.org, Boris Ostrovsky <boris.ostrvsky@oracle.com>
Subject: [PATCH v2 1/9] x86/xen: update xen_oldmem_pfn_is_ram() documentation
Date:   Tue,  5 Oct 2021 14:14:22 +0200
Message-Id: <20211005121430.30136-2-david@redhat.com>
In-Reply-To: <20211005121430.30136-1-david@redhat.com>
References: <20211005121430.30136-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callback is only used for the vmcore nowadays.

Reviewed-by: Boris Ostrovsky <boris.ostrvsky@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/xen/mmu_hvm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index 57409373750f..b242d1f4b426 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -9,12 +9,9 @@
 
 #ifdef CONFIG_PROC_VMCORE
 /*
- * This function is used in two contexts:
- * - the kdump kernel has to check whether a pfn of the crashed kernel
- *   was a ballooned page. vmcore is using this function to decide
- *   whether to access a pfn of the crashed kernel.
- * - the kexec kernel has to check whether a pfn was ballooned by the
- *   previous kernel. If the pfn is ballooned, handle it properly.
+ * The kdump kernel has to check whether a pfn of the crashed kernel
+ * was a ballooned page. vmcore is using this function to decide
+ * whether to access a pfn of the crashed kernel.
  * Returns 0 if the pfn is not backed by a RAM page, the caller may
  * handle the pfn special in this case.
  */
-- 
2.31.1

