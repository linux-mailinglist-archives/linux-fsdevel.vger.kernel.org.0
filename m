Return-Path: <linux-fsdevel+bounces-70830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98443CA87C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503B2300D40E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F77346FD2;
	Fri,  5 Dec 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="WRGqeGt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBC346E43;
	Fri,  5 Dec 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953964; cv=none; b=AC3alSNtpbncGY4RBWEvGEjDiVLlg7ixyq9mk+nCcZCcKuc0UrVrEaNhT0E32U/WCVZqaUJcfvaAHjpy3MHkvVR+AuaxesvdLymlyAAlYePn5pwFcDAnHmGfHnl9mNSuebzx3ogjFF0TeU768IyNiWOwMadt1kzOoazIicD8YmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953964; c=relaxed/simple;
	bh=g9f7k5eNWq+pvmYEnwpqBk6mpfJovYGI2BhirwjbTxI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n7XhdZzu+TCZyXsvXjC413axiNjM1HCDV9ESJAGqts8K3gJ5kZjTjUO3yByqiFtR+xHEzlnq8Qil2J3FsWKzrnGKWneVK6mbDnbLdH9fcntgtpN/Qk/B5lskfyLNW+MpJsQBMvy9qkZDVTYy/pduLXs6CwevocMSdRSBV7cmsS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=WRGqeGt/; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1764953959; x=1796489959;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5xjYTj8X5HwetCCZmy/ho1YfHMjgHekQDOcmjzpSUS8=;
  b=WRGqeGt/9a4Pw2G3SMYlyaXwCgapdtsZWWGDp8xCneu40oVMHKSjmGtq
   ci32tGqonZ/FWvHMH8HxeHUmj0hGZTbmSML70QI6e3199IW2gZYPtlfRz
   95r5dTUTh1IrwcvnPSlbbg9+U7p7+fjUcTcpzLZPDHTIWUBsydcIqHzWG
   fxPJTAQRos1l2tVqmfXKm/Q89m9lbCAnmVp6pyDpEHDJqOE1YRawyvDLL
   T6tXgKxUWWJ8X4p/VCxVF3QbqBuNuXI92kSsrbqdbK8ZbkZ6/OHJDHunv
   hj5OS+rZ8ZYlgyMV79L3nRcx8PT1xZm316RDC8BxpbTei+cs3kSROQHtZ
   Q==;
X-CSE-ConnectionGUID: PZ+vMz7dRbCMsLBLT8Gdaw==
X-CSE-MsgGUID: w5Ol/ml1TDK9X+g8vPtOgw==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6306224"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 16:57:47 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:8759]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.34.107:2525] with esmtp (Farcaster)
 id 0c512124-b02e-40ba-accc-7940a3109b59; Fri, 5 Dec 2025 16:57:46 +0000 (UTC)
X-Farcaster-Flow-ID: 0c512124-b02e-40ba-accc-7940a3109b59
Received: from EX19D005EUB001.ant.amazon.com (10.252.51.12) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:57:46 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB001.ant.amazon.com (10.252.51.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 16:57:45 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.029; Fri, 5 Dec 2025 16:57:45 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
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
	"riel@surriel.com" <riel@surriel.com>, "baohua@kernel.org"
	<baohua@kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jgross@suse.com" <jgross@suse.com>, "yu-cheng.yu@intel.com"
	<yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com"
	<coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "isaku.yamahata@intel.com"
	<isaku.yamahata@intel.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>
Subject: [PATCH v8 00/13] Direct Map Removal Support for guest_memfd
Thread-Topic: [PATCH v8 00/13] Direct Map Removal Support for guest_memfd
Thread-Index: AQHcZghHzqqX7URA4kyxe1tOPZcLlA==
Date: Fri, 5 Dec 2025 16:57:45 +0000
Message-ID: <20251205165743.9341-1-kalyazin@amazon.com>
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

[ based on kvm/next ]=0A=
=0A=
Unmapping virtual machine guest memory from the host kernel's direct map=0A=
is a successful mitigation against Spectre-style transient execution=0A=
issues: if the kernel page tables do not contain entries pointing to=0A=
guest memory, then any attempted speculative read through the direct map=0A=
will necessarily be blocked by the MMU before any observable=0A=
microarchitectural side-effects happen.  This means that Spectre-gadgets=0A=
and similar cannot be used to target virtual machine memory.  Roughly=0A=
60% of speculative execution issues fall into this category [1, Table=0A=
1].=0A=
=0A=
This patch series extends guest_memfd with the ability to remove its=0A=
memory from the host kernel's direct map, to be able to attain the above=0A=
protection for KVM guests running inside guest_memfd.=0A=
=0A=
Additionally, a Firecracker branch with support for these VMs can be=0A=
found on GitHub [2].=0A=
=0A=
For more details, please refer to the v5 cover letter.  No substantial=0A=
changes in design have taken place since.=0A=
=0A=
See also related write() syscall support in guest_memfd [3] where=0A=
the interoperation between the two features is described.=0A=
=0A=
Changes since v7:=0A=
 - David: separate patches for adding x86 and ARM support=0A=
 - Dave/Will: drop support for disabling TLB flushes=0A=
=0A=
v7: https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus=
.lmu.de=0A=
v6: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk=
=0A=
v5: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk=
=0A=
v4: https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.u=
k=0A=
RFCv3: https://lore.kernel.org/kvm/20241030134912.515725-1-roypat@amazon.co=
.uk=0A=
RFCv2: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon.c=
o.uk=0A=
RFCv1: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.c=
o.uk=0A=
=0A=
[1] https://download.vusec.net/papers/quarantine_raid23.pdf=0A=
[2] https://github.com/firecracker-microvm/firecracker/tree/feature/secret-=
hiding=0A=
[3] https://lore.kernel.org/kvm/20251114151828.98165-1-kalyazin@amazon.com=
=0A=
=0A=
Patrick Roy (13):=0A=
  x86: export set_direct_map_valid_noflush to KVM module=0A=
  x86/tlb: export flush_tlb_kernel_range to KVM module=0A=
  mm: introduce AS_NO_DIRECT_MAP=0A=
  KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate=0A=
  KVM: guest_memfd: Add flag to remove from direct map=0A=
  KVM: x86: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: arm64: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: selftests: load elf via bounce buffer=0A=
  KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd=0A=
    !=3D -1=0A=
  KVM: selftests: Add guest_memfd based vm_mem_backing_src_types=0A=
  KVM: selftests: cover GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing=0A=
    selftests=0A=
  KVM: selftests: stuff vm_mem_backing_src_type into vm_shape=0A=
  KVM: selftests: Test guest execution from direct map removed gmem=0A=
=0A=
 Documentation/virt/kvm/api.rst                | 22 ++++---=0A=
 arch/arm64/include/asm/kvm_host.h             | 13 ++++=0A=
 arch/x86/include/asm/kvm_host.h               |  9 +++=0A=
 arch/x86/include/asm/tlbflush.h               |  3 +-=0A=
 arch/x86/mm/pat/set_memory.c                  |  1 +=0A=
 arch/x86/mm/tlb.c                             |  1 +=0A=
 include/linux/kvm_host.h                      | 14 ++++=0A=
 include/linux/pagemap.h                       | 16 +++++=0A=
 include/linux/secretmem.h                     | 18 ------=0A=
 include/uapi/linux/kvm.h                      |  1 +=0A=
 lib/buildid.c                                 |  4 +-=0A=
 mm/gup.c                                      | 19 ++----=0A=
 mm/mlock.c                                    |  2 +-=0A=
 mm/secretmem.c                                |  8 +--=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 17 ++++-=0A=
 .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++++---=0A=
 .../testing/selftests/kvm/include/test_util.h |  8 +++=0A=
 tools/testing/selftests/kvm/lib/elf.c         |  8 +--=0A=
 tools/testing/selftests/kvm/lib/io.c          | 23 +++++++=0A=
 tools/testing/selftests/kvm/lib/kvm_util.c    | 59 +++++++++--------=0A=
 tools/testing/selftests/kvm/lib/test_util.c   |  8 +++=0A=
 tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +=0A=
 .../selftests/kvm/pre_fault_memory_test.c     |  1 +=0A=
 .../selftests/kvm/set_memory_region_test.c    | 52 +++++++++++++--=0A=
 .../kvm/x86/private_mem_conversions_test.c    |  7 +-=0A=
 virt/kvm/guest_memfd.c                        | 64 +++++++++++++++++--=0A=
 26 files changed, 314 insertions(+), 102 deletions(-)=0A=
=0A=
=0A=
base-commit: e0c26d47def7382d7dbd9cad58bc653aed75737a=0A=
-- =0A=
2.50.1=0A=
=0A=

