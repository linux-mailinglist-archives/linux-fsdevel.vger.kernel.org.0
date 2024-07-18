Return-Path: <linux-fsdevel+bounces-23909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5152934AA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B31C20AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D68063C;
	Thu, 18 Jul 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1CkBwtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDF6A332;
	Thu, 18 Jul 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293341; cv=none; b=QC45ew/3lNH1UYYiEKnk/QIOkffaj7oQSuj0vawGR/seyqLAmfmBQb0gvBVtqTETTPQoRZuQQ1J/m+rYBB2DIawHtGDRpDNKSGg/ZBob9kzVfFJL73P1hrG1MHxLlCGcruxdbU4NPPAbbBPAXCuLpVqFI9A8KRR+EjqWtlPiqB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293341; c=relaxed/simple;
	bh=CF1vJ7lc7QaIbSdcLbqGIssh70L1EjLJtfvUaeX+6vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwxreV0fVwLUvY8svT8FlInBjR6HV8ZMGbKi9HVlxv3fvRCHjdgQbaDMW1AtZKWMshUg5KqOIUioitmzvVIWPNOC3xUYgLb9Rox5M3/XtcUrkmgrmTvGxBfUp8MKPw6iYlBeLNug6uznpDZViJUwr5i2tbkYDRCdBintgehC9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1CkBwtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5041C116B1;
	Thu, 18 Jul 2024 09:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721293341;
	bh=CF1vJ7lc7QaIbSdcLbqGIssh70L1EjLJtfvUaeX+6vM=;
	h=From:To:Cc:Subject:Date:From;
	b=I1CkBwtVgH7J7lTUnNf+ej83/pmhXWAKM6nX8l6omaHmoU00qUIWX71FiasqZXr9w
	 lCC345xuowhRxAiqA93XTU4SvpLQrcSc4Vpii//cCzGFHCMMW72NciJyJuOw3mMwkT
	 cwl0ZZX8qZ6HXps8SWkxL9tEQms2hZafKMWqNWl+lgNgTbHaub4LCz7hMjwW7eklK4
	 KtukrmoznZ7qibd8KPNFb6kV5dAWUwxkHB2Ljxv+EmPLtOBzkaY9WApdVHEVOdEFvl
	 J0041Ja5Zwkr9q3M6SD+6iqV2JbhzbpzDhYS6Ri/Bl6QSz1EQeMaCod24EV4vl9Uvz
	 PQzi6Cu08XLXA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 18 Jul 2024 11:01:55 +0200
Message-ID: <20240718-vfs-fixes-ea80df04af07@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=brauner@kernel.org; h=from:subject:message-id; bh=CF1vJ7lc7QaIbSdcLbqGIssh70L1EjLJtfvUaeX+6vM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNuMXxwMErjJPJtFVU/udTf0MzozthsTdKco6vsIzbu zf9yJ9PHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5O5OR4fFfk/7TKpoXGr57 buVtvR5yZN++j58e+yXItv/bt82SS56RYeHznVWT37+4mdt6sDr6YPG1lefKT83KkYjiTFxWWSv jyAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains fixes for this merge window:

- Fix a missing rcu_read_unlock() in nsfs by switching to a cleanup guard.

- Add missing module descriptor for adfs.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

/* Conflicts */
No known conflicts.

The following changes since commit b1bc554e009e3aeed7e4cfd2e717c7a34a98c683:

  Merge tag 'media/v6.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2024-07-17 18:30:10 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes

for you to fetch changes up to 280e36f0d5b997173d014c07484c03a7f7750668:

  nsfs: use cleanup guard (2024-07-18 09:50:08 +0200)

Please consider pulling these changes from the signed vfs-6.11-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11-rc1.fixes

----------------------------------------------------------------
Christian Brauner (1):
      nsfs: use cleanup guard

Jeff Johnson (1):
      fs/adfs: add MODULE_DESCRIPTION

 fs/adfs/super.c | 1 +
 fs/nsfs.c       | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

