Return-Path: <linux-fsdevel+bounces-53064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D995DAE9827
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08161C406A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A607265CC5;
	Thu, 26 Jun 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5EZ9zEU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276F25BF1F;
	Thu, 26 Jun 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925988; cv=none; b=rsGb14VzPefvFxuQUW1EhHHFgL7bPIsi39zZckJ42//y5hKXovl0LNVwOt0otEZ7wFge2vqFVFgKT/Q+hr6f7tJvgHA5kJf2JhbAfN8g+X5/iMFosiB7PmYdAceIdSD6Kf1JOGzgycnj42PwVPrGNf3HQD2Ds+umep7rE7iTGLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925988; c=relaxed/simple;
	bh=A8+cYAkypY9eWevvSYqveVJzX5vxPUojuCmHq0PmdRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQRssAJoaxmeb6g8lvm9RKrD8yVdjEeD2glvCvEalPT6Pw18e+4MNGBw2UbYmC6jLeekG86jEP2bL3egPuyw7//V0RL+LY4+D13GCh3UlZMadfnSPZ49giMxUSTnfVeoaRvim3fVERmB75tDvcv9N5axg4gsSVie3ltjP9vM2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5EZ9zEU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8289C4CEEB;
	Thu, 26 Jun 2025 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925987;
	bh=A8+cYAkypY9eWevvSYqveVJzX5vxPUojuCmHq0PmdRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5EZ9zEUyZlcP/Dw6+aQ+/8LrpRyAMv7CPTS6uBCJafcUx4PGemq/XGmU4teDOw2X
	 ONAMeKQv6orf+pVI9PNB2liyMGk+ms5DQW0U/DpvinSm+s42Kww13Hy2rgcKWNVVJh
	 J7xkwBo+jw8332cwhe/qphNlzia5qFd3dfVCn/crmMitZIy4xNvhzWJ+NwgDcXBFlG
	 iOeMSgFai11lVjjwelgEm8LwpzUkrID/0SLT7ouz9I5gC/WFTsCo8cNaw3EXNJYsDQ
	 iZj6d//ExvyK3PrulzLBjEDabhKJvuo9a0noyckSRbb3MyTqdEu0g1tkVV5rQxmVRZ
	 s9M2Qd4aVDJIA==
Date: Thu, 26 Jun 2025 10:19:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Arnd Bergmann <arnd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, Roman Kisel <romank@linux.microsoft.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
Message-ID: <20250626-hinhalten-behaarten-43b8f306fee0@brauner>
References: <20250620112105.3396149-1-arnd@kernel.org>
 <404dfe9a-1f4f-4776-863a-d8bbe08335e2@samsung.com>
 <CGME20250625115426eucas1p17398cfcd215befcd3eafe0cac44b33a7@eucas1p1.samsung.com>
 <8f080dc3-ef13-4d9a-8964-0c2b3395072e@samsung.com>
 <cb0c926f-15be-4400-a9b9-0122a6238fea@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb0c926f-15be-4400-a9b9-0122a6238fea@app.fastmail.com>

On Wed, Jun 25, 2025 at 03:29:50PM +0200, Arnd Bergmann wrote:
> On Wed, Jun 25, 2025, at 13:54, Marek Szyprowski wrote:
> > On 25.06.2025 13:41, Marek Szyprowski wrote:
> >>
> >> This change appears in today's linux-next (next-20250625) as commit 
> >> fb82645d3f72 ("coredump: reduce stack usage in vfs_coredump()"). In my 
> >> tests I found that it causes a kernel oops on some of my ARM 32bit 
> >> Exynos based boards. This is really strange, because I don't see any 
> >> obvious problem in this patch. Reverting $subject on top of linux-next 
> >> hides/fixes the oops. I suspect some kind of use-after-free issue, but 
> >> I cannot point anything related. Here is the kernel log from one of 
> >> the affected boards (I've intentionally kept the register and stack 
> >> dumps):
> >
> > I've just checked once again and found the source of the issue. 
> > vfs_coredump() calls coredump_cleanup(), which calls coredump_finish(), 
> > which performs the following dereference:
> >
> > next = current->signal->core_state->dumper.next
> >
> > of the core_state assigned in zap_threads() called from coredump_wait(). 
> > It looks that core_state cannot be moved into coredump_wait() without 
> > refactoring/cleaning this first.
> 
> Thanks for the analysis, I agree that this can't work and my patch
> just needs to be dropped. The 'noinline_for_stack' change on
> its own is probably sufficient to avoid the warning, and I can
> respin a new version after more build testing.

@Arnd, I've dropped the previous patch. I'll wait for you to respin.

