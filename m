Return-Path: <linux-fsdevel+bounces-25830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC642951026
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2031C22A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16AC1AB53D;
	Tue, 13 Aug 2024 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFdBZRgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C216DEA9;
	Tue, 13 Aug 2024 23:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590196; cv=none; b=dkp2QnhIS6TGtTPRc+17dkTchio8PrKfA78ZVR7r688aH5m5w1xrma8JtHLIVXAM490i5A8a65BNPuXNAboorXdmrFGxpCsGJteDcRvOZKqX6W9MlzfxSZWakeF4oehYWUPJNHXpEW72DvTNH1ThKN4aDd4GzEYibKJNCoINzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590196; c=relaxed/simple;
	bh=mI+KRFOReeLabmgqAkmavGQBz91T9ZIktOaIWQ0VpXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbPDn3oGX4oC0tpNm+JVa8Jgm1v1/Va5rTwwOaNPnGfbHPKsT5GGUpL4HaFu1K00ZqX+nen7LYokpvbGeuO+jDkcWtXJ1vbX5wIL7p3jrCwx9uujWpVwR6wL813nGik0OhYYpiei5FIIhKPPLA5QgtD83na8zdf+zMU4Fh60YOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFdBZRgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2BBC4AF0E;
	Tue, 13 Aug 2024 23:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590195;
	bh=mI+KRFOReeLabmgqAkmavGQBz91T9ZIktOaIWQ0VpXk=;
	h=From:To:Cc:Subject:Date:From;
	b=MFdBZRgpiqmqNVIf1BqtE0PNjRcTayp6SDWKpCib+XLmmjrvVbubGwHEZsyKTv5sV
	 3Hq7d53kDrBD0ctPMQF258epZLcoj7Fv6pQRs0I12cO1BhY1rYje9R1fmwDZyqvOaw
	 /UhpM3Sdj31fFVAuo2nrGgMIJVLhbHUeu8szHcrCYTpnhWxYHlMzJFwTp2MzGHf0Px
	 QdQMMTSHQJAwXl8HtKQTBBJQHRBWHkJZLinGlLI/+i6ViZpZ0yOzcd8guXlR02WSo4
	 uRfHYDmpOA+4pactzX2uSB4M/O/MXFZo4myFi5WV3YGOg5boIXDcp6jos0z7JnXCIb
	 bTIetaRJ7NdEQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 0/8] BPF follow ups to struct fd refactorings
Date: Tue, 13 Aug 2024 16:02:52 -0700
Message-ID: <20240813230300.915127-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set extracts all the BPF-related changes done in [0] into
a separate series based on top of stable-struct_fd branch ([1]) merged into
bpf-next tree. There are also a few changes, additions, and adjustments:

  - patch subjects adjusted to use "bpf: " prefix consistently;
  - patch #2 is extracting bpf-related changes from original patch #19
    ("fdget_raw() users: switch to CLASS(fd_raw, ...)") and is ordered a bit
    earlier in this patch set;
  - patch #3 is reimplemented and replaces original patch #17
    ("bpf: resolve_pseudo_ldimm64(): take handling of a single ldimm64 insn into helper")
    completely;
  - in patch #4 ("bpf: switch maps to CLASS(fd, ...)"), which was originally
    patch #18 ("bpf maps: switch to CLASS(fd, ...)"), I've combined
    __bpf_get_map() and bpf_file_to_map() into __bpf_get_map(), as the latter
    is only used from it and makes no sense to keep separate;
  - as part of rebasing patch #4, I adjusted newly added in patch #3
    add_used_map_from_fd() function to use CLASS(fd, ...), as now
    __bpf_get_map() doesn't do its own fdput() anymore. This made unnecessary
    any further bpf_map_inc() changes, because we still rely on struct fd to
    keep map's file reference alive;
  - patches #5 and #6 are BPF-specific bits extracted from original patch #23
    ("fdget(), trivial conversions") and #24 ("fdget(), more trivial conversions");
  - patch #7 constifies security_bpf_token_create() LSM hook;
  - patch #8 is original patch #35 ("convert bpf_token_create()"), with
    path_get()+path_put() removed now that LSM hook above was adjusted.

All these patches were pushed into a separate bpf-next/struct_fd branch ([2]).
They were also merged into bpf-next/for-next so they can get early testing in
linux-next.

  [0] https://lore.kernel.org/bpf/20240730050927.GC5334@ZenIV/
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=stable-struct_fd
  [2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/log/?h=struct_fd

Al Viro (6):
  bpf: convert __bpf_prog_get() to CLASS(fd, ...)
  bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)
  bpf: switch maps to CLASS(fd, ...)
  bpf: trivial conversions for fdget()
  bpf: more trivial fdget() conversions
  bpf: convert bpf_token_create() to CLASS(fd, ...)

Andrii Nakryiko (2):
  bpf: factor out fetching bpf_map from FD and adding it to used_maps
    list
  security,bpf: constify struct path in bpf_token_create() LSM hook

 include/linux/bpf.h            |  11 +-
 include/linux/lsm_hook_defs.h  |   2 +-
 include/linux/security.h       |   4 +-
 kernel/bpf/bpf_inode_storage.c |  24 ++---
 kernel/bpf/btf.c               |  11 +-
 kernel/bpf/map_in_map.c        |  38 ++-----
 kernel/bpf/syscall.c           | 181 +++++++++------------------------
 kernel/bpf/token.c             |  74 +++++---------
 kernel/bpf/verifier.c          | 110 +++++++++++---------
 net/core/sock_map.c            |  23 ++---
 security/security.c            |   2 +-
 security/selinux/hooks.c       |   2 +-
 12 files changed, 179 insertions(+), 303 deletions(-)

-- 
2.43.5


