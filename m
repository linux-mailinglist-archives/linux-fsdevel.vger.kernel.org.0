Return-Path: <linux-fsdevel+bounces-65643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AADC0B2FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 21:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C031898C4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 20:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C652F656B;
	Sun, 26 Oct 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnPUUDOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED023EAB2
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510979; cv=none; b=bgGEr4hB5dhw2LlHbeE3ogABvY53yq4ayUWhrM3VrI503p2F8nDG0zoZpeUWEGJpKGQRHfJyF/47FnRJ1odWbH0YQpReQeaidmNlnKhFX3X4LjHH1wJ/1j8MJpJ7V4OrURpsUdptgigHZLsXX/Vpvgt24sOhId4hHu1LcKPtErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510979; c=relaxed/simple;
	bh=EtPHM/rxvf1s6wpudENnj+c1ViV9senew6m5yYbiKog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vv/EPZtCjzS9iNujPHJltMLK4AIQyngh4Y3PMpnwHc5vUg0qTL+s6IIRhNXaTup9bNcRnWta/8Xlfj/spp5pRZUSpyZf05lCqE3/N8D5bBn70ZKDi+4aPw2/1CUx+3p6ZKesIQmqjHtX8tq1e9PNqv2vnYqmec1u3BD9AMJtHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnPUUDOP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-77fa2ee9cb6so48089517b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Oct 2025 13:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761510976; x=1762115776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oIYNgmwaiZev52ielsOny0g8kp/qW6C19JMGXvUOw8g=;
        b=nnPUUDOP4vNpiN1JkUwR2VQk5zKdhdf6YMDBHoaqPiKQbK7V78fPyfor29DYhtdN1N
         rnGgSXXLyrG4LgPUV09tkDDyAZ5VHm8p0h8d6+YYegZMKZWcaMEt17AO2MkJSiEGju0X
         v0tsRA3l3YDp0Ug/Y0jDFW0Nj7/otmw0Q1/4ugJVReLbW2XMT8n30IEajT2mlc+7RNA9
         DxkVjsVGpalDNfgZPF0f1AhtuHDDbQ1/kF9rO9jxo/FjiL1zQeo7ySGeYXLOmVVofIhF
         NM3k7tXzPWeKCsCvueA1wNx7vrAgVD7AUjNQecdUHlZIG2Na/UGb/1loPWMG+3n1yAwt
         sUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510976; x=1762115776;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIYNgmwaiZev52ielsOny0g8kp/qW6C19JMGXvUOw8g=;
        b=TBLL7YGhlb0aINus+NnQvSnBipiCzfNv0xprHgjbCd3gTS/uxOjlzYXcKeCBZtHM05
         Vzxz7QE+VpY1FTtYgQWcdyLfS5Ortg6jfdCPLMNXeVDw+kRUj0Dh5cvnC1Dy3aNute+y
         CXfSJpwii9DClBFAkjBKECxj/u2dsZPBr8GrFQu8jFg9qM3CnmmnYGEXJwLweATDffwG
         bB7iqDYTGvr8zpRLoIwyKP05rle5CHw+UYCRsiUZlMpHIvP+T8jaiVgH4imEtKmXsaRp
         64yKx1zPe18TAccQH/aGbQHx3WjHtZjQldH+K637uOe8IOnnW91QVS8QAHn2Q5w950J+
         aG5w==
X-Forwarded-Encrypted: i=1; AJvYcCUieBsZeijLOpH1LWnqQPu+iRcG3NNrdNAGa/OMYRwiaLbe+CfHfCWLOHVGchpLCnw+mEvxys3eOFunZzZN@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtndKC623myQ+SzL1Iub5/qWN6Ain6RgriQinNtnZU0SbjrD5
	iGW7kYOc+rGZvjdHL7Dw+EyCW4o+eEdB3IW2QvAGopTZ++cDjsJVULl/JvvROOE61uAx1+butN5
	jV13jsg==
X-Google-Smtp-Source: AGHT+IEQ9Pwyyd7kjVHYsKEBM6jXV+KGbNmmj3ZfQc3rnB2XqZ4bQZDKRwRIjK4vvzIoUgZwP2mnd9XDO/0=
X-Received: from yxdd3.prod.google.com ([2002:a05:690e:2443:b0:63f:2d9a:656b])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:9a07:b0:784:8620:1c49
 with SMTP id 00721157ae682-78486201eacmr444866607b3.30.1761510975632; Sun, 26
 Oct 2025 13:36:15 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:36:03 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251026203611.1608903-1-surenb@google.com>
Subject: [PATCH v2 0/8] Guaranteed CMA
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

Changes since v1 [1]:
- Removed extra address_space parameter in cleancache hooks,
per Matthew Wilcox
- Updated comments to replace page with folio, per Matthew Wilcox
- Removed unnecessary new abbreviations from Kconfig, changelog and
documentation, per Matthew Wilcox
- Removed unnecessary comment about lock protecting xarray,
per Matthew Wilcox
- Replaced IDR with xarray for storage, per Matthew Wilcox
- Added unions in the folio for aliased fields, per Matthew Wilcox
- Removed an unused variable in the test, per kernel test robot
- Linked the cleancache document in mm/index.rst, per SeongJae Park
- Split cleancache sysfs documenation into cleancache_sysfs.rst and
linked it in Documentation/admin-guide/mm/index.rst, per SeongJae Park
- Cleaned up free_folio_range() code, per SeongJae Park
- Reworked gcma_free_range() to handle failures and properly rollback
refcount changes, per SeongJae Park
- Removed references to transcendent memory, per SeongJae Park
- Other minor documentation fixups, per SeongJae Park
- Added Minchan Kim as cleancache maintainer
- Minor code and documentation cleanups

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

 .../admin-guide/mm/cleancache_sysfs.rst       |   51 +
 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/mm/cleancache.rst               |   68 +
 Documentation/mm/index.rst                    |    1 +
 MAINTAINERS                                   |   15 +
 block/bdev.c                                  |    6 +
 fs/super.c                                    |    3 +
 include/linux/cleancache.h                    |   77 ++
 include/linux/cma.h                           |   11 +-
 include/linux/fs.h                            |    6 +
 include/linux/gcma.h                          |   36 +
 include/linux/mm_types.h                      |   12 +-
 include/linux/pagemap.h                       |    1 +
 kernel/dma/contiguous.c                       |   11 +-
 mm/Kconfig                                    |   39 +
 mm/Kconfig.debug                              |   13 +
 mm/Makefile                                   |    4 +
 mm/cleancache.c                               | 1127 +++++++++++++++++
 mm/cleancache_sysfs.c                         |  209 +++
 mm/cleancache_sysfs.h                         |   58 +
 mm/cma.c                                      |   37 +-
 mm/cma.h                                      |    1 +
 mm/cma_sysfs.c                                |   10 +
 mm/filemap.c                                  |   26 +
 mm/gcma.c                                     |  244 ++++
 mm/readahead.c                                |   54 +
 mm/tests/Makefile                             |    6 +
 mm/tests/cleancache_kunit.c                   |  420 ++++++
 mm/truncate.c                                 |    4 +
 mm/vmscan.c                                   |    1 +
 30 files changed, 2537 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/cleancache_sysfs.rst
 create mode 100644 Documentation/mm/cleancache.rst
 create mode 100644 include/linux/cleancache.h
 create mode 100644 include/linux/gcma.h
 create mode 100644 mm/cleancache.c
 create mode 100644 mm/cleancache_sysfs.c
 create mode 100644 mm/cleancache_sysfs.h
 create mode 100644 mm/gcma.c
 create mode 100644 mm/tests/Makefile
 create mode 100644 mm/tests/cleancache_kunit.c


base-commit: 752c460b5865d87117095c915addcce7a68296f2
-- 
2.51.1.851.g4ebd6896fd-goog


