Return-Path: <linux-fsdevel+bounces-5637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FE80E7D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7947A1F218F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AC58AA5;
	Tue, 12 Dec 2023 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qgs1TUF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CC584E8;
	Tue, 12 Dec 2023 09:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F6CC433C7;
	Tue, 12 Dec 2023 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702373745;
	bh=hKg6F+NFhadBrAoITIopgTDA3PxgK6ebSyII9ovDeec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qgs1TUF5Rb+0fPctb+WpetR3oR3/RDbo5bgDfq+A2pvMb4aoHWjwfua/2TL1lHNfd
	 7k5/54mFyNF8DrQCWiTC3AKm5jkWbOQS3KguLX46iBZXrupYa8LXeHPiNovnQ8L+lX
	 /LLGpPggieCrM8eUo5DC7Q4aeMiFHGy3hNL+VC8ALiLQkZy34oUBMgAFRTPM4pRjZU
	 vqutLx1J+LbJqNioiBgdSEegKrLkVT7uAbwpzGxKBMeHeCDZMxKh+Csxy4Fea+hSfi
	 /HuALobgqoatClbxWDH8sXGr+SRIO2iznscJ7nB+HbqfLd81N12nvOqTw+sqZ3/qWf
	 udMPrNMqylxTg==
Date: Tue, 12 Dec 2023 10:35:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
References: <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk>
 <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>

On Tue, Dec 12, 2023 at 10:28:12AM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Dec 12, 2023 at 09:10:47AM +0000, David Howells wrote:
> > > Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > > > > > I suggest:
> > > > > > >
> > > > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > > > >                               same inode number
> > > >
> > > > This is just ugly with questionable value. A constant reminder of how
> > > > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> > >
> > > There is a upcoming potential problem where even the 64-bit field I placed in
> > > statx() may be insufficient.  The Auristor AFS server, for example, has a
> > > 96-bit vnode ID, but I can't properly represent this in stx_ino.  Currently, I
> >
> > Is that vnode ID akin to a volume? Because if so you could just
> > piggy-back on a subvolume id field in statx() and expose it there.
> 
> And how would exporting a subvolume ID and expecting userspace to take
> that into account when checking for hard links be meaningfully
> different than expecting userspace to retrieve the file handle and
> compare that?
> 
> The latter would at least be a generic solution, including stacking fs
> inodes, instead of tackling just a specific corner of the problem
> space.

So taking a step back here, please. The original motivation for this
discussion was restricted to handle btrfs - and now bcachefs as well.
Both have a concept of a subvolume so it made sense to go that route.
IOW, it wasn't originally a generic problem or pitched as such.

Would overlayfs be able to utilize an extended inode field as well?

