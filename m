Return-Path: <linux-fsdevel+bounces-56401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB37B1712E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8237ADCC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E82BE7D9;
	Thu, 31 Jul 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjGpzabt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DE238D53;
	Thu, 31 Jul 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964913; cv=none; b=O7/7RCg+q33XkiknlROr5XE9CiLcZT9Rd2XiEGfFHCHgFWCTj/2+RFxYsTy7poot6JtYQ7vNtcgoRPT1LWFPMM8gJXklPQghESQ4o0k0VmWEC5aIZYg055EaVRpQrzDgI43zs645m04NNcPoF+39xaxK+oTm92htrwVWNdknrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964913; c=relaxed/simple;
	bh=M9bkk3C8kblgyRJ9V4XIBKeApgbeyDAmZl8OQzc4kJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDOR27mHrjhb8JeupBsuye/IADDWmMmlAafRx7Jo2+pFiGDCYrkXqtiy8lrp/LWoc7aZxHHdyz9DU+KHJcVnsRxYzulW/JvvWUzeIKvxwvdn3Ua6FdwDLZM/hSeBAYRZISjWQyJXZo/EeIVt3cP/HevUb1jgjJA4z6fMVpeBuUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjGpzabt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dd8773f9d9so70241985a.2;
        Thu, 31 Jul 2025 05:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753964910; x=1754569710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RS4JTAP3a6V5rVYkQiGLkIDwjMzYKjOUoW6XDyAbEAY=;
        b=VjGpzabt3XKPwm98jV/jSDplV8dV51BAQX4B51HLAtzoGx7y6yFlF6RUtpaRColC4P
         vI0tU8nIwcVyn3u/we8d4S7xI5hNBFzB4Q7I7+4cMCz/FPSzDShJxRAaRoiqPftr3avR
         XAyWgx1ZTXuwRumj87l3C4aRNNZUCRuodz6ct+ZPbR+3mvfZD3pwH9+MvLpiEici51PE
         2/GtNv63nQ3rRWcmARp1AO+RzNul8ocqtIb9gwm+58OS28ZXMSgMv28J7Tjngmt9uVTa
         spzaBN5xO66q9uF4bNMXwBAg7CF+VeiQD3QGFEQ8I88xQZ36WDiS2kczahfQu1cRpF2I
         d2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964910; x=1754569710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RS4JTAP3a6V5rVYkQiGLkIDwjMzYKjOUoW6XDyAbEAY=;
        b=CpSSKpFJ7+5++ksXnM3u6qr+3EiYeoEUbFCNy+FKNYe+rho9fGLsXegWjhIY7+vyxM
         /7BsNGnf6C97D345ly5zKTVIFTBkD1TW6BKEDQd4tw6vlbEQJEbfAEmbvo5CyDLtQfvc
         Ycdqz1sxnDpVvqwompPeZNi9l7JIowVNhW1IuEC4ahuqggFub9/GeJ3oUqes1UOG7s34
         NsZEclNtCC1kjKSS15lpqmOZ1QFugARKQXLuqhVCPnr7OowPzgmzZcAzGS1OvpEXu6Ig
         FRLrg5y1yemgVcYWAA1IkgQiqmyckoAAw09vxJHMncW4nnLBeaZ5lLiNaAV+C1uKXosS
         TQJw==
X-Forwarded-Encrypted: i=1; AJvYcCWRbvoNWqOuX5Qb1CdpPooofNajOeVTKwREIuWDJ446p0BJNEzeLzC5oatmGFh/axeHv+gUamSs6XS0kE5/@vger.kernel.org, AJvYcCXqiBtiGRtyVS2FAilK12wMXOnIjh4FVOa8za0cK4XHNIhHDt3hegoiUgABuewZNMlAIoEzpQBejBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPBit4yWMToWGMHiXDkk0kNfX82Q8/ZHWpEE1GpqSqXgGo/wF
	6ZYYRoF2Tef3ayOmuKVkNKGME/Ryjiuc0Gh8G7TDGeGrZrzAth0CIJt7
X-Gm-Gg: ASbGnctu+iiXvUHkEEkuaNCAgcvxMICiAtm5GW7cOE2zK5U2Bqwm2ky4H+DorNUCQE+
	i9jCgEvMYoUFPI0bWEtXAu/bQEh8382rqtQVXHB/EnknK6BQv8rIciLPo/3ZCLcmlmAFZGEFH/0
	QDf45TdRxT5z8QQ2RV8QgR09tmaM5TWYeZcih5QBtGVgTc2YjVmw9uCx7jLmUVeFGgDwuCvtEem
	75EraQ4/PBL1YCUk0Cfn0BiZlRULkG4IMQP05wIagcPvubxUclmWofxsjQ+zM9azzTOZ7nAhqex
	HThHEVHfJDqQsHTUku0aZM6ccI2C46LJGCUVki77vW8+VK5+rqzCVoT6cDzR+y1b/xmdMw81jPW
	cDnikdUrHPKAhUwh9aac=
X-Google-Smtp-Source: AGHT+IFaYqTU2XCFiHMz7+aNk0BrqZ5MYEroyP1jSw962PvqV1nx/jTcnm4C844IagSTx/ZUMJgXJQ==
X-Received: by 2002:a05:620a:118a:b0:7e6:2738:c2c2 with SMTP id af79cd13be357-7e66efe88b4mr951829985a.16.1753964910188;
        Thu, 31 Jul 2025 05:28:30 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:8::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5bb503sm78456385a.27.2025.07.31.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:28:29 -0700 (PDT)
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
Subject: [PATCH v2 0/5] prctl: extend PR_SET_THP_DISABLE to only provide THPs when advised
Date: Thu, 31 Jul 2025 13:27:17 +0100
Message-ID: <20250731122825.2102184-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending this as forgot to include PATCH v2 in subject prefix in
https://lore.kernel.org/all/20250731122150.2039342-1-usamaarif642@gmail.com/)

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


