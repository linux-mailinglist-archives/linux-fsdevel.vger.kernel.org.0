Return-Path: <linux-fsdevel+bounces-6161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA6813EC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 01:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC47283EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 00:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CFB805;
	Fri, 15 Dec 2023 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLh+iabv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF5363
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Dec 2023 19:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702600598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSylWbosBNBGHLPin/OZI2sugc03tGYwEDwO/pvcfoM=;
	b=CLh+iabvfcEShn1Q9RBL5D3pFhYDhOfsUJJowvw8qmXjU/P0S9xoQoh2XgKgF+4oPFT/8F
	DsNzV1NEPIgh1/DrlRLnzmdsldULn8tNtjM9h5qtqtbdXc58o+3rat/VcYhu4VbS5ns23g
	7xfTA1+MLaLxNMEFf7FcYyxb+9N+sQs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231215003635.uxwxdr4uesskqkwv@moria.home.lan>
References: <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <170241761429.12910.13323799451396212981@noble.neil.brown.name>
 <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>
 <170259406740.12910.16837717665385509134@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170259406740.12910.16837717665385509134@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 15, 2023 at 09:47:47AM +1100, NeilBrown wrote:
> On Wed, 13 Dec 2023, Christian Brauner wrote:
> > On Wed, Dec 13, 2023 at 08:46:54AM +1100, NeilBrown wrote:
> > > On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> > > > On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > 
> > > > > Other poeple have been finding ways to contribute to the technical
> > > > > discussion; just calling things "ugly and broken" does not.
> > > > 
> > > > Kent, calm down please.  We call things "ugly and broken" all the
> > > > time.  That's just an opinion, you are free to argue it, and no need
> > > > to take it personally.
> > > 
> > > But maybe we shouldn't.  Maybe we should focus on saying what, exactly,
> > > is unpleasant to look at and way.  Or what exactly causes poor
> > > funcationality.
> > 
> > I said it's "ugly" and I doubted it's value. I didn't call it "broken".
> > And I've been supportive of the other parts. Yet everyone seems fine
> > with having this spiral out of control to the point where I'm being
> > called a dick.
> > 
> > You hade a privat discussion on the bcachefs mailing list and it seems
> > you expected to show up here with a complete interface that we just all
> > pick up and merge even though this is a multi-year longstanding
> > argument.
> 
> I thought I was still having that private discussion on the bcachefs
> mailing list.  I didn't realise that fsdevel had been added.

I only thought that the discussion had gotten to the point where we had
something concrete enough to start to circulate more widely.

I wonder if some introspection could go into why this has been a
multi-year longstanding argument.

