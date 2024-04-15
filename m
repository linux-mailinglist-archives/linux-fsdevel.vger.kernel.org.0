Return-Path: <linux-fsdevel+bounces-16959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8FE8A5706
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDF61C2215D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490987F7F2;
	Mon, 15 Apr 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0MU7oX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB4762E0;
	Mon, 15 Apr 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197165; cv=none; b=IepfJf6u2dqQk6wAUviqsZSMTp3v2rdgXmz78OEtYN6CSSBsBGOleSQMzzt8rswRDWVuKNPDngDGUBX2okTo283Koto0I4WdJIqk0oTKj0aCDeDfG7kiQZBEcwJ+PWS1K8bYUjvOMHNa0M7t6bPj6HO0MXzi5QtkLZA2xH0hCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197165; c=relaxed/simple;
	bh=DHgzmazo1Glv7ZL1pMj7ynM9gjCt5b18g1EiYByuCMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRBJuPfoAKgMFmrXaQB2+NZvfrKmBf3lXg9ve0PcAU3ObH5snki+6gRD6/Z1JUqJJyw9cvoIlKMladh4rvuHoYxTu6VK+QQu5r04uBy4RBtx+/n21r5MeTidTu+PVSgcw7NMslA0Gm8wBfFdmsRErQTrnMqvCoTFNH5jIVM5UGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0MU7oX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C66DC2BD11;
	Mon, 15 Apr 2024 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197165;
	bh=DHgzmazo1Glv7ZL1pMj7ynM9gjCt5b18g1EiYByuCMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0MU7oX2cT1a03rWZMgFvCiVD8hPTXC89YYghSzOnBVzm6NbRi3wCCrG6D4K+cUe5
	 49ccilD9ypoqL6tKwOoah1iwhBEc5+Jf2nFqaEjVLo1U/lHChB+ZfucL8bGGzAORa2
	 BfCOgR8k9CLr81hRPuept9mqPFbbprBu671uOdfysjQnaCw3Z5IJcbd5UPtnuqKroQ
	 kUGWsONyTPmwsFH6FvUi3LWVxhnECaIk8jWdYDXy8xeNeewTaPSdwaSmqp1JqNCiPG
	 B7rDvXfpe4KyQWiuU84Yx29GYUQSK1FjIXMbFqx9OMMaiaYURDBqswfno8dF5LNwBD
	 zwQ41sNQEaDEw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwOqJ-000000007z2-1tiT;
	Mon, 15 Apr 2024 18:06:03 +0200
Date: Mon, 15 Apr 2024 18:06:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Anton Altaparmakov <anton@tuxera.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zh1Qa2aB2Dg_-mW4@hovoldconsulting.com>
References: <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
 <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner>
 <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
 <Zh1MCw7Q0VIKrrMi@hovoldconsulting.com>
 <CAHk-=whN3V4Jzy+Mv8UZGTJ5VEk_ihCS8tu3VskW-HCfBg6r=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whN3V4Jzy+Mv8UZGTJ5VEk_ihCS8tu3VskW-HCfBg6r=g@mail.gmail.com>

On Mon, Apr 15, 2024 at 08:51:13AM -0700, Linus Torvalds wrote:
> On Mon, 15 Apr 2024 at 08:47, Johan Hovold <johan@kernel.org> wrote:
> >
> > I think the "ntfs" alias must always be mounted read-only because you
> > can currently have an fstab entry which does not specify "ro" and this
> > mount would suddenly become writeable when updating to 6.9 (possibly by
> > a non-privileged user, etc).
> 
> Well, it would be fairly easy to do particularly if we just do it for
> the old legacy case.
> 
> Of course, even the legacy case had that CONFIG_NTFS_RW option, so
> people who depended on _that_ would want to be able to remount...

Ah, right, I forgot about CONFIG_NTFS_RW as I've never enabled it.

Judging from the now removed Kconfig entry perhaps not that many people
did:

	The only supported operation is overwriting existing files,
	without changing the file length.  No file or directory
	creation, deletion or renaming is possible. 

but I guess it still makes my argument above mostly moot.

At least if we disable write support in ntfs3 by default for now...

Johan

