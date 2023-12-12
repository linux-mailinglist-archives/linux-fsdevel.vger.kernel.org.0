Return-Path: <linux-fsdevel+bounces-5611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4080E161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 03:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7FEB208A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9898D2104;
	Tue, 12 Dec 2023 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XyokbTuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D9B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 18:24:10 -0800 (PST)
Date: Mon, 11 Dec 2023 21:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702347848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7OSQRwAzL7O94noo492qne0oE+wflNbxwpq2uNxdWPU=;
	b=XyokbTuW6Fy8iz6M/wPOYvzNaspQ8RfgHTNzh/tP2DXWSD+p+ExBwB8XrJaHKAdw8hE1X4
	Fv9h//KuYm0lclpjEr0mntmMKE8gjF8xC1fF41sUR70gw/aE4vtl8DNEEPU4tFQyp7RZP4
	RZM7nPa6G301lRgXVZiEachiG0QgG58=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212022405.mliaoyg7j6dnijta@moria.home.lan>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170234718752.12910.7741039469009828768@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 01:13:07PM +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Kent Overstreet wrote:
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

I tend to lean towards pushing people to only use the filehandle for
testing if files are the same, and discouraging using stx_vol for this
purpose.

Since the filehandle will include the generation number, it lets us fix
permenantly time of use races that stx_vol would still be subject to.

> > But we definitely want stx_vol in there. Another thing that people ask
> > for is a way to ask "is this a subvolume root?" - we should make sure
> > that's clearly specified, or can we just include a bit for it?
> 
> The start way to test for a filesystem root - or mount point at least -
> is to stat the directory in question and its parent (..) and see if the
> have the same st_dev or not.
> Applying the same logic to volumes means that a single stx_vol number is
> sufficient.
> 
> I'm not strongly against a STATX_ATTR_VOL_ROOT flag providing everyone
> agrees what it means that we cannot imagine any awkward corner-cases
> (like a 'root' being different from a 'mount point').

I'd like to do that, it lets us define properly some corner cases (is
the filesystem also a subvolume root if it's got the same volume ID as
the parent dir, on another filesystem? Let's make sure that's a yes).

