Return-Path: <linux-fsdevel+bounces-50423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F3ACC099
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B580B1890B51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E3268C76;
	Tue,  3 Jun 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFHxf26k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355120E32D;
	Tue,  3 Jun 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748933972; cv=none; b=lz3GFBQAuxWTLuq3TRmfdhcuEFtAx2COUjS4L1k+9O2/51OS7/7H+/bAP6wwJ+XzTqxYcLm5Ra/LEYSZnWwOGOgGwgL1xp9fAt/6b70jCXzuwKtEzmfs72GezNjvzHl9PBtjzswD3eJcTrdGOWGW+fR9ZxkeFG9wyVj7Q/lkV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748933972; c=relaxed/simple;
	bh=+akWN80P23osFI4jBQah02ZSssvWbJBzc1gByS55lTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnUz3x2B8/1CQWnHBAeXt5JD5R3iUmzfjWYjMCqes67rr83KXnM0P98i7lS1JTwc3vwn5FyfgyPi6IcFPj5vw7D50uOD0YKkzth0vOqkEMj8iGIU6kRWBzS23j0Y/tiVpElzQTGr5oFZ8jkodzGEfQ3ZtPW74Mo18G0kO580KPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFHxf26k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75B9C4CEED;
	Tue,  3 Jun 2025 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748933971;
	bh=+akWN80P23osFI4jBQah02ZSssvWbJBzc1gByS55lTU=;
	h=From:To:Cc:Subject:Date:From;
	b=pFHxf26kCaVBR5zXauIc3GJj/hBlYDGbkHkTjOVu7yMeLNAk9K9ixFnVYoE4rj2kc
	 5F4+Gbdj+ckyuqxuow7YdDKiBhwAIg5t7IsDFJePC0+OlXeTatKouiwwA7AX3lmBij
	 lUeHIan5uH2uDi+jWGfKJjayVitQAw8f9UpSjpfInSebzqu2dTZ//mcPZ7mTharpFt
	 /qoFVG/NOkPlXqZa3rxzsO0Nps2c/PpdCAZdiH+C3WSfYvwGjwKB+1LE9HjbYxb257
	 y5oWPfolYNsW0HJZSsWWTHsP+6XDWxCzgw0Cip3ig5MgbybQSEXCB1k8g7xdY5iLxD
	 Fh3QOEatZwipQ==
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
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/4] bpf path iterator
Date: Mon,  2 Jun 2025 23:59:16 -0700
Message-ID: <20250603065920.3404510-1-song@kernel.org>
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

This patchset introduce a reliable helper path_walk_parent, which walks
path to its VFS parent. The helper is use in Landlock.

A new BPF iterator, path iterator, is introduced to do the path walking.
The BPF path iterator uses the new path_walk_parent help to walk the VFS
tree.

Changes v1 => v2:
1. Rename path_parent => path_walk_parent.
2. Remove path_connected check in path_walk_parent.
3. Fix is_access_to_paths_allowed().
4. Remove mode for path iterator, add a flag instead.

v1: https://lore.kernel.org/bpf/20250528222623.1373000-1-song@kernel.org/


[1] https://lpc.events/event/18/contributions/1940/
[2] https://github.com/cilium/tetragon/

Song Liu (4):
  namei: Introduce new helper function path_walk_parent()
  landlock: Use path_walk_parent()
  bpf: Introduce path iterator
  selftests/bpf: Add tests for bpf path iterator

 fs/namei.c                                    |  52 +++++++
 include/linux/namei.h                         |   2 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/path_iter.c                        |  58 ++++++++
 kernel/bpf/verifier.c                         |   5 +
 security/landlock/fs.c                        |  31 ++--
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      |  12 ++
 tools/testing/selftests/bpf/progs/path_iter.c | 134 ++++++++++++++++++
 10 files changed, 283 insertions(+), 21 deletions(-)
 create mode 100644 kernel/bpf/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c

--
2.47.1

