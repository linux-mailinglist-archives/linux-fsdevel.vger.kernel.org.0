Return-Path: <linux-fsdevel+bounces-72712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37AD01094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 06:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B3C3301E6FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376002D73BC;
	Thu,  8 Jan 2026 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jji3OBLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF609286418
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848875; cv=none; b=O/VgAZjwrFxM4F1ijduCUzoM/oH7RERB1MyF8n+o0u6r/br0eXUb2o8nvjctUEZXHwJ07KgFGQzojAYy50KnRycUs+njuLZMzbt4XS3s1HqvzRuy+ivahkdkHFPafbXVrNd5RJpaCyyAW9UX6+Jl7oCSZVyUwf1s3QLWe8Oqotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848875; c=relaxed/simple;
	bh=tE1aQ8gNZYs8xPuJM9kx6/765WYYP1SfzbkObKgrR88=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bIz/a162Ma7XkeK811pr7onANRamXuzPYrQT33Pl6Ll//WSoQG5JGfxBHuZ9of5TPGQBXb8+LaI7km1LbjTNcNfkFyCQ8NgVFVmuH12+NRKPIYUFj3JOODtGgoD0BL9GvlMmwwjuipP8YxbEGxMMGBWTX1JbYxaeIUOoYz4I6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jji3OBLn; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65747d01bb0so5848138eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 21:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767848871; x=1768453671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B0VNCFFD6rMDix3svYgMGRaPMGUEIYmv4wVFO1Dxy/o=;
        b=jji3OBLn+29I07G7IHdhglJXZ6mJJKtvVRFddAhDZCbLuHRcgIxiPR6Oa8vdTkUGM0
         MqBR0nlVQlCPGr737vI13ggxlbeGlwoXCBLYu2FNAi4etyhsE/ukgFk6jepy4FbolTlz
         9QfYLuzcrZUv4TiOsnagu987foid8gV2U2xBLEgRG8faHL/hEsrcnFvMKnPSqmSZxebF
         G1/YJj2pfHOzArwPIi1g2aOjwp3HObbsxCbh6ZodNjxNrKk2d/YaZX7A4Vo6JpV1lf0P
         Ph0T4YahX0swD/X04f3RHQiOtVqGqrJDO5kzhA+ldk8ZVj78q2nQPLM1ejPLKR2Q82cM
         QzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848871; x=1768453671;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0VNCFFD6rMDix3svYgMGRaPMGUEIYmv4wVFO1Dxy/o=;
        b=ry4Iu8+GW/eb3ozTJ42odU4QHlXrkaT4tDiRI93Qvx9UEHTqGCanhFPHoH17g8DEYG
         B1So3U1NtdDQqyQ+06wX3gEBA14x1wv78MHa9YiJuIkrkk2x+ItEcRkYrLUuRrsIJFZu
         MdTP+UV+uzAF5TsIwo9Jc6NkdaaLVND8rxusoDS/xb4cM0fTJBH7BRb9KCQ6N/1ZNHy0
         qkGokTl1/I93JTv6/zwQziX3IdvpNnSc95SL4cCML23oBPVOCAzFGOM1GWodUnc3IDnN
         1Y/viBYl9dDPZ0/IeWGV0HEaSVme9VdT6vNPqHEjFu9CF3yBbxXwbhYCHeNH0KEpC7Y6
         n3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwFghcjHXKuw2EZczGOEX6d4MfsC2XHI500VGN82ykuU2drG1C4CoYPe6DckLCIvbL+BUYcTk1pYN1LNVz@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0QjymCQZtvWY7357OOpmz2eV/aonjr3vPZZQMlHDeFeKKpJb
	w2FEgJ8fp7QiGpCIrInRQPUp6Wm2rtaooibOWxHviGhnC/lFQ/7ZY6aFK3RbZkWUHXaEpKZ1O7l
	WQrI1UQ==
X-Google-Smtp-Source: AGHT+IHFhgBrHzgkUSk+DJKlBY6YHJjdAJxwOsdN8kTtLoTak/dkQMUOAlEAe06z6JEmnyckm7jGXWgWufU=
X-Received: from ilbee12.prod.google.com ([2002:a05:6e02:490c:b0:433:7cff:208c])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1624:b0:65f:27dd:f565
 with SMTP id 006d021491bc7-65f54ee9984mr2161961eaf.22.1767848871676; Wed, 07
 Jan 2026 21:07:51 -0800 (PST)
Date: Thu,  8 Jan 2026 05:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108050748.520792-1-avagin@google.com>
Subject: [PATCH 0/3 v2] exec: inherit HWCAPs from the parent process
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"

This patch series introduces a mechanism to inherit hardware capabilities
(AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
modified via prctl.

To support C/R operations (snapshots, live migration) in heterogeneous
clusters, we must ensure that processes utilize CPU features available
on all potential target nodes. To solve this, we need to advertise a
common feature set across the cluster.

Initially, a cgroup-based approach was considered, but it was decided
that inheriting HWCAPs from a parent process that has set its own
auxiliary vector via prctl is a simpler and more flexible solution.

This implementation adds a new mm flag MMF_USER_HWCAP, which is set when the
auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve() is
called, if the current process has MMF_USER_HWCAP set, the HWCAP values are
extracted from the current auxiliary vector and inherited by the new process.

The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.

The second patch implements the core inheritance logic in execve().

The third patch adds a selftest to verify that HWCAPs are correctly
inherited across execve().

v1: https://lkml.org/lkml/2025/12/5/65

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Ridong <chenridong@huawei.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Koutny <mkoutny@suse.com>

Andrei Vagin (3):
  binfmt_elf_fdpic: fix AUXV size calculation for ELF_HWCAP3 and ELF_HWCAP4
  exec: inherit HWCAPs from the parent process
  selftests/exec: add test for HWCAP inheritance

 fs/binfmt_elf.c                              |   8 +-
 fs/binfmt_elf_fdpic.c                        |  14 ++-
 fs/exec.c                                    |  58 +++++++++++
 include/linux/auxvec.h                       |   2 +-
 include/linux/binfmts.h                      |  11 ++
 include/linux/mm_types.h                     |   2 +
 kernel/fork.c                                |   3 +
 kernel/sys.c                                 |   5 +-
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 102 +++++++++++++++++++
 11 files changed, 197 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

-- 
2.52.0.351.gbe84eed79e-goog


