Return-Path: <linux-fsdevel+bounces-73712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F1D1F2CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24310309AC3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D226ED48;
	Wed, 14 Jan 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="WmRSu3BR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8963223DD6;
	Wed, 14 Jan 2026 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398376; cv=none; b=swAo5g5JQ5M3zxqk8TY6je7g7WsRZcRD3T0GNz2Lc6fEE1ZTvjGg1HNiXizD9o2E0rLSRLd2t2iKWqxPrFicAfRHw1pBlvT0acwgowU5LXuzJW8YJ3/gJyM54zgR22B4Obvi0P4x7PwQaKb+ZRXNcHzzHS/ySks0EZT2XmO9x08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398376; c=relaxed/simple;
	bh=uscAv0ZOrJ7JzQOd3sbmaT4mGOxC0tA+wUUmeuMqHpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7w3nTHnHQZGVRHnqseX77s+vqE0lvM9a1PeNLL0qdMDMA3lni9YSweRjrusGqyrvFCeBPDF0vciSlBkR/SEjcLVeFZWj6qpeIqYZZ759UrVJ7K57MGlzifSQ3rHqgMimKItZ+SFQUOxjWnwRXR8VZYPZ4uQR+thZQ7hfmZ9XPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=WmRSu3BR; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1768398374; x=1799934374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qx10YQyM1n7Bzq/TmzHM+nwXVd+92kjURQXs15/Kk1I=;
  b=WmRSu3BR1nTIoJuhhs2m8EhI56bICAl50ygry+WTM1D+cHr4cOuNIflh
   LdHg2C+UDPSTKPFPmjlCPETYouZjoMSjJ7L7Fw2D8h6g0TAniK2+RUFjM
   AxEpeTVyaFWtJudxSbEpFQgPCqgbBosJYyzcmq+UYNDShRGCjNV6jvHZO
   aicxyPjhn5wC/XUzzhLkCCIQIDFVunjJbXN3vsRb08hyhPVCA1Di0V16n
   T23r0eAYFWid+dG34bypQYOab0x1kCWAwDHeKqiftzrqMztzqB87WlyYB
   ajlLu/Shw4FlkzbOg0LxcHETV+s6FFqpIBVdCSuNpGnqQbmiJ/tS5eeA0
   g==;
X-CSE-ConnectionGUID: 6F6gMhRMTLC+B19uMUHjbw==
X-CSE-MsgGUID: nq2OO95sS4WesM1K/I1Kjg==
X-IronPort-AV: E=Sophos;i="6.21,225,1763424000"; 
   d="scan'208";a="7899040"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:46:11 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:23123]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.6.3:2525] with esmtp (Farcaster)
 id 646304cb-9c48-4747-8d9d-d4686df9ea29; Wed, 14 Jan 2026 13:46:11 +0000 (UTC)
X-Farcaster-Flow-ID: 646304cb-9c48-4747-8d9d-d4686df9ea29
Received: from EX19D005EUB002.ant.amazon.com (10.252.51.103) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:46:10 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB002.ant.amazon.com (10.252.51.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:46:10 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Wed, 14 Jan 2026 13:46:09 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v9 05/13] KVM: x86: define
 kvm_arch_gmem_supports_no_direct_map()
Thread-Topic: [PATCH v9 05/13] KVM: x86: define
 kvm_arch_gmem_supports_no_direct_map()
Thread-Index: AQHchVwjbMmxqTepZEW4NnK8Myz8WQ==
Date: Wed, 14 Jan 2026 13:46:09 +0000
Message-ID: <20260114134510.1835-6-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
In-Reply-To: <20260114134510.1835-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Patrick Roy <patrick.roy@linux.dev>=0A=
=0A=
x86 supports GUEST_MEMFD_FLAG_NO_DIRECT_MAP whenever direct map=0A=
modifications are possible (which is always the case).=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 arch/x86/include/asm/kvm_host.h | 9 +++++++++=0A=
 1 file changed, 9 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h=0A=
index 5a3bfa293e8b..68bd29a52f24 100644=0A=
--- a/arch/x86/include/asm/kvm_host.h=0A=
+++ b/arch/x86/include/asm/kvm_host.h=0A=
@@ -28,6 +28,7 @@=0A=
 #include <linux/sched/vhost_task.h>=0A=
 #include <linux/call_once.h>=0A=
 #include <linux/atomic.h>=0A=
+#include <linux/set_memory.h>=0A=
 =0A=
 #include <asm/apic.h>=0A=
 #include <asm/pvclock-abi.h>=0A=
@@ -2481,4 +2482,12 @@ static inline bool kvm_arch_has_irq_bypass(void)=0A=
 	return enable_device_posted_irqs;=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+static inline bool kvm_arch_gmem_supports_no_direct_map(void)=0A=
+{=0A=
+	return can_set_direct_map();=0A=
+}=0A=
+#define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_dir=
ect_map=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
+=0A=
 #endif /* _ASM_X86_KVM_HOST_H */=0A=
-- =0A=
2.50.1=0A=
=0A=

