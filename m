Return-Path: <linux-fsdevel+bounces-30475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7C98BA31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD781C235E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989261BF332;
	Tue,  1 Oct 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqCwKBGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D11BE844;
	Tue,  1 Oct 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780351; cv=none; b=ZVSPP9H+Ntyh4DizcODdv7jGG/27qV9ORAoGIM+L691SjegOnS7W/mHN+UlKXVcYHyl9bk9MYptcvfuCunz4wgP13YV6n3W+mF7XT8zzWrQIgyRJK2BWIUtodOzR9G/tDLbDotYQ5AExotUttFhghOcUvAtixuDJ+6OzHTEVyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780351; c=relaxed/simple;
	bh=VLG6bH+4TEIixDiT/n5phywyTssvqS4L5B6xFjWpTj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rq+CmCgpJyRVj4SOx1AyW/CtDJoKOe5hY8ia1gf4UNVGCz5EQ+BYc2LacNwfn5jABk8dqjfG6jXMQuGruFoIIhiLZYOcvnv0PTMQ03I1m9FdMvnU/j118Bb7HtwitcBr5ltGNREJKf7OyL25muW4a9lv9GtL+ihm34gWg8zFnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqCwKBGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B87C4CEC6;
	Tue,  1 Oct 2024 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727780350;
	bh=VLG6bH+4TEIixDiT/n5phywyTssvqS4L5B6xFjWpTj8=;
	h=From:Subject:Date:To:Cc:From;
	b=qqCwKBGQbvG5Y7mZadC21ECsFZNdJvThYEu/Dv+m4Qm2YJpPEw1ehBj3+E4O1j0Hc
	 34iGuvB+XYv+ko88xtmz50o1jPX4QsFOOAkrGWer9YtYbLYpzNPhoywZWUI3BzXqA8
	 whBHNvTEoN3TeH7/xY748xHxVmuCN45euqpjyEwh6iY1NiYsepnbjp7qQ/AOssqT3l
	 RTVCurl1yLRKecobCnstz3PKjoBa9+Ypvjkm4bCLf12sScF16s5b/73uHNAXhCpyK2
	 IxYaT50e5qyd5tbrvVdnRWbi5L/OQmYx5UseY365i6yAeSjqpNVlQbDEquK6M/ssxy
	 GE3ua1LLqdrtA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 00/12] fs: multigrain timestamp redux
Date: Tue, 01 Oct 2024 06:58:54 -0400
Message-Id: <20241001-mgtime-v8-0-903343d91bc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7V+2YC/1WNQQ6CMBBFr0Jmbc1QChRX3sO4oHSEiQKmJY2Gc
 HcLxqjL9zPvzQyeHJOHQzKDo8CexyGC3iXQdPXQkmAbGSRKhVWaib6duCchsam0aWytNUE8vju
 68GMLnc6RO/bT6J5bNxTr+k6Uaf5JhEKgUJpymyljpamPV3ID3faja2FthPLr/bwOZfQqaRVKp
 Mwg/nnLsrwA+W2M09UAAAA=
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5473; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VLG6bH+4TEIixDiT/n5phywyTssvqS4L5B6xFjWpTj8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm+9X51ZWxnSKAlgEHwigtPXgYjKvq2MPxoDofW
 DNLLrUo8GyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZvvV+QAKCRAADmhBGVaC
 FXUnD/9xk4rPMsOtYRJn8MOO+8/wK4SICpYo7lIFsgLUPfBpnAKNP7LkeQCRJUPQ6t0Iqv8CCw1
 m1RnSWyApVghZBl1ekTUYvFXl1YmeXaYR658KnqlrzpxjEXHo9gcvc6J4yJ/SzxoNT5U0fbBjdQ
 BtDokFss63xqrWz6LrlmT4Ei3hS4r8RN9vQ80/F7mmwd4c2hI5QgXOFWMVAebF7OmELcRD57PKi
 YOyH4RvlM5dyXYaeHLy67DiA3m2DhKqZL20ZiNQtBSZTitLWcWRSHT9/NdKL3FtPT+H2Pp+F3rd
 n1HSKA9jfXaJpZmxXDY76sxl5l0PEWFL70N9Zm9JzbTxTe8LtQBM3zxWGrf9IQSKODhmAgBigPO
 KzNevAoKHwDlG6dOVwJYdhv4h7GnutryT8KF7Sn1Zdoakfe5cWfUZ0XL8RK6zvqF62hXkysUwKA
 PwoLRSMsKyck7oAfJwhOnLEpeReMW6vTT/NzOvB3CYR/bjkUEyB8Mt64SJzuwgZsqKZfUEfdFRu
 h3GSFEft5mhQOOmKuGyTL6ef3p1Dhz1EbWWdsTy+RS53VvOuLKupj8EvIr91Mvx0IfbVsOUQ7Kq
 /UnT4LFTEg9ef6a4gimMUdyqdz1I+LxBJ+2iqLGoOCawWztpO0XPrUqk42qzWOIYyxtDqVf+GDu
 oIN/luq0GQ530aw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a replacement for the v6 series sitting in Christian's
vfs.mgtime branch.

The kernel test robot reported a performance regression in v6 due to the
changes to current_time(). This patchset addresses that by moving the
ctime floor handling into the timekeeper code, which allows us to avoid
multiple seqcount loops when fetching and converting times. The basic
approach is still the same. The only difference is in where the
timestamp floor is handled, and in how we get new timestamps.

This reduces the changes to fs/inode.c and avoids a lot of the messiness
of handling both timespec64's and ktime_t values.

The pipe1_threads test shows these averages on my test rig:

    v6.11-rc7				103561295 (baseline)
    v6.11-rc7 + v6 series		95995565  (~7% slower)
    v6.11-rc7 + v7 series		101357203 (~2% slower)

...so the performance difference here is significant.

The main difference between v6 and v7 is in the first two patches, so
I've dropped the R-b's from those. The rest I left intact.

Note that there is one additional patch in this series (#4) that adds
support for handling delegated timestamps. The patches that make use of
that are in Chuck's nfsd-next branch. Taking that in here should make
that merge easier.

R-b's would be welcome (particularly from the timekeeper folks).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v8:
- split patch that adds percpu counters into fs and timekeeping patches
- convert percpu counters to unsigned longs
- directly access the offs_real value in timekeeper instead of going
  through offsets array
- drop WARN_ON's in timekeeping patches
- better changelogs and more comments for the timekeeping bits
- better document how backward realtime clock jumps affect things
- Link to v7: https://lore.kernel.org/r/20240913-mgtime-v7-0-92d4020e3b00@kernel.org

Changes in v7:
- move the floor value handling into timekeeper for better performance
- Link to v6: https://lore.kernel.org/r/20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org

Changes in v6:
- Normalize timespec64 in inode_set_ctime_to_ts
- use DEFINE_PER_CPU counters for better vfs consistency
- skip ctime cmpxchg if the result means nothing will change
- add trace_ctime_xchg_skip to track skipped ctime updates
- use __print_flags in ctime_ns_xchg tracepoint
- Link to v5: https://lore.kernel.org/r/20240711-mgtime-v5-0-37bb5b465feb@kernel.org

Changes in v5:
- refetch coarse time in coarse_ctime if not returning floor
- timestamp_truncate before swapping new ctime value into place
- track floor value as atomic64_t
- cleanups to Documentation file
- Link to v4: https://lore.kernel.org/r/20240708-mgtime-v4-0-a0f3c6fb57f3@kernel.org

Changes in v4:
- reordered tracepoint fields for better packing
- rework percpu counters again to also count fine grained timestamps
- switch to try_cmpxchg for better efficiency
- Link to v3: https://lore.kernel.org/r/20240705-mgtime-v3-0-85b2daa9b335@kernel.org

Changes in v3:
- Drop the conversion of i_ctime fields to ktime_t, and use an unused bit
  of the i_ctime_nsec field as QUERIED flag.
- Better tracepoints for tracking floor and ctime updates
- Reworked percpu counters to be more useful
- Track floor as monotonic value, which eliminates clock-jump problem

Changes in v2:
- Added Documentation file
- Link to v1: https://lore.kernel.org/r/20240626-mgtime-v1-0-a189352d0f8f@kernel.org

---
Jeff Layton (12):
      timekeeping: add interfaces for handling timestamps with a floor value
      fs: add infrastructure for multigrain timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      fs: handle delegated timestamps in setattr_copy_mgtime
      fs: tracepoints around multigrain timestamp events
      fs: add percpu counters for significant multigrain timestamp events
      timekeeping: add percpu counter for tracking floor swap events
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 Documentation/filesystems/index.rst         |   1 +
 Documentation/filesystems/multigrain-ts.rst | 125 +++++++++++++
 fs/attr.c                                   |  60 +++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 278 +++++++++++++++++++++++++---
 fs/stat.c                                   |  42 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  36 +++-
 include/linux/timekeeping.h                 |   5 +
 include/trace/events/timestamp.h            | 124 +++++++++++++
 kernel/time/timekeeping.c                   |  97 ++++++++++
 kernel/time/timekeeping_debug.c             |  13 ++
 kernel/time/timekeeping_internal.h          |   9 +
 mm/shmem.c                                  |   2 +-
 18 files changed, 767 insertions(+), 73 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240913-mgtime-20c98bcda88e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


