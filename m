Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9B97B1F37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjI1OJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 10:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjI1OJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:09:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BAF9;
        Thu, 28 Sep 2023 07:09:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54E0C433C8;
        Thu, 28 Sep 2023 14:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695910161;
        bh=1OHYrgJpZE5GatH7jXt4ovEw8089Axq7qZtFT+kGgxQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GEE2hqn6D/GeeGUB1nNJiIppgNlMnhn4odSY/su2RN5plTDdf4z2Y6CXd4tBTnvp6
         LzQJfZya3Mt8QT5KMHwmfFdlwMUY/WYLXGJI5g7XgcEp0c1WzOCJdVRPv7B9a81zEe
         CV1vdN04Z7PV3O411Xy4gHhSYX3doGJ6ADT/8lFj+MyK/8BFJHyysMgpUsOscNtu6S
         gMCOzIoCxhy4Vv/bHxZEqbTyGa4Z9NuzAx24r3FoMm4DAVZCrR0BWuW9DZTOIYOm9A
         U5LW6XxlD84bmldH3jVxsn9v+zry6SUAi1+r7GYMMo1VOfM1H6EF2QJ83Qb1mz0pvP
         aUQKFE2nLzvCA==
Message-ID: <c908f4e65777b15e4574f27df97630b3033804a3.camel@kernel.org>
Subject: Re: [PATCH 51/87] fs/nfsd: convert to new inode {a,m}time accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Date:   Thu, 28 Sep 2023 10:09:19 -0400
In-Reply-To: <ZRWGBGqYe3rF5CRY@tissot.1015granger.net>
References: <20230928110300.32891-1-jlayton@kernel.org>
         <20230928110413.33032-1-jlayton@kernel.org>
         <20230928110413.33032-50-jlayton@kernel.org>
         <ZRWGBGqYe3rF5CRY@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-09-28 at 09:56 -0400, Chuck Lever wrote:
> On Thu, Sep 28, 2023 at 07:03:00AM -0400, Jeff Layton wrote:
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/blocklayout.c | 3 ++-
> >  fs/nfsd/nfs3proc.c    | 4 ++--
> >  fs/nfsd/nfs4proc.c    | 8 ++++----
> >  fs/nfsd/nfsctl.c      | 2 +-
> >  4 files changed, 9 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> > index 01d7fd108cf3..bdc582777738 100644
> > --- a/fs/nfsd/blocklayout.c
> > +++ b/fs/nfsd/blocklayout.c
> > @@ -119,10 +119,11 @@ nfsd4_block_commit_blocks(struct inode *inode, st=
ruct nfsd4_layoutcommit *lcp,
> >  {
> >  	loff_t new_size =3D lcp->lc_last_wr + 1;
> >  	struct iattr iattr =3D { .ia_valid =3D 0 };
> > +	struct timespec64 mtime =3D inode_get_mtime(inode);
>=20
> Nit: Please use reverse Christmas tree for new variable declarations.
>=20

Ok

>=20
> >  	int error;
> > =20
> >  	if (lcp->lc_mtime.tv_nsec =3D=3D UTIME_NOW ||
> > -	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
> > +	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
> >  		lcp->lc_mtime =3D current_time(inode);
> >  	iattr.ia_valid |=3D ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
> >  	iattr.ia_atime =3D iattr.ia_ctime =3D iattr.ia_mtime =3D lcp->lc_mtim=
e;
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index 268ef57751c4..b1c90a901d3e 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >  			status =3D nfserr_exist;
> >  			break;
> >  		case NFS3_CREATE_EXCLUSIVE:
> > -			if (d_inode(child)->i_mtime.tv_sec =3D=3D v_mtime &&
> > -			    d_inode(child)->i_atime.tv_sec =3D=3D v_atime &&
> > +			if (inode_get_mtime(d_inode(child)).tv_sec =3D=3D v_mtime &&
> > +			    inode_get_atime(d_inode(child)).tv_sec =3D=3D v_atime &&
>=20
> "inode_get_atime(yada).tv_sec" seems to be a frequently-repeated
> idiom, at least in this patch. Would it be helpful to have an
> additional helper that extracted just the seconds field, and one
> that extracts just the nsec field?
>=20

I don't know that extra helpers will make that any clearer.

>=20
> >  			    d_inode(child)->i_size =3D=3D 0) {
> >  				break;
> >  			}
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 4199ede0583c..b17309aac0d5 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >  			status =3D nfserr_exist;
> >  			break;
> >  		case NFS4_CREATE_EXCLUSIVE:
> > -			if (d_inode(child)->i_mtime.tv_sec =3D=3D v_mtime &&
> > -			    d_inode(child)->i_atime.tv_sec =3D=3D v_atime &&
> > +			if (inode_get_mtime(d_inode(child)).tv_sec =3D=3D v_mtime &&
> > +			    inode_get_atime(d_inode(child)).tv_sec =3D=3D v_atime &&
> >  			    d_inode(child)->i_size =3D=3D 0) {
> >  				open->op_created =3D true;
> >  				break;		/* subtle */
> > @@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
> >  			status =3D nfserr_exist;
> >  			break;
> >  		case NFS4_CREATE_EXCLUSIVE4_1:
> > -			if (d_inode(child)->i_mtime.tv_sec =3D=3D v_mtime &&
> > -			    d_inode(child)->i_atime.tv_sec =3D=3D v_atime &&
> > +			if (inode_get_mtime(d_inode(child)).tv_sec =3D=3D v_mtime &&
> > +			    inode_get_atime(d_inode(child)).tv_sec =3D=3D v_atime &&
> >  			    d_inode(child)->i_size =3D=3D 0) {
> >  				open->op_created =3D true;
> >  				goto set_attr;	/* subtle */
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 7ed02fb88a36..846559e4769b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1132,7 +1132,7 @@ static struct inode *nfsd_get_inode(struct super_=
block *sb, umode_t mode)
> >  	/* Following advice from simple_fill_super documentation: */
> >  	inode->i_ino =3D iunique(sb, NFSD_MaxReserved);
> >  	inode->i_mode =3D mode;
> > -	inode->i_atime =3D inode->i_mtime =3D inode_set_ctime_current(inode);
> > +	simple_inode_init_ts(inode);
>=20
> An observation about the whole series: Should these helpers use the
> usual naming convention of:
>=20
>   <subsystem>-<subject>-<verb>
>=20
> So we get:
>=20
>   simple_inode_ts_init(inode);
>=20
>   inode_atime_get(inode)
>=20

This was already bikeshedded during the ctime series, and the near
universal preference at the time was to go with inode_set_ctime and
inode_get_ctime. I'm just following suit with the new accessors.

>=20
> >  	switch (mode & S_IFMT) {
> >  	case S_IFDIR:
> >  		inode->i_fop =3D &simple_dir_operations;
> > --=20
> > 2.41.0
> >=20
>=20
> Otherwise, for the patch(es) touching nfsd:
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>=20

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
