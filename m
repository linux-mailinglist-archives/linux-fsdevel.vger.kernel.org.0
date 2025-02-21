Return-Path: <linux-fsdevel+bounces-42266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A9A3FADA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A537188DFEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEDC222563;
	Fri, 21 Feb 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="qF6YWADD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B001F1535;
	Fri, 21 Feb 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154246; cv=none; b=vDvve1Vt0+iB4DhpWCO93w6K79w3EB+cKrh6HUl67hbcYJO5CiPzeM/78rhua/EoeMRUTyEkoZr8ybexO9YgPTxxIjIfTw54FqlwyK7zC9QkgLF6KAIOIgq1ok3UfC9G2yBQYsdukbag49OYxurk0ie5b+6BcXBhqZEIu5+rhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154246; c=relaxed/simple;
	bh=haXYXj2KNnNM53EccSTxVj7puXHBh3hhQL/qUprzXn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UH1159z2m5bm3jqoqO+me+rjLoGt7Cr8SNr9tVdnPAs6ge9NQXALwjLMdU2Jo3pbCMQRdeqfYCae900u4osMfN+FjO7AxKl/MIy1nPx2e8kWCbuqGIHTNlFESEIo2I6ogpkXafJYOu5PkVpucFZMJ0XHHLY3TkpCuWDJAuYMxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=qF6YWADD; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154246; x=1771690246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GG+iBbH6CBZj8qfdCgUkXoIISA49vkr1DaWwQ2vmohw=;
  b=qF6YWADDZdWUrPA7tPGh21okWh2I1shkMlVwVhFo4oUfsCeeZYK7TNHk
   TbLyjzwV4iYvkfIMbef/9Z76add7g7V42zzlM1st5k8siUKnFV4CWCLQo
   WD4pZkKi4QNdHWS2HqXFRQFlIsjOCx6eC4WGhh9XZp5ijAb/15PCTgjgj
   M=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="699167651"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:10:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:6686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id 69e45197-d4c5-4ea5-a690-28fa854e89d7; Fri, 21 Feb 2025 16:10:40 +0000 (UTC)
X-Farcaster-Flow-ID: 69e45197-d4c5-4ea5-a690-28fa854e89d7
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:10:40 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:10:39 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:10:39 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id B70BB404C9;
	Fri, 21 Feb 2025 16:10:32 +0000 (UTC)
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
Subject: [PATCH v4 12/12] KVM: selftests: Test guest execution from direct map removed gmem
Date: Fri, 21 Feb 2025 16:07:25 +0000
Message-ID: <20250221160728.1584559-13-roypat@amazon.co.uk>
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

Add a selftest that loads itself into guest_memfd (via
KVM_GMEM_SHARED_MEM) and triggers an MMIO exit when executed. This
exercises x86 MMIO emulation code inside KVM for guest_memfd-backed
memslots where the guest_memfd folios are direct map removed.
Particularly, it validates that x86 MMIO emulation code (guest page
table walks + instruction fetch) correctly accesses gmem through the VMA
that's been reflected into the memslot's userspace_addr field (instead
of trying to do direct map accesses).

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 .../selftests/kvm/set_memory_region_test.c    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index bc440d5aba57..16bbfe117a17 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -603,6 +603,42 @@ static void test_mmio_during_vectoring(void)
 
 	kvm_vm_free(vm);
 }
+
+static void guest_code_trigger_mmio(void)
+{
+	/*
+	 * Read some GPA that is not backed by a memslot. KVM consider this
+	 * as MMIO and tell userspace to emulate the read.
+	 */
+	READ_ONCE(*((uint64_t *)MEM_REGION_GPA));
+
+	GUEST_DONE();
+}
+
+static void test_guest_memfd_mmio(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+		.src_type = VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,
+	};
+	pthread_t vcpu_thread;
+
+	pr_info("Testing MMIO emulation for instructions in gmem\n");
+
+	vm = __vm_create_shape_with_one_vcpu(shape, &vcpu, 0, guest_code_trigger_mmio);
+
+	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 1);
+
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
+
+	/* If the MMIO read was successfully emulated, the vcpu thread will exit */
+	pthread_join(vcpu_thread, NULL);
+
+	kvm_vm_free(vm);
+}
 #endif
 
 int main(int argc, char *argv[])
@@ -630,6 +666,10 @@ int main(int argc, char *argv[])
 	    (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM))) {
 		test_add_private_memory_region();
 		test_add_overlapping_private_memory_regions();
+		if (kvm_has_cap(KVM_CAP_GMEM_SHARED_MEM) && kvm_has_cap(KVM_CAP_GMEM_NO_DIRECT_MAP))
+			test_guest_memfd_mmio();
+		else
+			pr_info("Skipping tests requiring KVM_CAP_GMEM_SHARED_MEM | KVM_CAP_GMEM_NO_DIRECT_MAP");
 	} else {
 		pr_info("Skipping tests for KVM_MEM_GUEST_MEMFD memory regions\n");
 	}
-- 
2.48.1


