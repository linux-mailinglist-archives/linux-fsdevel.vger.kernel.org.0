Return-Path: <linux-fsdevel+bounces-10185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ACF848718
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5441C20EBC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50055F549;
	Sat,  3 Feb 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6PMVjSf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102115F476;
	Sat,  3 Feb 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973918; cv=none; b=aC8mmkxnPU6+fDPeq34fTmX0IHGPrdXGPUPRFQ02sXyZ8ik9BAjWOj1BRYnaY00bTY88/igSpwm1K5JCLDIbm6IAjjJX5luSzZGSqwTEblzf2mTmRGn+epJAGYYJMxeJ4rM5Ddav0Ezd9X8Aq91DUb27DInjWBknN4kXtLCIyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973918; c=relaxed/simple;
	bh=ekmUr4L6pSfbgul0L0LM4RLWyvoth0eyHol6PJrPvpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aOnC3yfW5EuecGu94T56E24p31serJm8fCjphNPT2J0BfmJl1ae1OYsxKoA1jOtwObzcmeDyKdPyklsSuMoTDWRqEYrVJqkiSWKiPwErw34gLsl5pTgf9bMzCH/1XYKDNpgiK2G+2tf+2vL2J8c88e6Rl9keBC3V6ko2ciEQw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6PMVjSf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE8AC43390;
	Sat,  3 Feb 2024 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706973917;
	bh=ekmUr4L6pSfbgul0L0LM4RLWyvoth0eyHol6PJrPvpw=;
	h=From:To:Cc:Subject:Date:From;
	b=b6PMVjSforq0fVW1w6vlcMOBHSt59PDGF76tdSyuBGpIkxY8IhH0Hiv9cPDvQ/nXI
	 BQLEKB2oB1tVd7sg8jZS0KG4H45Ps64YltV/gMYgn6AJPTSR5ruowokSmeIxmMxbbq
	 I+5X1O7Yfy3kUQP9Zv/mF9fdtLFZXk0JlbC6x/SoWLRUlNUWmMrNt50S5YgIl/W16q
	 cC+pxYCppCNspxtuWN1WUFRkqdhmrig70UtAB42xsZSnDkWAi2RnuxOVapBfuRVPf0
	 aQl7GQ27t/PAMZ/VPVIOWI4QzbTf5IiufUWkJinRcKHASBSzBxKMa+IsINbjeD/K1T
	 i+kXYlz/goQ5Q==
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: torvalds@linux-foundation.org
Cc: chandanbabu@kernel.org,aalbersh@redhat.com, djwong@kernel.org,
 hch@lst.de, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [GIT PULL] xfs: bug fixes for 6.8
Date: Sat, 03 Feb 2024 20:52:40 +0530
Message-ID: <87sf29efj8.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.8-fixes-2

for you to fetch changes up to 881f78f472556ed05588172d5b5676b48dc48240:

  xfs: remove conditional building of rt geometry validator functions (2024-01-30 14:04:43 +0530)

----------------------------------------------------------------
Bug fixes for 6.8-rc3:

 * Clear XFS_ATTR_INCOMPLETE filter on removing xattr from a node format
   attribute fork.

 * Remove conditional compilation of realtime geometry validator functions to
   prevent confusing error messages from being printed on the console during the
   mount operation.

Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>

----------------------------------------------------------------
Andrey Albershteyn (1):
      xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Darrick J. Wong (1):
      xfs: remove conditional building of rt geometry validator functions

 fs/xfs/libxfs/xfs_attr.c     |  6 +++---
 fs/xfs/libxfs/xfs_rtbitmap.c | 14 --------------
 fs/xfs/libxfs/xfs_rtbitmap.h | 16 ----------------
 fs/xfs/libxfs/xfs_sb.c       | 14 ++++++++++++++
 fs/xfs/libxfs/xfs_sb.h       |  2 ++
 fs/xfs/libxfs/xfs_types.h    | 12 ++++++++++++
 fs/xfs/scrub/rtbitmap.c      |  1 +
 fs/xfs/scrub/rtsummary.c     |  1 +
 8 files changed, 33 insertions(+), 33 deletions(-)

