Return-Path: <linux-fsdevel+bounces-18702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5668C8BB8B6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 02:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1B1F23BBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 00:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C610A3D;
	Sat,  4 May 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co0MnT07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EB139E;
	Sat,  4 May 2024 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782608; cv=none; b=lWVgU9oEXZ78pr2bsP2FDg00EX3GN8hrFk2RX/60h4c5fzbfkrrL/5Cr7sz5YUsP2gF6mycnH96fe4zfCgw1+AMLns/M+7eDh84wAM0Kz0KGLlnmgOjinSWbe53p2n+W2oqEYUbb0R4ZFa6Q4HvGNRkl3GOw8lRtOSaH1olxUsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782608; c=relaxed/simple;
	bh=TTG74m/eSxBs7jUVXRJ32J+Db4mE/GvMxzpez/uY7KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjBk2dne/miIVUONnm+KLcKp/ndK5bWFFPhVvyr3p+l9JkaZ3Ib9qCUjQwqI33GN0MidRZyiu//iP3wh2ssMUBipjTT4hDgPOcsePH9lFmXmFot2HrMX5sMYmnIOk/s7My6EV8iY7jzPeFuYjMX8boUp/U/RLervx2jFDGY8f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co0MnT07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE5C116B1;
	Sat,  4 May 2024 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782608;
	bh=TTG74m/eSxBs7jUVXRJ32J+Db4mE/GvMxzpez/uY7KA=;
	h=From:To:Cc:Subject:Date:From;
	b=co0MnT07AYnGkVusTnpu3exa2v9kMVLAecTi7KUpW2DrkNTY2ezwHeaQl1yGeSFxR
	 HjW/eAsqfpi/LP41Xbv835HtALENu1vTIX+iLPIizCNPWOpsAA7X2xA9/bnlgcuHND
	 zLb0V9d92DztsGaD6Yh97kyj6FIYDiNBxiAL9UoCi2jNCJRfD7lJhLfqOoCeeaqexY
	 nWyM9eT5FpkF0TVBMTNqBPEizJwkwaFjCAE4RNm01hRsmWhRCoTdbavC8GE3LbkmxS
	 okXt7Xp65ytfKkcBxaLbNB+NAYnU0dMuTQabaSxXbvXh44RHXfETfSi8nSOD00p7MM
	 NPKiIB4wjccDg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/5] ioctl()-based API to query VMAs from /proc/<pid>/maps
Date: Fri,  3 May 2024 17:30:01 -0700
Message-ID: <20240504003006.3303334-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement binary ioctl()-based interface to /proc/<pid>/maps file to allow
applications to query VMA information more efficiently than through textual
processing of /proc/<pid>/maps contents. See patch #2 for the context,
justification, and nuances of the API design.

Patch #1 is a refactoring to keep VMA name logic determination in one place.
Patch #2 is the meat of kernel-side API.
Patch #3 just syncs UAPI header (linux/fs.h) into tools/include.
Patch #4 adjusts BPF selftests logic that currently parses /proc/<pid>/maps to
optionally use this new ioctl()-based API, if supported.
Patch #5 implements a simple C tool to demonstrate intended efficient use (for
both textual and binary interfaces) and allows benchmarking them. Patch itself
also has performance numbers of a test based on one of the medium-sized
internal applications taken from production.

This patch set was based on top of next-20240503 tag in linux-next tree.
Not sure what should be the target tree for this, I'd appreciate any guidance,
thank you!

Andrii Nakryiko (5):
  fs/procfs: extract logic for getting VMA name constituents
  fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
  tools: sync uapi/linux/fs.h header into tools subdir
  selftests/bpf: make use of PROCFS_PROCMAP_QUERY ioctl, if available
  selftests/bpf: a simple benchmark tool for /proc/<pid>/maps APIs

 fs/proc/task_mmu.c                            | 290 +++++++++++---
 include/uapi/linux/fs.h                       |  32 ++
 .../perf/trace/beauty/include/uapi/linux/fs.h |  32 ++
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/procfs_query.c    | 366 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.c      |   3 +
 tools/testing/selftests/bpf/test_progs.h      |   2 +
 tools/testing/selftests/bpf/trace_helpers.c   | 105 ++++-
 9 files changed, 763 insertions(+), 70 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/procfs_query.c

-- 
2.43.0


