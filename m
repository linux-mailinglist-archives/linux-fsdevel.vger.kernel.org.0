Return-Path: <linux-fsdevel+bounces-45774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988DA7C0CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4E27A8C54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1A1F63F5;
	Fri,  4 Apr 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="En4mpUCo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78AE1F5853;
	Fri,  4 Apr 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781448; cv=none; b=F8NrDqEd4lbEMLjtLEvIIx2BqrH96WSs5i0mgRk1nCsrHo5LWtnTZOjqv99p8dWXzzrgNQ4PgA+Dp3kTb2YWzxR1yjEYIw+9KVHLLvmtOEPuIbQ3cTf2DU7yzL+IogUUATiKmwwrxHDVVFQuTwDzeHZfysPo9m7tOypVr7RsT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781448; c=relaxed/simple;
	bh=Kt79fJGRwJnXAG2klKk7/s3O5ZBmyTaKqz+56dyv8yg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3J+GmM2X3pKdGYHMkxn8q6RsdVKh6MaQ37r9GgUZXIrJ/RKEPzMhQIVO8Uuheam6RzHRhY1taViXiwipu2SRr1Dp4QmZ+oxBvIBmaOsVBUdoePZ5T6rKy8cmXfTnsvaGBARz2jKO9GqR8k+AZYwl+tItEBgeD0vA+ghECwoQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=En4mpUCo; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743781446; x=1775317446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wclIRAQFfE2pzVzzCPlSKXfar9IWu+zIoU0sBLVtp38=;
  b=En4mpUCo0sRNCVTx32Eq803PDdF9kKWPFWB8cBS6/4qHaWcILAROed7I
   vKAdgimouFxghEHK6oMJO4gCGEqSieurVwJ4TMUBRmhJVU6F9Islci43s
   mR4kF0BjLgwINZ8bzRzLQok/LPUPTGJ/BTjW/dGWM1j0RNLN9yi/qlyA3
   M=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="486684103"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:44:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:38790]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 19e4150d-3051-47dc-b5ab-c8164781f6fc; Fri, 4 Apr 2025 15:44:00 +0000 (UTC)
X-Farcaster-Flow-ID: 19e4150d-3051-47dc-b5ab-c8164781f6fc
Received: from EX19D003UWB001.ant.amazon.com (10.13.138.92) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:43:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D003UWB001.ant.amazon.com (10.13.138.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:43:55 +0000
Received: from email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 15:43:55 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-1box-1a-6851662a.us-east-1.amazon.com (Postfix) with ESMTPS id DE9684032D;
	Fri,  4 Apr 2025 15:43:52 +0000 (UTC)
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
Subject: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Date: Fri, 4 Apr 2025 15:43:46 +0000
Message-ID: <20250404154352.23078-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

This series is built on top of the Fuad's v7 "mapping guest_memfd backed
memory at the host" [1].

With James's KVM userfault [2], it is possible to handle stage-2 faults
in guest_memfd in userspace.  However, KVM itself also triggers faults
in guest_memfd in some cases, for example: PV interfaces like kvmclock,
PV EOI and page table walking code when fetching the MMIO instruction on
x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
that KVM would be accessing those pages via userspace page tables.  In
order for such faults to be handled in userspace, guest_memfd needs to
support userfaultfd.

Changes since v2 [4]:
 - James: Fix sgp type when calling shmem_get_folio_gfp
 - James: Improved vm_ops->fault() error handling
 - James: Add and make use of the can_userfault() VMA operation
 - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
 - James: Fix typos and add more checks in the test

Nikita

[1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
[2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
[3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
[4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/

Nikita Kalyazin (6):
  mm: userfaultfd: generic continue for non hugetlbfs
  mm: provide can_userfault vma operation
  mm: userfaultfd: use can_userfault vma operation
  KVM: guest_memfd: add support for userfaultfd minor
  mm: userfaultfd: add UFFD_FEATURE_MINOR_GUEST_MEMFD
  KVM: selftests: test userfaultfd minor for guest_memfd

 fs/userfaultfd.c                              |  3 +-
 include/linux/mm.h                            |  5 +
 include/linux/mm_types.h                      |  4 +
 include/linux/userfaultfd_k.h                 | 10 +-
 include/uapi/linux/userfaultfd.h              |  8 +-
 mm/hugetlb.c                                  |  9 +-
 mm/shmem.c                                    | 17 +++-
 mm/userfaultfd.c                              | 47 ++++++---
 .../testing/selftests/kvm/guest_memfd_test.c  | 99 +++++++++++++++++++
 virt/kvm/guest_memfd.c                        | 10 ++
 10 files changed, 188 insertions(+), 24 deletions(-)


base-commit: 3cc51efc17a2c41a480eed36b31c1773936717e0
-- 
2.47.1


