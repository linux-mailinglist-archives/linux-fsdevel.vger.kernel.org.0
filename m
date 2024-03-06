Return-Path: <linux-fsdevel+bounces-13743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23269873584
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D99282C24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81297866F;
	Wed,  6 Mar 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fht1wwZ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3C78289;
	Wed,  6 Mar 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724088; cv=none; b=hO60yJJ9Jyob8U7AfFook/AEeXcdnC2HMe9yPFy6KzNYDPFJRgiU/AEG6J/oXwttkVEKC3IP7pw2R5f13yB8mxXAmH+PDj/A5Ggscd1sFcUKaU3rAsGc6A4pFcxj1bQ1f0fF6nz4dRo3vCt0VynbqJRab0tAMRE2FDYjNH/TuP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724088; c=relaxed/simple;
	bh=RkRJtwgFgpfo1xGOWNTLjGovEUdRcH/RJqx3/0BlreU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNGJG+4dfbz8xdrsHB289DAe3DCPUYz8V1A5MX7UdZ967GWrnV/6vYpxvJjBF88XWdoG1Xw/Jw2xmyLdYQw6N4sFALlRA2jrMgqtfxg+HpHFw+Z3Mfno6MOxG5JWU2phoFpkK1zXoTG3fxr+nNfkaT3TvtYRUFTUMwwOOzK4Hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fht1wwZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D9C43390;
	Wed,  6 Mar 2024 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709724087;
	bh=RkRJtwgFgpfo1xGOWNTLjGovEUdRcH/RJqx3/0BlreU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fht1wwZ/WXR9h8ehBlp7rXLrEkqa56e3VosCkSQPxNOZQ6YYpAnu9LdKPwTgE7eg+
	 zwivZf3g/2Cbnh+cUBZqVcu2JD3yYpY4jsTtEuuNUdVF2pl191KFAFTqXQVmtcv29z
	 vtfkbMcacMNNMgwPxKngCNnOeBu/G375VmRWY1wptVBpEPE+WdkniBupBNU+5M+Sgk
	 2SCX8QpReN04krVkz3inxcaui7O4Aoe1+ujcGl+o7QKYHtGO1ADzV/5CwdKLhkyLcN
	 ZvbBHzo6rv1Lbd8YtzLb7ucV3rdFe1usQL2GA0eeEZnlzNDycgOF9KOeAiX8LqwXjL
	 NDzJCJ7TycJgA==
Date: Wed, 6 Mar 2024 12:21:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 0/9] add new acquire/release BPF kfuncs
Message-ID: <20240306-flach-tragbar-b2b3c531bf0d@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

On Wed, Mar 06, 2024 at 07:39:14AM +0000, Matt Bobrowski wrote:
> G'day All,
> 
> The original cover letter providing background context and motivating
> factors around the needs for the BPF kfuncs introduced within this
> patch series can be found here [0], so please do reference that if
> need be.
> 
> Notably, one of the main contention points within v1 of this patch
> series was that we were effectively leaning on some preexisting
> in-kernel APIs such as get_task_exe_file() and get_mm_exe_file()
> within some of the newly introduced BPF kfuncs. As noted in my
> response here [1] though, I struggle to understand the technical
> reasoning behind why exposing such in-kernel helpers, specifically
> only to BPF LSM program types in the form of BPF kfuncs, is inherently
> a terrible idea. So, until someone provides me with a sound technical
> explanation as to why this cannot or should not be done, I'll continue
> to lean on them. The alternative is to reimplement the necessary
> in-kernel APIs within the BPF kfuncs, but that's just nonsensical IMO.

You may lean as much as you like. What I've reacted to is that you've
(not you specifically, I'm sure) messed up. You've exposed d_path() to
users  without understanding that it wasn't safe apparently.

And now we get patches that use the self-inflicted brokeness as an
argument to expose a bunch of other low-level helpers to fix that.

The fact that it's "just bpf LSM" programs doesn't alleviate any
concerns whatsoever. Not just because that is just an entry vector but
also because we have LSMs induced API abuse that we only ever get to see
the fallout from when we refactor apis and then it causes pain for the vfs.

I'll take another look at the proposed helpers you need as bpf kfuncs
and I'll give my best not to be overly annoyed by all of this. I have no
intention of not helping you quite the opposite but I'm annoyed that
we're here in the first place.

What I want is to stop this madness of exposing stuff to users without
fully understanding it's semantics and required guarantees.

