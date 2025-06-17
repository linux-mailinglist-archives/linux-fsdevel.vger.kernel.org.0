Return-Path: <linux-fsdevel+bounces-51849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D95ADC21E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 08:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233443A74AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFD28BA88;
	Tue, 17 Jun 2025 06:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLezurYc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930D1E521D;
	Tue, 17 Jun 2025 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140681; cv=none; b=YEKWQ9NP3iFz6oqR48W1Xtj1X4r2mx4QAzNP7IrU8vI+EwR7DuKfgNwp7MLm/XnNtSMngOQyXHshMZ1Nv9ic6wCm3y51nn25dlNrV6A3y3FyDUemNKLyPm8dVGAEX6uv00waqyA5sS2MRdlqw2VWHGGrVG3JHO2I6GWNoClyD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140681; c=relaxed/simple;
	bh=8V/j/xn1NeNrhKE1fVgovjhXAH2IroR6hAwrwqltnGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cF1KGZ/r1CVecbZrZYV4ZMjAgfhierb3aXkbz74sk9Br1+1Zh0S/k4qpkhe94Pt0PK8d3gK6L720Pj1sAQ3FGPKYiVpjtlyCT1r8PiDpccWxj2ZLgTIpp2DdjS7mfigr95iZyW6xXtA5Xs7chJzAACZl3E2BaBKEhwS5YTcwh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLezurYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9367C4CEE3;
	Tue, 17 Jun 2025 06:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750140680;
	bh=8V/j/xn1NeNrhKE1fVgovjhXAH2IroR6hAwrwqltnGE=;
	h=From:To:Cc:Subject:Date:From;
	b=RLezurYctkm5y1hKRjIV6Zi4hAC51pAIl4o8G6ohh+80UWi3HYMEPGhRkxo4sd//c
	 CDd8rS47dW21NJyhTR6dPNL9ZGkpqk+8V6LQU15VrwQnMfGdgB3/KCoaUtmA5lTKn8
	 ywXPFlzWtzqqVqehgrVUw/fLWwE7elpT4k4sQJedYJ9Yv+The9DYMXOhCdnm/o/cDu
	 Ktfc3T3ko9+9ztRjL5MxjFuNqhFbA1U11iPc9/QIIXPAHl5pxQmD/NWStpWQr1DLhp
	 Gwz0C9y54n3AIAJ+sg0doW2hiZM9SAY8QOnYhnxz4RDK3Fz6ymdSNfzeILvsBTmvRN
	 FPZjgNRTDj6mw==
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
	m@maowtm.org,
	neil@brown.name,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next 0/5] bpf path iterator
Date: Mon, 16 Jun 2025 23:11:11 -0700
Message-ID: <20250617061116.3681325-1-song@kernel.org>
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

Changes v4 => v5:
1. Minor changes to path_walk_parent per suggestions by Neil Brown and
   Tingmao Wang.

v4: https://lore.kernel.org/bpf/20250611220220.3681382-1-song@kernel.org/

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
 fs/namei.c                                    |  95 +++++++++---
 include/linux/namei.h                         |   2 +
 kernel/bpf/verifier.c                         |   5 +
 security/landlock/fs.c                        |  30 +---
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      | 111 ++++++++++++++
 tools/testing/selftests/bpf/progs/path_iter.c | 145 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/path_walk.c |  59 +++++++
 9 files changed, 485 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_walk.c

--
2.47.1

