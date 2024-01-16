Return-Path: <linux-fsdevel+bounces-8089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8E82F4DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC5F285C36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A971D539;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvIa/26l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5453E1CF96;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431739; cv=none; b=FozuPwa0PPKBtbo2c41xo5xFnakI0o2/mMB11YqrSO6phZOIoWqypyRle2UItPlNwPCas4KzeIS5xeWTmbm7eCb/+PzduRFcUD0PHmNejO8pAQQqVDfe8ZOpFkfFUt35wYQ3QQWwUrigxQxiZj0F0adJ3Dfptu6TLQTLaaGn0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431739; c=relaxed/simple;
	bh=mabuVMcKVEOkHrK8i9xi5785IUs7iAevURAwnTbEMXU=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iESgGpLlTQYWOXjyHIFPQvOAKV0ZmrY8/tT5I+quXeU0dqL/eFGZAABlz7CfkwZEA6hx5IjFE4Pr2+RHirdauM/ZB76eO6SU080o3Y2WELM/wfGnE8zyF9l0fBuQdq2mRj9dZ6+C9S/9l3Sk3ZRjyNP4bl2K2BkOo62OhQOxtJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvIa/26l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E937FC43390;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431738;
	bh=mabuVMcKVEOkHrK8i9xi5785IUs7iAevURAwnTbEMXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RvIa/26lwIlbwqqv8SuX6pum1MW/EvyookaPicXgkDVOZiD2IsOwbdpjmQhsNGDKp
	 pTPuPgMwE+uDSRIUe9P4ZMwqlQ524EwdY+yCajAU00YKnu9c4OgWIjVeyCygUxw6wa
	 RDYJOM2tIuPJ08SHsWgdvSbYLYu4UWHt7rX9ket8d+Ij+iOnGERVJ2+52RsAuUhxvM
	 URzH61iLqst9J61zwywCH91bZ2Gp0oHchdoh/86AmLtgobJoRvtgxPLfLhd/dgEZHf
	 taCdMQpdoAYfi6AMzUGjOl2Fx6O7Q2QnaYtBy8IodNo5BUL027Y0vnDJdY+rMI6GV4
	 diJlaZ5k49OoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC827D8C985;
	Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 0/2] Move fscrypt keyring destruction to after
 ->put_super
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170543173883.30188.3991145453418147928.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <20231227171429.9223-1-ebiggers@kernel.org>
In-Reply-To: <20231227171429.9223-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
 josef@toxicpanda.com, linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Wed, 27 Dec 2023 11:14:27 -0600 you wrote:
> This series moves the fscrypt keyring destruction to after ->put_super,
> as this will be needed by the btrfs fscrypt support.  To make this
> possible, it also changes f2fs to release its block devices after
> generic_shutdown_super() rather than before.
> 
> This supersedes "[PATCH] fscrypt: move the call to
> fscrypt_destroy_keyring() into ->put_super()"
> (https://lore.kernel.org/linux-fscrypt/20231206001325.13676-1-ebiggers@kernel.org/T/#u)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: move release of block devices to after kill_block_super()
    https://git.kernel.org/jaegeuk/f2fs/c/275dca4630c1
  - [f2fs-dev,v2,2/2] fs: move fscrypt keyring destruction to after ->put_super
    https://git.kernel.org/jaegeuk/f2fs/c/2a0e85719892

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



