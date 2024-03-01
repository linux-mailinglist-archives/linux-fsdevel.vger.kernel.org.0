Return-Path: <linux-fsdevel+bounces-13262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8E86E144
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DB1F2196F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C649433AE;
	Fri,  1 Mar 2024 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqic8d6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97A7E1;
	Fri,  1 Mar 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297171; cv=none; b=LthreOaA3RdyfiUpQvGI8ovoo43e3L61RSrDIEIndA1tTROrrrRqfnso33Oy8FL7l+ohesgNYSaxgvLh262w99JE0ouobWJibIb0Amae1qmCu8XxWxl+t2g6Ceud5SEKYvx8xvmw6vONOuLFx97Kq0Ab8UwZRsRJK/AaI/h7Kkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297171; c=relaxed/simple;
	bh=mDOnIxNEWflmiuOfz/DFh9I5k8F0L7yGn2YjnEuogmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Og0wV7WD08JfaVuTCL32RevF3GNFOkhIUYKT1ndlhvn/yJ+U/8pl21jIZKciYV6/1R5yE0unj4eoD/6g09DZ+1XXreeZdaMD1aPCfMd7PTkuiaGzFa6S++xMzO2x4yDWuyADpwYmpxon5877owlvoHnRXOtE21cocJMXBv59PwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqic8d6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4FCC433F1;
	Fri,  1 Mar 2024 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297171;
	bh=mDOnIxNEWflmiuOfz/DFh9I5k8F0L7yGn2YjnEuogmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pqic8d6MRcsg/m/Vh4QoY2+o6POUOPIrSoNTgCg3Cimf2JAwWTTatBn8PmypGPuwU
	 xWgUYF37CScVOJrsaoZYYhiXmRPGYJMJRLx8R9ns3yLOD/sLZnmZjAKAmByTuX4hr7
	 Klf3lAvY8kxHHALBeVFCSMaGl7+COYMHXQOjWwTEKj6Oa5+HVGmyO+Lvgj7w7yjoss
	 wFcP7SLaAST86xUm0FFC6V4CaKl9Iy2IGIYA17MQJdVtpfkk9LbM3vMIlqsQc74HLz
	 ObWa/I3mUWM07W4HMYJiqC8YGjQaA4yVZbnqQ6CvkC5HQ9Uf4ja+ztDBxLhe++kHXy
	 dCFmT0UyGDDnA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  1 Mar 2024 13:45:45 +0100
Message-ID: <20240301-vfs-fixes-1ca0ae9e33be@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=brauner@kernel.org; h=from:subject:message-id; bh=mDOnIxNEWflmiuOfz/DFh9I5k8F0L7yGn2YjnEuogmQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+PMeZpamaUbxr39s3LrnMK/hfHptSuurk/kff72mdO VvozzY3r6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPlsZGbb1XLJ5t+hM4RYB NtMbKTcC8p0Ocgs3Hnedm2LHsD+Z/QrD/wD30j6+7NRrP121tPcXrPi8+M8ZRfNpT44VN0ycuGh RIScA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains two small fixes:

* Fix an endless loop during afs directory iteration caused by not skipping
  silly-rename files correctly.

* Fix reporting of completion events for aio causing leaks in userspace.
  This is based on the fix last week as it's now possible to recognize
  aio events submitted through the old aio interface.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.8-rc7.fixes

for you to fetch changes up to 54cbc058d86beca3515c994039b5c0f0a34f53dd:

  fs/aio: Make io_cancel() generate completions again (2024-02-27 11:20:44 +0100)

----------------------------------------------------------------
vfs-6.8-rc7.fixes

----------------------------------------------------------------
Bart Van Assche (1):
      fs/aio: Make io_cancel() generate completions again

David Howells (1):
      afs: Fix endless loop in directory parsing

 fs/afs/dir.c |  4 +++-
 fs/aio.c     | 27 +++++++++++----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

