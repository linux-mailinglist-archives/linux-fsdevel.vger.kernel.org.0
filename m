Return-Path: <linux-fsdevel+bounces-61431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58ADB581D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E947A9029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864B22DFBA;
	Mon, 15 Sep 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="VsYuStjg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6DD2A1BA;
	Mon, 15 Sep 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953110; cv=none; b=WZYWVs2rFFixlnz6CBZAYz6HRgzAE9sKMtGgCruLzYClRlJILg7KiCCTHD5N7JjubA8/aF5bfm0wZPJv+1nioFTWSjSvy9YjgEdH/IQqAQGTpFYHyjVPahfcwaaQ1eMht6hlVzaLg+p3XhxJx2GVd0qBCBmejl74+Jl2PJwGNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953110; c=relaxed/simple;
	bh=W/Bop0JiQCNiY4hZXW+9xx+6h+NiurHC1vm+mMAegCE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eaZEU73kn4fpJqHWV2q3RqzP4m9UZTmaTuvoBZG4CtjnfS6vRR/goQ/5aKgX9/7UnxbEQg8BlqMTHtkaKXdJ+byDvZw6IabRAtW6s1eg1NTKnHcMWsuiJHpsSw9uBbgxaxN2X3k8wkaP5NdGSdOdS5R8UkvKQnmAUoAGpWdrLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=VsYuStjg; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1757953108; x=1789489108;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=CDl0b6KkrXQvSS9kzg7AcD96nGNBLMsPGJRUmWs0z0w=;
  b=VsYuStjgvmIhexw4Rz2OGmGtv02oOxOcOxW4AUzG3enBWfPbsOur1WvY
   B1xQmtFnXjsWhr7wPIRCiqq+qa9eRD/BP8jW4xBhkWH8tplovgnH6hYu1
   g8KUDL/RUFyI7PShd9WVbK/ZeSDDo3xo80LtiZM+7ITWL46G8N1ochAeI
   +odQhhx5ZRt2iEJd3I76Q7CgbPpvNTNhBtjL2UsqgJGHfRFJJ3SKs8Qsi
   +FBlnxYIGl0Q/Qosig5do6fxgpKEPWXc670umh5qEWrPkedEV8l3lOHwy
   fyGITgbZvkEZRNkk0n+gBqRjxPk/yyA8AOijbIoaTtY80xB0A5qlMkn0S
   Q==;
X-CSE-ConnectionGUID: 7g8hTmdISPCOA/xP8HtpFQ==
X-CSE-MsgGUID: yprgmfxkSuWwZ9mZB0WgTQ==
X-IronPort-AV: E=Sophos;i="6.18,266,1751241600"; 
   d="scan'208";a="2139165"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 16:18:17 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:15164]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.8.212:2525] with esmtp (Farcaster)
 id ec76851e-2fd3-4c72-b0e1-9270752f342d; Mon, 15 Sep 2025 16:18:17 +0000 (UTC)
X-Farcaster-Flow-ID: ec76851e-2fd3-4c72-b0e1-9270752f342d
Received: from EX19D022EUC004.ant.amazon.com (10.252.51.159) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 16:18:17 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC004.ant.amazon.com (10.252.51.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 15 Sep 2025 16:18:16 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Mon, 15 Sep 2025 16:18:16 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "lorenzo.stoakes@oracle.com"
	<lorenzo.stoakes@oracle.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "willy@infradead.org" <willy@infradead.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"jack@suse.cz" <jack@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jthoughton@google.com"
	<jthoughton@google.com>, "tabba@google.com" <tabba@google.com>,
	"vannapurve@google.com" <vannapurve@google.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [RFC PATCH v6 0/2] mm: Refactor KVM guest_memfd to introduce guestmem
 library
Thread-Topic: [RFC PATCH v6 0/2] mm: Refactor KVM guest_memfd to introduce
 guestmem library
Thread-Index: AQHcJlxXR+tr4y5qFkOMqP9rmILQaA==
Date: Mon, 15 Sep 2025 16:18:16 +0000
Message-ID: <20250915161815.40729-1-kalyazin@amazon.com>
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

This is a revival of the guestmem library patch series originated from=0A=
Elliot [1].  The reason I am bringing it up now is it would help=0A=
implement UserfaultFD support minor mode in guest_memfd.=0A=
=0A=
Background=0A=
=0A=
We are building a Firecracker version that uses guest_memfd to back=0A=
guest memory [2].  The main objective is to use guest_memfd to remove=0A=
guest memory from host kernel's direct map to reduce the surface for=0A=
Spectre-style transient execution issues [3].  Currently, Firecracker=0A=
supports restoring VMs from snapshots using UserfaultFD [4], which is=0A=
similar to the postcopy phase of live migration.  During restoration,=0A=
while we rely on a separate mechanism to handle stage-2 faults in=0A=
guest_memfd [5], UserfaultFD support in guest_memfd is still required to=0A=
handle faults caused either by the VMM itself or by MMIO access handling=0A=
on x86.=0A=
=0A=
The major problem in implementing UserfaultFD for guest_memfd is that=0A=
the MM code (UserfaultFD) needs to call KVM-specific interfaces.=0A=
Particularly for the minor mode, these are 1) determining the type of=0A=
the VMA (eg is_vma_guest_memfd()) and 2) obtaining a folio (ie=0A=
kvm_gmem_get_folio()).  Those may not be always available as KVM can be=0A=
compiled as a module.  Peter attempted to approach it via exposing an=0A=
ops structure where modules (such as KVM) could provide their own=0A=
callbacks, but it was not deemed to be sufficiently safe as it opens up=0A=
an unrestricted interface for all modules and may leave MM in an=0A=
inconsistent state [6].=0A=
=0A=
An alternative way to make these interfaces available to the UserfaultFD=0A=
code is extracting generic-MM guest_memfd parts into a library=0A=
(guestmem) under MM where they can be safely consumed by the UserfaultFD=0A=
code.  As far as I know, the original guestmem library series was=0A=
motivated by adding guest_memfd support in Gunyah hypervisor [7].=0A=
=0A=
This RFC=0A=
=0A=
I took Elliot's v5 (the latest) and rebased it on top of the guest_memfd=0A=
preview branch [8] because I also wanted to see how it would work with=0A=
direct map removal [3] and write syscall [9], which are building blocks=0A=
for the guest_memfd-based Firecracker version.  On top of it I added a=0A=
patch that implements UserfaultFD support for guest_memfd using=0A=
interfaces provided by the guestmem library to illustrate the complete=0A=
idea.=0A=
=0A=
I made the following modifications along the way:=0A=
 - Followed by a comment from Sean, converted invalidate_begin()=0A=
   callback back to void as it cannot fail in KVM, and the related=0A=
   Gunyah requirement is unknown to me=0A=
 - Extended the guestmem_ops structure with the supports_mmap() callback=0A=
   to provide conditional mmap support in guestmem=0A=
 - Extended the guestmem library interface with guestmem_allocate(),=0A=
   guestmem_test_no_direct_map(), guestmem_mark_prepared(),=0A=
   guestmem_mmap(), and guestmem_vma_is_guestmem()=0A=
 - Made (kvm_gmem)/(guestmem)_test_no_direct_map() use=0A=
   mapping_no_direct_map() instead of KVM-specific flag=0A=
   GUEST_MEMFD_FLAG_NO_DIRECT_MAP to make it KVM-independent=0A=
=0A=
Feedback that I would like to receive:=0A=
 - Is this the right solution to the "UserfaultFD in guest_memfd"=0A=
   problem?=0A=
 - What requirements from other hypervisors than KVM do we need to=0A=
   consider at this point?=0A=
 - Does the line between generic-MM and KVM-specific guest_memfd parts=0A=
   look sensible?=0A=
=0A=
Previous iterations of UserfaultFD support in guest_memfd patches:=0A=
v3:=0A=
 - https://lore.kernel.org/kvm/20250404154352.23078-1-kalyazin@amazon.com=
=0A=
 - minor changes to address review comments (James)=0A=
v2:=0A=
 - https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com=
=0A=
 - implement a full minor trap instead of hybrid missing/minor trap=0A=
   (James/Peter)=0A=
 - make UFFDIO_CONTINUE implementation generic calling vm_ops->fault()=0A=
v1:=0A=
 - https://lore.kernel.org/kvm/20250303133011.44095-1-kalyazin@amazon.com=
=0A=
=0A=
Nikita=0A=
=0A=
[1]: https://lore.kernel.org/kvm/20241122-guestmem-library-v5-2-450e92951a1=
5@quicinc.com=0A=
[2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret=
-hiding=0A=
[3]: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk=
=0A=
[4]: https://github.com/firecracker-microvm/firecracker/blob/main/docs/snap=
shotting/handling-page-faults-on-snapshot-resume.md=0A=
[5]: https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.=
com=0A=
[6]: https://lore.kernel.org/linux-mm/20250627154655.2085903-1-peterx@redha=
t.com=0A=
[7]: https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicin=
c.com=0A=
[8]: https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/log/?h=
=3Dguestmemfd-preview=0A=
[9]: https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.com=
=0A=
=0A=
Nikita Kalyazin (2):=0A=
  mm: guestmem: introduce guestmem library=0A=
  userfaulfd: add minor mode for guestmem=0A=
=0A=
 Documentation/admin-guide/mm/userfaultfd.rst |   4 +-=0A=
 MAINTAINERS                                  |   2 +=0A=
 fs/userfaultfd.c                             |   3 +-=0A=
 include/linux/guestmem.h                     |  46 +++=0A=
 include/linux/userfaultfd_k.h                |   8 +-=0A=
 include/uapi/linux/userfaultfd.h             |   8 +-=0A=
 mm/Kconfig                                   |   3 +=0A=
 mm/Makefile                                  |   1 +=0A=
 mm/guestmem.c                                | 380 +++++++++++++++++++=0A=
 mm/userfaultfd.c                             |  14 +-=0A=
 virt/kvm/Kconfig                             |   1 +=0A=
 virt/kvm/guest_memfd.c                       | 303 ++-------------=0A=
 12 files changed, 493 insertions(+), 280 deletions(-)=0A=
 create mode 100644 include/linux/guestmem.h=0A=
 create mode 100644 mm/guestmem.c=0A=
=0A=
=0A=
base-commit: 911634bac3107b237dcd8fdcb6ac91a22741cbe7=0A=
-- =0A=
2.50.1=0A=
=0A=

