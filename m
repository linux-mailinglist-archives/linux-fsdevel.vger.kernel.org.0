Return-Path: <linux-fsdevel+bounces-59816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AB5B3E30D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198A97A8D78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BAE326D47;
	Mon,  1 Sep 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Uvm/pHRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6DF17A2E6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729837; cv=none; b=l9n48WCPk0XjLdi8aAB35OnDXcOXVT0TEVNU9oCHr7XRAMl2tQ37/RofSqKXPnFfIFmgJB1xkk9OZQiHEVxhO2wMPClfYJxguuWUUSSlswODiheDKHH9yEkNX8FaWEZRnBjPMFHLdbTsaLDpN/wSiA8kAUwQX3LIjT+0BYWO7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729837; c=relaxed/simple;
	bh=ymeIcfO5siUE2sOCLzmRutxlU15if7PhiIG2QigIMEY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L+rsBsSixqcwmPB5qkSHA+zdqQHKEfyT31LQrJAGFf7vqv+An+GHgiGN3HmugByVU96boB97aro/eTmYjFFdYUj055uqe6PC3XlzYnH8qC9XzT1Am8VgnZ1Uu09x1M77KNd1TBV/8lLP6IW+mNq4sBdr5ww90HgAIBGr/9kzCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Uvm/pHRi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso4392805a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729833; x=1757334633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrNbT6choDi3GgMhWeWNgFFS/EdlWGopjyFWK6pahow=;
        b=Uvm/pHRiQSJl/jP+0X7QpAySNr+dlAkQfnqCmB021oq7hHk9wXJqWrVuHIO5KiE7H+
         wUULFlcXhHykTl7USZRn/+nyYtqk/+46INuoyBUx1zKzFdKMgrM/j0o0XwTW9acn0/Uw
         psPYYs4L6vaXlq/lOY59mUAE/v7fJPuMTbMIXYRTP74KGMMDTT5L09Ho4ZF+lh+o7jCl
         qFNPlZNfArFdwcUBeCP2hWmc/F1eZkWmuCIy9I7RikcjibtlRehNeT1PXinJt+r3ZHmo
         we8fL89ssznlDkEuwJSrGcaoukvVP1KYHwUk1cUwXmM1Wgp+FqUMbkztyqyJrSEAXEH/
         lrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729833; x=1757334633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrNbT6choDi3GgMhWeWNgFFS/EdlWGopjyFWK6pahow=;
        b=BLTMtmKrNHW2JfDGgkqvMZtw3Or0/r+iaBtfwXsJfDMvFHC7NiaHLLzpA908xWz4fu
         DrJuMaNA8uP0L48oUuKVKJoFzpXBEM7PtXppKH2o+48LjskHEjATpMU8zCfk4NrRAD+1
         L8pTrHwnw0GWKb8cABpNTi4h59jSb2nouws1UQoW/5txrBLFwDxfdJD4ZwxIZ4e3gbTd
         FGPN9oFvjlCI1Klk8SRSqalD7tVLrLVzP3zuKkwqFCD6bOz6Bt0pm9memOSNrMcWSRsq
         GHzM5jxJmUhY1yiD6UdmJZmh3mN7eTbKoTWE3uZhOzMfvhqtzoDg3xtmnNinFpcF0+ke
         g5hw==
X-Forwarded-Encrypted: i=1; AJvYcCX8SipmhLiC7SztQncesufSVXagRD//DT3rnrNDupet/+5tvHxgmeDy5B5B47tx4SjR0VYX2HEfeh+drdYN@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFHYWuTrNz+iDHLDJvyMyc1z3pXQ76ZSAd8Ao2XkVdMvvRrPF
	6ziA+bMTM2rL/XGvCJ0H2OLF35xId/iZYnaCsLGdArb4fK6j7DEFXoyN2CdGhkTlf9s=
X-Gm-Gg: ASbGncvod7TCrp+jlFPpp65zR4J80M7gPPCHcIfBBsj7/p4g3VHTYmAF7xhVVcWwXL5
	ImZkXbfW5VFwipC4XukZfZ93ZDIj27tFS3o3L8I9/BEG48nBQ1TVF6e9od22UxwNKvMbobES9Vv
	YEBLassgHxwUPGfn0rgp9z7rtjDX90nI9AxgBPiGT8mr6lMICvowlC8CUAI5dedDaprIRI5havu
	h9IymHM9GfIZQUVask04n9oR6++FmWcIJ5R+ODDrV1hIkjOtrgNlFYtK8L8n3xFfVxaHXpEscfC
	dKF2foumPPb7KKIgkbhD+1N588DYf6nr65aYgQMRaBxbblgjS6NNcdswJnC9oXFnXDgx2UeFiXB
	a7MC/QOu5HFqTniHsmZQUO0PRT3agyDckwufsMm8UYpIzHUoxOLiIGASV2wUp8EdwUqiohWMamy
	JVJ9P+yi4mUjnnQlvd0DKtl7JmTID9txKh
X-Google-Smtp-Source: AGHT+IEIvcwSPmSxXCSKH0hPzJ7k/4E5ApIsDuAgvra/l5zTme80rYXYzWHYoZRuIErlfCsG0v7L6A==
X-Received: by 2002:a05:6402:270e:b0:617:b28c:e134 with SMTP id 4fb4d7f45d1cf-61d260cc308mr7198111a12.0.1756729833131;
        Mon, 01 Sep 2025 05:30:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:32 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 00/12] mm: establish const-correctness for pointer parameters
Date: Mon,  1 Sep 2025 14:30:16 +0200
Message-ID: <20250901123028.3383461-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

This patch series systematically adds const qualifiers to pointer
parameters throughout the memory management subsystem, establishing a
foundation for improved const-correctness across the entire Linux
kernel.

Const-correctness provides multiple benefits:

1. Type Safety: The compiler enforces that functions marked as taking
   const parameters cannot accidentally modify the data, catching
   potential bugs at compile time rather than runtime.

2. Compiler Optimizations: When the compiler knows data won't be
   modified, it can generate more efficient code through better
   register allocation, code motion, and aliasing analysis.

3. API Documentation: Const qualifiers serve as self-documenting code,
   making it immediately clear to developers which functions are
   read-only operations versus those that modify state.

4. Maintenance Safety: Future modifications to const-correct code are
   less likely to introduce subtle bugs, as the compiler will reject
   attempts to modify data that should remain unchanged.

The memory management subsystem is a fundamental building block of the
kernel.  Most higher-level kernel subsystems (filesystems, drivers,
networking) depend on mm interfaces.  By establishing
const-correctness at this foundational level:

1. Enables Propagation: Higher-level subsystems can adopt
   const-correctness in their own interfaces.  Without const-correct
   mm functions, filesystems cannot mark their own parameters const
   when they need to call mm functions.

2. Maximum Impact: Changes to core mm APIs benefit the entire kernel, as
   these functions are called from virtually every subsystem.

3. Prevents Impedance Mismatch: Without const-correctness in mm, other
   subsystems must either cast away const (dangerous) or avoid using
   const altogether (missing optimization opportunities).

Each patch focuses on a specific header or subsystem component to ease review
and bisection.

This work was initially posted as a single large patch:
 https://lore.kernel.org/lkml/20250827192233.447920-1-max.kellermann@ionos.com/

Following feedback from Lorenzo Stoakes and David Hildenbrand, it has been
split into focused, reviewable chunks. The approach was validated with a
smaller patch that received agreement:
 https://lore.kernel.org/lkml/20250828130311.772993-1-max.kellermann@ionos.com/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1 -> v2:
- made several parameter values const (i.e. the pointer address, not
  just the pointed-to memory), as suggested by Andrew Morton and
  Yuanchu Xie
- drop existing+obsolete "extern" keywords on lines modified by these
  patches (suggested by Vishal Moola)
- add missing parameter names on lines modified by these patches
  (suggested by Vishal Moola)
- more "const" pointers (e.g. the task_struct passed to
  process_shares_mm())
- add missing "const" to s390, fixing s390 build failure
- moved the mmap_is_legacy() change in arch/s390/mm/mmap.c from 08/12
  to 06/12 (suggested by Vishal Moola)

v2 -> v3:
- remove garbage from 06/12
- changed tags on subject line (suggested by Matthew Wilcox)

v3 -> v4:
- more verbose commit messages including a listing of function names
  (suggested by David Hildenbrand and Lorenzo Stoakes)

v4 -> v5:
- back to shorter commit messages after an agreement between David
  Hildenbrand and Lorenzo Stoakes was found

Max Kellermann (12):
  mm: constify shmem related test functions for improved
    const-correctness
  mm: constify pagemap related test functions for improved
    const-correctness
  mm: constify zone related test functions for improved
    const-correctness
  fs: constify mapping related test functions for improved
    const-correctness
  mm: constify process_shares_mm() for improved const-correctness
  mm, s390: constify mapping related test functions for improved
    const-correctness
  parisc: constify mmap_upper_limit() parameter for improved
    const-correctness
  mm: constify arch_pick_mmap_layout() for improved const-correctness
  mm: constify ptdesc_pmd_pts_count() and folio_get_private()
  mm: constify various inline test functions for improved
    const-correctness
  mm: constify assert/test functions in mm.h
  mm: constify highmem related functions for improved const-correctness

 arch/arm/include/asm/highmem.h      |  6 +--
 arch/parisc/include/asm/processor.h |  2 +-
 arch/parisc/kernel/sys_parisc.c     |  2 +-
 arch/s390/mm/mmap.c                 |  7 ++--
 arch/sparc/kernel/sys_sparc_64.c    |  3 +-
 arch/x86/mm/mmap.c                  |  7 ++--
 arch/xtensa/include/asm/highmem.h   |  2 +-
 include/linux/fs.h                  |  7 ++--
 include/linux/highmem-internal.h    | 44 +++++++++++----------
 include/linux/highmem.h             |  8 ++--
 include/linux/mm.h                  | 56 +++++++++++++--------------
 include/linux/mm_inline.h           | 26 +++++++------
 include/linux/mm_types.h            |  4 +-
 include/linux/mmzone.h              | 42 ++++++++++----------
 include/linux/pagemap.h             | 59 +++++++++++++++--------------
 include/linux/sched/mm.h            |  4 +-
 include/linux/shmem_fs.h            |  4 +-
 mm/highmem.c                        | 10 ++---
 mm/oom_kill.c                       |  7 ++--
 mm/shmem.c                          |  6 +--
 mm/util.c                           | 20 ++++++----
 21 files changed, 171 insertions(+), 155 deletions(-)

-- 
2.47.2


