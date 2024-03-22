Return-Path: <linux-fsdevel+bounces-15085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38227886E41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E61C21505
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E170F47A70;
	Fri, 22 Mar 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeMF9jho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E047F41;
	Fri, 22 Mar 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116841; cv=none; b=mkcXTODEShvPT4ClQohkuYPXBpLLXPBDfH2gRJd2j7662xBuXEmxDTvIJ8Tnt/CUlYVDloTVU+tAvpCFDt3EY7HPCUldXCx87xdW5bPaf+FuUZlDZT6rDOlaIvTi+PNSh/7lJPlt0r7jy5o7wICr41ERaE6fqhg3YF+fgtfRHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116841; c=relaxed/simple;
	bh=SUDjNJPFhmAni//UFuk6ejixrIl+KvydT+avjE5yPXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmj5QM0oobGNMbW2DzC8hZGIdbAnGJm1Xg5Vbcbw/ONa3f+rKjcjJlWeo4n9PiGNSKBJ1cxtsRWHMk3F6tdEs+yIYVWFBTDXPJmJuzK9svRcc83nCt7APF2SXmJQVmAxkU1fNuumHlRUkilHR3YCss1YH1YxISMiQJeflho1uJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeMF9jho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E46C433F1;
	Fri, 22 Mar 2024 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711116840;
	bh=SUDjNJPFhmAni//UFuk6ejixrIl+KvydT+avjE5yPXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeMF9jho3Zpr5om0OFiOLl9KpzEzOaTtk4rmviui6eKtaIeHS2GaiAnDBikdvN1dg
	 PuNe6dc6VvndWjiFZvMcdgJWvRG87lKektQkFeKPhqv0nMnD0uxG8mbiPWYKYWjkiK
	 l5M51M81gYo1MmhSljC6G3LoNk6P1qOqIpHWiiiEHzlSGPt2XCfH23vSkf35B5mjiC
	 hmBSi4SDc4noVEbhfSrQd7Jmp3qK5owiZEdDDQq9bECFdLebLhkdDP5XZaGgyjqC7K
	 DpAouu4DyEai6cbIaE/cPVjw2HMGrzV1cXMMCdzPhH5mNsS3jzG1p3YGat+F93bppe
	 u1MPy/83AH2ow==
Date: Fri, 22 Mar 2024 15:13:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 08/24] vfs: make vfs_mknod break delegations on
 parent directory
Message-ID: <20240322-laienhaft-lastwagen-63b3ef508466@brauner>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
 <20240315-dir-deleg-v1-8-a1d6209a3654@kernel.org>
 <20240320-jaguar-bildband-699e7ef5dc64@brauner>
 <ca81387b31025198808df6c55f411b00d74cb047.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca81387b31025198808df6c55f411b00d74cb047.camel@kernel.org>

On Wed, Mar 20, 2024 at 04:12:29PM -0400, Jeff Layton wrote:
> On Wed, 2024-03-20 at 14:42 +0100, Christian Brauner wrote:
> > >  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> > > -              umode_t, dev_t);
> > > +              umode_t, dev_t, struct inode **);
> > 
> > So we will have at least the following helpers with an additional
> > delegated inode argument.
> > 
> > vfs_unlink()
> > vfs_link()
> > notify_change()
> > vfs_create()
> > vfs_mknod()
> > vfs_mkdir()
> > vfs_rmdir()
> > 
> > From looking at callers all these helpers will be called with non-NULL
> > delegated inode argument in vfs only. Unless it is generally conceivable
> > that other callers will want to pass a non-NULL inode argument over time
> > it might make more sense to add vfs_<operation>_delegated() or
> > __vfs_<operation>() and make vfs_mknod() and friends exported wrappers
> > around it.
> > 
> > I mean it's a matter of preference ultimately but this seems cleaner to
> > me. So at least for the new ones we should consider it. Would also make
> > the patch smaller.
> > 
> 
> Good suggestion. I just respun along those lines and it's a lot cleaner.
> I'm still testing it but here is the new diffstat. It's a little larger
> actually, but it keeps the changes more confined to namei.c:

Sounds good to me!

