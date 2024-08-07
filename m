Return-Path: <linux-fsdevel+bounces-25258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081D494A535
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B8B1F21B41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7971D47D9;
	Wed,  7 Aug 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkpsVuLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958953612D;
	Wed,  7 Aug 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025601; cv=none; b=rrfa5xZ5H87dAOhclFINoBMqOCs9m+6L7B5LcQGiMrWvyh3kyNktorVSXKxwe3wYf/trZwmzi5xArlwCbheyyzlysAgZfzu5+RQ4Xnl0zbhChcCpqdMzGbk+AFb/0xS6nwM+w3bVi4LTVHwsYZQ7ANETaH8PkjHtjefEkQCmmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025601; c=relaxed/simple;
	bh=32sFIlH+nIuN+Gj/4FUt6FCBFZ1/79vLbWF2rG8Tqdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+C3KOceR5ab1+ayDH0kD/gzn+GK9MoCNr5h17u2XIwXoOnNyVcaOdtIL457EBtT71Qqi8se5b910yUmY+tfh0lXnDEBnd4BKt2hjabaIFXlxoHVNFF5Eqif8uBP9eD5wmQaNHwkKWF7ViVeJCQzodOc2somA72MBU66hCmIZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkpsVuLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F93C32782;
	Wed,  7 Aug 2024 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025601;
	bh=32sFIlH+nIuN+Gj/4FUt6FCBFZ1/79vLbWF2rG8Tqdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkpsVuLexk5mBFnVJr4I7MG9rIb+LbDGs5pjJycdt3xVTMc1B1btTfi7xUo5Ju8YD
	 MEMyS9y7+TKz714x+T2mP/rQaxPYXxjdrxnYEWPA5wKGvjJsmX8xhXgklFn6aI5z3N
	 wFXhtxxvMd21s8wc+gDwMJ73bSLg4p2UCOsM0bK9CrhRN9+Tv+ZUbvbgb9Ey1b7/Mg
	 Uf3NisLbMkrr5JM6ee6lRjfpjh1W19aJT64qKdHKTqZOGgB4qLRnwWFr5W11DNzazP
	 ru3ERorOK85dj35fKi7TUmOIuOt0MPbL1a0UXsCzVPWltEPo0lGXeN5slb+6dO5TOd
	 lZ7pHEJG47Bsw==
Date: Wed, 7 Aug 2024 12:13:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 06/39] net/socket.c: switch to CLASS(fd)
Message-ID: <20240807-erbarmen-getextet-77b673347599@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-6-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-6-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:52AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 	I strongly suspect that important part in sockfd_lookup_light()
> is avoiding needless file refcount operations, not the marginal reduction
> of the register pressure from not keeping a struct file pointer in
> the caller.
> 
> 	If that's true, we should get the same benefits from straight
> fdget()/fdput().  And AFAICS with sane use of CLASS(fd) we can get a
> better code generation...
> 
> 	Would be nice if somebody tested it on networking test suites
> (including benchmarks)...
> 
> 	sockfd_lookup_light() does fdget(), uses sock_from_file() to
> get the associated socket and returns the struct socket reference to
> the caller, along with "do we need to fput()" flag.  No matching fdput(),
> the caller does its equivalent manually, using the fact that sock->file
> points to the struct file the socket has come from.
> 
> 	Get rid of that - have the callers do fdget()/fdput() and
> use sock_from_file() directly.  That kills sockfd_lookup_light()
> and fput_light() (no users left).
> 
> 	What's more, we can get rid of explicit fdget()/fdput() by
> switching to CLASS(fd, ...) - code generation does not suffer, since
> now fdput() inserted on "descriptor is not opened" failure exit
> is recognized to be a no-op by compiler.
> 
> 	We could split that commit in two (getting rid of sockd_lookup_light()
> and switch to CLASS(fd, ...)), but AFAICS it ends up being harder to read
> that way.
> 
> [conflicts in a couple of functions]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

