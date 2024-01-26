Return-Path: <linux-fsdevel+bounces-9084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CDA83E0FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 19:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E45B2368B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A09A208A7;
	Fri, 26 Jan 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg3c8A8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8D208A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292152; cv=none; b=d5HUtoaoZgd9GO/932AqG7BTj8T+TmoODGj/BFLNgnY0OkbybIMMv8KcbBHfmYMyhXDHfKmogopFU7voV8E5dBSP3DcupRuVdR3dGJiXpXrFbuo1fZ9oKreJ06jhaAuCQ0USzlnkXPC79c5/i8Y2H8E60TgNUJiO3Squ/xD813s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292152; c=relaxed/simple;
	bh=L4kjAwDFloOrFNoO4njZxnlpCR9dsD+UHy8+QOdKPsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Luwcx5m5n1r62USaVwUFPqlGDQEjUb0BBKn+xQzNkb4MKfXX8S26IoxpSt/JPXKNUkDioPvlSnZqaH9cdBv0zzpPdRWW1kenhsMWzbEc6zSeZjBUzPZl6HpITP75cqbB/JlHGcvtty179dpHMyokthbLbGESABsk3ryluW8U9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg3c8A8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B529EC433F1;
	Fri, 26 Jan 2024 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706292150;
	bh=L4kjAwDFloOrFNoO4njZxnlpCR9dsD+UHy8+QOdKPsE=;
	h=From:To:Cc:Subject:Date:From;
	b=sg3c8A8FvxgI6BnLEMzR5So1dnHFRR5em6Indi7OLwzNTy19vhXdxCMu5RGwW7yd3
	 4dnxIVel0k2FM1a+iucI8zMFfIHM4fK/TVRTWg0Gp+xJC3vLeWuBM3V3t/LkNODM0i
	 sClS50PDV00PA4D8Ni3WxN7UsRlxvdmWh1zUBoq9oOhm8bEdwK9B9w6Tg/a5WXiaEy
	 9eUEbpDQ7FlMxMqCvwCNf/oeDvNmfUAYzJjhg8/HXITGDMWjDjUppRY8/rOyiJFeAQ
	 zleyaVBNm2Ptf9q/G0BkbC/TiRgLhZPCspSQnR/DJ0Ukffrj5N/V0sbYl/fSH7wu3A
	 PAgLl9wVhTrdQ==
From: cem@kernel.org
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND 0/3] Add support for tmpfs quotas 
Date: Fri, 26 Jan 2024 19:02:08 +0100
Message-ID: <20240126180225.1210841-1-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

Sending again with Jan's correct email address.

This series add suport for quota management on tmpfs filesystems. Support for
quotas in tmpfs has been added to Linux 6.6, so, give enable users to manage it.

This series add 2 new helpers, one named do_quotactl(), which switches between
quotactl() and quotactl_fd(), and the quotactl_handle() helper within quotaio,
which passes quota_handle data to do_quotactl() depending on the filesystem
associated with the mountpoint.

The first patch is just a cleanup.

Carlos Maiolino (3):
  Rename searched_dir->sd_dir to sd_isdir
  Add quotactl_fd() support
  Enable support for tmpfs quotas

 Makefile.am       |  1 +
 mntopt.h          |  1 +
 quotacheck.c      | 12 +++----
 quotaio.c         | 19 +++++++++--
 quotaio.h         |  2 ++
 quotaio_generic.c | 11 +++----
 quotaio_meta.c    |  3 +-
 quotaio_v1.c      | 11 +++----
 quotaio_v2.c      | 11 +++----
 quotaio_xfs.c     | 21 ++++++------
 quotaon.c         |  8 ++---
 quotaon_xfs.c     |  9 +++---
 quotastats.c      |  4 +--
 quotasync.c       |  2 +-
 quotasys.c        | 82 ++++++++++++++++++++++++++++++++++++-----------
 quotasys.h        |  3 ++
 16 files changed, 134 insertions(+), 66 deletions(-)

-- 
2.43.0


