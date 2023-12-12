Return-Path: <linux-fsdevel+bounces-5716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7380F1E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BAE2817C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AC77F01;
	Tue, 12 Dec 2023 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xkBEcTch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C329D3;
	Tue, 12 Dec 2023 08:08:34 -0800 (PST)
Date: Tue, 12 Dec 2023 11:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702397313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hnO8ui/6f1vcdg7veT/LtnaA15I1T8SwlC3y/iEPPCs=;
	b=xkBEcTch+h1ZSuhlOWHz4ya7NFEEauFZQQcQ5dLCSnofi175pZulW27uwYMnsfdmrugRWw
	ShtoajXTcY4NYw7JrC24BDwxgjgW3T4YIz3p+n9MP981LRRVVPsD6qSIHMFB9ILCbI104l
	kb4LD5urD968i1qPoKdQxXzezI9PVLs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212160829.vybfdajncvugweiy@moria.home.lan>
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <20231212154302.uudmkumgjaz5jouw@moria.home.lan>
 <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 04:57:41PM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 16:43, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > On Tue, Dec 12, 2023 at 04:38:29PM +0100, Miklos Szeredi wrote:
> > > On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > > Other poeple have been finding ways to contribute to the technical
> > > > discussion; just calling things "ugly and broken" does not.
> > >
> > > Kent, calm down please.  We call things "ugly and broken" all the
> > > time.  That's just an opinion, you are free to argue it, and no need
> > > to take it personally.
> >
> > It's an entirely subjective judgement that has no place in a discussion
> > where we're trying to decide things on technical merits.
> 
> Software is like architecture.  It must not collapse, but to function
> well it also needs to look good.  That's especially relevant to APIs,
> and yes, it's a matter of taste and can be very subjective.

Good taste is a highly important trait - in the course of normal work we
trust our subjective opinions constantly, because those opinions have
been trained by years and years of judgements and we can't reason
through everything.

But when you show up to a discussion that's been going on for a page,
where everything's been constructively gathering input, and you start
namecalling - and crucially, _without giving any technical justification
for your opinions_ - that's just you being a dick.

> On this particular point (STATX_ATTR_INUM_NOT_UNIQUE) I can completely
> understand Christian's reaction.  But if you think this would be a
> useful feature, please state your technical argument.

Well, you could have scanned through the prior thread, or read the
extensive LWN coverage, but in short - inode number uniqueness is
something that's already impossible to guarantee, today.

In short, STATX_ATTR_INUM_NOT_UNIQUE is required to tell userspace when
they _must_ do the new thing if they care about correctness; it provides
a way to tell userspace what guarantees we're able to provide.

