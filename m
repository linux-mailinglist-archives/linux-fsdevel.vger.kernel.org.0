Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA126D00DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjC3KOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjC3KO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:14:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86272868B;
        Thu, 30 Mar 2023 03:14:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E71B82582;
        Thu, 30 Mar 2023 10:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72054C433EF;
        Thu, 30 Mar 2023 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680171258;
        bh=1DRt/6//qsaRBAIrWLGXcGZabxxr4NuFgrQAGvbu1xY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lcwmANd/nMY1RWYxVRtXhJPUcMXDbMg2N8O/bnT9Wkbt/SFTFf1sklp5TS70jRguH
         9kA38taE8xcNfVX27S/odMrD4o5Wr7lKeHXcmNguTsunYose8kHuLTAOjm0Xa3Ygud
         6pn/oBjDuZk67AphoPGuN0EZvsxWxskwcY5gkMEOi1TFzNXr67LKgFlHflgtCKDpTo
         0/dQjfLtbzG+md7GcBcLYUihjx1mWMdDvsWptw4jZMihVkaLp2jwBqT5MQYHtHsfJ7
         N8fNpSB6WQR9j+EFxM7kpejqiiQnx/CoaMg2XgxQjjO78Y5ryRZUkFi5C4hLVPrGGn
         DXk+E8rSMxGmQ==
Message-ID: <eba75b19eab0281f79632edc0317ea7bbda9cb58.camel@kernel.org>
Subject: Re: [PATCH v2] fs: consolidate dt_type() helper definitions
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 30 Mar 2023 06:14:15 -0400
In-Reply-To: <20230330-magma-struck-e1f80f624070@brauner>
References: <20230330000157.297698-1-jlayton@kernel.org>
         <20230330-magma-struck-e1f80f624070@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-30 at 07:44 +0200, Christian Brauner wrote:
> On Wed, Mar 29, 2023 at 08:01:55PM -0400, Jeff Layton wrote:
> > There are 4 functions named dt_type() in the kernel. There is also the
> > S_DT macro in fs_types.h.
> >=20
> > Replace the S_DT macro with a static inline named dt_type, and have all
> > of the existing copies call that instead. The v9fs helper is renamed to
> > distinguish it from the others.
> >=20
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Cc: Phillip Potter <phil@philpotter.co.uk>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/9p/vfs_dir.c          | 6 +++---
> >  fs/configfs/dir.c        | 8 +-------
> >  fs/fs_types.c            | 2 +-
> >  fs/kernfs/dir.c          | 8 +-------
> >  fs/libfs.c               | 9 ++-------
> >  include/linux/fs_types.h | 7 ++++++-
> >  6 files changed, 14 insertions(+), 26 deletions(-)
> >=20
> > What about this one instead? This consolidates another copy and we use
> > Phillip's version that uses named constants instead of magic numbers.
> >=20
> > There are some scary warnings in fs_types.h about not changing the
> > definitions, but hopefully the rename from S_DT() to dt_type() is OK.
> >=20
> > diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
> > index 3d74b04fe0de..80b331f7f446 100644
> > --- a/fs/9p/vfs_dir.c
> > +++ b/fs/9p/vfs_dir.c
> > @@ -41,12 +41,12 @@ struct p9_rdir {
> >  };
> > =20
> >  /**
> > - * dt_type - return file type
> > + * v9fs_dt_type - return file type
> >   * @mistat: mistat structure
> >   *
> >   */
> > =20
> > -static inline int dt_type(struct p9_wstat *mistat)
> > +static inline int v9fs_dt_type(struct p9_wstat *mistat)
> >  {
> >  	unsigned long perm =3D mistat->mode;
> >  	int rettype =3D DT_REG;
> > @@ -128,7 +128,7 @@ static int v9fs_dir_readdir(struct file *file, stru=
ct dir_context *ctx)
> >  			}
> > =20
> >  			over =3D !dir_emit(ctx, st.name, strlen(st.name),
> > -					 v9fs_qid2ino(&st.qid), dt_type(&st));
> > +					 v9fs_qid2ino(&st.qid), v9fs_dt_type(&st));
> >  			p9stat_free(&st);
> >  			if (over)
> >  				return 0;
> > diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> > index 4afcbbe63e68..43863a1696eb 100644
> > --- a/fs/configfs/dir.c
> > +++ b/fs/configfs/dir.c
> > @@ -1599,12 +1599,6 @@ static int configfs_dir_close(struct inode *inod=
e, struct file *file)
> >  	return 0;
> >  }
> > =20
> > -/* Relationship between s_mode and the DT_xxx types */
> > -static inline unsigned char dt_type(struct configfs_dirent *sd)
> > -{
> > -	return (sd->s_mode >> 12) & 15;
> > -}
> > -
> >  static int configfs_readdir(struct file *file, struct dir_context *ctx=
)
> >  {
> >  	struct dentry *dentry =3D file->f_path.dentry;
> > @@ -1654,7 +1648,7 @@ static int configfs_readdir(struct file *file, st=
ruct dir_context *ctx)
> >  		name =3D configfs_get_name(next);
> >  		len =3D strlen(name);
> > =20
> > -		if (!dir_emit(ctx, name, len, ino, dt_type(next)))
> > +		if (!dir_emit(ctx, name, len, ino, dt_type(next->s_mode)))
> >  			return 0;
> > =20
> >  		spin_lock(&configfs_dirent_lock);
> > diff --git a/fs/fs_types.c b/fs/fs_types.c
> > index 78365e5dc08c..7dd5c0fb74fb 100644
> > --- a/fs/fs_types.c
> > +++ b/fs/fs_types.c
> > @@ -76,7 +76,7 @@ static const unsigned char fs_ftype_by_dtype[DT_MAX] =
=3D {
> >   */
> >  unsigned char fs_umode_to_ftype(umode_t mode)
> >  {
> > -	return fs_ftype_by_dtype[S_DT(mode)];
> > +	return fs_ftype_by_dtype[dt_type(mode)];
> >  }
> >  EXPORT_SYMBOL_GPL(fs_umode_to_ftype);
>=20
> Nice cleanup. But looking at this a bit it makes me wonder a little. It
> seems there's a bit of indirection going on:
>=20
> fs_umode_to_dtype()
> -> fs_type_to_dtype()
>    -> fs_umode_to_ftype()
>       -> fs_ftype_by_dtype()
>          -> dt_type()
>=20
> Presumably it exists so that unexpected return values from dt_type() are
> caught and DT_UNKNOWN is returned instead of whatever raw value
> dt_type() returned.

> If none of the filesystems we convert to dt_type() here expects "custom"
> return values from dt_type(), i.e., would never get DT_UNKNOWN, we
> should consider just switching all those places to fs_umode_to_dtype().
>=20
> However, if they do expect custom dt_type() values and so we really need
> to have them use dt_type() then we should remove fs_umode_to_dtype()
> because it is curerntly unused if my grepping skills haven't left me.

Good point.

The dt_type returns are all handed to dir_emit, and it looks like most
of the readdir actor functions just take that value as-is and stuff it
into the appropriate readdir response.

Given that, we probably don't want to hand the actors any "custom"
values and should switch these callers over to fs_umode_to_dtype
instead.

I'll plan to spin up a v3 series (and address HCH's comments in that
too).

Thanks for the review, everyone!
--=20
Jeff Layton <jlayton@kernel.org>
