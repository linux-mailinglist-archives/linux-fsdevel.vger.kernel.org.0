Return-Path: <linux-fsdevel+bounces-5724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178C80F35C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD684B20DD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33577A224;
	Tue, 12 Dec 2023 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L1bguwEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADBE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 08:41:36 -0800 (PST)
Date: Tue, 12 Dec 2023 11:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702399294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcT5dzqkNb7nk+Wonzwn1SrUsw3iMdiGcuo3tKoKXl4=;
	b=L1bguwEoiRj1RMrmQPzaHjTe5RYKQ+wEgm1CPbDKGEB2GcYNJfq7IeIdKKTX2h6YIzy5jH
	HKAJ5970GiZ2lXOzE04xHknqgr90aCHCMtMSitzHbQTu66KivwQge3kJBgdaiXnSh7T5Cb
	jqckV3XgbuCJa0IPIL58dWz7oCpITgk=
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
Message-ID: <20231212164130.ggezxdqq6gkq3smr@moria.home.lan>
References: <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <20231212154302.uudmkumgjaz5jouw@moria.home.lan>
 <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>
 <20231212160829.vybfdajncvugweiy@moria.home.lan>
 <CAJfpegvNVXoxn3gW9-38YfY5u0FLjXTCDxcv5OtS-p0=0ocQvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvNVXoxn3gW9-38YfY5u0FLjXTCDxcv5OtS-p0=0ocQvg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 05:30:23PM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 17:08, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > In short, STATX_ATTR_INUM_NOT_UNIQUE is required to tell userspace when
> > they _must_ do the new thing if they care about correctness; it provides
> > a way to tell userspace what guarantees we're able to provide.
> 
> That flag would not help with improving userspace software.

I disagree. Just having it there and in the documentation will be a good
solid nudge to userspace programmers that this is something they need to
consider.

And: if we size this thing for NFSv4 filehandles, those are big: there's
an overhead associated with using those, since userspace generally has
to track in memory all inode numbers/file handles that it's seen.
STATX_ATTR_INUM_NOT_UNIQUE would allow userspace to avoid that overhead
when it is safe to do so.

(But remember that file handles include inode generation numbers, and
inode numbers do not; that is something we should remember to document,
and explain why it is important).

> What would help, if said software started using a unique identifier.
> We already seem to have a unique ID in the form of file handles,
> though some exotic filesystems might allow more than one fh to refer
> to the same inode, so this still needs some looking into.
> 
> The big problem is that we can't do a lot about existing software, and
> must keep trying to keep st_ino unique for the foreseeable future.

Whatever hacks we try to apply to st_ino are outside the scope of this
discussion. Right now, we need to be figuring out what our future
proofed interface is going to be, so that we don't end up kicking this
can down the road when st_ino will be _really_ space constrained.

