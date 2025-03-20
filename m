Return-Path: <linux-fsdevel+bounces-44527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC3FA6A2A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A228A245D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 09:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDC2222AB;
	Thu, 20 Mar 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI7I2ILS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA61C1F2F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462957; cv=none; b=chRnv1BbBHiDGGOUyES0vDSGT4zOGLcWmHomVCTsdRmHaE1MrWDT2G/StmD8Kjm8VxzOY2TOYh+MA9ZSicXisdThcU7U6bEr274h7sPwePYYOZUt3Xkx4GBcZjJ9beO1C3hJVUt5ea3+O70K8YcBsvwbZF7bF63eVDtg4h5SoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462957; c=relaxed/simple;
	bh=s46q9IKEshuin2HRuEjUEoQL4/9671Ai/LAa9a0RtFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Al62+eC/w1GLDzuw919zA1CYSA11USnIKK6qqE3DFtPuWXwSth53CDExeNsGIbr8MlhPHaSeGnwimYzHdSfi4UjAXVgPNJ7NL+Qw3u6vMrkYq3SYDQ2EC0ZX2gdMgTOecZ7dU3G3pax0kce7wIv2ZrVoxX1tPt+c/bMyRP5SS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI7I2ILS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CC8C4CEEA;
	Thu, 20 Mar 2025 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742462957;
	bh=s46q9IKEshuin2HRuEjUEoQL4/9671Ai/LAa9a0RtFM=;
	h=From:Subject:Date:To:Cc:From;
	b=cI7I2ILSftD7WEmv9XMIXlcKp/a0GZEquZYhvfo0YWlgCcalmBVpPEVLUtTD4Pm0p
	 zMTYCDb2z3drz3B8IkJ+G6zi8z4CoZeO32u8XxumlRjyM1NkX+8cruQ2V1gEc2Iz65
	 xWXuSNDR4rBT9YqsBt5R3TXPZT3QYwXNLnfJMrUYkKJDnrWQ9n+QgQzUDMfVfGnibU
	 WmL8iPl9uzZX4HfxX96GGGI+PmZsYbpad2KYPcr0D9N/sAEG3H//w5ZGxdv/V65ycc
	 /ntLC+Pw4p0BYM/Ll8Q2fOqTYSIzep7w5QA/LuIE6tKDHmXLaU9XQ1g6yv5ExjO2QL
	 JM2L+UmWLFWsA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/4] pidfs: handle multi-threaded exec and premature
 thread-group leader exit
Date: Thu, 20 Mar 2025 10:29:05 +0100
Message-Id: <20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOHf22cC/4XOQQ6CMBCF4auYri2hRaB15T2MMQWmtMG0ZIpVQ
 7i7hZUujMu3+L+ZmQRAC4EcdzNBiDZY79Io9jvSGuV6oLZLm/Ccl3nBavrwONDRdjrQySCo7tq
 jv4+UHVgluJaqzBVJ9Yig7XOTz5e0GxWANqhca1Yvpr7KWJlt1BoYGyaPr+2TyNbs/9HIaE6bV
 kIJHRcFyNMA6OCWeezJejXyT0j8hniCeFXXQgqtFYcvaFmWN4m/huQpAQAA
X-Change-ID: 20250317-work-pidfs-thread_group-141682f9a50a
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s46q9IKEshuin2HRuEjUEoQL4/9671Ai/LAa9a0RtFM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfvv/SteqXxOp38TNXvHmd/fvT6bUWJ6Y80VPPvba7S
 3yhTk/X2o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJmNQwMmz/W8iZ/CuN+d4k
 A6E9CYvlr4U/V72f5rrQ9HZCX8Zktk5Ghj1XNH/vqxZT89B6HpDtJtffdUhgxxae2zN4zS1m/Q8
 JYQMA
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

This tiny series tries to address this problem. If that works correctly
then no exit notifications are generated for a PIDFD_THREAD pidfd for a
thread-group leader until all subthreads have been reaped. If a
subthread should exec before no exit notification will be generated
until that task exits or it creates subthreads and repeates the cycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Simplify the implementation based on Oleg's suggestion.
- Link to v2: https://lore.kernel.org/r/20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org

Changes in v2:
- This simplifies the implementation of pidfs_poll() a bit since the
  check for multi-threaded exec I added is wrong and actually not even
  needed afaict because pid->delayed_leader cleanly handles both
  multi-threaded exec and premature thread-group leader exec not
  followed by a subthread exec.
- Link to v1: https://lore.kernel.org/r/20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org

---
Christian Brauner (4):
      pidfs: improve multi-threaded exec and premature thread-group leader exit polling
      selftests/pidfd: first test for multi-threaded exec polling
      selftests/pidfd: second test for multi-threaded exec polling
      selftests/pidfd: third test for multi-threaded exec polling

 fs/pidfs.c                                      |  22 ++-
 kernel/exit.c                                   |  12 +-
 kernel/signal.c                                 |   6 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c | 237 +++++++++++++++++++++---
 4 files changed, 250 insertions(+), 27 deletions(-)
---
base-commit: 68db272741834d5e528b5e1af6b83b479fec6cbb
change-id: 20250317-work-pidfs-thread_group-141682f9a50a


