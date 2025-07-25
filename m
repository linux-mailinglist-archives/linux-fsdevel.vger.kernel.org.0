Return-Path: <linux-fsdevel+bounces-56014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB44AB11A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CABA1897AB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B362459E1;
	Fri, 25 Jul 2025 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yca7r8iG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7422CBE6;
	Fri, 25 Jul 2025 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433652; cv=none; b=cqNCv/2+WOXO1iLQVAq61bDVyQCHNqcsSVQtCPz01JUeJ5VOHLbQ6zC+Pt9DxBPnyaT7KZIYCfjli0LGlKATAh9qgRvNrvNA9ijgykbpiuB12GKIzTr2btgq9Ib54IborK6dgMj78Zx7IEuyX3WdaDEnPUCwtnxlcM4y3FCUitM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433652; c=relaxed/simple;
	bh=tSfYIZ31g+vLvLIWsAu0i8e7Fhb3tcLvIKszGYITlTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBVNtwNX3CcnFsS6ktwMMuXciE0M03O8ae8mijUR4CmlhDaJlUG+xn7pEs75bMmBZUxqQtUsKU+lqqmfLgOmgpuRzmLXz6B0qHmckvQ7fb2iIsTLkJemGKgA7msIYAE9Zs9hj0nPZs+r7GJazZArfIpTu0yok08cVw56diqk0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yca7r8iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7040DC4CEE7;
	Fri, 25 Jul 2025 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753433651;
	bh=tSfYIZ31g+vLvLIWsAu0i8e7Fhb3tcLvIKszGYITlTA=;
	h=From:To:Cc:Subject:Date:From;
	b=Yca7r8iGcZn2qq8huCpS61iSt4c+pF968o1OhEmGCEP4GembZIse7yUqHaD2JmXhL
	 lu9yoje+pcrLB7ZacfQWY4ElRxc54ATBktBXPd4r2UJ7YA11IWkcU8UhhyhAqgDjnq
	 vglN2AiHGlfx40e2iBJ+R2fcAhduyaqQfly/r8OrOLhIOOnJ6E4x+CqOJmuUjHRtif
	 RuPryohOOQlPO6SJQGfJHWT/rD98v/iPV9Ejfgre/ZL4wP45ZeJ6AhYPbpzJMk1FUY
	 sieDvHZl4wcjKXM33Js8fej0a8d9cCPW5IXie/rmEoELnSX/BZ3tCksBY5s7xVjN8b
	 rToLjzOgZRsiQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 25 Jul 2025 10:54:00 +0200
Message-ID: <20250725-vfs-fixes-067e349ed4dc@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=brauner@kernel.org; h=from:subject:message-id; bh=tSfYIZ31g+vLvLIWsAu0i8e7Fhb3tcLvIKszGYITlTA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0u2nsezTNOGbbR+bjn0vfMhxaOCc1VXthxe6LFQEu+ oF2TwMKOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayNJSR4bJD4bF+1nnK18ss lZwbpsUf+h6s0hh84cesgvP/FsZu52f4H/L0StU983LT3wZ1aZttq3d6TXx0XupAg9+jn/8+Xz3 4hxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains two last-minute fixes for this cycle:

- Set afs vllist to NULL if addr parsing fails.

- Add a missing check for reaching the end of the string in afs.

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

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc8.fixes

for you to fetch changes up to 8b3c655fa2406b9853138142746a39b7615c54a2:

  afs: Set vllist to NULL if addr parsing fails (2025-07-23 13:54:34 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc8.fixes

----------------------------------------------------------------
Edward Adam Davis (1):
      afs: Set vllist to NULL if addr parsing fails

Leo Stone (1):
      afs: Fix check for NULL terminator

 fs/afs/addr_prefs.c | 2 +-
 fs/afs/cell.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

