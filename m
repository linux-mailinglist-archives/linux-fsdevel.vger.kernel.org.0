Return-Path: <linux-fsdevel+bounces-25614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6B94E4D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329B81C213B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4271292CE;
	Mon, 12 Aug 2024 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8z1iV6r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F6461FE9;
	Mon, 12 Aug 2024 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429805; cv=none; b=HabHkVIQpkxcdHuOSh8sxDd0oupWbYEc6tszpyxNcuWTz0qcyrAsB+xtBVl5/d5amStgYj849GSRGapzrG+Boi6Wu3sXEWTO+THnlrs7UdehLOW2215mxgzODUbdD6ipGSjR0C+AIX96jTlCm/LaB1Qvpyv+XxS4f5EWagp1NRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429805; c=relaxed/simple;
	bh=qrFhDBoxjeR+uUI0kPeuVPn5TUPX509p72xmhgEo0yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PiOj210oQuGVKERaVE72KnZXCGCeo1Ckwpn1/7NSQ6t8SqewcG4hbLwJQwqgNU6spCgYzDSdJjCdY84qVooTkpNS94U85GyoB4Qo/e9KS0WhrFgFjjJ0FNXay0XLrAGlL7VhMEo1eOEpriLV5Tmb146Cx6t7GzOA7G/cKH9B8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8z1iV6r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc52394c92so36124215ad.1;
        Sun, 11 Aug 2024 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429804; x=1724034604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CPcfP+fHyMLz6sCkXjXj/fN1cAsrryKdxQYaf/+RRmQ=;
        b=O8z1iV6r/rAgFSYMSBzj1TOYK/tczo/bTX4r6znPybKuYpA7I45sQU1KvcEJY86kau
         mcBJaIYNCteyjvVNBdvsH0atYNAYlW1xDj/ZwR3xeOcMcvV/x6BOyBrE/By/TlDNjn8i
         xMpzKsj0tbpOmkxfPMCTwAK+We6RX3SW2rQpiI368MjWP+d828I/HPanOhMg+QHFfbTQ
         EDpGvYPlxwlmfTw8NPVVj3zbSxtI7BfQxH/H+3undPt+iGFjfa+PNUd4Q/uRbcYwxD1U
         lcTfwv88kEkbGapLF7UtrrUwemsuPKu1/N9M0W1lVbIQEzOGbfm9DTZeV51k/AJZH5Sk
         A+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429804; x=1724034604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPcfP+fHyMLz6sCkXjXj/fN1cAsrryKdxQYaf/+RRmQ=;
        b=KeYt9O2HKAAN8Ev+edzRc0JPOZbzy9/6q6/SI+Iou6uanmMjqoOPKYTsRGhrB2tXPc
         nAFq5Fnc3+P4QELq+iOsnW7SIBcdQY5u/XZErWl/JoQPDY1zpiOeY9VqneuWKfx5O588
         h5NcNCBMlDNmuf98PmjlH9CiisOXQ3OlyXEoeEZMxTLzvchm/GiJ0tpaP1vgRkMsijnO
         XYtkBeXH+TYe/QBXOTlsruyNjaw1LTgA0gABL7pVRMKH5pkY8VeSVrwgOAYJkibuPvgv
         2OxFVLNgoODi4l2guevAvcM38R1WYv4PzRNlwxOmMqSzBWR1MHpBQynkPXSrBMd0ehoG
         1Bug==
X-Forwarded-Encrypted: i=1; AJvYcCUg+jTDF1XEexXok+d71NSrwzwr/CnG6pWEVrIYkShULSDn9CuGrT3XkJw+yf/4vXC4DsbJ0QqXmvOvG7Ura0WuTXX6QgvRm86Krx2FFFa/Kij0zF6NEg1zo5+lnZTxeoZu1Bvl19Gq/pP1QYZgIw8CN0PEv/vzY/ltrurIwMHjfVyyaLMMcGDjdp1Iwi7xJ1AXmGLAYO9p3o717blpgg0nst0ANn6musKA3wfRlm3tNFbiORoaJkU4ZmjrrYesLNd4qWYd3ZNDeO6CY1TtqO4geUGV44kskNbMylqLLpGG3d+MecUy3FS/v+vwh1dr/d8jErTl/A==
X-Gm-Message-State: AOJu0YzI2yOaVT1b+1NJlfNaFSPlP5U0ujKk2s5GHDebm9IZDsTjUAO1
	soKf2PQruMPNBnF0BW0oDL1XHt/eUYdRcTYt3L72Pv6IIYVLvKxT
X-Google-Smtp-Source: AGHT+IHWjfWk9Yvp8Xz47EmfqTOyYIqZTpLYHww0hZawPQZt6bgoSLmdtP7yW5PiZUmHJmuoGirzew==
X-Received: by 2002:a17:902:ce03:b0:1fb:7b01:7980 with SMTP id d9443c01a7336-200ae250234mr122466755ad.0.1723429803589;
        Sun, 11 Aug 2024 19:30:03 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:30:02 -0700 (PDT)
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
Subject: [PATCH v6 0/9] Improve the copy of task comm
Date: Mon, 12 Aug 2024 10:29:24 +0800
Message-Id: <20240812022933.69850-1-laoar.shao@gmail.com>
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
PATCH #7:      strncpy
PATCH #8~#9:   strcpy

In this series, we have removed __get_task_comm() because the task_lock()
and BUILD_BUG_ON() within it are unnecessary.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/ [0]

Changes:
v5->v6:
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

Yafang Shao (9):
  Get rid of __get_task_comm()
  auditsc: Replace memcpy() with strscpy()
  security: Replace memcpy() with get_task_comm()
  bpftool: Ensure task comm is always NUL-terminated
  mm/util: Fix possible race condition in kstrdup()
  mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
  tracing: Replace strncpy() with strscpy()
  net: Replace strcpy() with strscpy()
  drm: Replace strcpy() with strscpy()

 drivers/gpu/drm/drm_framebuffer.c     |  2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
 fs/exec.c                             | 10 -----
 fs/proc/array.c                       |  2 +-
 include/linux/sched.h                 | 31 +++++++++++---
 kernel/auditsc.c                      |  6 +--
 kernel/kthread.c                      |  2 +-
 kernel/trace/trace.c                  |  2 +-
 kernel/trace/trace_events_hist.c      |  2 +-
 mm/util.c                             | 61 ++++++++++++---------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 14 files changed, 66 insertions(+), 64 deletions(-)

-- 
2.43.5


