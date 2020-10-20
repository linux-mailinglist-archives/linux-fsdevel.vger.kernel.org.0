Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBA293FCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436731AbgJTPo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436727AbgJTPo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:44:59 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60ABC061755;
        Tue, 20 Oct 2020 08:44:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so2721165wrq.11;
        Tue, 20 Oct 2020 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBgYFG8ewp8FjuDRc/9ogeevL4i12xB05s0x+Hp/xsw=;
        b=LEdn6Eg1/0ZYM0DaTybF3nD7sC9bpyW0xeYfyGgJzseRYf65TUAkWDN1vv73aW6H+H
         xVcPGd0Wtm0ABZfA8LdBGaYR+lLgKySY/cj9/is4my/llxoV1gEa2fxJKFL8GP8jyhi1
         sVkkwvcVxvQ50FO2fPndqAUtr232xJ4koRdBq5MpuFgCKPqXQtiDadGDkJayrDLhz2sV
         OG7kXecFitHJ8rZZoQFPZjZqx0Bj75w5JtI8QSn60oWVpT25lgrpy+XjU5OU0J45LTIR
         Ax31dp2d85vF3Wj6icmspHBEdRm2SGMzX/08VqDi7pX9EZbBIKjM6bAJk5+82H8kIgB5
         FZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBgYFG8ewp8FjuDRc/9ogeevL4i12xB05s0x+Hp/xsw=;
        b=kdk8OW909xntem7u69ANWE1nDIk1d7ZdyHQegspLwubkNMEA2AaGdHt9MAZKG6JJT/
         f1WU0Oqwa1Gf+eBfH+H3E75Z5LB2dMbqLF3UzKjGIakAyeh9YGjne6W6uylhdnAa/czj
         lPEwHWW3Y+KZp8brr9PcX07OyeUFCvnnU7G0xEwkOlD14yAqy8y3kTRe029c6rFSN0b9
         o74k0cvtoi0enbt8FVsUmAmKGyZ7JefIQDThmZtWUs0ljukIFTA4OL7pk/1gXl33MdNX
         1bcoHxiOC1bqaoVRKxKICZFHQ0vcRPapwNv+dKs3d0zdBR0V8yaJeiMsYbIb7Wp/cNoA
         dQ7g==
X-Gm-Message-State: AOAM530adc7a3c58d+HrVzQKGcVLcYghc+kDA1IJhssJxFYe8tUVSAAz
        7nC8Z72Xo8tTozstZT3pJNg=
X-Google-Smtp-Source: ABdhPJwAAJtsA7Ru071qpDqpkrZsiYH2XnRzpfAMyQ8oivkOUcayQ4kIVuVNf8wBj+piL5b+Pz/nXw==
X-Received: by 2002:adf:8290:: with SMTP id 16mr4511202wrc.103.1603208697353;
        Tue, 20 Oct 2020 08:44:57 -0700 (PDT)
Received: from stormsend.lip6.fr (dell-redha.rsr.lip6.fr. [132.227.76.3])
        by smtp.googlemail.com with ESMTPSA id y21sm3070464wma.19.2020.10.20.08.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:44:56 -0700 (PDT)
From:   Redha Gouicem <redha.gouicem@gmail.com>
Cc:     julien.sopena@lip6.fr, julia.lawall@inria.fr,
        gilles.muller@inria.fr, carverdamien@gmail.com,
        jean-pierre.lozi@oracle.com, baptiste.lepers@sydney.edu.au,
        nicolas.palix@univ-grenoble-alpes.fr,
        willy.zwaenepoel@sydney.edu.au,
        Redha Gouicem <redha.gouicem@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Ignatov <rdna@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/3] sched: delayed thread migration
Date:   Tue, 20 Oct 2020 17:44:38 +0200
Message-Id: <20201020154445.119701-1-redha.gouicem@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series proposes a tweak in the thread placement strategy of CFS
to make a better use of cores running at a high frequency. It is the result
of a published work at ATC'20, available here:
https://www.usenix.org/conference/atc20/presentation/gouicern

We address the frequency inversion problem that stems from new DVFS
capabilities of CPUs where frequency can be different among cores of the
same chip. On applications with a large number of fork/wait patterns, we
see that CFS tends to place new threads on idle cores running at a low
frequency, while cores where the parent is running are at a high frequency
and become idle immediately after. This means that a low frequency core is
used while a high frequency core becomes idle. A more detailed analysis of
this behavior is available in the paper but here is small example with 2
cores c0 and c1 and 2 threads A and B.

Legend: - means high frequency
        . means low frequency
	  nothing means nothing is running.

c0:   A------fork()-wait()
                  \
c1:                B................--------

c0 becomes idle while at a high frequency and c1 becomes busy and executes
B at a low frequency for a long time.

The fix we propose is to delay the migration of threads in order to
see if the parent's core can be used quickly before using another core.
When choosing a core to place a new or waking up thread (in
select_task_rq_fair()), we check if the destination core is idle or busy
frequency-wise. If it is busy, we keep the current behavior and move the
thread to this new core. If it is idle, we place the thread locally
(parent's core on fork, waker's core on wakeup). We also arm a
high-resolution timer that will trigger a migration of this thread to the
new core chosen by the original algorithm of CFS. If the thread is able to
run quickly on the local core, we cancel the timer (e.g. the parent thread
calls the wait() syscall). Else, the thread will be moved to the core
decided by CFS and run quickly. When the parent thread waits, the previous
example becomes:

c0:   A------fork()-wait()-B---------------
                  \/
c1:

If the parent thread keeps running, the example becomes:

c0:   A------fork()---------timer------------
                  \/           \
c1:                             B.............--------

In the first case, we use a high frequency core (c0) and let c1 be idle. In
the second case, we loose a few us of execution time for B.

There are two configurable parameters in this patch:
     - the frequency threshold above which we consider a core busy
       frequency-wise. By default, the threshold is set to 0, which
       disables the delayed migrations. On our test server (an Intel Xeon
       E7-8870 v4), an efficient value was the minimal frequency of the
       CPU. On another test machine (AMD Ryzen 5 3400G), it was a frequency
       a little bit higher than the minimal one.
     - the delay of the high-resolution timer. We choose a default value of
       50 us since it is the mean delay we observed between a fork and a
       wait during a kernel build.
Both parameters can be modified through files in /proc/sys/kernel/. Since
this is kind of work in progress, we are still looking to find better ways
to choose the best threshold and delay, as both values probably depend on
the machine.

In terms of performance, we benchmarked 60 applications on a 5.4 kernel at
the time of the paper's publication. The detailed results are available in
the paper but overall, we improve the performance of 23 applications, with
a best improvement of 56%. Only 3 applications suffer large performance
degradations (more than 5%), but the degradation is "small" (at most 8%).
We also think there might be energy savings since we try to avoid waking
idle cores. We did see small improvements on our machines, but nothing as
good as in terms of performance (at most 5% improvement).

On the current development kernel (on the sched/core branch, commit
f166b111e049), we run a few of these benchmarks to confirm our results on
an up-to-date kernel. We run the build of the kernel (complete and
scheduler only), hackbench, 2 applications from the NAS benchmark suite and
openssl. We select these applications because they had either very good or
very bad results on the 5.4 kernel. We present the mean of 10 runs, with
the powersave scaling governor and the intel_pstate driver in active mode.

 Benchmark    | unit | 5.9-f166b111e049 |          patched
 -------------+------+------------------+------------------
			LOWER IS BETTER
 -------------+------+------------------+------------------
 hackbench    |    s |            5.661 |    5.612 (- 0.9%)
 kbuild-sched |    s |            7.370 |    6.309 (-14.4%)
 kbuild       |    s |           34.798 |   34.788 (- 0.0%)
 nas_ft.C     |    s |           10.080 |   10.012 (- 0.7%)
 nas_sp.B     |    s |            6.653 |    7.033 (+ 5.7%)
 -------------+------+------------------+------------------
 			HIGHER IS BETTER
 -------------+------+------------------+------------------
 openssl      |sign/s|         15086.89 | 15071.08 (- 0.1%)

On this small subset, the only application negatively impacted application
is an HPC workload, so it is less of a problem since HPC people usually
bypass the scheduler altogether. We still have a large beneficial impact on
the scheduler build that proeminently has the fork/wait pattern and
frequency inversions.



The first patch of the series is not specific to scheduling. It allows us
(or anyone else) to use the cpufreq infrastructure at a different sampling
rate without compromising the cpufreq subsystem and applications that
depend on it.

The main idea behind this patch series is to bring to light the frequency
inversion problem that will become more and more prominent with new CPUs
that feature per-core DVFS. The solution proposed is a first idea for
solving this problem that still needs to be tested across more CPUs and
with more applications.


Redha Gouicem (3):
  cpufreq: x86: allow external frequency measures
  sched: core: x86: query frequency at each tick
  sched/fair: delay thread migration on fork/wakeup/exec

 arch/x86/kernel/cpu/aperfmperf.c | 31 ++++++++++++++++++++---
 drivers/cpufreq/cpufreq.c        |  5 ++++
 include/linux/cpufreq.h          |  1 +
 include/linux/sched.h            |  4 +++
 include/linux/sched/sysctl.h     |  3 +++
 kernel/sched/core.c              | 43 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c              | 42 ++++++++++++++++++++++++++++++-
 kernel/sched/sched.h             |  7 ++++++
 kernel/sysctl.c                  | 14 +++++++++++
 9 files changed, 145 insertions(+), 5 deletions(-)

-- 
2.28.0

