Return-Path: <linux-fsdevel+bounces-65010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE6BF9085
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 00:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B524404537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58595299AAC;
	Tue, 21 Oct 2025 22:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu2ck7DD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A926980F;
	Tue, 21 Oct 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085165; cv=none; b=Za8rrZIPbRCrCcapSQjLAMbo4Thopl4PCUihxIEF2PjVOAeigQYz+h0ZrV8aLhpGYc4+VYJN6z1UWJxhABukhqPln4SzZTCDenmz/XdzllQExfTAKlfoJQYzPDV0nRzl10M1OTSKwaoM9BEdCMwcAZfpD24ZtElrUAmHKwNwC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085165; c=relaxed/simple;
	bh=54cLEZeel//FAJJ4yMXaf9nVZzdqOC+0l5+nBDj5Fj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnBe2W/p6vNr/sltY/D+So4ZwW/Bf9LLtgWg1AIsmSDhGtZh9rKzjEmGN3HrJS848epd3UiyhvhcFL3L4uDx6OZjUe+FEwYqn4EjL6upFwrnLwwh36nDkcFzwYNhrrYg0Yxsom+css6cwNtlIPBdq24GHSoJ7/vbE49NKAa1HWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu2ck7DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1319C4CEF1;
	Tue, 21 Oct 2025 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761085165;
	bh=54cLEZeel//FAJJ4yMXaf9nVZzdqOC+0l5+nBDj5Fj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bu2ck7DDbmfcsOfCsbRZlfDV/rpMBYlHXqW3mFVwsaoH9wNIkmgtsbM87NCAuijyO
	 RqPWhlg8tvVjxsEfA41oS8zV+Yj8lPf71FVNeMqXB/07+nrFmakevRZURpIUixRV6N
	 /CgbJpsRD17qnB+SH4dgCPKb1LVbfFQXFyg43SKtfklAgNVWXqlbweVeY9llKCLtQe
	 +Vy8fxRzCODnIrEBiUsacKvoqkRqTBia1XeNvqbLYEXAnlF1mVh+xiluSaqmH9q692
	 bzDuguid+/FveXHHDh8cz1OYs6sZ4z1CNDWAE+6CFDuOJbFxiaQEwdtjT5+LrR+P0v
	 r80F6lZblGS8A==
Received: by pali.im (Postfix)
	id 178D342C; Wed, 22 Oct 2025 00:19:20 +0200 (CEST)
Date: Wed, 22 Oct 2025 00:19:19 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <20251021221919.leqrmil77r2iavyo@pali>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
 <20251020183304.umtx46whqu4awijj@pali>
 <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd-EZ1i9CeQ3vUCXgzQ7HTJdd-eeXRq3=iUaSTkPLbJLCg@mail.gmail.com>
User-Agent: NeoMutt/20180716

On Tuesday 21 October 2025 10:49:48 Namjae Jeon wrote:
> On Tue, Oct 21, 2025 at 3:33 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello,
> Hi Pali,
> >
> > Do you have a plan, what should be the future of the NTFS support in
> > Linux? Because basically this is a third NTFS driver in recent years
> > and I think it is not a good idea to replace NTFS driver every decade by
> > a new different implementation.
> Our product is currently using ntfsplus without any issues, but we plan to
> provide support for the various issues that are reported from users or
> developers once it is merged into the mainline kernel.
> This is very basic, but the current ntfs3 has not provided this support
> for the last four years.
> After ntfsplus was merged, our next step will be to implement full journal
> support. Our ultimate goal is to provide stable NTFS support in Linux,
> utilities support included fsck(ntfsprogs-plus) and journaling.

One important thing here is that all those drivers are implementing
support for same filesystem. So theoretically they should be equivalent
(modulo bugs and missing features).

So basically the userspace ntfs fs utils should work with any of those
drivers and also should be compatible with Windows ntfs.sys driver.
And therefore independent of the used kernel driver.

It would be really nice to have working fsck utility for ntfs. I hope
that we would not have 3 ntfs mkfs/fsck tools from 3 different project
and every one would have different set of bugs or limitations.

> >
> > Is this new driver going to replace existing ntfs3 driver? Or should it
> > live side-by-side together with ntfs3?
> Currently, it is the latter. I think the two drivers should compete.
> A ntfs driver that users can reliably use for ntfs in their
> products is what should be the one that remains.
> Four years ago, ntfs3 promised to soon release the full journal and
> public utilities support that were in their commercial version.
> That promise hasn't been kept yet, Probably, It would not be easy for
> a company that sells a ntfs driver commercially to open some or all sources.
> That's why I think we need at least competition.

I understand it. It is not really easy.

Also same thing can happen with your new ntfsplus. Nobody knows what
would happen in next one or two years.

> >
> > If this new driver is going to replace ntfs3 then it should provide same
> > API/ABI to userspace. For this case at least same/compatible mount
> > options, ioctl interface and/or attribute features (not sure what is
> > already supported).
> Sure, If ntfsplus replace ntfs3, it will support them.
> >
> > You wrote that ntfsplus is based on the old ntfs driver. How big is the
> > diff between old ntfs and new ntfsplus driver? If the code is still
> > same, maybe it would be better to call it ntfs as before and construct
> > commits in a way which will first "revert the old ntfs driver" and then
> > apply your changes on top of it (like write feature, etc..)?
> I thought this patch-set was better because a lot of code clean-up
> was done, resulting in a large diff, and the old ntfs was removed.
> I would like to proceed with the current set of patches rather than
> restructuring the patchset again.

Sure. In the current form it looks to be more readable and easier for
review.

But I think that more developers could be curious how similar is the new
ntfsplus to the old removed ntfs. And in the form of revert + changes it
is easier to see what was changed, what was fixed and what new developed.

I'm just thinking, if the code has really lot of common parts, maybe it
would make sense to have it in git in that "big revert + new changes"
form?

> >
> > For mount options, for example I see that new driver does not use
> > de-facto standard iocharset= mount option like all other fs driver but
> > instead has nls= mount option. This should be fixed.
> Okay, I will fix it on the next version.
> >
> > Pali
> Thank you for your review:)

