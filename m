Return-Path: <linux-fsdevel+bounces-10959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6B84F735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC38B1F2250F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A3383BD;
	Fri,  9 Feb 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G029cI94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30F28DB5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488540; cv=none; b=nY7Bow7okLNxR3qEOeujuRBuscU39cFW1zCnRq29jrI/Qs4DXfsG8k2bLwA/2w0z3q2RryJMFKfhLpWcsVW3wDX0EQqDQw9rE/WX7stCAJi86hds7vCr63LOkNNDVCkXSy4qkuk8mAPBlR93epneG344HQwuFnAIab0rCPFm2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488540; c=relaxed/simple;
	bh=zqJSuysga4bzGowg5hAQ49WMQFCQrrBo6DAHI/ntztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsPin0562CaJBGU8ZBXEGoQ0j7z3N2FeMAbaVrDNoTW8kOPVwfnI0Jusi4WoR4vJgDCKskvoSCbQy9OKmqubGRurEM1Y7pU1/UhUtLBMxx1XvJZnNTYEhLu/4ViKPnDiHWYM6oTtQe79OX/JSntC0Fn3gzTSltXhFDAM7TP9a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G029cI94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AAFC433C7;
	Fri,  9 Feb 2024 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707488539;
	bh=zqJSuysga4bzGowg5hAQ49WMQFCQrrBo6DAHI/ntztQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G029cI94hUHWDVbYVkpBRg6X/KYYrob3FZkQktA5Txf/YSsSijUUbvToCOPF8vxqK
	 jaUPuvoP94sJkFvxdcH/phweuq0bLikMAOEVgahtpNGfV8CyhHHMKMebOte/U2jHR5
	 ryQzCqgSm7uKk5ME6+d8jNnupBvVgAuchKY/T/yM9j3aq6N0f2svEtKOiOWrzhs8x6
	 XRoE37XqMMPeL05GTC6Xu4gCetHOtzGCDxq7g96Fq+FeRUqNGJuZN4qMxTGMBzVXq5
	 9VAFaV+p4dBw8sB5vBaYgooJPPKBuDOxiU34PX7f1ldw1N4aWTcnIEu+c05XV/QTzu
	 Hukuau7/awirQ==
Date: Fri, 9 Feb 2024 15:22:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Joel Fernandes <joel@joelfernandes.org>, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Message-ID: <20240209-hierzu-getrunken-0b1a3bfc7d16@brauner>
References: <20240209125220.330383-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209125220.330383-1-dmantipov@yandex.ru>

On Fri, Feb 09, 2024 at 03:52:19PM +0300, Dmitry Antipov wrote:
> In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
> 'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
> https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
> where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
> https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
> as well. Comments are highly appreciated.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

Yeah, according to commit ae65a5211d90 ("mm/slab: document kfree() as
allowed for kmem_cache_alloc() objects") this is now guaranteed to work
for kmem_cache_alloc() objects since slab is gone. So independent of
syzbot this seems like a decent enough cleanup.

