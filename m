Return-Path: <linux-fsdevel+bounces-42265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94134A3FB40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8126E866F18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AACE2206AC;
	Fri, 21 Feb 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="rd+Jqww4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E451D79B4;
	Fri, 21 Feb 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154240; cv=none; b=B+P+/PldU1kEY1OhHSkE6AkbbgptckHyEhYr+Qmsxi3keCPR8SXvwEDkWPULFK9ZPWoHoilnDY443vXPnhU66YWRjVNM9EvLOoVYGL0qrGddVswno+2C7R5ReYeGNfJLTHF3QWOQ19c5OZOXojIT7LrG8tTKPteV8q7EZKY00Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154240; c=relaxed/simple;
	bh=KKe0DJ8IaCvUGP3A2reEUBMv3+LU6Z5Y42CoH8pCrDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+TXwkl/KzkAEniVMA8wcskLC5ZR1Yu5lWD8Zr5OLAqfZjtptIOmA83ZEEYVvvmW7F3/icRXGtmSjbvtCw9K05+hQyct1GImT2YQle8pqSKUHCk/i5ZMUAXJUtLSORyQqgAs6cMEKJz6pVAcTk0YyVNS4vEsKsbT1oz9Q5TzsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=rd+Jqww4; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154239; x=1771690239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Ov1AvdkmE8RFNxbKfIF7ZP8moMSsOr7uZcMJB7/AEA=;
  b=rd+Jqww4Nyn/aVBZJX/U2f7bpYslaWY0Pu5ACLdAVVzC0sWXC0gklX3I
   LD0KhEVcuACMQOINkIem5JVu0TelLiH2jXnlR9ovBTaqZfHybYIDqmVvb
   ZZ+LbOU0CJY6ZapTUcbxdGeUqBDHxeZkEGv9vCLZKZVrcJS2H5eMT9/zI
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="273295679"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:10:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:36548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id e2af6afa-729d-4911-8577-61bddf574a96; Fri, 21 Feb 2025 16:10:32 +0000 (UTC)
X-Farcaster-Flow-ID: e2af6afa-729d-4911-8577-61bddf574a96
Received: from EX19D003UWC004.ant.amazon.com (10.13.138.150) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:10:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D003UWC004.ant.amazon.com (10.13.138.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:10:32 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:10:32 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id BB555404D5;
	Fri, 21 Feb 2025 16:10:24 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 11/12] KVM: selftests: set KVM_GMEM_NO_DIRECT_MAP in mem conversion tests
Date: Fri, 21 Feb 2025 16:07:24 +0000
Message-ID: <20250221160728.1584559-12-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Cover the scenario that the guest can fault in and write gmem-backed
guest memory even if its direct map removed.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 .../selftests/kvm/x86/private_mem_conversions_test.c       | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 82a8d88b5338..dfc78781e93b 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -367,7 +367,7 @@ static void *__test_mem_conversions(void *__vcpu)
 }
 
 static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t nr_vcpus,
-				 uint32_t nr_memslots)
+				 uint32_t nr_memslots, uint64_t gmem_flags)
 {
 	/*
 	 * Allocate enough memory so that each vCPU's chunk of memory can be
@@ -394,7 +394,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
 
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
@@ -477,7 +477,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	test_mem_conversions(src_type, nr_vcpus, nr_memslots);
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots, 0);
+	test_mem_conversions(src_type, nr_vcpus, nr_memslots, KVM_GMEM_NO_DIRECT_MAP);
 
 	return 0;
 }
-- 
2.48.1


