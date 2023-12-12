Return-Path: <linux-fsdevel+bounces-5627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DDC80E6F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23A71F21E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858315811B;
	Tue, 12 Dec 2023 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5kljM8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E157326;
	Tue, 12 Dec 2023 08:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AAC433C7;
	Tue, 12 Dec 2023 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702371411;
	bh=5AkVBCECufFwkffK6AuHp+5xxGA0eH2FRdwjfkHNztA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5kljM8Ygbj/z8RU2BzYklrpYWqiWBLRjJ2MWqLp+s2zjIk27W2xUGgqOfdVrrqjc
	 kMPq9aUirjFNiXcF6l11yD1uHKd4DpR/sMAiSSx2kj9sPqP+MobVaTU/vTjY9sj7lM
	 6IE6GwFszY34NGed86stnSqoYaLbFl06h2xNMm6rU5kucBlb8nA9cc8Bf9U+SrxRpT
	 nc3bO4Rqa0UVBuPtNtPxC2MYa3bQo8P+TUSi0yKbbffkweewwOb/C6D/7o0AtQjIsj
	 NccFlVwIF/aPtWOIPmJYrwXL2wK1cTZ3IsD4FzL6Yez4RsiWsg4RHVe8rB7GtJGpTY
	 i2cM419h/BX5Q==
Date: Tue, 12 Dec 2023 09:56:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-impfung-linden-6f973f2ade19@brauner>
References: <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>

On Tue, Dec 12, 2023 at 08:32:55AM +0200, Amir Goldstein wrote:
> On Tue, Dec 12, 2023 at 7:53 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> > > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > > On Tue, Dec 12, 2023 at 10:53:07AM +1100, NeilBrown wrote:
> > > > > On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > > > > > On Tue, Dec 12, 2023 at 09:43:27AM +1100, NeilBrown wrote:
> > > > > > > On Sat, 09 Dec 2023, Kent Overstreet wrote:
> > > > > > Thoughts?
> > > > > >
> > > > >
> > > > > I'm completely in favour of exporting the (full) filehandle through
> > > > > statx. (If the application asked for the filehandle, it will expect a
> > > > > larger structure to be returned.  We don't need to use the currently
> > > > > reserved space).
> > > > >
> > > > > I'm completely in favour of updating user-space tools to use the
> > > > > filehandle to check if two handles are for the same file.
> > > > >
> > > > > I'm not in favour of any filesystem depending on this for correct
> > > > > functionality today.  As long as the filesystem isn't so large that
> > > > > inum+volnum simply cannot fit in 64 bits, we should make a reasonable
> > > > > effort to present them both in 64 bits.  Depending on the filehandle is a
> > > > > good plan for long term growth, not for basic functionality today.
> > > >
> > > > My standing policy in these situations is that I'll do the stopgap/hacky
> > > > measure... but not before doing actual, real work on the longterm
> > > > solution :)
> > >
> > > Eminently sensible.
> > >
> > > >
> > > > So if we're all in favor of statx as the real long term solution, how
> > > > about we see how far we get with that?
> > > >
> > >
> > > I suggest:
> > >
> > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > >                               same inode number

This is just ugly with questionable value. A constant reminder of how
broken this is. Exposing the subvolume id also makes this somewhat redundant.

> > >
> > >
> > >  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and
> > >                    stx_ino MUST be the same.  Exact meaning of volumes
> > >                    is filesys-specific

Exposing this makes sense. I've mentioned that I'd be open to exporting
the subvolume id in statx before even though I know some people don't
like that. I still stand by that. Especially now that we have btrfs and
bcachefs that both have the concept of a subvolume id it makes sense to
put it into statx().

> > >
> > >  STATX_VOL         Want stx_vol
> > >
> > >   __u8 stx_handle_len  Length of stx_handle if present
> > >   __u8 stx_handle[128] Unique stable identifier for this file.  Will
> > >                        NEVER be reused for a different file.
> > >                        This appears AFTER __statx_pad2, beyond
> > >                        the current 'struct statx'.
> > >  STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
> > >                    receiving statx info has at least
> > >                    sizeof(struct statx)+128 bytes.

No, we're should not be reinventing another opaque handle. And even if
it really doesn't belong into statx().

> >
> > Hmmm.
> >
> > Doesn't anyone else see or hear the elephant trumpeting loudly in
> > the middle of the room?
> >
> > I mean, we already have name_to_handle_at() for userspace to get a
> > unique, opaque, filesystem defined file handle for any given file.

I agree.

> > It's the same filehandle that filesystems hand to the nfsd so nfs
> > clients can uniquely identify the file they are asking the nfsd to
> > operate on.
> >
> > The contents of these filehandles is entirely defined by the file
> > system and completely opaque to the user. The only thing that
> > parses the internal contents of the handle is the filesystem itself.
> > Therefore, as long as the fs encodes the information it needs into the
> > handle to determine what subvol/snapshot the inode belongs to when
> > the handle is passed back to it (e.g. from open_by_handle_at()) then
> > nothing else needs to care how it is encoded.
> >
> > So can someone please explain to me why we need to try to re-invent
> > a generic filehandle concept in statx when we already have a
> > have working and widely supported user API that provides exactly
> > this functionality?
> 
> Yeh.
> 
> Not to mention that since commit 64343119d7b8 ("exportfs: support encoding
> non-decodeable file handles by default"), exporting file handles as strong
> object identifiers is not limited to filesystems that support NFS export.
> 
> All fs have a default implementation of encode_fh() by encoding a file id
> of type FILEID_INO64_GEN from { i_ino, i_generation } and any fs can
> define its own encode_fh() operation (e.g. to include subvol id) even without
> implementing the decode fh operations needed for NFS export.

I also would like both btrfs and bcachefs to agree.

