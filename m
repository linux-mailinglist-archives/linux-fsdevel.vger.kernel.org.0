Return-Path: <linux-fsdevel+bounces-22576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D0919C85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF552864C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0376AC0;
	Thu, 27 Jun 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9ba/YQc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E24C62;
	Thu, 27 Jun 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450034; cv=none; b=He0RPVxCXXEtnYX0+BUOySTuxvgF5nMxG1Z7mDwuf+k+8ogogIXpQprqOl48w5qG47nkLWXNKLmbe6Czr9aPu5ZDDhnUgowZiP66o1zjZa/4kVQRozDMv/z1wtSFneuWuOjeHWxnySWKhEqrFTDjDeOZmjjJS8IiYXrQkWLNd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450034; c=relaxed/simple;
	bh=LUacYIlT79rW04FeLla3/n41llR1qlk2oIplHlsSCo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C+V4ZHKdhToK6fhXbpM1oPUEjO4AJ4DwN7v5FvcWb4fl/4ajfSeMNgsn/JjeFivqnuHpPxEne/b9/AQ/hq3gVCGOKP4fZUks/rQPTl6gPgm2mRLcC+QEBlxgSr9tnepo3Jp7i5+6TPMACZx7WSfQ/t0QkWuybE4hqlQGd/L/K78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9ba/YQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C54C116B1;
	Thu, 27 Jun 2024 01:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450034;
	bh=LUacYIlT79rW04FeLla3/n41llR1qlk2oIplHlsSCo8=;
	h=From:Subject:Date:To:Cc:From;
	b=X9ba/YQcgXhwCm8/TJ8Uh4mp258noDC2rr0AaFBl0BEPkB9XQSpA9M/tEdKbW40tB
	 X+Z6OGP+Si5nRlkpsVLibkf4AiJAhojO5s5V4kpdXBIJSvoviXwiDj2FaKW9uWMIAF
	 4MJe8FP26sA3j5dAvuApRF0se7CFUhvx/9I/7Ypf06bwRsiLc+H3ZydlyzSjxhuOQy
	 R4nTwxqZPHonjDzgUF/boDRbHPm/GCueYfwTcNMQfuNdRA6mEcLGkfR/cpyvCK45yD
	 JEtcOJ0ldQB1gqsLGla+o6eQDD+OE0qG0jN1ui8Y+8pFdGfOAeReIE+TaGQIdyro9B
	 lzDTU8RbwnwwQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/10] fs: multigrain timestamp redux
Date: Wed, 26 Jun 2024 21:00:20 -0400
Message-Id: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKS5fGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMz3dz0kszcVF3T5BQLgyRDixQLQwMloOKCotS0zAqwQdGxtbUA/AJ
 kIFgAAAA=
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LUacYIlT79rW04FeLla3/n41llR1qlk2oIplHlsSCo8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmuyaAFpK8/qwLflf3v4ChVsLVE+AkNZRWYo
 JubBGmnD9+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rgAKCRAADmhBGVaC
 FcVxEACn53hnX+vD8wOy1qsZk+3QM/qqzDCO7uy8RgExJI106gkJfuFX8+lcL+HRdrW2QfOGSw+
 hO7Mt3G37n3x1PsLI2i2L3wKymPJkPtkN0gCUDRhqkHhXfjGWMiAYKcupUoOQgd3/5sUw/wVOCn
 gxb4joKDPQjyDOuFdQP/iiNryS6CSID8IXYPqpgksIsTrI82/iB6MW5X0/XiO53z+TGnMEIyLHy
 P62o2CEnPUm77LjIIamrxVwCpX1qLDDUt4zXOf5PU+KQq+Cmo+3hFTZEYW1qFsWUOPaKoGLW2vc
 cCHBezSmioQNmG4EyshecGnFRdqkKvZM69d9AXpw0PjJOpF1X90HsqY9e46vLExXidPMU3sOo01
 dFvdrSLUHmDnX7cmaEakCVuKv+EQRzodyHNKI12T9IsuPl0cXsJVgWTlunlLF2nnHPp4uGiC0K6
 Dx0bk6gvhtz/eH66y2wnXWr0Q3xAMJ/SxYdqWfIArsqDw7LBA40+erE6CKTDPAf9VRsfTcO0ura
 SaHhLn470dWvbxOVa/L15AfDgNL+Y24+RWVrD3UYAOmDIKDyj3Ki+s8359EemA9FRV8FGJhjUhL
 ij+SmnVh0io7cDczz/QZh+y5Cy/DLAd3/lDWZuSoTZVLrvn5tepmBjcI0URpN1uvHG6ODJ3s/3M
 vO1R8IE1b5/DaDA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At LSF/MM this year, we had a discussion about the inode change
attribute. At the time I mentioned that I thought I could salvage the
multigrain timestamp work that had to be reverted last year [1].  That
version had to be reverted because it was possible for a file to get a
coarse grained timestamp that appeared to be earlier than another file
that had recently gotten a fine-grained stamp.

This version corrects the problem by establishing a global ctime_floor
value that should prevent this from occurring. In the above situation
that was problematic before, the two files might end up with the same
timestamp value, but they won't appear to have been modified in the
wrong order.

That problem was discovered by the test-stat-time gnulib test. Note that
that test still fails on multigrain timestamps, but that's because its
method of determining the minimum delay that will show a timestamp
change will no longer work with multigrain timestamps. I have a patch to
change the testcase to use a different method that I will post soon.

The big question with this set is whether the performance will be
suitable. The testing I've done seems to show performance parity with
multigrain timestamps enabled, but it's hard to rule this out regressing
some workload.

This set is based on top of Christian's vfs.misc branch (which has the
earlier change to track inode timestamps as discrete integers). If there
are no major objections, I'd like to let this soak in linux-next for a
bit to see if any problems shake out.

[1]: https://lore.kernel.org/linux-fsdevel/20230807-mgctime-v7-0-d1dec143a704@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (10):
      fs: turn inode ctime fields into a single ktime_t
      fs: uninline inode_get_ctime and inode_set_ctime_to_ts
      fs: tracepoints for inode_needs_update_time and inode_set_ctime_to_ts
      fs: add infrastructure for multigrain timestamps
      fs: add percpu counters to count fine vs. coarse timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps

 fs/attr.c                        |  52 +++++++--
 fs/btrfs/file.c                  |  25 +----
 fs/btrfs/super.c                 |   3 +-
 fs/ext4/super.c                  |   2 +-
 fs/inode.c                       | 222 +++++++++++++++++++++++++++++++++++----
 fs/stat.c                        |  39 ++++++-
 fs/xfs/libxfs/xfs_trans_inode.c  |   6 +-
 fs/xfs/xfs_iops.c                |   6 +-
 fs/xfs/xfs_super.c               |   2 +-
 include/linux/fs.h               |  61 +++++++----
 include/trace/events/timestamp.h | 173 ++++++++++++++++++++++++++++++
 mm/shmem.c                       |   2 +-
 12 files changed, 514 insertions(+), 79 deletions(-)
---
base-commit: 33b321ac3a51e590225585f41c7412b86e987a0d
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


