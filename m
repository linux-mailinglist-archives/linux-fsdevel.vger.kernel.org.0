Return-Path: <linux-fsdevel+bounces-50009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784AAC73F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1573B82B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0ED221F18;
	Wed, 28 May 2025 22:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5INrGBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8522127B;
	Wed, 28 May 2025 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748471188; cv=none; b=cegtfxXvtJfcW1vatgDfMk80lN3QtkfW3Esdbk5sVqdgggJ0zeH6p8FwoB4Y5SXsipqIQkZcNSdWeqqTQ6I1icLojOU3rYI7mG801A3qWJVoAlBDtF99HfflWINFhtfuobh1Yx2QoeLKN4O+9ei3oM/SqIUBd3Lpkht1c1FPpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748471188; c=relaxed/simple;
	bh=uYHjXbHyBJCFiCNjV3yOxQW7qXGInodsaq8a4RtU7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwMc9ytq2l2sXo0Vjj1ADR6pu6tcQSQ1gtqK+185OTqRFrpg64sXzj8TmIebfmSxuEQh+ZsVdZMkoPahKFouyTjQN6t+bIwFEvChJryFf9SL8QB4x3LfLbUMCcKGj1hykj7XpXPuhMhrFBF/fEM6o042zYAUjhpqn9TtS7c+CRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5INrGBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FE6C4CEE3;
	Wed, 28 May 2025 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748471187;
	bh=uYHjXbHyBJCFiCNjV3yOxQW7qXGInodsaq8a4RtU7yk=;
	h=From:To:Cc:Subject:Date:From;
	b=s5INrGBIzb3ou2AWm+U7FoZ9VpmFm5EDiNDCnmPsBR1K1VbdBi9CzQ4b0AKYNGshk
	 UvBJq9x+mu/f4pHB/RW2A+brxRMVSn4gz7AFsx3Cvq1sNxuajaqcITcJqa4cy/ers/
	 tplpadgKS5JqphA95RKpkGeUHG+O6JzG+UdCJc5+c1MeKMc7iQYx45omf5raW39AvR
	 dAYz4HVrRehmBTFxOL4HMmXNA7SjZnuQqFGAycV/DSDHMGLCcj+yYryANQxgGBHqoj
	 XVhKs2AiLERJAJlxAFHfPwF1Dm2ZJOhOPuZuPFfbgUwLidQc+osqlGuQrDT+oMYd7m
	 M5Y7LHh/Yhlow==
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
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/4] bpf path iterator
Date: Wed, 28 May 2025 15:26:19 -0700
Message-ID: <20250528222623.1373000-1-song@kernel.org>
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

This patchset introduce a reliable helper path_parent, which walks path to
its VFS parent. The helper is use in Landlock.

A new BPF iterator, path iterator, is introduced to do the path walking.
The BPF path iterator uses the new path_parent help to walk the VFS tree
reliably.

[1] https://lpc.events/event/18/contributions/1940/
[2] https://github.com/cilium/tetragon/

Song Liu (4):
  namei: Introduce new helper function path_parent()
  landlock: Use path_parent()
  bpf: Introduce path iterator
  selftests/bpf: Add tests for bpf path iterator

 fs/namei.c                                    |  39 +++++
 include/linux/namei.h                         |   8 ++
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/path_iter.c                        |  74 ++++++++++
 kernel/bpf/verifier.c                         |   5 +
 security/landlock/fs.c                        |  34 ++---
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      |  12 ++
 tools/testing/selftests/bpf/progs/path_iter.c | 134 ++++++++++++++++++
 10 files changed, 299 insertions(+), 17 deletions(-)
 create mode 100644 kernel/bpf/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c

--
2.47.1

