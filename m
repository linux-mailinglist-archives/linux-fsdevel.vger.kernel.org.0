Return-Path: <linux-fsdevel+bounces-44302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8667EA6705E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 10:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD7E3B4367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA6A207A35;
	Tue, 18 Mar 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFEy4n1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC51F180C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291549; cv=none; b=UwNQLJnv3FrvA8Rw9y8b9TcXUZdPWz3wQrxHtZQyc1vwY01ROEqfa3XHhMdodLK7LvcK5C5OyZwPembrg24aO64bk2rrtVwuNuoXyTM/DDCEvoqKktLSB3jsy5cAFQHDFC+WScsBBaA42G9IADpOhvkGIx6fgZJ8yg3EaSRZmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291549; c=relaxed/simple;
	bh=D+BSsm4NHo/xG52gFTKSV38y0QVATml2cmiy6/0R0jI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lXP24eMz9JziA18CUAHcwtjU01K6hal1k9Z4ISS3/G47l4iC5drhxj4jZjPr/B4SS7UKZRM6ys+uYdGVycCkbZSDfm5eBsG3QKHAv1ooThk+Iz0r/tLCbfQuM4CvndUvtRKI+FQwwLwEczCX83fjKH4hg7CdEbPEedWew6IRX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFEy4n1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA44C4CEDD;
	Tue, 18 Mar 2025 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291548;
	bh=D+BSsm4NHo/xG52gFTKSV38y0QVATml2cmiy6/0R0jI=;
	h=From:Subject:Date:To:Cc:From;
	b=jFEy4n1glbDa4d/xFhZ0sAhzrepQhCohc49eZ1FM5fFjPH/E4WReLbCzYuoMdTgfI
	 Js+r+fEQ477z/xAVWrA0btnuV3Dbcx7F6wqfz75M52mjB3uWTdOmMAsvezYY7noB4s
	 i9mFTAqPqF1TLBFrN9dJWmDA42Mc2XZ1vj6LOMKNOTYhDZIsZylZrHKq41jXlTP75a
	 8xHKXXlMwvxkDBPi52zXjIx56bw2zyobS+CoEoT50D+L/F4SbtWMgGdQezYrJRpL1j
	 IuX6SrelTgKz5pXmy3TVlF+MOPi0W7C2gMbt5vEXKgwovKfg4vFOjf2oaQRCmAkQ3u
	 6odw13msLLGeA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/3] pidfs: handle multi-threaded exec and premature
 thread-group leader exit
Date: Tue, 18 Mar 2025 10:52:15 +0100
Message-Id: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE9C2WcC/4WOQQ6CMBREr0L+2pK2CIorExMP4NYQU+gHGgwlv
 1g1hLtbegGXM8l7Mws4JIMOTskChN44Y8cQ5C6Bpldjh8zokEFymfNMHNjb0sAmo1vH5p5Q6Ud
 H9jUxsRfFUbalyrmCQE+ErflE8x1u1wtUoayVQ1aTGpt+k/ogKVKRp9G3Ub1xs6VvvONFZP8ue
 8E4q5sSc9TymGF5HpBGfKaWOqjWdf0BDBKVP+UAAAA=
X-Change-ID: 20250317-work-pidfs-thread_group-141682f9a50a
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3510; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D+BSsm4NHo/xG52gFTKSV38y0QVATml2cmiy6/0R0jI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfdIq6JHpON3SLwLfQ/5LPJpptOuL9We7cVIlHO5qPc
 rzMyVV93FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR83WMDF8Kouo4M1LdxN4c
 O3S73m1D/73rX5v3TbPIufqzeNkGg7OMDC+e15zizaremrXDL7yO0+/z9uTT09ysNPN8Fx9Z+UB
 6FysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Oleg,

Don't kill me but this is another attempt at trying to make pidfd
polling for multi-threaded exec and premature thread-group leader exit
consistent.

A quick recap of these two cases:

(1) During a multi-threaded exec by a subthread, i.e., non-thread-group
    leader thread, all other threads in the thread-group including the
    thread-group leader are killed and the struct pid of the
    thread-group leader will be taken over by the subthread that called
    exec. IOW, two tasks change their TIDs.

(2) A premature thread-group leader exit means that the thread-group
    leader exited before all of the other subthreads in the thread-group
    have exited.

Both cases lead to inconsistencies for pidfd polling with PIDFD_THREAD.
Any caller that holds a PIDFD_THREAD pidfd to the current thread-group
leader may or may not see an exit notification on the file descriptor
depending on when poll is performed. If the poll is performed before the
exec of the subthread has concluded an exit notification is generated
for the old thread-group leader. If the poll is performed after the exec
of the subthread has concluded no exit notification is generated for the
old thread-group leader.

The correct behavior would be to simply not generate an exit
notification on the struct pid of a subhthread exec because the struct
pid is taken over by the subthread and thus remains alive.

But this is difficult to handle because a thread-group may exit
premature as mentioned in (2). In that case an exit notification is
reliably generated but the subthreads may continue to run for an
indeterminate amount of time and thus also may exec at some point.

So far there was no way to distinguish between (1) and (2) internally.
This tiny series tries to address this problem by remembering a
premature leader exit in struct pid and forgetting it when a subthread
execs and takes over the old thread-group leaders struct pid.

If that works correctly then no exit notifications are generated for a
PIDFD_THREAD pidfd for a thread-group leader until all subthreads have
been reaped. If a subthread should exec before no exit notification will
be generated until that task exits or it creates subthreads and repeates
the cycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- This simplifies the implementation of pidfs_poll() a bit since the
  check for multi-threaded exec I added is wrong and actually not even
  needed afaict because pid->delayed_leader cleanly handles both
  multi-threaded exec and premature thread-group leader exec not
  followed by a subthread exec.
- Link to v1: https://lore.kernel.org/r/20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org

---
Christian Brauner (3):
      pidfs: improve multi-threaded exec and premature thread-group leader exit polling
      selftests/pidfd: first test for multi-threaded exec polling
      selftests/pidfd: second test for multi-threaded exec polling

 fs/pidfs.c                                      |  27 +++-
 include/linux/pid.h                             |   3 +-
 kernel/exit.c                                   |  24 +++-
 kernel/pid.c                                    |  10 ++
 tools/testing/selftests/pidfd/pidfd_info_test.c | 181 ++++++++++++++++++++++--
 5 files changed, 231 insertions(+), 14 deletions(-)
---
base-commit: c0ff2d6e30f20fd943eac5cdc3b0e89f2f2566ce
change-id: 20250317-work-pidfs-thread_group-141682f9a50a


