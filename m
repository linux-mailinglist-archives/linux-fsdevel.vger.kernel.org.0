Return-Path: <linux-fsdevel+bounces-35603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FBA9D64ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 21:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72813B220E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2761187FEC;
	Fri, 22 Nov 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzFIXDqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8FE17B428
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307918; cv=none; b=bMv5uyt1GSJIldACXvR/proSgTO+6Htjv0H+p0DwHwH1+wGk9rfsQuuXuhNQYfzHbcS7VOUrrLj2TA2/6HUKq17f25W/h1uENm8rY+kX3aHvA5M5NlQCXQEJ7SmjDPdr9ddECjru7U/rKfxyeCQHjRc5XUHa+mbLvoU4GAcMIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307918; c=relaxed/simple;
	bh=/ZNs3ddG5afj5+MzDtFad3PkBcijAgsdKC6GRGhXtd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0IoD4EzIis/JAE1PgvyDy83FEAvMWad+6GoKqURl5nVXODEZ/QXfNd8kpikgL7Gzcs38DJiqQqUGdUue3TM+MD9tDRo+kZqt9L5d8JAJYAvczg1t/ndY0QMxUPNHQsd1WgHtpkaqvw/JGqtaIEDbiCIQAJX/LpdOax/sptZY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzFIXDqd; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83b430a4cfdso92749739f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732307916; x=1732912716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eu14sCRVzejODJC6qzjxU3K6dPA4Gz/RH8oyvGexODM=;
        b=BzFIXDqdFNFCctS16yNE+tal4hDQrPbYXjqIGwZwCLBW34waGIUWiu3YPPgBmWSjSA
         NcA81kmnLU8J0pUxEF5k62M3oWyQdkI24Br9ylnDuss2R5/qVodM3LO533EIqtkElfNo
         uq6Jrosv85cWW9nTIyrDFjIMK9oFMNTZphgjVrU/AMgQy/aXLLhkNM/X0XTVf8FzvFiu
         RD0jwocemDun0wVQLvmngVfF7aggdsEmq5WJjb7D0LZnh/WbkhOPVj0xNZCHjtW2xDl3
         Q33cNXSVD8xN+n0bSY/EdffsTpPcdoxOdGxFHBfe9jD4wWBZL/KQG++pSjj3rYxHECbV
         GlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307916; x=1732912716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eu14sCRVzejODJC6qzjxU3K6dPA4Gz/RH8oyvGexODM=;
        b=FMU4F4yc3AB2d8dCbPrVAUaJdQX1QzFrx7CdMTHM/Qfba8myD0pYb8aTo2+lVKzD8w
         p+sEOR6Aa0qhqE4O043S2bjpQJ9hPVRsKIJ9jcGv6vnPvvCta7Aev8T24HbSrF3SPDqW
         uJ9iF1IGZuHoSVyOnJ4DKy4T67QS1swGbak5dsg26Ywp4q5NHWxufS+O2S2N4P173pTq
         bdeCCoTCdfNe7GZxfh1Y8xBuZQj4SWoZXhUA1snvbgExn13knXM+Zgp2SBmVipO1T1nx
         jqyAoBeZ7yrtsewJd2LQI1V2Z2vwmA6E+jvg6Oo5Dt/OZhlW0AHkDd8yA9Zg61n7sjv8
         YNXA==
X-Gm-Message-State: AOJu0Yx0tXzDAFnCt8RGW2zPQr/UMLF/DkiAMZ/TTIO+CZnMFgZ8Dg7P
	//ijipj/3BlyRWpwMB5bhVyHgYcxSCWKnxMDKp5/103b7Haa66HyxnouUogL
X-Gm-Gg: ASbGncv966aSisKRl4pxMHnpFGsICUFpiDHllYgmE9rCENmdeouYgpLHd9lN/X7qdnF
	L0qmGVci70G7kYSsJmEteQOXctxvDFc0nFr7134O+0x3R9sB3qZRQ3Sd6wWYzNb/grLx+r+vJ0l
	VlXSa193djDO+/mheB+pHCcgYe239SODkjkX9YCzwhexz789iIYWrBkJdFTqz1qIHXIHBU6BNgx
	tJYk3kbg30CWaSWYIfQeZ63rZizXy8HzBhrxvwvmKl13d5DRy+8IKuZoMAKGIOlY1qRa2SXxIc=
X-Google-Smtp-Source: AGHT+IH6rJWbNfVr7vcbyDX4s5qAkX+9U6Billtz99yD39jNe4BipPNDJvFp6knxEVG7rcfvJfNSqA==
X-Received: by 2002:a05:6602:1693:b0:83a:acba:887b with SMTP id ca18e2360f4ac-83ecdd22d41mr493393739f.10.1732307915566;
        Fri, 22 Nov 2024 12:38:35 -0800 (PST)
Received: from manaslu.cs.wisc.edu (manaslu.cs.wisc.edu. [128.105.15.4])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe52506sm794682173.77.2024.11.22.12.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 12:38:35 -0800 (PST)
From: Bijan Tabatabai <bijan311@gmail.com>
X-Google-Original-From: Bijan Tabatabai <btabatabai@wisc.edu>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	btabatabai@wisc.edu
Cc: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	mingo@redhat.com
Subject: [RFC PATCH 0/4] Add support for File Based Memory Management
Date: Fri, 22 Nov 2024 14:38:26 -0600
Message-Id: <20241122203830.2381905-1-btabatabai@wisc.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set implements file based memory management (FBMM) [1], a
research project from the University of Wisconsin-Madison where a process's
memory can be transparently managed by memory managers which are written as
filesystems. When using FBMM, instead of using the traditional anonymous
memory path, a process's memory is managed by mapping files from a memory
management filesystem (MFS) into its address space. The MFS implements the
memory management related callback functions provided by the VFS to
implement the desired memory management functionality. After presenting
this work at a conference, a handful of people asked if we were going to
upstream the work, so we decided to see if the Linux community would be
interested in this functionality as well.

This work is inspired by the increase in heterogeneity in memory hardware,
such as from Optane and CXL. This heterogeneity is leading to a lot of
research involving extending Linux's memory management subsystem. However,
the monolithic design of the memory management subsystem makes it difficult
to extend, and this difficulty grows as the complexity of the subsystem
increases. Others in the research community have identified this problem as
well [2,3]. We believe the kernel would benefit from some sort of extension
interface to more easily prototype and implement memory management
behaviors for a world with more diverse memory hierarchies.

Filesystems are a natural extension mechanism for memory management because
it already exists and memory mapping files into processes works. Also,
precedent exists for writing memory managers as filesystems in the kernel
with HugeTLBFS.

While FBMM is easiest used for research and prototyping, I have also
received feedback from people who work in industry that it would be useful
for them as well. One person I talked to mentioned that they have made
several changes to the memory management system in their branch that are
not upstreamed, and it would be convinient to modularize those changes to
avoid the headaches of rebasing when upgrading the kernel version.

To use FBMM, one would perform the following steps:
1) Mount the MFS(s) they want to use
2) Enable FBMM by writting 1 to /sys/kernel/mm/fbmm/state
3) Set the MFS an application should allocate its memory from by writting
the desired MFS's mount directory to /proc/<pid>/fbmm_mnt_dir, where <pid>
is the PID of the target process.

To have a process use an MFS for the entirety of the execution, one could
use a wrapper program that writes /proc/self/fbmm_mount_dir then calls exec
for the target process. We have created such a wrapper, which can be found
at [4]. ld could also be extended to do this, using an environment variable
similar to LD_PRELOAD.

The first patch in this series adds the core of FBMM, allowing a user to
set the MFS an application should allocate its anonymous memory from,
transparently to the application.

The second patch adds helper functions for common MM functionality that may
be useful to MFS implementors for supporting swapping and handling
fork/copy on write. Because fork is complicated, this patch adds a callback
function to the super_operations struct to allow an MFS to decide its fork
behavior, e.g. allow it to decide to do a deep copy of memory on fork
instead of copy on write, and adds logic to the dup_mmap function to handle
FBMM files.

The third patch exports some kernel functions that are needed to implement
an MFS to allow for MFSs to be written as kernel modules.

The fourth and final patch in this series provides a sample implementation
of a simple MFS, and is not actually intended to be upstreamed.

[1] https://www.usenix.org/conference/atc24/presentation/tabatabai
[2] https://www.usenix.org/conference/atc24/presentation/jalalian
[3] https://www.usenix.org/conference/atc24/presentation/cao
[4] https://github.com/multifacet/fbmm-workspace/blob/main/bmks/fbmm_wrapper.c

Bijan Tabatabai (4):
  mm: Add support for File Based Memory Management
  fbmm: Add helper functions for FBMM MM Filesystems
  mm: Export functions for writing MM Filesystems
  Add base implementation of an MFS

 BasicMFS/Kconfig                |   3 +
 BasicMFS/Makefile               |   8 +
 BasicMFS/basic.c                | 717 ++++++++++++++++++++++++++++++++
 BasicMFS/basic.h                |  29 ++
 arch/x86/include/asm/tlbflush.h |   2 -
 arch/x86/mm/tlb.c               |   1 +
 fs/Kconfig                      |   7 +
 fs/Makefile                     |   1 +
 fs/exec.c                       |   2 +
 fs/file_based_mm.c              | 663 +++++++++++++++++++++++++++++
 fs/proc/base.c                  |   4 +
 include/linux/file_based_mm.h   |  99 +++++
 include/linux/fs.h              |   1 +
 include/linux/mm.h              |  10 +
 include/linux/sched.h           |   4 +
 kernel/exit.c                   |   3 +
 kernel/fork.c                   |  57 ++-
 mm/Makefile                     |   1 +
 mm/fbmm_helpers.c               | 372 +++++++++++++++++
 mm/filemap.c                    |   2 +
 mm/gup.c                        |   1 +
 mm/internal.h                   |  13 +
 mm/memory.c                     |   3 +
 mm/mmap.c                       |  44 +-
 mm/pgtable-generic.c            |   1 +
 mm/rmap.c                       |   2 +
 mm/vmscan.c                     |  14 +-
 27 files changed, 2040 insertions(+), 24 deletions(-)
 create mode 100644 BasicMFS/Kconfig
 create mode 100644 BasicMFS/Makefile
 create mode 100644 BasicMFS/basic.c
 create mode 100644 BasicMFS/basic.h
 create mode 100644 fs/file_based_mm.c
 create mode 100644 include/linux/file_based_mm.h
 create mode 100644 mm/fbmm_helpers.c

-- 
2.34.1


