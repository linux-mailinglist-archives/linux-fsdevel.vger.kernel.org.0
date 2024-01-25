Return-Path: <linux-fsdevel+bounces-8931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2983C76D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5671C22B3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C205774E03;
	Thu, 25 Jan 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6VsQ9cU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31E6EB62
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706198696; cv=none; b=loEFbd5B20oPGaFrcfeJzhLskGysRnYEjeJfzfPbQ6b3YHvhMYCMAiqjclc/oTj1PpC8L5HIyNbOa0C3sgmaTLIA3VQqfWHIBCIWEbEKOQS9BjeWzMH05GRUI1xXTjfsrQxLJNHjw5P0HC75JhS+QYYpVfwARjbjj5z6knjEYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706198696; c=relaxed/simple;
	bh=W987+M5oHxwhVcpVU7AhdjKzg5EnIS8G73QFHLc8xtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQAy0miQxgAgaAwvu3K0qMIqHzPKzEkWZZooP3XiwSSh2+lgv8BwuCUUIGa0cRqgsIft1gyug/V+jQh0EF4x2bEPSjaJLnmIqCoL3IXD00JE8g9KgS+zeo1bjOJz8k1bt3LaMB4EikLElAcL5FDgGYPeuJfTw3xQkZjv/TOhhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6VsQ9cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D67C433A6;
	Thu, 25 Jan 2024 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706198695;
	bh=W987+M5oHxwhVcpVU7AhdjKzg5EnIS8G73QFHLc8xtQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6VsQ9cUdh9uIeeVxVMk8LTdFFmd7iR+Xfr1V8j7pYwcVokZ3rM5cQn5rCYnjisMO
	 52IcnZhDC/CmtAgqnvNeJrntVazvAvcYmDiAJD8/SlVxaDpr9e3mmlFO8IxMABf3RZ
	 tqYWPQaEQKJm8N2e/siZQhJe/XapVoMviJbNrU7nym13W++F6jZyLO7ssbsNRpTE1o
	 F9yYQvAnN7SmWEyYo3ABu20TQKYRTRV3cdtJUqmdR4a2h3uxWxbYFSSkXtHNbCuyLQ
	 w4XyoFbpHdMRVb/rKcS+BX24QYDbntRe2BPfyjmIj5Kk62NcXNABz0THgvju2sGan9
	 qet0kqd7bJ+EQ==
From: cem@kernel.org
To: jack@suze.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Add support for tmpfs quotas 
Date: Thu, 25 Jan 2024 17:04:32 +0100
Message-ID: <20240125160447.1136023-1-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

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


