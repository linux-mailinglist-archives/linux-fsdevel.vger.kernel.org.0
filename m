Return-Path: <linux-fsdevel+bounces-71023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19624CB0BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 18:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1097630CA2F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 17:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5D532ED24;
	Tue,  9 Dec 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrEbx/X4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884CA32E754
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300914; cv=none; b=iLP8GscOGWrfnYQVSy7w5Rvb6GK3vFf9Rr6RX++QT+WDwqNTEszFWXibu3DEQoCcIp7Wj+PtoLK+/L9wtH/JZWGeZrd/btJYoLZV+f98/20IDeBjl0I6YDl7O+ZWtqBHeFY3OcM88olN8EgBO3M+CcNZ9vddf0ukRNDpw2EcmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300914; c=relaxed/simple;
	bh=myGVRalgrsbtvRWYKHHOrkm0sXCxbKG58e5Al9NBxgY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jz6UX9cQ+wdIvx7cJayTF0cqtDNVHVbw2hgm1vWGMeYc5fSbk4HhQElMCa8CN5Pyj2pTjt0RRF5c0t9e8MwSJdY5kK7klzEs3pW2dw7ZDUQSW3pHRzZyMf40HWs3dAG+EQb/PFpvleMcekoWOoauvPRmO+JbvMUr13Q83l9Xog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrEbx/X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31953C4CEF5;
	Tue,  9 Dec 2025 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765300914;
	bh=myGVRalgrsbtvRWYKHHOrkm0sXCxbKG58e5Al9NBxgY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OrEbx/X4K6wBSSKwU0WbMdK8zz6f2QVZ2bc/SDpB7azF59Mv1wmjhDUxlHoxviwFf
	 YPffS438MwrcZBTso9ikk/QUa2hLyE/W4cZ9W2IHTsEwpujcI4Z4n4r6XlLDMCZDAS
	 QqnTpY1QLIbdF+snSu2TCFpDGpXzyqXQu/PYIODcU2BR7O8j3PXIglGcnSZNTbsVWR
	 FXpPxX4L4ceGKssMw4ZJ0gk4MNgLAqclRe8zQE5yRjjfnC5n/VA6icIIU4lMLmeotH
	 aZfpkEXFS1W8J8mnQxAeOmNc5h6BQ73MzjFUg5UYUeTXyxStazYK9+m7r+oliu9VnC
	 vHfAnSPG5yxjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788153808200;
	Tue,  9 Dec 2025 17:18:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 05/10] f2fs: Use folio_next_pos()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176530072903.4018985.4925454806084370297.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 17:18:49 +0000
References: <20251024170822.1427218-6-willy@infradead.org>
In-Reply-To: <20251024170822.1427218-6-willy@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Christian Brauner <brauner@kernel.org>:

On Fri, 24 Oct 2025 18:08:13 +0100 you wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,05/10] f2fs: Use folio_next_pos()
    https://git.kernel.org/jaegeuk/f2fs/c/4fcafa30b70a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



