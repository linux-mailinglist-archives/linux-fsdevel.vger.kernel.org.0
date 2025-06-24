Return-Path: <linux-fsdevel+bounces-52800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49955AE6FA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 21:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AC93A2C3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52702E7F2D;
	Tue, 24 Jun 2025 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3IeHmRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E526AAB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750793645; cv=none; b=jPbtWs1atrLThuNCF6vpyI+GDsjezLfKUersTm5+lP8p3vttAS5OJu5x8ETWoE+occqfc9zP2+2pYyiJkPGIN8SuY8NgtDcM3s6M2BLjX8XY7S5bWgMGColipD860HUn7WnkkHyt0+H127t1hEYa1Goyk7mCSW3IhVenw4eqnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750793645; c=relaxed/simple;
	bh=cxr1XUiQs7Dk7yW16dKgHZCbB9KXVCzrVN86qYM55tk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fRoOUxwZ/i6A0e0lVWP8Oa1NZ/Wijk6pvF5G8GHQ4voRXoqbpjNF3PAK5u3fJAphrAzbeb37Ct5hJJ8JXq4FJti+Yw1SICAuyAciRcnYU4vXBINE+VsTyeljZLBuSPCYEfjSrzeYsWRQcA8wvIfCDTpo8PJKTnEu3dpd8tkluLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3IeHmRv; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso760109b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750793642; x=1751398442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAfF+mMc1XNl8c+YVTYgvfkcW5XUc9MqdxvqcD7TAp8=;
        b=a3IeHmRvccJkfdUiBL2dqx1bdxwjyL1n7GmoCn7J9DT7yH+8UBYuN96Gj4hlO6MMMs
         YTNb7b5ho66d/DY/U1HoFdDQjGCenJfuE6JnDGConXSErXIt6Viyl2KyNpw4PYoy4zec
         knuFtyxVlZAz1eCcKlAznSsFzM9jIL//mG9ITmFlo4j4a2eXE99lozaeBpjvqfRwikNb
         1XZV0L+hysQ//nhRk/YsTBhj2Ax8JvIZdZocwoA5XM8BlPZZh7sqEtOqROUNOJBrhZK9
         kZHDTAcKpaEE6YFve07C5cRcA/wa8m6QcAEwRm4bPLAUDbagciKyRdRf1IYk+KhWlwKl
         r3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750793642; x=1751398442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAfF+mMc1XNl8c+YVTYgvfkcW5XUc9MqdxvqcD7TAp8=;
        b=fyNeBZJWvg+G+xL/8k9z5C7ZRA6oIC5cgi8AUf1EyTrZHpGAJDwKhFSoZMwTYPlb76
         yt8iUsn0nIbTb2WuzKAt+47tgPBux40sfckBmsacLkyXNrVnIyJAzOynFQ05sB7OM8i0
         cpn5T+tDcrf99wrcgCeaLLxNS2y6rfeQahVoDkk8oXL7d+AkuSOLXqSDZ1ci/aN9v1Yb
         DhqWro2IXX41ok8jWsP3xQFz8R8U28dD4IxvOGSyvgEhBwhj0Xw9yH0Hj8d1rmqYAcr6
         OepmiTMkpboQhkTmT8L5RE+xwCum4c/XxASR7n6tvr6gMcgdnK3ldR/tN+WYvvoNKIU3
         3Teg==
X-Forwarded-Encrypted: i=1; AJvYcCXKJxd/XLsZXNa1qEj1+1vUhTguHr1mSfJFa+/fvtVUxXQIpv5ln1BihXMjfEtuzg56SEPwab8MyWuiBhzo@vger.kernel.org
X-Gm-Message-State: AOJu0YxbznBmlBBKwVgNnE1TgorS1EKeHF6fRy0VncrKoJLwy5SStZAk
	KxW5QBhCIBhzJlsl1djXxwhnZtQCfQ+B2uhKKX6JQDDFcLwClHyMzG7SD12/iqtZlBzFNVOvtVR
	gyyNIyw==
X-Google-Smtp-Source: AGHT+IESPNWdUFvkJLMcSh5tmTSGQQDEpRowdisdAiY1tiikGkyPK41qKhmKqgqXISv7VzDDl5GwYzdl9gY=
X-Received: from pfrb8.prod.google.com ([2002:aa7:8ec8:0:b0:746:32ae:99d5])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3399:b0:21f:7430:148a
 with SMTP id adf61e73a8af0-2207f2858c1mr238077637.28.1750793642586; Tue, 24
 Jun 2025 12:34:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:33:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624193359.3865351-1-surenb@google.com>
Subject: [PATCH v5 0/7] use per-vma locks for /proc/pid/maps reads and PROCMAP_QUERY
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, surenb@google.com
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
to contend for the same vma as opposed to the entire address space. Same
is done for PROCMAP_QUERY ioctl which locks only the vma that fell into
the requested range instead of the entire address space. Previous version
of this patchset [1] tried to perform /proc/pid/maps reading under RCU,
however its implementation is quite complex and the results are worse than
the new version because it still relied on mmap_lock speculation which
retries if any part of the address space gets modified. New implementaion
is both simpler and results in less contention. Note that similar approach
would not work for /proc/pid/smaps reading as it also walks the page table
and that's not RCU-safe.

Paul McKenney's designed a test [2] to measure mmap/munmap latencies while
concurrently reading /proc/pid/maps. The test has a pair of processes
scanning /proc/PID/maps, and another process unmapping and remapping 4K
pages from a 128MB range of anonymous memory.  At the end of each 10
second run, the latency of each mmap() or munmap() operation is measured,
and for each run the maximum and mean latency is printed. The map/unmap
process is started first, its PID is passed to the scanners, and then the
map/unmap process waits until both scanners are running before starting
its timed test.  The scanners keep scanning until the specified
/proc/PID/maps file disappears. This test registered close to 10x
improvement in update latencies:

Before the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.011     0.008     0.455
    0.011     0.008     0.472
    0.011     0.008     0.535
    0.011     0.009     0.545
    ...
    0.011     0.014     2.875
    0.011     0.014     2.913
    0.011     0.014     3.007
    0.011     0.015     3.018

After the change:
./run-proc-vs-map.sh --nsamples 100 --rawdata -- --busyduration 2
    0.006     0.005     0.036
    0.006     0.005     0.039
    0.006     0.005     0.039
    0.006     0.005     0.039
    ...
    0.006     0.006     0.403
    0.006     0.006     0.474
    0.006     0.006     0.479
    0.006     0.006     0.498

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

Changes from v4 [4]:
- refactored trylock_vma() and other locking parts into mmap_lock.c, per
Lorenzo
- renamed {lock|unlock}_content() into {lock|unlock}_vma_range(), per
Lorenzo
- added clarifying comments for sentinels, per Lorenzo
- introduced is_sentinel_pos() helper function
- fixed position reset logic when last_addr is a sentinel, per Lorenzo
- added Acked-by to the last patch, per Andrii Nakryiko

[1] https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/
[2] https://github.com/paulmckrcu/proc-mmap_sem-test
[3] https://lore.kernel.org/all/e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local/
[4] https://lore.kernel.org/all/20250604231151.799834-1-surenb@google.com/

Suren Baghdasaryan (7):
  selftests/proc: add /proc/pid/maps tearing from vma split test
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    resizing
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    remapping
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  selftests/proc: add verbose more for tests to facilitate debugging
  mm/maps: read proc/pid/maps under per-vma lock
  mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                         |   5 +
 fs/proc/task_mmu.c                         | 179 ++++-
 include/linux/mmap_lock.h                  |  11 +
 mm/mmap_lock.c                             |  88 +++
 tools/testing/selftests/proc/proc-pid-vm.c | 793 ++++++++++++++++++++-
 5 files changed, 1053 insertions(+), 23 deletions(-)


base-commit: 0b2a863368fb0cf674b40925c55dc8898c5a33af
-- 
2.50.0.714.g196bf9f422-goog


