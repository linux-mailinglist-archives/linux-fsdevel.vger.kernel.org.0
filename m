Return-Path: <linux-fsdevel+bounces-22855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7991DC73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F927B25A40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AE9143C4E;
	Mon,  1 Jul 2024 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vf+KOvFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC5612C486;
	Mon,  1 Jul 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829628; cv=none; b=nr907TUxMiIPiDM8qxVmudbKR1475DJ7J+kZ9xzTJWobOJRJYwLNRMw9+qleiHt4r2FTGooGgKYm6rRiE2lD5pzYeBBKKgmosMWQtWj7sVeT/fGUZWBDLmqbqnHEAyE1+QtGejTZOLVr29UyHNuwTTRTnXcBy9Hp5zz9x03hLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829628; c=relaxed/simple;
	bh=X6JnNaUpmLXm/etsj1wjIh6Yp85tWQSB7sG1ZkO5uUo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aNBvx+6AygEdqOb1vQs/mPAwO0Z8X8LlColdthzknqCVMPHASWprmI1fstOCuJsxNDWK2HAPGyTQylF+r9KjN4f7eOIs7KyGVrtFJADmRwzWEJfzc4fYMFFoDGHvwBv9C/jJvGkulPO3BtiafOGJd/W3i/w54ZIyf8NNd1zwTYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vf+KOvFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A2DC116B1;
	Mon,  1 Jul 2024 10:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829628;
	bh=X6JnNaUpmLXm/etsj1wjIh6Yp85tWQSB7sG1ZkO5uUo=;
	h=From:Subject:Date:To:Cc:From;
	b=Vf+KOvFJKBw679ZYAgmsH0RLuGYp8IAiSlCCZUhsTO4bKK7aVVnIt6i4tns2GxcVc
	 arXIZflCj58WmK6HjROQJKCEmt3cQ5z0Hzi3pn3cztxRDFM9AW3TTN05aRVRbzfTIP
	 nb/Zx0ZvRRprqg1+Pe8fWPIbcD8w30t2kT6oAPo+uHh9tj3fWC6GkC1S99hRvIETG8
	 521TVFm4Rxsi2Kpi4RFWUdZBsF5bKnOYBn+8q1ndAmtmtM2N3/ewIfHvBZfYQtQ7KW
	 HZaynh8qe10p4ksacSS8KtMrPUEca2HAktvREYgJJmRJZftrOhVHQ9Oj0ZFkjFs9uC
	 8nHV+WEk81uqA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/11] fs: multigrain timestamp redux
Date: Mon, 01 Jul 2024 06:26:36 -0400
Message-Id: <20240701-mgtime-v2-0-19d412a940d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFyEgmYC/2XMQQ7CIBCF4as0sxYDaBt05T1MF7UMdKKFZmiIp
 uHuYrcu/5eXb4OETJjg2mzAmClRDDX0oYFxGoJHQbY2aKnPstOdmP1KM4p2tEY+lLFGSajnhdH
 Re4fufe2J0hr5s7tZ/dY/IishxaDM5dRqK51xtydywNcxsoe+lPIFCXxMlJ0AAAA=
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
Cc: Andi Kleen <ak@linux.intel.com>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3820; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X6JnNaUpmLXm/etsj1wjIh6Yp85tWQSB7sG1ZkO5uUo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmgoRw4WRZGASUb0ntKxZvyqMtYMkx8cPpzxKSo
 7jHqLZ2ou6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZoKEcAAKCRAADmhBGVaC
 FRklD/0V9mb072IqdAyazN2How8Y2mDXc3TC/CKJ07/XI2o0+GsYhF4MwAHLt4dLmtP0m5lVEYt
 IXSS117t5QAbroXjMGDO78L/ngFJ6XHQNs8ApzjMPUa8wiawbeiKGEYtqgRm0+QcHsSkXtOKbfN
 /YpUKYMts3Zt4XXHBcfdJNv2QCNem83SoduUEY5ZGw+Cm3Zi428oPzX4zNx+KGveuc0atwcVkoM
 bNcs4Ua8HzyOOjnAZPcbSyLDv7nl4Lp8AeF86Pzg9s/TpY1We1cUclLV4H0DBoGVSc6rYrn73IJ
 F6XwQI5jldA2SxQpsuUq3Q9fRBGLIvU82LiSsJ6TuneSFb/nlLahtrbfTsFZKeBv1T8AtN/Bm3g
 7JF8I8BESppicGDpFegi78JzwQvXq9QqPEeQoL7aFSVVBjDjlqz5kGT+3dZn5T6RoKRMPqNiTGY
 jIBsiFOWOR2qM8jpIb5mwYfHjSJSVf0FYhYrzNiOBhC60Mo5QrsyK73HTwf0ouEznjygtcaOgqs
 FevfDb09sW8WOF9igWYRK8bqpYkDbxPGVkflRLNElGxBooBGRokJsXnKOj63BWkqpAmZxct3dR6
 zcO9QewsnTTV5FQuOh/q1SzW+lOoa+eIAOqMTV8bsC+bXen4HUI4jXfhPlhbAOHNxurzh0M7nLT
 mBgV2UQww4zEPtQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This set is essentially unchanged from the last one, aside from the
new file in Documentation/. I had a review comment from Andi Kleen
suggesting that the ctime_floor should be per time_namespace, but I
think that's incorrect as the realtime clock is not namespaced.

At LSF/MM this year, we had a discussion about the inode change
attribute. At the time I mentioned that I thought I could salvage the
multigrain timestamp work that had to be reverted last year [1].  That
version had to be reverted because it was possible for a file to get a
coarse grained timestamp that appeared to be earlier than another file
that had recently gotten a fine-grained stamp.

This version corrects the problem by establishing a per-time_namespace
ctime_floor value that should prevent this from occurring. In the above
situation that was problematic before, the two files might end up with
the same timestamp value, but they won't appear to have been modified in
the wrong order.

That problem was discovered by the test-stat-time gnulib test. Note that
that test still fails on multigrain timestamps, but that's because its
method of determining the minimum delay that will show a timestamp
change will no longer work with multigrain timestamps. I have a patch to
change the testcase to use a different method that I've posted to the
bug-gnulib mailing list.

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
Changes in v2:
- Added Documentation file
- Link to v1: https://lore.kernel.org/r/20240626-mgtime-v1-0-a189352d0f8f@kernel.org

---
Jeff Layton (11):
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
      Documentation: add a new file documenting multigrain timestamps

 Documentation/filesystems/multigrain-ts.rst | 126 ++++++++++++++++
 fs/attr.c                                   |  52 ++++++-
 fs/btrfs/file.c                             |  25 +---
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 221 +++++++++++++++++++++++++---
 fs/stat.c                                   |  39 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |   6 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  61 +++++---
 include/trace/events/timestamp.h            | 173 ++++++++++++++++++++++
 mm/shmem.c                                  |   2 +-
 13 files changed, 639 insertions(+), 79 deletions(-)
---
base-commit: 2e8c78ef85682671dae2ac3a5aa039b07be0fc0b
change-id: 20240626-mgtime-5cd80b18d810

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


