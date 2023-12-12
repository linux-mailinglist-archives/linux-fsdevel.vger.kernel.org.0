Return-Path: <linux-fsdevel+bounces-5711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1E580F129
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D991D280789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C976DC7;
	Tue, 12 Dec 2023 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEbGNtGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF632100
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 07:35:47 -0800 (PST)
Date: Tue, 12 Dec 2023 10:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702395345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJi9dGA3qHpQnTz+St/q5yOa6Gz9ssitrSg35TwaQcU=;
	b=cEbGNtGv8Y4bijcnELjxcizW3/LEQplX5lChqW0U3Psh/KZbLjR+BPqdgCKLkNb/SWZDH9
	uZIgOnJnRjIuGV9a70/gT0d8reY7eCCB1xTR6+XiU+bmvhcuyiqjtK7FaVBvqUqdFy4ziy
	fptzToMudHIBoJb3joriEroHUe+V3j8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
	NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
References: <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-neudefinition-hingucken-785061b73237@brauner>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 04:29:09PM +0100, Christian Brauner wrote:
> On Tue, Dec 12, 2023 at 10:16:31AM -0500, Kent Overstreet wrote:
> > On Tue, Dec 12, 2023 at 09:56:45AM +0100, Christian Brauner wrote:
> > > On Tue, Dec 12, 2023 at 08:32:55AM +0200, Amir Goldstein wrote:
> > > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > > >                               same inode number
> > > 
> > > This is just ugly with questionable value. A constant reminder of how
> > > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> > 
> > Oh hell no. We finally get a reasonably productive discussion and I wake
> > up to you calling things ugly and broken, with no reason or
> > justification or any response to the justification that's already been
> > given?
> > 
> > Christain, that's not how we do things. Let's not turn what was a
> > productive discussion into a trainwreck, OK?
> 
> That's a major aggressive tone for no good reason. And probably not a
> good way to convince anyone. I'm also not sure why you're taking a
> dislike of this flag as a personal affront.

No, if you're going to show up with comments like that it is entirely
called for.

Other poeple have been finding ways to contribute to the technical
discussion; just calling things "ugly and broken" does not.

