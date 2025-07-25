Return-Path: <linux-fsdevel+bounces-56041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 415ACB121E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9131CE28D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC1E2EF9A1;
	Fri, 25 Jul 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az7aai42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7C2EF2BE;
	Fri, 25 Jul 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460583; cv=none; b=iU/hBagwLm82eo9moRTEjukz3iMLvFLa17d2VSRfR+BFzalNFQRhd+dm4Vs3QoZZdDwJKpVygOwWEWf53YiQ835IHGrZ7VRgKqjpBDYb+loWkEA9oEXEgIO6A6tdet5l+BBU0OPEG1Gy/95kuBJvoRbywKvYnfDYAOSBggnKjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460583; c=relaxed/simple;
	bh=Oj2GNtunj58iszMUxlwwrdfsm7gS8ttBuq0WG8VMIoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mE9dqDGC3JfIgvuW4qOMpwXpIJBwAbKhmz47hNuLzLkc03ccT8CjH5fJuSP88/fR5qbmsIdk6+4NN1LgXWEx/fKByh2yHhe/CHDhG8lp7WJHHEbcdQjTqPfwiCjPAYiiINiyJuk/X/ll9YIP83lBtpkPnc0S6yBSMzAj5DauZ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az7aai42; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e169ac6009so237418885a.0;
        Fri, 25 Jul 2025 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753460580; x=1754065380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tsRvKxISNRBPG2Kb51ym8LU6IwShBIRfDNgq3e6HRCc=;
        b=az7aai425TVMtfOQhRJVMha+nzVDeivWE6T+fSXq2yDQP5+4zC4iIuri7HOoJyRdMw
         rPI+WFcRBArrt8tLVCr4CZEoLCuQlEe73Y/b0DZXxBI8O9o5PEmjCpeyXio+ihcH5lsO
         KkeK5GddL0ICFX3o2KdcE9ArG/8I7zJzcckkVcW0WzKwnZ7G45xjMRYb47TExYnbz7Fl
         6//M5Xnq5IGvI+2a0mGX3FxDa2ghqncXTKZ2d/K44z2MCucjBAR7I3sYMfAdDlby3Vfy
         H/bR9jgsTxzhFhXHkucyQ/UQbE8exncizEyCwNtl8GCjr1CYS1Slx7+6CJjYQ4OsTyYh
         L1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460580; x=1754065380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsRvKxISNRBPG2Kb51ym8LU6IwShBIRfDNgq3e6HRCc=;
        b=WJhnI3gbrU+gaZg649kk/aXXhA6z2sIDsAGD5nPoehH4aI54g6hEOGJ6d9NVrWdBe1
         +a1DKiXqFVJ/cm9g0WILko26+5nNC0MhAF8Aft/9XWWa/Sz7sz6Ht4ilvp9r0gDMm8go
         PikaeBarzMiUuZqEaXJ/ppCtH+/funM4ZiPwFTwKMhLNVy4M7EBkmrhVpliOqBRLJfa0
         wizvD9E85g8/7Tv4C8lDdDpCn1qNZCB2h4l0s1DpE/lRDY3z7ZWaSCpcecF6t6xfhVLf
         m9/gtFxbEUShOAaKifxYwtBzRu8lnPA27qG2NZbk7efpcd7gF8QI2S1L9xuHVy7PDf68
         e3oA==
X-Forwarded-Encrypted: i=1; AJvYcCX4r6opuiAphIf2E5bBriPUxz57I6gJXSXkTtDWea9sF+xhi9xXVeoh+wqG+vfumjeIkoCygfXhEzk=@vger.kernel.org, AJvYcCX6JefpLBFkcortoJ1k4ceJ+3cL3MrUy0KwFJvpg4ZdEzNzli27hzhD4MlVqB178D6k0dCvQo2lIKhJmXzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2SHWSASEEt26IAovdYneLlf4vGsyoPDkcZBruwZMGGaBeCfH
	UiI7h64zQs/N5xVVwBm7OKSKyxBeP2JacKXOkEgtn0B9fdmtHyeBdjEN
X-Gm-Gg: ASbGncvk72RZoXKC7/SXrwz6UPtiTDeepA9mxZw/MzVLNSZFRzivQNZKV+y1oRgsfJO
	XpQNVwUQKUCw4A2G3GQhiaygIVevd3te7/KFkShz4mDtecpew0KB7uouyadyORRwQyODkUwot3w
	rmsQKkQLhsm088Bkgzu9yAoFAs4hvUeTolwHWNwlhaxEba/vlFRY4PasumimV7Ke24bG8MwCf+l
	cV4fGfklGxs+uSRHwuJ5dDqAAiv8ZLSJN5yp4bkJ72w8rWkePTjT3BWCU/HTEdFwKxK683wt1qE
	bbbde+gt8ykotWv+mDObnM5TyrxthkVIAkcTDq6D2aTC98Xj0k3Y5OE0hAm7QoAl4E0XMjXM9KO
	6fIUcFS2qwT2IGLcqkWUkIDdJ9JXWuAA=
X-Google-Smtp-Source: AGHT+IFUPOXO+Rx3b3L9FWMojxy4UgYsuqor8FhdRVAZKo4WeQbM3LrIA/dgX9xaRGdAcSqcaoHl+g==
X-Received: by 2002:a05:620a:2892:b0:7e6:21cb:c331 with SMTP id af79cd13be357-7e63be53012mr329207485a.5.1753460580101;
        Fri, 25 Jul 2025 09:23:00 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:74::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e643878eb7sm13556985a.46.2025.07.25.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:22:59 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	corbet@lwn.net,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	baohua@kernel.org,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	ziy@nvidia.com,
	laoar.shao@gmail.com,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	vbabka@suse.cz,
	jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 0/5] prctl: extend PR_SET_THP_DISABLE to only provide THPs when advised
Date: Fri, 25 Jul 2025 17:22:39 +0100
Message-ID: <20250725162258.1043176-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow individual processes to opt-out of THP = "always"
into THP = "madvise", without affecting other workloads on the system.
This has been extensively discussed on the mailing list and has been
summarized very well by David in the first patch which also includes
the links to alternatives, please refer to the first patch commit message
for the motivation for this series.

Patch 1 adds the PR_THP_DISABLE_EXCEPT_ADVISED flag to implement this, along
with the MMF changes.
Patch 2 is a cleanup patch for tva_flags that will allow the forced collapse
case to be transmitted to vma_thp_disabled (which is done in patch 3).
Patches 4-5 implement the selftests for PR_SET_THP_DISABLE for completely
disabling THPs (old behaviour) and only enabling it at advise
(PR_THP_DISABLE_EXCEPT_ADVISED).

The patches are tested on top of 4ad831303eca6ae518c3b3d86838a2a04b90ec41
from mm-new.
 
David Hildenbrand (3):
  prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
  mm/huge_memory: convert "tva_flags" to "enum tva_type" for
    thp_vma_allowable_order*()
  mm/huge_memory: treat MADV_COLLAPSE as an advise with
    PR_THP_DISABLE_EXCEPT_ADVISED

Usama Arif (2):
  selftests: prctl: introduce tests for disabling THPs completely
  selftests: prctl: introduce tests for disabling THPs except for
    madvise

 Documentation/filesystems/proc.rst            |   5 +-
 fs/proc/array.c                               |   2 +-
 fs/proc/task_mmu.c                            |   4 +-
 include/linux/huge_mm.h                       |  60 ++--
 include/linux/mm_types.h                      |  13 +-
 include/uapi/linux/prctl.h                    |  10 +
 kernel/sys.c                                  |  58 +++-
 mm/huge_memory.c                              |  11 +-
 mm/khugepaged.c                               |  20 +-
 mm/memory.c                                   |  20 +-
 mm/shmem.c                                    |   2 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 257 ++++++++++++++++++
 14 files changed, 394 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

-- 
2.47.3


