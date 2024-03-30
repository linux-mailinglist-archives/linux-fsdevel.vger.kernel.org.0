Return-Path: <linux-fsdevel+bounces-15772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B7892B7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 14:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B0F1C20FF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838F92D03B;
	Sat, 30 Mar 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PubxICAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61C8BFC;
	Sat, 30 Mar 2024 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711806860; cv=none; b=FmCupPtpBb+5PcHQKWuVl5+KqOF6v0RVbvOseDqCaJbhvBwDI22iSL1HsiyYpk/nSQA2JrsaoRnDSGAAARm4smYU6bzTJyotGtdjFxErrLGFRdXRv0XyUz6sHW/2ZmRa27Nghsaow+tUVuS54Y6epS9+cW2CSSG1r+CEt5OLNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711806860; c=relaxed/simple;
	bh=gdiN5QceMOmYJR6aANoPIK9P+VOtXiE5jti77EzMyng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvhMJNQZGA+tr+mScsz8Pc/JSpPP+X4an1/fNaBxlTWlb2hg5g9oDsmgM2PjTxR+HodT2LN4b7CPwVHYwKWkgUnSbo8/EbqlvC6wc5iRtnzOi0O5O94JECYj3XLfsBCTPaG9q1biqr6IuaXy9xzXE20nMJJI9XyUEcMt7dBk79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PubxICAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E9AC433C7;
	Sat, 30 Mar 2024 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711806860;
	bh=gdiN5QceMOmYJR6aANoPIK9P+VOtXiE5jti77EzMyng=;
	h=From:To:Cc:Subject:Date:From;
	b=PubxICAPFkULCDHrQInMKvt2ftqscwq70N6vX9ZqASVjAp8t5oYpBlGWrvCgHY3YD
	 NXba2llksm6YUEoKNje3YwcMqeRjNADEpMRCSnrwXZyLTk5EwXIpH6JfrxKQi9nI1O
	 aF7Hnukoid+Aijov1T7qenSgIIwM5zXFaWR0Z4ljkBXp/K0feDbGPczApsDlOqGsTr
	 SW0Kn17L7J90R8xPzZJ1taWFr8PMHR43CHp/tXGIt1+DBJ8LHeWB49uqSvY/8pl7TU
	 yEAdc5l+bDPMOJ/SnlpAkwlywDep7TUDRQUd+pOudcaOgsOTLvGyuFQFraNz4R/PC5
	 54p6P9XmvlV+A==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org, dchinner@redhat.com, djwong@kernel.org,
 hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 mark.tinguely@oracle.com
Subject: [GIT PULL] xfs: Bug fixes for 6.9
Date: Sat, 30 Mar 2024 19:19:34 +0530
Message-ID: <875xx3lta0.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Linus,

Please pull this branch which contains two XFS bug fixes for 6.9-rc2. A brief
summary of the bug fixes is provided below.

I did a test-merge with the main upstream branch as of a few minutes ago and
didn't see any conflicts.  Please let me know if you encounter any problems.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.9-fixes-1

for you to fetch changes up to f2e812c1522dab847912309b00abcc762dd696da:

  xfs: don't use current->journal_info (2024-03-25 10:21:01 +0530)

----------------------------------------------------------------
Bug fixes for 6.9-rc2:

 * Allow stripe unit/width value passed via mount option to be written over
   existing values in the super block.
 * Do not set current->journal_info to avoid its value from being miused by
   another filesystem context.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Dave Chinner (2):
      xfs: allow sunit mount option to repair bad primary sb stripe values
      xfs: don't use current->journal_info

 fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++++++---------
 fs/xfs/libxfs/xfs_sb.h |  5 +++--
 fs/xfs/scrub/common.c  |  4 +---
 fs/xfs/xfs_aops.c      |  7 -------
 fs/xfs/xfs_icache.c    |  8 +++++---
 fs/xfs/xfs_trans.h     |  9 +--------
 6 files changed, 41 insertions(+), 32 deletions(-)

