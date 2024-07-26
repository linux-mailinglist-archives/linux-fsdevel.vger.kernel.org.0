Return-Path: <linux-fsdevel+bounces-24327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C193D59A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C0BB21775
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F7149001;
	Fri, 26 Jul 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRacDgs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA21791F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006474; cv=none; b=tB7i9KfqjzYXCrwx0TfNRfxAHUcC46+MsZvBHqBv0JUsg6KB250sySMdZ8O+nGfnrAmD/A9l/64T2OYdPa8Lu7w8rESbvcXdGwWWqClBHb6AbiWZu8UZ3wQnVDvff+87Yo2ocpKqg1Dbuv9XBC3CXRm5UMPs4kkkLASm2aBoUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006474; c=relaxed/simple;
	bh=l9aMkn+xt88Ok0/4b9aN2UQPYeXAHN9x8QJcScXTjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwpFFVUsQv3fd7oSVXG7THcWniu1FzijJbqWfkq8TU4eVTG4Ti2ctmnLKrqrDRSiuIYGCpwRrBgIVgIBSQKNQNj91A1YmP8HfrTHWyix9Pk9xtvbkRgG9OWoSxOX4jcte119PKod5I4oEisN6EhyX1BPos19ELIFjy5uXH99JFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRacDgs/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722006472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hcrSbRRNq3UgkpcRSzhVfFxj5WTgmNA01IUpGR6Hr34=;
	b=XRacDgs/Mzs2TRDlJQVyC6a336xwSil5aqS5yuXTP8IVRDDjK1CGK+fzRS2R9garMIlqId
	Ftt8/bEmY7kyYiLWHzzLMACB1LAHJe4oFhkYhHpbgkVeNl3BiHMrGx38tBiFL545r38ZM1
	Rg0QMMalGMXndwZxIiq5YWPQeaE2AdE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-uU9eNeBmOBmxsbHiNspYkQ-1; Fri,
 26 Jul 2024 11:07:47 -0400
X-MC-Unique: uU9eNeBmOBmxsbHiNspYkQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 396AC1955D4D;
	Fri, 26 Jul 2024 15:07:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF9BB1955D45;
	Fri, 26 Jul 2024 15:07:31 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 0/3] mm: split PTE/PMD PT table Kconfig cleanups+clarifications
Date: Fri, 26 Jul 2024 17:07:25 +0200
Message-ID: <20240726150728.3159964-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This series is a follow up to the fixes:
	"[PATCH v1 0/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking"

When working on the fixes, I wondered why 8xx is fine (-> never uses split
PT locks) and how PT locking even works properly with PMD page table
sharing (-> always requires split PMD PT locks).

Let's improve the split PT lock detection, make hugetlb properly depend
on it and make 8xx bail out if it would ever get enabled by accident.

As an alternative to patch #3 we could extend the Kconfig SPLIT_PTE_PTLOCKS
option from patch #2 -- but enforcing it closer to the code that actually
implements it feels a bit nicer for documentation purposes, and there
is no need to actually disable it because it should always be disabled
(!SMP).

Did a bunch of cross-compilations to make sure that split PTE/PMD
PT locks are still getting used where we would expect them.

[1] https://lkml.kernel.org/r/20240725183955.2268884-1-david@redhat.com

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>

David Hildenbrand (3):
  mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig
    options
  mm/hugetlb: enforce that PMD PT sharing has split PMD PT locks
  powerpc/8xx: document and enforce that split PT locks are not used

 arch/arm/mm/fault-armv.c      |  6 +++---
 arch/powerpc/mm/pgtable.c     |  6 ++++++
 arch/x86/xen/mmu_pv.c         |  7 ++++---
 fs/Kconfig                    |  4 ++++
 include/linux/hugetlb.h       |  5 ++---
 include/linux/mm.h            |  8 ++++----
 include/linux/mm_types.h      |  2 +-
 include/linux/mm_types_task.h |  3 ---
 kernel/fork.c                 |  4 ++--
 mm/Kconfig                    | 18 +++++++++++-------
 mm/hugetlb.c                  |  8 ++++----
 mm/memory.c                   |  2 +-
 12 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.45.2


