Return-Path: <linux-fsdevel+bounces-63702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360FEBCB53F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 03:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3026C19E70ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8A2264AB;
	Fri, 10 Oct 2025 01:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mfd/hyml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF034BA58
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760059198; cv=none; b=PNjKrlPKFdnHLFnfdnmJTI0hF9PSXFV1aB8SD0VrsOW3cufNQQVe1iYtdd+qT8wC0dFiDT2tdC4MOZGA6Xw9zkwb8kgVxFukngoAMZLX8iLPMElpvuCKoy+HSTlIXjnQo9y05UHMRhWGOLkD03hDRtEDMjx7ounNQ9IlFXGtKjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760059198; c=relaxed/simple;
	bh=uaTvHrHRLctEDmqgKU6Co6gfADnqxXrJ/YLmUpeeOrY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oN2hZt9/kaWqWirH34ULzIDB+quUqi+QOkg5QVNlbB8AmL9HsSbP389EfQiEx7wRAapRd5171qAcXgXUET2MGI5MPTxdbh06EXoqFyVETuXavRGXpXgosI5ZWRUkQNEQDW5vdY/2iGZfGRMBlCo3a3Q9izuARnLEJ0PKhus8P78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mfd/hyml; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269939bfccbso30511855ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760059196; x=1760663996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Umr72UDM+ef/eu/5GGg59+M3j2MSWUMKK6kjEtNqzt4=;
        b=Mfd/hymlEn1QCs5BP6bx7Kp6cGxJm9jMAT13K+BusQRgl6R12p+te46wjuQ5f+tbdD
         a3QVIXbAIjXDEJCzVgdut99Se5An64wmMBYIEeZ2ARMly2xH/V2xl+9IwDPTk0zc5j/C
         1lkdwg6boq/B2oIuTNmQl/mchTV9tchS72oesmfIePZboNjc0aE/XtKX/tvtjxYWmz8S
         VarjtKkaNF2x3RetsYD2UGHiRK2m3pAKbdonc30ZEUV8rmpAy+NzbsgEbvUTG3ibZJDj
         x+DIzwNWGW+eel3Q2btWQyyxFw5NnoalaJ4HSL09CX2Ry/v7Aje3WqjYXKjbX1NscgQt
         jkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760059196; x=1760663996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Umr72UDM+ef/eu/5GGg59+M3j2MSWUMKK6kjEtNqzt4=;
        b=qnnXuqiLSsXxNzTHVnZOjucYsisjcJHVRkugNY/HGzyx8pH4Ly2uDEH+sar7/gdVeU
         7ogAmg4pEI2F0L7O7qDwqFy8lfWleT+kb+5ipYVjQSNRE3Lp8Bgie3GJ8lNwgQCzSqCZ
         YGIcd330hzITop7ZL6p6PByxbf/Eepg1/M71t+ViJ9IoArQqFGIlxtKw49KWCB1mSFll
         yyi7Q0x3sOY/6QsSYUwkYwjDjDaqNyiBpfhO8iEhSwq38hE0HhcGahvlEGiNPtZ2DUxw
         7oF6CdbhHzosvf6XlEX/ZJ7DtpP5ZQ9bKgqpxVXcpm75Wask3iXoI0SjLekKv32Zm/mD
         B/7w==
X-Forwarded-Encrypted: i=1; AJvYcCWOQ49Fcq3k6Mfd3p7wgVXigtVC+gQkCIiZzl9BSLx+fRekFXy+W9HybIK9rQRL7sjZ3m4myHvBVwO+u6wm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcy4B+rHn4mjAzhfGtI/XuD85kLecmo4crV1ufuVPzHz53pagt
	tnSw1YHsaOlmMxPOVCsbbzE61zMVmYBBPe/9nT2wyN+Wts2D886Xa8Ep2udfCr3PHrBVp2kDMR5
	NU6vhVA==
X-Google-Smtp-Source: AGHT+IE27KyVOHtRVs+A0lEatoDCera078aKUGcBNIuc3h+4WOD0YdO+2yFbdCIN2uDuSh9GKzfzUmBfEEw=
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:28e:7f4e:dd17])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec83:b0:267:d2f9:2327
 with SMTP id d9443c01a7336-2902739b36dmr131881235ad.27.1760059195894; Thu, 09
 Oct 2025 18:19:55 -0700 (PDT)
Date: Thu,  9 Oct 2025 18:19:43 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251010011951.2136980-1-surenb@google.com>
Subject: [PATCH 0/8] Guaranteed CMA
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, alexandru.elisei@arm.com, peterx@redhat.com, sj@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, corbet@lwn.net, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	willy@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	hannes@cmpxchg.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	minchan@kernel.org, surenb@google.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Guaranteed CMA (GCMA) is designed to improve utilization of reserved
memory carveouts without compromising their advantages of:
1. Guaranteed success of allocation (as long as total allocation size is
below the size of the reservation.
2. Low allocation latency.
The idea is that carved out memory when not used for its primary purpose
can be donated and used as an extension of the pagecache and any donated
folio can be taken back at any moment with minimal latency and guaranteed
success.

To achieve this, GCMA needs to use memory that is not addressable by the
kernel (can't be pinned) and that contains content that can be discarded.
To provide such memory we reintroduce cleancache idea [1] with two major
changes. New implementation:
1. Avoids intrusive hooks into filesystem code, limiting them to two hooks
for filesystem mount/unmount events and a hook for bdev invalidation.
2. Manages inode to folio association and handles pools of donated folios
inside cleancache itself, freeing backends of this burden.

Cleancache provides a simple interface to its backends which lets them
donate folios to cleancache, take a folio back for own use and return the
folio back to cleancache when not needed.

With cleancache in place, GCMA becomes a thin layer linking CMA allocator
to cleancache, which allows existing CMA API to be used for continuous
memory allocations with additional guarantees listed above.
The limitation of GCMA is that its donated memory can be used only to
extend file-backed pagecache. Note that both CMA and GCMA can be used
at the same time.

Accounting for folios allocated from GCMA is implemented the same way as
for CMA. The reasoning is that both CMA and GCMA use reserved memory for
contiguous allocations with the only difference in how that memory gets
donated while not in use. CMA donates its memory to the system for movable
allocations with expectation that it will be returned when it is needed.
GCMA donatest its memory to cleancache with the same expectation. Once CMA
or GCMA use that memory for contiguous allocation, the difference between
them disappears, therefore accounting at that point should not differ.

The patchset borrows some ideas and code from previous implementations of
the cleancache and GCMA [2] as well as Android's reference patchset [3]
implemented by Minchan Kim and used by many Android vendors.

[1] https://elixir.bootlin.com/linux/v5.16.20/source/Documentation/vm/cleancache.rst
[2] https://lore.kernel.org/lkml/1424721263-25314-1-git-send-email-sj38.park@gmail.com/
[3] https://android-review.googlesource.com/q/topic:%22gcma_6.12%22

Patchset is based on mm-new.

Minchan Kim (1):
  mm: introduce GCMA

Suren Baghdasaryan (7):
  mm: implement cleancache
  mm/cleancache: add cleancache LRU for folio aging
  mm/cleancache: readahead support
  mm/cleancache: add sysfs interface
  mm/tests: add cleancache kunit test
  add cleancache documentation
  mm: integrate GCMA with CMA using dt-bindings

 Documentation/mm/cleancache.rst |  112 +++
 MAINTAINERS                     |   13 +
 block/bdev.c                    |    6 +
 fs/super.c                      |    3 +
 include/linux/cleancache.h      |   84 +++
 include/linux/cma.h             |   11 +-
 include/linux/fs.h              |    6 +
 include/linux/gcma.h            |   36 +
 include/linux/pagemap.h         |    1 +
 kernel/dma/contiguous.c         |   11 +-
 mm/Kconfig                      |   40 ++
 mm/Kconfig.debug                |   13 +
 mm/Makefile                     |    4 +
 mm/cleancache.c                 | 1144 +++++++++++++++++++++++++++++++
 mm/cleancache_sysfs.c           |  209 ++++++
 mm/cleancache_sysfs.h           |   58 ++
 mm/cma.c                        |   37 +-
 mm/cma.h                        |    1 +
 mm/cma_sysfs.c                  |   10 +
 mm/filemap.c                    |   26 +
 mm/gcma.c                       |  231 +++++++
 mm/readahead.c                  |   55 ++
 mm/tests/Makefile               |    6 +
 mm/tests/cleancache_kunit.c     |  425 ++++++++++++
 mm/truncate.c                   |    4 +
 mm/vmscan.c                     |    1 +
 26 files changed, 2534 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/mm/cleancache.rst
 create mode 100644 include/linux/cleancache.h
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/cleancache.c
 create mode 100644 mm/cleancache_sysfs.c
 create mode 100644 mm/cleancache_sysfs.h
 create mode 100644 mm/gcma.c
 create mode 100644 mm/tests/Makefile
 create mode 100644 mm/tests/cleancache_kunit.c


base-commit: 70478cb9da6fc4e7b987219173ba1681d5f7dd3d
-- 
2.51.0.740.g6adb054d12-goog


