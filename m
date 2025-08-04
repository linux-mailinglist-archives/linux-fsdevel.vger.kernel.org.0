Return-Path: <linux-fsdevel+bounces-56655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A975B1A63C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB7C44E1008
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2183221F11;
	Mon,  4 Aug 2025 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRtx6TI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800F1EE7D5;
	Mon,  4 Aug 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322221; cv=none; b=B8xLSvH0feu6ZdzZncyUD105zdwd4g3Z3V2ETR5vb8Y/sd+wik6Xe6jUqmTNbg+QzDrlnfOSIHsCaOPsweUF2G41Jcj34mfzLcs3dhUtBCrnx9+Sos2DBl4QquD6kIuNPmKUoGflK6kemqTnJ28uvXOS91JEDd2s3bd3NETGLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322221; c=relaxed/simple;
	bh=+aGwtPLB3qrjcUOxcRhOND2khS55JYN+cb7zPXxTjqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebIHShxnVgTpnOGivLo6jO5pj6xET4PXPk+ZRe9HUI2MNOHRBdn7okVjz+eSSdW2rf0lWaBoeWFg17mvkeEwe441etkwXqFchY2zxRgRvjp2AEenqTHPt6Po2yHu7nzwrw6WruEysUre9UGDCa/NXIvXe5XLMbVreCrpqz25z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRtx6TI7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-704c5464aecso37957626d6.0;
        Mon, 04 Aug 2025 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322216; x=1754927016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5e6drRtevaO71NOW/enzFLn3Cq6X1p0jSQ7t0k1aGj4=;
        b=bRtx6TI73kYpekRLfSmuOVpcl0Twy3lGo8m1oz/KnptQvca1lMqa/eM4emc87AYCYF
         Ygils3Y4W/PTBo+ZlNONz1JujoLKm3JkL/eAJ9mjJmw8Q6RW2/Y+ErGsAWrEc5ag0E3x
         0qoPF9p8GfJ6DI+x1xAuv7o1Fy/OCHy4Uj0F3uX6pIXvGOZbhjKZYsLRhoz1PSTPPkrd
         om8zQn/7DT9QsHAI/3WiOP3sCMJWQoqTu1GyMK6+yBvLtHAKuIx13We/ks3YCuwRwXQA
         egC8mxH/swN/yCub7rcFqveQYi08lGU3/F0cTD02ltCfWtFlRKIPekFPDCc3AJZ6xHx1
         0qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322216; x=1754927016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e6drRtevaO71NOW/enzFLn3Cq6X1p0jSQ7t0k1aGj4=;
        b=pufpilIZSsNbpHufqsoirnm3WLu/bXkABGYRnYCHCEvACNnFcrdWcT+zOC/qrd91PJ
         XqnG98XB9f7PqhNep2PBazbAPYRGc0f3hYP8MpLP0JYIq/DAWTBwo0/TTc47lxgjuHNF
         oQALQ2XPaE6HnZen+79536UsHUbvTNDltgwe1oR+tjanftNZyjA5rlo5Q+05SvX4l/0p
         BWohh+IftnQcgwJUwlsvuXs1Db+HZIP1q+Ixms6QvHUbHWOEnIJFYkeHzGi9+UpNZP5s
         yGbL7Hpq1UH+2irb9QwwEgyN7jCwjK1bQONef00G17K6T+5tJkDvD09x82JTLCqW26Oh
         Kkiw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUM+obHGYwAbZEaFO9t/BDHKtDw6wkBS1htrFbRELS+/gAQGLxm+BIXdzhCN3bHULwVKo0ybojRk=@vger.kernel.org, AJvYcCVUjqsDleboSZaHzEJEtYi0ol7cKRbtDMNO2/zNp2tkBpRoJhOtQPHd3uZ7Y5/2WingNNOTvBS2mCGAR2oG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sCsMtYiT+WBR5vLv0srNBn1yaeeVY1EK4EmlG9QEP0Li923U
	B9tczb+m+42Ypm7HGM0mKw/gRVuq3BdCYYF1ngi752CBHvaj5F50dqaM
X-Gm-Gg: ASbGnctywYCIiZr3kfTh+5SYkTMLW1ZIYhWT7YkosWEC1NtWq/LcZIc5MBycP5khlYt
	tWf7WSGdkU7oC5f4UMOMeSX0oZvw+DKkmDNWLqmPck+6r0GIdDWlYx9dfXH2LlcHiJoJtnCN004
	sTi75uMZ1DJYRjcD3fFtpbqAPUxfplisFES0eM3WCkWF8sJIbbnOEGfLRlcPhmr7R3EQ9MKlsJN
	P2+WmSGlh5cZSr6WAeYojqLrywXX+S1ro3DQyvLbKQcESgdrgxfhDuLNJYbTsrOmCEqq7Ij3Qey
	kR0RfK0lnBvzt8KgdB7Al7PrbaHoLlQj/4b/2SbybA+2fsqaBonuNwWVVrbbLSbSxgk7w/Dv2yi
	67XRxPQWwz0cQTaqTiV4=
X-Google-Smtp-Source: AGHT+IG9tVEEClUy7ZbvuxCABzGUJjw0iQygmGFI7l1dILdAP6o6amKv30ChQba0LsLIZgBekdXdpQ==
X-Received: by 2002:a0c:f092:0:10b0:709:5f31:2fa1 with SMTP id 6a1803df08f44-7095f3130f5mr26993256d6.2.1754322216233;
        Mon, 04 Aug 2025 08:43:36 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:9::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c716effsm59372746d6.0.2025.08.04.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:43:35 -0700 (PDT)
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
Subject: [PATCH v3 0/6] prctl: extend PR_SET_THP_DISABLE to only provide THPs when advised
Date: Mon,  4 Aug 2025 16:40:43 +0100
Message-ID: <20250804154317.1648084-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending this as forgot to include PATCH v2 in subject prefix)

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
Patches 5-6 implement the selftests for PR_SET_THP_DISABLE for completely
disabling THPs (old behaviour) and only enabling it at advise
(PR_THP_DISABLE_EXCEPT_ADVISED).

The patches are tested on top of 4ad831303eca6ae518c3b3d86838a2a04b90ec41
from mm-new.

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

Usama Arif (3):
  docs: transhuge: document process level THP controls
  selftests: prctl: introduce tests for disabling THPs completely
  selftests: prctl: introduce tests for disabling THPs except for
    madvise

 Documentation/admin-guide/mm/transhuge.rst    |  38 +++
 Documentation/filesystems/proc.rst            |   5 +-
 fs/proc/array.c                               |   2 +-
 fs/proc/task_mmu.c                            |   4 +-
 include/linux/huge_mm.h                       |  60 ++--
 include/linux/mm_types.h                      |  13 +-
 include/uapi/linux/prctl.h                    |  10 +
 kernel/sys.c                                  |  59 +++-
 mm/huge_memory.c                              |  11 +-
 mm/khugepaged.c                               |  19 +-
 mm/memory.c                                   |  20 +-
 mm/shmem.c                                    |   2 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/prctl_thp_disable.c  | 280 ++++++++++++++++++
 tools/testing/selftests/mm/thp_settings.c     |   9 +-
 tools/testing/selftests/mm/thp_settings.h     |   1 +
 17 files changed, 464 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c

-- 
2.47.3


