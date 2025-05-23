Return-Path: <linux-fsdevel+bounces-49755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE5AC2114
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5666017E20E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C481522839A;
	Fri, 23 May 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4XTOfEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7E519C55E;
	Fri, 23 May 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747996039; cv=none; b=I3eg6FDX1rbcw09eMd77/OI+NpRC6hK3EQFJQhQ1YsZca2PqcYMK87mcxQLW3BARmcsGxuXaCEA+1Yn8uyuQyxG52fTlDGwa+Tp1zdAj13OFCZIZ9zEoebQE+yxppe7uUK21aVWQPBW9I6+zO2bWytP6h8yzmKuOnoe7CMFHKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747996039; c=relaxed/simple;
	bh=qZPZt2MCqkQbffLUMjGjNgAIhm+xWjCy+b4MK9UHJqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkgWMqBF61A97ehbU5qGGz0lTMtqVxLZ9h9VmsNrrTwwiLaJ8Wc2c9pQ2ABOCGmlUWc/Mt87i/DbAN5eOpyoAdi1gSVzj/ZxT49JAGVb50KiTX3MJ1cduqXpRDPshvI2ZxTGu+UqfWxTs/cc9B4PMAD162DvflAuaGWYlGd0ZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4XTOfEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FEBC4CEE9;
	Fri, 23 May 2025 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747996038;
	bh=qZPZt2MCqkQbffLUMjGjNgAIhm+xWjCy+b4MK9UHJqk=;
	h=From:To:Cc:Subject:Date:From;
	b=S4XTOfEGJfulyzRVEB5JxVsx/6IHRkHz15PTIjZLmTIl0NEcYgsV8axire4qhKgy1
	 l4tMidcE7V3GQlIpOyzc0kZ+kOIlc2Ad/k8FNVDQl+5ocZWRc7XBEI2QDxevkslzS9
	 7cp1fcgQ6Q+tVPJhq5xfE6oNyBxzD389dIjJFSwtBZbaNtUsK+JOnYMz1/rgUl1MAI
	 B0X8nXLrpos7FFtVhXprHWEwmOI2E7gCWLysE/KSZKAtquitKD8nkudtfYZh/qaGn3
	 oszKnb+twgzGvtvjIRmiZdnFSh+KtOxZbBTLlMxRIcP/If2vIxN589wgJJgoNP5oI6
	 gG2Jv8w4GjCig==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 23 May 2025 12:26:22 +0200
Message-ID: <20250523-vfs-fixes-187d59638114@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=brauner@kernel.org; h=from:subject:message-id; bh=qZPZt2MCqkQbffLUMjGjNgAIhm+xWjCy+b4MK9UHJqk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY+FaLd7C6zK89/mG7inlR/7rE1YUbZutvv9j2zOLcy 7IozVmfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyJ5eRYZWAfFOP60yOoEVy 1ev9ZvblrH7U1Sqi8WEzg8DFxpSSvYwMW+35mn8ufnK5S2dyyfL3/4+9WPKyVmFv94SyzjamCeL WvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a small set of fixes for the blocking buffer lookup
conversion done earlier this cycle. It adds a missing conversion in the
getblk slowpath and a few minor optimizations and cleanups.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc8.fixes

for you to fetch changes up to 7e69dd62bcda256709895e82e1bb77511e2f844b:

  Merge patch series "fs/buffer: misc optimizations" (2025-05-21 09:34:31 +0200)

Please consider pulling these changes from the signed vfs-6.15-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc8.fixes

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "fs/buffer: misc optimizations"

Davidlohr Bueso (4):
      fs/buffer: use sleeping lookup in __getblk_slowpath()
      fs/buffer: avoid redundant lookup in getblk slowpath
      fs/buffer: remove superfluous statements
      fs/buffer: optimize discard_buffer()

 fs/buffer.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

