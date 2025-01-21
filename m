Return-Path: <linux-fsdevel+bounces-39801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33988A18789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A6E1627ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2F01F8911;
	Tue, 21 Jan 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h55JmBMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB91B85C5;
	Tue, 21 Jan 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496679; cv=none; b=svH69zSl2+aWUp85cz0p8yllgIxPAhaB1yWskd0bikSGEyEnXf/oxZYVSUNdZLjSAW3ZQSXGODY/oy/PkbDrPG9reOFAA21lZ5hhkrdSwOWc2FojOWQAOriq/g5b2561HF6e6akbd7QjHopNbV+IB0QdPkpFn6kMB2+AjAmH7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496679; c=relaxed/simple;
	bh=iwQAYmSv6mOcGDLGhF4ALj3QqFyyNnVW+bor9nF76FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFpTTtFR9/4SJsj2VhYMwB7xMIL1lhwqYdfiohjn16gKB8sYHUQ3lsJOlI9yQC9PICG9jDNjLnTJWbN79SX9F6q8Bf0xv3vKPYpU+XFjYvHQnKXpMJtmjULvF+G9nm9FX9LsEE/aCLfGoYZjloXDL6QVQEtWf7idLg5+lrA5oN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h55JmBMR; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso9733608276.1;
        Tue, 21 Jan 2025 13:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737496676; x=1738101476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwGWgkyJc1Uae+zIgBxQ+sZTkevS05BbKjYiRoid0bs=;
        b=h55JmBMRN7MP5Wznes45eyvdzz7YTJVfrEwwWxxanUCN2Yv3n/ZDjaXTR6nBR67STM
         ZnpTN3QlsbUAM8SYr5FY7JjLc2Z7z5bPVQca3BG2dBEpdkfW++xfF+/t0W/RqYfLv9vh
         uafaMu3RTa/GFMRZDevVN1wLKWTGUQ0Zd0XL/cDTgehfpop+pLe8C9MGeMOfqpyBIwEP
         GcJMbYVu9oYb/zZ8Fs/plG/zaREtkO0QFweCC9K0BamQ6/smlZ4d3xEZNSfericCcroS
         Lz1PawYJg7bVTfW+8MBT1TczrceoFFrg7aRXq6b5IOHYsNKGFLAAeXaz5Qql2eEk5jRH
         tcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496676; x=1738101476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwGWgkyJc1Uae+zIgBxQ+sZTkevS05BbKjYiRoid0bs=;
        b=dZuD+dEmP6eXVY5m9ag9pQY30xcmQlYeNWLXor1FAgCbWPo3llZdNl4gVNMTlE6Tx2
         qsEWCRDiVQxzTvYBTxchvlJ50tKOpag4qFhU+xNKT+oGG3QsdqIP8i+4IqpAWHV9Ujp2
         UYK42gkVDu796anDM4pSKEJE9DR89Hxulxr76uMgxpElh66/rbxeaoawAfX7z4iGjagH
         SHvoHYwpaL6kED4Ws9sAFyiKjiIqAYSJAk3/NtMUmc59k4LrsDlSEZOX4r53Es9RmIhU
         MwzaFo/YMuh1YUCXZuLu0AXMPrNIZ9hWDwq4Qh4a+Tp/aUf0k42nfW93zWyzB3OBUhkL
         Y+wQ==
X-Gm-Message-State: AOJu0Yyy0RIDwqTOXYaOZsFv/1GGPSaf2szuxMtqn/rohxoanMngINUl
	3L+NuKZ2dAjk/HscFglzPXZ2Qps0mRtdrHCNnrrPJDCRHKvbo8uMNiNzLA==
X-Gm-Gg: ASbGncviW2rmair4qm6ZFgHWRLYBh+N+t11ZB9rYQuJyK9loaO7oHykV75c0BvTIKrD
	PklH445C2cWXmao4g9yGF9Y9mOY0O3Au8K5YNAIcJvr+6TUnfbX57ZRlJpO2TUcaRMxF8oTKFQH
	2qd/UwssNJi2g76nzYWJZLmTmYfdRUhnPf2jgro8KXff9TLExo0dugJQ5SUSCsm1kTxNc1LWJHV
	lYYKo7YRj16OzUWsBTap5mSs38/QJv5BgE1motScQ+aSaGhirrJm6aqR8uwfV8JKcg=
X-Google-Smtp-Source: AGHT+IGlCCew5tkRBsy1h32UTgfarbnZhgkktGCKrJKx6isUy7+tBaX3wZMhtlaHckULERnHnQXfMg==
X-Received: by 2002:a05:690c:f90:b0:6ea:f3d5:e6d8 with SMTP id 00721157ae682-6f6eb66bbe3mr148544857b3.11.1737496676024;
        Tue, 21 Jan 2025 13:57:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63ab29esm18318017b3.15.2025.01.21.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:57:55 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bfoster@redhat.com,
	djwong@kernel.org,
	nirjhar@linux.ibm.com,
	zlang@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v5 0/2] fstests: test reads/writes from hugepages-backed buffers
Date: Tue, 21 Jan 2025 13:56:39 -0800
Message-ID: <20250121215641.1764359-1-joannelkoong@gmail.com>
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
v4: 
https://lore.kernel.org/linux-fsdevel/20250118004759.2772065-1-joannelkoong@gmail.com/
- Fix identationand and if logic structure for collapses (Darrick)

v3:
https://lore.kernel.org/linux-fsdevel/20250115183107.3124743-1-joannelkoong@gmail.com/
- Gate '-h' text behind MADVISE_COLLAPSE (Darrick)
- Add periodic hugepages collapsing for memory constrained environments (Darrick)
- Use tabs instead of spaces (Darrick)
- Refactor #ifdef MADVISE_COLLAPSE placements

v2:
https://lore.kernel.org/linux-fsdevel/20241227193311.1799626-1-joannelkoong@gmail.com/
- Gate -h and MADV_COLLAPSE usage to get it compatible on old systems (Zorro)
- Use calloc instead of malloc/memset (Nirjhar)
- Update exit codes in 1st patch
- Add Brian's reviewed-bys

v1:
https://lore.kernel.org/linux-fsdevel/20241218210122.3809198-1-joannelkoong@gmail.com/
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
 ltp/fsx.c             | 166 ++++++++++++++++++++++++++++++++++++++----
 tests/generic/758     |  22 ++++++
 tests/generic/758.out |   4 +
 tests/generic/759     |  26 +++++++
 tests/generic/759.out |   4 +
 6 files changed, 222 insertions(+), 13 deletions(-)
 create mode 100755 tests/generic/758
 create mode 100644 tests/generic/758.out
 create mode 100755 tests/generic/759
 create mode 100644 tests/generic/759.out

-- 
2.47.1


