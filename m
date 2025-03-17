Return-Path: <linux-fsdevel+bounces-44203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE4A654D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935E7172126
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 15:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B522759C;
	Mon, 17 Mar 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZpDaXnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA87143748
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223661; cv=none; b=GJA0rlF3ooh3Bc5ezBrVqsjhoB6ZfhWK+YLFSfnOuyA2IEGNsF/BGi8l+NVX1bSoJpC+fky6VW468fEAJq2DTOLSUVvIfBNrv5v36H8GfV6Viis+Vu9YEXvSeXvi+3BaYKOKJZlZfKeX+mXLssmLUM9QxghHoOHyGEz4z0JegHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223661; c=relaxed/simple;
	bh=G+6/uVIDf3ivBHC0XlzdncnQ6ImkvFmrW+xTrbErlfY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iGhi3d/2W79dpjqV3zB2Tk2JB+oHa/J/A2juFc+BD6azTdIHaZC/ZabQQBuC+YH3MYt+H7eeDtlLdi/30snrB2VqGq+Cjn8yQNglvggNiE/zY+kYKdE5Djgu+9fRtj4QymqcbFbqZaFbAJ4pFUXs4kVSXlfdoF47OJ470+6HKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZpDaXnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518FFC4CEE3;
	Mon, 17 Mar 2025 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742223660;
	bh=G+6/uVIDf3ivBHC0XlzdncnQ6ImkvFmrW+xTrbErlfY=;
	h=From:Subject:Date:To:Cc:From;
	b=fZpDaXnFYOhRpwQRFUOygRCOu8hggtUsh/XhIseVpUZuP7mcAQ6aQQaG+GU5h4zAI
	 Hn8rnO7P2sfdHPAMCWF5+77KzOoGY7XSfGc7K+MWDJcIP+SuEGeU2hDf9tjdHCkXFN
	 BhDRY26Ihm14wPKdfw5kap5cVY+hz487ye367B6TqsR1SLl+m+T0hjnV19NpSkFMbP
	 VzB+BXXJdOXJNL4m/y6er2uGdHHB6QteaCUPqt/caRiNi3zcwfJh6GauEV0KTiM1sS
	 iuCIublYuNHpJtbtJ6WurLBoU1hQ6zdJoIXCI7yQ+qAkglgDE/yT5XURYLH7OZG/ay
	 5gE3B0WzdFxSg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] pidfs: handle multi-threaded exec and premature
 thread-group leader exit
Date: Mon, 17 Mar 2025 16:00:42 +0100
Message-Id: <20250317-work-pidfs-thread_group-v1-0-bc9e5ed283e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABo52GcC/x3MywrCMBCF4VcpszYliaZetoIP4FZE0mbSDEISJ
 lqF0nc3dvkfON8MBZmwwKmZgXGiQinWUJsGhmDjiIJcbdBSG7lVe/FJ/BSZnC/iFRite4yc3lm
 oneoO2h+tkRbqOzN6+q7yDa6XM9zr2NuComcbh/BHp4p0rTLt6sGy/AAJB/QHjwAAAA==
X-Change-ID: 20250317-work-pidfs-thread_group-141682f9a50a
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3034; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G+6/uVIDf3ivBHC0XlzdncnQ6ImkvFmrW+xTrbErlfY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfsNTayaEYeGmy7QqHJ5+8Z6xKOH37U4e680kfQRvpw
 i0dW+ySO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayYRbDP3v9LbvXH75xymda
 pOk5BVW3V+IzfZJOGIo7Lr/w8XzkEmNGhiMmvRZ2xT5BuyYcNn7NoPfULeqwYMWlEh+1vnbDXSv
 NmQA=
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
Christian Brauner (2):
      pidfs: improve multi-threaded exec and premature thread-group leader exit polling
      selftests/pidfd: test multi-threaded exec polling

 fs/pidfs.c                                      | 28 +++++++++++++++++++++++--
 include/linux/pid.h                             |  3 ++-
 kernel/exit.c                                   | 24 +++++++++++++++++++--
 kernel/pid.c                                    |  9 ++++++++
 tools/testing/selftests/pidfd/pidfd_info_test.c | 23 ++++++++++----------
 5 files changed, 71 insertions(+), 16 deletions(-)
---
base-commit: c0ff2d6e30f20fd943eac5cdc3b0e89f2f2566ce
change-id: 20250317-work-pidfs-thread_group-141682f9a50a


