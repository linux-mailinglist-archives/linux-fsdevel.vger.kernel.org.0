Return-Path: <linux-fsdevel+bounces-23560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525392E589
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B033A287C14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54A15B140;
	Thu, 11 Jul 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeooJrr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28305158DC8;
	Thu, 11 Jul 2024 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696105; cv=none; b=EXGKbG5hFIYvWqZd4iLzD5rftg3iiN7f5jQYcSyldXj4NrKNolA20ALEvYOSrunMOzPXsgDgl/+wP2ITtRuajkZHihBbK7BvzRr/sWl0t5mWN2OtXr5xJMdkP3uljt0LzGOWLsas5yQ6+7+qLd0OD6LEwhB1IlZ/FnGywmwxujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696105; c=relaxed/simple;
	bh=6RdMfN8GT5TlOHt8U/xfrPGOCLGbZMq30a98R04eApo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9Fr1Fmh2QHLcz6l5Z1mO30b2LrQCFu4QiyO5uO8PPcxYMz8Ck6Y7Sz2kmDquAOzKM4fZKg/ZM4GRmBkjBVDxIgmk+qvoch3hPS0FXA4/Lf9J76QkYGMnGZPZV+e2JfgqyZyaumEdXillw4noQ6SnTH9lE0MkjpXTycGfrzh054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeooJrr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E947EC116B1;
	Thu, 11 Jul 2024 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696104;
	bh=6RdMfN8GT5TlOHt8U/xfrPGOCLGbZMq30a98R04eApo=;
	h=From:Subject:Date:To:Cc:From;
	b=FeooJrr2+az8wlTlJzJNBNTQgbxo5CoT2v0Uu+ysdwGu6rdm2VDD2gtW/LX6qPqPB
	 5Nvb3nBvD0x+DfyM0z1IuR/5LHBKrT6u30B7EgL0mgkd0jIpIYNnJObs3StrfSgtNP
	 m/FzuafDk+x3L3bw1HyKZ+ayyU9bmpZwnIu6cJeEw+mRQ/Elti8ogWbdykQjEt6YfW
	 mrpKLaYpU5r2jhB3LxfkqTs1P5CMvvJkBC16o8quM1AshhIP/IzGQzpiifFk1AdE63
	 sdIfrjMieal+/+h+IfW0CbGzEWTPPjpuO6bsodSxLxx+UoSrZxPMwpKLR0cekPTkKA
	 ZOAzKJn5iiz8Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 0/9] fs: multigrain timestamp redux
Date: Thu, 11 Jul 2024 07:08:04 -0400
Message-Id: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABS9j2YC/2XOTQ6DIBRG0a0YxqV5/Cl01H00HaCAklZtwJg2x
 r0XHVgbh98L54YJRRu8jeiSTSjY0Uffd2mIU4aqRne1xd6kjShQDjnNcVsPvrVYVEZCSaSRBFB
 6/ArW+fcaut3Tbnwc+vBZuyNZrofESDBgTaRighpw0l0fNnT2ee5DjZbGSH+uALI5mhxRhhOqF
 QejDo7tndgcS06KkhqtVcmYODi+d3JzfPknOFblrhSFY39unucvAjh/HUUBAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5229; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6RdMfN8GT5TlOHt8U/xfrPGOCLGbZMq30a98R04eApo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70f3nAKvVzwWbeFtmY26vMEGFNsy5Y6kvcLp
 I62wXPcziGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9HwAKCRAADmhBGVaC
 FYmPD/46BtIEjpmLwuzvndS0jbI/Wx/CH2yPVhvmwMG/KhPp04qOzAI2cR4fpjbY48b1RS15EX/
 eQh4kQ/ICIMpeQeqkfqd9DQVUzJgf3yVREXHgEii7ZZT0+h8aX1/Hu8DJ0gpA/MjjNNNX59wlCR
 8Bpt0pFE35x0cnXa1b763A2pyYAZQz/zvvBSIik1M4OtnFbfKg05c1gPsCyipDy4LZUG2E6g6dE
 QaC1jw5+m2mRceWloHK08sosonspLLe6bKh6JiTM5PrlBbnOntz8jDYs+vxqJUSFNEGqOEgrOY9
 SJO08W33hjJ/0tpz/xpTuExehB9mjd9Djal1+XCnJcou+si7ooTss3nQlK8sSyl+f5Mk+dFY8an
 8gx+8gCBWo51IiGREPJFAHG45iXx8jzYIhkgMCb8HtLaKpkB7uZE5mCQ9VWT6ELeBTJSLzJXhCh
 as0kDeofDpVZftPnGQDqpGTRj42/oWHrVKYyOVH897WJs+HpI16CDYPbikYXz4f51hl7Z8LwKCU
 qbC8oga88Ww5f5/lXGabKKIH/nFXA0ayz0Hn2NCQD+e9lbbUSzX5QoGQ7hEaURES6eEB/2PcXUR
 JEMj2g5MEISh+nqOCHWZJAED0JYhV6HoSFGOvRZwyTz7Td+2fNU/LNyqmjiGQNob0GkH7LjxvcZ
 eMV9Prfj8m7Iynw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

tl;dr for those who have been following along:

There are several changes in this version. The conversion of ctime to
be a ktime_t value has been dropped, and we now use an unused bit in
the nsec field as the QUERIED flag (like the earlier patchset did).

The floor value is now tracked as a monotonic clock value, and is
converted to a realtime value on an as-needed basis. This eliminates the
problem of trying to detect when the realtime clock jumps backward.

Longer patch description for those just joining in:

At LSF/MM this year, we had a discussion about the inode change
attribute. At the time I mentioned that I thought I could salvage the
multigrain timestamp work that had to be reverted last year [1].

That version had to be reverted because it was possible for a file to
get a coarse grained timestamp that appeared to be earlier than another
file that had recently gotten a fine-grained stamp.

This version corrects the problem by establishing a per-time_namespace
ctime_floor value that should prevent this from occurring. In the above
situation, the two files might end up with the same timestamp value, but
they won't appear to have been modified in the wrong order.

That problem was discovered by the test-stat-time gnulib test. Note that
that test still fails on multigrain timestamps, but that's because its
method of determining the minimum delay that will show a timestamp
change will no longer work with multigrain timestamps. I have a patch to
change the testcase to use a different method that is in the process of
being merged.

The testing I've done seems to show performance parity with multigrain
timestamps enabled vs. disabled, but it's hard to rule this out
regressing some workload.

This set is based on top of Christian's vfs.misc branch (which has the
earlier change to track inode timestamps as discrete integers). If there
are no major objections, I'd like to have this considered for v6.12,
after a nice long full-cycle soak in linux-next.

PS: I took a stab at a conversion for bcachefs too, but it's not
trivial. bcachefs handles timestamps backward from the way most
block-based filesystems do. Instead of updating them in struct inode and
eventually copying them to a disk-based representation, it does the
reverse and updates the timestamps in its in-core image of the on-disk
inode, and then copies that into struct inode. Either that will need to
be changed, or we'll need to come up with a different way to do this for
bcachefs.

[1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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
Jeff Layton (9):
      fs: add infrastructure for multigrain timestamps
      fs: tracepoints around multigrain timestamp events
      fs: add percpu counters for significant multigrain timestamp events
      fs: have setattr_copy handle multigrain timestamps appropriately
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 Documentation/filesystems/multigrain-ts.rst | 120 ++++++++++++++
 fs/attr.c                                   |  52 ++++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 234 ++++++++++++++++++++++++----
 fs/stat.c                                   |  39 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  34 +++-
 include/trace/events/timestamp.h            | 109 +++++++++++++
 mm/shmem.c                                  |   2 +-
 13 files changed, 560 insertions(+), 78 deletions(-)
---
base-commit: 7507ae6c41bb8990d3ae98ad0f5b0c15ca4156fe
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


