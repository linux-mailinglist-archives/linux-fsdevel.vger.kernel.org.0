Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D30582611
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiG0MEm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiG0MEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:04:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFBA4B0EC;
        Wed, 27 Jul 2022 05:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CED2DB82035;
        Wed, 27 Jul 2022 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBE7C433D6;
        Wed, 27 Jul 2022 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658923476;
        bh=TJzTGxdWYyNLFJKQVh/pRV3ZHT37AT3Z4uZIdGkD698=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eQ6uTKhUYFUjMjg0KL087Cv+zVzDugpGH3qyqxp0rIebemgaWCGUWA1OiwJctUNKc
         WUlIk+GcQ/sWM0WIPQhQp7GFlkpTuUH0sXOm9z3OfOlIJV26hAUK5rvOTKupnVoS9m
         I4iHF5y2e45LoosqjtIHaBhCHc17NKP9eYoBTibqKSw3iY6lkaZd1mkYiUq8+TajXk
         OR1UG5TIestAUOM7a4+06rzdl4a+FS1LoeA4jTqoY4ih7j3scCsQXv0102aZmwH29W
         E4FUPB9o9kTbICWMySoBXI4dQvIpqZGtX5qRije2XHaZNly7P7wHPm+TvwprkpAb5s
         eVeRbu6iafjNw==
Message-ID: <b1d3c63ef5a7e8f98966552b4509381aae25afb6.camel@kernel.org>
Subject: Re: [RFC PATCH] vfs: don't check may_create_in_sticky if the file
 is already open/created
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Date:   Wed, 27 Jul 2022 08:04:34 -0400
In-Reply-To: <20220727113406.ewu4kzsoo643cf66@wittgenstein>
References: <20220726202333.165490-1-jlayton@kernel.org>
         <8e4d498a3e8ed80ada2d3da01e7503e082be31a3.camel@kernel.org>
         <20220727113406.ewu4kzsoo643cf66@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-07-27 at 13:34 +0200, Christian Brauner wrote:
> On Tue, Jul 26, 2022 at 04:27:56PM -0400, Jeff Layton wrote:
> > On Tue, 2022-07-26 at 16:23 -0400, Jeff Layton wrote:
> > > NFS server is exporting a sticky directory (mode 01777) with root
> > > squashing enabled. Client has protect_regular enabled and then tries =
to
> > > open a file as root in that directory. File is created (with ownershi=
p
> > > set to nobody:nobody) but the open syscall returns an error.
> > >=20
> > > The problem is may_create_in_sticky, which rejects the open even thou=
gh
> > > the file has already been created/opened. Only call may_create_in_sti=
cky
> > > if the file hasn't already been opened or created.
> > >=20
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1976829
> > > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/namei.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 1f28d3f463c3..7480b6dc8d27 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3495,10 +3495,15 @@ static int do_open(struct nameidata *nd,
> > >  			return -EEXIST;
> > >  		if (d_is_dir(nd->path.dentry))
> > >  			return -EISDIR;
> > > -		error =3D may_create_in_sticky(mnt_userns, nd,
> > > -					     d_backing_inode(nd->path.dentry));
> > > -		if (unlikely(error))
> > > -			return error;
> > > +		if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > > +			error =3D may_create_in_sticky(mnt_userns, nd,
> > > +						d_backing_inode(nd->path.dentry));
> > > +			if (unlikely(error)) {
> > > +				printk("%s: f_mode=3D0x%x oflag=3D0x%x\n",
> > > +					__func__, file->f_mode, open_flag);
> > > +				return error;
> > > +			}
> > > +		}
> > >  	}
> > >  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry=
))
> > >  		return -ENOTDIR;
> >=20
> > I'm pretty sure this patch is the wrong approach, actually, since it
> > doesn't fix the regular (non-atomic) open codepath. Any thoughts on wha=
t
>=20
> Hey Jeff,
>=20
> I haven't quite understood why that won't work for the regular open
> codepaths. I'm probably missing something obvious.
>=20

In the normal open codepaths, FMODE_OPENED | FMODE_CREATED are still
clear. If we're not doing an atomic_open (i.e. the dentry doesn't exist
yet or is negative), then nothing really happens until you get to the
vfs_open call.

> > the right fix might be?
>=20
> When an actual creation has taken place - and not just a lookup - then
> may_create_in_sticky() assumes that the owner of the inode matches
> current_fsuid(). That'd would also be problematic on fat or in fact on
> any fs where the actual inode->i_{g,u}id are based on e.g. uid/gid mount
> options and not on current_fsuid(), I think?
>=20
> So in order to improve this we would need to work around that assumption
> in some way. Either by skipping may_create_in_sticky() if the file got
> created or by adapting may_create_in_sticky().
>=20
> I only wonder whether skipping may_create_in_sticky() altogether might
> be a bit too lax. One possibility that came to my mind might be to relax
> this assumption when the file has been created and the creator has
> CAP_FOWNER.
>=20

That may be the best option. I'll tinker around with that and see if I
can get it to work. Thanks for the suggestion.

> So (not compile tested or in any way) sm like:
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f28d3f463c3..239e9f423346 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1221,7 +1221,8 @@ int may_linkat(struct user_namespace *mnt_userns, s=
truct path *link)
>   * Returns 0 if the open is allowed, -ve on error.
>   */
>  static int may_create_in_sticky(struct user_namespace *mnt_userns,
> -                               struct nameidata *nd, struct inode *const=
 inode)
> +                               struct nameidata *nd, struct inode *const=
 inode,
> +                               bool created)
>  {
>         umode_t dir_mode =3D nd->dir_mode;
>         kuid_t dir_uid =3D nd->dir_uid;
> @@ -1230,7 +1231,9 @@ static int may_create_in_sticky(struct user_namespa=
ce *mnt_userns,
>             (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
>             likely(!(dir_mode & S_ISVTX)) ||
>             uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
> -           uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
> +           uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) ||
> +           (created &&
> +            capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FOWNER)))
>                 return 0;
>=20
>         if (likely(dir_mode & 0002) ||
> @@ -3496,7 +3499,8 @@ static int do_open(struct nameidata *nd,
>                 if (d_is_dir(nd->path.dentry))
>                         return -EISDIR;
>                 error =3D may_create_in_sticky(mnt_userns, nd,
> -                                            d_backing_inode(nd->path.den=
try));
> +                                            d_backing_inode(nd->path.den=
try),
> +                                            (file->f_mode & FMODE_CREATE=
D));
>                 if (unlikely(error))
>                         return error;
>         }

I think that still won't fix it in the normal open codepath.
FMODE_CREATED won't be set, so this will just end up failing again.

--=20
Jeff Layton <jlayton@kernel.org>
