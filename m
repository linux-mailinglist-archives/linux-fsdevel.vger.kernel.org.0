Return-Path: <linux-fsdevel+bounces-52267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE4AE0F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCE93B18D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5F8263F40;
	Thu, 19 Jun 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0qohlEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09194260582;
	Thu, 19 Jun 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370504; cv=none; b=oBoDjNpqBiSm/JuCTMb4qEuey2/CT6idfgKgV4MiGE3YcuzQHG8df5s6ZUnCeh5dQ6b8vJsQBF7q5HoswyT7s83D24RnCysPJgKLUSS1z2nilZm2uWT8BcpeM4iqIRjph+s0CUC/xT2qUVOy6QE54jOCfWv8Xj80ibk7CjMbh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370504; c=relaxed/simple;
	bh=Tz/lGOw8O1n2Xxaax92kMOO1KRDUnAFIXp6vTgb5S2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXN/AnrT4CFQJo1Mq0lBr1NAbkj9Erz7jGzhUxgKhAv+BVOD/KKKwSoSJ6g4y43V25n3xpt0YUlNSMicDt1wV0fXXGOEek7tq0CvkxDaD5LvcZUvZInnA9S21kpcjUEP6mocM7/kmTdZvdW6+iG7AAW1E2ftntandQNakS9ypYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0qohlEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E212BC4CEEA;
	Thu, 19 Jun 2025 22:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370503;
	bh=Tz/lGOw8O1n2Xxaax92kMOO1KRDUnAFIXp6vTgb5S2c=;
	h=From:To:Cc:Subject:Date:From;
	b=s0qohlEvQE03XP5M5sRB4OyEsTQMF/EO/GZTSj8Lpu89jafgQhDRQ2U2XhYEZ4Jlv
	 Qn9fcCle9/IsaWxtw5KSsoneX8oJJ7yRUYFimROJvB4rq35mjtxOsEuV29VROkwpmJ
	 1HxxnyAetf5syxwQ6ti5OXGdcKBdZlwz90qGZ6YgnibSjAlT7GJzKMDyF7BuSnBR/S
	 1XhcpvY6xmwQlGXNeLIlcTKb3+Senklu4mmAg8klMgG0+UjqR1BNKVTYIKLvLEu5Hi
	 bTIjCmL+8/oJzeLPIyFIlXYEFUsvdndduqoUCuv3zU87UT4lnnnEqHTuJ5AvPPfrDe
	 xDiJmZJRyXwwA==
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
Subject: [PATCH v2 bpf-next 0/5] Introduce bpf_cgroup_read_xattr
Date: Thu, 19 Jun 2025 15:01:09 -0700
Message-ID: <20250619220114.3956120-1-song@kernel.org>
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

Changes v1 => v2:
1. Replace 1/4 in v1 with Chritian's version (1/5 in v2).
2. Rename bpf_kernfs_read_xattr => bpf_cgroup_read_xattr, and limit access
   to cgroup only.
3. Add 5/5, which makes bpf_cgroup_read_xattr available to cgroup and
   struct_ops programs.

v1: https://lore.kernel.org/bpf/20250618233739.189106-1-song@kernel.org/

Christian Brauner (1):
  kernfs: remove iattr_mutex

Song Liu (4):
  bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node
  bpf: Mark cgroup_subsys_state->cgroup RCU safe
  selftests/bpf: Add tests for bpf_cgroup_read_xattr
  bpf: Make bpf_cgroup_read_xattr available to cgroup and struct_ops
    progs

 fs/bpf_fs_kfuncs.c                            |  86 +++++++++-
 fs/kernfs/inode.c                             |  74 ++++----
 kernel/bpf/verifier.c                         |   5 +
 .../selftests/bpf/prog_tests/cgroup_xattr.c   | 145 ++++++++++++++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   | 158 ++++++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 +++++++
 6 files changed, 489 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

--
2.47.1

