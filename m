Return-Path: <linux-fsdevel+bounces-52136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 202C7ADF9C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A919E0332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539928504A;
	Wed, 18 Jun 2025 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4F15rpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F431C2324;
	Wed, 18 Jun 2025 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289869; cv=none; b=hPjApl2WZlX0zvBhEmqP2KCek2pBxbvSpsPE0nsRtmjiWL5ZCaJ1mVUb7Te6M8zPk9fqZ5h0gA0+n/VrIxUPQn/STXb7lSrMF4iCFlpYxIKgpXvHKKhOw8D72POfN32V84bA7VfFnrGFnYby0IwsTWMDXmlXJDgKPpzxzhLDpwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289869; c=relaxed/simple;
	bh=57U4HUj1TaKN/otMUBUDWLAiMAuN6kSRzu/C1u8g3Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVlrqMOnpH1NWbjNl4i0/avZHbqo45JkqNV07fnYcD+Jp947yXz5Qb3abiXP5+oUi86wYsRIND+JSYXac6LFNi6lggFTELxvZlW9Dt5WlzgJnngmjz3Rju1hwk6TAsiLHuz5SV4kPsfxw9Ca0AzgmTaUXqe4kZ0aVIwi5ybTeCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4F15rpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A125CC4CEE7;
	Wed, 18 Jun 2025 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750289868;
	bh=57U4HUj1TaKN/otMUBUDWLAiMAuN6kSRzu/C1u8g3Tk=;
	h=From:To:Cc:Subject:Date:From;
	b=j4F15rpwS3hjum2uic6o/rp9fqV3p2hbKVhFqSnOU11x12hvHb7WN34wsfhf0CV5w
	 DSe4+fDMRbzSPfnGfwwOYWPI0SAew64BirgVZAxGsAL4uQ3ywROwix/QhgTftn2DiE
	 ALdvPI5r6f8/peNq7ggbGGWBkxX6SHmLWyb5RVDiOZamb+XgvFju84QzE4SRj/DPPB
	 l93bxMcdsU6g4Zx5RYokkjFubvVjAb3tL60CCamjX1vKEQ6JKBBE9GKQJt8RztUUyt
	 3dNGGawVud3Feuuvw82dESceNPU7X5otfG70+Y77Sx29bXy7HYYGcTlw0Ej5CzPGmj
	 vwAY18NEC9SzQ==
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
Subject: [PATCH bpf-next 0/4] Introduce bpf_kernfs_read_xattr
Date: Wed, 18 Jun 2025 16:37:35 -0700
Message-ID: <20250618233739.189106-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new kfunc bpf_kernfs_read_xattr, which can read xattr from
kernfs nodes (cgroupfs, for example). The primary users are LSMs, for
example, from systemd. sched_ext could also use xattrs on cgroupfs nodes.
However, this is not allowed yet, because bpf_kernfs_read_xattr is only
allowed from LSM hooks. The plan is to address sched_ext later (or in a
later revision of this set).

Song Liu (4):
  kernfs: Add __kernfs_xattr_get for RCU protected access
  bpf: Introduce bpf_kernfs_read_xattr to read xattr of kernfs nodes
  bpf: Mark cgroup_subsys_state->cgroup RCU safe
  selftests/bpf: Add tests for bpf_kernfs_read_xattr

 fs/bpf_fs_kfuncs.c                            |  33 ++++
 fs/kernfs/inode.c                             |  14 ++
 include/linux/kernfs.h                        |   2 +
 kernel/bpf/verifier.c                         |   5 +
 .../selftests/bpf/prog_tests/kernfs_xattr.c   | 145 ++++++++++++++++++
 .../selftests/bpf/progs/kernfs_read_xattr.c   | 117 ++++++++++++++
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  60 ++++++++
 7 files changed, 376 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernfs_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/kernfs_read_xattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c

--
2.47.1

