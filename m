Return-Path: <linux-fsdevel+bounces-25693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDC94F1A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759431C21F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1301862BE;
	Mon, 12 Aug 2024 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVLniwUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C9185E73
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476467; cv=none; b=eeXXgZRhvBXnmeppgDbHqH/5a02kkxAjTdNuGFqu3TX6BOmI8ufRXdBCIKUrM5YiSrCaDunTyshMLYImkzxAjZw3kh7S1Kbb+auk31Nrd9kj4IyrE+s09sywWxGN2pI4DXBQSKSQAPlvcRYUicNDiH5UQGbj94k9OQMJiFU1Ew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476467; c=relaxed/simple;
	bh=0hWvSFJmQrqzP8qWyZrDx66iT0XLavzfpKTXRMqNxTY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eYzw8eWX4iZr85m7OX1MhX8+0v1hZfPUoy1diUjsHGRC3BjhGJjCXiTOgbWfuS/RM/Rm3+i0xtcacD28sFeSIChRsrRDj+pjYg1OJUlFFVvO0+jQL9OtYR3taredrYR66eNGId6WEVMX1rqU6QbBe9Naq88qE6YvTkUdizSN7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVLniwUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0015C4AF12;
	Mon, 12 Aug 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723476466;
	bh=0hWvSFJmQrqzP8qWyZrDx66iT0XLavzfpKTXRMqNxTY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TVLniwUsxJ/D+KfpHzrJeCfM//8viYsrAISWG+z4gkzOzlya7u93xf33pWfbxYh13
	 c72JV0vKhffFzHmaQ/vUPDp00Eq3uOGDc85YONJO/Al8aZq7e4YH7DRi3+xQiyN7Jb
	 5J+PZnt2G138ll7k0LZ2OVnu4FGMEnFKMCpY1TCiUzdssrhiLlC1kdteth0EUtZE/6
	 XEj5FjrH4qL85cLG/iLlKbkDmv8hpCHQX1YCGc82f68rdFNEvU+orb6nxUtUD5VJEP
	 bUOfRa/XT5q+QL5yaDDH3NyWBk476zN2DZcd1z0CRqSJvH2TyMNMldWaysHbpA2AJb
	 +OqbEAuXQeVyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED9382332D;
	Mon, 12 Aug 2024 15:27:46 +0000 (UTC)
Subject: Re: [git pull] fix bitmap corruption on close_range(), take 2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240812025942.GG13701@ZenIV>
References: <20240812025942.GG13701@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240812025942.GG13701@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 9a2fa1472083580b6c66bdaf291f591e1170123a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1460e457e7ae42f48d8490c1214fa29f23e4d58
Message-Id: <172347646555.1056983.15967540976211059051.pr-tracker-bot@kernel.org>
Date: Mon, 12 Aug 2024 15:27:45 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Aug 2024 03:59:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1460e457e7ae42f48d8490c1214fa29f23e4d58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

