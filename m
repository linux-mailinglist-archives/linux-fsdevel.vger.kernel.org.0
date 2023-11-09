Return-Path: <linux-fsdevel+bounces-2660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD097E7450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283371C20A64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266538FA8;
	Thu,  9 Nov 2023 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WXL5BfFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628A38F92
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:23:00 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A141FF6;
	Thu,  9 Nov 2023 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=/1aAAOfZoPJB+SIcZK8uAuu2vTpGQEKR3GjqFdj1Lfs=; b=WXL5BfFZTfyzIdYpq/yJHYDjLS
	cNb3Gu55uygBewH4u7fSvpIgn+vEjUIXHjSGlYnS+4KDXXW1Z4DIBgI3ybRYD5G7vrYY7cuQBhWEo
	E5wXD1U2N8mO1hDl0WTRlbEENenNjHd07GB64kiQ9gsMAWF4AD060v5PfYwzGtKvVlbHkcOfNYnip
	UJsODITYXv7zR9lPdCzmqSJHomeCZ9G8t4T7hVtiCpLeI1vdMe/0+y4zkAdrS+30Ge8mTTUg7V3rc
	jMirK0Ug+n+t8D5h+/Bac4N6RcmgFOmFxYu8EPD12zK9e4Og9Sz5CmuPfE+JBxupbLduQSr9JSyml
	TiY7S0gg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1DQM-00DboO-2u;
	Thu, 09 Nov 2023 22:22:55 +0000
Date: Thu, 9 Nov 2023 22:22:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>, Abhi Das <adas@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
Message-ID: <20231109222254.GK1957730@ZenIV>
References: <20231109190844.2044940-1-agruenba@redhat.com>
 <20231109220018.GI1957730@ZenIV>
 <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 11:12:32PM +0100, Andreas Grünbacher wrote:
> Am Do., 9. Nov. 2023 um 23:00 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> > On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > > Jens,
> > >
> > > since your commit 99668f618062, applications can request cached lookups
> > > with the RESOLVE_CACHED openat2() flag.  When adding support for that in
> > > gfs2, we found that this causes the ->permission inode operation to be
> > > called with the MAY_NOT_BLOCK flag set for directories along the path,
> > > which is good, but the ->permission check on the final path component is
> > > missing that flag.  The filesystem will then sleep when it needs to read
> > > in the ACL, for example.
> > >
> > > This doesn't look like the intended RESOLVE_CACHED behavior.
> > >
> > > The file permission checks in path_openat() happen as follows:
> > >
> > > (1) link_path_walk() -> may_lookup() -> inode_permission() is called for
> > > each but the final path component. If the LOOKUP_RCU nameidata flag is
> > > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > > inode_permission(), which passes it on to the permission inode
> > > operation.
> > >
> > > (2) do_open() -> may_open() -> inode_permission() is called for the
> > > final path component. The MAY_* flags passed to inode_permission() are
> > > computed by build_open_flags(), outside of do_open(), and passed down
> > > from there. The MAY_NOT_BLOCK flag doesn't get set.
> > >
> > > I think we can fix this in build_open_flags(), by setting the
> > > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
> >
> > No.  This will expose ->permission() instances to previously impossible
> > cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> > in that area.
> 
> True, lockdep wouldn't be happy.
> 
> >  See RCU pathwalk patches I posted last cycle;
> 
> Do you have a pointer? Thanks.

Thread starting with Message-ID: <20231002022815.GQ800259@ZenIV>
I don't remember if I posted the audit notes into it; I'll get around
to resurrecting that stuff this weekend, when the mainline settles down
enough to bother with that.

