Return-Path: <linux-fsdevel+bounces-20956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E038FB622
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25896B2AAAE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540ED147C85;
	Tue,  4 Jun 2024 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="JZR17nx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F213C827
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512166; cv=none; b=Mk+MwNYXlquwe5ISZ9Rdh4RD/p8QGpbS0TDtcNbUWMjskv5Mfa+9+j5zxtx9Jccp7CQxkhhq9OlHOCUEN/VuBSNIupXo5S1r6ItkGByNCQ1hEVPM/UN+X00+c8JANIWuBpyB3Q841vZEvqBVkMQuU1WEYntDZ0xcEwhWIubUKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512166; c=relaxed/simple;
	bh=JHa+9ywlMgTeIPeMh6eroajTlaJpwCNkX//8oMednds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNWT/93tuxEmLmqeoYBjxtcpneGjg8Ovo+RfyYSgKNGseZ6Erhf92DmkdkcOgLosM2//KHdh43qf0pxhsUi3+fWEYTF9BYOcUS+TG+ganohRGBHE0KwtzgV+wg1/IfgZZ/1YdM20Sb0HnktKITX3ciiLyPZzhwcdla4Nc/gC9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=JZR17nx6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42121d27861so11430215e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 07:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717512163; x=1718116963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jnKGJySu9h8dQmXOQLdoPh0h1DTnfmclVsZLb2/cVI=;
        b=JZR17nx67lwgHrulSpAr+83QM8hZ5q2CQXYfKKndBG4paUe/Xh3UAfUv8ixmlpPRe4
         hnn+KKJ7cEBFiG6AVJAdnb2bjxbZ/8mFkCBVwmRg4eTVKfWa+gJQBWTB52kPd03MS0QR
         8i8eehjmDPZKpyfKazTYInyIvsV4kzfBPNe+bGZzssFRfGp1E2keBpxjOIL/JyisJhzG
         QsGjs75+DNYQ3orf8qZw1cAX8W9TvgXAHgoIhm8AP81MrFbubPoog0WR/H+TmH7wguc9
         FsLVb1Hwzw8mkEkcOhHi+ESgaTOLd62ihxeb8okQJm8ptDDNDyDLtg0FChMvQQJFHeKt
         ghLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512163; x=1718116963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jnKGJySu9h8dQmXOQLdoPh0h1DTnfmclVsZLb2/cVI=;
        b=M0G2amcZVnEwaCEb8zTM8vB0qxI+XFcdMpS3uYv48otblAiNcFs0JIO4f9/ltlolsE
         D1ZHU7DP1MlRjWDDZw5CHSF4BN/HoGzqjFJ8a8PM7vxV6bs8EaH28mx0wb1vy3cmjGDP
         io0syIv6c8W0ZGcwAsZQ+lsFNDl70aFAeRL39OdMBasiPkTuMVc49Z3WzbFppHFXnhed
         yG2bBHVML0n3XTSFXGKn457NZ/8Xrdeya3B2qZQVHiOtOd+I/HOi5fInQnPZwPFwhVZV
         Zt8cfKqn6CMh/Our2OyyJHk/MUM5I6zlREgBcqsBBrQNOMJKOitmbgB+Dq+6ByBAtBBZ
         IT/A==
X-Forwarded-Encrypted: i=1; AJvYcCVEZk7NG0ZxLmXswiQRqpaY0nANtU4l+wr3yg3+bykkhK33TyqRj7qTuzWQ6tzhEm6dEtjpNFR/Q7wUQIkNnUVZWcenT5hbZZfl5ouXDQ==
X-Gm-Message-State: AOJu0YxS0A54TCww6735tG+7jr0Ojxzh++VqHgInjZxlhvS0BOJqlvDe
	9PFZC1hi1cG2inqhlJLVGf2cFbZuaGtSXoQZKa03eDob/ndukWGPl7AJBYbK52E=
X-Google-Smtp-Source: AGHT+IFHyXe61JT/ocdpGZbrwDVdMOmBXRW4tJ1GcV6IkVgsEhaXirpg5hiOocDOW3cnr3WEDVJn5Q==
X-Received: by 2002:a05:600c:1d85:b0:421:2efe:5aa8 with SMTP id 5b1f17b1804b1-4212efe5bebmr105827485e9.18.1717512163384;
        Tue, 04 Jun 2024 07:42:43 -0700 (PDT)
Received: from airbuntu.BoongateKia.local ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213eca8a51sm62423295e9.14.2024.06.04.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 07:42:43 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v5 0/2] Clean up usage of rt_task()
Date: Tue,  4 Jun 2024 15:42:26 +0100
Message-Id: <20240604144228.1356121-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rt_task() return true only for RT class and add new realtime_task() to
return true for RT and DL classes to avoid some confusion the old API can
cause.

No functional changes intended in patch 1. Patch 2 cleans up the return type as
suggested by Steve.

Changes since v4:

	* Simplify return of rt/realtime_prio() as the explicit true/false was
	  not necessary (Metin).

Changes since v3:

	* Make sure the 'new' bool functions return true/false instead of 1/0.
	* Drop patch 2 about hrtimer usage of realtime_task() as ongoing
	  discussion on v1 indicates its scope outside of this simple cleanup.

Changes since v2:

	* Fix one user that should use realtime_task() but remained using
	  rt_task() (Sebastian)
	* New patch to convert all hrtimer users to use realtime_task_policy()
	  (Sebastian)
	* Add a new patch to convert return type to bool (Steve)
	* Rebase on tip/sched/core and handle a conflict with code shuffle to
	  syscalls.c
	* Add Reviewed-by Steve

Changes since v1:

	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
	* Improve commit message readability about replace some rt_task()
	  users.

v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20240515220536.823145-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20240527234508.1062360-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240601213309.1262206-1-qyousef@layalina.io/

Qais Yousef (2):
  sched/rt: Clean up usage of rt_task()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 14 ++++++-------
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 33 +++++++++++++++++++++++++------
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.34.1


