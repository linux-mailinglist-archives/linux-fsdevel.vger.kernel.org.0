Return-Path: <linux-fsdevel+bounces-76223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HSGHVRLgmnNRwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A2ADE20F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 20:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB04F3038FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E2345CCE;
	Tue,  3 Feb 2026 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C06PM+iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CE329378
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146638; cv=none; b=HllpPdNHI+9W9XJaHflviAnpwc5zC8siyXO6lKTsupSGEVB1AQw6iqeKKei08bxU1QfGPTDVfUNBEHFVcAN+egst3bAU87Ufv/2pZMg7GTfcdaDK6P2lXCFm6t/ls1e8fJx69ORkrLeqB1hSIMiOVdwscD1/wU9GRHzUGBdUEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146638; c=relaxed/simple;
	bh=m9YPivXEo162F+1tZx67d0awtEn5/61na+XGoPPBok4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XN2l9LCjjsQWeXDwqi7O42qVazuc6WnKMTwL/jLTZ1kV5WLOmk5ei4plBRXW/0dKW58aKFEd+1JTxO3t2ndQKn47Kk8QLfr7KwWraoXgioM8aN9IeOR+5oocB5Why50yOAF+o4VnW8BCxmg8T3AkTjzPYi6WhK60Bs5wDmLdjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C06PM+iC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c337cde7e40so3783516a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770146635; x=1770751435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=95Pw2DdmywMK3Koth7G2RTcpT3ER5Cfb3Bey9F5Hbow=;
        b=C06PM+iC5SSZWF64gDF2+mHK5XARllnuLKCqkUGBdm4znYWVvUhJIfbIMv811XGkzq
         g60+rcsJ/Fyhqv2FyDUN2yWr/++l21RPt2Khb3YO0wYuMPI6o4xnFMVCxpE8vSVoWa0U
         4u3dReIhCzRdsg/C5O9vIrrfRZIOj3yhvJ330nnfjfYfHYRUXEvMmyoD2mJZBfqQVuhc
         Wid0a26mvJpN4uOcuCzfWH28Tyj0tOhX+9AE2qMTnPhxauFjBivSb7KbLvof4v1OsEeq
         NZVPwW9p1OcKVdsAw/5yb6Ir9La3Ra+CCmgoihgaVUQ/CwdcAdKrbYSoSD94Duua7KBu
         HaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146635; x=1770751435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95Pw2DdmywMK3Koth7G2RTcpT3ER5Cfb3Bey9F5Hbow=;
        b=v5G/oaE9ItwkIezAnk7jphOjQZL9n0+OmEUQdfsvZE7YwQqTLmFlspNuMqn7JOoLOx
         VEHH8/1+deKuTnlaSqgeGpJI9HC9pjnzlekcSnadVA+tkE6W2pCq+w+h8yvMTVPwkw4G
         0je3NtRueHnwfHSkGXYcMfipWEPO3aT4Vt8oQ0mEDsFHZI3E6yOCa82cqFFWLm3arDfl
         A3hdul4SYfucAHM7B2Xji5BTpnAFZmKDSelKGR1blYphjMid/8VRvxBvnhbralDIcVGT
         SUncQo7BdeZQ8NMwV9nRQxkdYdIWSQto+DlpehT5uZwgyPgWhcjlfcfk7OhR0mcl+5+A
         5VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVERyGUHPXiNj36uRpl08rhBjhqVdRrlWY2uc4GpQ2jZcxoqha1Q06yUhProb3ViUrEbJm6klgKvjAFYoAI@vger.kernel.org
X-Gm-Message-State: AOJu0YzBcmA1Mp2iq/cjst5Yii82khOI5Ozv1jVWj9UmyHFG54dB6HHu
	fvDrgfOGW3SaW/imtCankADqiwp9099H4EElzls9l/1YImBLEWaX2tpCe8ki6YRHW4o4VIHqocf
	uPn3gNIy6dR/DRg==
X-Received: from pgce17.prod.google.com ([2002:a05:6a02:1d1:b0:c66:bca:633d])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d9e:b0:35d:f625:7e87 with SMTP id adf61e73a8af0-393720d0461mr520709637.22.1770146635467;
 Tue, 03 Feb 2026 11:23:55 -0800 (PST)
Date: Tue,  3 Feb 2026 19:23:49 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203192352.2674184-1-jiaqiyan@google.com>
Subject: [PATCH v3 0/3] memfd-based Userspace MFR Policy for HugeTLB
From: Jiaqi Yan <jiaqiyan@google.com>
To: linmiaohe@huawei.com, william.roche@oracle.com, harry.yoo@oracle.com, 
	jane.chu@oracle.com
Cc: nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76223-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,huawei.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,oracle.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4A2ADE20F
X-Rspamd-Action: no action

Problem
=======

This patchset is a follow-up for the userspace memory failure
recovery (MFR) policy proposed in [1] and [2], but focused on
a smaller scope: HugeTLB.

To recap the problem for HugeTLB discussed in [1] and [2]:
Cloud providers like Google and Oracle usually serve capacity-
and performance-critical guest memory with 1G HugeTLB
hugepages, as this significantly reduces the overhead
associated with managing page tables and TLB misses. However,
the kernel's current MFR behavior for HugeTLB is not ideal.
Once a byte of memory in a hugepage is hardware corrupted, the
kernel discards the whole hugepage, including the healthy
portion, from the HugeTLB system. Customer workload running in
the VM can hardly recover from such a great loss of memory.

[1] and [2] proposed the idea that the decision to keep or
discard a large chunk of contiguous memory exclusively owned
by a userspace process due to a recoverable uncorrected
memory error (UE) should be controlled by userspace. What this
means in the Cloud case is that, since a virtual machine
monitor (VMM) has taken host memory to exclusively back the
guest memory for a VM, the VMM can keep holding the memory
even after memory errors occur.

MFD_MF_KEEP_UE_MAPPED for HugeTLB
=================================

[2] proposed a solution centered around the memfd associated
with the memory exclusively owned by userspace.

A userspace process must opt into the MFD_MF_KEEP_UE_MAPPED
policy when it creates a new HugeTLB-backed memfd:

  #define MFD_MF_KEEP_UE_MAPPED	0x0020U
  int memfd_create(const char *name, unsigned int flags);

For any hugepage associated with the MFD_MF_KEEP_UE_MAPPED
enabled memfd, whenever it runs into a UE, MFR doesn't hard
offline the HWPoison huge folio. In other words, the
HWPoison memory remains accessible via the returned memfd
or the memory mapping created with that memfd. MFR still sends
SIGBUS to the userspace process as required. MFR also still
maintains HWPoison metadata on the hugepage having the UE.

A HWPoison hugepage will be immediately isolated and
prevented from future allocation once userspace truncates it
via the memfd, or the owning memfd is closed.

By default MFD_MF_KEEP_UE_MAPPED is not set, and MFR hard
offlines hugepages having UEs.

Implementation
==============

Implementation is relatively straightforward with two major parts.

Part 1: When hugepages owned by an MFD_MF_KEEP_UE_MAPPED
enabled memfd run into a UE:

* MFR defers hard offline operations, i.e., unmapping and
  dissolving. MFR still sets HWPoison flags and holds a refcount
  for every raw HWPoison page. MFR still sends SIGBUS to the
  consuming thread, but si_addr_lsb will be reduced to PAGE_SHIFT.
* If the memory was not faulted in yet, the fault handler also
  needs to unblock the fault to the HWPoison folio.

Part 2: When an MFD_MF_KEEP_UE_MAPPED enabled memfd is being
released, or when a userspace process truncates a range of
hugepages belonging to an MFD_MF_KEEP_UE_MAPPED enabled memfd:

* When the HugeTLB in-memory file system removes a filemap's
  folios one by one, it asks MFR to deal with HWPoison folios
  on the fly, implemented by filemap_offline_hwpoison_folio().

* MFR drops the refcounts being held for the raw HWPoison
  pages within the folio. Now that the HWPoison folio becomes
  a free HugeTLB folio, MFR dissolves it into a set of raw pages.

Changelog
=========

v3 -> v2 [3]

- Rebase onto [4] to simplify filemap_offline_hwpoison_folio_hugetlb().
  With free_has_hwpoisoned() rejecting HWPoison subpages in a HugeTLB
  folio, there is no need to take_page_off_buddy() after
  dissolve_free_hugetlb_folio().

- Address comments from William Roche <william.roche@oracle.com> and
  Jane Chu <jane.chu@oracle.com>.

- Update size_shift in kill_accessing_process() if MFD_MF_KEEP_UE_MAPPED
  is enabled. Thanks William Roche <william.roche@oracle.com> for providing
  his patch on this.

- Add a new tunable to hugetlb-mfr to control the number of pages within
  the 1st hugepage to MADV_HWPOISON.

v2 -> v1 [2]

- Rebase onto commit 6da43bbeb6918 ("Merge tag 'vfio-v6.18-rc6' of
  https://github.com/awilliam/linux-vfio").

- Remove populate_memfd_hwp_folios() and offline_memfd_hwp_folios() so
  that no memory allocation is needed during releasing HWPoison memfd.

- Insert filemap_offline_hwpoison_folio() into remove_inode_single_folio().
  Now dissolving and offlining HWPoison huge folios is done on the fly.

- Fix the bug pointed out by William Roche <william.roche@oracle.com>:
  call take_page_off_buddy() no matter HWPoison page is buddy page or not.

- Remove update_per_node_mf_stats() when dissolve failed.

- Make hugetlb-mfr allocate 4 1G hugepages to cover new code introduced
  in remove_inode_hugepages().

- Make hugetlb-mfr support testing both 1GB and 2MB HugeTLB hugepages.

- Fix some typos in documentation.

[1] https://lwn.net/Articles/991513
[2] https://lore.kernel.org/lkml/20250118231549.1652825-1-jiaqiyan@google.com
[3] https://lore.kernel.org/linux-mm/20251116013223.1557158-3-jiaqiyan@google.com
[4] https://lore.kernel.org/linux-mm/20260202194125.2191216-1-jiaqiyan@google.com

Jiaqi Yan (3):
  mm: memfd/hugetlb: introduce memfd-based userspace MFR policy
  selftests/mm: test userspace MFR for HugeTLB hugepage
  Documentation: add documentation for MFD_MF_KEEP_UE_MAPPED

 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/mfd_mfr_policy.rst          |  60 +++
 fs/hugetlbfs/inode.c                          |  25 +-
 include/linux/hugetlb.h                       |   7 +
 include/linux/pagemap.h                       |  23 ++
 include/uapi/linux/memfd.h                    |   6 +
 mm/hugetlb.c                                  |   8 +-
 mm/memfd.c                                    |  15 +-
 mm/memory-failure.c                           | 124 +++++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/hugetlb-mfr.c      | 369 ++++++++++++++++++
 12 files changed, 627 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst
 create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c

-- 
2.53.0.rc2.204.g2597b5adb4-goog


