Return-Path: <linux-fsdevel+bounces-23227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494AD928C9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04C61F25796
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126A16D9D6;
	Fri,  5 Jul 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUWuxt9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01F1F94C;
	Fri,  5 Jul 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198977; cv=none; b=TY4hNaQfOWpQoByt9bE2gMpAOHylNjX/Orz7N6nneuvQ2SF9NO+r/9O3La1AT/VlcStFywaxKBzUAr/W7DUBEiuuz+U2VeOLkPULcsxwVR1wNT5OKO/lP9vIwLYTIkr1EndvpJ4ZKWnEj6Oj2hREGW+mLjZZMhYFMOIXD5QRBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198977; c=relaxed/simple;
	bh=GpNXKixQKHwmxqdS5uwKxyyDRs6usVf9Q2aUQOt0m2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=czLSjq20mzrLyxbWCUhE63ibI0eFoxDonRQWA4DFW634KO7s16edPj/jvCN76iYtYqjpyrHR9dfEWxX7vF8sjHD4qj7YdvIqSgX/qM+gcsYUgAC3Ye+Q8L+uOczhLWm4uQ5gyogxS1+26845Jeq34u/2cLPAiHKd0f0HSOD9XUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUWuxt9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17399C4AF07;
	Fri,  5 Jul 2024 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720198976;
	bh=GpNXKixQKHwmxqdS5uwKxyyDRs6usVf9Q2aUQOt0m2o=;
	h=From:Subject:Date:To:Cc:From;
	b=NUWuxt9iDBBNGHC9VWuq8vAP00vsRGoenkOw+bUutWZBj2UTXEpqhsTChsry/mhpg
	 Z02XCSWfog4QtTcv0Q6AxozBFJEK8ScwKtkkzmsmaxB4L7YP49J23dGvdYefJA1Ihr
	 zAGoc38iMc2wlr9vs1qjmuBchHYPxTJPrp3upBm9tU7rOMLbXtd+LOfnAphO8xouXP
	 1DEdlo9IKw8wLtfaR9A22RfNSdHPw812VioB2tlx4npYiIbmvgqWirHHZ8sA+LiiWp
	 yoFBbxNhqbQblB2kjtQ4BVht0NUC8U4Q9ZxejJMGx1Kce6vESZI5PG5On3wI1bpGHP
	 3sdzbbA4xtW/Q==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/9] fs: multigrain timestamp redux
Date: Fri, 05 Jul 2024 13:02:34 -0400
Message-Id: <20240705-mgtime-v3-0-85b2daa9b335@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAConiGYC/2WMyw6CMBBFf4XM2pqZ8rB15X8YF0gHaJRiWtJoC
 P9uYaExLs/NPWeGwN5ygGM2g+dogx1dgnyXQdPXrmNhTWKQKAusZCWGbrIDi7IxCq+kjCKEdH5
 4bu1zC50viXsbptG/tm6kdf1LRBIoalI6L6XBVrWnG3vH9/3oO1gbUX69A9LHk8kjbQqStS7Q6
 B9vWZY3HU29ZNUAAAA=
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
 Christoph Hellwig <hch@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5230; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GpNXKixQKHwmxqdS5uwKxyyDRs6usVf9Q2aUQOt0m2o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmiCc2mW3Ax9riCifJk81b/A4ti+wBSBpCt9fL3
 kufw+dDdlaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZognNgAKCRAADmhBGVaC
 FUh+EACt/ob9lB1os3d1+625J7Nr+v1FlGeUZzyHjLIes76oKNEAWNcMVKowKpFAe6zNQNXwENR
 fEcEzdNiWnnqQQZbvRHGkd/SsE0Xn4e9afNIkc1kg011Pp3KUs+fjvDckPpr39UJpCWCnu+QKcn
 P9kVXTwSibJyLdv4FoY9idGeGNRszUCDeMqzvkOFoJX+Kgo17JX44QntHwCjc45VAMmsZLW9nqI
 IT043ZapyyJYsADKoSBTJIDK/G0xaP1ZDpiJmnsHcCtMsK08fQmcy0pjLXdYUDTG5QRdm+gqEVe
 cxn99SJm2UEhpmOjA95QLHa978CrzlDOkBXjjEFplP4HiaNnkMfy8EfbzqUbdVZqA6fQngN9sHm
 veIf+I4gVAP/75ZF5De5rZRLaDBXIko9k7tcYw2QhedH+qI0nTY853QUVx/1go1CUhUScNT6FMw
 UXztQ7Wo4oBPzsmdDAjcgRwSOQ6kTFmJySQqRAgF/oA9lo/hYy44mVplqDVKQTc7H1XLJw0g5br
 I3sYFf7YxmsnHiWPFR0MNj4xThLU/XuhwChiSrYlGER+EOha5Z67I5bv+f6OXJLOoa4fY7nmMDY
 1SKT9qN1kiHAr/SUVg5HZYJjAHCh2re9SnyeHE+CWJPm1CdV1Dv2vupgDxLQBVvtcDJEclDuBbY
 9U9TnzERBZN5CAg==
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
are no major objections, I'd like to let this soak in linux-next for a
bit to see if any problems shake out.

[1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Chandan Babu R <chandan.babu@oracle.com>
To: Darrick J. Wong <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
To: Andreas Dilger <adilger.kernel@dilger.ca>
To: Chris Mason <clm@fb.com>
To: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
To: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: kernel-team@fb.com
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-nfs@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Jeff Layton <jlayton@kernel.org>

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
      fs: add percpu counters to count fine vs. coarse timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 Documentation/filesystems/multigrain-ts.rst | 120 +++++++++++++++
 fs/attr.c                                   |  52 ++++++-
 fs/btrfs/file.c                             |  25 +---
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 224 ++++++++++++++++++++++++----
 fs/stat.c                                   |  39 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  34 ++++-
 include/trace/events/timestamp.h            | 109 ++++++++++++++
 mm/shmem.c                                  |   2 +-
 13 files changed, 550 insertions(+), 78 deletions(-)
---
base-commit: cc8223373449ecbd4c18932820714235db6006c4
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


