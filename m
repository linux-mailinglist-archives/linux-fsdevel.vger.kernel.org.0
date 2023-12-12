Return-Path: <linux-fsdevel+bounces-5633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCD680E77A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17E81C2170B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B33584ED;
	Tue, 12 Dec 2023 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeEzQm+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15258137;
	Tue, 12 Dec 2023 09:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1E4C433C7;
	Tue, 12 Dec 2023 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702372994;
	bh=aAXAxAcTtlLab9cSppqL8EVujGnM4915M6pkaIFGQlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeEzQm+LyLHDO2sysJlUxfDpriq52GJpgd+KhiyTbuIZXNq98kYNzDfz7tbbKkN9L
	 KBn5JxhMgZ4lctjXUW8Ase/iAID3azVOqTjlJqiVj6lKpSs9/RLBiMMhUOnsJ2SbVy
	 PpbVxrVsIzDLDzMIxUDtK//3dOx8CQvHgMHytm+jG82JVJvjHJ86IEQ1lQU07soIZs
	 utlHeRQDim88+DiLua/Ttgqod9bJFRJeTEEBYwAhk0xpAe01IY0AO1ycJ0HQ3Kb7cD
	 IFtpxq/X6cOutb+FA2lqYu6gsaq5R1J5Lc7Z7Md68wWHYI9C3WblvnxPZiZu28qoTH
	 1krb1E8EgQjXg==
Date: Tue, 12 Dec 2023 10:23:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
	NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
References: <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2810685.1702372247@warthog.procyon.org.uk>

On Tue, Dec 12, 2023 at 09:10:47AM +0000, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > > > > I suggest:
> > > > >
> > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > >                               same inode number
> > 
> > This is just ugly with questionable value. A constant reminder of how
> > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> 
> There is a upcoming potential problem where even the 64-bit field I placed in
> statx() may be insufficient.  The Auristor AFS server, for example, has a
> 96-bit vnode ID, but I can't properly represent this in stx_ino.  Currently, I

Is that vnode ID akin to a volume? Because if so you could just
piggy-back on a subvolume id field in statx() and expose it there.

> just truncate the value to fit and hope that the discarded part will be all
> zero, but that's not really a good thing to do - especially when stx_ino is
> used programmatically to check for hardlinks.
> 
> Would it be better to add an 'stx_ino_2' field and corresponding flag?

Would this be meaningfully different from using a file handle?

