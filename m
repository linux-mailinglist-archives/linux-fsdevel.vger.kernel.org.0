Return-Path: <linux-fsdevel+bounces-22608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC7C91A415
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1A1C214E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DDB13F42E;
	Thu, 27 Jun 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2Zel+BV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD913D62E;
	Thu, 27 Jun 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484782; cv=none; b=eAk32hJ8+5ESoHci0xl89WFvQE83tjk6kSPb3/QPIFHuvEd/WX8JZX/Qh6HRonXLDsaTwaTwDe3ejX/2HUsrPhUWYvjtrT7/+a/UGlMFOlP3ZdR06bg14odg4uV39rZoublp8LGaFoj5Db70pFsY67vXLhr6lj6QYEDnH32Qnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484782; c=relaxed/simple;
	bh=Rm3oHolbsf2Le2SoW8rnQD+D5XsHfm7yKNt9a6jOm8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bABJ4tJMwv8XSz2tKbwjjWEAgK5OxzHOnDlwgM7MsJmu56nntojrRHU8tcttxy1Pm/gAqIZPCstvoF+NFcY5mu963oHk0IAA2K8/bW1siKd8T9/t8ycrR36dfLMei7OYbhJqEGjkLD9CfAjYA+jjSTbXJd2y3Z+8p3U0rHdYLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2Zel+BV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4256742f67fso1775965e9.3;
        Thu, 27 Jun 2024 03:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484779; x=1720089579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tp8I88N5zTJngyTJGNfyhk0MXYhV5WZ/GtGHnw15UVU=;
        b=m2Zel+BVGixUZgRV+eA/k1hUSAMMbG97Qrom0/XAcrInhDuTAnfHM7niFL6H5mQALO
         XH98eWHhT2XBJiBtY81ePRnRbPmJobTKE8j7Kxa7dQ5dUftKsPzmxDHUkQJrlIQg3x65
         ifAJCVrMyRrj3YMThUjYhSY/JDfbv1cXZVdAT5EJbX+www5qxAkdEFSa5hiIwL4763vv
         V5Qx5S7FBPnuN9wYSTAgZ7Et+cE1i1+XkjpoVbbkicPz7WxYDGAqYjgoTuD/1KwTqiSL
         AaKpO04fQ7Cm7jJAwwAZDkSYgfs+8paTb2HelT+o2lzGz5PVTBpXS7Y6Io8l1SGgShgU
         yH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484779; x=1720089579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tp8I88N5zTJngyTJGNfyhk0MXYhV5WZ/GtGHnw15UVU=;
        b=b8ppbqKtIkjSXU/rhE6TeMDYM2Dq1SxxACO6IdVHSE58h4KRb6HnlBv5ks7j3ELiZT
         EtM/RJa1GGBS7zGG5kgJp+dINTZ3A9VN88l4HBXicAdhKPct42z3mgnCzkSUQmT0wAXH
         aVrwXPE9eH6QCWb4ulILVlBms2GHDuI/rIZf31562VhqFiG7tP5N86uWLZZUg8CofMy5
         hH6jhWafwWyHjsIpNKNr62rtDG1unoYKRRyDVZhgi9IwrS4iPSeFom5CX/XYrmX1fpRe
         lRYbkmtEJ4zE2lcANdU/Wi+QFxnDwUMghDheXarJAxAuO00zbsOxhu+G/4aRgU99LbFB
         EwmA==
X-Forwarded-Encrypted: i=1; AJvYcCUoKb5UaG2N13QWCpLYLf5CHduhxEYdgCXw4QF1EYY72DfJSInB/VSQEEPOxmBFW9OAhlWqnZv1M0ZfKIsnm92XQpo8tmEgValAeEyW
X-Gm-Message-State: AOJu0Yw1qMr2eQoIp/C5rvtWZ4xd8xUC/w/NwIE4b2stgeVOS7PAPcG/
	DfCpPTJjLnyJHHAovtJlk625tBBvbzNG3bHZ1UDeb36b0+OSYSej
X-Google-Smtp-Source: AGHT+IGvtRZlO7kSgJ/OAiER8k6Ry3nLBU8hTMdGH2uQfnW89yXrq3HjEUQxC9bY1xw4mdxf9w9RYw==
X-Received: by 2002:a05:600c:68cc:b0:425:5eec:d261 with SMTP id 5b1f17b1804b1-4255eecd2bcmr25764165e9.34.1719484778559;
        Thu, 27 Jun 2024 03:39:38 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42564bb6caasm19957195e9.33.2024.06.27.03.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:39:37 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 0/7] Make core VMA operations internal and testable
Date: Thu, 27 Jun 2024 11:39:25 +0100
Message-ID: <cover.1719481836.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of "core" VMA manipulation functions implemented in
mm/mmap.c, notably those concerning VMA merging, splitting, modifying,
expanding and shrinking, which logically don't belong there.

More importantly this functionality represents an internal implementation
detail of memory management and should not be exposed outside of mm/
itself.

This patch series isolates core VMA manipulation functionality into its own
file, mm/vma.c, and provides an API to the rest of the mm code in mm/vma.h.

Importantly, it also carefully implements mm/vma_internal.h, which
specifies which headers need to be imported by vma.c, leading to the very
useful property that vma.c depends only on mm/vma.h and mm/vma_internal.h.

This is useful, because we can then re-implement vma_internal.h in
userland, stubbing out and adding shims for kernel mechanisms as required,
and then can directly and very easily unit test internal VMA functionality.

This patch series takes advantage of existing shim logic and full userland
maple tree support contained in tools/testing/radix-tree/ and
tools/include/linux/, separating out shared components of the radix tree
implementation to provide this testing.

Kernel functionality is stubbed and shimmed as needed in tools/testing/vma/
which contains a fully functional userland vma_internal.h file and which
imports mm/vma.c and mm/vma.h to be directly tested from userland.

A simple, skeleton testing implementation is provided in
tools/testing/vma/main.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality works
correctly.

Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: unexport vma_expand() / vma_shrink()
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   26 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/mm.h                            |  104 +-
 include/linux/userfaultfd_k.h                 |   19 +
 mm/Makefile                                   |    2 +-
 mm/gup.c                                      |    1 +
 mm/huge_memory.c                              |    1 +
 mm/internal.h                                 |  160 +-
 mm/madvise.c                                  |    1 +
 mm/memory.c                                   |    1 +
 mm/mempolicy.c                                |    1 +
 mm/mlock.c                                    |    1 +
 mm/mmap.c                                     | 1808 +----------------
 mm/mmu_notifier.c                             |    2 +
 mm/mprotect.c                                 |    1 +
 mm/mremap.c                                   |    1 +
 mm/mseal.c                                    |    2 +
 mm/rmap.c                                     |    1 +
 mm/userfaultfd.c                              |  170 ++
 mm/vma.c                                      | 1766 ++++++++++++++++
 mm/vma.h                                      |  356 ++++
 mm/vma_internal.h                             |  143 ++
 tools/testing/radix-tree/Makefile             |   68 +-
 tools/testing/radix-tree/maple.c              |   14 +-
 tools/testing/radix-tree/xarray.c             |    9 +-
 tools/testing/shared/autoconf.h               |    2 +
 tools/testing/{radix-tree => shared}/bitmap.c |    0
 tools/testing/{radix-tree => shared}/linux.c  |    0
 .../{radix-tree => shared}/linux/bug.h        |    0
 .../{radix-tree => shared}/linux/cpu.h        |    0
 .../{radix-tree => shared}/linux/idr.h        |    0
 .../{radix-tree => shared}/linux/init.h       |    0
 .../{radix-tree => shared}/linux/kconfig.h    |    0
 .../{radix-tree => shared}/linux/kernel.h     |    0
 .../{radix-tree => shared}/linux/kmemleak.h   |    0
 .../{radix-tree => shared}/linux/local_lock.h |    0
 .../{radix-tree => shared}/linux/lockdep.h    |    0
 .../{radix-tree => shared}/linux/maple_tree.h |    0
 .../{radix-tree => shared}/linux/percpu.h     |    0
 .../{radix-tree => shared}/linux/preempt.h    |    0
 .../{radix-tree => shared}/linux/radix-tree.h |    0
 .../{radix-tree => shared}/linux/rcupdate.h   |    0
 .../{radix-tree => shared}/linux/xarray.h     |    0
 tools/testing/shared/maple-shared.h           |    9 +
 tools/testing/shared/maple-shim.c             |    7 +
 tools/testing/shared/shared.h                 |   34 +
 tools/testing/shared/shared.mk                |   68 +
 .../testing/shared/trace/events/maple_tree.h  |    5 +
 tools/testing/shared/xarray-shared.c          |    5 +
 tools/testing/shared/xarray-shared.h          |    4 +
 tools/testing/vma/.gitignore                  |    7 +
 tools/testing/vma/Makefile                    |   18 +
 tools/testing/vma/errors.txt                  |    0
 tools/testing/vma/generated/autoconf.h        |    2 +
 tools/testing/vma/linux/atomic.h              |   19 +
 tools/testing/vma/linux/mmzone.h              |   37 +
 tools/testing/vma/main.c                      |  161 ++
 tools/testing/vma/vma.h                       |    3 +
 tools/testing/vma/vma_internal.h              |  843 ++++++++
 tools/testing/vma/vma_stub.c                  |    6 +
 61 files changed, 3800 insertions(+), 2262 deletions(-)
 create mode 100644 mm/vma.c
 create mode 100644 mm/vma.h
 create mode 100644 mm/vma_internal.h
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h
 create mode 100644 tools/testing/vma/.gitignore
 create mode 100644 tools/testing/vma/Makefile
 create mode 100644 tools/testing/vma/errors.txt
 create mode 100644 tools/testing/vma/generated/autoconf.h
 create mode 100644 tools/testing/vma/linux/atomic.h
 create mode 100644 tools/testing/vma/linux/mmzone.h
 create mode 100644 tools/testing/vma/main.c
 create mode 100644 tools/testing/vma/vma.h
 create mode 100644 tools/testing/vma/vma_internal.h
 create mode 100644 tools/testing/vma/vma_stub.c

--
2.45.1

