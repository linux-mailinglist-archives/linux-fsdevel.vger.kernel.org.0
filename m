Return-Path: <linux-fsdevel+bounces-23616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3292FC08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 16:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514EC1C20CC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A5216FF48;
	Fri, 12 Jul 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khlAQemp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9A15DBAE;
	Fri, 12 Jul 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792912; cv=none; b=DZNxz2ikPazIkRJ9AkTaGdGyXEf1b5vqqhyqjEdTf1IkA7A3Mod72LO+GAGF/T+N9wB8K7fHBVdjBJZEiAZzFlKsHBLsxVsNV7OwpdEluEbwaJRzaTtukyp8g3TrQwyS0j/3dmIgJZ4KMYQ9sEET33KZtW3Jyl1ki2/rkFzlrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792912; c=relaxed/simple;
	bh=C7FWvbTTrJp2SDH0O0qvo3qmaBBK4J4/ppyJIQWg1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ino5L+KoXa5MIvawugGogGM97722zluC0utDoEtVaE6GMYU/G7DQHfwwJ9X4vvwVGnLcSDNxGMHP2Z7WgJE2U1hGRHpIgfcO9xcQ7RzQkYn9DxVzMFA7/kIOluO7QYTdir682DsjQN9lpkeRkjpNhcHK+ue1KIf8WI8nlSiCevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khlAQemp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14197C32782;
	Fri, 12 Jul 2024 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720792912;
	bh=C7FWvbTTrJp2SDH0O0qvo3qmaBBK4J4/ppyJIQWg1BI=;
	h=From:To:Cc:Subject:Date:From;
	b=khlAQempAeJMf94vKJNr7llS/5dM/ELEfTlpbooGmvZ4omQUnzO4pfQLwifHaohSR
	 LyP6if9xYHCnZzmmXDAK7MoXyUMpqJ8Li5gGb1B2Kp4DR+FvFYGUUMNSsQg26K8dU1
	 zZLUs882Uagr2ZueFEf5EOGqdEHsa7+rYG+7Vl8lLWsavjl4RemLhhL8s/WWM0nf/O
	 x0Gq6WW8GHmO5PiTxShyfdCa1RDPUGWfzwvd4vo+/fZk4I7y4nGuzHOOuJ1fYVbfpk
	 VGD68J7+jswfWBqMllgTxpRsjscHV0Il3p+XM7P23G0lf63t8Rbw5sl8O0IeBpmWtJ
	 8X7dVUPBGbt6w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.11] vfs pidfs
Date: Fri, 12 Jul 2024 16:01:45 +0200
Message-ID: <20240712-vfs-pidfs-18bf3ec8bde5@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3355; i=brauner@kernel.org; h=from:subject:message-id; bh=C7FWvbTTrJp2SDH0O0qvo3qmaBBK4J4/ppyJIQWg1BI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRNNPdKX7E7uvJ0fPaSAyZaMxrVrb9cOm4TfC1ZPa2H/ erqwsCTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxSmFk+L67W5S/er+elGWn iUzZ6X6vdO6T6rbu5rca3n+cFZeSz/BPu7Q772OokaWhqdaM4+4ce5M3ulvoHfx13PzFn/VrtNc xAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains work to make it possible to derive namespace file descriptors
from pidfd file descriptors.

Right now it is already possible to use a pidfd with setns() to atomically
change multiple namespaces at the same time. In other words, it is possible to
switch to the namespace context of a process using a pidfd. There is no need to
first open namespace file descriptors via procfs.

The work included here is an extension of these abilities by allowing to open
namespace file descriptors using a pidfd. This means it is now possible to
interact with namespaces without ever touching procfs.

To this end a new set of ioctls() on pidfds is introduced covering all
supported namespace types.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.10-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
[1]: This contains a merge conflict with the vfs-6.11.misc pull request
     https://lore.kernel.org/r/20240712-vfs-misc-c1dbbc5eaf82@brauner

     After conflict resolution the merge diff looks like this:

diff --cc fs/internal.h
index f26454c60a98,24346cf765dd..a5e9a2f5b30d
--- a/fs/internal.h
+++ b/fs/internal.h
@@@ -323,15 -322,4 +324,16 @@@ struct stashed_operations
  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
                      struct path *path);
  void stashed_dentry_prune(struct dentry *dentry);
 +/**
 + * path_mounted - check whether path is mounted
 + * @path: path to check
 + *
 + * Determine whether @path refers to the root of a mount.
 + *
 + * Return: true if @path is the root of a mount, false if not.
 + */
 +static inline bool path_mounted(const struct path *path)
 +{
 +      return path->mnt->mnt_root == path->dentry;
 +}
+ int open_namespace(struct ns_common *ns);

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11.pidfs

for you to fetch changes up to 5b08bd408534bfb3a7cf5778da5b27d4e4fffe12:

  pidfs: allow retrieval of namespace file descriptors (2024-06-28 10:37:29 +0200)

Please consider pulling these changes from the signed vfs-6.11.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11.pidfs

----------------------------------------------------------------
Christian Brauner (6):
      path: add cleanup helper
      file: add take_fd() cleanup helper
      nsproxy: add a cleanup helper for nsproxy
      nsproxy: add helper to go from arbitrary namespace to ns_common
      nsfs: add open_namespace()
      pidfs: allow retrieval of namespace file descriptors

 fs/internal.h              |  2 ++
 fs/nsfs.c                  | 55 +++++++++++++++-------------
 fs/pidfs.c                 | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/cleanup.h    | 13 ++++---
 include/linux/file.h       | 20 +++++++++++
 include/linux/nsproxy.h    | 13 +++++++
 include/linux/path.h       |  9 +++++
 include/uapi/linux/pidfd.h | 14 ++++++++
 8 files changed, 187 insertions(+), 29 deletions(-)

