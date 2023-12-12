Return-Path: <linux-fsdevel+bounces-5603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCA80E0BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5737CB215DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C766381A;
	Tue, 12 Dec 2023 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E1A/D2kl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF90C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 17:10:45 -0800 (PST)
Date: Mon, 11 Dec 2023 20:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702343442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uCmzAPr9FjBUdx8UYMDyo1yWi9l38cZDY5iPqozgHRs=;
	b=E1A/D2kljetGe803sPAAR5ifgX8fM2f5k8Zi3S66RHvBz5qXxOCuMTRZvgN78btPmqJK0C
	z6wzpb9uX7GOKdx++MCwvYTgA42kBeNbDS2qob9yA+5UHX4CBDD1teDoSMt2R5iv3eOhMl
	L4AZgOC6TcrmH0itDDITUcFAwN+RDyI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212011038.i5cinr5ok7gkotlm@moria.home.lan>
References: <20231208013739.frhvlisxut6hexnd@moria.home.lan>
 <170200162890.12910.9667703050904306180@noble.neil.brown.name>
 <20231208024919.yjmyasgc76gxjnda@moria.home.lan>
 <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170234279139.12910.809452786055101337@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 12, 2023 at 11:59:51AM +1100, NeilBrown wrote:
> On Tue, 12 Dec 2023, Kent Overstreet wrote:
> > NFSv4 specs that for the maximum size? That is pretty hefty...
> 
> It is - but it needs room to identify the filesystem and it needs to be
> stable across time.  That need is more than a local filesystem needs.
> 
> NFSv2 allowed 32 bytes which is enough for a 16 byte filesys uuid, 8
> byte inum and 8byte generation num.  But only just.
> 
> NFSv3 allowed 64 bytes which was likely plenty for (nearly?) every
> situation.
> 
> NFSv4 doubled it again because .... who knows.  "why not" I guess.
> Linux nfsd typically uses 20 or 28 bytes plus whatever the filesystem
> wants. (28 when the export point is not the root of the filesystem).
> I suspect this always fits within an NFSv3 handle except when
> re-exporting an NFS filesystem.  NFS re-export is an interesting case...

Now I'm really curious - i_generation wasn't enough? Are we including
filesystem UUIDs?

I suppose if we want to be able to round trip this stuff we do need to
allocate space for it, even if a local filesystem would never include
it.

> I suggest:
> 
>  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
>                               same inode number
> 
>  
>  __u64 stx_vol     Volume identifier.  Two files with same stx_vol and 
>                    stx_ino MUST be the same.  Exact meaning of volumes
>                    is filesys-specific

NFS reexport that you mentioned previously makes it seem like this
guarantee is impossible to provide in general (so I'd leave it out
entirely, it's just something for people to trip over).

But we definitely want stx_vol in there. Another thing that people ask
for is a way to ask "is this a subvolume root?" - we should make sure
that's clearly specified, or can we just include a bit for it?

>  STATX_VOL         Want stx_vol
> 
>   __u8 stx_handle_len  Length of stx_handle if present
>   __u8 stx_handle[128] Unique stable identifier for this file.  Will
>                        NEVER be reused for a different file.
>                        This appears AFTER __statx_pad2, beyond
>                        the current 'struct statx'.
>  STATX_HANDLE      Want stx_handle_len and stx_handle. Buffer for
>                    receiving statx info has at least
>                    sizeof(struct statx)+128 bytes.
> 
> I think both the handle and the vol can be useful.
> NFS can provide stx_handle but not stx_vol.  It is the thing
> to use for equality testing, but it is only needed if
> STATX_ATTR_INUM_NOT_UNIQUE is set.
> stx_vol is useful for "du -x" or maybe "du --one-volume" or similar.
> 
> 
> Note that we *could* add stx_vol to NFSv4.2.  It is designed for
> incremental extension.  I suspect we wouldn't want to rush into this,
> but to wait to see if different volume-capable filesystems have other
> details of volumes that are common and can usefully be exported by statx

Sounds reasonable

