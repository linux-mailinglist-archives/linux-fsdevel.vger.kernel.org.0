Return-Path: <linux-fsdevel+bounces-75484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMqzHe+bd2nOjAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:53:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E253A8AFB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE01A309166E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4023346E4E;
	Mon, 26 Jan 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="pKcZSazx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD348458;
	Mon, 26 Jan 2026 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446033; cv=none; b=XF+MSj8zoB1MeJZ61T6uVXhLnbXiofQmLU2aCAM9Eny/kd8OtrCbkW4Eii0gmIljUiY0Oa3/zds+d66Z28I5yvtwCMgkHjYz1x/GgEbrc6FX8ziScj5K6cE20dLGP5cz4SDozys98PQWZV0NPrZKLYnhgK39yqzV9J003wagatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446033; c=relaxed/simple;
	bh=Jj2MWM7REKjQ3mCzvIc3KbcDhzOgxwLiYIXs/egsra4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V+pS8v09uCEwYEEd6eWYHtNt3fsVKPnlCEWhSlXw37iZ/YBOqtrMXX2l6zv6LlB+cB9eJrGlux3ziDw67MagTAAbkBf5xmnwGDBx92t90QuphiB+A5akj6FL5FqLliZqOR3azAYaHE5jg9vbb+cneiFa1BOBHeDeKB3KweDr4d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=pKcZSazx; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1769446029; x=1800982029;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tbv/MTwQoTKHu7Ejd3vLaiU5iszGht/IvO/yWSvhW4o=;
  b=pKcZSazxJzC/PmBxPNy6WOccDoCCl86D+PPFANf66eX1ot6JC5ZZ76P/
   0Afi8x3WN4r/rI3rhAtg/63BPEsUQUcczIUS4WOCcJJhQubt0L6O/tn22
   u/70/x7BSITn6XzNwe72ZQTkLjfZ1utaje3KrMMAgkX2xwVkqJyIQEUJ9
   psA5rwV4M7nvrvwOPse+EefGt9obsagTfBrHLx58Ck8/OR/rRsPfIvy/J
   b6T74DiPssvwgHhcfa0zyudTOj6tsbsHZc+s0oDUEDfnmID+8gKkO0qNs
   NsLVzfAw5lx/dhUJqa1qdQJpermH+w7SGgA41bYeZVvr+6E6zTOb5S1gZ
   w==;
X-CSE-ConnectionGUID: 6IHftKH7SsOlKU7AyD1EnA==
X-CSE-MsgGUID: kMm4jjHORlWTkE3xuKVThA==
X-IronPort-AV: E=Sophos;i="6.21,255,1763424000"; 
   d="scan'208";a="8361622"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:46:49 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:30081]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.13.191:2525] with esmtp (Farcaster)
 id 867ddae6-4aab-4228-9189-c90a4ffe3bcf; Mon, 26 Jan 2026 16:46:48 +0000 (UTC)
X-Farcaster-Flow-ID: 867ddae6-4aab-4228-9189-c90a4ffe3bcf
Received: from EX19D005EUB004.ant.amazon.com (10.252.51.126) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:46:48 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB004.ant.amazon.com (10.252.51.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:46:48 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Mon, 26 Jan 2026 16:46:48 +0000
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
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@suse.cz"
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
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v10 00/15] Direct Map Removal Support for guest_memfd
Thread-Topic: [PATCH v10 00/15] Direct Map Removal Support for guest_memfd
Thread-Index: AQHcjuMVKu9EzWzx90GD17TC625r+Q==
Date: Mon, 26 Jan 2026 16:46:47 +0000
Message-ID: <20260126164445.11867-1-kalyazin@amazon.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.co.uk:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.co.uk,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.co.uk:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:dkim,vusec.net:url];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75484-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.co.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[104];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E253A8AFB1
X-Rspamd-Action: no action

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
Changes since v9:=0A=
 - Huacai/Ackerley: formatting and error handling fixes=0A=
 - Heiko: remove TLB flushing from folio_zap_direct_map() on s390=0A=
 - Willy: set_direct_map_valid_noflush() to take const void * instead of=0A=
   struct page *page=0A=
 - Ackerley: remove reject_file_backed variable in=0A=
   gup_fast_folio_allowed()=0A=
 - Ackerley: avoid referencing memfd_secret in doc=0A=
 - Ackerley: make calls to kvm_gmem_folio_zap_direct_map() conditional=0A=
   to GUEST_MEMFD_FLAG_NO_DIRECT_MAP=0A=
 - Rick: Exclude TDX from direct map removal=0A=
 - Rick: Add a comment about current impossibility of zapping at=0A=
   non-base page granularity.=0A=
=0A=
v9: https://lore.kernel.org/kvm/20260114134510.1835-1-kalyazin@amazon.com=
=0A=
v8: https://lore.kernel.org/kvm/20251205165743.9341-1-kalyazin@amazon.com=
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
Nikita Kalyazin (3):=0A=
  set_memory: set_direct_map_* to take address=0A=
  set_memory: add folio_{zap,restore}_direct_map helpers=0A=
  mm/gup: drop local variable in gup_fast_folio_allowed=0A=
=0A=
Patrick Roy (12):=0A=
  mm/gup: drop secretmem optimization from gup_fast_folio_allowed=0A=
  mm: introduce AS_NO_DIRECT_MAP=0A=
  KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate=0A=
  KVM: x86: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: arm64: define kvm_arch_gmem_supports_no_direct_map()=0A=
  KVM: guest_memfd: Add flag to remove from direct map=0A=
  KVM: selftests: load elf via bounce buffer=0A=
  KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd=0A=
    !=3D -1=0A=
  KVM: selftests: Add guest_memfd based vm_mem_backing_src_types=0A=
  KVM: selftests: cover GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing=0A=
    selftests=0A=
  KVM: selftests: stuff vm_mem_backing_src_type into vm_shape=0A=
  KVM: selftests: Test guest execution from direct map removed gmem=0A=
=0A=
 Documentation/virt/kvm/api.rst                | 21 +++--=0A=
 arch/arm64/include/asm/kvm_host.h             | 13 +++=0A=
 arch/arm64/include/asm/set_memory.h           |  9 +-=0A=
 arch/arm64/mm/pageattr.c                      | 31 ++++---=0A=
 arch/loongarch/include/asm/set_memory.h       |  9 +-=0A=
 arch/loongarch/mm/pageattr.c                  | 37 +++++---=0A=
 arch/riscv/include/asm/set_memory.h           |  9 +-=0A=
 arch/riscv/mm/pageattr.c                      | 29 +++++--=0A=
 arch/s390/include/asm/set_memory.h            |  9 +-=0A=
 arch/s390/mm/pageattr.c                       | 25 ++++--=0A=
 arch/x86/include/asm/kvm_host.h               |  6 ++=0A=
 arch/x86/include/asm/set_memory.h             |  9 +-=0A=
 arch/x86/kvm/x86.c                            |  5 ++=0A=
 arch/x86/mm/pat/set_memory.c                  | 43 +++++++---=0A=
 include/linux/kvm_host.h                      | 14 ++++=0A=
 include/linux/pagemap.h                       | 16 ++++=0A=
 include/linux/secretmem.h                     | 18 ----=0A=
 include/linux/set_memory.h                    | 19 ++++-=0A=
 include/uapi/linux/kvm.h                      |  1 +=0A=
 kernel/power/snapshot.c                       |  4 +-=0A=
 lib/buildid.c                                 |  4 +-=0A=
 mm/execmem.c                                  |  6 +-=0A=
 mm/gup.c                                      | 37 +++-----=0A=
 mm/mlock.c                                    |  2 +-=0A=
 mm/secretmem.c                                | 14 ++--=0A=
 mm/vmalloc.c                                  | 11 ++-=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 17 +++-=0A=
 .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++--=0A=
 .../testing/selftests/kvm/include/test_util.h |  8 ++=0A=
 tools/testing/selftests/kvm/lib/elf.c         |  8 +-=0A=
 tools/testing/selftests/kvm/lib/io.c          | 23 +++++=0A=
 tools/testing/selftests/kvm/lib/kvm_util.c    | 59 +++++++------=0A=
 tools/testing/selftests/kvm/lib/test_util.c   |  8 ++=0A=
 tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +=0A=
 .../selftests/kvm/pre_fault_memory_test.c     |  1 +=0A=
 .../selftests/kvm/set_memory_region_test.c    | 52 +++++++++++-=0A=
 .../kvm/x86/private_mem_conversions_test.c    |  7 +-=0A=
 virt/kvm/guest_memfd.c                        | 84 +++++++++++++++++--=0A=
 38 files changed, 511 insertions(+), 195 deletions(-)=0A=
=0A=
=0A=
base-commit: 0499add8efd72456514c6218c062911ccc922a99=0A=
-- =0A=
2.50.1=0A=
=0A=

