Return-Path: <linux-fsdevel+bounces-57714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AE1B24B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AAB1C204A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04E2ED160;
	Wed, 13 Aug 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFoL0Yim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D112EACFB;
	Wed, 13 Aug 2025 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093450; cv=none; b=Rp7q973Kje7155Wzv6ZjQtQ6VecEYwu61ZCOr+DsfgMTTT+xlTXLku5Fl0chT53PsXXXMk7s3QTzcZsVNfjCPn7HljUoGRXyhB//SxS92jMg7uFy69daAKtpKdz29YFriMe4MXpF9M3n1hZoWg0wZwhbqjOWJZO8ees43Ej/dpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093450; c=relaxed/simple;
	bh=9dqxB5WnkRlLdf8v+liBnr4iOxIWUO4BTpKEIfF62p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZWNC/r+omOpOWxe6vE76mHLNMgs7Ag70/Ck6YlxKoJUDpv1vcaOj84E0H6IzBxjVbjYPFwxX/xhsTkSY714qX/OheyaBoM1vVy6qZOJAkV6tfxInLN3RRSbnLLxppowlPm7itnAIZ7huoIOdPaeDLQDxOrrBXcSZF1PlCTggW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFoL0Yim; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b070b3b7adso112911751cf.3;
        Wed, 13 Aug 2025 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755093448; x=1755698248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzWUPox51DZi49hcWgUUk30VnYc4Bgc0iKM5O3Jcgw4=;
        b=CFoL0Yim4Y1G1UDmmxRNKSmA7J/ZahQnVYQ/1A9r8wCFZzO5aXiPgxV4AJ2+7rEvun
         VA6RcLwMTj8pH/AzfcOu7LhhKpAhz+rWGSnqN2msSPWCN7YaKQV1441RFpoc6CNnBDHi
         HtsTuq5/pdvc27n8n07a2o2IVPdO9JJTjsjw2z7hE8nabCaHpcrxrMkZnDA+ikIb5NGz
         in2pummd9IWcgiAoX/PDjZP/6xppZz/uQjcGvrOCR7Mujnzsy+ZllQey9MqFXK6N9h7c
         cxlBgDKsPLoK26V584icI5NhKRqtAb3gvna3/T0fUE3nmTI+V5Hp/jhgPy4W6DQyHAWL
         agxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093448; x=1755698248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzWUPox51DZi49hcWgUUk30VnYc4Bgc0iKM5O3Jcgw4=;
        b=YGvRXx+HIpIuvJPjn7tycspIYVM1x7jO71HxexYM5hMWDfcYUdHfVW0OMf9vhaDwVA
         IaM2WnkJxVFi8V7znhMSBhGFTF6TcbIml0mGl0AXj8uszbbIi0Seo8viOKQURgd5lelq
         aVe5hUKVcfUOxpnNp5iijUx3adoVwMrQk0jLfyVAw9+3i+11pkWOcj+nm1UwSk+wNXPw
         6hdwPIsO7jLpazXUn4MjOtHqsvtWPJyk8gHHTOtGhIkPV3TR2N7ICK7oh5JToMmvjdC6
         +Cx2L4MV1/X/wb19hnMhWRcYh3z7PdE4ldN36vOnc/7kt4xCO2G+NYuvaoMY0SM0WY72
         VzCA==
X-Forwarded-Encrypted: i=1; AJvYcCVyqVemgSP/HgS7PD92rwZ09x88wRjlOnjlWkpl6Zb62JbJJnu3NGvdlBT+jfb4q+rYU7FMZevgc8M=@vger.kernel.org, AJvYcCXzq7JtVaHr3HJ2EHcop5oDm7wPn9Iwx8nFrTnpJWIAgwJhlNBVfh/JgMdAKH1XclCYWVjWeexyDww7gEkS@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpbryXwEI4qgTFtgxF1DgHXcEx12VGwbs89vU6HqOV+512ofm
	fbl4+/wT4ITwHzeG86jNMJ7vWobJ1W0UfKVlDlo4oHJpblVFZMlpNyZV
X-Gm-Gg: ASbGncuXyeI3VdgB7RbxFdcfoI0VNB+w9d+yD7UQgUmwN2T7rjit3+lZ55WDE5ihCvV
	MLp0cOAQmkFYf48tnqbm0jxwd1nqDn6bfGhg3qEmlJnAI2s5dIHV1CVnZ4IF0Tk6Y6Hwby+NLIQ
	EgvKW4sWogdOakIb9wvmrmckPMfvvGEnQVXQkWl8JnNFYBB71pnqlqSJMV6US8b7l6nzschODRI
	iek0Ughl076kJcI1Pv9a7XlSROqpMNp3PB0ABNK8nmSe1hOGNgCs04EUaJ7JXi1pJJf0IEWyU2+
	6L44JGH6DSB8tGFVHlgKV84rTXKStleb7a4UqnETYTR8G1RDQqa9aZDy5pW3c+4LkyPrQRtyett
	8jR/+fbORiAQ4HfdsMEiq
X-Google-Smtp-Source: AGHT+IHMpLHS102o5V9MYRk9uIP4OvbzgHHel8QxmDYGPR2Zk/mAM8p6YLuZt9c630uTVwr2P7e9Ag==
X-Received: by 2002:a05:6214:20c3:b0:707:5df5:c719 with SMTP id 6a1803df08f44-709e8815919mr41371566d6.17.1755093447561;
        Wed, 13 Aug 2025 06:57:27 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm195552726d6.84.2025.08.13.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:57:27 -0700 (PDT)
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
Subject: [PATCH v4 0/7] prctl: extend PR_SET_THP_DISABLE to only provide THPs when advised
Date: Wed, 13 Aug 2025 14:55:35 +0100
Message-ID: <20250813135642.1986480-1-usamaarif642@gmail.com>
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

 Documentation/admin-guide/mm/transhuge.rst    |  37 +++
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
 .../testing/selftests/mm/prctl_thp_disable.c  | 275 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 tools/testing/selftests/mm/uffd-wp-mremap.c   |   9 +-
 tools/testing/selftests/mm/vm_util.h          |   5 +
 20 files changed, 470 insertions(+), 86 deletions(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

-- 
2.47.3


