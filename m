Return-Path: <linux-fsdevel+bounces-679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E87CE4D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7FB1C20ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF93FB26;
	Wed, 18 Oct 2023 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmbULKUS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397342F531
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 17:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D2FC433C8;
	Wed, 18 Oct 2023 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650891;
	bh=kOWxubIvgkUuX1LHF9Uvd3PXOcCevsiFIHXsUMPyfII=;
	h=From:Subject:Date:To:Cc:From;
	b=HmbULKUSdAVTYh0NKXFEKevWhFCUwYFMuL4ZE6MnHrMRc//1huWLlflMoK0S8D7HT
	 RpsmiCca/5mXfeyTb19e8+kl8UJFzEghrdotH3KvXYHZLUsXcKKlbUVfvdQyMx62z6
	 34Xsrh7WT/00XDtz5t6InI84zeLOx7tPeu8rJA9Rwn1Zx9HeCyi0I3fC4LOiYur/fE
	 JDN4Vyc3XcT+ERm/aUw1zN6TI4Le3vB5HM60CU8WN2sV4b/rcSCzdsY2aZvIqYa99Z
	 sjX65S2Oku9xYqAVYGzUC0sAqceFqJ82GaotgiDmurcJyHeCgtRQvu9Ale3NAijBbP
	 rOv1uoNIL4Tnw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH RFC 0/9] fs: multigrain timestamps (redux)
Date: Wed, 18 Oct 2023 13:41:07 -0400
Message-Id: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMYMGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0Mz3dz0kszcVN20VOPURHPTZLM0U0sloOKCotS0zAqwQdFKQW7OSrG
 1tQAHBm97XQAAAA==
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
 David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5629; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kOWxubIvgkUuX1LHF9Uvd3PXOcCevsiFIHXsUMPyfII=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlMBjAuucpyDoopVPNBPSV5kIUK51y3+JkIuJbJ
 MfA0arDDZaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZTAYwAAKCRAADmhBGVaC
 FRcGD/4gWTfDUlUYR99pZVwm1+RHd3+PX9zlbEqYbvDvs6/aA8B9q7koy4wlyncLKHzM5nrgYHf
 rFzENOpzsSadkGkDajVLKfFaQ7akLUv8uZiji9WsSoT+e1AyWZj0DskG0JKmYteynPzh30YyJL0
 KHzsJ7pfrumiZBtdXtMJAa8Skoueq0gWV/7oshhybg6JEOMLOQ+4ANJDMsIfpb6+sHdFitMACRF
 q4gKZPjsX7FZIx1dd0SQdMlRjw4An+JYEwgjP3bkdy7XTjz6sW5sitQstxEDS/JaxZ6XIIL7xqB
 OO/Jkxmo5/vSa05/4RVeplhTkAh1uV5n4LuWsjuh+Q8bON7Zv4VKdYJP8r9WBL/5zQwCPpHM2SO
 c5eE9cT+BmXGcJIzAw52UsXAbp0LO+gYHlR+G7q+I5GEVg2+g6LFRoxL0+OpYvIWcycfYQps5NH
 XnbuDRwrAVg96y3GpdKaOGuEzu1Sm5CLNXS0jYorIwAossaz50WdaaVRJxMjPRinrp+sP8fv7+l
 h2X/0Yla61mKX6fZZArxV7sA9uEGbMcZPQcXRw5DW7EhjKh1QbyGwF46sawjrX93/UoxFvWEHso
 iVcm5rVdVOTBwEy9iFhY241oVCW3E7NtCZ/SNf/hiaRQFTl/Sn7Q3aluI/ogOfLPa0eG+eRYdo8
 H373khRmD98lzxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The VFS always uses coarse-grained timestamps when updating the
ctime and mtime after a change. This has the benefit of allowing
filesystems to optimize away a lot metadata updates, down to around 1
per jiffy, even when a file is under heavy writes.

Unfortunately, this coarseness has always been an issue when we're
exporting via NFSv3, which relies on timestamps to validate caches. A
lot of changes can happen in a jiffy, so timestamps aren't sufficient to
help the client decide to invalidate the cache.

Even with NFSv4, a lot of exported filesystems don't properly support a
change attribute and are subject to the same problems with timestamp
granularity. Other applications have similar issues with timestamps (e.g
backup applications).

If we were to always use fine-grained timestamps, that would improve the
situation, but that becomes rather expensive, as the underlying
filesystem would have to log a lot more metadata updates.

What we need is a way to only use fine-grained timestamps when they are
being actively queried. The idea is to use an unused bit in the ctime's
tv_nsec field to mark when the mtime or ctime has been queried via
getattr. Once that has been marked, the next m/ctime update will use a
fine-grained timestamp.

The original merge of multigrain timestamps for v6.6 had to be reverted,
as a file with a coarse-grained timestamp could incorrectly appear to be
modified before a file with a fine-grained timestamp, when that wasn't
the case.

This revision solves that problem by making it so that when a
fine-grained timespec64 is handed out, that that value becomes the floor
for further coarse-grained timespec64 fetches. This requires new
timekeeper interfaces with a potential downside: when a file is
stamped with a fine-grained timestamp, it has to (briefly) take the
global timekeeper spinlock.

Because of that, this set takes greater pains to avoid issuing new
fine-grained timestamps when possible. A fine-grained timestamp is now
only required if the current mtime or ctime have been fetched for a
getattr, and the next coarse-grained tick has not happened yet. For any
other case, a coarse-grained timestamp is fine, and that is done using
the seqcount.

In order to get some hard numbers about how often the lock would be
taken, I've added a couple of percpu counters and a debugfs file for
tracking both types of multigrain timekeeper fetches.

With this, I did a kdevops fstests run on xfs (CRC mode). I ran "make
fstests-baseline" and then immediately grabbed the counter values, and
calcuated the percentage:

$ time make fstests-baseline
real    324m17.337s
user    27m23.213s
sys     2m40.313s

fine            3059498
coarse          383848171
pct fine        .79075661

Next I did a kdevops fstests run with NFS. One server serving 3 clients
(v4.2, v4.0 and v3). Again, timed "make fstests-baseline" and then
grabbed the multigrain counters from the NFS server:

$ time make fstests-baseline
real    181m57.585s
user    16m8.266s
sys     1m45.864s

fine            8137657
coarse          44726007
pct fine        15.393668

We can't run as many tests on nfs as xfs, so the run is shorter. nfsd is
a very getattr-heavy workload, and the clients aggressively coalesce
writes, so this is probably something of a pessimal case for number of
fine-grained timestamps over time.

At this point I'm mainly wondering whether (briefly) taking the
timekeeper spinlock in this codepath is unreasonable. It does very
little work under it, so I'm hoping the impact would be unmeasurable for
most workloads.

Side Q: what's the best tool for measuring spinlock contention? It'd be
interesting to see how often (and how long) we end up spinning on this
lock under different workloads.

Note that some of the patches in the series are virtually identical to
the ones before. I stripped the prior Reviewed-by/Acked-by tags though
since the underlying infrastructure has changed a bit.

Comments and suggestions welcome.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (9):
      fs: switch timespec64 fields in inode to discrete integers
      timekeeping: new interfaces for multigrain timestamp handing
      timekeeping: add new debugfs file to count multigrain timestamps
      fs: add infrastructure for multigrain timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 fs/attr.c                           |  52 ++++++++++++++--
 fs/btrfs/file.c                     |  25 ++------
 fs/btrfs/super.c                    |   5 +-
 fs/ext4/super.c                     |   2 +-
 fs/inode.c                          |  70 ++++++++++++++++++++-
 fs/stat.c                           |  41 ++++++++++++-
 fs/xfs/libxfs/xfs_trans_inode.c     |   6 +-
 fs/xfs/xfs_iops.c                   |  10 +--
 fs/xfs/xfs_super.c                  |   2 +-
 include/linux/fs.h                  |  85 ++++++++++++++++++--------
 include/linux/timekeeper_internal.h |   2 +
 include/linux/timekeeping.h         |   4 ++
 kernel/time/timekeeping.c           | 117 ++++++++++++++++++++++++++++++++++++
 mm/shmem.c                          |   2 +-
 14 files changed, 352 insertions(+), 71 deletions(-)
---
base-commit: 12cd44023651666bd44baa36a5c999698890debb
change-id: 20231016-mgtime-fe3ea75c6f59

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


