Return-Path: <linux-fsdevel+bounces-31197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C92992FCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23876286FFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DD01D6DBC;
	Mon,  7 Oct 2024 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRZT3w1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B01DA26;
	Mon,  7 Oct 2024 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312573; cv=none; b=qx1Qqr8MYwhlTniriXbYQkQAlrLNxiQJJYZRFPbc+rlfigKsKaWOzs2ZvbpdtwWo0MydYSIyoA1uoLykiEqlZ27cIDQv7s6D0iH+SIrFU5yeUpaOyEtq/GvlaURIt4qOsNHqUxei4m5vg1A7JZZQaH20Ks7IxefpQjkqi9A8vo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312573; c=relaxed/simple;
	bh=mBfpUlF63Wnj76KpAEO6z16Q+0wdO32RqRG6F0yDckM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n9qhq//iauIX5E1knXWro4c/hMe3BUiWOtaA9AUHa+/HqlEHcArEPo8wTaLdF7RQJ3a3A2hSnTzdu42DrcP6vZPsyZnNLdyyNcQ1lBYEYPQyFKDo4HW3UizM27oiFRe4f0VePpG4jWfkbJe7NaG0u44dEREBIhm57LB1ZEWzsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRZT3w1r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e023635acso769131b3a.2;
        Mon, 07 Oct 2024 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312571; x=1728917371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUiVT68fLR3vW4CyEtRR57v0fZ51pf3YQeR56Ep4krg=;
        b=BRZT3w1rCWk7+DhclWXdLDrFeroFgUyLwkNmkHrW/FaID/OeO7uRLy4sh7BjPeCKsW
         RqtnUtzAIP/LMNM1//NoWWgwOdOAvHk5tOijqQTwi3XR+cQFjdEo1mReMfhwGekgxgmN
         fNOORHv4Ai+qm6OOU3hsARyZwifxsukEg70kNsO1DP34y+cLlDSK3wgxGKykKViKTA89
         Chw6UMLs8U8IgvTRzAb8ZR8ikquybiyQi1RI8k12wRCdfwpIzB2VJdLiOZhQC+ZI7jhy
         TMR0zALtXkSNt2lAlvNLM66OtCS6QCQX5QxnHdenWdagJcNIQ/ZFpFcVMBs+NZ27fEOy
         7BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312571; x=1728917371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUiVT68fLR3vW4CyEtRR57v0fZ51pf3YQeR56Ep4krg=;
        b=RvP/xo7oFaLFjGyv8wWecAuDHoN4rxX1jX9sZDvCGU+AZ3ydmoOYjXYltTrcHxUANc
         dHV8+bzdteFffo5Juw6lyCzcj73/ZjdVZllMOuBWcZKGQMDoVHrNUYigcDnh4PPReWmc
         u8GVkq5bhM940mFoqPQbxPmxR28o97abNmi5r3IeS3lMWT6HNBsmMqgWBaKFH5BnD9HS
         q5ELrtq56/EioVw/lYubUVVhfWRmF5Ex9uGvvFD1SZKbgo1PTMU6MvWEsBYR49eFVR9S
         TXeSnedtrZ68p8/O9rfTW28OU80XLTGwp03/Kqm5qGxaAQeLviofMsb6OMVb5Ivzqs5s
         Ez9w==
X-Forwarded-Encrypted: i=1; AJvYcCVe8dpWXUduZsEJc9/6L8LD0+eUtMddwDBxv7jrwQiRQOX+ZyJaRc1CHUkcFiObmdVp3aIB3MQP@vger.kernel.org, AJvYcCVl1by6i/y0iHOHJ6PJUoutymQtrygweP1YUy4L6epAaMw01FXGcD+e86nxgevD5BlL2OhIHDDT1pP5OTpYPlWgDDb3@vger.kernel.org, AJvYcCVpY+/nCvegjSj0G00ReAoNd27kqH6euPvRFR3RQHTk+iYXFRwVKm/0jeTeD8xgRVbBJ6AY@vger.kernel.org, AJvYcCWY1EqhdcYcUePqgLMt0gA/iR8DLpBcf7ZQJQNheoEAaQz5yo9uuPnkozWwYS0e4qBEZ0eD1Q==@vger.kernel.org, AJvYcCWthSxKlH19TMcEhMgL/tjDooIAleC/va1rulCufqtdBvhqsE5o3ZYDanNCZhlMuK9x+W27206OKg==@vger.kernel.org, AJvYcCXY2W8PIkUoNjz8OPQpBpSxv3QMTAO4gkWF6U/MtDNKC1Ih+lXXg55Fi/e57GPtUxoemSBgxkWQlo5fGcY6/Q==@vger.kernel.org, AJvYcCXq5Qcsg2Iq/4kO7FCnWONtJFxbb8wJBFleq3VmJv8v2j/saYsZpGPoWNm1lo4bqgR2a4TqCpQ+K0hI2GkCVUkjb4+Di1nC@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmiQWWJ7EUXEfhQ+7t1OJe6FtVWolGupArECaLMM3hFxjyCIr
	KDiVBuHxQ1rmPz52s5dC4AGtkJmdXTt44GSviE3ozFslEjk8/Cm5
X-Google-Smtp-Source: AGHT+IFd5G5JZb9zGuck27vY3G5rfm6RRd7wrvlQcG7A8r1xXm54v9yJmOzv7wLCL4FHuPfrgLQA4A==
X-Received: by 2002:a05:6a00:3a14:b0:717:9768:a4f0 with SMTP id d2e1a72fcca58-71de22eb62bmr20503670b3a.0.1728312571513;
        Mon, 07 Oct 2024 07:49:31 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.49.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:49:30 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
	alx@kernel.org,
	justinstitt@google.com,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
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
Subject: [PATCH v9 0/7] Improve the copy of task comm
Date: Mon,  7 Oct 2024 22:49:04 +0800
Message-Id: <20241007144911.27693-1-laoar.shao@gmail.com>
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
string that is overflow. Therefore, we should explicitly ensure the
destination string is always NUL-terminated, regardless of the task comm.
This approach will facilitate future extensions to the task comm.

As suggested by Linus [0], we can identify all relevant code with the
following git grep command:

  git grep 'memcpy.*->comm\>'
  git grep 'kstrdup.*->comm\>'
  git grep 'strncpy.*->comm\>'
  git grep 'strcpy.*->comm\>'

PATCH #2~#4:   memcpy
PATCH #5~#6:   kstrdup
PATCH #7:      strcpy

Please note that strncpy() is not included in this series as it is being
tracked by another effort. [1]

task_lock() is removed from get_task_comm() as it is unnecessary.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v8->v9:
- Keep the BUILD_BUG_ON() in get_task_comm() (Kees)
- Keep strscpy_pad() in get_task_comm() (Kees)
- Replace more strcpy() with strscpy() in
  drivers/gpu/drm/i915/i915_gpu_error.c (Justin)
- Fix typos and commit improvement in patch #5 (Andy)
- Drop the change in net as it was fixed by
  b19f69a95830 ("net/ipv6: replace deprecated strcpy with strscpy")

v7->v8: https://lore.kernel.org/all/20240828030321.20688-1-laoar.shao@gmail.com/
- Avoid '+1' and '-1' in string copy. (Alejandro)

v6->v7: https://lore.kernel.org/all/20240817025624.13157-1-laoar.shao@gmail.com/
- Improve the comment (Alejandro)
- Drop strncpy as it is being tracked by another effort (Justin)
  https://github.com/KSPP/linux/issues/90 [1]

v5->v6: https://lore.kernel.org/linux-mm/20240812022933.69850-1-laoar.shao@gmail.com/
- Get rid of __get_task_comm() (Linus)
- Use ARRAY_SIZE() in get_task_comm() (Alejandro)

v4->v5: https://lore.kernel.org/all/20240804075619.20804-1-laoar.shao@gmail.com/
- Drop changes in the mm/kmemleak.c as it was fixed by
  commit 0b84780134fb ("mm/kmemleak: replace strncpy() with strscpy()")
- Drop changes in kernel/tsacct.c as it was fixed by
  commit 0fe2356434e ("tsacct: replace strncpy() with strscpy()")

v3->v4: https://lore.kernel.org/linux-mm/20240729023719.1933-1-laoar.shao@gmail.com/
- Rename __kstrndup() to __kmemdup_nul() and define it inside mm/util.c
  (Matthew)
- Remove unused local variable (Simon)

v2->v3: https://lore.kernel.org/all/20240621022959.9124-1-laoar.shao@gmail.com/
- Deduplicate code around kstrdup (Andrew)
- Add commit log for dropping task_lock (Catalin)

v1->v2: https://lore.kernel.org/bpf/20240613023044.45873-1-laoar.shao@gmail.com/
- Add comment for dropping task_lock() in __get_task_comm() (Alexei)
- Drop changes in trace event (Steven)
- Fix comment on task comm (Matus)

v1: https://lore.kernel.org/all/20240602023754.25443-1-laoar.shao@gmail.com/

Yafang Shao (7):
  Get rid of __get_task_comm()
  auditsc: Replace memcpy() with strscpy()
  security: Replace memcpy() with get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
  drm: Replace strcpy() with strscpy()

 drivers/gpu/drm/drm_framebuffer.c     |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c |  6 +--
 fs/exec.c                             | 10 -----
 fs/proc/array.c                       |  2 +-
 include/linux/sched.h                 | 28 +++++++++---
 kernel/auditsc.c                      |  6 +--
 kernel/kthread.c                      |  2 +-
 mm/util.c                             | 62 ++++++++++++---------------
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 11 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.43.5


