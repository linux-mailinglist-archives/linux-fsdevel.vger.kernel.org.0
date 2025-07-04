Return-Path: <linux-fsdevel+bounces-53885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C0AF879A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5ECE561DD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC0223704;
	Fri,  4 Jul 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ku6U8Nbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2321B9D6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609254; cv=none; b=Ox9RxKloE7AeDlgpnw/aJ8Q6ibsyreMkBL4wKeuo6fttquHKK0UvunA+C6RiVtmVirGhJ31kP7Ulzr42L0/GEqKET6lFbv6CrcBiAJqsH68TLaNlgFGSPO3VtK+SfWryJvWK65ns53X/7UT59O8B9L3sufPbqLGz6SXttdgfb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609254; c=relaxed/simple;
	bh=num7ZwJGxm2xcwzgmExP91PNehpZ10zz5brwKdCfm2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FTwFjfmNMrTZQcVI+e/xHfErj4uxtxv2zR6A4ABGyctPj2qYPo+nV7YyHvpC/VznxaYeVqd7eDca39opZ8boVybc3I8dd9jTc67ob/+70uzC8G4zQIQDid9K2epAwPprQsUj3zKJxaIIeO3aqZvz4eJxoR/L7G5z8xv8tVSBNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ku6U8Nbh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74927be2ec0so1069117b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jul 2025 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751609251; x=1752214051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZEckqv9KvWhwhlMKe66GULnS7cfmA5oovNSgnKfWkgg=;
        b=Ku6U8NbhocuLryxZx7e8eSojI9A0Yhjfq/trr3pXNvKIdbg5yV9MuC0NlYDhSXG50x
         IFlwVtsR1Ga0VtJIdrMWi3QBT9gF2pw4pgRDVGtSRMaTvjTeDYCreF8JuMJq7K4D6mPm
         UgXVGNnI8SxEBM0xSBFHLX8iE5KH+ixhIKV2MLxW5LuL8mtjakYPdn9n9sulie+YHNvf
         LZEqygr1Boo4RBvtBGY/nh1t+Q9xgz7cUX9gWDY4qSAnJyTcZQ5RkZeHaEYX1cU9napK
         iv9N/scn+DWXMUOczQ4o6F2xx/4h9wDOvFZ0gjbE8D5WdKjwJEcgV83m2alMkBPJOhJv
         pzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751609251; x=1752214051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEckqv9KvWhwhlMKe66GULnS7cfmA5oovNSgnKfWkgg=;
        b=A2MNvkcPi18gTjK4iz51k7gAzK301t1ADnyjY/4rlGXw3hza80lv8GD3ijWXfIEbxR
         ar1gtWNfXQ/6jYyEVo5zPJxxsTkpxvc2IH8Omq+KraQqvC9Y+SRYni9criDAH7Cuk5QA
         4t62wE/B96Ri8kQkyiZmxVpsJ5bmSVM8iTiUB9UN0KhCdFkpxQec3NOLTcaMeA5MO8eZ
         rxqtjZZoAm7mabh7Voaqo0iLFZt7UH64vVGBxX4T24Dm293SvS4y81XGd0iQrL8PEa4v
         xkYaLyX0NqJ0MTFNjlI2p/pohpC5nIg5y/zLegT2pN47k9/X4sKgMRBoqCFciAA457xB
         kViw==
X-Forwarded-Encrypted: i=1; AJvYcCUvlYRjMgB6q4RM4cp/MXs/5MfjoGTRpyrHX1AmGdHIM6iJX0c7xJQglFqLNbHTZcSZPqv8ZApnA4sxspmC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+4hZxQaW8Mfq94fDPuVYWSy7wqrUJimKM7EVFhqt/+5W3VSs
	R8HcBi46dAF7WplRx5j/bAizUucNV4v11poZ/vQgWxnmR6BGnhEBW1M2H7HXmrdxraeHjNFd+hK
	03F3o4A==
X-Google-Smtp-Source: AGHT+IFG67ZnYijnEmrANJ862qby4lfyUrmXgaBAHJy2D7Sq0PQ1+KEFSXZY6Nd+epUGRR6aiPOLz1kauiE=
X-Received: from pfbhs5.prod.google.com ([2002:a05:6a00:6905:b0:747:af58:72ca])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84c:b0:748:2d1d:f7b7
 with SMTP id d2e1a72fcca58-74ce8af2ae5mr1489520b3a.21.1751609250767; Thu, 03
 Jul 2025 23:07:30 -0700 (PDT)
Date: Thu,  3 Jul 2025 23:07:18 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250704060727.724817-1-surenb@google.com>
Subject: [PATCH v6 0/8] use per-vma locks for /proc/pid/maps reads and PROCMAP_QUERY
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

Changes since v5 [4]:
- Made /proc/pid/maps tearing test a separate selftest,
per Alexey Dobriyan
- Changed asserts with or'ed conditions into separate ones,
per Alexey Dobriyan
- Added a small cleanup patch [6/8] to avoid unnecessary seq_file position
type casting
- Removed unnecessary is_sentinel_pos() helper
- Changed titles to use fs/proc/task_mmu instead of mm/maps prefix,
per David Hildenbrand
- Included Lorenzo's fix for mmap lock assertion in anon_vma_name()
- Reworked the last patch to avoid allocation in the rcu read section,
which replaces Jeongjun Park's fix

!!! NOTES FOR APPLYING THE PATCHSET !!!

Applies cleanly over mm-unstable after reverting old version with fixes.
The following patches should be reverted before applyng this patchset:

b33ce1be8a40 ("selftests/proc: add /proc/pid/maps tearing from vma split test")
b538e0580fd6 ("selftests/proc: extend /proc/pid/maps tearing test to include vma resizing")
4996b4409cc6 ("selftests/proc: extend /proc/pid/maps tearing test to include vma remapping")
c39471f78d5e ("selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently modified")
487570f548f3 ("selftests/proc: add verbose more for tests to facilitate debugging")
e1ba4969cba1 ("mm/maps: read proc/pid/maps under per-vma lock")
ecb110179e77 ("mm/madvise: fixup stray mmap lock assert in anon_vma_name()")
6772c457a865 ("fs/proc/task_mmu:: execute PROCMAP_QUERY ioctl under per-vma locks")
d5c67bb2c5fb ("mm/maps: move kmalloc() call location in do_procmap_query() out of RCU critical section")

[1] https://lore.kernel.org/all/20250418174959.1431962-1-surenb@google.com/
[2] https://github.com/paulmckrcu/proc-mmap_sem-test
[3] https://lore.kernel.org/all/e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local/
[4] https://lore.kernel.org/all/20250624193359.3865351-1-surenb@google.com/

Suren Baghdasaryan (8):
  selftests/proc: add /proc/pid/maps tearing from vma split test
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    resizing
  selftests/proc: extend /proc/pid/maps tearing test to include vma
    remapping
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  selftests/proc: add verbose more for tests to facilitate debugging
  fs/proc/task_mmu: remove conversion of seq_file position to unsigned
  fs/proc/task_mmu: read proc/pid/maps under per-vma lock
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |   5 +
 fs/proc/task_mmu.c                            | 188 +++-
 include/linux/mmap_lock.h                     |  11 +
 mm/madvise.c                                  |   3 +-
 mm/mmap_lock.c                                |  88 ++
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 tools/testing/selftests/proc/proc-maps-race.c | 829 ++++++++++++++++++
 8 files changed, 1098 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-maps-race.c

-- 
2.50.0.727.gbf7dc18ff4-goog


