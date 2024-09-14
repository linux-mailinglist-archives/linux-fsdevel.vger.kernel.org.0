Return-Path: <linux-fsdevel+bounces-29379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCFC979245
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 19:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F921F22744
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E21D1313;
	Sat, 14 Sep 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIhrG/TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3921D094B;
	Sat, 14 Sep 2024 17:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333642; cv=none; b=orOSv9okK/WjDvde51Yk7ow/Yki1S2hqXT+zz6rTClCXBGI24VjiObDvgRfqP7VeOKHJG5QlZNKSnpqvyvfV6lACvbqWZo020ORwNzTa7ci21ssfIkCYPuRC0fI2PLTxrbxOPesDLtZZBgKa8m21Rbssetshwpz/uqKYRbKJwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333642; c=relaxed/simple;
	bh=oNZ9ifUx85pIo9YMYCgfUbZxCuBYJVyxSYhJ7nj6Okw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qRBLeW81DXmygBi7s7o3T9o9hiIoFS2RRTZaa7D9CIAKEWF0gDULw/5Fo3fUF6D+sM5C560PJM1yhvETRiDKquAXWGDyNf11yBxOkgdehnYeICkZ513my6pLpJ2i+7JplmQOH4lcotWzwN6WcUgRRJkOk9cD9ZR1N7W5Gi4QoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIhrG/TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C27AC4CEC0;
	Sat, 14 Sep 2024 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333641;
	bh=oNZ9ifUx85pIo9YMYCgfUbZxCuBYJVyxSYhJ7nj6Okw=;
	h=From:Subject:Date:To:Cc:From;
	b=NIhrG/TDQrl07dQ6TTbVV11vXpgZGzQZxMb7rqWJf9YAqDCOnuN8/88/0FV3S4zRz
	 F/sRefY+mAgWCj290EfoHiDr/tFuPLrwWcSPQa15Ly6rSF8ogjkIt9UdqTIlKPC6by
	 Ybmndyp8mgSJurKbFuIIBPi34KWS2K3oD1BKV6lHzBNQ3ZGMbbXyVe7+GO3Zpc3NRi
	 3InVqX8jWq2iggLuTzveSlnI6KzQIp3opdUoZSS0xkYAeY7SsvDvGTc+PtrVtaSZF8
	 Kvle/Z2ivJSJ4h9S9YYYq1bGJyyCGkGmp3hcpex84I2YuUaTGKdwN8yJ1Ags2cbifD
	 BkS6SDCaPGIoA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 00/11] fs: multigrain timestamp redux
Date: Sat, 14 Sep 2024 13:07:13 -0400
Message-Id: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMHC5WYC/1WNQQ6CMBBFr0Jmbc1QChRX3sO4oHSEiQKmJY2Gc
 HcLxqjL9zPvzQyeHJOHQzKDo8CexyGC3iXQdPXQkmAbGSRKhVWaib6duCchsam0aWytNUE8vju
 68GMLnc6RO/bT6J5bNxTr+k6Uaf5JhEKgUJpymyljpamPV3ID3faja2FthPLr/bwOZfQqaRVKp
 Mwg/nnLsrwA+W2M09UAAAA=
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oNZ9ifUx85pIo9YMYCgfUbZxCuBYJVyxSYhJ7nj6Okw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5cLFlgIi7SHE2OO3b2zPbvHekVLuRGgQpvr7G
 ARO3J1jIfeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuXCxQAKCRAADmhBGVaC
 FdqoD/4wRjGY+YRjkK+C/HU/G/RaDXKhm2vvNLBmfdXKKZsZoysJ15/xGizWxxwA3gcNG+I3yRu
 0ya0o2/adat2un1V3fbCiW9mnm3KqYqPhZEbDFWMz7RFpwNqeDg1/Rm0q8BOcDfGeufzR8Efzqe
 Poq08GAsbKITk3hkfpYd7AFI7lVhMn+moLz2knAjzLmaRjUa/Emlf6ENFKVbU7Re4bVE67s+SZt
 9qpFpLKD3v0PtrKw0/B3Mb87PCRMrothPihtbKQun6+QO6bnkx7QRQGVdytzwGL4wARIYKKpQca
 AZcLEYR5BfQ5V9zNX2psOArfBOplvawPoBhxOP9ttGSUN7yS3vpvYYP2nqczTOQeRF4TWpfqPlz
 Ce7A0iWlkjue9rMYQUBdyMle/8b/mqHfL5I1pCZXGgY4uewUk5LhXe+imQCPFd7nq4dkZV51R7v
 x6WgqXLj3yFQv9+3Bzs2rRe+JdP8EVYTCEPR4Xk6Z3H0puhANuW1kkQozhZokAbNfprVPcMTHxV
 qN8XM9rTuaLF3XOJ2OGNKepD+szArorAasN6pHEY/olnn1AGh67bAqLTNgDGEFg/adoDvAKJ4ls
 SwTAwrprK0N0HzEmTCBo4f6ri25yP5TbqSpDmUNRMFBerH0a27fgMu0FXbm7JhVIOIatQE6T2AM
 Xzp8+BwB3oev/GQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is a fairly small update to the v7 set. It seems to pass all of my
testing. Again, most of the changes are in the first two patches, but
there are some differences in the patch that adds percpu counters as
well.

Since the report of a performance regression came just before the merge
window, it looks like we're going to have to wait for yet another
release, so consider this version v6.13 material.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v8:
- drop the cookie handling from the new timekeeper interfaces
- add back the floor_swaps percpu counter
- comment updates and minor cleanups
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
Jeff Layton (11):
      timekeeping: move multigrain timestamp floor handling into timekeeper
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
 Documentation/filesystems/multigrain-ts.rst | 121 ++++++++++++
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
 kernel/time/timekeeping.c                   |  83 +++++++++
 kernel/time/timekeeping_debug.c             |  12 ++
 kernel/time/timekeeping_internal.h          |   3 +
 mm/shmem.c                                  |   2 +-
 18 files changed, 742 insertions(+), 73 deletions(-)
---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240913-mgtime-20c98bcda88e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


