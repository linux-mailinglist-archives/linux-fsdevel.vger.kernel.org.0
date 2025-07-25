Return-Path: <linux-fsdevel+bounces-56020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3BB11D82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC005AE3132
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046D2E8DE8;
	Fri, 25 Jul 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a91dA7v9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C846D2E889B;
	Fri, 25 Jul 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442851; cv=none; b=TJUI0nhnQEcxhuZuv6cGkDOUR6IqfDA7fEKzieUGOOkGI3TgqCXtey0Pw892TBlrIasjuYjeENUd6OybavtvOlv7tR22oZXsKD0v3C+CYkuYf+KVPnRcmLrgmZdOS4Ysx7dQOXFVXK2b3E8yVcJINIurXPpJqMdAUZt6Zrop/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442851; c=relaxed/simple;
	bh=+0FqvfHaUmIQOw15n52x7426VXgjnN+qBk8JbTg7lzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOYpsP6wxNM489wyDzGhXoTcQ227PaSVo5iSxz5dm/LIJ+/ASOejFQUaHvpKQ/9g7JBZQaK9yZuV6dG8youwd3isELQXvnE6WiBrstfmT4v+9Z329z95LHnHObK1QRqZBzB8U2VucTGc46b/+6GklfU1Ylnu/x5N6cwukAJCUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a91dA7v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AA1C4CEF5;
	Fri, 25 Jul 2025 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442851;
	bh=+0FqvfHaUmIQOw15n52x7426VXgjnN+qBk8JbTg7lzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a91dA7v9YKWWdgBOZsJIqRvfCuoPL33JdzhnAczZNECwUo81+rzd7RxBD/6uPYPJs
	 3CBRkJjy+is/3C6QS0EQoK46KxGLovfpAsEWw19oTvx+vrrB1zhzfQ0DVFCngn0639
	 R39XN+PTBaRJN+0tn75MZyKKg7JNXqOi2t1+tX+lnKGPB5RFxfQTmW/5kbi8Tk3Arz
	 bw8nlq4ufJbn1mtSMBpbU45eYLGpITpxX00i80SWIv6GGm5X0MrluiMRs8tiVztksu
	 JNnJDAqsLuUQTILyOlfI9xBcZBnPfCAQUgdVK9vts15oB4SDr1iTWaxg1tXrlzGtVB
	 F68uHxyFfRqlg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 09/14 for v6.17] vfs bpf
Date: Fri, 25 Jul 2025 13:27:15 +0200
Message-ID: <20250725-vfs-bpf-a1ee4bf91435@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; i=brauner@kernel.org; h=from:subject:message-id; bh=+0FqvfHaUmIQOw15n52x7426VXgjnN+qBk8JbTg7lzs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4m6/T6j68jjnC2XznXBX6sy7Zn5js4cdyOL2Weu3 wmXcr7XUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHAGYwMvyTfmItl9yTZPX+b rD89z7Oq1HbjrCm5sd9+P7rhqbvpCsN/z6inxZPSb8y3aGCTE7s69ZXrCZYGOXPmTaFSl7cbTVT lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
These changes allow bpf to read extended attributes from cgroupfs.
This is useful in redirecting AF_UNIX socket connections based on cgroup
membership of the socket. One use-case is the ability to implement log
namespaces in systemd so services and containers are redirected to
different journals.

Please note that I plan on merging bpf changes related to the vfs
exclusively via vfs trees.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.bpf

for you to fetch changes up to 70619d40e8307b4b2ce1d08405e7b827c61ba4a8:

  selftests/kernfs: test xattr retrieval (2025-07-02 14:18:22 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.bpf tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.bpf

----------------------------------------------------------------
Christian Brauner (3):
      kernfs: remove iattr_mutex
      Merge patch series "Introduce bpf_cgroup_read_xattr"
      selftests/kernfs: test xattr retrieval

Song Liu (3):
      bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
      bpf: Mark cgroup_subsys_state->cgroup RCU safe
      selftests/bpf: Add tests for bpf_cgroup_read_xattr

 fs/bpf_fs_kfuncs.c                                 |  34 +++++
 fs/kernfs/inode.c                                  |  70 ++++-----
 kernel/bpf/helpers.c                               |   3 +
 kernel/bpf/verifier.c                              |   5 +
 tools/testing/selftests/bpf/bpf_experimental.h     |   3 +
 .../selftests/bpf/prog_tests/cgroup_xattr.c        | 145 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c        | 158 +++++++++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c      |  60 ++++++++
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 tools/testing/selftests/filesystems/kernfs_test.c  |  38 +++++
 11 files changed, 486 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
 create mode 100644 tools/testing/selftests/filesystems/kernfs_test.c

