Return-Path: <linux-fsdevel+bounces-72062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A2CCDC4D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1CBC3004F01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139432AAA8;
	Wed, 24 Dec 2025 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0EVgIRw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95330B510;
	Wed, 24 Dec 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581343; cv=none; b=U+2HYxlug5ROb13roR2Lu6BnsUMrXuzbCRmFqPxf7oJRbuIHuMOuoLs9RgTRt5e+RgsOLFG0Izr9GOUmnqo6hMI7pLoCVBE4ZYA7irthQt1YrxyTv5UJoT6So/AHHKufUx6IaY0HtT43Kz03tLK1eE4K7ldwBU6wH6iEtdKiZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581343; c=relaxed/simple;
	bh=puY+uRJEBunktVCNLGWe6FrAlCs7F6rEiob4cceZR1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFUdGBfq1qYeOpyuRLnJ+Ve41K91sVFb/wcx/eNfP4s575tPj1hIThsX5wrf3kuaMlCqvNp52NdLWVXrkJt+sct+jfmPf2zE5HCkgLzBfMxQYjS2CMeNlRuCG4bwv5IeNfdhvzH8eKoHSnnCJvNZhUNEKHVeXsSIX7/CTSauJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0EVgIRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F09C4CEFB;
	Wed, 24 Dec 2025 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766581339;
	bh=puY+uRJEBunktVCNLGWe6FrAlCs7F6rEiob4cceZR1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0EVgIRwBRyK8zXqRBb3nKQtBn3kEyM1TQbV+EhCIhetu11E9htltqGOt5qZp1Jbi
	 7Lx28tL6OvW16unKPGtfsVkdPT0fO66Y2SzxSJ6JGBzmGqLvHgk1jC2x3S9zEKvcB/
	 ayNB5/VaQKMG8NIL7luMVcUboxKVmfmg+GdJ8AnHDwcZWXuj49mLyNCviXfx3LvqQM
	 /T5FXx3Tb3FqYWYYKFZrZXn1KxTVRVOdkjaAuPM6P2IhTTuFqPaFvIgmvw3s6LCzvx
	 /wQchbQKrpqvkjgPsRp1df6p/wpsaN05U8HYYRI+rnhFWrmwlhsFZ2aEU/eI/xXzNS
	 t6DRlXHP7R6XQ==
From: Christian Brauner <brauner@kernel.org>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] select: store end_time as timespec64 in restart block
Date: Wed, 24 Dec 2025 14:02:09 +0100
Message-ID: <20251224-hinwirken-erstach-957410852bd4@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251223-restart-block-expiration-v2-1-8e33e5df7359@linutronix.de>
References: <20251223-restart-block-expiration-v2-1-8e33e5df7359@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=brauner@kernel.org; h=from:subject:message-id; bh=puY+uRJEBunktVCNLGWe6FrAlCs7F6rEiob4cceZR1U=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6Pwnf+yaqucwtZIFLyjQn/g3pRec6l/RyOBwWapkyk 8dqjUZ1RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+/WRkeG2Y5LnE7dPOzBUc 5n80Hi1Q4ms7V6LDuiC80Xjva8uvNowMh1ZN25Hmfp3xU3XRH1+dYu3uL4qLbNgfSs2IOfdVcu9 8RgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Dec 2025 08:00:39 +0100, Thomas Weißschuh wrote:
> Storing the end time seconds as 'unsigned long' can lead to truncation
> on 32-bit architectures if assigned from the 64-bit timespec64::tv_sec.
> As the select() core uses timespec64 consistently, also use that in the
> restart block.
> 
> This also allows the simplification of the accessors.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] select: store end_time as timespec64 in restart block
      https://git.kernel.org/vfs/vfs/c/0f166bf1d6d8

