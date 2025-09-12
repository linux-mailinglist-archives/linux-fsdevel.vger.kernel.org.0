Return-Path: <linux-fsdevel+bounces-61014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BFB546C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCB21CC081E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBC2848B4;
	Fri, 12 Sep 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Wgae4W8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B9227FD5B;
	Fri, 12 Sep 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668664; cv=none; b=C0xwjpeX4dgnfBkWekcXUkijSAlrFlmaJmU8VgtaaTDwRPGKIUo4liqgIZC8htyqdVB8YaXgKUX2vh4PCDMuUJmcjaM0+6MUy7Gp/m9wxMobKnnOI0lWq0fY2Iaeqfetu3c6LySCfJlBnzv78RN2gwKQMxYEMvP+n5rc39Y3r8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668664; c=relaxed/simple;
	bh=V/gNybMhlcM17xEcJFIgonEkiuW7o9f1xXbH2RHhk9U=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X8kTJKfHaj9hpQT+vvSCKgqjqn3aBHw24XAP9tQdXOd+uiktfgVE9PClldPl5ib2+ueQRj/DnmnOc7PsptqmNX7Is/WM2PhHIHsUXJq8HnK2nZ4ZOG7Qt7eKvcSMrKALODqGcH30IxrB/9YgG5EcUqTGp8vJR87xlGAecTKXRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Wgae4W8C; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1757668662; x=1789204662;
  h=from:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=euX1DcBgIQsakeQD0gmDCocpRR5IiK5IHce/Exk3Qcs=;
  b=Wgae4W8C5DIcmrQXWKzA83zcQ90BopXRyogffDu6DCx/Hji9nlGfOyYZ
   /ZK1FZsCTstlj9nPF8kIeAyb+Fi9BAnLKgCMfgDGbiNOuKF5G83KhTXf5
   iOSzdQja0htQsp31I0V6Kv8gfsGSnZCfmENJgzNCt+R4w08LADdt2fQjN
   uafWcytoC9Q3T85L26EWTvI9qJmydnvU9VbBMzU9ieu2U1AfMW6Gu2e1D
   Lzl04e/4J2PtfE7P8ORSaDYpbQTYtdVi7oJq6hZja++r5/K9MNubqUuJj
   YEoLVeVLSuLrxrgvESIsgeeEpvhLQ8wHvcIPTCUlt50chkXAZttXJe1wK
   A==;
X-CSE-ConnectionGUID: din/RBPeSnGfqj64mcO16Q==
X-CSE-MsgGUID: h+u6Z7AnQzWKlyQKajwbGQ==
X-IronPort-AV: E=Sophos;i="6.18,259,1751241600"; 
   d="scan'208";a="2004929"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 09:17:30 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:6055]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.45.248:2525] with esmtp (Farcaster)
 id 353fed0d-37b0-4710-853f-25025dd2cbc0; Fri, 12 Sep 2025 09:17:30 +0000 (UTC)
X-Farcaster-Flow-ID: 353fed0d-37b0-4710-853f-25025dd2cbc0
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 09:17:29 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB004.ant.amazon.com (10.252.51.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 12 Sep 2025 09:17:29 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.020; Fri, 12 Sep 2025 09:17:29 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
CC: "Thomson, Jack" <jackabt@amazon.co.uk>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "willy@infradead.org" <willy@infradead.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "joey.gouly@arm.com"
	<joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "kernel@xen0n.name"
	<kernel@xen0n.name>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "trondmy@kernel.org" <trondmy@kernel.org>, "anna@kernel.org"
	<anna@kernel.org>, "hubcap@omnibond.com" <hubcap@omnibond.com>,
	"martin@omnibond.com" <martin@omnibond.com>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>,
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
	"pfalcato@suse.de" <pfalcato@suse.de>, "axelrasmussen@google.com"
	<axelrasmussen@google.com>, "yuanchu@google.com" <yuanchu@google.com>,
	"weixugc@google.com" <weixugc@google.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "devel@lists.orangefs.org"
	<devel@lists.orangefs.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: [PATCH v6 00/11] Direct Map Removal Support for guest_memfd
Thread-Topic: [PATCH v6 00/11] Direct Map Removal Support for guest_memfd
Thread-Index: AQHcI8YPHCplp86cBE2LweCaK1PIkA==
Date: Fri, 12 Sep 2025 09:17:29 +0000
Message-ID: <20250912091708.17502-1-roypat@amazon.co.uk>
Accept-Language: en-US
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
Unmapping virtual machine guest memory from the host kernel's direct map is=
 a=0A=
successful mitigation against Spectre-style transient execution issues: If =
the=0A=
kernel page tables do not contain entries pointing to guest memory, then an=
y=0A=
attempted speculative read through the direct map will necessarily be block=
ed=0A=
by the MMU before any observable microarchitectural side-effects happen. Th=
is=0A=
means that Spectre-gadgets and similar cannot be used to target virtual mac=
hine=0A=
memory. Roughly 60% of speculative execution issues fall into this category=
 [1,=0A=
Table 1].=0A=
=0A=
This patch series extends guest_memfd with the ability to remove its memory=
=0A=
from the host kernel's direct map, to be able to attain the above protectio=
n=0A=
for KVM guests running inside guest_memfd.=0A=
=0A=
Additionally, a Firecracker branch with support for these VMs can be found =
on=0A=
GitHub [2].=0A=
=0A=
For more details, please refer to the v5 cover letter [v5]. No=0A=
substantial changes in design have taken place since.=0A=
=0A=
=3D=3D=3D Changes Since v5 =3D=3D=3D =0A=
=0A=
- Fix up error handling for set_direct_map_[in]valid_noflush() (Mike)=0A=
- Fix capability check for KVM_GUEST_MEMFD_NO_DIRECT_MAP (Mike)=0A=
- Make secretmem_aops static in mm/secretmem.c (Mike)=0A=
- Fixup some more comments in gup.c that referred to secretmem=0A=
  specifically to instead point to AS_NO_DIRECT_MAP (Mike)=0A=
- New patch (PATCH 4/11) to avoid ifdeffery in kvm_gmem_free_folio() (Mike)=
=0A=
- vma_is_no_direct_map() -> vma_has_no_direct_map() rename (David)=0A=
- Squash some patches (David)=0A=
- Fix up const-ness of parameters to new functions in pagemap.h (Fuad)=0A=
=0A=
[1]: https://download.vusec.net/papers/quarantine_raid23.pdf=0A=
[2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret=
-hiding=0A=
[RFCv1]: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon=
.co.uk/=0A=
[RFCv2]: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon=
.co.uk/=0A=
[RFCv3]: https://lore.kernel.org/kvm/20241030134912.515725-1-roypat@amazon.=
co.uk/=0A=
[v4]: https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co=
.uk/=0A=
[v5]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co.uk=
/=0A=
=0A=
Elliot Berman (1):=0A=
  filemap: Pass address_space mapping to ->free_folio()=0A=
=0A=
Patrick Roy (10):=0A=
  arch: export set_direct_map_valid_noflush to KVM module=0A=
  mm: introduce AS_NO_DIRECT_MAP=0A=
  KVM: guest_memfd: Add stub for kvm_arch_gmem_invalidate=0A=
  KVM: guest_memfd: Add flag to remove from direct map=0A=
  KVM: selftests: load elf via bounce buffer=0A=
  KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd=0A=
    !=3D -1=0A=
  KVM: selftests: Add guest_memfd based vm_mem_backing_src_types=0A=
  KVM: selftests: stuff vm_mem_backing_src_type into vm_shape=0A=
  KVM: selftests: cover GUEST_MEMFD_FLAG_NO_DIRECT_MAP in existing=0A=
    selftests=0A=
  KVM: selftests: Test guest execution from direct map removed gmem=0A=
=0A=
 Documentation/filesystems/locking.rst         |  2 +-=0A=
 Documentation/virt/kvm/api.rst                |  5 ++=0A=
 arch/arm64/include/asm/kvm_host.h             | 12 ++++=0A=
 arch/arm64/mm/pageattr.c                      |  1 +=0A=
 arch/loongarch/mm/pageattr.c                  |  1 +=0A=
 arch/riscv/mm/pageattr.c                      |  1 +=0A=
 arch/s390/mm/pageattr.c                       |  1 +=0A=
 arch/x86/mm/pat/set_memory.c                  |  1 +=0A=
 fs/nfs/dir.c                                  | 11 ++--=0A=
 fs/orangefs/inode.c                           |  3 +-=0A=
 include/linux/fs.h                            |  2 +-=0A=
 include/linux/kvm_host.h                      |  9 +++=0A=
 include/linux/pagemap.h                       | 16 +++++=0A=
 include/linux/secretmem.h                     | 18 ------=0A=
 include/uapi/linux/kvm.h                      |  2 +=0A=
 lib/buildid.c                                 |  4 +-=0A=
 mm/filemap.c                                  |  9 +--=0A=
 mm/gup.c                                      | 19 ++----=0A=
 mm/mlock.c                                    |  2 +-=0A=
 mm/secretmem.c                                | 11 ++--=0A=
 mm/vmscan.c                                   |  4 +-=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  |  2 +=0A=
 .../testing/selftests/kvm/include/kvm_util.h  | 37 ++++++++---=0A=
 .../testing/selftests/kvm/include/test_util.h |  8 +++=0A=
 tools/testing/selftests/kvm/lib/elf.c         |  8 +--=0A=
 tools/testing/selftests/kvm/lib/io.c          | 23 +++++++=0A=
 tools/testing/selftests/kvm/lib/kvm_util.c    | 61 +++++++++++--------=0A=
 tools/testing/selftests/kvm/lib/test_util.c   |  8 +++=0A=
 tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +=0A=
 .../selftests/kvm/pre_fault_memory_test.c     |  1 +=0A=
 .../selftests/kvm/set_memory_region_test.c    | 50 +++++++++++++--=0A=
 .../kvm/x86/private_mem_conversions_test.c    |  7 ++-=0A=
 virt/kvm/guest_memfd.c                        | 56 ++++++++++++++---=0A=
 virt/kvm/kvm_main.c                           |  5 ++=0A=
 34 files changed, 288 insertions(+), 113 deletions(-)=0A=
=0A=
=0A=
base-commit: a6ad54137af92535cfe32e19e5f3bc1bb7dbd383=0A=
-- =0A=
2.50.1=0A=
=0A=

