Return-Path: <linux-fsdevel+bounces-50868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6BFAD0972
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 23:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB7617B4D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF3B237163;
	Fri,  6 Jun 2025 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCB85euJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05001A76BC;
	Fri,  6 Jun 2025 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749245424; cv=none; b=PZnbDmw6h3h+BVwsGUNe7lfqtte17UY+6W5kZU4tt8ekjjKPXIN+MnFR1HZL1V/72dxNGPmQ2rWF2sPnlO+qMjz4ZQ8e7VOSr6Wcsf99uajrT6DAkrNLO7ZGlItg4lML5Og0Tvy3lD4PVdiJIO0Y1DJArCnPmXle2j1UA/Ibu+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749245424; c=relaxed/simple;
	bh=L+1GPDYfhNOgc+mO/H4gde3c82WpRfUT5pLQa3xR3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzvBwriyAY28dWlBVl0xU7tsu3mgeN5heX6GAe6bkqLSwY4tyik+TDv3AEUIj7dZ4F/0+FC+zJFffnkUps9K/ROAVsRhrk0BS62oengH4K5gGFBK/+xLA8wmUedjrbpAqQaBNUl0CD+cNRH7keKDJXyVXpYVW91uoHF3yXtmQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCB85euJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF36C4CEEB;
	Fri,  6 Jun 2025 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749245424;
	bh=L+1GPDYfhNOgc+mO/H4gde3c82WpRfUT5pLQa3xR3Ww=;
	h=From:To:Cc:Subject:Date:From;
	b=hCB85euJkYT+0y7l3nmpSXI5JYMqrzlPKjDLcQnAJoR+P3z8OT+pGtfXu1E1cDxTE
	 fppAQiToSm9u7Opxp41uhSrVdwxELX3N6ZAEerLFT8RwkMWlIxxPfyNFrC5CfL72ir
	 1WNkESJOskl7d4Tfo7+eMWXf+lkTYrlNcmXMoQTNmNo00musdrZwbE6kjpMVy+JD49
	 IaWdZbqJEN+UhKFMZ8jd0UdVN8mcVIEh/C00X1Lcr0I9f4wMzouLv6QYUoTkx1Z/F3
	 Fe42LkCzmqVsXyPa4d/bO3i68PIAWE7F/Wvw3MQe/93A1A61GCOSUc6vwsEGKkIc7g
	 v612eVKGyFUdA==
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
Subject: [PATCH v3 bpf-next 0/5] bpf path iterator
Date: Fri,  6 Jun 2025 14:30:10 -0700
Message-ID: <20250606213015.255134-1-song@kernel.org>
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

 fs/bpf_fs_kfuncs.c                            |  73 +++++++++
 fs/namei.c                                    |  51 ++++++
 include/linux/namei.h                         |   2 +
 kernel/bpf/verifier.c                         |   5 +
 security/landlock/fs.c                        |  31 ++--
 .../testing/selftests/bpf/bpf_experimental.h  |   6 +
 .../selftests/bpf/prog_tests/path_iter.c      | 111 ++++++++++++++
 tools/testing/selftests/bpf/progs/path_iter.c | 145 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/path_walk.c |  59 +++++++
 9 files changed, 462 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_walk.c

--
2.47.1

