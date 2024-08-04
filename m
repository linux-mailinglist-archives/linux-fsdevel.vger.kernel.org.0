Return-Path: <linux-fsdevel+bounces-24938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C490946D23
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA2B20999
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 07:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988FF1BC49;
	Sun,  4 Aug 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYbhDKuo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169A7494;
	Sun,  4 Aug 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758209; cv=none; b=Vbzqr869v0hhWbPqJ+v6DAgEuN7HFdqwL/zJgiYpwqFUTWq/q0z40lFkDBpY/ZgKdQV4CqD2TT++R/wmenm+irQUuCk5iGsObn7ckdTrXv9tlaERxowBgkdWKNiEnuyKIpqdzhMnOKLY5X6xonWutpXtcb+3DPsCYmuBW7haHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758209; c=relaxed/simple;
	bh=zfRBye9XjAyf1w+J+rLHJaLjVkIJJvi7H+/9DoIfN74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H7Qfjq5dR8inYuZGd0hUxvjIjZSBazf0MHlS2PrNDyRoGBJJ3mD1GNUfgPEjGuLp5Dta6TxFGgeLrpsT8qqKMmbD1diDoDcb3olG+fCKFM32KBXxcVEwO98YSbe1etqesfrBoBLbSCn0y4WmLdwpHPlbDaRQPwViU/Z5kK8G8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYbhDKuo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d25b5b6b0so7060495b3a.2;
        Sun, 04 Aug 2024 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758207; x=1723363007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAUiIbA9M914l7SbVcGMcRn0qL18BQ5kTGC/RMGMPl4=;
        b=BYbhDKuoSy5kiP/T/t8AYguX4K08c0CO5oMiU4u7FR4j2serqcH7dhWrta+zc/gvdf
         PPRFkQgb9bOZZeox0WWrDlMmmo1U6n5nHgNG07zAaVg8gxMBPFvmXzdxMyOSRLq5+dfa
         IE/KB0iGEbFX8cF0O+NXXos6Lqt9/orLctXpmUzjZXRk+Qn/d4B9VvKIecXTVQVXgNgg
         RnRqDYjpfGHLnssnIOKx11agZsj/yVhg8/hr4MExjivL3Y4ZvYRbZk4HP4d99ft/imL2
         czeTMqlqGNR+mkio4pi6FqZgbUgHTWy3gjqAB8TIdKOsDKc1H3d7jVXL0e9PL2XuhDhg
         Kwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758207; x=1723363007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAUiIbA9M914l7SbVcGMcRn0qL18BQ5kTGC/RMGMPl4=;
        b=amj4DBgEmB3OBlDs7Uz2Uof9sLAgcNUVZVH0qaSsHNKhczzoAPhvBOjtq5sVAPNRiG
         n/Zs80wvdJJB4m1PMY81luR/2jLv6hBCyF5H4+2Q0JgAB++ulkRSUg7gOI/wOVt+0KIb
         q+FPguNYfJnaFEkOtq8xuAt9UfYuoRq/GPDV/VuSI2ETEH+V91TWNj2wKf/ovUZXcIrs
         iqGZPjK3AICX6yulmYegislt3KnpprQNL76+lbGLAFXZmna/B7fGyGVJDrEFl41QnyW/
         YGCS8sA7GF/51pnlNcGrPe59FuYlqjeYOvRNS76ir9zuthEVBD4tJ8jJo+knD0+YRb2G
         RZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCV9zWLqFm1r6T82ZQyjEdpuzqOTV7mJSGYB2e7icd+zJix4VavxkAvE6F74avuo46yijBHz9QaLsxxnHmsHTpDBAFVR2MjDVz1uR+jscSnFbvEaLLJWOZOzhohYeAtOpyOwutQNtp2WdO/tshcXSGS8lu0OSPhqVjv5N9erJxjUuoN/CBt45csMf5AKd/IuLWHQNK3aaQ/fnXGwdRb4wcGRpsSRtQKb0jh8sB+hq8EuYDxYpj7Mjsc4IM5GbgJFYttCdKovWK0SZ/9Gu5qf5qO/k/ffWGavNtu3JnR9yh3WYBGvPJolzwMelg9IT6SxPQelj5fjRw==
X-Gm-Message-State: AOJu0YyyxaJ8rHcNZOXjPeuXE0bT1USDebXZE6P4HHNmclr609MHF+E3
	vGhVHXnV8uYSpOJ19ejVt1RFqlr4CXVtqqqnkmEmLNkqfc5489rXDy2foJCcIy0=
X-Google-Smtp-Source: AGHT+IGr87hL+CR9BQ4tkSVsGq67qKnz8TEMjj1/AcYNViYHS42eo8GA1J34i40o5jKuxGL8nismgw==
X-Received: by 2002:a17:902:d08a:b0:1fd:9e6e:7c10 with SMTP id d9443c01a7336-1ff5748d30cmr59016425ad.41.1722758206776;
        Sun, 04 Aug 2024 00:56:46 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm46387605ad.202.2024.08.04.00.56.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 00:56:45 -0700 (PDT)
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
Subject: [PATCH v5 0/9] Improve the copy of task comm
Date: Sun,  4 Aug 2024 15:56:10 +0800
Message-Id: <20240804075619.20804-1-laoar.shao@gmail.com>
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

PATCH #2~#4:   memcpy
PATCH #5~#6:   kstrdup
PATCH #7:      strncpy
PATCH #8~#9:   strcpy

There is a BUILD_BUG_ON() inside get_task_comm(), so when you use
get_task_comm(), it implies that the BUILD_BUG_ON() is necessary. However,
we don't want to impose this restriction on code where the length can be
changed, so we use __get_task_comm(), rather than the get_task_comm().

One use case of get_task_comm() is in code that has already exposed the
length to userspace. In such cases, we specifically add the BUILD_BUG_ON()
to prevent developers from changing it. For more information, see
commit 95af469c4f60 ("fs/binfmt_elf: replace open-coded string copy with
get_task_comm").

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v4->v5:
- Drop changes in the mm/kmemleak.c as it was fixed by
  commit 0b84780134fb ("mm/kmemleak: replace strncpy() with strscpy()")
- Drop changes in kernel/tsacct.c as it was fixed by
  commmit 0fe2356434e ("tsacct: replace strncpy() with strscpy()")

v3->v4: https://lore.kernel.org/linux-mm/20240729023719.1933-1-laoar.shao@gmail.com/
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

Yafang Shao (9):
  fs/exec: Drop task_lock() inside __get_task_comm()
  auditsc: Replace memcpy() with __get_task_comm()
  security: Replace memcpy() with __get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
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
 mm/util.c                             | 61 ++++++++++++---------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 12 files changed, 49 insertions(+), 50 deletions(-)

-- 
2.34.1

