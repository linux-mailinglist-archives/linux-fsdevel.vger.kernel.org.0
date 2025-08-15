Return-Path: <linux-fsdevel+bounces-58012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CEB280FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC07188FB74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E33019C9;
	Fri, 15 Aug 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqqu5RRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1729D05;
	Fri, 15 Aug 2025 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266158; cv=none; b=b0m3y7qpBL27D1Kdciy4HpUo46NZPDwr9uxl+puCKHc5yAuQrxpTI/jaGD+p+vq70Xh/tkOWxwoBxsG/XRygNlNoUPyv5l+O08DffymTsUsL4HOwL2RumzY4ILV5RqMK70hFuD42olLXtXm5rO86NdBGm8D/H2YC201+ogWbxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266158; c=relaxed/simple;
	bh=xfzl1UCjyvSbc2P+UZNvfTN2sJ+6rUyNCF8zLrgjPLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIOpAuZ8I46LMcTVvHN9TBmFGxksGGhaZ9+zVmsR37b8Zf1D1g4NG6H8Qy1lg4KsbghJn0vxDM1fquU8aS2FzN8KgulkGwmm1ZSJ6hD0BHKjaEi8+JYq/2w04GGphlCBCtD8fkvhAZIMvXIrh7lQA+oUp1L0XZT8g7ObnPWyhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sqqu5RRT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e87030df79so198503785a.0;
        Fri, 15 Aug 2025 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755266155; x=1755870955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sGpDHu0WxbXQtKyhY1Cb6ZZbvTz1iWAdpNXzbeXC1I=;
        b=Sqqu5RRTCn65QI/z+X+F5gIdfoQjp27WC7i6LyIpdhBYfZRaZxfJJ7/naeaEWeNu5K
         8H06xU57Q1mEmowkzBWSsI4Y4+O8ALTls/dw39XcZ10nCF66H4Z0TKlMHLUm+bAbmXIw
         a84iBvPpMgevmyKC4UtnkHeiaE5gh7AwPrYLVGbWmnD93yKyoKilh1SF/wUs1FoajbXM
         DjIpILdbsYsoOOFnxBo7eN+zdINfPAf9TsbEM9cta+ssMubFwOS7n787Af8tkj60nIKn
         e5SJ7R4ZEwUIE3jSM69i/EharV2bhlhgp3vu94eKsrsYlOwgktt1QVeMmm+IFnHZz00X
         VrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755266155; x=1755870955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sGpDHu0WxbXQtKyhY1Cb6ZZbvTz1iWAdpNXzbeXC1I=;
        b=gyxBtXISnVLaMWtA8uxlpQwMNM7Q7vtdpW8ONcOsmtzR4RZthYfIU+/Zva7819PQMn
         nrWR1F2uMCJuhyyRCy/tBT9KIXb86ibgYng8bLB3Sevp14VdVc34J2k6KBBn7RcquUTf
         +X554eJILJyjCyesJgdLqNxTr2EWM7Kouti/+6uKfU1tY7QlUci9dGTQ4l4TGme6BV79
         veHJCSbtlRnSvBtapseiS27wLRzpTMNc7PUImd2/IDPqO/6oaOjL7nJRZqa2ItUhAWfj
         9SCW17XWesUeRfGqvvAy6+gHR0YwMem5lIsWmA2SpGqZ46iPhnOgYB0pXJ79/nPkkqOI
         iIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsWxtLL9Pgk5pDVRTvKNM3RBlUIXZxQHrOBGdSB/EAg6jPnj2/IhK+C1sHVR1h7kkjf632pPNCZhI=@vger.kernel.org, AJvYcCWa8pOUqnHu/049YCrrDhfsuHsHwSb22iDMguRrj3TTYXe5AK9gR/z0lY8gdIhhfmpRsG9vH+e5GCVQe1v0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rUgOEY8lxYgcd2Q3+DbPUJ6lrssfUxo497OQ/4xTGaIuLN73
	MeXl3XlV7cLTWS0nik3fBxM1KW1WTo9C4/3BEvtbIOBeyqUINwpcikX7
X-Gm-Gg: ASbGncvOL9DggEnEjKsCJr5/dnuxwlboOWL2F8lFAAWWxlrKrupPI1nlFUVTZbMnOVL
	9qvhNRZsPINnSbkP96pG51wle/TqbF7u7y2qaVYvR4O9dJ+bCwVO6JG7M4fQsT5td/LmP6F2E8Z
	sptByk1uG+NYq2kKuoAWVMQrFWq0tNxZv6GlIWa8zTacd2WFtTZ5/nZ4igQlHfRw/hjgfdguBk8
	H/WHmxvgf0at4gyLnyIWZP3yWAd2Ai/sAEJadJ3qSsXLR1M6tjHDQ/lQBkJJMvr1XvogLShSj5F
	j1mEJgqkn3+ja3eYFTEOZSBGelu/i/YJyx0svOddG0w3c/yIJhVUQ/QDKoRZzTLl9BR5QLIkLeV
	d3P2E+aNRZJO3Zqb8Ztc=
X-Google-Smtp-Source: AGHT+IFfTMhkH5S73SuIsAAN/SpqZF0BEersYKQpUO6Bh5VPy9ZlLUmJ8OiCjyRdj7LYgE3+tceL0Q==
X-Received: by 2002:a05:6214:3016:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-70ba7c71cd3mr21315166d6.38.1755266155517;
        Fri, 15 Aug 2025 06:55:55 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:9::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f827sm8123736d6.10.2025.08.15.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:55:54 -0700 (PDT)
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
Subject: [PATCH v5 0/7] prctl: extend PR_SET_THP_DISABLE to only provide THPs when advised
Date: Fri, 15 Aug 2025 14:54:52 +0100
Message-ID: <20250815135549.130506-1-usamaarif642@gmail.com>
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
Patch 4 adds documentation for PR_SET_THP_DISABLE/PR_GET_THP_DISABLE.
Patches 6-7 implement the selftests for PR_SET_THP_DISABLE for completely
disabling THPs (old behaviour) and only enabling it at advise
(PR_THP_DISABLE_EXCEPT_ADVISED).

The patches are tested on top of 694c8e78f486b09137ee3efadae044d01aba971b
from mm-new.

v4 -> v5: https://lore.kernel.org/all/20250813135642.1986480-1-usamaarif642@gmail.com/
- small comment fix up in patch 4 (Zi Yan)
- Remove mention of VM_HUGEPAGE and other small fixes in transhuge.rst (Zi)
- add testcases for MADV_NOHUGEPAGE (Lorenzo)

v3 -> v4: https://lore.kernel.org/all/20250804154317.1648084-1-usamaarif642@gmail.com/
- rebase to latest mm-new (Aug 13), which includes the mm flag changes from Lonrenzo.
- remove mention of MM flags from admin doc in transhuge.rst and other other
  improvements to it (David and Lorenzo)
- extract size2ord into vm_util.h (David)
- check if the respective prctl can be set in the fixture setup instead of the fixture
  itself (David)

v2 -> v3: https://lore.kernel.org/all/20250731122825.2102184-1-usamaarif642@gmail.com/
- Fix sign off and added ack for patch 1 (Lorenzo and Zi Yan)
- Fix up commit message, comments and variable names in patch 2 and 3 (Lorenzo)
- Added documentation for PR_SET_THP_DISABLE/PR_GET_THP_DISABLE (Lorenzo)
- remove struct test_results and enum thp_policy for prctl tests (David)

v1 -> v2: https://lore.kernel.org/all/20250725162258.1043176-1-usamaarif642@gmail.com/
- Change thp_push_settings to thp_write_settings (David)
- Add tests for all the system policies for the prctl call (David)
- Small fixes and cleanups

David Hildenbrand (3):
  prctl: extend PR_SET_THP_DISABLE to optionally exclude VM_HUGEPAGE
  mm/huge_memory: convert "tva_flags" to "enum tva_type"
  mm/huge_memory: respect MADV_COLLAPSE with
    PR_THP_DISABLE_EXCEPT_ADVISED

Usama Arif (4):
  docs: transhuge: document process level THP controls
  selftest/mm: Extract sz2ord function into vm_util.h
  selftests: prctl: introduce tests for disabling THPs completely
  selftests: prctl: introduce tests for disabling THPs except for
    madvise

 Documentation/admin-guide/mm/transhuge.rst    |  36 +++
 Documentation/filesystems/proc.rst            |   5 +-
 fs/proc/array.c                               |   2 +-
 fs/proc/task_mmu.c                            |   4 +-
 include/linux/huge_mm.h                       |  60 ++--
 include/linux/mm_types.h                      |  14 +-
 include/uapi/linux/prctl.h                    |  10 +
 kernel/sys.c                                  |  59 +++-
 mm/huge_memory.c                              |  11 +-
 mm/khugepaged.c                               |  19 +-
 mm/memory.c                                   |  20 +-
 mm/shmem.c                                    |   2 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/cow.c              |  12 +-
 .../testing/selftests/mm/prctl_thp_disable.c  | 286 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 tools/testing/selftests/mm/uffd-wp-mremap.c   |   9 +-
 tools/testing/selftests/mm/vm_util.h          |   5 +
 20 files changed, 480 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

-- 
2.47.3


