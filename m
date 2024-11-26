Return-Path: <linux-fsdevel+bounces-35893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A739D9640
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D73B2865C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A81CEAD8;
	Tue, 26 Nov 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuqMzKAh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02514139D07;
	Tue, 26 Nov 2024 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732620379; cv=none; b=iSFB2uTvq7zftq1q4M71SZobDSmdjRkGtCzyiawHFHrdQknL051MspL+5A+Q1VXcPEoDtQGaL0uFlvL9ucH9f1kxGAyq3z2hdjO7I9VR7Pppyy7nndS+qBn55CH6cpvReR85qJ9lcnQEOJHccQWKyiVTicj1cXMjvnBOrEgNtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732620379; c=relaxed/simple;
	bh=3uT0PT2l/EMNqqJ+IljppA8Zcm78dK8fD25uA3im1Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRJ+uCxlOIDyMSWIcwNKEHRttz2kyiEix89qECFpwi5gmDtaNL+sgQqJ/ICfEZmooCtg2fsTAipOJnKaTUVk4x2sNxnj/xxzq3Tw8+7PcuFcZb+lr5oOFI9ADyKMudyp2MgA6OU/XHG3icAMM812ZPEzjs+dG0hQtc5t8VVxAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuqMzKAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E69CC4CECF;
	Tue, 26 Nov 2024 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732620378;
	bh=3uT0PT2l/EMNqqJ+IljppA8Zcm78dK8fD25uA3im1Vo=;
	h=From:To:Cc:Subject:Date:From;
	b=RuqMzKAhUhEfzY1flCqit/P2+fpsu1IwmCeNO5QcxWSbhmIuWjMdyC1kgxJW+ie5m
	 Qw2TTnI/OkKRP99w237QnMz9RGpHvUTUkdffwgqnzIs+lnmemqMTF9HX2Y0GnLVWHj
	 7CBs5By7g4o0UXjDa/tPuaPOdMIRyFpXO0O6JPaa/ANZ5d9yKtmwn175tBEWswpqvU
	 ptmfLDWBOLuETX83Ep/swMmG1RpnuuZ3qNhXUn9RmWMLYrF6hFIGt8HSxkImDfHrPp
	 mlxh+MnlscUX1YRWtjeRy2neHnFxx/qrxnisofBAwOD3FneSxoyn66x/UWS/5u+iDw
	 bzZ3/uqMI3YqA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs ecryptfs mount api
Date: Tue, 26 Nov 2024 12:26:04 +0100
Message-ID: <20241126-vfs-ecryptfs-f20bc3c7b06e@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=brauner@kernel.org; h=from:subject:message-id; bh=3uT0PT2l/EMNqqJ+IljppA8Zcm78dK8fD25uA3im1Vo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7bgjsXKFRFXys5z+nddahA3wVSluf+pdml24ofvrQ+ DSXtKlVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETeHGX47yfKn/+xhufwxxcP LKW+6DTPt1N0OvqAN+HFyyWLZyxUa2ZkuGJmWzwl+vUS9S1b5Oz0BdKFXIIEv7RsC1stvCdc1uI JEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the work to convert ecryptfs to the new mount api.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit b4201b51d93eac77f772298a96bfedbdb0c7150c:

  Merge patch series "Convert ecryptfs to use folios" (2024-11-05 17:20:17 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.ecryptfs.mount.api

for you to fetch changes up to 7ff3e945a35ac472c6783403eae1e7519d96f1cf:

  ecryptfs: Fix spelling mistake "validationg" -> "validating" (2024-11-15 11:51:29 +0100)

----------------------------------------------------------------
vfs-6.13.ecryptfs.mount.api

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "ecryptfs: convert to the new mount API"

Colin Ian King (1):
      ecryptfs: Fix spelling mistake "validationg" -> "validating"

Eric Sandeen (2):
      ecryptfs: Factor out mount option validation
      ecryptfs: Convert ecryptfs to use the new mount API

 fs/ecryptfs/main.c | 401 +++++++++++++++++++++++++++--------------------------
 1 file changed, 205 insertions(+), 196 deletions(-)

