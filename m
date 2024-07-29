Return-Path: <linux-fsdevel+bounces-24389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB74593EB56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 04:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E577EB20F1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C57CF34;
	Mon, 29 Jul 2024 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFDa6P7F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA88335B5;
	Mon, 29 Jul 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220704; cv=none; b=kTI/HZUEqvNmCs5yH7QZp9uQfeLlGsbIG5Tmf9EsuoTINQvJ/5SD73uQhQv3hJhOM/nDAsgVc4NnnS8LCyTtIDpYU7bvwbd3DSldBcB0hJhq823h+hpbTEJcqbzAKb03SjPotYP9U79aATc7fhN2uajrrZiYoKRhLHeXJTslcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220704; c=relaxed/simple;
	bh=fHi1WKbG4rwo9K7JZ99t5n13jlcTwAYYxY3/86tkJzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZj6/dwg/P9+QUg+9nDn0ej9OIHZkr9p7bRGpiND0/fzNoSNKUwxR70TMFvRZejR7eiFR2MUNPlr0Xf5Q0DR5CzEN5bHCgbTyfu45aY3wHfLO7NLDyi+YqO1Uv2OT96Y6tv0mJgtKk7+eR2BIu1d+weiQDrwKWFnxEFWthAuJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFDa6P7F; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7163489149eso2111136a12.1;
        Sun, 28 Jul 2024 19:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722220703; x=1722825503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoXVnJDl1DBrc1Y4CS2cvJgm86xrff8Hli3dvn72knc=;
        b=VFDa6P7F57uEm75p0d8D4fulDN+V/TQzCllmI8dP+UJYkEDvklDFvO+kzlKOduIvLi
         QklIeiJVjaZvW2K//oOhNQkZ0EBHrrJ0QSI8kjGJmvpUcuOWnPW6ACpxf+h5K2XxOhZ1
         0NByg1pwfQZwZkj9SHoboaXEIHBYfGLTfdPSLai/L/iGscFLvJ8G9FLOCukmhxtdpiNL
         CBhrQd3GwVHRKH3cmjHV84sTaVLWapMEzRjDK5eG72SZHF9+IH3Bew9sQL6x9xcCIL7h
         aWRQsty5yH5nQJTclmMR/o6DJNxQnWn/9RLe7UZ2cWfWJ6SIY1FPpBsC73/7pDa9SVn2
         7Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722220703; x=1722825503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoXVnJDl1DBrc1Y4CS2cvJgm86xrff8Hli3dvn72knc=;
        b=NwlZ5ZbYI7LGqq44sP6zW0JVy63oLP2dPpailVPvcNkXbfsy6aWfXeAdAvIZe90v3j
         6f6faaoA3mADOUW/dArXgObXdNdFiRc919m36poBcmZTuvmzIlp5P3pbW5bvFapKIPGY
         JGVfNiWVj30wGFBfDSqnAhgluIOjk9f9pb5TJhxFVPuyZoMuXs4BoKBlWVeavPMbCSoJ
         wWjL4S6PpggTTR8erLxFWZJejbXr6q/NkvJjHZr7TBRMj8FP9GMSt+LJMA6wEDFTqulN
         5TZpmlOiDm4O6lD/vcH1PkZvvTDqboGZVyasb5boJ9WeGRidVDkUkRAcokdJdHx05Ujz
         DZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVOFBbsz+ncTdQ96HEnlJdf8GQpVMWH0fCly6YT6GAD0AJmDiaPtGxNiPNgnPS0nHKs/23SjvwsqetrZc8mnCKJXg983Qbrp/WJnzc6DfI+FlvqjIFa3p3MVn/dO9rQJJxRrukvaIMdosk15O2snlR100XYynvrF3s+zHlWA4zzQUCb7+zDfHwBbUQ8YfBxhQJYa2KPy+4bQ/ceGv+PC9y10RFxIHPQHPjuvPz12xEnYXlo/FgwQ/XVNWlPRIJjyi+J7qwcp5r6gRudGGjxZbUswGHDlgmaEPjAJjGTIF9tMDlZruLsa0EDby5SXsX8BzV0CTQ44Q==
X-Gm-Message-State: AOJu0Yxi1jAPRWGCNYR33YxRkaLxW1KWXzySC9C3G+0rYvjGzHm02zpj
	IIGgT2B8VMqq7jOVUvuUeqZK5wH0fOuECvRsDXYX6+o1OUIP6GX/padO1IQlskUZ3w==
X-Google-Smtp-Source: AGHT+IHeVJuzyb2EwGW+50qWRtjvsFUnfcwe8AV+hJIj0aUlJNPkNbWdN0SRhTofBR2ODO0UIaMdgg==
X-Received: by 2002:a17:90b:384d:b0:2c9:7f3d:6aea with SMTP id 98e67ed59e1d1-2cf7e5f4b7cmr7481617a91.32.1722220702568;
        Sun, 28 Jul 2024 19:38:22 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c55a38sm7332247a91.10.2024.07.28.19.37.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2024 19:38:22 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
Subject: [PATCH resend v4 00/11] Improve the copy of task comm
Date: Mon, 29 Jul 2024 10:37:08 +0800
Message-Id: <20240729023719.1933-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Andrew,

Is it appropriate for you to apply this to the mm tree?

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

PATCH #2~#4:   memcpy
PATCH #5~#6:   kstrdup
PATCH #7~#9:   strncpy
PATCH #10~#11: strcpy

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v3->v4:
- Rename __kstrndup() to __kmemdup_nul() and define it inside mm/util.c
  (Matthew)
- Remove unused local varaible (Simon)

v2->v3: https://lore.kernel.org/all/20240621022959.9124-1-laoar.shao@gmail.com/
- Deduplicate code around kstrdup (Andrew)
- Add commit log for dropping task_lock (Catalin)

v1->v2: https://lore.kernel.org/bpf/20240613023044.45873-1-laoar.shao@gmail.com/
- Add comment for dropping task_lock() in __get_task_comm() (Alexei)
- Drop changes in trace event (Steven)
- Fix comment on task comm (Matus)

v1: https://lore.kernel.org/all/20240602023754.25443-1-laoar.shao@gmail.com/

Yafang Shao (11):
  fs/exec: Drop task_lock() inside __get_task_comm()
  auditsc: Replace memcpy() with __get_task_comm()
  security: Replace memcpy() with __get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
  mm/kmemleak: Replace strncpy() with __get_task_comm()
  tsacct: Replace strncpy() with __get_task_comm()
  tracing: Replace strncpy() with __get_task_comm()
  net: Replace strcpy() with __get_task_comm()
  drm: Replace strcpy() with __get_task_comm()

 drivers/gpu/drm/drm_framebuffer.c     |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
 fs/exec.c                             | 10 ++++-
 include/linux/sched.h                 |  4 +-
 kernel/auditsc.c                      |  6 +--
 kernel/trace/trace.c                  |  2 +-
 kernel/trace/trace_events_hist.c      |  2 +-
 kernel/tsacct.c                       |  2 +-
 mm/kmemleak.c                         |  8 +---
 mm/util.c                             | 61 ++++++++++++---------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 14 files changed, 51 insertions(+), 58 deletions(-)

-- 
2.43.5


