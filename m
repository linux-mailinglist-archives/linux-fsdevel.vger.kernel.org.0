Return-Path: <linux-fsdevel+bounces-17939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE28B406C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25C31F21233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 19:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC223765;
	Fri, 26 Apr 2024 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMC0F65B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4037FBE4A;
	Fri, 26 Apr 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161028; cv=none; b=ZV5CWFkO1NUdE4yx/CjHRTmRK9Zsza4gprbw4zQx5SfohfP2KihMNhMhDQ6TkIKwTZ7qkg7aWyspGmJw0WdEZWte/G6JplHc1Kexhz/PgVzThKuThHEuK6j91nF7eOWeHMf65Q9AX9+rX6Elkr9pDeaHzwzUqZeEsBZVbHTZ+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161028; c=relaxed/simple;
	bh=MvhargL3ylJyOzWeH24MNc5xj2ittPCGif/aZcR1FPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S0lb1llFE+aSQOPP/73ZPkHjh+qQPv+XuyqPuzyTFkUBxVrVTfpzfp119FdZxeQ8e/gy2Kv+RLCqD74X2x5O5KFVhlmLiADHbJy7+o3/c1FmmlGNlsRAMId8LKjvy/LD7qoAUZVcX2wn5jyakvmqU57hRJXCTlgO2J2gms0KMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMC0F65B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76F1C2BD10;
	Fri, 26 Apr 2024 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161027;
	bh=MvhargL3ylJyOzWeH24MNc5xj2ittPCGif/aZcR1FPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMC0F65BXmJWlJe5+NgUBesegKZxh2ig+8v5Ys4vQHMoApRPFwxAkty8BQra0hE+D
	 0KfB+g7Q54YQ9rb8m6DAT2O3Vjxte6qGjNFja5SwnNp8KwTrk8uRvBpRwTWuIf3awV
	 zz6d5mpi5gNIan2CVlCHC+OpcLNoMWKfzc9kR8kXUKFCgVmrZmXl3x3Ze/4xRH866N
	 BJKOtJXpYkWge93EyGCZoVBgIpo7dw/9EzT+/9yY+uB6EyBG8T3F44G1AhN03NAX5C
	 9mE1zk80MVWhaEPkfJKt4oNt/lMZNMvbyFcK+0hvOoPRjMBUyikoLhwQPDxiN4230s
	 /BZEDU+d7ZHxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A20CFC433F2;
	Fri, 26 Apr 2024 19:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Fix a potential infinite loop in extract_user_to_sg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171416102765.32161.2308930891250088286.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 19:50:27 +0000
References: <1967121.1714034372@warthog.procyon.org.uk>
In-Reply-To: <1967121.1714034372@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, jlayton@kernel.org, sfrench@samba.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netfs@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Apr 2024 09:39:32 +0100 you wrote:
> Fix extract_user_to_sg() so that it will break out of the loop if
> iov_iter_extract_pages() returns 0 rather than looping around forever.
> 
> [Note that I've included two fixes lines as the function got moved to a
> different file and renamed]
> 
> Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator")
> Fixes: f5f82cd18732 ("Move netfs_extract_iter_to_sg() to lib/scatterlist.c")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Steve French <sfrench@samba.org>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: netfs@lists.linux.dev
> cc: linux-crypto@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] Fix a potential infinite loop in extract_user_to_sg()
    https://git.kernel.org/netdev/net/c/6a30653b604a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



