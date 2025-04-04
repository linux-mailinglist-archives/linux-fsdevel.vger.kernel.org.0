Return-Path: <linux-fsdevel+bounces-45778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0EA7C0E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8F3B9F76
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E51F78F3;
	Fri,  4 Apr 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ssFO4xjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA171F584D;
	Fri,  4 Apr 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781495; cv=none; b=DguxVIkHJ5Pjp4+VH4/UzNq4+UKEB0t/MJJYTBSTrzz2hzZ6YGfieJVIKiAzVRRzDrKq85MZ5riyYm521tUS+tZgmYor5QmsPJ2tHy+7ixQgCLoNK90A7V6Wb1TETN6GCuF9scBxxd2S46sJIGwN3P8hUfD8iBSwIgpexC+2VO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781495; c=relaxed/simple;
	bh=kFNfO4+4H/Do6SIV4WALi6N3A6Tqd4BX3kF8tn9/k+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=by29im79uD+Kj0obsIDHmJOfBjcgyOR4Jvg7Ep4YuiykO44ABe77zuoBW3leHkjmF2O8U0GCUf4fVm7p/B1NPYFanwoz02KIXauGT2521M+JvAdgnti1Q3OREr6J6TQlHVcJmYl9OP2zu6W5jt7vxPV/IAh/QDxyAGqyZcQg67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ssFO4xjU; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781495; x=1775317495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hs0vi6KJkVKWhslhiRZ4duAi0DhiXeUL0EGHDvOz7fs=;
  b=ssFO4xjUC1/W6rce5ly4qYMhUTD4zl3BTPLZQOmhrD6TCykkeuC+uNfE
   vcIuBLUlVdi3zuN4Mlow4QGJdstgDFYRyTqQxL55faKWn9j05nrNUI9vB
   B4WkbU3bTHfD3nGBzKK96DyrMvue0Uwmr+hcDb8/y4LtV9zqAATbRz+fY
   k=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="480424509"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:44:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:10114]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 7694f073-a459-43df-b4a1-c487f31edac7; Fri, 4 Apr 2025 15:44:48 +0000 (UTC)
X-Farcaster-Flow-ID: 7694f073-a459-43df-b4a1-c487f31edac7
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:44:47 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:44:47 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTPS id 68987402AD;
	Fri,  4 Apr 2025 15:44:44 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@Oracle.com>, <jannh@google.com>,
	<ryan.roberts@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<peterx@redhat.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [PATCH v3 4/6] KVM: guest_memfd: add support for userfaultfd minor
Date: Fri, 4 Apr 2025 15:43:50 +0000
Message-ID: <20250404154352.23078-5-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404154352.23078-1-kalyazin@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Add support for sending a pagefault event if userfaultfd is registered.
Only page minor event is currently supported.

Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
---
 virt/kvm/guest_memfd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fbf89e643add..096d89e7282d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -4,6 +4,9 @@
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
 #include <linux/anon_inodes.h>
+#ifdef CONFIG_KVM_PRIVATE_MEM
+#include <linux/userfaultfd_k.h>
+#endif /* CONFIG_KVM_PRIVATE_MEM */
 
 #include "kvm_mm.h"
 
@@ -380,6 +383,13 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
 		kvm_gmem_mark_prepared(folio);
 	}
 
+	if (userfaultfd_minor(vmf->vma) &&
+	    !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
+		folio_unlock(folio);
+		filemap_invalidate_unlock_shared(inode->i_mapping);
+		return handle_userfault(vmf, VM_UFFD_MINOR);
+	}
+
 	vmf->page = folio_file_page(folio, vmf->pgoff);
 
 out_folio:
-- 
2.47.1


