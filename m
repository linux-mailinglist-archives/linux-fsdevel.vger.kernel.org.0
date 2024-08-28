Return-Path: <linux-fsdevel+bounces-27492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED37961C7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB52C1C22B52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0328B13B2B4;
	Wed, 28 Aug 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msMs74kQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BF288B1;
	Wed, 28 Aug 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814218; cv=none; b=ON+DhmTlKY1VqeFOadBglUYScV9AdPjVDvYOQAzznspEMSmi6GSzVVyDxKskMo4xQQCxvuSVz0E5dmRKqOv/Ke+Ui3DM5kDbr9P3RUEmT5ua1ccDdgBiikkIeVWKdc0pgM0Smh3J5WMilhvdXehaA9FhVeNNQu4zZMJV+L/BILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814218; c=relaxed/simple;
	bh=cCVG2dvpcm6txKhFsmgtEBhA5qVSSR/kkcVf0/zvARg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ljcHqxv1rzpcMlkwZMbZU6EpRUjhKmRraEGjGsxWBdOA0WucDSYbKvwU3UyH4lqx1BtjNSi4nzNDjWHwa9lxyoxwwoUvb5qFe4Dk3zYN2rcpRulSslwuivb+9mqkpdJDs6A0AVgDQELoLWU0CL9hysDqMKFoVIK5R/ihQtLDYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msMs74kQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5226649b3a.2;
        Tue, 27 Aug 2024 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814216; x=1725419016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u96++TBbJ71oR+HkQgBso+tiWoljyvGONtmx4MFc6sw=;
        b=msMs74kQBTx1wCiIvu14y5BmYEt0bSDbsnXqEN4luyvMvOmsyGaWXszGoGo3MQ/hAj
         3qClNqnOjw+qpqfcNQJRBof4u2ceuH3BylnUXtFdLLWg9mXSLR5WoihuysH04vVOCggQ
         lI/bStEInPpNhhS2w6iYe5Xzuvzz96p8bX/qzPAg9jHxfSgKeNjBygD1zyibEwuzRhQE
         rEBnYqUL4054KaRHVxFeBOiCd8DpwF/Cuqj1Qt9VG7R5QjvNap7ccUPqjEa1nvPP9qR+
         j62CA6JQzJCQOZ1A9LMgPAnkc2iDKTgB2s7R4iklP7mZn6dIiPhyLMrn6HemzwKCvv43
         qb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814216; x=1725419016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u96++TBbJ71oR+HkQgBso+tiWoljyvGONtmx4MFc6sw=;
        b=ioIkI6INxYuZdp4q1ZTSEoWD/nyT2tRmfjEJkDuMV9tmFhnD/xvIjpbSWCGvKGyfqw
         iTX7UFA5KhJ/sA2aHdkWMrjsIViuKFd1jehQ2WkPhLcRjXD/P0AjxGGcH/dPR9XahkW3
         lyYw6W/D9Zfp7kVC7wJFpL6LMCcxCM69HugJjjosTH7waGCSo72MPhiLmOyMCkX3Xm++
         WRxiEZUZNBgK0D96WT5FW255a6yXN5V+fU7JmHsMZynv7qm8TNPsztYqhNjXfzMW/YwB
         YVLI1wZgTVlv8vx69Lc2u2JCbOcsKjHmK3p6xRwvucwj2ZVpuT3qTxFQIgYtyPmZuQoH
         tSAw==
X-Forwarded-Encrypted: i=1; AJvYcCV3skHLyJ0gxGjFKC7GoamCrdYoX4sX/dA4X7Hb0WVNFkJ44s9Nb2U9wtOTQTgBnbfby1D+1GHb8dCoZFIcJGKPWsn13L2H@vger.kernel.org, AJvYcCVpq2br3cokzFyWsrZrJb30fuT6KXNaqUPeLE4gPYS++Rgh3NxKM5Ux8lx8xdgt3qx1lcfdxu92G8yr2u6wIA==@vger.kernel.org, AJvYcCWFI3eyZuPuq9BU/Aa6WLr+rqkUlNoYL3ygfBukBz6pd1i3yzTh8ryIGx/opz6GQrASc6cmVQ==@vger.kernel.org, AJvYcCWf7GCXQbIe6I5CYIlz5eQUib+/8XepXlpN6bX0L6efJ0DJA7MqNOnk55otw66WIJvMex69L8an@vger.kernel.org, AJvYcCWg+KpImpdHpLN7JuIQ9yerK6FRDxajrdW5iXGihOUkrEVLJCXb2xTuiHH4a4dUHq7w950aEb9HcD68o2/9D3+GxNJF@vger.kernel.org, AJvYcCWv2+Vb575Hd2t6C4MwSur+qKxMqEZSIDY+GzO7/LA5YbywGIV8K5HLdlYD8dXUuhLVRMAR@vger.kernel.org, AJvYcCXvJAet0O8obK0I8vB+ZsrIeGsUFlxnw1fL50FZRsEWRodLSVXMrJ4Zp+9N7bUCpET6O5yw3UiwJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQelLdsTlDXdqQe6T/9H51Rj9MAmtpYGykVdhpncSnpE6dbMdh
	/SxJm3hhig7XhYZFp5G4hT6N47MtxC8ziLVVIqxz8g/e9hOWqJbP
X-Google-Smtp-Source: AGHT+IHibExtxV8dBZTZD5JORthJOms4iDv1rvcr+QvHWcHAfAXxuXG3hLg0KOZ+K8PqosjKn4N4Iw==
X-Received: by 2002:a05:6a20:9c89:b0:1c3:a63a:cef2 with SMTP id adf61e73a8af0-1cc89dc90ecmr15627538637.28.1724814215888;
        Tue, 27 Aug 2024 20:03:35 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.03.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:03:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
Subject: [PATCH v8 0/8] Improve the copy of task comm
Date: Wed, 28 Aug 2024 11:03:13 +0800
Message-Id: <20240828030321.20688-1-laoar.shao@gmail.com>
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
PATCH #7~#8:   strcpy

Please note that strncpy() is not included in this series as it is being
tracked by another effort. [1]

In this series, we have removed __get_task_comm() because the task_lock()
and BUILD_BUG_ON() within it are unnecessary.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v7->v8:
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

Yafang Shao (8):
  Get rid of __get_task_comm()
  auditsc: Replace memcpy() with strscpy()
  security: Replace memcpy() with get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
  net: Replace strcpy() with strscpy()
  drm: Replace strcpy() with strscpy()

 drivers/gpu/drm/drm_framebuffer.c     |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
 fs/exec.c                             | 10 -----
 fs/proc/array.c                       |  2 +-
 include/linux/sched.h                 | 32 +++++++++++---
 kernel/auditsc.c                      |  6 +--
 kernel/kthread.c                      |  2 +-
 mm/util.c                             | 62 ++++++++++++---------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 12 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.43.5


