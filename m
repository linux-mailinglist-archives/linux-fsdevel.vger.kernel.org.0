Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CD3156CD6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 23:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBIWY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 17:24:58 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgBIWY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:24:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so5226558wru.3;
        Sun, 09 Feb 2020 14:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZloK1j3KMcViPM0mYOaGXZdok5Mk5NKREkeyN+dthg=;
        b=Q+iL70qiKnki6EtstCEFLEjn3sIHYW59r/9AifmuMLS6FttS5MPoj5U2a2bXgeRhki
         zDkdsNUSVLgjtqonq23fDB0fyHvg5wOV4yeleFaVwJQ3cpiYEpNbemMyeY7hMCTsuNcR
         pDmiBH9aBER7zoeD0dqRr4DUhV0U8MQHgga51ZRbYIWwStJl5zNGNjHNRa1o1GRR0eI1
         RerRY402pMjqrGezmyIg6UsAKOVW+uaXvJCuwEaUzUJMFoEEU1zifqvbXm4LvvBGARO2
         oIgmbyTMybVTXtHK9/GE1evj+tyOIyxXMVcB6dUUfSFG9FOxomRT76NamJsbLs+ojV9s
         yqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZloK1j3KMcViPM0mYOaGXZdok5Mk5NKREkeyN+dthg=;
        b=lm3yKqcLT8DaB+kZ/uAJkkpZwpWVowHn+7+frzpf/dPMDLgmvJhYx77yy74KIew9Nr
         5tv0y606XRmzI9rvKRG41gkHOtjU7/rPJ6Tzp+6AAPEaGXXTmbiHnB6XDI9adfzV3ZIT
         moKSHBU8eljsboVjI0p1kdWEENVOuF/pD+zn/jJrsRVvZj3ywcrVxe2AuQbsjrs4dHkg
         /3RibnX6IDjm2vxZEOpRMVXaNMKaYRkTEsIlc3DERaD9Fky4d5jb+bMyQmBTtPnKAeDj
         klhtqeeqFD7R2V093E7UHdHzHbZxmx2Qjlq+AYf4scB3TKVwZN/jPRtcYJJpnNiEjh9B
         0Rpg==
X-Gm-Message-State: APjAAAUT729HFuZJv8ZfB3Lc6dL5w/PSdLQm9BdK6Bg2Oakddgqm5TuM
        YLtg6JoX1yguDSDkn3e6xg==
X-Google-Smtp-Source: APXvYqzytg39AgSq4qdwxPgY78rhWe/R9ylhetCXXb+V4MuhtAn316HrqoTCFOMT/vLNl4u29j4qHA==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr13045738wrv.334.1581287096541;
        Sun, 09 Feb 2020 14:24:56 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id b21sm13421510wmd.37.2020.02.09.14.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:24:56 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        dvyukov@google.com, glider@google.com, aryabinin@virtuozzo.com,
        bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, mgorman@suse.de,
        dvhart@infradead.org, tglx@linutronix.de, namhyung@kernel.org,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        mark.rutland@arm.com, acme@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 00/11] Lock warning cleanup
Date:   Sun,  9 Feb 2020 22:24:42 +0000
Message-Id: <cover.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <0/11>
References: <0/11>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
The adds fix the warnings and give insight on what the functions are actually doing.

1. Within the futex subsystem, a __releases(&pi_state->.pi_mutex.wait_lock) is added because wake_futex_pi() only releases the lock at exit,
must_hold(q->lock_ptr) have been added to fixup_pi_state_owner() because the lock is held at entry and exit;
a __releases(&hb->lock) added to futex_wait_queue_me() as it only releases the lock.

2. Within fs_pin, a __releases(RCU) is added because the function exit RCU critical section at exit.

3. In kasan, an __acquires(&report_lock) has been added to start_report() and   __releases(&report_lock) to end_report() 

4. Within ring_buffer subsystem, a __releases(RCU) has been added perf_output_end() 

5. schedule subsystem recorded an addition of the __releases(rq->lock) annotation and a __must_hold(this_rq->lock)

6. At hrtimer subsystem, __acquires(timer) is added  to lock_hrtimer_base() as the function acquire the lock but never releases it.
Jules Irenge (11):
  hrtimer: Add missing annotation to lock_hrtimer_base()
  futex: Add missing annotation for wake_futex_pi()
  futex: Add missing annotation for fixup_pi_state_owner()
  perf/ring_buffer: Add missing annotation to perf_output_end()
  sched/fair: Add missing annotation for nohz_newidle_balance()
  sched/deadline: Add missing annotation for dl_task_offline_migration()
  fs_pin: Add missing annotation for pin_kill() declaration
  fs_pin: Add missing annotation for pin_kill() definition
  kasan: add missing annotation for start_report()
  kasan: add missing annotation for end_report()
  futex: Add missing annotation for futex_wait_queue_me()

 fs/fs_pin.c                 | 2 +-
 include/linux/fs_pin.h      | 2 +-
 kernel/events/ring_buffer.c | 2 +-
 kernel/futex.c              | 3 +++
 kernel/sched/deadline.c     | 1 +
 kernel/sched/fair.c         | 2 +-
 kernel/time/hrtimer.c       | 1 +
 mm/kasan/report.c           | 4 ++--
 8 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.24.1

