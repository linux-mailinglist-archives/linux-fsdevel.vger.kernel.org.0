Return-Path: <linux-fsdevel+bounces-22745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9963391BA88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503972835ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A014EC56;
	Fri, 28 Jun 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHPkKpY8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694E514A08D;
	Fri, 28 Jun 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565091; cv=none; b=NxJu70tB08hmGZ4FhNVsYSoMji/9DHT6Ut3/kwvsFTF0YgwouHi7zDskuIwTCeoct4L3kF6GtqHjvGQohf9yVTn14GATyJa5PtW0eXwyuIHbqgCpnFmCnhYS3hRmOZyrMwJY6TV7Z3T11EExbm8d1GXKO7SO2/PZqarFxBXGm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565091; c=relaxed/simple;
	bh=HZhJKiBVZERyBEmw8IFRI4IJlxHvdwvv0u4OoebYJtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vA3u63BhyDHUwyfA/k0Gfdw1rJca8sbObarjVIj8PuqAEGt4OQTqdUDeHbTB59cEWS2XrnnHsFbNhI75i9kv61wSAI6+S5UL4Vukaik0bQKDtfsOlJBVKnuZbVtx78bglqhwF8HZ3go9peLJ1t5cSKRITY+sol23ExLGU+dWih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHPkKpY8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1faad2f1967so11788215ad.0;
        Fri, 28 Jun 2024 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565090; x=1720169890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+oKp38c6s8xaT2ZLZhMjXUeTO03kiDRVYzSyaWPaE0=;
        b=OHPkKpY8mfnr82xkEkSyEBqSv7YVoweV+7W7g5vxuJXBI3c83koQ5cjaRZ7oeVd/OF
         R3OZVGmEuPXajQ8aNVRkr1g5jNlSIfGpKkrL0LOvy7bMK8UJPvgs5yMRASxoiRLy2bj5
         2wDY1iIcuUNt/WUVnsxTSQHW0xHcxBO0GZLuJ+FLQvq+znvOLfXuIbWvn0ljosxVpArc
         uszp71E+8YqyiO+UkeD5q9k13xbz5EGdca6y4mZFMgfaXOBHcwu1lKgooZkccJcxshRE
         w5U9qziNqtlyxgoXQ2DXu1b3OA54DzsL8YBGs11cqjN4n2F39m6w2oyK+Rrh8NmSg5+P
         DvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565090; x=1720169890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+oKp38c6s8xaT2ZLZhMjXUeTO03kiDRVYzSyaWPaE0=;
        b=D4bUv+kTM1vNJhj8TPjlq7pYuI8b49W4n1DoKJ4WdscCncqwO/7k/twBiOEwQxK9l7
         ObVQPV3viUpKVbTU4JHNMb/xAxgZnSWi6A47VhI55L/oso3mc+qrbzhRsf9jTgQbul3r
         nUA514x9/MfBMhihjm7I1SfXTQcgg2Ipj7j8/hbFtmEm4Lf8JJ7ybSm7wOyCDZiPldvF
         JI8pyZj4ON7SzHXskxjNuQLjl96TMETJjggz8SdoAFlWFcaBoPFbQZyJ6sIAnfnRgwfh
         nEjFDOpAH1G+t2W0QwGKArz/ghwySVf6sywAhAeHjAr1+bFGgQaEspUqyL+SjM4zKdMo
         z8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYXvCLb7D5yYoeAH+CwGvStVcMZQA9RFrUN0IAVdGVZWz9DaWxFreBBtD++Xaj6mLmzGP2kauiMScmpQhH+nzId3f6fBlUw5h7iJj8jFb68yGrGOcmy+57Wb4sypj2hZZpFwAcs1gUuIOiLeM8z1nQSmIfIMG7K07Nv+hOkHCi7EhGVi606ELtjRoq5TErQKSgMxvyI7kcYikX5NuZawTpvXRWoSBN0TSBadqM00SpAjgPWPY2MqWGHKbFL8nwZtw8SfI73deCxQIZRQzKWmOvCk2prtoqYenUJyVCyUxpj80Rs5v7lE7JcgP95LJI366G9ZN/Qg==
X-Gm-Message-State: AOJu0YyygW6bQNv9/GLV4xg3BMwh7dvjkBMjNHiwwT0JT8L06wkYZ8HB
	O/uvH+Xe5xMWq59zanUx66iVGbfw3ZSnmzp3cqHlFhrl2jkbPU5C
X-Google-Smtp-Source: AGHT+IHW5n7W+Hsi/3tpD3rJbrf7D7rBby69hy4/8oAP7PWGB8JzPIs+Xaa9S3prTCBl6bkFGCqEaA==
X-Received: by 2002:a17:902:daca:b0:1f9:f6c5:b483 with SMTP id d9443c01a7336-1fac7f0478bmr14804095ad.27.1719565089631;
        Fri, 28 Jun 2024 01:58:09 -0700 (PDT)
Received: from localhost.localdomain ([39.144.106.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596728sm10270615ad.256.2024.06.28.01.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 01:58:09 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: torvalds@linux-foundation.org
Cc: ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
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
Subject: [PATCH v4 00/11] Improve the copy of task comm
Date: Fri, 28 Jun 2024 16:57:39 +0800
Message-Id: <20240628085750.17367-1-laoar.shao@gmail.com>
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


