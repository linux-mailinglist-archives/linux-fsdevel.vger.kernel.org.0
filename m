Return-Path: <linux-fsdevel+bounces-42254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6835A3FA8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E993519E1109
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3421F3D20;
	Fri, 21 Feb 2025 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="fFSUHhBk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0219F1DB958;
	Fri, 21 Feb 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154157; cv=none; b=qg0SGxNW8SizS9A0vyIXuXaI6wUBUeEjM6PRZ9R1xhT1SeciB4g/flDtlSEK23AfnD8D3GBTO+UMInCiMtNBxAB8uUYlHuEyfESNzm6h2/V7R4tx6qwaNp1gp4z/WcGmBfOqQAf7QW66aezV2giKtGEY2KDuRu23zkmCgj3mScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154157; c=relaxed/simple;
	bh=C6wt0QpOubA3Wo2Ui6kiIdrONu63xbeBPLkcu3iw5sc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cReiOPDACy241VdxCBKGj9Cj7nXTIK5at5DeQy/NvhsQE1heUdIPisUHsKyx/Pqn5vL+hJUHoDiXD9Nkq2/UtwCx9uu0DjJRs5D+taaMLJRnaPzN4jjNktAn1607ydMh7bnrkbjkLXf2Mms3AfHzQ+lamnfQASBNXObFUbwLOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=fFSUHhBk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154155; x=1771690155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PHVzDpLvU92kBE3YeWHx+UpvZAPAAQDXw2hzc0F/GoM=;
  b=fFSUHhBkkevI7NlreBT905I8xXzs0r5IEvvZ+SEhw+jcZG/Nk+n5rZtx
   Mgv9z84Qv8HDSjaB+eLuikPa90E3iiSsdCvP7xU+gkmm18kITzyd+MTAm
   aluEyQAFzVj3Dz1qZB31m+SmKiIl8nn677mWkYJahoVkdGfJoobSgsfUb
   M=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="68171595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:27470]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id 0f0eb951-77e0-44a7-963b-1320b4a5ebbf; Fri, 21 Feb 2025 16:09:09 +0000 (UTC)
X-Farcaster-Flow-ID: 0f0eb951-77e0-44a7-963b-1320b4a5ebbf
Received: from EX19D003UWB004.ant.amazon.com (10.13.138.24) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:08:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB004.ant.amazon.com (10.13.138.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:08:57 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:08:57 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 5BAFC404C9;
	Fri, 21 Feb 2025 16:08:50 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>
Subject: [PATCH v4 00/12] Direct Map Removal for guest_memfd
Date: Fri, 21 Feb 2025 16:07:13 +0000
Message-ID: <20250221160728.1584559-1-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Unmapping virtual machine guest memory from the host kernel's direct map
is a successful mitigation against Spectre-style transient execution
issues: If the kernel page tables do not contain entries pointing to
guest memory, then any attempted speculative read through the direct map
will necessarily be blocked by the MMU before any observable
microarchitectural side-effects happen. This means that Spectre-gadgets
and similar cannot be used to target virtual machine memory. Roughly 60%
of speculative execution issues fall into this category [1, Table 1].

This patch series extends guest_memfd with the ability to remove its
memory from the host kernel's direct map, to be able to attain the above
protection for KVM guests running inside guest_memfd.

=== Changes to RFC v3 ===

- Settle relationship between direct map removal and shared/private
  memory in guest_memfd (David H.)
- Omit TLB flushes upon direct map removal again
- Settle uABI for how KVM accesses guest memory in non-CoCo guest_memfd
  VMs (upstream guest_memfd calls)
- Add selftests that exercise the codepaths of non-CoCo guest_memfd VMs

Lastly, this series is rebased on top of Fuad's v4 for shared mapping of
guest_memfd [2]. The KVM parts should also apply on top of 0ad2507d5d93
("Linux 6.14-rc3"), but the selftest patches need Fuad's series as base.

=== Overview ===

guest_memfd should be usable for "non-CoCo" VMs - virtual machines where
host userspace is trusted (e.g. can have access to all of guest memory),
but which should still be hardened against speculative execution attacks
(Spectre, etc.) staged through potentially existing gadgets in the host
kernel.

To attain this hardening, unmap guest memory from the host kernels
address space (e.g. zap direct map entries), while allowing KVM to
continue accessing guest memory through userspace mappings. This works
because KVM already almost always uses userspace mappings whenever KVM
needs to access guest memory - the only parts that require direct map
entries (because they use GUP) are KVM's MMU, and kvm-clock on x86.

Building on top of guest_memfd sidesteps the MMU problem, as for
memslots with KVM_MEM_GUEST_MEMFD set, the MMU consumes fd + offset
directly without going through any VMAs. kvm-clock on the other hand is
not strictly needed (guests boot fine without it), so ignore it for
now.

=== Implementation ===

Make KVM_CREATE_GUEST_MEMFD accept a flag (KVM_GMEM_NO_DIRECT_MAP) that
instructs it to remove newly allocated folios from the host kernels
direct map immediately after preparation.

Nothing further is needed to make non-CoCo VMs work - particularly, KVM
does not need to be taught any special ways of accessing guest memory if
it is in guest_memfd. Userspace can simply mmap guest_memfd (via
KVM_GMEM_SHARED_MEM added in Fuad's series), and set the memslot's
userspace_addr to this userspace mapping of guest_memfd.

=== Open Questions ===

In this patch series, stale TLB entries do not get flushed after direct
map entries are marked as not present. This is fine from a functional
point of view (as the mapping is still valid, it's just temporarily not
supposed to be used), but pokes a theoretical hole into the speculation
protection: Something could try to keep alive stale TLB entries for
specific pages until the guest starts using them for sensitive
information, and then stage a Spectre attack on that memory, despite it
being unmapped. In practice, this would require knowing in advance, at
gmem fault-time, which pages will eventually contain information of
interest, and then preventing these specific TLB entries from getting
naturally evicted (where the number of pages that can be targeted like
this is limited by the size of the TLB). These seem to be fairly
difficult requisites to fulfill, but we were wondering what the
community thinks.

=== Summary ===

Patch 1 adds a struct address_space flag that indices that folios in a
mapping are direct map removed, and threads it through mm code to ensure
direct map removed folios don't end up in places where they can cause
mayhem (particularly, we reject them in get_user_pages).  Since these
checks end up being duplicates of already existing checks for secretmem
folios, patch 2 unifies the two by using the new address_space flag for
secretmem mappings. Patches 3 through 5 are about support for direct map
removal in guest_memfd, while patches 6 through 12 are about testing the
non-CoCo setup in KVM selftests, with patches 6 through 9 being
preparatory, and patches 10 through 12 adding the actual test cases.

[1]: https://download.vusec.net/papers/quarantine_raid23.pdf
[2]: https://lore.kernel.org/kvm/20250218172500.807733-1-tabba@google.com/
[RFC v1]: https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk/
[RFC v2]: https://lore.kernel.org/kvm/20240910163038.1298452-1-roypat@amazon.co.uk/
[RFC v3]: https://lore.kernel.org/kvm/20241030134912.515725-1-roypat@amazon.co.uk/

Patrick Roy (12):
  mm: introduce AS_NO_DIRECT_MAP
  mm/secretmem: set AS_NO_DIRECT_MAP instead of special-casing
  KVM: guest_memfd: Add flag to remove from direct map
  KVM: Add capability to discover KVM_GMEM_NO_DIRECT_MAP support
  KVM: Documentation: document KVM_GMEM_NO_DIRECT_MAP flag
  KVM: selftests: load elf via bounce buffer
  KVM: selftests: set KVM_MEM_GUEST_MEMFD in vm_mem_add() if guest_memfd
    != -1
  KVM: selftests: Add guest_memfd based vm_mem_backing_src_types
  KVM: selftests: stuff vm_mem_backing_src_type into vm_shape
  KVM: selftests: adjust test_create_guest_memfd_invalid
  KVM: selftests: set KVM_GMEM_NO_DIRECT_MAP in mem conversion tests
  KVM: selftests: Test guest execution from direct map removed gmem

 Documentation/virt/kvm/api.rst                | 13 ++++
 include/linux/pagemap.h                       | 16 +++++
 include/linux/secretmem.h                     | 18 ------
 include/uapi/linux/kvm.h                      |  3 +
 lib/buildid.c                                 |  4 +-
 mm/gup.c                                      | 14 +---
 mm/mlock.c                                    |  2 +-
 mm/secretmem.c                                |  6 +-
 .../testing/selftests/kvm/guest_memfd_test.c  |  2 +-
 .../testing/selftests/kvm/include/kvm_util.h  | 29 ++++++---
 .../testing/selftests/kvm/include/test_util.h |  8 +++
 tools/testing/selftests/kvm/lib/elf.c         |  8 +--
 tools/testing/selftests/kvm/lib/io.c          | 23 +++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 64 +++++++++++--------
 tools/testing/selftests/kvm/lib/test_util.c   |  8 +++
 tools/testing/selftests/kvm/lib/x86/sev.c     |  1 +
 .../selftests/kvm/pre_fault_memory_test.c     |  1 +
 .../selftests/kvm/set_memory_region_test.c    | 40 ++++++++++++
 .../kvm/x86/private_mem_conversions_test.c    |  7 +-
 virt/kvm/guest_memfd.c                        | 24 ++++++-
 virt/kvm/kvm_main.c                           |  5 ++
 21 files changed, 214 insertions(+), 82 deletions(-)


base-commit: da40655874b54a2b563f8ceb3ed839c6cd38e0b4
-- 
2.48.1


