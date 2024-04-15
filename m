Return-Path: <linux-fsdevel+bounces-16953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6D8A56BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEA21C2123D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899F7C085;
	Mon, 15 Apr 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZHIt/LJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68278C7B;
	Mon, 15 Apr 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196046; cv=none; b=rq2c63rxSpN/+3RHneBm78Y+30a4S8nVOZ+vpgb+71s+0lP80cTOmAlp3OSkVytLq5ogmBwRmLKM8yWt1bKZR52jshskPtpG7esBq1aiChEumfHqz00hb6+thg6Rl6ePJuHkR/zZcAuSDeQ0cC5cvTQBEh2a9KQV8Ucr0FkRsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196046; c=relaxed/simple;
	bh=kqmdoARUi+zYJ/sz9hO4Rz/kqq9WqkoTBom+XH8kNBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iydtlqcVOrWmzpGOM7ajrMWH7AMUbutY7tg8SYYr8aMekdPgpF6ymWN+QViGH8vKsdTMauJQ3hnZR0NcKOOz7xRN1tJdI0aOb6ZrkN7Z6/2pCSN7Er2Q1rgu0TCV2gBIk6SgTvwDYHuHP9b/ZU1pncyoiPoQw52vMYOLDPQYcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZHIt/LJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD1AC2BD11;
	Mon, 15 Apr 2024 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713196045;
	bh=kqmdoARUi+zYJ/sz9hO4Rz/kqq9WqkoTBom+XH8kNBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZHIt/LJWow2GjwyaUJxdKlHEbLpW4MCyLzbZrXPZqxETYEFYarHOAwxDtv+m7u3P
	 PWUMlJ9x0W8B8OMWNmFr7yQRsJ8THDb72j3n7Qr83sJVzSExcwHNNQnT+zIIiwab7H
	 jau74tOiEP+dEmS3lDJvrqK9ArLErNfj8hYTFN9SjTwfET0vKBRo0vSGTo9SA3l+TS
	 hnyh/YNs+LR0ZWW0JXuef17x2sxBrTt5ohH/ciJ2GBp4pxXx/tRGiQCcKjxWZp6JTf
	 lZQz3Tct11TOq7siYkaEPrm/0ptKbLzBWGu8fNBkYVrkW7ShhKtqTjzl5rrRQxwY/F
	 uW9W7kEX+5n5g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwOYF-000000007iH-3KuV;
	Mon, 15 Apr 2024 17:47:23 +0200
Date: Mon, 15 Apr 2024 17:47:23 +0200
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
Message-ID: <Zh1MCw7Q0VIKrrMi@hovoldconsulting.com>
References: <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
 <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
 <20240415-warzen-rundgang-ce78bedb5f19@brauner>
 <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPTEYv3F9tgvJf-OakOxyGw2jzRVD0BMkXmC5ANPj0YA@mail.gmail.com>

On Mon, Apr 15, 2024 at 08:23:46AM -0700, Linus Torvalds wrote:
> On Mon, 15 Apr 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
> >
> > (1) Since the ntfs3 driver is supposed to serve as a drop-in replacement
> >     for the legacy ntfs driver we should to it the same way we did it
> >     for ext3 and ext4 where ext4 registers itself also for the ext3
> >     driver. In other words, we would register ntfs3 as ntfs3 filesystem
> >     type and as legacy ntfs filesystem type.
> 
> I think that if just registering it under the same name solves the
> immediate issue, that's the one we should just go for.

I also tend to agree, but...

> >     To make it fully compatible
> >     we also need to make sure it's persistently mounted read-only.
> 
> My reaction to that is "only if it turns out we really need to".
> 
> It sounds unlikely that somebody has an old ntfs setup and then tries
> to mount things rw which didn't use to work and things go sideways if
> that then suddenly works.
> 
> But "unlikely" isn't "impossible", of course - it's just that I'd
> suggest we actually wait for that report to happen and ask what the
> heck they were doing and why they were doing that...

I think the "ntfs" alias must always be mounted read-only because you
can currently have an fstab entry which does not specify "ro" and this
mount would suddenly become writeable when updating to 6.9 (possibly by
a non-privileged user, etc).

We also need to do something about the ntfs3 driver spamming the logs
about broken corrections also when mounted read-only even if it doesn't
eat your filesystem then.

And it seems write-support should be disabled in the driver by default
until someone has tracked down why listing a directory can currently
corrupt your filesystem.

Johan

