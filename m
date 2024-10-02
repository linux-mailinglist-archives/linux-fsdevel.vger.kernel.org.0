Return-Path: <linux-fsdevel+bounces-30786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCF98E4EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4D21C222DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50C2178F2;
	Wed,  2 Oct 2024 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcXFxU3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F76745F4;
	Wed,  2 Oct 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904454; cv=none; b=ba4eafgY/GmLHOauxnouM4Vlh28eTm1yXBsRtaw8WO5/dd/Qbq33o4OYC6VQOma8FRa+emJr6GDCTeISJ5s2HKjGvu1DI09WHE0WcKyw4ph13QQSsuIdPiWYq+uz6F49tCb7puIuJkm0vsiJZRCKBAT2y79PRTr7N0ICjL2afks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904454; c=relaxed/simple;
	bh=Y5NHoq1D66E6MhHGAOXPO50U8Tj9wg921VuqUM47n1c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bG0AHyoct8m1fJGHty7Q9UUC8U/MECQ/lwiRW/3dPwu/XCyp91CQtTI9StDJIqzi6Dd24s3GjAUtjyZGQ4IwISFQMpmAG4OjiBLGrRbVe0H9rN8RsSt7icBnOtnrdVmRSDX0LFcgodAZNQyZMwBrC6UAJNezG9cstndzbHdtdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcXFxU3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7406C4CEC2;
	Wed,  2 Oct 2024 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904451;
	bh=Y5NHoq1D66E6MhHGAOXPO50U8Tj9wg921VuqUM47n1c=;
	h=From:Subject:Date:To:Cc:From;
	b=tcXFxU3ofaRyX9PSIuU+dnEpVSM/iumnaLK9a5v7TRdkrtwP0QNqH27GmUbZcI1tG
	 oYge+zigzJPA1JlMSEgw/KdA581RhzhSY2EXPXC24TcYb/fxHkk2JC3p2pYVf1dhpl
	 uTFc8CnIho9ca+o5HduPQWYL6McWHSds7sm+jMg4ijNCAepuwpa0wEE1g2kauctk49
	 DSHzGyfbIwqSARHG+mFXPk12jQQ8+Dr9gm/lQDr2W7vbZjlbkISYQgNfSimTqXm91W
	 EFckdWyhiqKZgr9kr2ycRGM1jRvMAK9cowQ98S4qExt0fLZE2bvIhe3zvSgP6dO3wS
	 GGNPr5QZTTZCg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v10 00/12] timekeeping/fs: multigrain timestamp redux
Date: Wed, 02 Oct 2024 17:27:15 -0400
Message-Id: <20241002-mgtime-v10-0-d1c4717f5284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALO6/WYC/2XOSw7CIBCA4asY1mKGRwu48h7GBY+xErU11BCN6
 d2lNVaNy5nw/cOD9Jgi9mS9eJCEOfaxa8vAYLkg/mDbBmkMZUE4cAmGCXpurvGMlIM32vlgtUZ
 SHl8S7uNtKm13ZT7E/tql+xTO9bh9JRSr3olcU6BSYxWEdIE7uzliavG06lJDxkZWH/d1OqviD
 A8SOKBwAH9Oz44BsNnp0YEQUgTDnBd/znw7PjtTnFJYfmhDpaz/ccMwPAGOhG0LRgEAAA==
X-Change-ID: 20240913-mgtime-20c98bcda88e
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5223; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y5NHoq1D66E6MhHGAOXPO50U8Tj9wg921VuqUM47n1c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/bq5Ucxpe+2dO/4f2N9Del8gbRSKkXWJ4RxvE
 m32RFAxn22JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv26uQAKCRAADmhBGVaC
 FbJjD/4ich0/NyeGFTRSWS1TM6qXVjXQ8xiLD/NLSZ2ncXBcG3V1hR+AI5b74oW1NMX++R6i4gB
 T4DeOOvnUvb9hYQzATPVtCEMnTs/zmfiO+2KdNNNMT+l8TLfGQ/lZcLoVOxLDKMz9AFbDkAeSr7
 c6kjXrU0eBwUVT1gDRxmqojgNY+HGQe2vLNRFERnBRe3NDtNi+MCmot32asaXK/7KvjnrwEjzHz
 3x6+s9pu0nlJw7d6H/Lb5KvbeyTDrqckDBjXOC1nJp4C8fKnAxYBYVjP4cUtlkwTWwr20hD+Rwd
 mnjXCPtQ3ATyHOir3Y3b6y2/YdxjR990iPnP2Xc5w2JgpskMUhEtm5SnjP0BnOzBlpnl0kHALXj
 Eh85QVu4qubOl+4hGsJ9EL7CKh0CVckteSwd3EVlAM7AkGJhn03xeplu/pt7S/R9QtQbkWQxlct
 wjg9ADGhboyjclGC6lU1GYHkz1nYOy75cd5gEpOKN/j5Xg4eKN6tuBYJQTi1J+5vtMfhZBeDs3J
 PTh40/58qSFsYQcSbNKZCoXKa5UPTkcFRQwGEFhU9rEbPH9N6wSthLdJECY/UWrNYW1DtxceroA
 D8dDhy1XDRaUnAsnroLHI9/TPzjvO5y1al84sZ8El7GNodyr9+ILoihcGqtO8dQm/l7WS7BU4dS
 x01qjjvjnCAepRQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a replacement for the v6 series sitting in Christian's
vfs.mgtime branch. The main changes here are to the changelogs,
documentation and comments. I've also moved the timekeeping patches to
the front of the series, and done some minor cleanups.

The pipe1_threads test shows these averages on my test rig with this
series:

    v6.11:				89233600 (baseline)
    v6.11 + v9 series:			88460897 (<1% slower)

Thanks for all of the review so far!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v10:
- Reorder timekeeping patches to front of series
- Better separate timekeeping and fs changes
- add data_race annotations to per_cpu fetches
- get rid of pointless test for unsigned long to go negative
- better spacing for declarations and definitions in timekeeping_internal.h
- minor style cleanups
- Link to v9: https://lore.kernel.org/r/20241002-mgtime-v9-0-77e2baad57ac@kernel.org

Changes in v9:
- Comment and documentation cleanups.
- Drop the EXPORT_SYMBOL_GPL() from new timekeeper interfaces
- Link to v8: https://lore.kernel.org/r/20241001-mgtime-v8-0-903343d91bc3@kernel.org

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
      timekeeping: add percpu counter for tracking floor swap events
      fs: add infrastructure for multigrain timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      fs: handle delegated timestamps in setattr_copy_mgtime
      fs: tracepoints around multigrain timestamp events
      fs: add percpu counters for significant multigrain timestamp events
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 Documentation/filesystems/index.rst         |   1 +
 Documentation/filesystems/multigrain-ts.rst | 125 ++++++++++++
 fs/attr.c                                   |  60 +++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 282 +++++++++++++++++++++++++---
 fs/stat.c                                   |  46 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  36 +++-
 include/linux/timekeeping.h                 |   5 +
 include/trace/events/timestamp.h            | 124 ++++++++++++
 kernel/time/timekeeping.c                   | 106 +++++++++++
 kernel/time/timekeeping_debug.c             |  14 ++
 kernel/time/timekeeping_internal.h          |  15 ++
 mm/shmem.c                                  |   2 +-
 18 files changed, 791 insertions(+), 73 deletions(-)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240913-mgtime-20c98bcda88e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


