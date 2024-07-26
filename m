Return-Path: <linux-fsdevel+bounces-24341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E8293D7FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FD81C231FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CAF17D348;
	Fri, 26 Jul 2024 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSdYruMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8817CA0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017274; cv=none; b=Uat71tG4GYL6XPVI15QvDw06jDjJEFokSAWEnfTokpmsIeYbsIV9TKNVqst7gz7nZYl24sl53sxR6nnMBuKEboRUoHWaIBcuJhaWq22cTstSCJ2IZC124QLW2B4PaYCupDVK3PbiX2YhsUNsZXq+JDG2OCbVaznIrrNdEwIiios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017274; c=relaxed/simple;
	bh=LrU1eO20s+Lc2HMJUajtpefbAiD/A/kzc12t0XHbnVo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NHekhjP8xSOsQplDdHG+rJdUsFtBMoZxKCbhqftPCAS2fKOb0DjfiCOD/Rk0dfQIOclK1XPmeABbBciLcI44X6egnetY3aw7rtGLsAYNSxQGZIez+cZ6Cwpckfwo9z6h6eShre/Wtix1NVtzQxn6bJ2Va0U26TaW2hhTXHk3BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSdYruMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C85E4C4AF07;
	Fri, 26 Jul 2024 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017273;
	bh=LrU1eO20s+Lc2HMJUajtpefbAiD/A/kzc12t0XHbnVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qSdYruMGHPyiKfdfm2N1Iq17nLtsRAJyWF5/HYkUb1GDCTQNmK0i0BRxhgDN1o/DN
	 1L5jcSD3vNoHJt6a1GVvdOMVrcpKnJlLh1ikXTjXe9n/8QWtZ2V8wH38pyuqn+GNUu
	 etl+BOnvLZaipCyeSuPw9cVmrm5ReliS8x2bR0v/+CyCl1hrwMjY48wp0+AevYtd/+
	 PR+aox37IFganE7lM2f0CBiQ7++Gn777iT4ElSNeATYyXo7Zr7f0YUGQpJyJ8I6YMT
	 +NVUvLnQaO6uME566sujYKPY/ZL96TtJwyQdgaMQ8MHik5X+t2EK9svuSZPbi92Hjo
	 1+Z6s/1CwkjyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0DE6C433E9;
	Fri, 26 Jul 2024 18:07:53 +0000 (UTC)
Subject: Re: [git pull] (very belated) struct file leak fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240726054138.GC99483@ZenIV>
References: <20240726054138.GC99483@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240726054138.GC99483@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: bba1f6758a9ec90c1adac5dcf78f8a15f1bad65b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd90ad50cb372056d01a9913ce80aaa526826593
Message-Id: <172201727378.32235.7770879475610890750.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jul 2024 18:07:53 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jul 2024 06:41:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd90ad50cb372056d01a9913ce80aaa526826593

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

