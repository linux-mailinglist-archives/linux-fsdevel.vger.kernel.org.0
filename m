Return-Path: <linux-fsdevel+bounces-16888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EE48A44B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 20:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B4C1F212E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5AE1369AE;
	Sun, 14 Apr 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg7CVTDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB9813665B
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120480; cv=none; b=rNcRz9y+64kijkqFuoI2kDuFtXw4IVJQfUBZ4pTnod2CUKMBs6PwUfSyVRPkTP7OADmvB5/+yj2e4FtZfkp4tI9G+Jh9WNwlyM0ctHYS/QNghe16pW2YOLnVAazuRHe4z10IfYxQcXxRbY5jPAZTrvtIXcjbRngyrhT9CsgvO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120480; c=relaxed/simple;
	bh=aZ6/9lpQPm8JbfRmQMcXKfEA/cA137YEd0VOPSwMtUk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=da2rjbyGwlnNNgBtW7so7nWB4uFpF/rdjOsofWvYr5CipBfN/jZ4Ym31LR7PObuvif+W8vo2qtN/3RPmO0o5vS4Z4FwB7Ct3dZDLW72qZiuvlAWBAAwPtvXRhOaPxT7rLHzTE/aGcsJvTV7m/N0K8R2dyWLxJFUh8vtjCo58Mbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg7CVTDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A506C32781;
	Sun, 14 Apr 2024 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120480;
	bh=aZ6/9lpQPm8JbfRmQMcXKfEA/cA137YEd0VOPSwMtUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gg7CVTDXW1FwpDP7YAACtyCxVjWKHQer45Txn9H3971T4+XZDUTSIRZp/XLr+j7r6
	 voJACU5MNwHs7xZyAjBWRyhAn02Se0rUUm/VLl3RKbyMzOkvAM36kN52KkqW1PYEDb
	 b06pXGlXJi6GGqlvjEhiCE+wPgJuEE3ktG+zTNNktIWmvwKHqOdtd6CAvjYAwDOsqY
	 hHc8DWG1mjROS8zfvM1l7/dw7fidyzXCLQHu5CPtPEPNJx3KsCKhsURPwn54/D8KGB
	 cc2s/AA8ru0JgLbQR1D0vwfvaWGFkK0gcZrL0TJNvLRrzww/9rdcbxNT1DASQO/8Kw
	 5hdd/41h5jJrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC812C43140;
	Sun, 14 Apr 2024 18:47:59 +0000 (UTC)
Subject: Re: [git pull] fix lockdep false positives around sysfs/overlayfs
 interactions
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240414110925.GS2118490@ZenIV>
References: <20240414110925.GS2118490@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240414110925.GS2118490@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-sysfs-annotation-fix
X-PR-Tracked-Commit-Id: 16b52bbee4823b01ab7fe3919373c981a38f3797
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72374d71c31596c7442ac0db9a9327d0e062e941
Message-Id: <171312047995.2589.12573917792394985431.pr-tracker-bot@kernel.org>
Date: Sun, 14 Apr 2024 18:47:59 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Apr 2024 12:09:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-sysfs-annotation-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72374d71c31596c7442ac0db9a9327d0e062e941

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

