Return-Path: <linux-fsdevel+bounces-55511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F91B0B157
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 20:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18E6563972
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47149289352;
	Sat, 19 Jul 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQUUUtNT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93A288C0A
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949739; cv=none; b=CPju6zKNF7HszVB+S1Wkk2JX8q+39d1koXDg2s8s4dgZzpTyHxfRYkTuVWFLLqfapKUy8l+95Tnw9/GT5U0DJbekPwjfBcE+7NluJmaDjTzvlMAPtAf19dG7JDwjMg3+x7SLn/U9cciRVp890xYU1QALq0fnV76nQGkNrJGzfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949739; c=relaxed/simple;
	bh=4eqfbzwTRiWOdlSaFW6JIpPIbctEpx/139iEQZ8sh8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wekb3p38evFhYZhHe+v9LHlihMaTWVKpzCyxG08z4hpr+ep+9+Breb3Xa95+SGj5Y6h64ZAQmsdJbnNSi9T4uuVIn7zsfUAlh37+mo+btKZksuJbnIFj1pkrVL5ZXSQ7CsuTqYYD36pB2UDg/11w56lQisycgXb/einKep5Bt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQUUUtNT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce55d33so51709505ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752949737; x=1753554537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xEd/u+2IpZE3HiQH1JMDxFxVYywITI5/mdS+tdMrMQ=;
        b=HQUUUtNTpsBM3qs8m1BPNr3USA4yjR75n4dJPqN+Lr2IWKQaT/XcThyBNJQA8k58fE
         P5bOLV4hin4Gk1uTvRO/RyUIAWriidmcNi2PLMw89lGcw9ORIac/GKWfZ3VNccAW+goL
         Huu/6YNoZ5tGvLlvBqrl8SmSvls5CYd6kAQIX2F2quKeBgZA9EAR9RvOZy47CTfwltd3
         /7QNg85qeB4D1QKjzi/Ct8B1svpgNyfxKyTfHSmuW9QEyBI6jBMWBxRArjc21IzVQOW2
         2eFYTagOuX4XlVL3oFWNmLZOaG3DBZNQlsBh+rJruK8s9sK7cwXgqZdEtsZxDvqpJZhu
         tFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752949737; x=1753554537;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xEd/u+2IpZE3HiQH1JMDxFxVYywITI5/mdS+tdMrMQ=;
        b=sz4BN21S/fvqQyUh5NAUqAtn0m01m8B7hZhapsOv8x7rP9e84MGGLWGhSTP7JbYZUy
         E+NZw+xV9j/FgoLzaMipm3c42cwYl9fD7UljgSWcThetr2biRvAHSu5tWZHj7hoZBRrw
         aQ2PT3p+29k3qAEvTfeE8JuslZ8HXgQ1GwB0SiWmN/UBG6pr4QInLMO/OXQmoI9dLjN4
         UDkCw0y2Frns2WGjNpwj1kenDbretvFoFEPXqeWAxvURlBW/d+67i2P9VBib7naZeSiI
         JunCvIZZbCY8OFt5lX1b/p0ZRZcAyuOc4T3g1LeRsKwMK5fqwIJHWWX21EveZcrQPHzM
         P9nw==
X-Forwarded-Encrypted: i=1; AJvYcCXBdN+8cakfF+ofRPuYmlfUgJkgshdSvb4esG57HZ6lfLwCG5ASnV8GfpvcbC0OeLKy8ld69NJLgjFi8aeu@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxGH+qUted47iA/ppGIvmOArDCTLxgrqyyzXj/um3YUSThb3i
	osTE7kV8Dx4yA7NOs2lKrlYGRx6O5R1CmVYXOOXON+giLb2DRpHkkcc+ZIdt3WCgATmjUboQeZD
	TZemBRQ==
X-Google-Smtp-Source: AGHT+IEo3zTyfmVqhcB5gfo8/UAHWAF5v2Oo3REY86B4jZzhZ39jSaM2c98Ey7dPLGRgT7CVz0wCfqx2UBI=
X-Received: from plhq4.prod.google.com ([2002:a17:903:11c4:b0:231:def0:d268])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1447:b0:238:120:134a
 with SMTP id d9443c01a7336-23e302cad77mr178702025ad.22.1752949737334; Sat, 19
 Jul 2025 11:28:57 -0700 (PDT)
Date: Sat, 19 Jul 2025 11:28:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250719182854.3166724-1-surenb@google.com>
Subject: [PATCH v8 0/6] use per-vma locks for /proc/pid/maps reads
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Reading /proc/pid/maps requires read-locking mmap_lock which prevents any
other task from concurrently modifying the address space. This guarantees
coherent reporting of virtual address ranges, however it can block
important updates from happening. Oftentimes /proc/pid/maps readers are
low priority monitoring tasks and them blocking high priority tasks
results in priority inversion.

Locking the entire address space is required to present fully coherent
picture of the address space, however even current implementation does not
strictly guarantee that by outputting vmas in page-size chunks and
dropping mmap_lock in between each chunk. Address space modifications are
possible while mmap_lock is dropped and userspace reading the content is
expected to deal with possible concurrent address space modifications.
Considering these relaxed rules, holding mmap_lock is not strictly needed
as long as we can guarantee that a concurrently modified vma is reported
either in its original form or after it was modified.

This patchset switches from holding mmap_lock while reading /proc/pid/maps
to taking per-vma locks as we walk the vma tree. This reduces the
contention with tasks modifying the address space because they would have
to contend for the same vma as opposed to the entire address space.
Previous version of this patchset [1] tried to perform /proc/pid/maps
reading under RCU, however its implementation is quite complex and the
results are worse than the new version because it still relied on
mmap_lock speculation which retries if any part of the address space gets
modified. New implementaion is both simpler and results in less
contention. Note that similar approach would not work for /proc/pid/smaps
reading as it also walks the page table and that's not RCU-safe.

Paul McKenney's designed a test [2] to measure mmap/munmap latencies while
concurrently reading /proc/pid/maps. The test has a pair of processes
scanning /proc/PID/maps, and another process unmapping and remapping 4K
pages from a 128MB range of anonymous memory.  At the end of each 10
second run, the latency of each mmap() or munmap() operation is measured,
and for each run the maximum and mean latency is printed. The map/unmap
process is started first, its PID is passed to the scanners, and then the
map/unmap process waits until both scanners are running before starting
its timed test.  The scanners keep scanning until the specified
/proc/PID/maps file disappears.

The latest results from Paul:
Stock mm-unstable, all of the runs had maximum latencies in excess of
0.5 milliseconds, and with 80% of the runs' latencies exceeding a full
millisecond, and ranging up beyond 4 full milliseconds.  In contrast,
99% of the runs with this patch series applied had maximum latencies
of less than 0.5 milliseconds, with the single outlier at only 0.608
milliseconds.

From a median-performance (as opposed to maximum-latency) viewpoint,
this patch series also looks good, with stock mm weighing in at 11
microseconds and patch series at 6 microseconds, better than a 2x
improvement.

Before the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.011     0.008     0.521
    0.011     0.008     0.552
    0.011     0.008     0.590
    0.011     0.008     0.660
    ...
    0.011     0.015     2.987
    0.011     0.015     3.038
    0.011     0.016     3.431
    0.011     0.016     4.707

After the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.006     0.005     0.026
    0.006     0.005     0.029
    0.006     0.005     0.034
    0.006     0.005     0.035
    ...
    0.006     0.006     0.421
    0.006     0.006     0.423
    0.006     0.006     0.439
    0.006     0.006     0.608

The patchset also adds a number of tests to check for /proc/pid/maps data
coherency. They are designed to detect any unexpected data tearing while
performing some common address space modifications (vma split, resize and
remap). Even before these changes, reading /proc/pid/maps might have
inconsistent data because the file is read page-by-page with mmap_lock
being dropped between the pages. An example of user-visible inconsistency
can be that the same vma is printed twice: once before it was modified and
then after the modifications. For example if vma was extended, it might be
found and reported twice. What is not expected is to see a gap where there
should have been a vma both before and after modification. This patchset
increases the chances of such tearing, therefore it's even more important
now to test for unexpected inconsistencies.

In [3] Lorenzo identified the following possible vma merging/splitting
scenarios:

Merges with changes to existing vmas:
1 Merge both - mapping a vma over another one and between two vmas which
can be merged after this replacement;
2. Merge left full - mapping a vma at the end of an existing one and
completely over its right neighbor;
3. Merge left partial - mapping a vma at the end of an existing one and
partially over its right neighbor;
4. Merge right full - mapping a vma before the start of an existing one
and completely over its left neighbor;
5. Merge right partial - mapping a vma before the start of an existing one
and partially over its left neighbor;

Merges without changes to existing vmas:
6. Merge both - mapping a vma into a gap between two vmas which can be
merged after the insertion;
7. Merge left - mapping a vma at the end of an existing one;
8. Merge right - mapping a vma before the start end of an existing one;

Splits
9. Split with new vma at the lower address;
10. Split with new vma at the higher address;

If such merges or splits happen concurrently with the /proc/maps reading
we might report a vma twice, once before the modification and once after
it is modified:

Case 1 might report overwritten and previous vma along with the final
merged vma;
Case 2 might report previous and the final merged vma;
Case 3 might cause us to retry once we detect the temporary gap caused by
shrinking of the right neighbor;
Case 4 might report overritten and the final merged vma;
Case 5 might cause us to retry once we detect the temporary gap caused by
shrinking of the left neighbor;
Case 6 might report previous vma and the gap along with the final marged
vma;
Case 7 might report previous and the final merged vma;
Case 8 might report the original gap and the final merged vma covering the
gap;
Case 9 might cause us to retry once we detect the temporary gap caused by
shrinking of the original vma at the vma start;
Case 10 might cause us to retry once we detect the temporary gap caused by
shrinking of the original vma at the vma end;

In all these cases the retry mechanism prevents us from reporting possible
temporary gaps.

Changes since v7 [4]:
- Refactored tests to use kselftest harness, per David Hildenbrand and
Lorenzo Stoakes
- Removed PROCMAP_QUERY selftest, per David Hildenbrand and
Lorenzo Stoakes
- Added Acked-by, per David Hildenbrand
- Replaced sentinels values with named definitions, per Vlastimil Babka
- Added Reviewed-by, per Vlastimil Babka

!!! NOTES FOR APPLYING THE PATCHSET !!!

Applies cleanly over mm-unstable after reverting v7 version of this
patchset (from 94951ab6fe6f to e47914e6c28f in mm-unstable).

[1] https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/
[2] https://github.com/paulmckrcu/proc-mmap_sem-test
[3] https://lore.kernel.org/all/e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local/
[4] https://lore.kernel.org/all/20250716030557.1547501-1-surenb@google.com/

Suren Baghdasaryan (6):
  selftests/proc: add /proc/pid/maps tearing from vma split test
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    resizing
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    remapping
  selftests/proc: add verbose mode for /proc/pid/maps tearing tests
  fs/proc/task_mmu: remove conversion of seq_file position to unsigned
  fs/proc/task_mmu: read proc/pid/maps under per-vma lock

 fs/proc/internal.h                            |   5 +
 fs/proc/task_mmu.c                            | 158 +++-
 include/linux/mmap_lock.h                     |  11 +
 mm/madvise.c                                  |   3 +-
 mm/mmap_lock.c                                |  93 +++
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 tools/testing/selftests/proc/proc-maps-race.c | 741 ++++++++++++++++++
 8 files changed, 997 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-maps-race.c

-- 
2.50.0.727.gbf7dc18ff4-goog


