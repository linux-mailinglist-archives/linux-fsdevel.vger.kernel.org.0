Return-Path: <linux-fsdevel+bounces-39565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FCA15A99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30BE168A44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4BB666;
	Sat, 18 Jan 2025 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDB8ONge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE152913;
	Sat, 18 Jan 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737161292; cv=none; b=lB+M27YQJvroMDxbOnilkt+BFH5Q3zzAe9130UYTC3pxJLrE8dzb2nWIMHROBSNREotnQs2AeCWwGVnZw13pc9ujQAxb8IuMBWubdsFU4P9GoSHzC96p5io02ZEg3Jy90wKgGWY2qgBb/ANxGQbYUbLlhsbemNKRBOVxgeL79+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737161292; c=relaxed/simple;
	bh=fbktfGWvSa4gEpcEF6whZwsRXScnycT3VcVG/O6fiYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMdeq7arFEZwwFd2tqJMUHiKdmi5ZAVX6D3XYVezE2GmrqfzKU5d3vuNxc/eJ4QVDaM1X8K4GI1TtUVwAb9r3jDOeBeRd+skp+IPTM/lcx0yEvO5BlmCZY48VOWqjLPQ4BH4tRAOK8sTA8VSgglPdX+eHXbOq/C6u2rYU2JS/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDB8ONge; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e455bf1f4d3so3830125276.2;
        Fri, 17 Jan 2025 16:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737161290; x=1737766090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AF3bWaUPaYx/mr1WRWWM4MwXwG2ltNfjWEzCsL6n5xU=;
        b=NDB8ONgeW54bi6fP9Wx4tXVjCbte0LEKOvmq2C6cpdwTkxToUI/HfXiRrBiV7hJ9dF
         /nIruU37nQhwm9YK4Ip5+jAWCzARRq5rh2ER2XONbnysDZbaBwrJ7CTVlVd5S7Hj4SMR
         ZFQNlsnc9ktc9HEL0MEy8/KbgIt5CyexBvMbufUeBXd5R4I4f0yhtkpsKGsiqoKjnoP2
         VwBRnngawUfQJvcwKYhhI/UwUiUuGzwmHBJEItUaTNJY/41sOsz95nN0Ym0cyWEQb8Fg
         E/NrqPH7i/t7Xz/qVArtRYNJSfxe/ECL8BaeGL4b5PdRwV94oAZwBKr4NqVx16RZXGB/
         O1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737161290; x=1737766090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF3bWaUPaYx/mr1WRWWM4MwXwG2ltNfjWEzCsL6n5xU=;
        b=spgLrRILDc0hhbz4IQsEALUka8S03bhF0PdEKfyZnMc77w0RMlpxTsDRau9iogijAA
         pxpKAbJlN1wG6+Ujw2PFqHRu04No63S8chVFEiRqXgE4Jb+ZfzWo26Ak4Ldhsd88FRrQ
         jwU8GKHn4jkqPuK4SW00ZyzRbqQXbR2GgujW5szbpSXLv80YFJgieHkE8Ns7NJeFMS1o
         9EvKy4z6Ib7nzcvrJSi1HbMFoS1ZB6wqZrH4yqAzKJMkD/wQ1RbUAxubLmGbqNNp4+4G
         bX+b+O97no/YzEFmDV6UVij5c9ctQtN4H2H6P3GEelqxle38v56syi5SOiaQQVtvwAMY
         V4Gg==
X-Gm-Message-State: AOJu0YzAJx/mLXIg+ZuGWiUWs1DM04um5Su17gnQTC6Lh7VVsoZOGu69
	8UcNHlATspAOK8nkusTfMaAdX3rlCfIH3c5+fj4ZHFvqPfvSQE6FtmPfzQ==
X-Gm-Gg: ASbGnctdD0L9WzY2rZISIssJ1Ypd/nDXsZwzGLGKsnnReHg7R0BCTt8VdN8mLR9L5MF
	0U89I86UszGyriLKZGA04Y0Lh7X0WHLXecuLAHu9rim0TocqtPcL1vFReBC5Qf0lNhLOatNyu2F
	IYvQ7c1/62PDpAjSgGmf4QPiGfLDxjmU5omftqqXRNLj9fezPXwKirj2hr10DKIkhmmfjNNhFF0
	Dxn0+jazRXmaiueZx09gB7B1YTj+vcaY32I/8Ohz/f7cKjaXmVYxR0/ZExFT00HWd9N
X-Google-Smtp-Source: AGHT+IHv+UEbmURBCr/anvkCgil0TBIeHiRvXkg7fJ8B2H0M/1ybsfATaH6hhWNzMi5WRSMhNVH0Ig==
X-Received: by 2002:a05:690c:7346:b0:6f3:e027:bea3 with SMTP id 00721157ae682-6f6eb6971cdmr39365347b3.17.1737161289549;
        Fri, 17 Jan 2025 16:48:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63a8ccasm6561237b3.10.2025.01.17.16.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 16:48:09 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v4 0/2] fstests: test reads/writes from hugepages-backed buffers
Date: Fri, 17 Jan 2025 16:47:57 -0800
Message-ID: <20250118004759.2772065-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a recent bug in rc1 [1] that was due to faulty handling for
userspace buffers backed by hugepages.

This patchset adds generic tests for reads/writes from buffers backed by
hugepages.

[1] https://lore.kernel.org/linux-fsdevel/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw/

Changelog:
v3: https://lore.kernel.org/linux-fsdevel/20250115183107.3124743-1-joannelkoong@gmail.com/
- Gate '-h' text behind MADVISE_COLLAPSE (Darrick)
- Add periodic hugepages collapsing for memory constrained environments (Darrick)
- Use tabs instead of spaces (Darrick)
- Refactor #ifdef MADVISE_COLLAPSE placements

v2: https://lore.kernel.org/linux-fsdevel/20241227193311.1799626-1-joannelkoong@gmail.com/
- Gate -h and MADV_COLLAPSE usage to get it compatible on old systems (Zorro)
- Use calloc instead of malloc/memset (Nirjhar)
- Update exit codes in 1st patch
- Add Brian's reviewed-bys

v1: https://lore.kernel.org/linux-fsdevel/20241218210122.3809198-1-joannelkoong@gmail.com/
- Refactor out buffer initialization (Brian)
- Update commit messages of 1st patch (Brian)
- Use << 10 instead of * 1024 (Nirjhar)
- Replace CONFIG_TRANSPARENT_HUGEPAGE check with checking
  'sys/kernel/mm/transparent_hugepage/' (Darrick)
- Integrate readbdy and writebdy options 
- Update options of generic/759 to include psize/bsize

Joanne Koong (2):
  fsx: support reads/writes from buffers backed by hugepages
  generic: add tests for read/writes from hugepages-backed buffers

 common/rc             |  13 ++++
 ltp/fsx.c             | 165 ++++++++++++++++++++++++++++++++++++++----
 tests/generic/758     |  22 ++++++
 tests/generic/758.out |   4 +
 tests/generic/759     |  26 +++++++
 tests/generic/759.out |   4 +
 6 files changed, 221 insertions(+), 13 deletions(-)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

-- 
2.47.1


