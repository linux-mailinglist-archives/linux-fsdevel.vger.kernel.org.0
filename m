Return-Path: <linux-fsdevel+bounces-20997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677DE8FC0A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B1286310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA7C13174B;
	Wed,  5 Jun 2024 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0VFPNx5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA5138493;
	Wed,  5 Jun 2024 00:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547111; cv=none; b=UgTCaCvq8lI5uteuxj3na+/wSEV88p7T3R/jJ6Dk6zCXxtMVFXvVRVSR2F6dRfCRkApC8Pf88t7QfFZCSBz3ckV38hGgoPgR1+i00fk0Z2kKYVEd6F3b1THssG0/FWN6xRBUeQiBmufjU8pHbYaEX7ndQ37BBCfvVEedt429sJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547111; c=relaxed/simple;
	bh=xlav2H8FcbF2kBE50cB92+/q2AIJRTGhHwZ10uAGAG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TaPa6igVFvitFYsgGaUw8lBoU4e39Px8T+u61GJklD6CK7tJLn/hrGGUCzBUH6CHZqFYzplM31PNekIAMI5TniPUhi4fjK2Jai9JA0S+lwJNe/SE4wENEUcYhcidJUpDJ1g2bc3+IpgfmYR5qhjIoivKtsXL52Hqzea9/My9ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0VFPNx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98006C2BBFC;
	Wed,  5 Jun 2024 00:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547110;
	bh=xlav2H8FcbF2kBE50cB92+/q2AIJRTGhHwZ10uAGAG4=;
	h=From:To:Cc:Subject:Date:From;
	b=o0VFPNx5uU8IvyuM4VjLdFP0pBiJkpaqKiPk7LGlgG8wGJmNbNlADStRApdQww/DO
	 QK3lw5/LKaWhPh4T+pV9+FChvxknLFEF3xY0jOJJBTkGV6rWnZfG+HaW/sfb7uduqZ
	 TmCjk1iM7wHml61CozRdHxgmRwZY0ngUio8qCxSARYwICtbp7wb3y2ssyyd3Iv3H4d
	 VBnNF+DkFyCT7k0CI/DZ71t64+57myU22schlsS+5fxDlN/8P33sBUqYqLsC1fPvWM
	 KE1UK51MEAJXGlrsNR8hoJcyW9Rma7qExrMAB/YbqFMgb1LG4+VoLTWN01bKcT8LhU
	 7dit3wGiQuTDA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v3 0/9] ioctl()-based API to query VMAs from /proc/<pid>/maps
Date: Tue,  4 Jun 2024 17:24:45 -0700
Message-ID: <20240605002459.4091285-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
applications to query VMA information more efficiently than reading *all* VMAs
nonselectively through text-based interface of /proc/<pid>/maps file.

Patch #3 goes into a lot of details and background on some common patterns of
using /proc/<pid>/maps in the area of performance profiling and subsequent
symbolization of captured stack traces. As mentioned in that patch, patterns
of VMA querying can differ depending on specific use case, but can generally
be grouped into two main categories: the need to query a small subset of VMAs
covering a given batch of addresses, or reading/storing/caching all
(typically, executable) VMAs upfront for later processing.

The new PROCMAP_QUERY ioctl() API added in this patch set was motivated by the
former pattern of usage. Patch #9 adds a tool that faithfully reproduces an
efficient VMA matching pass of a symbolizer, collecting a subset of covering
VMAs for a given set of addresses as efficiently as possible. This tool is
serving both as a testing ground, as well as a benchmarking tool.
It implements everything both for currently existing text-based
/proc/<pid>/maps interface, as well as for newly-added PROCMAP_QUERY ioctl().

But based on discussion on previous revision of this patch set, it turned out
that this ioctl() API is competitive with highly-optimized text-based
pre-processing pattern that perf tool is using. Based on perf discussion, this
revision adds more flexibility in specifying a subset of VMAs that are of
interest. Now it's possible to specify desired permissions of VMAs (e.g.,
request only executable ones) and/or restrict to only a subset of VMAs that
have file backing. This further improves the efficiency when using this new
API thanks to more selective (executable VMAs only) querying.

In addition to a custom benchmarking tool from patch #9, and experimental perf
integration (available at [0]), Daniel Mueller has since also implemented an
experimental integration into blazesym (see [1]), a library used for stack
trace symbolization by our server fleet-wide profiler and another on-device
profiler agent that runs on weaker ARM devices. The latter ARM-based device
profiler is especially sensitive to performance, and so we benchmarked and
compared text-based /proc/<pid>/maps solution to the equivalent one using
PROCMAP_QUERY ioctl().

Results are very encouraging, giving us 5x improvement for end-to-end
so-called "address normalization" pass, which is the part of the symbolization
process that happens locally on ARM device, before being sent out for further
heavier-weight processing on more powerful remote server. Note that this is
not an artificial microbenchmark. It's a full end-to-end API call being
measured with real-world data on real-world device.

  TEXT-BASED
  ==========
  Benchmarking main/normalize_process_no_build_ids_uncached_maps
  main/normalize_process_no_build_ids_uncached_maps
	  time:   [49.777 µs 49.982 µs 50.250 µs]

  IOCTL-BASED
  ===========
  Benchmarking main/normalize_process_no_build_ids_uncached_maps
  main/normalize_process_no_build_ids_uncached_maps
	  time:   [10.328 µs 10.391 µs 10.457 µs]
	  change: [−79.453% −79.304% −79.166%] (p = 0.00 < 0.02)
	  Performance has improved.

You can see above that we see the drop from 50µs down to 10µs for exactly
the same amount of work, with the same data and target process.

Results for more synthentic benchmarks that hammer /proc/<pid>/maps processing
specifically can be found in patch #9. In short, we see about ~40x improvement
with our custom benchmark tool (it varies depending on captured set of
addresses, previous revision used a different set of captured addresses,
giving about ~35x improvement). And even for perf-based benchmark it's on par
or slightly ahead when using permission-based filtering (fetching only
executable VMAs).

Another big change since v1 is the use of RCU-protected per-VMA lock during
querying, which is what has been requested by mm folks in favor of current
mmap_lock-based protection used by /proc/<pid>/maps text-based implementation.
For that, we added a new internal API that is equivalent to find_vma(), see
patch #1.

One thing that did not change was basing this new API as an ioctl() command
on /proc/<pid>/maps file. An ioctl-based API on top of pidfd was considered,
but has its own downsides. Implementing ioctl() directly on pidfd will cause
access permission checks on every single ioctl(), which leads to performance
concerns and potential spam of capable() audit messages. It also prevents
a nice pattern, possible with /proc/<pid>/maps, in which application opens
/proc/self/maps FD (requiring no additional capabilities) and passed this FD
to profiling agent for querying. To achieve similar pattern, a new file would
have to be created from pidf just for VMA querying, which is considered to be
inferior to just querying /proc/<pid>/maps FD as proposed in current approach.
These aspects were discussed in the hallway track at recent LSF/MM/BPF 2024
and sticking to procfs ioctl() was the final agreement we arrived at.

This patch set is based on top of next-20240604 tag in linux-next tree.

Note: currently there is a race when using RCU-protected per-VMA locking,
which Liam is fixing. RFC patches can be found at [2]. This patch set can
proceed in parallel with that solution.

  [0] https://github.com/anakryiko/linux/commits/procfs-proc-maps-ioctl-v2/
  [1] https://github.com/libbpf/blazesym/pull/675
  [2] https://lore.kernel.org/linux-mm/20240531163217.1584450-1-Liam.Howlett@oracle.com/

v2->v3:
  - drop mmap_lock aggressively under CONFIG_PER_VMA_LOCK (Liam);
  - code massaging to abstract per-VMA vs mmap_lock differences (Liam);
v1->v2:
  - per-VMA lock is used, if possible (Liam, Suren);
  - added file-backed VMA querying (perf folks);
  - added permission-based VMA querying (perf folks);
  - split out build ID into separate patch (Suren);
  - better documented API, added mention of ioctl() into procfs docs (Greg).

Andrii Nakryiko (9):
  mm: add find_vma()-like API but RCU protected and taking VMA lock
  fs/procfs: extract logic for getting VMA name constituents
  fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
  fs/procfs: use per-VMA RCU-protected locking in PROCMAP_QUERY API
  fs/procfs: add build ID fetching to PROCMAP_QUERY API
  docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
  tools: sync uapi/linux/fs.h header into tools subdir
  selftests/bpf: make use of PROCMAP_QUERY ioctl if available
  selftests/bpf: add simple benchmark tool for /proc/<pid>/maps APIs

 Documentation/filesystems/proc.rst          |   8 +
 fs/proc/task_mmu.c                          | 412 +++++++++++++--
 include/linux/mm.h                          |   8 +
 include/uapi/linux/fs.h                     | 156 +++++-
 mm/memory.c                                 |  62 +++
 tools/include/uapi/linux/fs.h               | 550 ++++++++++++++++++++
 tools/testing/selftests/bpf/.gitignore      |   1 +
 tools/testing/selftests/bpf/Makefile        |   2 +-
 tools/testing/selftests/bpf/procfs_query.c  | 386 ++++++++++++++
 tools/testing/selftests/bpf/test_progs.c    |   3 +
 tools/testing/selftests/bpf/test_progs.h    |   2 +
 tools/testing/selftests/bpf/trace_helpers.c | 104 +++-
 12 files changed, 1623 insertions(+), 71 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/testing/selftests/bpf/procfs_query.c

-- 
2.43.0


