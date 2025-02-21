Return-Path: <linux-fsdevel+bounces-42258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4CA3FB01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A0A3AE0C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF621518D;
	Fri, 21 Feb 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="KpUc7lgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD41FAC51;
	Fri, 21 Feb 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154187; cv=none; b=iFvysKYeOjMqUyfi+bZdlbOtUeQzIGrFFapUW6LAPT92kLhvMjb6Ymq3H6SnG2dLXbojOo/Xl5VDi3anzDAKpam2ecY6uks8iFDnBH5DRgBy9cJsim5t8f4U2Fy7+tg8p9SKVH4YvObiifuoLluK8NbyvjGRrKcBqn/C0vyGAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154187; c=relaxed/simple;
	bh=lD39blZXZH445//XcOmyibr7Yw4FHmMDKh+gwbgueYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+LJiFOZqBwvQFp/I/Xn0k+ZcN5rTvzXiVDZWfc8qW6krNcrW0GClujS9sQUt10CZp/0mmMrsrGo1Hr4Mof+vUAVXYtNJPLkVeAjgpbLs4YULf7STWstYNEv6ekvBaxd5e2ruJqoCjoXudaW5aoBsLLQGEkyVB/NucFyBsx1QN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=KpUc7lgn; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154186; x=1771690186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Lxw3QwOdwCmgolpoFT5r+0SQOlcE3s27pqIYNolM4s=;
  b=KpUc7lgn5EU+kEA3+MN6vlvrGeXAdK99t15rfJuzLJfILJtzgelMQYcN
   MUAw4E6dMxS8dhZ9cO0fan1r8ADmdIeSM7AWlrlYcp+SUsMz5W3TuEHEo
   /ieEooqLNFCEOVvrUlE/DbvH5pOgMjlKURtW6PKztHDhLTkMYSYDxcyvl
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="699167429"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:58310]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id 0c629e67-bcab-4233-b9fa-68409832e265; Fri, 21 Feb 2025 16:09:39 +0000 (UTC)
X-Farcaster-Flow-ID: 0c629e67-bcab-4233-b9fa-68409832e265
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:37 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:36 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:36 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id A7DCF404C9;
	Fri, 21 Feb 2025 16:09:28 +0000 (UTC)
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
Subject: [PATCH v4 04/12] KVM: Add capability to discover KVM_GMEM_NO_DIRECT_MAP support
Date: Fri, 21 Feb 2025 16:07:17 +0000
Message-ID: <20250221160728.1584559-5-roypat@amazon.co.uk>
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

Add a capability to let userspace discover whether guest_memfd supports
removing its folios from the direct map. Support depends on guest_memfd
itself being supported, but also on whether KVM can manipulate the
direct map at page granularity at all (possible most of the time, just
arm64 is a notable outlier where its impossible if the direct map has
been setup using hugepages, as arm64 cannot break these apart due to
break-before-make semantics).

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 include/uapi/linux/kvm.h | 1 +
 virt/kvm/kvm_main.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4654c01a0a01..fb02a93546d8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -930,6 +930,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_GMEM_SHARED_MEM 239
+#define KVM_CAP_GMEM_NO_DIRECT_MAP 240
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3e40acb9f5c0..32ca1c921ab0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -65,6 +65,7 @@
 #include <trace/events/kvm.h>
 
 #include <linux/kvm_dirty_ring.h>
+#include <linux/set_memory.h>
 
 
 /* Worst case buffer size needed for holding an integer. */
@@ -4823,6 +4824,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return kvm_supported_mem_attributes(kvm);
 #endif
 #ifdef CONFIG_KVM_PRIVATE_MEM
+	case KVM_CAP_GMEM_NO_DIRECT_MAP:
+		if (!can_set_direct_map())
+			return false;
+		fallthrough;
 	case KVM_CAP_GUEST_MEMFD:
 		return !kvm || kvm_arch_has_private_mem(kvm);
 #endif
-- 
2.48.1


