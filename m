Return-Path: <linux-fsdevel+bounces-28546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5407E96BB9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31068B240C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD901D67A6;
	Wed,  4 Sep 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6+UsZTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2FA1CF2AB;
	Wed,  4 Sep 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451433; cv=none; b=IjGzkCa6qNfU/QQJsbG6XwEauzkguWSZTzR2hR2EZSWZzXjP38/tv6veChep2W7rsNfTRxbUsnAskG2/DR3Wo7W+pZpkPPXN2zaX+Q9qlIfQe723WArCMa2YVTTugjVylBrGSmcVmm5LBk0Gly5aISt3qTXGBmPn3PmrJhvvWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451433; c=relaxed/simple;
	bh=LCT/94QGm1wjllwTWkWh7esCRxFn2wBTYFOGl5OcBCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OobEh91JCaHIOPYo9/231SU2Gf/XOX3W+EGpPaK8Wiga96wzY82o2zx9IAnXsexJ/cIpEKvoZHatyvVmdeL3a6IhotY1Y84mBq7GT8IyvRTwBH6aZNeXsXckz1E2cedenIyDVT5hfwoPx9JR4LhvsNYXLY/GPVdtRpbdaCxbbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6+UsZTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0773BC4CEC2;
	Wed,  4 Sep 2024 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725451433;
	bh=LCT/94QGm1wjllwTWkWh7esCRxFn2wBTYFOGl5OcBCY=;
	h=From:To:Cc:Subject:Date:From;
	b=k6+UsZTvVAZnzNhiAnJn01ApNNvoZTmspo9a2PNiQlf9kSkJm6oN4Z2IKDunCb/Ed
	 XSfDRcJ9ohu2OkTRzrhWfKUw9MWpEAllIPS49+qaWBYWKVjmXeLBPzp1dz0zeulFXX
	 KRFUqa3V5OfWK+8xOKiKpD4gyJ5BkC5xrbbVT88m/Dp5U1I6xWCsTksVCYY28CfQkx
	 21GUWhk9lwRW8Als9Ctm2ueAxvID5XE8x/aKOvibTlIcWFlBD+AbGVCOCMxPbMkoX6
	 2if3w75jIzMUfjMrOmlg+OAUNvm0s+a+lTLkMSdkiLgV3iRqcXcfVyBnDNH06LEPTv
	 1h60uxqdugrjQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed,  4 Sep 2024 14:03:36 +0200
Message-ID: <20240904-vfs-fixes-65728c7717d0@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=brauner@kernel.org; h=from:subject:message-id; bh=LCT/94QGm1wjllwTWkWh7esCRxFn2wBTYFOGl5OcBCY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd8Jm3esI9gZwdgh/WM0f9j5f9cPUk+2/fm7xX+B3qN 1ewa83L7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIjzUjw5PM/t59X5wzc2J3 3Fz39dAbRp3HWtsf7Vt/Xq32yLMZasUM/30els5yXv70wIwJL5b+/J/KYqlt+y3GMFh5vjYT+/l bM9kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains two fixes for this merge window:

netfs:

- Ensure that fscache_cookie_lru_time is deleted when the fscache module is
  removed to prevent UAF.
- Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range(). Before
  it used truncate_inode_pages_partial() which causes copy_file_range() to fail
  on cifs.

/* Testing */
Debian clang version 16.0.6 (27+b1)
gcc (Debian 14.2.0-1) 14.2.0

/* Conflicts */
No known conflicts.

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc7.fixes

for you to fetch changes up to 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f:

  fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF (2024-09-01 10:30:25 +0200)

Please consider pulling these changes from the signed vfs-6.11-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11-rc7.fixes

----------------------------------------------------------------
Baokun Li (1):
      fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF

David Howells (1):
      mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()

 fs/netfs/fscache_main.c | 1 +
 mm/filemap.c            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

