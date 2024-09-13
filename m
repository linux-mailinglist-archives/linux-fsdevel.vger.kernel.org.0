Return-Path: <linux-fsdevel+bounces-29317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28317978198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB73A1F21215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D891DC047;
	Fri, 13 Sep 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlvPP8gh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697E1DB533;
	Fri, 13 Sep 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235661; cv=none; b=o/43UEqDBZM0vBAINeymuMhqigcfxiySaAXQ/EpWG+lDgsVrVOVM3KdTdD3YWqx1V3aUS9kIL2JoufFSnQFxIYXKNdcO2LztzIuHfusdZhIcRwueoz/DP0rYlfKxn8dxwrq3XsQiIsYItPLQ0G6SOoKKJyG4S9wDddbk0h07kzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235661; c=relaxed/simple;
	bh=yUDX1L5zIhXfZWAvQGFRbCdKV8NwPBAWna+kswkxPuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uaCu4LINVP23Xw4U+YrjjkUaag4q4Tb6yj0EGLC13W5AojJ0soFLHML9+Z+qDf0NtM0+l0RBFB0oivRESG/9spPFhVs9xWAGREUAr8lYWUQ8VpOme5TY8QmTNYLtHHlEXHgItubPNMEENIlFohLFONsk256mB9eiZiZBxQkoZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlvPP8gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9B7C4CEC0;
	Fri, 13 Sep 2024 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235660;
	bh=yUDX1L5zIhXfZWAvQGFRbCdKV8NwPBAWna+kswkxPuc=;
	h=From:Subject:Date:To:Cc:From;
	b=YlvPP8ghUUluaCjE+TMLAs0SU6H+CvMmlgnwLlYPyf4gqLyZrBKb9SsK0yAGLrW4s
	 I5tM4aGvRjYgEBnGRvrg8n70FBva6KIonU4V83d3+kMzEy/V6sbQxAjEYd96zlJFCj
	 Gy7M5p7ES7Zm7Ccmpg872uALvkpoUEi6oHoqS1dfhkxvykSxXHcNYEQ0hrmq8H4XYM
	 5iiFqPA7IFm0qTOEVF9Bj3oxNuvQZjqXCHRKjQiAeh40iVcTrCoLFxkSvxKLoW9jKH
	 A9LpOS2KB2xLubBnfKicbcsea64INT8E1U4IZ7e8l17sIaWvn61xJhJBa1ri1ihSdc
	 LXv3LHBTveQqA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 00/11] fs: multigrain timestamp redux
Date: Fri, 13 Sep 2024 09:54:09 -0400
Message-Id: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFE5GYC/zXMyw6CMBCF4Vchs7amlFth5XsYFrQdYaK0ZkqIh
 vDuVozL/+Tk2yAiE0bosg0YV4oUfIrmlIGdBj+iIJcalFSlbPNCzONCMwolbauNdYPWCOn8ZLz
 R64CufeqJ4hL4fbhr/V1/RJNXf2KthRSlxsoVpXHKDJc7ssfHOfAI/b7vHyH1TRydAAAA
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4945; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yUDX1L5zIhXfZWAvQGFRbCdKV8NwPBAWna+kswkxPuc=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQHUabYmQ8O9utWRpfIzA4y/7I7lsBUmSOsu
 +pMPwbszJmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuREBwAKCRAADmhBGVaC
 Fb1XD/9d0BiHJACIE25SlsnPn+K7f8kbnu+3syFIxHlg3sQLIvQIofGPpuck3SHMGuV1N8An9kh
 oDmH6vImXFDl0M4RukRiKtGI0oXvPSunyHFs3otRs+rxMVlk++EIH4OMXjOsn9UHOZyZTElAyzP
 eEGQgKxuT3Au6NrUIgqhsaN0ZI9SAkok6P+ESk9o6eUl2f85iN4HelsdhrKcbD6tqrWcw/ufr7G
 oppSotRh9dJiCHPhuGUVThjE7kxjDqohEPkEtRKLN3sh3TJmj50b1YJhxK3QHJJagh1AO4IYFNm
 8mfoGQTrrPPnkcUQOBNw7OkW+NYmokob8cFZDQ00xNYx95RxMnF97DkpjlbPKzvM9LlGgzRY15w
 o/H2jhnry24sirqS4wJn5WhrNVBMMDF4YDkBUDuMSNhGWM+dGCAYgwazVOBZveDm7ZLlp4Na+sQ
 7XzTHR2Vet4vdVC24V57XWo31sTzbqF+QO86GOMyeMaO9DXYdF/jRwl7bXbVa/k7gHAreaHa/gl
 ofjxQgrweclwWeOaIiik7my4iTjuOieaPDN62McvgvnMTW/jGqModKBeH8WpnX/oILw2kZEHQdq
 TLOzsTBoATE0fehknRRBxtkpWQnTAU9O5PmdAXOVQU11NRdW/2vkjKmTLabESaqsyRP9hyMmv6T
 LEe/exNVGG/AHEw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Once more into the breach, dear friends!

This is a replacement for the v6 series sitting in Christian's
vfs.mgtime branch. For the uninitiated, the main rationale for this
set is described in the changelog for patch #2.

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
 Documentation/filesystems/multigrain-ts.rst | 121 +++++++++++++
 fs/attr.c                                   |  60 +++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 271 +++++++++++++++++++++++++---
 fs/stat.c                                   |  42 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  36 +++-
 include/linux/timekeeping.h                 |   4 +
 include/trace/events/timestamp.h            | 124 +++++++++++++
 kernel/time/timekeeping.c                   |  81 +++++++++
 mm/shmem.c                                  |   2 +-
 16 files changed, 717 insertions(+), 73 deletions(-)
---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240913-mgtime-20c98bcda88e

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


