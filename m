Return-Path: <linux-fsdevel+bounces-22648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05A91AD7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06AB1C26280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE997433B3;
	Thu, 27 Jun 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfMfnaOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663F19A295;
	Thu, 27 Jun 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508144; cv=none; b=HqFfC3EQkMcdP7x9FidvNj1YFj+itnj1w92T433fCPnILbNESJSO/1stpFnCw0vohrzosioOQD0FymueXe9LvfpAHfUJnmcZc/7vwCkvYWQgbwvbhLoNp75xn81SOpHe6PDl/HNlSbwcE2dHkqueMAFChWqDzrR+zafnfG0/VXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508144; c=relaxed/simple;
	bh=ARHRjAfyCJ2jzfvBvNLQlAL7hzNda9MDzichgeVZa8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GNsxKEuUkSEeKrxd6HJw3uQUgU8qH8/uk5ljOOsNfgdsN/47uZOx/J8z7OtdxBdjJmR+A/VAD+V3aCLRmp7q9F5PkrQMoQt8K4amYVsUB26abA0Dk0Rn8whVvE9sMuNSflkKmnsLiUKe41wYVeGAAtZ9ZdAriD/tm4YJUy9Bc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfMfnaOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E190C2BBFC;
	Thu, 27 Jun 2024 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508143;
	bh=ARHRjAfyCJ2jzfvBvNLQlAL7hzNda9MDzichgeVZa8g=;
	h=From:To:Cc:Subject:Date:From;
	b=jfMfnaOsYiVBnWi/zLAJT2hf1W2S9piLL9GCs59IemJpZl+hylI3rxjcUHZSewTv7
	 MqkuirWJ310XMWLO8VFzbDIJYP4Ohm+vW53dFo21AaU+Y1s3ZN5vAa+WKM7Ve73wUg
	 7o84LTbbd/50wzvzb7IqKlHh5w7g6yxrX9mg7sKqFYmysJFWk2R1GZ7Q++QGj3WjhE
	 guNbWFi9J90uPt5p4yVm3QsPKy7yWasHk35A8hfZ/Tsg8An2o+SJ2kZoy2bhVJRXNP
	 OR5pGQhbhm8Fs+k/8TaEv9/7HWMCVZd8MtLtnfQyL2VCS6y6UePmALLXh09TqwqQV6
	 XXJvmId3gSrwQ==
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
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v6 0/6] ioctl()-based API to query VMAs from /proc/<pid>/maps
Date: Thu, 27 Jun 2024 10:08:52 -0700
Message-ID: <20240627170900.1672542-1-andrii@kernel.org>
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

Patch #2 goes into a lot of details and background on some common patterns of
using /proc/<pid>/maps in the area of performance profiling and subsequent
symbolization of captured stack traces. As mentioned in that patch, patterns
of VMA querying can differ depending on specific use case, but can generally
be grouped into two main categories: the need to query a small subset of VMAs
covering a given batch of addresses, or reading/storing/caching all
(typically, executable) VMAs upfront for later processing.

The new PROCMAP_QUERY ioctl() API added in this patch set was motivated by the
former pattern of usage. Earlier revisions had a patch adding a tool that
faithfully reproduces an efficient VMA matching pass of a symbolizer,
collecting a subset of covering VMAs for a given set of addresses as
efficiently as possible. This tool served both as a testing ground, as well as
a benchmarking tool. It implements everything both for currently existing
text-based /proc/<pid>/maps interface, as well as for newly-added
PROCMAP_QUERY ioctl(). This revision dropped the tool from the patch set and,
once the API lands upstream, this tool might be added separately on Github as
an example.

Based on discussion on earlier revisions of this patch set, it turned out
that this ioctl() API is competitive with highly-optimized text-based
pre-processing pattern that perf tool is using. Based on perf discussion, this
revision adds more flexibility in specifying a subset of VMAs that are of
interest. Now it's possible to specify desired permissions of VMAs (e.g.,
request only executable ones) and/or restrict to only a subset of VMAs that
have file backing. This further improves the efficiency when using this new
API thanks to more selective (executable VMAs only) querying.

In addition to a custom benchmarking tool, and experimental perf integration
(available at [0]), Daniel Mueller has since also implemented an experimental
integration into blazesym (see [1]), a library used for stack trace
symbolization by our server fleet-wide profiler and another on-device profiler
agent that runs on weaker ARM devices. The latter ARM-based device profiler is
especially sensitive to performance, and so we benchmarked and compared
text-based /proc/<pid>/maps solution to the equivalent one using PROCMAP_QUERY
ioctl().

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

With the aforementioned custom tool, we see about ~40x improvement (it might
vary a bit, depending on a specific captured set of addresses). And even for
perf-based benchmark it's on par or slightly ahead when using permission-based
filtering (fetching only executable VMAs).

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

This patch set is based on top of mm-unstable branch in mm tree.

  [0] https://github.com/anakryiko/linux/commits/procfs-proc-maps-ioctl-v2/
  [1] https://github.com/libbpf/blazesym/pull/675
  [2] https://lore.kernel.org/bpf/7rm3izyq2vjp5evdjc7c6z4crdd3oerpiknumdnmmemwyiwx7t@hleldw7iozi3/

v5->v6:
  - make vma_page_size an __u64 field (Liam);
v4->v5:
  - added tests in selftests/proc (Andrew);
  - added vma_page_size field (Liam);
  - dropped the benchmark tool and BPF selftests parts, I'll send them
    directly to bpf-next once this API makes it into that tree;
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

Andrii Nakryiko (6):
  fs/procfs: extract logic for getting VMA name constituents
  fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
  fs/procfs: add build ID fetching to PROCMAP_QUERY API
  docs/procfs: call out ioctl()-based PROCMAP_QUERY command existence
  tools: sync uapi/linux/fs.h header into tools subdir
  selftests/proc: add PROCMAP_QUERY ioctl tests

 Documentation/filesystems/proc.rst         |   9 +
 fs/proc/task_mmu.c                         | 383 ++++++++++++++++++---
 include/uapi/linux/fs.h                    | 158 ++++++++-
 tools/include/uapi/linux/fs.h              | 184 +++++++++-
 tools/testing/selftests/proc/Makefile      |   1 +
 tools/testing/selftests/proc/proc-pid-vm.c |  86 +++++
 6 files changed, 754 insertions(+), 67 deletions(-)

-- 
2.43.0


