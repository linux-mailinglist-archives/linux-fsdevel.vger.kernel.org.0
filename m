Return-Path: <linux-fsdevel+bounces-67697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F317FC4769A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546843A7050
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5220314D2F;
	Mon, 10 Nov 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLm0/4Ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AE1A7AE3;
	Mon, 10 Nov 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787322; cv=none; b=MpvA/76q5WBhBMMmErudHZoA0S46RT1gI9ZxXleeQp7ZPSMmwm4pFLSr8piti7XLknDisijgaLrKdRkCB5FQdoqV0ga5zHygBpHDKL4curnU77wXn7zj8/zkzTbabwpzlRIj7fpOK5pZaL+GjKqEM6zcpOxG2xdNWKUfgugmGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787322; c=relaxed/simple;
	bh=6KSwsK8hJ3VsxaX3vSZfCo2wVNblyfeSCIhlDo7+M8s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QAAvSfisKgZ0lhvOLuS/5ICYa4T8x82tcpaAd9HNrZqrpHlLc73H9qsjrr1JD0baRbtA+/qXUA75qdS5zPDGYMdZOCzAyEB3jfgBWYuFPorhjyRoVV3b/plT9HFUzBhkiR6Kj2vf6+14bFTZkJkIYjATQeDkQBPuMmEo+k8WKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLm0/4Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77677C113D0;
	Mon, 10 Nov 2025 15:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762787321;
	bh=6KSwsK8hJ3VsxaX3vSZfCo2wVNblyfeSCIhlDo7+M8s=;
	h=From:Subject:Date:To:Cc:From;
	b=uLm0/4EvJE1j74j9QrirPiPyBOSzPMEk/h/hXjnZIEdQ180jK+CQjUqfYCuGpk4Vf
	 5mobfv4yPgkePiyxcD6931VgiqR944gHEROE/Wyih0wahEAMNE4JxyyBJdAueainrp
	 uh4+nQKWGr+in+771km0LEE5tCpV4pYhQi11wdGREl7LqMC60DbVDYpGq5OHabFy2d
	 UngFeoTeREhmgCy/D+pwkHjnlxonZgRPbAycgSi/7aEVXNrHqc4GgTScMbV1sOZIvX
	 8sqnHIUyfO+j/10N487rOEaY33MQvYwCyujkiHEvYinl5EYVJFDdhtbcECrpcDWpGA
	 8VKES//ZwEnWQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/17] ns: header cleanups and initial namespace reference
 count improvements
Date: Mon, 10 Nov 2025 16:08:12 +0100
Message-Id: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANz/EWkC/0XMQQrCQAxA0auUrE2ZTFGoVxEXmTG1g5iWpKhQe
 nenblw+PvwVXKyIw7lZweRVvExaQYcG8sh6Fyy3aoghHoko4HuyByo/xWfOguqLieBQPuI4xK7
 viENIHKEeZpNfqIPLtTqxCyZjzeP+3Nn+V6eWeti2Lx80KNOTAAAA
X-Change-ID: 20251110-work-namespace-nstree-fixes-f23931a00ba2
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2728; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6KSwsK8hJ3VsxaX3vSZfCo2wVNblyfeSCIhlDo7+M8s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQK/v+sx9I829Vx/dJT0dYO/bk8rzg27U5LYN7h9iE3S
 vKfgIFsRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETS2hkZ1p+8KSZhx8wk4XH/
 3y1F57kChquubJ0gVh50I+jinRlX+BgZ9lwRMytQ1/zhUerw06P496wDmdHWVvofdxteP25TMzG
 WGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Cleanup the namespace headers by splitting them into types and helpers.
Better separate common namepace types and functions from namespace tree
types and functions.

Fix the reference counts of initial namespaces so we don't do any
pointless cacheline ping-pong for them when we know they can never go
away. Add a bunch of asserts for both the passive and active reference
counts to catch any changes that would break it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (17):
      ns: move namespace types into separate header
      nstree: decouple from ns_common header
      nstree: move nstree types into separate header
      nstree: add helper to operate on struct ns_tree_{node,root}
      nstree: switch to new structures
      nstree: simplify owner list iteration
      nstree: use guards for ns_tree_lock
      ns: make is_initial_namespace() argument const
      ns: rename is_initial_namespace()
      fs: use boolean to indicate anonymous mount namespace
      ipc: enable is_ns_init_id() assertions
      ns: make all reference counts on initial namespace a nop
      ns: add asserts for initial namespace reference counts
      ns: add asserts for initial namespace active reference counts
      pid: rely on common reference count behavior
      ns: drop custom reference count initialization for initial namespaces
      selftests/namespaces: fix nsid tests

 fs/mount.h                                     |   3 +-
 fs/namespace.c                                 |   9 +-
 include/linux/ns/ns_common_types.h             | 196 ++++++++++++++++
 include/linux/ns/nstree_types.h                |  55 +++++
 include/linux/ns_common.h                      | 266 +++++-----------------
 include/linux/nstree.h                         |  38 ++--
 include/linux/pid_namespace.h                  |   3 +-
 init/version-timestamp.c                       |   2 +-
 ipc/msgutil.c                                  |   2 +-
 ipc/namespace.c                                |   3 +-
 kernel/cgroup/cgroup.c                         |   2 +-
 kernel/nscommon.c                              |  15 +-
 kernel/nstree.c                                | 304 ++++++++++++++-----------
 kernel/pid.c                                   |   2 +-
 kernel/pid_namespace.c                         |   2 +-
 kernel/time/namespace.c                        |   2 +-
 kernel/user.c                                  |   2 +-
 tools/testing/selftests/namespaces/nsid_test.c | 107 +++++----
 18 files changed, 576 insertions(+), 437 deletions(-)
---
base-commit: c9255cbe738098e46c9125c6b409f7f8f4785bf6
change-id: 20251110-work-namespace-nstree-fixes-f23931a00ba2


