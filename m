Return-Path: <linux-fsdevel+bounces-68547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5AC5F740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9813BB969
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B935BDD7;
	Fri, 14 Nov 2025 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfwJU+ZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A230B50C;
	Fri, 14 Nov 2025 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157613; cv=none; b=Q7WpqbInVi+fH7ovhkmFRlH4yOy2knIj4xumWx4Lg3dmFsRuvvuDxINm0H2UtIKQt2oG+Gqp/KWfFOwQOCNUiEQ6Nc+ZKabLpi/t/9S6JRIkYakgKKrUmPPEMOOpugECL7tO3kDexPfWPocW3YMgFw7vaO7MYr7cfGYr9/uAnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157613; c=relaxed/simple;
	bh=j7RZqy16ewoXhRgrqJNjQ7/+/CoZMfyd+6JInM1le7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdfGRtKbBPiX3hE/9dTwCIcE9mIb+s0c11ExVY5mHeVxfaVwhQ27EOJJRSNOruwKv3GbNcg9z/VNIQOL0Byp9R4znSlXZuvFMYERhxCzf+eibeOTP86OIVtfCzmNO7DcbSAycgnEGE0qOsqQEOB17sJk0n75Udaez25QQFrdT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfwJU+ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D246DC4CEF8;
	Fri, 14 Nov 2025 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763157613;
	bh=j7RZqy16ewoXhRgrqJNjQ7/+/CoZMfyd+6JInM1le7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfwJU+ZUNjn6c5WRHTfTiKmw/cdc6ZbEieKQ8JC1UXhHEzhgMJa+pi7uOa9BYXOgy
	 1jq5bJrMPT9t+b1CwfZXQst6xQ497J/u/j9d2lHz3Aq0C+sg0bviuV3lbLYBhxVOFd
	 abwmBU/NlfhjmNQgVVgGJQ7hjV+P9jHuAP4y+qCDr0bqXBlPGUp1lOcgpBGMdvd7/d
	 zpD2mNXtOk5tMPZo2JZtOKV9ArhNES0aWPAlNwR2owUfIs7n2FjaaHUlN0r5iTB4oj
	 T4HGhidEIh9kSIO2vxnO/fTIUASB0Xuvskb4gfsHPVJEenytYvZCwtZS47sJosv2yE
	 GO05Ixa1HGn3g==
Date: Fri, 14 Nov 2025 23:00:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Subject: Re: [PATCH v6 00/15] Create and use APIs to centralise locking for
 directory ops
Message-ID: <20251114-simulation-gerissen-aec3f9b82844@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251114-baden-banknoten-96fb107f79d7@brauner>
 <20251114-liedgut-eidesstattlich-8c116178202f@brauner>
 <3209fb8c9be25362316bf3585a156c21f3b0a7e2.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3209fb8c9be25362316bf3585a156c21f3b0a7e2.camel@kernel.org>

On Fri, Nov 14, 2025 at 09:52:59AM -0500, Jeff Layton wrote:
> On Fri, 2025-11-14 at 15:23 +0100, Christian Brauner wrote:
> > On Fri, Nov 14, 2025 at 01:24:41PM +0100, Christian Brauner wrote:
> > > On Thu, Nov 13, 2025 at 11:18:23AM +1100, NeilBrown wrote:
> > > > Following is a new version of this series:
> > > >  - fixed a bug found by syzbot
> > > >  - cleanup suggested by Stephen Smalley
> > > >  - added patch for missing updates in smb/server - thanks Jeff Layton
> > > 
> > > The codeflow right now is very very gnarly in a lot of places which
> > > obviously isn't your fault. But start_creating() and end_creating()
> > > would very naturally lend themselves to be CLASS() guards.
> > >
> > > Unrelated: I'm very inclined to slap a patch on top that renames
> > > start_creating()/end_creating() and start_dirop()/end_dirop() to
> > > vfs_start_creating()/vfs_end_creating() and
> > > vfs_start_dirop()/vfs_end_dirop(). After all they are VFS level
> > > maintained helpers and I try to be consistent with the naming in the
> > > codebase making it very easy to grep.
> > 
> > @Neil, @Jeff, could you please look at:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.all
> > 
> > and specifically at the merge conflict resolution I did for:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.all&id=f28c9935f78bffe6fee62f7fb9f6c5af7e30d9b2
> > 
> > and tell me whether it all looks sane?
> 
> 
> I don't see any major issues. I'm kicking off a quick pynfs test run
> now with it. One fairly minor nit:
> 
> @@ -212,15 +210,13 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  		 * In the 4.0 case, we should never get here; but we may
>  		 * as well be forgiving and just succeed silently.
>  		 */
> -		goto out_put;
> -	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, 0700, NULL);
> +		goto out_end;
> +	dentry = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU, NULL);
>  	if (IS_ERR(dentry))
>  		status = PTR_ERR(dentry);
> 
> I'm not sure if it was Neil's patch or your resolution that changed it,
> but the change from 0700 to a symbolic constant is not preferred, IMO.
> File modes are one of the few places where I think it's easier to
> interpret (octal) numbers rather than symbolic constants.

Neil's patches didn't change that. They just keep the status quo ante.
You've changed it all to octals at the same time you extended directory
operations to allow delegations. Not sure how great it is to mix those
changes together in a single patch.

I can change the resolution to use 0700 again ofc.

