Return-Path: <linux-fsdevel+bounces-10656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6684D1F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2FC286C39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EFC84FB4;
	Wed,  7 Feb 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E35iDfaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829383CD9;
	Wed,  7 Feb 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332671; cv=none; b=TshDl3Le0OHFS84nlawuycgEvRW8pWqrsjkYjr5wEnQuRf/XeHdvzpwCKz95sI8/2r6b/HNsKvB/16VEc130EcAVPzkVYLtMsBn1siiw+Z3ax1+23kFeX2tI51CisyQIfVvLxleNi+EggQ36gE5HJnIE7SNcNkoX0LjxlkxuAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332671; c=relaxed/simple;
	bh=EIK1jH6AiQQfBronE608Yw6CyK0Ul2MUZ4pjU7cZTjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmtLZeOIEP+35G/M32W2XEsZ9Qzf+lIdr2l98jng9Eua0eQWrv2rkShHhC7pNl87FaxTqtPh6+l443lCDA1bxh0VmijVqSccLHnN0RKFizJ9M7ovpP5HdVxtWCiNxC32ds//oJolzQ0Zehipg9OcWQoXJdF3jXuM03dnD/vdlfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E35iDfaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46068C433C7;
	Wed,  7 Feb 2024 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332670;
	bh=EIK1jH6AiQQfBronE608Yw6CyK0Ul2MUZ4pjU7cZTjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E35iDfajHXQAd25IIl+QgzdFudxfMex9lm7q3for9EHdRA4IMzCIDe7ecMTGW+kqq
	 +kfVz5FdzZnpXVW/4yCGo1qihd83vqiKPH0XLX6i6eLDHB3myPnPheKnJwswOQVSFE
	 kCDPYbW8b+PB4LKA/ejx0IvMEzLO+P5CVdhW+XVqDMxNgYstqOhmsCrTk6bD/ICi1n
	 XEegsbvYgob4SPq75V2NuVGUIGnseC3lgwVHkfQ3sKFvda0SKk1qQH77kIKkiPNQ9X
	 YrwPewXPhKVVwFrcWqtK7VNywH4phBS3Tstkr3KuvX3axp+ZHaTyBlx3pgqXEAYnrO
	 YeXOS4vGoRGWg==
Date: Wed, 7 Feb 2024 11:04:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS
 (VFS and infrastructure))
Subject: Re: [PATCH net-next v6 2/4] eventpoll: Add per-epoll busy poll
 packet budget
Message-ID: <20240207110429.7fbf391e@kernel.org>
In-Reply-To: <20240205210453.11301-3-jdamato@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 21:04:47 +0000 Joe Damato wrote:
> When using epoll-based busy poll, the packet budget is hardcoded to
> BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
> can potentially increase throughput when busy polling under high network
> load.
> 
> Other busy poll methods allow setting the busy poll budget via
> SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
> value.
> 
> Fix this edge case by adding support for a per-epoll context busy poll
> packet budget. If not specified, the default value (BUSY_POLL_BUDGET) is
> used.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

