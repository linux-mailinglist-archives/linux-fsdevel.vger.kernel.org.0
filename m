Return-Path: <linux-fsdevel+bounces-7465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE4B82537A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 13:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F01B2325F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 12:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35852D602;
	Fri,  5 Jan 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogX2BBB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6D2CCBF;
	Fri,  5 Jan 2024 12:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC6C433C7;
	Fri,  5 Jan 2024 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704459099;
	bh=DbfRqxiggwOs+/bTVDzKnSxknNbZ1VMNtVqFjwgoLwE=;
	h=From:To:Cc:Subject:Date:From;
	b=ogX2BBB50BoVEuv/EshJH/AWVRdyMxJl8rR7IHlug3gFq7kj1kz6lU7+O+6BUgpnc
	 Noe74tZ6XwEH6DnW7dVGd/ICNTSbDF7h8He4S+/Hpk93XIXqgv4S9bckECIdhLbYaR
	 0h89CED4yHj0YqCxjPfLU+EGSzIr/trdlLzkzIrFmkvq7Qyy3wE1P3p3iE7IzEUTby
	 bcTU1HHxj4BJ5uwL+2oF7zaWghh/71U9BGmC8PaJ2Ad1BgRdFbgHTFX/vuWvz9dgzv
	 9ouCM1xG+243wG046PFpVx+feyj+oquvz5TGXUusgcO4P4eG29hfiinzVyn0OpWGO9
	 iTIVspx0XED1A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs cachefiles updates
Date: Fri,  5 Jan 2024 13:51:23 +0100
Message-ID: <20240105-vfs-cachefiles-c2fe8c0b01b6@brauner>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3265; i=brauner@kernel.org; h=from:subject:message-id; bh=DbfRqxiggwOs+/bTVDzKnSxknNbZ1VMNtVqFjwgoLwE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRO/+3VFKv/uFQ+pfiK852kKRbrCtu0Vm37N2fqSjf5L NmzxgkiHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5rcTI8CCs+YW6B6N+Pt/J 3UHzLffp/o5z4U1dtb3Fn6Ftrzf3TIZfTG5/s799lbpXuDvgwZQ10oIiR74Jhn3eMT97TsHzkjV 13AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains improvements for on-demand cachefiles. If the daemon crashes and
the on-demand cachefiles fd is unexpectedly closed in-flight requests and
subsequent read operations associated with the fd will fail with EIO. This
causes issues in various scenarios as this failure is currently unrecoverable.

The work contained in this pull request introduces a failover mode and enables
the daemon to recover in-flight requested-related objects. A restarted daemon
will be able to process requests as usual.

This requires that in-flight requests are stored during daemon crash or while
the daemon is offline. In addition, a handle to /dev/cachefiles needs to be
stored. This can be done by e.g., systemd's fdstore (cf. [1]) which enables the
restarted daemon to recover state.

Three new states are introduced in this patchset:

(1) CLOSE
    Object is closed by the daemon.
(2) OPEN
    Object is open and ready for processing. IOW, the open request has been
    handled successfully.
(3) REOPENING
    Object has been previously closed and is now reopened due to a read request.

A restarted daemon can recover the /dev/cachefiles fd from systemd's fdstore
and writes "restore" to the device. This causes the object state to be reset
from CLOSE to REOPENING and reinitializes the object. The daemon may now handle
the open request. Any in-flight operations are restored and handled avoiding
interruptions for users.

[1]: https://systemd.io/FILE_DESCRIPTOR_STORE

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.7-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8.cachefiles

for you to fetch changes up to e73fa11a356ca0905c3cc648eaacc6f0f2d2c8b3:

  cachefiles: add restore command to recover inflight ondemand read requests (2023-11-25 16:03:57 +0100)

Please consider pulling these changes from the signed vfs-6.8.cachefiles tag.

Happy New Year!
Christian

----------------------------------------------------------------
vfs-6.8.cachefiles

----------------------------------------------------------------
Jia Zhu (5):
      cachefiles: introduce object ondemand state
      cachefiles: extract ondemand info field from cachefiles_object
      cachefiles: resend an open request if the read request's object is closed
      cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
      cachefiles: add restore command to recover inflight ondemand read requests

 fs/cachefiles/daemon.c    |  15 ++++-
 fs/cachefiles/interface.c |   7 +-
 fs/cachefiles/internal.h  |  59 +++++++++++++++-
 fs/cachefiles/ondemand.c  | 166 ++++++++++++++++++++++++++++++++++------------
 4 files changed, 201 insertions(+), 46 deletions(-)

