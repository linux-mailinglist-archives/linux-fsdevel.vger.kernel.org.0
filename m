Return-Path: <linux-fsdevel+bounces-22772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456591C111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4459B2349A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C31C005F;
	Fri, 28 Jun 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMi6VGBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D41E522;
	Fri, 28 Jun 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585339; cv=none; b=Jrn7Y0Z37HiJJVvvHrY1Agei5fbx57QeiZn9PFXv6QcXbLTMgqFVGlkPFDDbzrQSRi1MljyHm65cnBfesqs+oY7awEjrbspKhvI6+ltPy2XfOySW8IB+RnsAirekdGk+bbqTUFjnXLN2vDPX0CqJKAEfNymlZNVhAAKOp1T5ONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585339; c=relaxed/simple;
	bh=M+mmVeOL6m8FmyDokJNplwZhot9fKY++AbP2+IWbHMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dios3HIzqA97wmYm/45LpMgC5YISg/qtpHah/kFhqvK16KAZGEehsyUB+lZn2Ufo5F6FbvW8OhCHq6EM1OSPqLKXs0ZjfSxo4sW7dkTM+JkAfAPaJUf0FXOssccupySZCN4o3R7mVYhIvlk3ctlYtZfDj2kYyXzfbrSmlOI6bBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMi6VGBQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so5799865e9.2;
        Fri, 28 Jun 2024 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585335; x=1720190135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0NwxkLlbP9jgFl/TCIElmahbD3Db/e8/WdXfIoQlZs=;
        b=UMi6VGBQcI/UNQIdjh2NLS+O1ZmcOvGX/dWVKWtO/GY5t60y6nTaVS1zi16RGW+scF
         UPAS7TtziZvusUj7xIIUtzFUy4gKARfbkVm5U9J2UP4jIn0GEPgt/QYZTLiPKO4ohQLr
         wPXlGcB4Qud6o+DDdndr0bb3tv3AzF7iwbvyJq5x5VMCM05DReufFsnzappf9C3Q5teL
         LrTvOK5cyQSGAErvX3hWHmYpClGhPh9lD/yrVyIbYp72KiwwEV5rvnuOQ7zYpbjjLUpV
         5hiLEMtLqpt94mXqkiFoiPZs/ARq3fP2+5giPb7QM3IZ+mRNVL9eh2L6m0TRxzPcu6RW
         CqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585335; x=1720190135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/0NwxkLlbP9jgFl/TCIElmahbD3Db/e8/WdXfIoQlZs=;
        b=gIozTOJl20ijst3Zd0bPb5t1OxzTSU3whRFvQTjkwRZewFAmW2+x8NVr96f5dxtuHQ
         m9rk4E8DDyxxllfVLkCV23pSinVP3b4+lLWSuSpe1IOCjcmIiFGJ44IWzI4YYt7AS1pO
         HWms7wzIMhMWT74IVj1pRVk/aELhqKpM6Ggg+JOaLU2XqeHt5qRjOZ8MSWwy2O7onJvn
         B8bq/OaqyWBHZFgyeD4q+9oH5kuBAq13IDHsfHw5TmyX+AD5UFmZoXYskSKJIKXzC38x
         JUfJRMU1v74PwnpoSrfxKmqtHyUjQFxybPpRlkSBnJybhr6oWkQxfQf8oqXz7/DfygtL
         Nm3g==
X-Forwarded-Encrypted: i=1; AJvYcCUJog5bypIxDRiAtsfHYu6OubCa2iJGSZYQIeOCl4OsZxnjMmfkBGOrxevgkhmGpPUY5MKm4Hueyg3eCvtIEBbiEYqs94ndTwFf2e4E
X-Gm-Message-State: AOJu0Ywldg4b1eq7IhINIAnredP4iqbvwcTZk2gBwjIMiY9TCj8SnpT5
	9ms1NX12g9C+M8gk4cXE4Srjq08gOPkz/c1Js5q0msG8Cf8kchQG
X-Google-Smtp-Source: AGHT+IFnUVHgnwtaOakrbDqmh5eSI+bbvM1Nnux4SzQbNuyj7GLBzZnPk6NITvp02lKAV3Zib0BtvA==
X-Received: by 2002:a05:600c:2212:b0:424:a2d9:67c5 with SMTP id 5b1f17b1804b1-424a2d96a8emr74770535e9.16.1719585335320;
        Fri, 28 Jun 2024 07:35:35 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm38985485e9.9.2024.06.28.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:35:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 0/7] Make core VMA operations internal and testable
Date: Fri, 28 Jun 2024 15:35:21 +0100
Message-ID: <cover.1719584707.git.lstoakes@gmail.com>
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
tools/testing/vma/vma.c as a proof-of-concept, asserting that simple VMA
merge, modify (testing split), expand and shrink functionality work
correctly.

v2:
* Reword commit messages.
* Replace vma_expand() / vma_shrink() wrappers with relocate_vma().
* Make move_page_tables() internal too.
* Have internal.h import vma.h.
* Use header guards to more cleanly implement userland testing code.
* Rename main.c to vma.c.
* Update mm/vma_internal.h to have fewer superfluous comments.
* Rework testing logic so we count test failures, and output test results.
* Correct some SPDX license prefixes.
* Make VM_xxx_ON() debug asserts forward to xxx_ON() macros.
* Update VMA tests to correctly free memory, and re-enable ASAN leak
  detection.

v1:
https://lore.kernel.org/all/cover.1719481836.git.lstoakes@gmail.com/

Lorenzo Stoakes (7):
  userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
  mm: move vma_modify() and helpers to internal header
  mm: move vma_shrink(), vma_expand() to internal header
  mm: move internal core VMA manipulation functions to own file
  MAINTAINERS: Add entry for new VMA files
  tools: separate out shared radix-tree components
  tools: add skeleton code for userland testing of VMA logic

 MAINTAINERS                                   |   14 +
 fs/exec.c                                     |   68 +-
 fs/userfaultfd.c                              |  160 +-
 include/linux/atomic.h                        |    2 +-
 include/linux/mm.h                            |  112 +-
 include/linux/mmzone.h                        |    3 +-
 include/linux/userfaultfd_k.h                 |   19 +
 mm/Makefile                                   |    2 +-
 mm/internal.h                                 |  167 +-
 mm/mmap.c                                     | 2070 ++---------------
 mm/mmu_notifier.c                             |    2 +
 mm/userfaultfd.c                              |  168 ++
 mm/vma.c                                      | 1766 ++++++++++++++
 mm/vma.h                                      |  362 +++
 mm/vma_internal.h                             |   52 +
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
 tools/testing/vma/.gitignore                  |    6 +
 tools/testing/vma/Makefile                    |   15 +
 tools/testing/vma/errors.txt                  |    0
 tools/testing/vma/generated/autoconf.h        |    2 +
 tools/testing/vma/linux/atomic.h              |   12 +
 tools/testing/vma/linux/mmzone.h              |   38 +
 tools/testing/vma/vma.c                       |  207 ++
 tools/testing/vma/vma_internal.h              |  882 +++++++
 51 files changed, 3910 insertions(+), 2444 deletions(-)
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
 create mode 100644 tools/testing/vma/vma.c
 create mode 100644 tools/testing/vma/vma_internal.h

--
2.45.1

