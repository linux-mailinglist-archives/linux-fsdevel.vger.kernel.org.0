Return-Path: <linux-fsdevel+bounces-30762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218298E2D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1B2838E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4B215F72;
	Wed,  2 Oct 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTOBUXlL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C512C54D;
	Wed,  2 Oct 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894993; cv=none; b=gObJ2rs+nzmFJ64yR4mU8cPoICG23SjslHeer/XCllCncuRzGHsJF2c11/OxLmVrFsXxwLOiFWtczepXsLRYdn0BNo5y5dU6xV76Rpr+S1m/yOAoQnSC77FCCpT01ZzAdg5/6GdLVyOxp9YsdrH6eS31p+l1qlDlmRi/S4GrpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894993; c=relaxed/simple;
	bh=bkr/giBTZadF4+ZaiqM9ZsvG/mHxPB6xi2TaYAALx5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H7DFFIQEJlQ7JvQk9N4q2H15cGRdNHwgTWGO6oX/tY+q6ptt7oesZPh+WR9vgtk2qaotx7Kn8lk5MxI4PN97hHuCUq3/WQRCSaA86rf6715OX9CuLwrkigd6Cv5XxyH8LhbkC+Pb227wGTlc5BlIuRrNJqE+SWYqGGZ+Q8SIWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTOBUXlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36A2C4CEC2;
	Wed,  2 Oct 2024 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727894992;
	bh=bkr/giBTZadF4+ZaiqM9ZsvG/mHxPB6xi2TaYAALx5E=;
	h=From:Subject:Date:To:Cc:From;
	b=LTOBUXlL6D2ckQYybkdmOWsZzG2yHmK14UFnGZpmydG5YBgdkkKttR4EwCpHBIqUA
	 skJdfpEhebw4UzbgcWxV6PemWSdZBcKCcApa6WfsN/l613bwcpsV29Rfk2zn25oglC
	 vaEqSLJQtts3g0P1RGnt9ODaU6nSahiVv9eg+O0GmNhttqykL90DMGTQAk/dovOLEy
	 prSfA6XLGs1emmxJ1GKDxG+ejZ526z1ednTpcg8D0mgGHfohtQMjDP3KMoKfOhk8uD
	 XLaUhkZD+DGlvA3Oz+dJY/m1Y6tRSpLt+ji0XQEVTwHx/HuGxAN2iQCCTqg7lwY4Qo
	 KmFujK/ZUY+Ug==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 00/12] fs: multigrain timestamp redux
Date: Wed, 02 Oct 2024 14:49:28 -0400
Message-Id: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALiV/WYC/2XNTQ6CMBCG4auQrq2Z/gCtK+9hXFA6QqOCaUmjI
 dzdghE1Lr9Jn7cjCegdBrLLRuIxuuD6Lg29yUjdVl2D1Nm0CQcuQTNBr83grkg51FqZ2lZKIUm
 Pbx5P7r6EDse0WxeG3j+Wbizm6ytRsvydiAUFKhXmVkhjuan2Z/QdXra9b8jciOXHfX0dy+Q0t
 xI4oDAAf06tjgGw1anZgRBSWM1MLX7cNE1Py3mcRA0BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4801; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bkr/giBTZadF4+ZaiqM9ZsvG/mHxPB6xi2TaYAALx5E=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm/ZXGaarTxxkWaNZ/Bc1x5dRpKVleGFmW4G93p
 yeU+T33FouJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZv2VxgAKCRAADmhBGVaC
 FaalEAClzTf0+QC+AiBd5ATPquIjfAeFwnewaup6LZ/09jEA0sS0+bxA8pbRMLDga7cYu4LfYSe
 fN3F9l9h+JBHlo9dFG+ep0UUlgCQmA75t5aSnJWUKAZh4NYy4/JUayrZlcUdXU+tTRiPSButiUj
 G2wrHgeelBzrjzlYuF7W5MUu2rR9wJTCbiwVMpxub6YBWoA8emENI+aGinV41vUjPQGDvGInzfG
 4ONhuU2Tm/ZR3CHANJ4FBW2GYMeURFV7eyy/g8miB6UlFt1eTNWb1HpR58zaKd2F5ofHZJ0Rueg
 0MmYXXfuDrsBGPlwyxMSH+b9KE+FRf+2E311ToVif53zKGUWSISz57YGGwCFN4M0o45dt9J+XQw
 Sr9JJjGq6j6UNhiPAHxHPqJaGDzhsiPhUbbfJlW6Fd4Sfst6DSO6xIABQW8uptQ9sI1OROKRtlS
 MPqbE5NLAr/E0JGt6XfJkjhTSA+KLDBDwlDi7l3wWlk6Kf8wWC8Z86XTghHwBq6YsHHD5qC4fLJ
 2RJSNv4OLQm4mxM9Tkn+9J1l2D6IP2A0+r/PDiXyhYw9slEar48XLomicHODNoS8BiD55LyPI7T
 pEQighu0Eo1xlGGpLxv3/nB1OLunevvbeOFNzSCz2LZPqCbux82f3Woht/OvZ5zbFCJneU3wrDx
 0H9IS0cpGNM8ioA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a replacement for the v6 series sitting in Christian's
vfs.mgtime branch. The main changes here are to the changelogs,
documentation and comments. The code itself is largely unchanged.

The pipe1_threads test shows these averages on my test rig with this
series:

    v6.11:				89233600 (baseline)
    v6.11 + v9 series:			88460897 (<1% slower)

Acked-by's and Reviewed-by's would be welcome (particularly from the
timekeeper folks).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
 kernel/time/timekeeping_debug.c             |  13 ++
 kernel/time/timekeeping_internal.h          |   9 +
 mm/shmem.c                                  |   2 +-
 18 files changed, 784 insertions(+), 73 deletions(-)
---
base-commit: 7f1416b4fe6bd3363878a91894cd770f8ee1b5d0
change-id: 20240913-mgtime-20c98bcda88e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


