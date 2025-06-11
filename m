Return-Path: <linux-fsdevel+bounces-51365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B094FAD620F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 00:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93B51E037A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 22:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771EA248F5F;
	Wed, 11 Jun 2025 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na33zKNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5222331E;
	Wed, 11 Jun 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749679345; cv=none; b=gA/L5dt+9z22Ywypp3SBbkR+rNjiknOb+/ePIgXKR2eVHkQXT4MeBN0hpkvKuO+IJjsrOjyTN4IrhMmS2tfIJh9LUO3tBZbpdLzpXzBdWGIMwCOuEgWkb2+H0VSIwXHR2/iEZHx3p+pS7VI26NMy0pOLgTNlFqlnASAyMCiJNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749679345; c=relaxed/simple;
	bh=dbWyLdIKUwccYwPkvCKRqCvmKDrCHNu+2dYDyvMAb/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfHEzgALwhqnkFSYcEXWr+ElVz1TKYQESZUeNBTtAfZIu1UbU70VnAk2iNR2q2qMDduk9m/voR7hkJaIxl1+5fj2dmG2MV2mP9tu8mdLjP25PR102VyHR9zVME35OMqrWM9xg5V+XHsFRyYeqnX4reXS3zswrRagKdv4qDyiOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na33zKNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41FDC4CEE3;
	Wed, 11 Jun 2025 22:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749679345;
	bh=dbWyLdIKUwccYwPkvCKRqCvmKDrCHNu+2dYDyvMAb/o=;
	h=From:To:Cc:Subject:Date:From;
	b=Na33zKNqUDUvzYHrBdgM+MzgJ3IsMsm2GAEGFW5llPuQpEE+1I2ybBSXnubZfcYvz
	 Up2Be9Z92sCE31LRqJ4jTG4hCLQy1Pe2SoN27cMB2vI0mmjlsw/bqoYQ8CCwysbvmG
	 nH/XlvvnopCMjqFV5AwysVTtwT/GDJZjE7ggluhWkBVGzur+iF+FAa5K5wEw7ERdqx
	 sr49l8SJgcZKFNfxIDRWgIPSG8JZ39MDtZUCvIxgzXebszgE2EoxUbuVhg3Bs/+uPW
	 8Tp4RTkxomafoRYiD/ZVzxRfMME6XOqckzr0JmpzcSnQkQKgGIAwG9J17Tmm6Ij82W
	 5FF0fRsl25X0w==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/5] bpf path iterator
Date: Wed, 11 Jun 2025 15:02:15 -0700
Message-ID: <20250611220220.3681382-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In security use cases, it is common to apply rules to VFS subtrees.
However, filtering files in a subtree is not straightforward [1].

One solution to this problem is to start from a path and walk up the VFS
tree (towards the root). Among in-tree LSMs, Landlock uses this solution.

BPF LSM solutions, such like Tetragon [2], also use similar approaches.
However, due to lack of proper helper/kfunc support, BPF LSM solutions
usually do the path walk with probe read, which is racy.

This patchset introduces a new helper path_walk_parent, which walks
path to its VFS parent. The helper is used in Landlock.

A new BPF iterator, path iterator, is introduced to do the path walking.
The BPF path iterator uses the new path_walk_parent help to walk the VFS
tree.

Changes v3 => v4:
1. Rewrite path_walk_parent based on suggestion from Neil Brown.
2. When path_walk_parent() returns false, it call path_put on @path and
   then zeros @path.

v3: https://lore.kernel.org/bpf/20250606213015.255134-1-song@kernel.org/

Changes v2 => v3:
1. Fix an issue with path_walk_parent.
2. Move bpf path iterator to fs/bpf_fs_kfuncs.c
3. Optimize bpf path iterator (less memory).
4. Add more selftests.
5. Add more comments.

v2: https://lore.kernel.org/bpf/20250603065920.3404510-1-song@kernel.org/

Changes v1 => v2:
1. Rename path_parent => path_walk_parent.
2. Remove path_connected check in path_walk_parent.
3. Fix is_access_to_paths_allowed().
4. Remove mode for path iterator, add a flag instead.

v1: https://lore.kernel.org/bpf/20250528222623.1373000-1-song@kernel.org/

[1] https://lpc.events/event/18/contributions/1940/
[2] https://github.com/cilium/tetragon/

Song Liu (5):
  namei: Introduce new helper function path_walk_parent()
  landlock: Use path_walk_parent()
  bpf: Introduce path iterator
  selftests/bpf: Add tests for bpf path iterator
  selftests/bpf: Path walk test

 fs/bpf_fs_kfuncs.c                            |  72 +++++++++
 fs/namei.c                                    |  99 ++++++++++--
 include/linux/namei.h                         |   2 +
 kernel/bpf/verifier.c                         |   5 +
 security/landlock/fs.c                        |  28 +---
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      | 111 ++++++++++++++
 tools/testing/selftests/bpf/progs/path_iter.c | 145 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/path_walk.c |  59 +++++++
 9 files changed, 493 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_walk.c

--
2.47.1

