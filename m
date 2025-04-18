Return-Path: <linux-fsdevel+bounces-46680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3ECA93C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF58189A444
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDF921CC4E;
	Fri, 18 Apr 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzJe3yX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC918952C
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998606; cv=none; b=dFuIcOJVQSEPI54aoVG4B+Qy0AqqZJURtCkk0NkINv9KuGfZCYZdLuTGp9rZx4XOrK8tBBdiRDfxNmOOWY7meNl5eebFoq6IGWc2YWQq6Ds8ic5VNhkAKQTA7jelIpAKYGgGgc5wGXzbPfXlwqaW41AT5U1fRrXFKo3IcC5si3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998606; c=relaxed/simple;
	bh=J2Lz0EDBuhAnvIhVI7WuWBYiMB01TvLRzTph4cwRKFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XSQPp+QrHwLyIjzacYbi6lUKsgy5QF7rQ7HwfScptuFNZY7rPxdVErAsDef84sw4OfgcROfN9pl+llyBZK+Ywm9v69LVJ9psA6jLUpyRRiu5EB0RVdHcka2jGMFad1WqprGJglw/K95mOq6nkW0t1wEJYmIddeACTDrY2F9rrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzJe3yX0; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c22c1d5d09so1367195fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Apr 2025 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744998603; x=1745603403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NChENxjYlbY+fearBpat5nnFIT5zlqPLQI15hZf3lPM=;
        b=rzJe3yX0C7w6K9BnrlPj3zwCRnc1vtNfFMpapaxLX0kcyRu21vrQZTZTaskoD58wQc
         7CxiZJcfyOqBfsWX3lQ+JdoYGe3e0pMb/oeYcyoUDRinG0V7Q2RTrwE8LFHJ72gTGcHJ
         pvnuGNxbzcyqrCZtCww2kIFdTBNksQb/T5uokamoU6Svr1LNnpEvTqPYrYCt1VJeBmSt
         vHh4bROW9JUOhmwpm7xs1CgzSmFrUq0j7Emy2IdycdG1P9i/omuA0MRObveQOIneObfC
         9LIvSt99GUg65BLGuP/6KcYJThrewC3t6OnwvZ00JzaTWL1rrpwZENryww7rMIxViMK2
         T28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998603; x=1745603403;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NChENxjYlbY+fearBpat5nnFIT5zlqPLQI15hZf3lPM=;
        b=pEQEnxa6JZzCqpeiCudCgXN5fYc8JitYhyssKQzzQ4j+iGSUpFn0JffLVlnJi+vCJJ
         5x7tf5rq1JocO4NEyECB+NOhwV7QIwU9pWV/JpRHrKC1cCY2bd2oLEfde1ltgzc/Appq
         XDZ2EEmRuqadQK4ICmDqBbp3aCEc0It5eNautk1iyXlrx6ClZqk/BlZDzqtUst5XMeaB
         l7anSEJVVjURnW49Bwe4yHstphI6p/fwb/J0RBg0PWE8/BqQgSY2OErn5e+fFC7JYHqc
         nrsN3CGSje1um+TOlrvgg2sWzi/zKiTLM5WkjG2uVxROLOLvius9ow5K3Zdk6oyyVP/i
         YqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlpafc2aj7/bhIRcRsjvtyrwZIypGMHRHTgqLwx+4hxJhdVj3WoQMjeg0/50O5Iof+zGqChT6i8VotD8MF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5dU2JJZpFsVa2NEbGDIt2aTYciKHon3gyBrmTHEoUKPZ95JF
	lAAeISBFa2O58ISXGQ3uCBjGvHUmxYvgaYhf3pbfSejxKnWpgM1eh666yz3yAaZ7um0hjrqTg5d
	KCw==
X-Google-Smtp-Source: AGHT+IE3aftsn9hfNjPsF8qSwC5r3XHYkK9rjlStJcjhr+jAxmTp8vjQYXiW/ySOAL58Q0hdZgfr9P9bsm4=
X-Received: from oabuz10.prod.google.com ([2002:a05:6870:af8a:b0:29f:d208:6db])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:ef83:b0:2d5:4f4:e24d
 with SMTP id 586e51a60fabf-2d5269799d4mr2188610fac.6.1744998603619; Fri, 18
 Apr 2025 10:50:03 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418174959.1431962-1-surenb@google.com>
Subject: [PATCH v3 0/8] perform /proc/pid/maps read and PROCMAP_QUERY under RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

After a long delay I'm posting next iteration of lockless /proc/pid/maps
reading patchset. Differences from v2 [1]:
- Add a set of tests concurrently modifying address space and checking for
correct reading results;
- Use new mmap_lock_speculate_xxx APIs for concurrent change detection and
retries;
- Add lockless PROCMAP_QUERY execution support;

The new tests are designed to check for any unexpected data tearing while
performing some common address space modifications (vma split, resize and
remap). Even before these changes, reading /proc/pid/maps might have
inconsistent data because the file is read page-by-page with mmap_lock
being dropped between the pages. Such tearing is expected and userspace
is supposed to deal with that possibility. An example of user-visible
inconsistency can be that the same vma is printed twice: once before
it was modified and then after the modifications. For example if vma was
extended, it might be found and reported twice. Whan is not expected is
to see a gap where there should have been a vma both before and after
modification. This patchset increases the chances of such tearing,
therefore it's event more important now to test for unexpected
inconsistencies.

Thanks to Paul McKenney who developed a benchmark to test performance
of concurrent reads and updates, we also have data on performance
benefits:

The test has a pair of processes scanning /proc/PID/maps, and another
process unmapping and remapping 4K pages from a 128MB range of anonymous
memory.  At the end of each 10-second run, the latency of each mmap()
or munmap() operation is measured, and for each run the maximum and mean
latency is printed.  (Yes, the map/unmap process is started first, its
PID is passed to the scanners, and then the map/unmap process waits until
both scanners are running before starting its timed test.  The scanners
keep scanning until the specified /proc/PID/maps file disappears.)
In summary, with stock mm, 78% of the runs had maximum latencies in
excess of 0.5 milliseconds, and with more then half of the runs' latencies
exceeding a full millisecond.  In contrast, 98% of the runs with Suren's
patch series applied had maximum latencies of less than 0.5 milliseconds.
From a median-performance viewpoint, Suren's series also looks good,
with stock mm weighing in at 13 microseconds and Suren's series at 10
microseconds, better than a 20% improvement.

[1] https://lore.kernel.org/all/20240123231014.3801041-1-surenb@google.com/

Suren Baghdasaryan (8):
  selftests/proc: add /proc/pid/maps tearing from vma split test
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    resizing
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    remapping
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  selftests/proc: add verbose more for tests to facilitate debugging
  mm: make vm_area_struct anon_name field RCU-safe
  mm/maps: read proc/pid/maps under RCU
  mm/maps: execute PROCMAP_QUERY ioctl under RCU

 fs/proc/internal.h                         |   6 +
 fs/proc/task_mmu.c                         | 233 +++++-
 include/linux/mm_inline.h                  |  28 +-
 include/linux/mm_types.h                   |   3 +-
 mm/madvise.c                               |  30 +-
 tools/testing/selftests/proc/proc-pid-vm.c | 793 ++++++++++++++++++++-
 6 files changed, 1061 insertions(+), 32 deletions(-)


base-commit: 79f35c4125a9a3fd98efeed4cce1cd7ce5311a44
-- 
2.49.0.805.g082f7c87e0-goog


