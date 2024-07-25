Return-Path: <linux-fsdevel+bounces-24281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB493CB4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 01:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A801F21EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 23:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B9149C4C;
	Thu, 25 Jul 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNESgzqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B813C3DD;
	Thu, 25 Jul 2024 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951238; cv=none; b=lEzgrD7d94m5JzXgjIFM6rySM1IDKgTV40RPVuTyFPxch5LfpqUd+qG3bdwQrDERPx909umOTyZYNcsd2vQK4DEFMo0iVUcIx8aJI3zn2aNtvBvzGp72QZcBWAxDgJLEotlNPwUSUl8D2j8PORsu5fwU3zvRyABdsU5QMlV8idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951238; c=relaxed/simple;
	bh=4Xp8mZZlsx7mzi8EPIzc79J0caiEGv7PnpWHDRJiQO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqvYnO/WarAkYqqhg2BjBNrvH0hhy1vHxff/Td6AUlyyJLlgehcHOjCkuVHogF1yUg3XEPYb50/xlUB+KUmit4VDgBMyky+5GOQeWjmmxkg+1ILmkE/E/H7j4Z4WEeoU8FVgRDtYWL62tmufDKaaDHgkgtbUKUtBARbN9DiUcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNESgzqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A84C116B1;
	Thu, 25 Jul 2024 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721951238;
	bh=4Xp8mZZlsx7mzi8EPIzc79J0caiEGv7PnpWHDRJiQO0=;
	h=From:To:Cc:Subject:Date:From;
	b=WNESgzqxQgU12JC/NrUImMtBNfQ+Vbgrgmotu/o/euP0S9VU2Mdlu+PTbzl8GpCM5
	 iMCBRVsmvwiRuNMw2OOoJXHwwvQ4bOqO+Ei7XWbCYvu7pR6L8DKvenKMCsbJYz4Nle
	 WMjnTo31bxvX5ZPz+PDh2j6TLCcQRQA1v4Gf28JAPeUDqBrZ9T1OeCK0pTI8KO4JHM
	 c1XpIP7wPr5mloBN9BQ16K8jM17tm2wzu+TAlar6ZuNwRm3L15Tqd6IKaxVnL/1+hM
	 ofDWdPrrK6vFqesLGdBdQTGiu/1oSoBo9jLOF1rCWbew79Q9WmMr+mNo5tb9SB2FQD
	 b3BNxCKzhB/1g==
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
	mattbobrowski@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] Add kfuncs to support reading xattr from dentry
Date: Thu, 25 Jul 2024 16:47:04 -0700
Message-ID: <20240725234706.655613-1-song@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use case is to tag directories with xattr. For example, "user.allow_x"
tag on /bin would allow execution of all files under /bin. To achieve this,
we start from the security_file_open() hook and read xattr of all the
parent directories.

4 kfuncs are added in this set:

  bpf_get_dentry_xattr
  bpf_file_dentry
  bpf_dget_parent
  bpf_dput

The first is used to read xattr from dentry; while the other 3 are used to
walk the directory tree.

Note that, these functions are only allowed from LSM hooks.

Song Liu (2):
  bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
  selftests/bpf: Add tests for bpf_get_dentry_xattr

 kernel/trace/bpf_trace.c                      | 60 +++++++++++++++---
 .../selftests/bpf/prog_tests/fs_kfuncs.c      | 61 +++++++++++++++++--
 .../selftests/bpf/progs/test_dentry_xattr.c   | 46 ++++++++++++++
 .../selftests/bpf/progs/test_get_xattr.c      | 16 ++++-
 4 files changed, 168 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_dentry_xattr.c

--
2.43.0

