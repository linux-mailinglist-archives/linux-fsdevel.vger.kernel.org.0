Return-Path: <linux-fsdevel+bounces-13248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C186DA9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2187B1C22793
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C24481D5;
	Fri,  1 Mar 2024 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="i8ileHlr";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="i8ileHlr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF84CB54
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266716; cv=none; b=LF42luV0kSBQRyJo3NSpdaEDBHYE8nHFeommOp9W//lGqyI63UBvqYyzdAKWZBhSx+OTwV+fVEd8uJowNVU0NQEaD6JeWzDvXtYPGEn+vvOjYWHtJvQJkDBZoqJhI4ycEszvjfALH26e+h/vO3H0LtTG9t2S62Qpw2VwZUZHaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266716; c=relaxed/simple;
	bh=5p/LW4JS1Y5FbVnk8Z/1edS2WpghYxTfo3KlO7AiO7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kMg0VujaUgpYmbzd5DbtOcwsa2G33JvRl21tdD+vADUd99WMrWU0e06hQx90gMdDvAENOsQ+n/c2kLDmCDxAw71QzpmQZyFIigiZ/QCPqVXDTjK5EwDU6gwW5ov7GxZ+QWi+PXc5GXjXzoHhChMebBTnHX3416fCPb1BykIJxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=i8ileHlr; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=i8ileHlr; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709266711;
	bh=5p/LW4JS1Y5FbVnk8Z/1edS2WpghYxTfo3KlO7AiO7k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=i8ileHlr/9PTgAR+6dXTkliDD7dAEIpNSyaR3PktmShzcNHU9C2WmaxfNLY9LlKEz
	 8rM2XEum+tvdfUiOvt2myW7UZM7yKaN29A5JmlBramaO5yNCz3PcLsFYJhNkIr9G0a
	 x+sNIP495OcURUtqdsa1qU8CqwrPzexqddU1AbxA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3771B128136F;
	Thu, 29 Feb 2024 23:18:31 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id n_X0Bkzttn22; Thu, 29 Feb 2024 23:18:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709266711;
	bh=5p/LW4JS1Y5FbVnk8Z/1edS2WpghYxTfo3KlO7AiO7k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=i8ileHlr/9PTgAR+6dXTkliDD7dAEIpNSyaR3PktmShzcNHU9C2WmaxfNLY9LlKEz
	 8rM2XEum+tvdfUiOvt2myW7UZM7yKaN29A5JmlBramaO5yNCz3PcLsFYJhNkIr9G0a
	 x+sNIP495OcURUtqdsa1qU8CqwrPzexqddU1AbxA=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DE6D01281209;
	Thu, 29 Feb 2024 23:18:27 -0500 (EST)
Message-ID: <da1efd23f0c228f18420d6fd4d45b8dd0a34a995.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, NeilBrown <neilb@suse.de>, Amir
 Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
 lsf-pc@lists.linux-foundation.org,  linux-mm@kvack.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Date: Fri, 01 Mar 2024 11:18:24 +0700
In-Reply-To: <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
	 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
	 <Zd-LljY351NCrrCP@casper.infradead.org>
	 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
	 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
	 <ZeFCFGc8Gncpstd8@casper.infradead.org>
	 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
	 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
	 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
	 <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-02-29 at 23:01 -0500, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 10:52:06PM -0500, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> > > On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
[...]
> > > > Let's _not_ go that route in the kernel. I have pointy sticks
> > > > to brandish at people who don't want to deal with properly
> > > > handling errors.
> > > 
> > > Error legs are the least exercised and most bug, and therefore
> > > exploit, prone pieces of code in C.  If we can get rid of them,
> > > we should.
> > 
> > Fuck no.
> > 
> > Having working error paths is _basic_, and learning how to test
> > your code is also basic. If you can't be bothered to do that you
> > shouldn't be writing kernel code.

Heh, that's as glib as saying people should test their C code for
overcommit errors.  If everyone did that there'd be no need for
languages like rust.

> > We are giving far too much by going down the route of "oh, just
> > kill stuff if we screwed the pooch and overcommitted".
> > 
> > I don't fucking care if it's what the big cloud providers want
> > because it's convenient for them, some of us actually do care about
> > reliability.

Reliability has many definitions.  The kernel tries to leave policy
like this to the user, which is why the overcommit type is exposed to
userspace.  Arguing about whose workload is more important isn't really
going to be helpful.

> > By just saying "oh, the OO killer will save us" what you're doing
> > is making it nearly impossible to fully utilize a machine without
> > having stuff randomly killed.
> > 
> > Fuck. That.
> 
> And besides all that, as a practical matter you can't just "not have
> erro paths" because, like you said, you'd still have to have a max
> size where you WARN() - and _fail the allocation_ - and you've still
> got to unwind.

So? the point would be we can eliminate some potentially buggy error
legs on small allocations.  Since we have to add MAY_FAIL and error
handling (which should already exist) to the larger ones.  It would
have no impact at all on scaling.  The question of where the limit
should be in the general case should probably be compile time
configurable.  We can probably even get the compiler to eliminate the
if (err) leg with some judicious return value priming, meaning we
achieve some meaningful bug density reduction for no or very few code
changes.

James


