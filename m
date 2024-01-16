Return-Path: <linux-fsdevel+bounces-8088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A116482F4DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45124B230A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E51D535;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTyE/atv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A91C2A9;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431739; cv=none; b=uce+FqrPtapkUdryQpGrncLUlmbfwgeAmb5v3w3bsNLcg+QzLyJ4y7PNXt+j/9l9BJu5M9lAIa7mqCItByI9X7XWBxR1xSo7reqw5PfhMuYDoVuwg4mqb76Xfg/JysbS44l1PAlr3rnw+XjGO+e4d+7WnR34S3JvyEP845Qdzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431739; c=relaxed/simple;
	bh=B7KdqtNAr+YKsv310derD9kBElqfPUpwakSS4/1H6EE=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=no83Gx6vndgaYlptA+2sif2Zm6isuYHSUJNc2qPzwCk7z7mf5QTyHMobs1oQVkl9WSUWbvuljzQQVX2uTt9COxDfq/R4kphMvHDFuzk3E2hs0IIM/gNR1GwlL4iy9M+5QYX108a7470iQLzaVoBb7/j7SmXssxPY8uGl0QpJHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTyE/atv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F44C433A6;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431739;
	bh=B7KdqtNAr+YKsv310derD9kBElqfPUpwakSS4/1H6EE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fTyE/atvgWNfwbRtGAK9G4fT+t48V9auXl/dM9UBC1XrAORjlIi5Sk5uxCY3mFft3
	 W12nOB+vt1pk5Y5eQJ7cHfFOmJkPJvsHoFOtfCATr1XDymAjtZjtVYC3E2dIzth+Qy
	 a/qruXUyLG6BjMYwosh2gTkz6FHXILkeyFqWgyx3t/FxkHad7dz59tKTRafdDZjRJk
	 AGM0FQc2faIf3FMg3SordWsvUL52JNTkbE8fbXumy3MdLuYzhyjFm7S2YwlFRNgejh
	 I/IEI9/XBi42QIjbpG5427aZzPNdGx4KjJLsJdGw6CTUT/pyMBXvGbG6FHIzLMYGxz
	 y9NrZ/egbUVBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D51F4D8C9A0;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170543173886.30188.17408872425977441156.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <20230816050803.15660-1-krisman@suse.de>
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Gabriel Krisman Bertazi <krisman@suse.de>:

On Wed, 16 Aug 2023 01:07:54 -0400 you wrote:
> Hi,
> 
> This is v6 of the negative dentry on case-insensitive directories.
> Thanks Eric for the review of the last iteration.  This version
> drops the patch to expose the helper to check casefolding directories,
> since it is not necessary in ecryptfs and it might be going away.  It
> also addresses some documentation details, fix a build bot error and
> simplifies the commit messages.  See the changelog in each patch for
> more details.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v6,1/9] ecryptfs: Reject casefold directory inodes
    https://git.kernel.org/jaegeuk/f2fs/c/cd72c7ef5fed
  - [f2fs-dev,v6,2/9] 9p: Split ->weak_revalidate from ->revalidate
    (no matching commit)
  - [f2fs-dev,v6,3/9] fs: Expose name under lookup to d_revalidate hooks
    (no matching commit)
  - [f2fs-dev,v6,4/9] fs: Add DCACHE_CASEFOLDED_NAME flag
    (no matching commit)
  - [f2fs-dev,v6,5/9] libfs: Validate negative dentries in case-insensitive directories
    (no matching commit)
  - [f2fs-dev,v6,6/9] libfs: Chain encryption checks after case-insensitive revalidation
    (no matching commit)
  - [f2fs-dev,v6,7/9] libfs: Merge encrypted_ci_dentry_ops and ci_dentry_ops
    (no matching commit)
  - [f2fs-dev,v6,8/9] ext4: Enable negative dentries on case-insensitive lookup
    (no matching commit)
  - [f2fs-dev,v6,9/9] f2fs: Enable negative dentries on case-insensitive lookup
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



