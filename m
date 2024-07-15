Return-Path: <linux-fsdevel+bounces-23688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D549314AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A2B22F47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AFF18C357;
	Mon, 15 Jul 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHO0YxtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826118C176;
	Mon, 15 Jul 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047751; cv=none; b=UTiZOO4klNFjygCkS4m+7E39WP7fmJuCBRgSK0ZNDUcehapXaEMWxVO1J/n8LtobChAJ4gJyT+IugEg/LSWwQUS7+82jMKwW6UD7FWKWCjXDuDfvWU25FPmzDwIvTjnlE91zp6+Fljj+D9kz9wF4o2Sf5MDxDisAX4KWpbegyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047751; c=relaxed/simple;
	bh=xFFgpft1Mea2W1k9CRfnoGMXT8jsvAC5W7aI49zY2Ho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XsbhcRmzenHvMKxFjCO9t2VfP7tScdIiWJSDyORlINKZm+M11+6hne6RDEpdCfZn0eJGxYTSeOgHtvfVbmf7DmaOEK/Kpzzx1J264z8avgOWZQZwHNSrC/GFgIFel4fgsapAITcGgYeZUkYePxKcPHjySrVMnsOU4ymXVmdxGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHO0YxtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE245C32782;
	Mon, 15 Jul 2024 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721047750;
	bh=xFFgpft1Mea2W1k9CRfnoGMXT8jsvAC5W7aI49zY2Ho=;
	h=From:Subject:Date:To:Cc:From;
	b=hHO0YxtV0sA7lKQy/qpLsAUoBj1SK5dbWWh/2CEfEcmYykhD36/pSSmr7qi/ixBVF
	 jQ0qVn2G1Kctx7Xm/CRjFjBCp0cmcJrckKdNxBA084n9hdWkj55fal7wkSfI0Bwhkn
	 e2/wyIH70/thsGeXp+3qb9BEC1AxXsogak1p2XusxeoG/s9fCWGxD7amUEZz6nz/Kz
	 +eSbbBfQMq8Oguwj6tUjlMYhaHKipf4O+J+TxukYaaBTMYbvn4bFjCkS0gS6nEDygw
	 LOhWc+6Z9oxKKkF9i/dNle20vVbucj4mcDeyWNQz+SaZ0KzI1jvKqTywtRnUVppgrM
	 frsjZG+6s597g==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v6 0/9] fs: multigrain timestamp redux
Date: Mon, 15 Jul 2024 08:48:51 -0400
Message-Id: <20240715-mgtime-v6-0-48e5d34bd2ba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMalWYC/2XOQW7DIBAF0KtErEs0AwyGrHqPqgsw4KA0doUjq
 1Xkuwdn4Tjy8o/mff07G2PJcWSnw52VOOUxD30N+uPA2rPru8hzqJkJEAq00Pza3fI1cmqDAY8
 mGARWn39LTPnvWfT1XfM5j7eh/D97J1yuu4oJOXCHxkoSAZJJn5dY+vhzHErHlo5JvFwDuDpRH
 dqgUDirINidk1tHq5PVGfIiOGe9lLRzauvM6tSyE5JsdfLUJLlztHH42knVycZ78kpTiv7NzfP
 8AGWAWtd9AQAA
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
 Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3631; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xFFgpft1Mea2W1k9CRfnoGMXT8jsvAC5W7aI49zY2Ho=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGaVGr2g4UrC2NR/JuNqzaZKyhN0Ef4ZmpMvcH7PbDDPZHHRV
 IkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJmlRq9AAoJEAAOaEEZVoIVTjQP/jX+
 FkDKAs3wVJ5Axae25xxqh3+9eKr0TZGpOgkPagjwLT6v3f9XdjTx2D+ny31MbxZx/8McTCh5CqJ
 MGiEx4rfChljA39Fo/tW9wXGqNRPbnTWdKXc4PfP6WoC0NVtDBRFQtLB9NypjpBFG8NEMhzxWHi
 7d4e3cfDb9xiU6JM0NjmIligXvUQiWXAKnzPfPQO2IFF4dbLuMieQdwv2aJcpR6dFseL1XsEWSP
 CEvJfHO1LicNtZ2HnTCUN4THmgXqRq2+DCAh13kGt63mbgaWg2ZdMaxzjlKn0Q6PzgYGca0jJJS
 /6R4MROk86E+GnGt7CkR42Qll5QKwzReKTCAlZBQBuECkMcOTMGUaJnMKBb4aSH+pgfdEO53CQ3
 f/jO/nubRe3e1M7r7xjT3fGDfTXAecDgT8CjXnAlGDjyXfapx+cjnMSROMycWqsPxaVAlZmSKXt
 nxZ5qgK/wv5IwQt9KknfIKDoV6xiK+u27ekJ+feAYc/e5dUd+m2AzN+LIf3X0K8n917ky5sZKvB
 mhpyaxFsNuX78/dILLUSGbie3FmjWHzJokfYwLfrwSUt3LYE4YXJ/gXEgHs+eQhmU8HV0GiD4QQ
 nKvv2railk/i6NH5pvQy2msnvWcNvs2yvwaMevWsvEqFLM6yFTMJH90b3Rw/l3SSF7mq6YQrGzf
 DJstS
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I think this is pretty much ready for linux-next now. Since the latest
changes are pretty minimal, I've left the Reviewed-by's intact. It would
be nice to have acks or reviews from maintainers for ext4 and tmpfs too.

I did try to plumb this into bcachefs too, but the way it handles
timestamps makes that pretty difficult. It keeps the active copies in an
internal representation of the on-disk inode and periodically copies
them to struct inode. This is backward from the way most blockdev
filesystems do this.

Christian, would you be willing to pick these up  with an eye toward
v6.12 after the merge window settles?

Thanks!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
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

 Documentation/filesystems/multigrain-ts.rst | 120 +++++++++++++
 fs/attr.c                                   |  52 +++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 251 +++++++++++++++++++++++++---
 fs/stat.c                                   |  39 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  34 +++-
 include/trace/events/timestamp.h            | 124 ++++++++++++++
 mm/shmem.c                                  |   2 +-
 13 files changed, 592 insertions(+), 78 deletions(-)
---
base-commit: bb83a76c647a96db4c9ae77b0577170da4d7bd77
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


