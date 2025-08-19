Return-Path: <linux-fsdevel+bounces-58290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677CB2BEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795F15640B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668D279DC4;
	Tue, 19 Aug 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs9krP8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608C1990C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598810; cv=none; b=KZFpptetFrDHNRlEd85kjgrijG7zKwW1/e9cy00Wo4IzbtrT1TOaDy4pGxmhUa+CcCWiPoefthbvVV/Mlh0yD38E7GNBaBkglWNKAu+RNHiGmb9WGUc0d1+4j7631OwciFKYV2ZznHh8/WxqOVSK1rX+8oyRLXyXVpx1VpbEi5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598810; c=relaxed/simple;
	bh=h2ECP+XahocfVOQXVyfY2YF59pnhPKQ9aJZsGc01fhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9ZEnv1e7k3nrDMU1Esz1f2GfuXmAqTHluVC0025wHoYboQFnZh5fS4aQa+VMNg862q5iVBH0oJkar1EkllzqBuN8P3rBGVKNptJMH0i6opzmAkCJ7T6+A/Pid23CFeDzWk7yAx9CMEOqb7TEfTi7rdcO380DoWV0vyWQBUPuMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs9krP8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493C1C4CEF1;
	Tue, 19 Aug 2025 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598810;
	bh=h2ECP+XahocfVOQXVyfY2YF59pnhPKQ9aJZsGc01fhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs9krP8vV9XdgfxtUZTrifTNK+OgMiegRwzxhVUv/lwAFnUyAxTbe+9qlGyhCjUMT
	 ane05R2hgAst8o9H60ymus6aZk6rg6IswJ76qjGoYCdw+XBcybYhn/XmZgRw/lNll/
	 /YBVCQQW0Q/9SeVhas/mMTgTVnF1QGXqc9WbaRudtWKYC+o0WwhDuw7dWBrx9KxcA8
	 60d5wjTe4VaBoVEDZF8YNX4GJamlIG+6GryCGgJ6yzx5fw/k2LNrl0LJL4yS2Kgxgn
	 3lVcjfMCadXfF68q4CYWMgggfnvrBb6NNR7+F6jH1/EN7cHbQ5rfWFOFKevZOimN7Z
	 qt2fRqo7VkKbQ==
Date: Tue, 19 Aug 2025 12:20:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCH 3/4] use uniform permission checks for all mount
 propagation changes
Message-ID: <20250819-wahren-petersilie-b2d1632bcf22@brauner>
References: <20250815233316.GS222315@ZenIV>
 <20250815233524.GC2117906@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815233524.GC2117906@ZenIV>

On Sat, Aug 16, 2025 at 12:35:24AM +0100, Al Viro wrote:
> do_change_type() and do_set_group() are operating on different
> aspects of the same thing - propagation graph.  The latter
> asks for mounts involved to be mounted in namespace(s) the caller
> has CAP_SYS_ADMIN for.  The former is a mess - originally it
> didn't even check that mount *is* mounted.  That got fixed,
> but the resulting check turns out to be too strict for userland -
> in effect, we check that mount is in our namespace, having already
> checked that we have CAP_SYS_ADMIN there.
> 
> What we really need (in both cases) is
> 	* we only touch mounts that are mounted.  Hard requirement,
> data corruption if that's get violated.
> 	* we don't allow to mess with a namespace unless you already
> have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).
> 
> That's an equivalent of what do_set_group() does; let's extract that
> into a helper (may_change_propagation()) and use it in both
> do_set_group() and do_change_type().
> 
> Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not ours mounts"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

