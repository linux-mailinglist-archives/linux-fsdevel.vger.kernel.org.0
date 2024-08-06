Return-Path: <linux-fsdevel+bounces-25197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D299949BD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 01:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1DF1F2440A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63194175D3D;
	Tue,  6 Aug 2024 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcrR2DF+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE018D644;
	Tue,  6 Aug 2024 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985751; cv=none; b=gLkRs7q4CIgiROovPnhSxVYSUzTGqZDjLJ+zPB++QdskUjQIEPRKOeSH0WOXhGHxBPq9u/2UyUmOeLprIpNtYQYosmpXPmrU61wUUY0TynMniC5bhnaVutg67pR2isKuGQgWvZK956vnNgO6KFAFC377JnkL/YdpIpNLuNFFEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985751; c=relaxed/simple;
	bh=OKYxy/HE9AVOUtgRgq9vDg6rJHP16OAnJ6NQcciUb4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uvx5jd4XYdszDgq/xiGqYuA/wZreBGcKaPdYE3lBcsv6qbyAXETgc30tGK1ogt1Lnq7j4JqtO9bNKtu4Q+09l9CiuWuJ5o+GJZGWkEC8ZbM+s8px44oJ/Qu+fd724OvTuq7yVDVrIMlWA37C/8n6js46d2U8wyrnyWECzmhpLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcrR2DF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5010C32786;
	Tue,  6 Aug 2024 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722985751;
	bh=OKYxy/HE9AVOUtgRgq9vDg6rJHP16OAnJ6NQcciUb4s=;
	h=From:To:Cc:Subject:Date:From;
	b=OcrR2DF+lldQwB9GjlTCI4iqCKzULNBdD0dNS8ZUbtcQnyp9TBYoLjDr6phhS+XVi
	 xUZlsMFli7MFQPXWXy5g+YZBo25OMG1Rhvz2UfmSsK02EoEU1hhfA0AuermjecdKO0
	 Wk8GazKuKcFFH/fIMMYwx4+6lNGqmuwN5k6KIEV0wRHYn9SKnmclj3EXuVbUJQqF99
	 qdmUbxrbVkGttROEP892EfkPtkL49mAFhSDp155t0u0esAHvuHzi5J3wutPbEhQxHo
	 msSngIF28jer96XzpYzzqc4ER0V6bhOail8nHmhGjKwtr3QRPzYFY+/Al4Bv3IVagT
	 Wgk2rChX+Wvyw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/3] Add bpf_get_dentry_xattr
Date: Tue,  6 Aug 2024 16:09:01 -0700
Message-ID: <20240806230904.71194-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kfunc to read xattr from dentry. Also add selftest for the new
kfunc.

Changes v3 => v4:
1. Fix selftest build.

V3: https://lore.kernel.org/bpf/20240806203340.3503805-1-song@kernel.org/T/#u

Changes v2 => v3:
1. Move the kfuncs to fs/bpf_fs_kfuncs.c.
2. Fix selftests build error on s390. (Alexei)

v2: https://lore.kernel.org/bpf/20240730230805.42205-1-song@kernel.org/T/#u

Changes v1 => v2:
1. Remove 3 kfuncs that are ready yet.

v1: https://lore.kernel.org/linux-fsdevel/20240725234706.655613-1-song@kernel.org/T/#u

Song Liu (3):
  bpf: Move bpf_get_file_xattr to fs/bpf_fs_kfuncs.c
  bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
  selftests/bpf: Add tests for bpf_get_dentry_xattr

 fs/bpf_fs_kfuncs.c                            | 62 +++++++++++++++++
 kernel/trace/bpf_trace.c                      | 68 -------------------
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  9 +++
 .../selftests/bpf/prog_tests/fs_kfuncs.c      |  9 ++-
 .../selftests/bpf/progs/test_get_xattr.c      | 37 ++++++++--
 5 files changed, 111 insertions(+), 74 deletions(-)

--
2.43.5

