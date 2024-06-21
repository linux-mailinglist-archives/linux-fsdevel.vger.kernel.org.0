Return-Path: <linux-fsdevel+bounces-22045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CC91187F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 04:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74263B21A1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170084D29;
	Fri, 21 Jun 2024 02:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVCopKb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C23207;
	Fri, 21 Jun 2024 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718937036; cv=none; b=IdDocOnIxDrRVi8hWt/PGaoi7bekQRGP3Sn13URmdVKlw9KALO/28O+XK1stfj5lSB5xA9/tNXCNCn/nhGKSbX1P0qBOJGMnSjWFCg7IZLKcsIGq4TMH3emUx5GK44x+ZV9yNWxEUwKX4N38vr4l/KvNuUNetR8SMl18qvMd9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718937036; c=relaxed/simple;
	bh=fMlHavGbtfAeuokks/SCwnduQjgzHmT3IS8gpQsG98I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpnxbertiZOV0LGt38xekZ4F8Ch6TnLfkcEmSJ/r4a2a6sAfXwM7134cR3jczVl3zWNdcUmX3XMq/vwOmY31kjbrEbFheNUqdEvtJ9OI086So9+K/rsJaYy+UC9OELQt6kE7VJSjMR38PyHBP/+MXVq068a6wsMlnPpHGT5lPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVCopKb3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so1221875a12.0;
        Thu, 20 Jun 2024 19:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718937034; x=1719541834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwlwwP2ml9p21cPlAav/YvSh18oChNGHXpTCNRHeKlc=;
        b=gVCopKb33RvG+mZPoRENvHdxkmF6ZKdBql+BV/hh4GTuFzZRQCZSsQnJZvrbO7jrNM
         fKpfzf91ji3mpR/abfNb7gurkUV+5wypDyr4t6m0aXpierEZbAyv8LjxU3TLs1xDNUG5
         7Y3O9u7zw4F2dUKlo68EWtF5eGzN1BFdsxxCWzdg39iFUBN0YgK060r2XbsVQ0Su4nC9
         e4MAhwZ5R2ho20eL7u1GRIHMjwM8YLR5v2rq94xhHdiHCw8CAGR8fl7ReGf85cP2l+rB
         qhQgPzflnEtoDR91skSHEl7B0EeF1uza7aMipwPq8JJxt5Wxcxlge4uDhgopX3ClyCPJ
         nGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718937034; x=1719541834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwlwwP2ml9p21cPlAav/YvSh18oChNGHXpTCNRHeKlc=;
        b=j8oc1u0aB6IYJn6JS/rKmidqKgmdc8FcHWKZRI5Qa5GEY3BDNKGumSMaChjeGv3Aev
         9ZzU9pROS6++JiOlkPSrHiVpXVYS8lwhpgLYL3en0DPqu+yXLMlF4VciG+XMsXQFt0JC
         O/8L6tqNKUfpkTF+ZGjUITsSZ13Re43qhFRJCwbpObvsHujEpLrR9ytAv9hN715QigBO
         oT9Fnw7iWKCAWYsDSFL7zlq4v3slFOtGw0OWsTtpzombjO4bWnpC4NpR3y4g20W7iLLu
         pk5gkMZCiWl8/pfzQGgFgLHiL60qHgMVdMBMsLPN0Td7Gzx1v7Y1/yg3h1Ih7ISN1+3b
         WvNg==
X-Forwarded-Encrypted: i=1; AJvYcCWluYFFI6R6yv7Pg6sEUu129v8wjKygLnrg9M0kemt2SV+r/Jk1pq9jdKoJwTFe5Kt4SdhkjYBzSsVse57R2m67DSbHRWuwUDbdiUqPXRpEFAxb6mGDEemO2F/P3qPRQiRlv6z5nXtGCccEXuzkPI5S1NvoYZVRinSq4vUMgdKb77Xk2DR1vaXacBWUYMVmPF9xccyvrHYXnOM8xTP1XMWKJ1FvJge10fwmfD5DlMh26mTXwfEKY4a4Liz+TpPtRVmmQ+l3S+UNBCnu3CnoGTRuH+cSXnB9NyycSWPR9SNRFDgtOHB7t6U/yEMKQOUVIvQAgOpmXA==
X-Gm-Message-State: AOJu0YxFawzzxHuVx+BDrqECyeRjt2DfULudO4Jwi9lcGldY1LkFZTCI
	XCb++I4SUWir7yRDGLhcWsD1uNRkcUQKf/bWbF+5hQ04b7ZIi1CP
X-Google-Smtp-Source: AGHT+IHCunKAxv47P844vphuNTxBO9sCB83yDLseIyT9/+IsrkCTE3Wi2jgqKchbD0S9to2P9PKntQ==
X-Received: by 2002:a05:6a20:9145:b0:1b7:edea:e32 with SMTP id adf61e73a8af0-1bcbb46b981mr9429646637.32.1718937033951;
        Thu, 20 Jun 2024 19:30:33 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511944d2sm332488b3a.70.2024.06.20.19.30.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2024 19:30:32 -0700 (PDT)
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
Subject: [PATCH v3 00/11] Improve the copy of task comm 
Date: Fri, 21 Jun 2024 10:29:48 +0800
Message-Id: <20240621022959.9124-1-laoar.shao@gmail.com>
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
v2->v3:
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
 fs/exec.c                             | 10 ++++++++--
 include/linux/sched.h                 |  4 ++--
 kernel/auditsc.c                      |  6 +++---
 kernel/trace/trace.c                  |  2 +-
 kernel/trace/trace_events_hist.c      |  2 +-
 kernel/tsacct.c                       |  2 +-
 mm/internal.h                         | 24 ++++++++++++++++++++++++
 mm/kmemleak.c                         |  8 +-------
 mm/util.c                             | 21 ++++-----------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 ++--
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 ++
 15 files changed, 53 insertions(+), 40 deletions(-)

-- 
2.39.1


