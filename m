Return-Path: <linux-fsdevel+bounces-44573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970AAA6A712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C0717B3DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C620AF6D;
	Thu, 20 Mar 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvLZ03ki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59991DFE00
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477056; cv=none; b=SOxihKsJ7Ha7x/X4nuBn3pcq+Pw2D5Mvv4etZLgVo7uyg+vvjzFrAcIzrYe5ap/O5BvPzju19xuuEAa95m4U0j8LWfO72zN2y5g9/YHHfQLtgvMa0KsHiAN1pZHcoEIGpRAAkSnVUFqdtU0t55AO0J0U6IHTN8TaEIAKHZ/KGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477056; c=relaxed/simple;
	bh=dduVrgtWct5MRznQuZhJnl7Srvn2+w1L8XXMKvFrhuA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GYR9TeUQO/UNXPatTV/a8pXyUWZ+hywB8WC6o4/3AFH8QEA8OKCW+sHfOhK1QMO2Q6WyTgNJGe9TOIB34twhNEorzQzJ6x6ESa0fINvsg0nqI3/CO1MBQaNpj/cTkdwmaDTpyyG6ndMkCnp+Tg1v6bE6SGLFpdjbRz3e80li+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvLZ03ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96466C4CEDD;
	Thu, 20 Mar 2025 13:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477056;
	bh=dduVrgtWct5MRznQuZhJnl7Srvn2+w1L8XXMKvFrhuA=;
	h=From:Subject:Date:To:Cc:From;
	b=RvLZ03ki+saDX5iDrBSNW5Kwk4KoyEiLIN9fzPl+ToCCHcT2O8gN84fQKnnnzwQIx
	 IUSXQD6zJq1dPy9X4/4Ol75MdTXjPsa6GrNAuwVx8UXgxnk6zmn/8gl6iZdN18Kn+B
	 ymOSsBAiTeu9mwogfPF1ecOCTdwE/12tDzbF288GRTPN1Oy/07P5SbtcJNoHvz3MBA
	 Vpt5Ft1UvtI4sGdv0pm02plZwZdCq5V0yjYNQuoGsCpNab0MT7t5Y/CZp5BO/EuRBW
	 /GbovXyT/boS0xL6tuf+tL/Ov50ZU2smKrCWS9WbrT2djnt+lppcp1tWZ8f9YdaLpa
	 Mn+dKprSDujnQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/4] pidfs: handle multi-threaded exec and premature
 thread-group leader exit
Date: Thu, 20 Mar 2025 14:24:07 +0100
Message-Id: <20250320-work-pidfs-thread_group-v4-0-da678ce805bf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPgW3GcC/4XOwW7DIBAE0F+JOBcLlmBwTv2PKqqwvdgolbGWh
 LaK/O8Fn1JVUY9zmDdzZwkpYGKnw50R5pBCXEo4vhzYMLtlQh7GkhkI0EJJwz8jXfgaRp/4dSZ
 04/tE8bZyeZStBd85LRwr7ZXQh69dfjuX3LuEvCe3DHP1cum3jdTNTtXCHNI10vf+JMta+380S
 y54P3SocQSrsHu9IC340USaWF3N8AjZ5xAUCFpjbGe9d4B/IPUAgXgOqfrIoPYGYVC9/AVt2/Y
 D1FfBe3IBAAA=
X-Change-ID: 20250317-work-pidfs-thread_group-141682f9a50a
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3698; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dduVrgtWct5MRznQuZhJnl7Srvn2+w1L8XXMKvFrhuA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfEfsn6f7wZWKl7/yIjKDGol3KAefXhr+cOvFNVv/6y
 1NrbvtadJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkXT3Db9apRwRvbPvw8FlV
 j5GPf19AgDH753IuJb7EX/+FD+sopjAy3NStOJDMFn427PzVsMzdLgz1rpHB8399VP9ktmZWz64
 2dgA=
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
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20250320-work-pidfs-thread_group-v3-0-b7e5f7e2c3b1@kernel.org

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

 fs/pidfs.c                                      |   9 +-
 kernel/exit.c                                   |   6 +-
 kernel/signal.c                                 |   3 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c | 237 +++++++++++++++++++++---
 4 files changed, 225 insertions(+), 30 deletions(-)
---
base-commit: 68db272741834d5e528b5e1af6b83b479fec6cbb
change-id: 20250317-work-pidfs-thread_group-141682f9a50a


