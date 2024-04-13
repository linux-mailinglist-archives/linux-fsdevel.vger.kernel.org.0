Return-Path: <linux-fsdevel+bounces-16848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C498A3A29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 03:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270691F22BFE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F115E89;
	Sat, 13 Apr 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6UEd6VX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB82714290
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972466; cv=none; b=TbYoZctpCZyR/wSYeFfF7RRPP/RgsEu4KmxjB0nO3kQH0zd8bWm8tMjZs/sIGufE5bo4n73+vpTe60/U9TNfXznvowVf4Cb/KBdc99y18KEJI2UroJH5NIvXX2MN3H7zcLfEVJB/M4Jz4qmRayXNWutd3p5lZgXeTl9pZwY3Khk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972466; c=relaxed/simple;
	bh=sRSiRQPpRSx0rbz3OfBDZA15EHTV7b0yg+Crq/zkQ70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sy81i1069pVYQC07BuDykThSeItHOQKwSwqvuwJ3U5yuyLa7q9GeQFRUQtqWH67XmCNqlXoPiyrHEaRuAjrP8yDUaO7jyMqd5N1xXrTuanJqgVQHijg1iIqFGNyTBCSPjInZwwoX0HWYRYROtBxdwP87xeYMVxOL9c8E0gOpG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6UEd6VX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C143C113CC;
	Sat, 13 Apr 2024 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972466;
	bh=sRSiRQPpRSx0rbz3OfBDZA15EHTV7b0yg+Crq/zkQ70=;
	h=From:To:Cc:Subject:Date:From;
	b=o6UEd6VXNU8x3exg6o6j4WJo8+rifVpGFscR5O5MJy4Ry6C5Q9O6Q7dE2NL0VxvPi
	 xELWK8Zcpqv+1ZPa09Jl2ryN7fAHtO6zVyDBPMyM4aw8eHX7Ub7zdRjLMPxRUoiGmO
	 RWVy1QCQ+Uzk6rM2bhBLOfenGr4JwTJ68kUVNteQpjq1xsjUcf0ROx0LHmmQyBc0sd
	 uVVRTEl076EZwkyugoduK6K6eJzzeLgaXRVRYuJPGfYnpWPnTqUyz+iCuAOtFzP6cX
	 fRoxspWpt3ycTrQ47WeM+djpa2FJjL+pZL1sigtLbNzdckK3+yiz9SCArZTyXv9FSz
	 oJk+o9sE9fPQw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs fixes for 6.9-rc4
Date: Sat, 13 Apr 2024 10:41:04 +0900
Message-ID: <20240413014104.1099579-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Linus,

The following changes since commit 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702:

  Merge tag 'drm-fixes-2024-04-09' of https://gitlab.freedesktop.org/drm/kernel (2024-04-09 09:24:37 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.9-rc4

for you to fetch changes up to 60b703c71fa80de0c2e14af66e57e234019b7da2:

  zonefs: Use str_plural() to fix Coccinelle warning (2024-04-10 07:23:47 +0900)

----------------------------------------------------------------
zonefs fixes for 6.9-rc4

 - Suppress a coccicheck warning using str_plural().

----------------------------------------------------------------
Thorsten Blum (1):
      zonefs: Use str_plural() to fix Coccinelle warning

 fs/zonefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

