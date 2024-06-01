Return-Path: <linux-fsdevel+bounces-20712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D868D71FC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 23:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2739D1C20AD8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EE322F0A;
	Sat,  1 Jun 2024 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TLwXvDBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1511DFF8
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277613; cv=none; b=UHFSTQauxtWjl/aEDZ4wZwoliOpofr6cYNR4pUF0IUKgKeK6hHFyRjrNfakjVC6cONC+VFTU1ZTknhju6qPuw6Q93VcQVjYumyMU307spaYBe4z7tZ6G532zSwJSrW5KW0jp8UTVw8xY/wDUuXNqokh/trFvacGZXzBDI+8XrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277613; c=relaxed/simple;
	bh=3sBwYo/AqZ+0RfDJFg+GCK+aWleW3pxMfuHyAah0dzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m30IDPOeF+WiSOEz69hpm6ui9p+IGho5O1ZZ1MJ6GMjxl6GJyLgz544Dm7AJ7mK9u2dp3e1aCOSEssZgpb5hGPt5j+6D+GVb+09kRdyGAw4NdIqt+lMzQZJPBp2AeVhqEhPFr1phbMmA9zxP0qfaRI2gKTsi4Kfer4tX2UJ+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TLwXvDBd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42137366995so5000545e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jun 2024 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717277610; x=1717882410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=TLwXvDBd2KibpGurTDNi0sS+F1f2zelbruqHlBywSWqKU0TBnjVDV2I9he92JaYU+J
         wkztfGH/CioZVK4nKw0NVukUyatKtpyj/Qw9a7+0w6AOW61OOyUmKQQK/YDiWuohdgj1
         7hq0QEZu++TL9htN8+fffSxcA1BTQRsNaE9fv082V56CEc+wTYar/pfjMOhwxek2VFGc
         HqkJRulNSTqpx5rfrUIglt6di5bT2mYLGJr/3yYSZMybL0C/13lEHP5uOSiipbdXvaAL
         /d0ROzAFVNH7iXSpNoOgKPIn1MbQtYIMiooXq6730LwBebTl3KzTYl6xueNsTXl4Bx0S
         JVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717277610; x=1717882410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=weqociPQjkavTQffmMqHauaUJ7TmBLmJ2YTZpOE40T+eDfficSOPkPLp25H7G2vw/C
         OH+S7BLu/6kdePta07kalgpquYes+X3R9YAxlxIPGJv9sZHp98WplnfMjvO2F/EbD7U/
         tJQ2YOyVA5ppBEpov5rWzjuHmF8JXe058wcvbNn7SQl/MBUk9shNQ2eCBBCo2A1i7Bpo
         Q6ADxobfqM/u0Qt/jmhncoFnBS+MYVkB6saK5kk0wwr+mGCncAhGCTRi47/CLi8lDRkv
         eur0uB0NZ/Q654DgGuzdyI4MkzmimA+NYoyoWoDpt7BpScyBqPp7W5A69pUC/3exDMEY
         rdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRYJLJcU1QpLjGeRP38VOgKtK2cVs6lEtxuxVx4HkHMTClWzI0qMske0uE8jO9NiQDdSWMGXiUxO/g4aGFmVjphoj/WLMkz7Bp3sSYSQ==
X-Gm-Message-State: AOJu0YysChsq66LvAPb8+FHa8hxdIbfy3vpFgTvvUi1D5lvThZbI5UUt
	z2I+j5U7jOQ1Gc8EDccYrRJz7BY/Nyj/fU7b+fHd9DGIvLGWj2myoXfFZ1LuM54=
X-Google-Smtp-Source: AGHT+IGl9Hl1b8VRJQpVpXl7hCsSBOPLOHgRsVLux3bAWL4Geb2ApKKwM1lVHyceYADVoADXs17YOw==
X-Received: by 2002:adf:e80f:0:b0:354:f724:6419 with SMTP id ffacd0b85a97d-35e0f25509fmr4554299f8f.8.1717277609843;
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm4751324f8f.23.2024.06.01.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v4 0/2] Clean up usage of rt_task()
Date: Sat,  1 Jun 2024 22:33:07 +0100
Message-Id: <20240601213309.1262206-1-qyousef@layalina.io>
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

Qais Yousef (2):
  sched/rt: Clean up usage of rt_task()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 14 +++++++------
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 35 ++++++++++++++++++++++++++-----
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 57 insertions(+), 29 deletions(-)

-- 
2.34.1


