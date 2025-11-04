Return-Path: <linux-fsdevel+bounces-66975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75688C32643
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 18:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D884434B4A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 17:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3934D33A028;
	Tue,  4 Nov 2025 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD3Bcrqt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4D3385B5;
	Tue,  4 Nov 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277894; cv=none; b=Zl+kTSFI7qM20+N+zNX4mugulcBGRpWOsdZh3Owr/N52x6bjeYJpUEhAwu2CMUW2lmMqVvpjkJzKAP0L0pE+T+ldDyf1TD3k2pbvolj2gxi/onUpI4fV9l4hQdFXK4McoHJRMAB5LRHzlkaHZ+wu/I/oFXCdrBIt0f+idbgsR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277894; c=relaxed/simple;
	bh=2YkhSmbyR/ykbq3wvF4/ragaZLbIWVFj3cwVxNUZdOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wznt+7awMAPpVSSsgyQvO4eeS7QYUveMakPLbvcz0MgMTMmTDtOlIuRHwHVYN5S4C/tJBgdfGfNsYyMluf54ikrIbIEPgSjur/4fZvNZGE3Vz7kS1JooMxAJLCnl6pKJ8GYG6noSy8P39mYEjSa0lHgHdBUt2Nv/lixqtffbniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD3Bcrqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F483C4CEF7;
	Tue,  4 Nov 2025 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762277893;
	bh=2YkhSmbyR/ykbq3wvF4/ragaZLbIWVFj3cwVxNUZdOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD3BcrqtkZePKnxYHwmwZYrukhL924KK+XvIkgGVxtLZF3G8EhI0HztRHNkLk/RrZ
	 xZ3icwfEYP+6rywLt1s/PR6mPSxnyDflICEeZSxJBxj5TYePRraT3XHf0MFJQuRqkh
	 JxMr0DKypTdkQDdKbx83cWecgDQt8BKyVL11TM/532eR31nMoxm0uZgdx+t/WXyJK3
	 0hVRs8djr+qJgAUGI7SgH8Ni7jAFnlCY3oW2W0QPu15rvN90eQU1+Urrluh2iy5DA2
	 GnkHhgnocol6ztqH+u39zUu0PykXgUXPI7PIcjYad+ztfV9y8rO/x206FGCMBbLPrP
	 bjd9t8CVd1NFg==
Date: Tue, 4 Nov 2025 17:38:04 +0000
From: Simon Horman <horms@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 10/17] vfs: make vfs_create break delegations on
 parent directory
Message-ID: <aQo5_P5XCsSZhw7N@horms.kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
 <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>

On Mon, Nov 03, 2025 at 07:52:38AM -0500, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> Add a delegated_inode parameter to struct createdata. Most callers just
> leave that as a NULL pointer, but do_mknodat() is changed to wait for a
> delegation break if there is one.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/namei.c         | 26 +++++++++++++++++---------
>  include/linux/fs.h |  2 +-
>  2 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c

...

> @@ -4359,6 +4362,8 @@ static int may_mknod(umode_t mode)
>  static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  		unsigned int dev)
>  {
> +	struct delegated_inode delegated_inode = { };
> +	struct createdata cargs = { };
>  	struct mnt_idmap *idmap;
>  	struct dentry *dentry;
>  	struct path path;
> @@ -4383,18 +4388,16 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	switch (mode & S_IFMT) {
>  		case 0:
>  		case S_IFREG:
> -		{
> -			struct createdata args = { .idmap = idmap,
> -						   .dir = path.dentry->d_inode,
> -						   .dentry = dentry,
> -						   .mode = mode,
> -						   .excl = true };
> -
> -			error = vfs_create(&args);
> +			cargs.idmap = idmap,
> +			cargs.dir = path.dentry->d_inode,
> +			cargs.dentry = dentry,
> +			cargs.delegated_inode = &delegated_inode;
> +			cargs.mode = mode,
> +			cargs.excl = true,

Hi Jeff,

I don't think it makes any difference to the generated code.
But I think it would be more intuitive to use ';' rather than ','
at the end of the lines immediately above.

> +			error = vfs_create(&cargs);
>  			if (!error)
>  				security_path_post_mknod(idmap, dentry);
>  			break;
> -		}
>  		case S_IFCHR: case S_IFBLK:
>  			error = vfs_mknod(idmap, path.dentry->d_inode,
>  					  dentry, mode, new_decode_dev(dev));

...

