Return-Path: <linux-fsdevel+bounces-5629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE280E713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693062821F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89C5812B;
	Tue, 12 Dec 2023 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm7jXJWr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9122338;
	Tue, 12 Dec 2023 09:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB45C433C7;
	Tue, 12 Dec 2023 09:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702372114;
	bh=M60dkv6D7KJActsFVbT0uZgMRt1gTMDaE/YXf/4ZBMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vm7jXJWrOb8EL46XN1SPJEuFpcMGYJrTqMdYgW5HJ6lQH4DTurEWP/unAZ7rt8mV1
	 KEvgDBwv0G+vmSznGDqEDzcy65RriuTG4697adli0Q0MeXjxrVo4s/82VNtk2BLxXc
	 1OK0jzv/RemWs0agx7wW7gu/LM52i1sUXrs0eUfirgJ/x/EQQsCxmSn704vUWzmg8G
	 8qyvpM5ezYcpZwn9YCCJwr9vE2kOsw+D+16x/Qs1kFaIGJCg/lf1x3biTcmc+kYS3n
	 2zlJGfVrx1OYaMtf6UfuRcozqk3cd7YYvsoC63APCzoODgNx/n25Ll1J3NHUSsClhv
	 9yhp+hEkFCTUw==
Date: Tue, 12 Dec 2023 10:08:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-hinfahren-unvorbereitet-193db16c5b00@brauner>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <20231212011038.i5cinr5ok7gkotlm@moria.home.lan>
 <170234718752.12910.7741039469009828768@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170234718752.12910.7741039469009828768@noble.neil.brown.name>

On Tue, Dec 12, 2023 at 01:13:07PM +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> > > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > > NFSv4 specs that for the maximum size? That is pretty hefty...
> > > 
> > > It is - but it needs room to identify the filesystem and it needs to be
> > > stable across time.  That need is more than a local filesystem needs.
> > > 
> > > NFSv2 allowed 32 bytes which is enough for a 16 byte filesys uuid, 8
> > > byte inum and 8byte generation num.  But only just.
> > > 
> > > NFSv3 allowed 64 bytes which was likely plenty for (nearly?) every
> > > situation.
> > > 
> > > NFSv4 doubled it again because .... who knows.  "why not" I guess.
> > > Linux nfsd typically uses 20 or 28 bytes plus whatever the filesystem
> > > wants. (28 when the export point is not the root of the filesystem).
> > > I suspect this always fits within an NFSv3 handle except when
> > > re-exporting an NFS filesystem.  NFS re-export is an interesting case...
> > 
> > Now I'm really curious - i_generation wasn't enough? Are we including
> > filesystem UUIDs?
> 
> i_generation was invented so that it could be inserted into the NFS
> fileshandle.
> 
> The NFS filehandle is opaque.  It likely contains an inode number, a
> generation number, and a filesystem identifier.  But it is not possible
> to extract those from the handle.
> 
> > 
> > I suppose if we want to be able to round trip this stuff we do need to
> > allocate space for it, even if a local filesystem would never include
> > it.
> > 
> > > I suggest:
> > > 
> > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > >                               same inode number
> > > 
> > >  
> > >  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and 
> > >                    stx_ino MUST be the same.  Exact meaning of volumes
> > >                    is filesys-specific
> > 
> > NFS reexport that you mentioned previously makes it seem like this
> > guarantee is impossible to provide in general (so I'd leave it out
> > entirely, it's just something for people to trip over).
> 
> NFS would not set stx_vol and would not return STATX_VOL in stx_mask.
> So it would not attempt to provide that guarantee.
> 
> Maybe we don't need to explicitly make this guarantee.
> 
> > 
> > But we definitely want stx_vol in there. Another thing that people ask
> > for is a way to ask "is this a subvolume root?" - we should make sure
> > that's clearly specified, or can we just include a bit for it?
> 
> The start way to test for a filesystem root - or mount point at least -
> is to stat the directory in question and its parent (..) and see if the
> have the same st_dev or not.

It depends. If you want to figure out whether it's a different
filesystem or a different btrfs subvolume then yes, this generally
works because of changing device ids. But it doesn't work for
bind-mounts as they don't change device numbers. But maybe you and I are
using mount point differently here.

> Applying the same logic to volumes means that a single stx_vol number is
> sufficient.

Yes, that would generally work.

> 
> I'm not strongly against a STATX_ATTR_VOL_ROOT flag providing everyone
> agrees what it means that we cannot imagine any awkward corner-cases
> (like a 'root' being different from a 'mount point').

I feel like you might have missed my previous mails where I strongly
argued for the addition of STATX_ATTR_SUBVOLUME_ROOT:

https://lore.kernel.org/linux-btrfs/20231108-herleiten-bezwangen-ffb2821f539e@brauner

The concept of a subvolume root and of a mount point should be kept
separate. Christoph tried mapping subvolumes to vfsmounts, something
that I (and Al) vehemently oppose for various reasons outlined in that
and other long threads.

I still think that we should start with exposing subvolume id first.

