Return-Path: <linux-fsdevel+bounces-21583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7880F9061D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 04:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242CA1F2239E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F9C83CB2;
	Thu, 13 Jun 2024 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ+G5u03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FE33F6;
	Thu, 13 Jun 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245865; cv=none; b=CowxOmnf5mADC4Bdhk2z5VTUiEbd6acJKuLicrwGk19hAnNEjYVWdmmrPt1pitotTDDEZIdryebVM9xCZvgoS5fQOL8urnMMbJ/4yk2wtOhgGO9bKvbgmgzDh8CDu6JbU0JMkXn+fgklir7ZYETwrbDG7yfRkhcu28xJ7JUO8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245865; c=relaxed/simple;
	bh=tTWzkbxfg+urrQczo838x0xEXLFwq/NcmeMWL5l/9sY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUGJOKJ8aatU8pGFUC2YJutsLgIz88x1UDgr0h2g1cfFlkLVJR1+euxAYigMSCGpCkmLDzYrRxB20F9h2/in7qwp+yZ5dkDDAkv2TcvXaqVM5jbBWVnXJ+sHSXx9piOhISftVfHR9zft8abFN8v9lkngiD1UrbnvSNo0Ur8t9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ+G5u03; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c19e6dc3dcso405185a91.3;
        Wed, 12 Jun 2024 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245863; x=1718850663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3w4iDYMbDQ8VqQWdAkr+pXXK7YGM0mHCHQpTjjn+CA4=;
        b=kQ+G5u03slM3vGoA++DIeIjAI5yjQWxnhqwz34ghdJ4P3w68VMFzXcQ3wk3SmnVMJb
         gaVV0d0cO6mPAnJF/B+owUlhoTwyxm1lSB9j+j4yZohWrbhvn23CKEUIcGIgChHsU0V2
         N/AOcxDMgmau20n9TvFZ1BSq4lGdn9QtzYNaHycwNKG+aKrmQbIxEwyLZtz+DrM5qrle
         6s+E7KHlPRzD1g2qQ8l6up/DIm8w32kontUMEQxKby1VFoizw4phqQ1gjd2bOAD5XuFg
         twbSGIBFAsDaEdFqSyjL0hfRXkddB0ZdaHqbtjEhrXIrczJayDQtYkH4bvSJPRI86GGT
         tnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245863; x=1718850663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w4iDYMbDQ8VqQWdAkr+pXXK7YGM0mHCHQpTjjn+CA4=;
        b=jeP3SwyAfU7Hur9spyxlk/pCqcYku5Mv20u4I85LiX6Zzks7eKYt5bJhowyI/NoPbw
         tdpDXpQmkDmN3L0QthCafNuR+zkFY7F2a1RRP30/B61chBXFo+hLELdT92LxVwxp07aA
         Z+MBeeRyDC2VqSZuJuqT7orJwvXISoafXgvE8U9obPPQtGk+pyxqWV+L+thfK0BNyStL
         Xz+xwpLmlbk6zpO9HLctDoJLJgebjm3F8oGxaykDRCB+Unov4/d2TcVTHo3elw5pC//P
         Qj6zWmBY9qoQSTUMWC5iqNFIbvHKZ9qdETuR0UyRG+M5BZ8cp2gaaHOgRlORgbdQCfik
         3+cg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zW0JGryqkUqOraNZPcC5MRi3pRwrf7KaK+zsXLaJmZE55dgQy5CnJ9Ibtx0GRR6k90VmNV/MhXr2GzOxsElj05RdWEpu7z0WFeKi2x5TnkXSttVpNV933UcyKAcLDvykF2cmIHTAWmGOgodUL/PkV7ZXfNxF+ImAmJKSP8pMwK/Tk3Jcmtzi2MjrGLnKAK5M5B7rQfuf5kn9CnMOB0eM9Ovm7jdp1FP6CmAM53bbGjgg8DbAzhMhXkevjnUbssp0hE7BLhkl+G8CuO0ebCocT3ia0Ud4stNjZ7TDaDmFo29qWg9IWKX1ORmlwIET1xeNFhU7Jg==
X-Gm-Message-State: AOJu0Yz2PctFRdwXfgBuOlHz57Wq6dDy8NzV6kz7R8hSQS3wDeCZOtff
	q77zHKZQ9fVro//WnW6qXIbv6vnNgcsq/VLGLimz4PIt32a/cbLq
X-Google-Smtp-Source: AGHT+IFHNRfsiu51tV3Is/1VFg4pMq/OwH4IEvQ35DxqQ9O+7zGa5prTyMS/UUJ19qnEah41eexFNg==
X-Received: by 2002:a17:902:c944:b0:1f6:ecf8:65e4 with SMTP id d9443c01a7336-1f83b5cf98fmr45292425ad.15.1718245862670;
        Wed, 12 Jun 2024 19:31:02 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f4d159sm1755695ad.289.2024.06.12.19.30.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 19:31:02 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 00/10] Improve the copy of task comm 
Date: Thu, 13 Jun 2024 10:30:34 +0800
Message-Id: <20240613023044.45873-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using {memcpy,strncpy,strcpy,kstrdup} to copy the task comm relies on the
length of task comm. Changes in the task comm could result in a destination
string that is overflow. Therefore, we should explicitly ensure the destination
string is always NUL-terminated, regardless of the task comm. This approach
will facilitate future extensions to the task comm.

As suggested by Linus [0], we can identify all relevant code with the
following git grep command:

  git grep 'memcpy.*->comm\>'
  git grep 'kstrdup.*->comm\>'
  git grep 'strncpy.*->comm\>'
  git grep 'strcpy.*->comm\>'

PATCH #2~#4:  memcpy
PATCH #5:     kstrdup
PATCH #6~#8:  strncpy
PATCH #9~#10: strcpy

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v1->v2:
- Add comment for dropping task_lock() in __get_task_comm() (Alexei)
- Drop changes in trace event (Steven)
- Fix comment on task comm (Matus)
  
v1: https://lore.kernel.org/all/20240602023754.25443-1-laoar.shao@gmail.com/

Yafang Shao (10):
  fs/exec: Drop task_lock() inside __get_task_comm()
  auditsc: Replace memcpy() with __get_task_comm()
  security: Replace memcpy() with __get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/kmemleak: Replace strncpy() with __get_task_comm()
  tsacct: Replace strncpy() with __get_task_comm()
  tracing: Replace strncpy() with __get_task_comm()
  net: Replace strcpy() with __get_task_comm()
  drm: Replace strcpy() with __get_task_comm()

 drivers/gpu/drm/drm_framebuffer.c     |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
 fs/exec.c                             | 10 ++++++++--
 include/linux/sched.h                 |  4 ++--
 kernel/auditsc.c                      |  6 +++---
 kernel/trace/trace.c                  |  2 +-
 kernel/trace/trace_events_hist.c      |  2 +-
 kernel/tsacct.c                       |  2 +-
 mm/kmemleak.c                         |  8 +-------
 mm/util.c                             |  4 +++-
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 ++--
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 ++
 14 files changed, 28 insertions(+), 24 deletions(-)

-- 
2.39.1


