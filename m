Return-Path: <linux-fsdevel+bounces-9368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7888404A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDC41C226D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A654F604C4;
	Mon, 29 Jan 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5jxudOO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1265FEFE;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530227; cv=none; b=hhIkIEToauYuAFlR1Vmdtz08TufYDm/8rOOTqa9ZkUbbWk32YqxRYK7kDcN0aj0YpZJtd042WVOUZ0+KXNOq2uJkzPdp21q3wxG21dS5bhiiemib7gX3J6pOrmXsNgz2Hk38kbQx7fOB1u0YsVha04HwLEMz8MOBh/rBXu0K0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530227; c=relaxed/simple;
	bh=iz0dFAW58yqZGL7j3dGGKZP1Ew+s3LKz5hSYf4xXUX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C1U8/LsGb8SIwk4UVuXJoGHVeNwLIUSrvGe7VHD3q6loyaIGdiUmxww82O7nWeP+Rb4m6ax/UR44ZQHiMqNF4yQU+/eCwpb/jPb6CWJd3Zn6YxAVxG1nUzJrct07fF+6fx0P4tzjuYQ3jzc2cgIeu1UfnPhfeHqYRoK+JaQ1PM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5jxudOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60207C43390;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706530226;
	bh=iz0dFAW58yqZGL7j3dGGKZP1Ew+s3LKz5hSYf4xXUX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G5jxudOOJatUSgnbdRkuNGRkJOo05pOEKVhsBDXosMqDaPKFnO/9gHGx1QJhCIvDy
	 DvYW7XhmBXf0nrUMsJIUPN74N4hzL+k2UrUv/3FmldQHFa9zQuYp0sJYpRWFa8UGGL
	 6xZruGiaDBY9sFwlxWEsEJervZ9hQ3YfTGLZxT7IoA3Z/dmjOueRzii2Ncj4nvQrlX
	 zINGsk8+mVIrBFmxH7Lu1CQnp/HL9CLTkiMWrHoQUufiMj9JoWz3b3akScTDFmGpnZ
	 MGOVUQreD6oFLAlqe+VzAB+ouabb+wiHTP+KUsY1cYKFZlbfTO/z0UVDtiIWeEnqUJ
	 VANtvh2KUyhPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46912C561EE;
	Mon, 29 Jan 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: add sanity checks to rx zerocopy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653022628.12593.4708063524897046829.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 12:10:26 +0000
References: <20240125103317.2334989-1-edumazet@google.com>
In-Reply-To: <20240125103317.2334989-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 zhangpeng362@huawei.com, arjunroy@google.com, willy@infradead.org,
 linux-mm@vger.kernel.org, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 10:33:17 +0000 you wrote:
> TCP rx zerocopy intent is to map pages initially allocated
> from NIC drivers, not pages owned by a fs.
> 
> This patch adds to can_map_frag() these additional checks:
> 
> - Page must not be a compound one.
> - page->mapping must be NULL.
> 
> [...]

Here is the summary with links:
  - [net] tcp: add sanity checks to rx zerocopy
    https://git.kernel.org/netdev/net/c/577e4432f3ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



