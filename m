Return-Path: <linux-fsdevel+bounces-21415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2D90396E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964AF281FD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F7179951;
	Tue, 11 Jun 2024 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv3/s18L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAE46525;
	Tue, 11 Jun 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103661; cv=none; b=ZDb5YjIkgAwf/rBGXE5MwoFHRqTXXtExVZgz0AsES/drjnrAEOQF+c1DWAgAlTp2iLr8oGVjpJc6ncYWBzJF6gWrjif8woQsIYBZ6YR1zI/o64zhncbVMGv05myFqsMgG+HgoZlcg//A3kPCM4QdrZSZbH+mYFMHXMP4X/tLdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103661; c=relaxed/simple;
	bh=ZDpFbMbmPb8D4u9/TrmtWz/aLsgRff7lvDoIhL0sAI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iYMpt0brbnRT6eA+W9j5VqzKlWJpJknz4IQoBO5neCzdCyEEJo/J6BB13l3tOX4WkLMXwIcK20d7Z5alXA+UDjIM5d+4OmtVy7XP2IyiuhCLF40xFwCmphj+hTK6WpZq6BPwrgViadjQix6+fBMIYsVLLSdWUpOL7IYl0D3lhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv3/s18L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D7C2BD10;
	Tue, 11 Jun 2024 11:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718103660;
	bh=ZDpFbMbmPb8D4u9/TrmtWz/aLsgRff7lvDoIhL0sAI8=;
	h=From:To:Cc:Subject:Date:From;
	b=Tv3/s18LudvwIL9D25sC9XsLoUNpu+a6i2TvsOE96tnbrV1r7hZsBtLlPKplW5k6V
	 vki3WfGT5E/xVFtEFUArfq+o6+HBCf7S1UQ9gCuXVT9Cr4gLjS4PwdZA3SGjNf+YQx
	 P6E2WTIRnEJdlTmq58jmq42Xc/Mbyj/BQS9iiiPz1gpUBoPJ+kphCHb/orrmYeInKv
	 /PKp1sLV9Wgw1DJta+9RWdqf+5pjgatplTn5BkTSdlv/SlYLvOIne+lfUllLo53DRq
	 3jNDQg4Jms4aU6eU8IxhCoAjSUoX4fS4ZOTJ9rdi1VF6WKugbPOjQukh2DTHU6uF6E
	 LxDCjBxZW6uDw==
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
Subject: [PATCH v4 0/7] ioctl()-based API to query VMAs from /proc/<pid>/maps
Date: Tue, 11 Jun 2024 04:00:48 -0700
Message-ID: <20240611110058.3444968-1-andrii@kernel.org>
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

Earlier revisions attempted to use per-VMA locking, if kernel was compiled
with CONFIG_PER_VMA_LOCK=y, but it turned out that anon_vma_name() is not yet
compatible with per-VMA locking and assumes mmap_lock to be taken, which makes
the use of per-VMA locking for this API premature. It was agreed ([2]) to
continue for now with just mmap_lock, but the code structure is such that it
should be easy to add per-VMA locking support once all the pieces are ready.

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

This patch set is based on top of next-20240611 tag in linux-next tree.

  [0] https://github.com/anakryiko/linux/commits/procfs-proc-maps-ioctl-v2/
  [1] https://github.com/libbpf/blazesym/pull/675
  [2] https://lore.kernel.org/bpf/7rm3izyq2vjp5evdjc7c6z4crdd3oerpiknumdnmmemwyiwx7t@hleldw7iozi3/

v3->v4:
  - drop per-VMA locking changes for now, we'll need anon_vma_name() to be
    compatible with vma->vm_lock approach (Suren, Liam);
v2->v3:
  - drop mmap_lock aggressively under CONFIG_PER_VMA_LOCK (Liam);
  - code massaging to abstract per-VMA vs mmap_lock differences (Liam);
v1->v2:
  - per-VMA lock is used, if possible (Liam, Suren);
  - added file-backed VMA querying (perf folks);
  - added permission-based VMA querying (perf folks);
  - split out build ID into separate patch (Suren);
  - better documented API, added mention of ioctl() into procfs docs (Greg).

Andrii Nakryiko (7):
  fs/procfs: extract logic for getting VMA name constituents
  fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
  fs/procfs: add build ID fetching to PROCMAP_QUERY API
  docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
  tools: sync uapi/linux/fs.h header into tools subdir
  selftests/bpf: make use of PROCMAP_QUERY ioctl if available
  selftests/bpf: add simple benchmark tool for /proc/<pid>/maps APIs

 Documentation/filesystems/proc.rst          |   9 +
 fs/proc/task_mmu.c                          | 366 +++++++++++--
 include/uapi/linux/fs.h                     | 156 +++++-
 tools/include/uapi/linux/fs.h               | 550 ++++++++++++++++++++
 tools/testing/selftests/bpf/.gitignore      |   1 +
 tools/testing/selftests/bpf/Makefile        |   2 +-
 tools/testing/selftests/bpf/procfs_query.c  | 386 ++++++++++++++
 tools/testing/selftests/bpf/test_progs.c    |   3 +
 tools/testing/selftests/bpf/test_progs.h    |   2 +
 tools/testing/selftests/bpf/trace_helpers.c | 104 +++-
 10 files changed, 1508 insertions(+), 71 deletions(-)
 create mode 100644 tools/include/uapi/linux/fs.h
 create mode 100644 tools/testing/selftests/bpf/procfs_query.c

-- 
2.43.0


