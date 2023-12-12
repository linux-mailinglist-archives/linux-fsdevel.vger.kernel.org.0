Return-Path: <linux-fsdevel+bounces-5689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260A80EDFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 14:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CDE1C20B4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43026F631;
	Tue, 12 Dec 2023 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Soo6BjJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE506DCFB;
	Tue, 12 Dec 2023 13:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1178C433CD;
	Tue, 12 Dec 2023 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702388876;
	bh=KK6k7ktFdcMgvX1gs7P76rUn6O9ERk65npZY37aPADA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Soo6BjJw9sG9qzCxgmUA+QzURPApdg6AHB5j9LZxaFflQGJDsi5NtgRBLKtWsbplK
	 KuZ6my0SFlPVy2/hD0CBCRwWE3fQ5QhVvkuJXqm/8kzFfFaEdVUNKFWPD5bNWCi8cu
	 9ykSqBt8ncPXuUctx1Y3nuKA3TXuEWcz95gh6tdcEJvPvUGyOiuCbX83eirVttE4DI
	 daRXkF1P2P9/f7OL1oXCzBUvboHq1Yjc+jHojwOgJydcoDBGLSJYhBQcTe5IJzRiZl
	 T1pwoT/+CeXkpsffqK7v6VbbxLvrWe1qnub/rM91vF1lxWjdiqqs0cp1pRQyLT8vjX
	 +TYv5gapNQwww==
Date: Tue, 12 Dec 2023 14:47:51 +0100
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
Message-ID: <20231212-kahlschlag-abtropfen-51dc89b9ac11@brauner>
References: <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk>
 <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
 <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
 <20231212-sechzehn-hausgemacht-6eb61150554e@brauner>
 <CAJfpegshsEWtm-dcdUy2w9_ic0Ag7GXpA2yRWGR+LD2T37odGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegshsEWtm-dcdUy2w9_ic0Ag7GXpA2yRWGR+LD2T37odGQ@mail.gmail.com>

On Tue, Dec 12, 2023 at 10:42:58AM +0100, Miklos Szeredi wrote:
> On Tue, 12 Dec 2023 at 10:35, Christian Brauner <brauner@kernel.org> wrote:
> 
> > So taking a step back here, please. The original motivation for this
> > discussion was restricted to handle btrfs - and now bcachefs as well.
> > Both have a concept of a subvolume so it made sense to go that route.
> > IOW, it wasn't originally a generic problem or pitched as such.
> >
> > Would overlayfs be able to utilize an extended inode field as well?
> 
> Well, yes, but I don't think that's the right solution.

Exposing the subvolume id in statx() is still fine imho. It's a concept
shared between btrfs and bcachefs and it's pretty useful for interested
userspace that wants to make use of these apis.

> 
> I think the right solution is to move to using file handles instead of
> st_ino, the problem with that is that there's no way kernel can force
> upgrading userspace.

That's not our job tbh. I get why this is desirable. What we can do is
advertise better and newer apis but we don't have to make unpleasant
compromises in our interfaces for that.

> 
> It might help to have the fh in statx, since that's easier on the
> userspace programmer than having to deal with two interfaces (i_ino
> won't go away for some time, because of backward compatibility).
> OTOH I also don't like the way it would need to be shoehorned into
> statx.

No, it really doesn't belong into statx().

And besides, the file handle apis name_to_handle_at() are already
in wider use than a lot of people think. Not just for the exportfs case
but also for example, cgroupfs uses file handles to provide unique
identifiers for cgroups that can be compared.

