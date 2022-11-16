Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26F162C2B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiKPPg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiKPPg0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:36:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF61C92D;
        Wed, 16 Nov 2022 07:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C85861E6E;
        Wed, 16 Nov 2022 15:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4184BC433C1;
        Wed, 16 Nov 2022 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668612985;
        bh=+51QNyQ0zG4XqLPgJLjbPfdfi5O6LZRsi2skJKFE0sw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y0cDK3rtRFCzVSm0ArTMRSHKxsEhMTiwyQFDdUbwsYiPQW7RNddLAusDgPynRRFca
         FBJc+U026lPMxrKmv4xRXvj30mLo9jgAIzRvTqZomctS/G+26QOCEUn3RxVSXROwzO
         Y/pgrsxqMP7VCLhbJXYJxBxiOa0wQdshoQRaKwvzLgecOwH9GheImjGbY9w09uGjrH
         FVTnc3+JcN8IfmzNkcd4OHSGzWLzglX4tMMz0Z89r7QbW1hnUZl89jZIaLELDfD6As
         B+6lBVbBG/wyJif0FlJE8TZC/H7TPX8QsoFQgDYxiJQ1A1PjIOecjx8HbHHRwjMFN4
         xxlWZNnbcuTEw==
Message-ID: <388754c59ed73360ccd41c5b85ceadea37a75b9e.camel@kernel.org>
Subject: Re: [PATCH 7/7] nfsd: use locks_inode_context helper
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, "hch@lst.de" <hch@lst.de>
Date:   Wed, 16 Nov 2022 10:36:22 -0500
In-Reply-To: <406B1FC6-23B1-429D-B9BD-33EF0DD7C908@oracle.com>
References: <20221116151726.129217-1-jlayton@kernel.org>
         <20221116151726.129217-8-jlayton@kernel.org>
         <406B1FC6-23B1-429D-B9BD-33EF0DD7C908@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-16 at 15:21 +0000, Chuck Lever III wrote:
>=20
> > On Nov 16, 2022, at 10:17 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > nfsd currently doesn't access i_flctx safely everywhere. This requires =
a
> > smp_load_acquire, as the pointer is set via cmpxchg (a release
> > operation).
> >=20
> > Cc: Chuck Lever <chuck.lever@oracle.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>=20
>=20
> > ---
> > fs/nfsd/nfs4state.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 836bd825ca4a..da8d0ea66229 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4758,7 +4758,7 @@ nfs4_share_conflict(struct svc_fh *current_fh, un=
signed int deny_type)
> >=20
> > static bool nfsd4_deleg_present(const struct inode *inode)
> > {
> > -	struct file_lock_context *ctx =3D smp_load_acquire(&inode->i_flctx);
> > +	struct file_lock_context *ctx =3D locks_inode_context(inode);
> >=20
> > 	return ctx && !list_empty_careful(&ctx->flc_lease);
> > }
> > @@ -5897,7 +5897,7 @@ nfs4_lockowner_has_blockers(struct nfs4_lockowner=
 *lo)
> >=20
> > 	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) =
{
> > 		nf =3D stp->st_stid.sc_file;
> > -		ctx =3D nf->fi_inode->i_flctx;
> > +		ctx =3D locks_inode_context(nf->fi_inode);

Thanks Chuck.

To be clear: I think the above access is probably OK. We wouldn't have a
lock stateid unless we had a valid lock context in the inode. That said,
doing it this way keeps everything consistent, so I'm inclined to leave
the patch as-is.

check_for_locks definitely needs this though.

> > 		if (!ctx)
> > 			continue;
> > 		if (locks_owner_has_blockers(ctx, lo))
> > @@ -7713,7 +7713,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4=
_lockowner *lowner)
> > 	}
> >=20
> > 	inode =3D locks_inode(nf->nf_file);
> > -	flctx =3D inode->i_flctx;
> > +	flctx =3D locks_inode_context(inode);
> >=20
> > 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
> > 		spin_lock(&flctx->flc_lock);
> > --=20
> > 2.38.1
> >=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
