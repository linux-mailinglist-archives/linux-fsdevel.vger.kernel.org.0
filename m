Return-Path: <linux-fsdevel+bounces-67119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084DFC35947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A35624A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90923148BF;
	Wed,  5 Nov 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS9wsXtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAC147C9B;
	Wed,  5 Nov 2025 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344950; cv=none; b=eL6M9qbiYBoPt/rQLfyFpY7ENHNgPA/8h3YOcBqlF8gjbzVEllj+a4JgVwhRPHjj24vd8F8ER9vRLkubxBHKUxTuZsgGmvOR7E+DSaxaCXW4g+V+SDd7kgJdiHOrF18jhZDaSdZ3A7fTPletI0o+S16jy/TMTt23AT5xUVmbIks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344950; c=relaxed/simple;
	bh=j6nt+b2fOshIZ+T+ki5rUhiMWr57o6/QciYlKMH8SN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy9akNY38Nueh7dHg4jggNb3473MZUtvkJfetfei3rQuZKqP1BKdZG61ltZE3PUF2yka2Go9pFlKIaJKe5K3J27ASn5JqhRPq6PPVp2J5ryHxdNfPI9tXiLOdLbVXtzRZGoew/YuZvMC/ROdwEjHV2IOPULvzt9pXmls3hOLV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS9wsXtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE995C4CEF8;
	Wed,  5 Nov 2025 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762344949;
	bh=j6nt+b2fOshIZ+T+ki5rUhiMWr57o6/QciYlKMH8SN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NS9wsXtXeg83J4YkDH8mQGdfGeGp3fYVvsVuRb2YFXCr9gg7zr2E8d5qLGHlzD0T9
	 g0joBJEt/8wJYQwe1mmYw+Q404f9DdrfC55hzAoMVswnD7yGxZG/6kxn5HLFPcQkaD
	 i0MkivAt2W1JCI7Pcf+hAGPttUlQ/azzKoFM9cyU6lVCro2L0in3QA2i40f7qu51Py
	 84549oeilWi63mHbfBDkbClenojZhj7uLqIA6Mw933WfrbPuYWHB93sBAQS66SB7ea
	 KfY8pXUuvVsObS2yZgrAtlj952qoNi+ocfRIDcqtj+fk9DUiRMH7XiYaZmIVV5Zm1k
	 bqjk/PMisUGEg==
Date: Wed, 5 Nov 2025 13:15:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 10/17] vfs: make vfs_create break delegations on
 parent directory
Message-ID: <20251105-lamawolle-strom-bcd659e0b66a@brauner>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
 <20251103-dir-deleg-ro-v4-10-961b67adee89@kernel.org>
 <176221525113.1793333.253208063990645256@noble.neil.brown.name>
 <6021e64ed25c3b3e7880f17accb0f7a7b89fac0e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6021e64ed25c3b3e7880f17accb0f7a7b89fac0e.camel@kernel.org>

On Mon, Nov 03, 2025 at 07:30:57PM -0500, Jeff Layton wrote:
> On Tue, 2025-11-04 at 11:14 +1100, NeilBrown wrote:
> > On Mon, 03 Nov 2025, Jeff Layton wrote:
> > > In order to add directory delegation support, we need to break
> > > delegations on the parent whenever there is going to be a change in the
> > > directory.
> > > 
> > > Add a delegated_inode parameter to struct createdata. Most callers just
> > > leave that as a NULL pointer, but do_mknodat() is changed to wait for a
> > > delegation break if there is one.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/namei.c         | 26 +++++++++++++++++---------
> > >  include/linux/fs.h |  2 +-
> > >  2 files changed, 18 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index fdf4e78cd041de8c564b7d1d89a46ba2aaf79d53..e8973000a312fb05ebb63a0d9bd83b9a5f8f805d 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3487,6 +3487,9 @@ int vfs_create(struct createdata *args)
> > >  
> > >  	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> > >  	error = security_inode_create(dir, dentry, mode);
> > > +	if (error)
> > > +		return error;
> > > +	error = try_break_deleg(dir, args->delegated_inode);
> > >  	if (error)
> > >  		return error;
> > >  	error = dir->i_op->create(idmap, dir, dentry, mode, args->excl);
> > > @@ -4359,6 +4362,8 @@ static int may_mknod(umode_t mode)
> > >  static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > >  		unsigned int dev)
> > >  {
> > > +	struct delegated_inode delegated_inode = { };
> > > +	struct createdata cargs = { };
> > 
> > If we must have 'createdata', can it have a 'struct delegated_inode'
> > rather than a pointer to it?
> > 
> 
> If we do that, then we'd need some way to signal that the caller
> doesn't want to wait on the delegation break. Currently that's
> indicated by setting cargs.delegated_inode to NULL. I suppose we could
> add a bool for this or something.
> 
> I confess that I too am lukewarm on struct createdata. I can live with
> it, but it's not clearly a win to me either.
> 
> Christian, thoughts?

If two stable voices of the community seem to have consensus that this
isn't worth it then it's obviously fine to not do it.

> 
> > 
> > >  	struct mnt_idmap *idmap;
> > >  	struct dentry *dentry;
> > >  	struct path path;
> > > @@ -4383,18 +4388,16 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > >  	switch (mode & S_IFMT) {
> > >  		case 0:
> > >  		case S_IFREG:
> > > -		{
> > > -			struct createdata args = { .idmap = idmap,
> > > -						   .dir = path.dentry->d_inode,
> > > -						   .dentry = dentry,
> > > -						   .mode = mode,
> > > -						   .excl = true };
> > > -
> > > -			error = vfs_create(&args);
> > > +			cargs.idmap = idmap,
> > > +			cargs.dir = path.dentry->d_inode,
> > > +			cargs.dentry = dentry,
> > > +			cargs.delegated_inode = &delegated_inode;
> > > +			cargs.mode = mode,
> > > +			cargs.excl = true,
> > > +			error = vfs_create(&cargs);
> > >  			if (!error)
> > >  				security_path_post_mknod(idmap, dentry);
> > >  			break;
> > > -		}
> > >  		case S_IFCHR: case S_IFBLK:
> > >  			error = vfs_mknod(idmap, path.dentry->d_inode,
> > >  					  dentry, mode, new_decode_dev(dev));
> > > @@ -4406,6 +4409,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > >  	}
> > >  out2:
> > >  	end_creating_path(&path, dentry);
> > > +	if (is_delegated(&delegated_inode)) {
> > > +		error = break_deleg_wait(&delegated_inode);
> > > +		if (!error)
> > > +			goto retry;
> > > +	}
> > >  	if (retry_estale(error, lookup_flags)) {
> > >  		lookup_flags |= LOOKUP_REVAL;
> > >  		goto retry;
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index b61873767b37591aecadd147623d7dfc866bef82..cfcb20a7c4ce4b6dcec98b3eccbdb5ec8bab6fa9 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2116,12 +2116,12 @@ struct createdata {
> > >  	struct mnt_idmap *idmap;	// idmap of the mount the inode was found from
> > >  	struct inode *dir;		// inode of parent directory
> > >  	struct dentry *dentry;		// dentry of the child file
> > > +	struct delegated_inode *delegated_inode; // returns parent inode, if delegated
> > >  	umode_t mode;			// mode of the child file
> > >  	bool excl;			// whether the file must not yet exist
> > >  };
> > >  
> > >  int vfs_create(struct createdata *);
> > > -
> > >  struct dentry *vfs_mkdir(struct mnt_idmap *, struct inode *,
> > >  			 struct dentry *, umode_t, struct delegated_inode *);
> > >  int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
> > > 
> > > -- 
> > > 2.51.1
> > > 
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

