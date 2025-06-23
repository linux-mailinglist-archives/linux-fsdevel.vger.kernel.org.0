Return-Path: <linux-fsdevel+bounces-52482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B33AE35D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8044F3AFB92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA281E47A8;
	Mon, 23 Jun 2025 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swOqxQgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB5136348;
	Mon, 23 Jun 2025 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660742; cv=none; b=pvZv7jeFkn/ZgKFVd/GpmF1Vbtb/U+TfbZOxPYhNA7wX11uUshFpCLGn03o6G6yo1GEylVaP6DP0YQkQyyyRIygknMnhkAGOjgB9uU1QFrF5ttD9+UgcwvQEOgeONgUxVbHOQ8xkPBsq7wxPHnuN2F4aGULexnYyWjZt6NhhGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660742; c=relaxed/simple;
	bh=buYFvQ/djnOOvxUrhQfFa4W2KVshHCQ12FtFjG4Lbj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hW/Tm0ACggo0VORrXoGXXaEonsGvMVyeRdBoBO9hLUVKix0IzBsKTM/YFI3IqTLZ6aNaH6zqIa8PIhfSf4iAGRf4Y4GgCjN/k0p0JwWrAF6DpGRATpGLjYxGe3nQTdRdMAx1mTTRFnObBiybl8p/UN9memyQQjmipbbhFuOEQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swOqxQgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138A1C4CEED;
	Mon, 23 Jun 2025 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750660741;
	bh=buYFvQ/djnOOvxUrhQfFa4W2KVshHCQ12FtFjG4Lbj4=;
	h=From:To:Cc:Subject:Date:From;
	b=swOqxQgOEpTqLYbskDwfDIWumX84AA9ctLsNxjzNKV6UM2EfnPUVUGg7EaJzX9NDX
	 Py6wefAVt3li5vvfsfIqqRhFZS1JSdgtqLEawcVX+os0+8ZdUBNUq7M2pp85AbBdT5
	 RY6l64vXOnQT47SSsQiffbKOH63AdnQQ6cKw3hB5N51HRgtDsnhQpDOnvBkZxiLXaq
	 KKAIohKkr5M/sFy+SYIcFZmTbSJK1lppAjz9qknDprHtqJlW519qwHk+x7qwg4GN+O
	 6tSW1SHZngEV48e3vp1Q6eJ1Poeser2v95mt7yCGTstOZfl+2obOlt28ShmrddUf5G
	 Glg/+R3Ho/w3g==
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
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 0/4] Introduce bpf_cgroup_read_xattr
Date: Sun, 22 Jun 2025 23:38:50 -0700
Message-ID: <20250623063854.1896364-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new kfunc bpf_cgroup_read_xattr, which can read xattr from
cgroupfs nodes. The primary users are LSMs, cgroup programs, and sched_ext.

---

Changes v2 => v3:
1. Make bpf_cgroup_read_xattr available to all program types.
2. Fix gcc build warning on the selftests.
3. Add "ifdef CONFIG_CGROUPS" around bpf_cgroup_read_xattr.

v2: https://lore.kernel.org/bpf/20250619220114.3956120-1-song@kernel.org/

Changes v1 => v2:
1. Replace 1/4 in v1 with Chritian's version (1/5 in v2).
2. Rename bpf_kernfs_read_xattr => bpf_cgroup_read_xattr, and limit access
   to cgroup only.
3. Add 5/5, which makes bpf_cgroup_read_xattr available to cgroup and
   struct_ops programs.

v1: https://lore.kernel.org/bpf/20250618233739.189106-1-song@kernel.org/

Christian Brauner (1):
  kernfs: remove iattr_mutex

Song Liu (3):
  bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
  bpf: Mark cgroup_subsys_state->cgroup RCU safe
  selftests/bpf: Add tests for bpf_cgroup_read_xattr

 fs/bpf_fs_kfuncs.c                            |  34 ++++
 fs/kernfs/inode.c                             |  74 ++++----
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/verifier.c                         |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   3 +
 .../selftests/bpf/prog_tests/cgroup_xattr.c   | 145 ++++++++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   | 158 ++++++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 +++++++
 8 files changed, 448 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

--
2.47.1

