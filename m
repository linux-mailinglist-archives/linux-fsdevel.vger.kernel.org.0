Return-Path: <linux-fsdevel+bounces-11097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436A85102F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73871F213CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA117C67;
	Mon, 12 Feb 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIpTByYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B01BDC2
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731967; cv=none; b=NXJRZTVH43ytQQmfv5mwfZWYF8doXB8Otwm0XiUuXYB1AsKuOSa54pXgo+HnpP6JuzvLezIoaYBWpj98UUzCSsk74lm52ynF84ClN8MCCm7izZaBto4nE6sFXrz8xD6LBvwE29OFvxVIZDCZbW8SMNbK2Z7lzAX7wMg3oZSMzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731967; c=relaxed/simple;
	bh=Wrt+qIySAgiHc7gyjfBHoo8kesbs+XZ+YBHPtgL/QxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNlTsQbDBSuOza9JiJ9yy5R6KsQJyr7mhreA1RoBe+EETKkN72Y0dCyv5H50i/kClXMtENmSYZtdi7DeBZtQw5lL9bye0H2lT8QgwkPk1jK4V5afVv1wsxBIik17D56gj0D20t73jNQ5T4qL5zadZ2Z2EVXVCbSanWHlVRBmnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIpTByYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD30C433C7;
	Mon, 12 Feb 2024 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731966;
	bh=Wrt+qIySAgiHc7gyjfBHoo8kesbs+XZ+YBHPtgL/QxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NIpTByYPHuTvHeGJ2j+hNYeq+VPNDfnEluUIH8tFdyouqtyLoZuAFt3ugljelSNoX
	 nWe1F9PqAf3rgu4H+lF0/1FzzwW73faA/ZelYGa+S5Clpj/KUCKX52Vga6jaa9gZO6
	 m2s2z4OALCyZrlje2PfKPAknE89UXgLKHCOLQWYgyuGgkt3Ol1hIZLQv2/SCySc6ks
	 MDwhyuEuWp3qo9XurDt2PmA8lSOhCE4iCjy/daCn7XDfeDvJ/cuD3jafAzkPopI3RJ
	 H+sFZXlaelYfc/9eWGDtWXVU6iBCsblxqt2Enc3Q5dlCfG7dZYh3FvOsBH3KKr+i/U
	 twl0KqOWKDx7A==
Date: Mon, 12 Feb 2024 10:59:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, 
	Catalin Marinas <catalin.marinas@arm.com>, Joel Fernandes <joel@joelfernandes.org>, 
	linux-fsdevel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] [RFC] fs: prefer kfree_rcu() in fasync_remove_entry()
Message-ID: <20240212-wettmachen-magisch-bb4f18ab0b7e@brauner>
References: <20240209125220.330383-1-dmantipov@yandex.ru>
 <20240209-hierzu-getrunken-0b1a3bfc7d16@brauner>
 <20240209163646.GD608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209163646.GD608142@ZenIV>

On Fri, Feb 09, 2024 at 04:36:46PM +0000, Al Viro wrote:
> On Fri, Feb 09, 2024 at 03:22:15PM +0100, Christian Brauner wrote:
> > On Fri, Feb 09, 2024 at 03:52:19PM +0300, Dmitry Antipov wrote:
> > > In 'fasync_remove_entry()', prefer 'kfree_rcu()' over 'call_rcu()' with dummy
> > > 'fasync_free_rcu()' callback. This is mostly intended in attempt to fix weird
> > > https://syzkaller.appspot.com/bug?id=6a64ad907e361e49e92d1c4c114128a1bda2ed7f,
> > > where kmemleak may consider 'fa' as unreferenced during RCU grace period. See
> > > https://lore.kernel.org/stable/20230930174657.800551-1-joel@joelfernandes.org
> > > as well. Comments are highly appreciated.
> > > 
> > > Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> > > ---
> > 
> > Yeah, according to commit ae65a5211d90 ("mm/slab: document kfree() as
> > allowed for kmem_cache_alloc() objects") this is now guaranteed to work
> > for kmem_cache_alloc() objects since slab is gone. So independent of
> > syzbot this seems like a decent enough cleanup.
> 
> Sure, but we'd better make very sure that it does *NOT* get picked by any
> -stable prior to 6.4.

Yeah, sure. I've not marked it for stable exactly because of that. _But_
we can't exactly control AUTOSEL. Maybe there's a way. In any case, I'll
keep an eye out for it and will reply appropriately.

