Return-Path: <linux-fsdevel+bounces-45871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F1A7DFED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D553B16AB86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E696156880;
	Mon,  7 Apr 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3bIMY11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83527081E;
	Mon,  7 Apr 2025 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033430; cv=none; b=S+b5NtG+mq2RjlA7G2yCsgthDDDbrKr8qxTanR8LUWTfyrK7CR8hBAQ4MAS8bLqYsAppCnwXcFJ32WwLL44v1yNRI7CDdj1N7azk/lUmPYtbUYvyIFBgccmK+KiCipuOzgIk20RHPt5wpNG/iKHMJ6zzAbRTximGAqOcDZClKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033430; c=relaxed/simple;
	bh=40iQustOgDQ8Q/5j6LkdNDPMCav7k37yCtdH2wEQiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab+OabeutG+/ggkmzvaSxyG8opHWmp8AYGCrfD0QcxUPyEgfPXvcWW0FuxGF6mnL/CRvzoDTaLaZT6shk2NXeGeSIJm3bug2gk4evFElSkZcrApiPNm7FyzZh1Pz0Pcx5pGcZM5SqPvicjwullds7nrEDuHQWCz3hkqreSlv65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3bIMY11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A04C4CEDD;
	Mon,  7 Apr 2025 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744033429;
	bh=40iQustOgDQ8Q/5j6LkdNDPMCav7k37yCtdH2wEQiyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3bIMY11C7Na4RP29p8eQKl5h29DEcGjJvAzstWR85wIEgl6x7r8EYXvBJ1PORU1G
	 g9TpM0zc3ytD+OGQ1AU5iJ5/rfN9RgynuYLStekM70RMV62yGJhxwEAhia0Nczyv7G
	 4+wXr9mayxZuiggICDtEfa5fdgwez+p4HRrtNg5l1st4wQawQToH8CxYN0vwU5z2Mo
	 jdBBDnIEpWoRK93iIr8yX43OkTkpZv7DIk538iMTIQfhzyZo8W0BYRMDxvGCykZfs5
	 sYV1iVV2AfkbC9UVyPVjEsLoMj9plteTUymR/mgsVQnSGv7HQIs0yx3X++3X5Nxf1P
	 n2myo7loFMzMw==
Date: Mon, 7 Apr 2025 15:43:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <20250407-vergolden-banknoten-2be28a3f1022@brauner>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
 <dfa046b304aa0c66dde37da5ed9cf31759cb6f18.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfa046b304aa0c66dde37da5ed9cf31759cb6f18.camel@kernel.org>

On Mon, Apr 07, 2025 at 08:19:25AM -0400, Jeff Layton wrote:
> On Mon, 2025-04-07 at 11:54 +0200, Christian Brauner wrote:
> > This allows the VFS to not trip over anonymous inodes and we can add
> > asserts based on the mode into the vfs. When we report it to userspace
> > we can simply hide the mode to avoid regressions. I've audited all
> > direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> > and i_op inode operations but it already uses a regular file.
> > 
> > Fixes: af153bb63a336 ("vfs: catch invalid modes in may_open()")
> > Cc: <stable@vger.kernel.org> # all LTS kernels
> > Reported-by: syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/67ed3fb3.050a0220.14623d.0009.GAE@google.com
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/anon_inodes.c | 36 ++++++++++++++++++++++++++++++++++++
> >  fs/internal.h    |  3 +++
> >  fs/libfs.c       |  2 +-
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index 583ac81669c2..42e4b9c34f89 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -24,9 +24,43 @@
> >  
> >  #include <linux/uaccess.h>
> >  
> > +#include "internal.h"
> > +
> >  static struct vfsmount *anon_inode_mnt __ro_after_init;
> >  static struct inode *anon_inode_inode __ro_after_init;
> >  
> > +/*
> > + * User space expects anonymous inodes to have no file type in st_mode.
> 
> Weird. Does anything actually depend on this?

Yeah, lsof failed and started complaining about this. They're checking
the mode to recognize anonymous inodes. And tbf, it works to generically
recognizer proper anonymous inodes because they came come from very
different superblocks (dmabuf, drm, vfio, anon_inode_mnt etc.).

> 
> ISTM that they should report a file type.

I agree but that ship has probably sailed.

