Return-Path: <linux-fsdevel+bounces-25282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721394A61E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81E31C229AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080921E672F;
	Wed,  7 Aug 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD+0muj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF161DE871;
	Wed,  7 Aug 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027478; cv=none; b=STo5/Gba9ZicpU1GJc9uHeFKuZmBwoKuDLP/qoHnPUbY6iLWCVxMJaa+lgqoOp5PM+UcCL5BmU2KfyiAMyiJibn3d3+zKJxN51fW8KnjN4GEC17gCEeJp1nFjH9w6ZeoXZYZo1vjdnL6zC+BErc0Lon9dmCMa57V2rJVV6vhyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027478; c=relaxed/simple;
	bh=5RU54TnA2ijxr3h+WcY1wwpjeDhbAGMzInCTx3CARxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPkuqrtllh2s2QE+OCAz8STJ6DDbFI7kiNdYWH/voSvGuUDGUcBCp5ioAQ8fdET8Kl/M/xWUZ8JwlhgibgdP2yQwlaCqqbrCNbpcXef+ZvoWgR82AMithfEU4csHAOhZNrOlvWS4ywWnENu+dF/Rf0hdxs4nVJ+Sa1s1dQvK4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD+0muj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEE1C32782;
	Wed,  7 Aug 2024 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027477;
	bh=5RU54TnA2ijxr3h+WcY1wwpjeDhbAGMzInCTx3CARxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YD+0muj3uGOf/EclPpoKfmIDCZ3+UNZ5yzbgJnsAaPnwac1wsDjHwWDXfSW/i7NCr
	 +G0X4NN+CO5gJW3nUcHRxjvfR1s0/wPkhW1wXycDU16ps8DllT+UhvsHZr+bBOOe5G
	 sMUiplP6wSN2ZHW2UEDeh75j0W2MspLU3VyveXUaG+dnfsnJDZBd71QAsGSYGWmPip
	 Jz1JgOtTO5x7S0wObbaufiUQD23od88EM5/kHscqZNQpF2IMmSGw/m9ud1Rqytk3PZ
	 IBEyHl3ywgs+91XKO99IPmtteD0Vrhh/fdFR8tT35oVoOcz3rAve2YbO9rXuIk8WSd
	 /SG0Mz3rqvJFg==
Date: Wed, 7 Aug 2024 12:44:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 35/39] convert bpf_token_create()
Message-ID: <20240807-gepfiffen-messwerte-e6dc549634e9@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-35-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-35-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:21AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> keep file reference through the entire thing, don't bother with
> grabbing struct path reference (except, for now, around the LSM
> call and that only until it gets constified) and while we are
> at it, don't confuse the hell out of readers by random mix of
> path.dentry->d_sb and path.mnt->mnt_sb uses - these two are equal,
> so just put one of those into a local variable and use that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

