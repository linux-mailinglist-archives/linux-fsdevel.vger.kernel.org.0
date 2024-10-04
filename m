Return-Path: <linux-fsdevel+bounces-31001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802C990A64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 19:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EAF1C21C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AF1DAC8A;
	Fri,  4 Oct 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzyXHS1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C171D9A72
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064227; cv=none; b=Y4jWQtr5X3Fn2Aa4sGRkMnxX9PyMvhCZYWS+Q3XL5GKsbUsCj4J8xF2WdFsTJ1M6jpCOMao1bYkz/snOkNUd1M8MNFiRyVEdHRacRzi3dou66taXAk2IbcyP2MZtiX2SSDvr7r7f22vUiLHRRHAyjg0YKOLvYHYr+3Vg6q0U2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064227; c=relaxed/simple;
	bh=mGHwpXudTbb3MwKd4Qk0HHRaGmn1jVvYcg/YGUqyhuc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c8kEp6SVorrWuSXDfVctIaX4zlCAPO9G3odcY+NdwG5UH91Xn64uH8URnTqooVhsAUaExjAI4Z2CYfZtCqT700MGwHXlv8pFcM7OaUDP3xNY+2n4LroPTAmTr7A/sAcQO5OZwl7LUaJo6F3r5JoAJdeJizTD17pAurYjZgLdevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzyXHS1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624DCC4CEC6;
	Fri,  4 Oct 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064227;
	bh=mGHwpXudTbb3MwKd4Qk0HHRaGmn1jVvYcg/YGUqyhuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KzyXHS1RWaTwrTA7tc6/PXi865UHQrPvYlnuSn+20oSI8/rN+qQ2B7jhLyvdqEcdF
	 lHSN/8jYMkB9Y1d8VLOwA41FLv94PPjeaDYO4JhLABgs8qnoLTICgCxqCfEUxyfSld
	 Iw8rLC0gJEkduhlyZFAdhb9ZdhUcz0YNQ6Q6NBEcbCQbNY0L0lbdrlcg9VLz49Y9z2
	 W6d+Un3onuPX+VCxnqQlbPJ+Kc7Z6FA0LJ4VMGffFA/+xdsI8LdmFbOVUqRQn0Zuc6
	 mN8vbnrV3LlxPfUCRMuGwdKpxY04PKFRXAu0IV1G61VmoaA9JrXog3hK8Cm4Gtno/q
	 4yRGrdaB2TjrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39AF039F76FF;
	Fri,  4 Oct 2024 17:50:32 +0000 (UTC)
Subject: Re: [git pull] missed close_range() fix from back in August...
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241004045656.GP4017910@ZenIV>
References: <20241004045656.GP4017910@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241004045656.GP4017910@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 678379e1d4f7443b170939525d3312cfc37bf86b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6cca11958870b9b1d64933ffe1a4c11b0e6e6bbb
Message-Id: <172806423107.2676932.7625738877562856623.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 17:50:31 +0000
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 05:56:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6cca11958870b9b1d64933ffe1a4c11b0e6e6bbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

