Return-Path: <linux-fsdevel+bounces-56392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0E0B17100
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE7F3AECFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9672BE7D9;
	Thu, 31 Jul 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6PlslPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB321FF4E;
	Thu, 31 Jul 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964516; cv=none; b=MHd7gGLHeh+45VvldFx0/4FQYkM8+qjvggdYRfSpJlV69wltcmcMAC9f9qP5ivoWBqgluj6+KllFxrGejobQNP+egs0UEHJNdu5K5umwqQMp4PIxtwCDA4ou7VsZMIW9/lxZvEQPXN+KuwIxzCPBew35CPkU91r+O1+19NHwIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964516; c=relaxed/simple;
	bh=+Z8iMUTpzYDGgsj3rGeChufp+xrNaWS2OH30xTfmXP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLp2g7371s/tCLSgS9nQ+8gbFADOzwK+SL3ONyyGrT4KZtQPMUyQC/O83M669i8RmxzSA3FUq/GqQCdTceZJLStB6YBGoXoHxFrAQUq6q9zlMMjIwpGmHsp/AU4tsCDr9jqPQQXhz8xHw4J3TVX9muyAoFJaT4iseL8oDi70Ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6PlslPI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e33d36491dso29811985a.3;
        Thu, 31 Jul 2025 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964513; x=1754569313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyB2bd0Y5ziwt0wpZ4L6oPfSKZCsBSGJvL4ApO6LdH0=;
        b=e6PlslPIX8+6HiSbiqyENx94xuss16yIV8odmBlndkUP+Vm1DGG01x00G4EG4cczWv
         Xh9Vp1dN7gEJGBw1xiJMB6k/iDJOwN0CYH0DQk/TkWmUFktLCS9Y4Yiqh5/4az1jH2sR
         83jpEoBGbCZo/iIGvSb4KJEHTO/kh74iox5CIMV5W9ePEY6D6k3bEojSprZRgxG4Nlak
         MrK3NarRaC9C0OUmUGKKbDIIlvAoONgmhmoZ3xe5JkUqKyKltX9NtfN9EM/se9gOJDVM
         zO9qJp+FGvSsnUTUMsGQFqTrRZZNz/Obr25INxKCHXfH97iwlzYAm3py2dmnuzJewHoI
         LRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964513; x=1754569313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyB2bd0Y5ziwt0wpZ4L6oPfSKZCsBSGJvL4ApO6LdH0=;
        b=M1Zm9Dc16ojjU1cNNuotLRgAiAPikUXjyIyy5KXnH46mozYWKSZcsHBNE3/VAk5cdS
         L1+o/ujHIYnewu06IG9lKteGaP7PBjRXWorgtBNEA5gnDt1FrQXHtZTGKIorTY2ZROOq
         Ux55X7pgL5WxU1348eP2Qrke2O69XNRhILasd0ixNyAUuAqEC0z0vpZ8pAL1kI6NxNYL
         STQVhHJWQGlBlmpr/54l/AkTIt5o2qomXvJR7WsaCGJNCIjn7GcTNWfUwbX1QUnv5/uk
         Gc2ydXNpRYV4QQuXgumRTsRXLnJocWUF/XbajOqGNIDoQ4cAS+S0qtDXcrO70q0kzb4b
         gH/w==
X-Forwarded-Encrypted: i=1; AJvYcCU+dL9HzfiVsVKajxoq82mit2Vw7x2cpvU7CVQLw6jYcXuYl1bdwBdkxqz4qW76D5ET4OvyIk1+M09vQS3M@vger.kernel.org, AJvYcCXU8mkKTk4K8/ceLgGk6/dNAgIbaEBieh3m/eKBwPitjE6TYXppvyo1MkC85omyk5/+sH2XjBd3Xew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnC5QFk7z3qxVEFXL4HlBxw1VkNBdVCuq7hoHdYL14UQTDKUKU
	bLpUP5drVnn3Q11Bg94rH9+pt7VlonN0pAYiIVJmK0eEiiDcF68WgGRH
X-Gm-Gg: ASbGncvgVoelqxMjWD1uPZJsMkhmwenugKIE3V2NUqAhmz2klmm7ZYadD1BZLpd0ze9
	Ng6Z4yyj7vz013Gd3R/qLccaoXuPjNfDK32RK3V/Ynpth0wBcimshXcMbXFq3yGFVoqo7ycu4uA
	d/uJuHnP74asmZ0aIVeKkmLAEgighvnig55HmvWUno956nuwtaUVSyGK6JirJJg2BhwTkxwjVmz
	g3jj9fjtkxurtW5FHThrHL1JzTBNVFq79vGbfvVdTVJNPkxxASYapF7987Sf9gb3xeiLIPLyNGz
	nxF1U8wi90YYbbfpUiEAINiBNwdcQQLLOeTBdd/PPmI+X1Pcs8ycNgPaJQgvCYL3m3E1irj4luk
	qBsdC00qKO7igqr3m
X-Google-Smtp-Source: AGHT+IFaNwzD9Uxs/RKFYt5m6qnDGOphlQ2Tpe9T1NHIPTPwwihehfIu5ETWtSsTwS33LypgOJOgGQ==
X-Received: by 2002:a05:620a:d87:b0:7e6:6d78:979 with SMTP id af79cd13be357-7e66ef8a93emr982153985a.15.1753964513428;
        Thu, 31 Jul 2025 05:21:53 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5947e9sm78587585a.1.2025.07.31.05.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:21:52 -0700 (PDT)
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
Date: Thu, 31 Jul 2025 13:18:11 +0100
Message-ID: <20250731122150.2039342-1-usamaarif642@gmail.com>
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

v1 -> v2: https://lore.kernel.org/all/20250725162258.1043176-1-usamaarif642@gmail.com/
- Change thp_push_settings to thp_write_settings (David)
- Add tests for all the system policies for the prctl call (David)
- Small fixes and cleanups
 
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
 include/linux/huge_mm.h                       |  60 ++-
 include/linux/mm_types.h                      |  13 +-
 include/uapi/linux/prctl.h                    |  10 +
 kernel/sys.c                                  |  59 ++-
 mm/huge_memory.c                              |  11 +-
 mm/khugepaged.c                               |  20 +-
 mm/memory.c                                   |  20 +-
 mm/shmem.c                                    |   2 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 358 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 16 files changed, 505 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

-- 
2.47.3


