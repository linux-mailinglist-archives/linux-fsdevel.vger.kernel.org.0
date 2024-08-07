Return-Path: <linux-fsdevel+bounces-25284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F794A673
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BACB2B2CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538EC1E3CBE;
	Wed,  7 Aug 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJxmorv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF215B98F;
	Wed,  7 Aug 2024 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027636; cv=none; b=gmeQX1AbMYlnG5ppRWfQliGpXHDvh58KOTUIQzhvAB7pLtR+3UwrqpkNp9nd+gJ7Gb394UQ8SrACbpu6enP+67kAG0pbgQBB129Q1BNxlA1n4Fo7b4Qv+A2IuzND+dr3uC+a/93/8dO9TtLjYCSr2q0I4sHrj/OimHj/yldR1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027636; c=relaxed/simple;
	bh=MK6FGPZSvr0Z593Exs7oN9J3ZkOS51c2qkF2THNHzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0tKTYTh4tK/2Zi8SsLLZJRZ9aBy3/sdEFdrFvRYnLQUMKHVVOiBCz00PmSrUK3HJx7cGI9Ku4q3qaYi3ZDRvWIAiOEYiNSgu/TkJ8mP4vl0H0WmcHVRvit5iY0wgezzeeDfGFC9r/mR1JTYjXPTzPmd1gEZWZhcTSDkpzAyEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJxmorv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9E5C32782;
	Wed,  7 Aug 2024 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027636;
	bh=MK6FGPZSvr0Z593Exs7oN9J3ZkOS51c2qkF2THNHzfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJxmorv/3VvGwwBOwZCJ9SBfAUpKvJS89dwJJkL2gGrLMSboVh4aY2SK3TdoVwwuh
	 809gSOwdlq+xyk2rvIHMxl0g6e8OmUvPS0Pv2YYA0iskJmHKf49fh0ihYE96cyKzD8
	 bnZISJxCyb00ZsQTQxruAEoN0c0l5ELMo2yHvN2JD+iVjK5Ial4Qgg4FIgI5CfCTCf
	 EmKuLG7wITfpIjXknjQgP51Kzy2Bbdp3qa6/TS/dDx8a0SvNWfhO+i26PCiGZ6sqq/
	 GurRC1tA2nzz2IIRYFfDiavbgcFwyXHbHZhTF/3gXeYPnEtA7rHIyGY0xBNKJQtjnv
	 zQMRHuc/D8/5A==
Date: Wed, 7 Aug 2024 12:47:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 37/39] memcg_write_event_control(): switch to CLASS(fd)
Message-ID: <20240807-baldrian-drehkreuz-a0119795f1af@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-37-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-37-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:23AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> some reordering required - take both fdget() to the point before
> the allocations, with matching move of fdput() to the very end
> of failure exit(s); after that it converts trivially.
> 
> simplify the cleanups that involve css_put(), while we are at it...
> 
> [stuff moved in mainline]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

