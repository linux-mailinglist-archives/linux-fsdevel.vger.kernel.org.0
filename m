Return-Path: <linux-fsdevel+bounces-21056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7298FD1BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FE5DB29743
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA261FDF;
	Wed,  5 Jun 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY76XVen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6F27450;
	Wed,  5 Jun 2024 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601611; cv=none; b=n5cZ8uAXV6MJlP+leHsBqYtfNi575e8cWP8n3VrWlGikRHd00r49dbdaq1ORnc4hy86XG9BC7MBtrW9r4mtVSibwnIoJS6utfaBB7Ykpl72Q4CfdWLq58F9GIwon9ivByNbbcCTs7jSPyZc+5fSA3SCold3y8PHUmLy9jCO/U98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601611; c=relaxed/simple;
	bh=4lLUXsn97faWP7+i+36tE5boR7rNlTYyLIxuiFPVPbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQlPaxoJsyZqNweiDnRr9Z8NgHnszewDLep8moc4G81b7VvGlD8xCTuIcX2/MJDsLKC28vYRkAR6mtgiyK3eUT7gS0FPvoqKv9bGi0+11dPRLiqtgrnpf7vVYS0X4eyr/lTQ4E/X4ir2LzIRvLnnbFYsjdUGq1iJQgEM1vAtW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY76XVen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03B7C2BD11;
	Wed,  5 Jun 2024 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717601611;
	bh=4lLUXsn97faWP7+i+36tE5boR7rNlTYyLIxuiFPVPbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY76XVeneC2Z77c/01GHO8HLsz0kEw385P1BgievhO6xmP/qtnxze1wkQlv8UDCIY
	 ShcZuqBij1k3Qox7WU9j5MA4mO+Myx9uXO3vZedaPWUlNLpRyHgurTXiB73OLFcjtA
	 Aq3uVgnoayqmN/9Wr7Dw5bu+w9mOb3FLRLWPk/19aV0xVjnz5AV+iv7tK2iLn/7tLT
	 AmnHJ05T4whYMhyuECaKBr52Ex7KLr03RHJdftlGfpryqkNGV8bd0hL7hvZ/l3gII5
	 PHDN1iV1fQcNXGWDKDhRecNGcw5w85woaE/nP1q/TYZ+Jo2R2go2uj6MQ5zw9FGQ5k
	 tX+0J21Ezk/GA==
Date: Wed, 5 Jun 2024 17:33:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-renesas-soc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240605-miterleben-empfunden-ee9efeded6d3@brauner>
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
 <20240527-pittoresk-kneipen-652000baed56@brauner>
 <nr46caxz7tgxo6q6t2puoj36onat65pt7fcgsvjikyaid5x2lt@gnw5rkhq2p5r>
 <20240603-holzschnitt-abwaschen-2f5261637ca8@brauner>
 <7e8f8a6c-0f8e-4237-9048-a504c8174363@redhat.com>
 <20240603-turnen-wagen-685f86730633@brauner>
 <934aaad0-4c41-43d4-9ba2-bd15513b9527@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <934aaad0-4c41-43d4-9ba2-bd15513b9527@redhat.com>

On Mon, Jun 03, 2024 at 10:13:43AM -0500, Eric Sandeen wrote:
> On 6/3/24 9:33 AM, Christian Brauner wrote:
> > On Mon, Jun 03, 2024 at 09:17:10AM -0500, Eric Sandeen wrote:
> >> On 6/3/24 8:31 AM, Christian Brauner wrote:
> >>> On Mon, Jun 03, 2024 at 09:24:50AM +0200, Wolfram Sang wrote:
> >>>>
> >>>>>>> Does that fix it for you?
> >>>>>>
> >>>>>> Yes, it does, thank you.
> >>>>>>
> >>>>>> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>>>> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>>>>
> >>>>> Thanks, applied. Should be fixed by end of the week.
> >>>>
> >>>> It is in -next but not in rc2. rc3 then?
> >>>
> >>> Yes, it wasn't ready when I sent the fixes for -rc2 as I just put it in
> >>> that day.
> >>>
> >>
> >> See my other reply, are you sure we should make this change? From a
> >> "keep the old behavior" POV maybe so, but this looks to me like a
> >> bug in busybox, passing fstab hint "options" like "auto" as actual mount
> >> options being the root cause of the problem. debugfs isn't uniquely
> >> affected by this behavior.
> >>
> >> I'm not dead set against the change, just wanted to point this out.
> > 
> > Hm, it seems I forgot your other mail, sorry.
> 
> No worries!
> 
> > So the issue is that we're breaking existing userspace and it doesn't
> > seem like a situation where we can just ignore broken userspace. If
> > busybox has been doing that for a long time we might just have to
> > accommodate their brokenness. Thoughts?
> 
> Yep, I can totally see that POV.
> 
> It's just that surely every other strict-parsing filesystem is also
> broken in this same way, so coding around the busybox bug only in debugfs
> seems a little strange. (Surely we won't change every filesystem to accept
> unknown options just for busybox's benefit.)
> 
> IOWS: why do we accomodate busybox brokenness only for debugfs, given that
> "auto" can be used in fstab for any filesystem?

I suspect that not that most filesystems aren't mounted from fstab which
is why we've never saw reports.

