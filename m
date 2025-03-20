Return-Path: <linux-fsdevel+bounces-44627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D7A6AC2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 18:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2377A8A2BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC22225785;
	Thu, 20 Mar 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pT/u7lc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519F224231
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492376; cv=none; b=eLOOU5iXud8Fy1lLzYE4YMol+3W/R19OBnfvf7/Xsfj1pc5MVsiX/OeckLRx3z48XyAdquBBsoAE1XwB0/CAIK2eWLpGSVoAl58/wwCYTcc0myL4yzAxF16M4o5Fgq8Eu3ILF8lsTD62hNbwsZYU3/7XYRZPDYp7jSVQ/nmwPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492376; c=relaxed/simple;
	bh=mAdFG00QLsGJXKgewrwZAnN8f1frbMLsHy23XVF4A1U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WmYdtqosrjWlBGCQ8ijMaJvJ39rPd5oRyxE8lyQBHfiwphFolBJ9Q07TqFaERmQHFLpOE6XYzyZFZqU5fPKekqqMb84atizahwTfvIrBvYNDrooff+XRUbD/cfCPsynt9N0TgACrqLZwxRQxmGa6uq7t7VuX8k8Nep6G8M3ujIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pT/u7lc+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so2474890a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742492374; x=1743097174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k6tEKz/UqhbyHPwZaieYYXzQwjdGTl6UqIIR/Zfit/M=;
        b=pT/u7lc+/3HGSu6BJElO1NcU5BxpHyj+LtSweRjerLENEgVYOLAyFIrRFS+gzlaeOk
         WOdsGJfXrQAS11XgdDc/nShkXyvljEVnTFmyTXLDpWhPLfLIOFRkKko/LrfDaMO+l7iu
         fySYqNdI8Zgvxm0UkWAeWA0DWata9Yg/Em3yC43r2XbMixfxEfI3v/bqVe135GkAhP7R
         ypD3I8fYicaKlfOWWINJOLidY+NYkPgBU3Cph1ExKi3RY/k5Ezvxu4zSfAI9CMlLCfwk
         UK83k4Rv01RDYBU3QAQ+7s5l8MaheQEmDId8UQHJpQG25Thw/BYFaW1xnE0PrpdJ8UA7
         wxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492374; x=1743097174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k6tEKz/UqhbyHPwZaieYYXzQwjdGTl6UqIIR/Zfit/M=;
        b=HXTjpsI4Y8YtogcFUml3SPp9+aUrbbd5vExKZLbLA5eUDrGWYZXH74kPRUAeIU/RqO
         j8wAtZZU7FoMGnvVBXqFxY60QnLGwNyosal6Zj6tKUepB435/Sdk/Wn3Qr4fVjg9EgsG
         B8Wum2x5awlshHU7LbaLtmU1ydnFa6t7jNBHoNHbXwhqClVzQyDwjreUALiMibAcfvFG
         PJY14uwQ4jkMI8ATBetPmwZlG25d9/TImTfAqoL9zMcqWOEnILqxo5DCy2JbzoKVb4kX
         Sb8+cSPCsFKDXxmCZMMfrVzFFg6fmr2y+mXbpx3LQFLijZn2cMn04MhkQD8agIiZBYhW
         dWvA==
X-Forwarded-Encrypted: i=1; AJvYcCUSju5m7eN6eTWs6HzLgwgBNeyXsY0XisgqMYeGD1A0/SBMhnBBGXdq4rUYtZC1e0ZH6jpVPKKNQHDFlTwd@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYPf3Y/vnGHxeY36WLLcWigsC+roUQfPmjyliyNxMOKiXSyTn
	p0oeGFA1n14HXkRwzoGbeLl9VCsFVoTf2xsRmu4almQtYTVQOtSQyZnoZcm58eRSbpTQdPqN8X9
	X8A==
X-Google-Smtp-Source: AGHT+IGIxvxSLNwY9Q0/avXwy1mxv0PoM1/FD7lwSCmDvbaod/z/NHWuwhtnOKOlvUCBtbnjCWplqo4dvqI=
X-Received: from pjbsi11.prod.google.com ([2002:a17:90b:528b:b0:2f9:c349:2f84])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc6:b0:2fe:a79e:f56f
 with SMTP id 98e67ed59e1d1-3030fe9e9c3mr149779a91.13.1742492374365; Thu, 20
 Mar 2025 10:39:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:39:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320173931.1583800-1-surenb@google.com>
Subject: [RFC 0/3] Guaranteed CMA
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@redhat.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, liam.howlett@oracle.com, alexandru.elisei@arm.com, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com, mina86@mina86.com, 
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, hbathini@linux.ibm.com, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, aneesh.kumar@kernel.org, 
	bhelgaas@google.com, sj@kernel.org, fvdl@google.com, ziy@nvidia.com, 
	yuzhao@google.com, minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This RFC is posted to collect feedback and to be used as a reference
implementation for the upcoming LSF/MM discussion. The code is not of
production quality and needs more testing.

Guaranteed CMA (GCMA) is designed to improve utilization of reserved
memory carveouts without compromising their advantages of:
1. Guaranteed success of allocation (as long as total allocation size is
below the size of the reservation.
2. Low allocation latency.
The idea is that carved out memory when not used for its primary purpose
can be donated and used as an extension of the pagecache and any donated
page can be taken back at any moment with minimal latency and guaranteed
success.

To achieve this, GCMA needs to use memory that is not addressable by the
kernel (can't be pinned) and that contains content that can be discarded.
To provide such memory we reintroduce cleancache idea [1] with two major
changes. New implementation:
1. Avoids intrusive hooks into filesystem code, limiting them to two hooks
for filesystem mount/unmount events and a hook for bdev invalidation.
2. Manages fs->inode->page tracking and handles pools of donated pages
inside cleancache itself, freeing backends of this burden.
Cleancache provides a simple interface to its backends which lets them
donate a bunch of pages to cleancache, take a page back for own use and
return the page back to cleancache when not needed.

With cleancache in place, GCMA becomes a thin layer linking CMA allocator
to cleancache which allows existing CMA API to be used for continuous
memory allocations with additional guarantees listed above.
The limitation of GCMA is that its donated memory can be used only to
extend file-backed pagecache. Note that both CMA and GCMA can be used
at the same time.

The patchset borrows some ideas and code from previous implementations of
the cleancache and GCMA [2] as well as Android's reference patchset [3]
implemented by Minchan Kim and used by many Android vendors.

[1] https://elixir.bootlin.com/linux/v5.16.20/source/Documentation/vm/cleancache.rst
[2] https://lore.kernel.org/lkml/1424721263-25314-1-git-send-email-sj38.park@gmail.com/
[3] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Minchan Kim (1):
  mm: introduce GCMA

Suren Baghdasaryan (2):
  mm: implement cleancache
  mm: integrate GCMA with CMA using dt-bindings

 arch/powerpc/kernel/fadump.c |   2 +-
 block/bdev.c                 |   8 +
 fs/super.c                   |   3 +
 include/linux/cleancache.h   |  88 ++++
 include/linux/cma.h          |   2 +-
 include/linux/fs.h           |   7 +
 include/linux/gcma.h         |  12 +
 kernel/dma/contiguous.c      |  11 +-
 mm/Kconfig                   |  32 ++
 mm/Makefile                  |   2 +
 mm/cleancache.c              | 926 +++++++++++++++++++++++++++++++++++
 mm/cma.c                     |  33 +-
 mm/cma.h                     |   1 +
 mm/cma_sysfs.c               |  10 +
 mm/filemap.c                 |  63 ++-
 mm/gcma.c                    | 155 ++++++
 mm/truncate.c                |  21 +-
 17 files changed, 1356 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/cleancache.h
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/cleancache.c
 create mode 100644 mm/gcma.c


base-commit: 40caf747267c18b6206e26a37d6ea6b695236c11
-- 
2.49.0.rc1.451.g8f38331e32-goog


