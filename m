Return-Path: <linux-fsdevel+bounces-26160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61F29554F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E99F1F22BEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07243178;
	Sat, 17 Aug 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeAOtq7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC2EEA9;
	Sat, 17 Aug 2024 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863409; cv=none; b=iLjUvmxcNjWYah9SZLsbta215GBhyuZ91hr737o4KGpIkfpMxsKgEsSgkM9aHaa6jQ9+fOvyCmoce+BocU9f5oZThRE7kapjhrl2JkdG75it/QF5Wbzz8BLpBcQx1Qth7g1Sjrmal7wsZMlLiYyVRZ1rTN0o1WJNWTUrAgD0ug0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863409; c=relaxed/simple;
	bh=+jKitb4HkbCFufAiexrmRMipOSoKL+6Eqar2mQ6apRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VNzXMwoIQnbxhSAn8X/SQiETs6M3yFp+iTA5Xsp9bfQvbgtnlljYTcaLU7pADnAmyPPmitpQxqMDM+Sq051NwDTcTp4s7WxBML39HHFKfZksw4YBeF1F9H6QJ5CjvOC61RB/G9x2Za44KEgGlky/Q6YQTgZOGBlAcBIY+Z+TSzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeAOtq7b; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2021a99af5eso3132755ad.1;
        Fri, 16 Aug 2024 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863407; x=1724468207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKgZtG9uOqD3DFxRKcQkjZTQLILEzoQhivhfaU9Nqo4=;
        b=AeAOtq7bWuoSSO0yj2nCikUif0Lsq2DVexFN4MXYcuW1CaCcGMIeL+szogLsrbG+P8
         8W1SfycMZgZxCuP2Rh9vgdgBg/FNJ0DWThDUsUTOBUX4Dm0OoCt/Zmb7Nnb16UtEyY0B
         1LpPidN42ifDf0c6BQgW7y1Le+76JauDFlF2ZoAjWWz7X/BYYS+SfnV1unSSThdZtIQa
         wOPvuqUOEL/V7GL1jauEjSEzj5EEEp1V6zxOACD5pLnfEOYwbZ3G9lX1csRIoaxHaGTw
         uGdMBMBv4lvLTBGUr9Sq7UuxvH8NvAJ+R10IUpJZin5d1lPNn3HjqdaNOdA6tf8MIdby
         ogLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863407; x=1724468207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKgZtG9uOqD3DFxRKcQkjZTQLILEzoQhivhfaU9Nqo4=;
        b=rpHZYXdqOJKGOHSV2CjrMVm0+w3SuLQNLQI0qTlJhvZBvLVoxvRAxzqh1/1obHEdfZ
         /p6SXr8sOCZ3CaloWNukbQBQKz6BGeJDJLZrBqfXgMSRVb6tPI5gO3Rn30VBOBpMAMc+
         jzma2tsz4NuW7bcaquq9agd5h1QE8TmxbcxZVtCdH3jq+AOuBysZYBlfO9a4W1uMt1YF
         ujetsh+aSLUH0/VxMekw5p1Q/g5f2WD4uP9O3TYFdDgUKcjDTVHkQ1L1iUEMrd0S4LGM
         bvFYfnfwirJuhEN4hBG/tyPII2J33ehqHaOT/BcM+RvRqZqQSCFCkhXBx1iGqEAx2fRz
         VJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4l18vrccTxSZbnLmVu7mD8aB4sXFBd/GPYGdbTR7sAD5Hw4FOJXSnyEGDCSvqy81HwLiT7vrsjyBmIcyctm+UumpydSuage72ilFbHim3yTNNL6NoAbf7Qlz+XlvoP/sa7kjk+18OTwXLV/Dal3hwX04d1ivgIkzEkL6RplRiQp2i5SUb2JjpMtrHy7ddD+xh5wXXkH9aCj4+zO1Z6CMGYRBhAaKsvg1GJ/ymrEZjiJwtQjAiuh6GUNyY8UwH7lz79fwiXRwHHuaZarg/DqvdyrzfH73P19MksKL2o+7sMahzE2kP4zUpg9fgA0bOng3vXC5RLA==
X-Gm-Message-State: AOJu0Yz3wF3VKUbRcrV95ImbRYwrpFpEpAFBscnn+qUYqPzxFGk6HnSg
	1AJQPLxoQxpalFJIJ922tv8qPn+xlZFflrUmLChc+3MO4+CNsntK
X-Google-Smtp-Source: AGHT+IEbPGpqoRSYF8jBgPK+pTBiTQRphrHbJ0rUSgdEvQgjtWO3Wff4DwqW4cJKQwtvK2mv0b1kNQ==
X-Received: by 2002:a17:903:124e:b0:1f7:1b08:dda9 with SMTP id d9443c01a7336-20203e50e27mr63144585ad.8.1723863407171;
        Fri, 16 Aug 2024 19:56:47 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.56.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:56:46 -0700 (PDT)
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
Subject: [PATCH v7 0/8] Improve the copy of task comm
Date: Sat, 17 Aug 2024 10:56:16 +0800
Message-Id: <20240817025624.13157-1-laoar.shao@gmail.com>
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
v6->v7:
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
 mm/util.c                             | 61 ++++++++++++---------------
 net/ipv6/ndisc.c                      |  2 +-
 security/lsm_audit.c                  |  4 +-
 security/selinux/selinuxfs.c          |  2 +-
 tools/bpf/bpftool/pids.c              |  2 +
 12 files changed, 65 insertions(+), 62 deletions(-)

-- 
2.43.5


