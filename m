Return-Path: <linux-fsdevel+bounces-25663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233DE94E9E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 11:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A117B2241B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5616D4F8;
	Mon, 12 Aug 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EskCtEqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956120323
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455347; cv=none; b=mhXNOXIGG7LAD5ceC0I3EUHk+qOQmTc3MdY0J9qKkB8i15CcxNvYV1UVCpLcItOB8+UVOuB0qytIbUXEl0lE0qlp+7CCwmiFMLuc3wXTRL+01ZCxc+JScAWU9bVxx8sa9jRkKNGagJe4rD2Lq0/y8QqB0dm4JeVcJczEjHyq89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455347; c=relaxed/simple;
	bh=0RAqw/+M1HkPQ2bnMjIwj856QrYhUS9FLzwGs2TPICQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCgL1fOCrkPVYTohdJDUTltp5PmdeEUHJirSa/DyV4w7zl5GhxYVOEyi9K8bUMl0oLfIs4tQFRqikk8NWkmEFQiUsf1XEFoBdCC7eritidiAVGwKKpJomKiv6w+PyJKWosa/qRLRPh6DsIXrS4jGJDM/K/i0crlm4QZLcvZ3eJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EskCtEqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D318EC32782;
	Mon, 12 Aug 2024 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723455345;
	bh=0RAqw/+M1HkPQ2bnMjIwj856QrYhUS9FLzwGs2TPICQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EskCtEqQJlUkPGBCPxOulCT93/KByNT6Ugk3Lt3pYdIoVXlJ79c4zT5EZzXuslFh1
	 /5hLmRpcyy3SzI+GIpN7p0Akl7E+Ktuw7V8Xp/h0Lw7dR102hSNBgTBm/VPwZpTiVJ
	 9yMtKQU4CbuBlsej8E6/2Vp/np2hGtqlMjTeV1FPIGRV1dQ1TsUFubEPaQqXXstEth
	 bHxyANZ2ELqxnLKZgEGx0G2NjfQEDw1Vd7IwA4tf29ig5AGHVL8Q0RQDrtXhOmPkob
	 G3yE0Q1uww4KV4mlBuhPNTINwLHNntRa0VqB5d0X8/uPogGW452InlHA1O6n1+0Fft
	 z5XgBhuLi6kIQ==
Date: Mon, 12 Aug 2024 11:35:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/11] alloc_fdtable(): change calling conventions.
Message-ID: <20240812-nutzfahrzeug-ferngeblieben-f606dd2a027e@brauner>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
 <20240812064427.240190-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240812064427.240190-10-viro@zeniv.linux.org.uk>

On Mon, Aug 12, 2024 at 07:44:26AM GMT, Al Viro wrote:
> First of all, tell it how many slots do we want, not which slot
> is wanted.  It makes one caller (dup_fd()) more straightforward
> and doesn't harm another (expand_fdtable()).
> 
> Furthermore, make it return ERR_PTR() on failure rather than
> returning NULL.  Simplifies the callers.
> 
> Simplify the size calculation, while we are at it - note that we
> always have slots_wanted greater than BITS_PER_LONG.  What the
> rules boil down to is
> 	* use the smallest power of two large enough to give us
> that many slots
> 	* on 32bit skip 64 and 128 - the minimal capacity we want
> there is 256 slots (i.e. 1Kb fd array).
> 	* on 64bit don't skip anything, the minimal capacity is
> 128 - and we'll never be asked for 64 or less.  128 slots means
> 1Kb fd array, again.
> 	* on 128bit, if that ever happens, don't skip anything -
> we'll never be asked for 128 or less, so the fd array allocation
> will be at least 2Kb.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

I'd copy the rules from the commit message into the function comment
(Maybe not the 128bits part).

Reviewed-by: Christian Brauner <brauner@kernel.org>

