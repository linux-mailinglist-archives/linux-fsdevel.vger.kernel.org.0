Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E070C009
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEVNtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjEVNtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C38ED;
        Mon, 22 May 2023 06:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E879361614;
        Mon, 22 May 2023 13:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0952C433D2;
        Mon, 22 May 2023 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684763342;
        bh=NMNiJ0mPgzw7IxzF4cDREzLTgfMblUHLQo7wGpbJPbg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BI8z4AsjgVYPKvjVVea34z2J10L0DdhzDsd6u0D2YPHL0h+mjH/9D0qRSmLYBWy6d
         BoeSfpHE4DL7xcgRSRFoDtYqgZmL+VLMwPk4QOH9FfJnhZ8VvLQN6h9ZBjzl24cS5s
         U/owJMYL2GMk9l4sSmRkBPJXfhfeYGrzypp/GfmOmHRWQW3Ju2+y9VegACF04WgQQm
         AYB+F4F/dNDizXzJfIK/AO6TZUtbL6cnJUl1mCZZWJyJzB+k9mJcVttJfjxVwvN8rG
         f45rJeWBlxqSA0Cg14fQXPAtbE+N7lwGPQoTHHO6RoOuRKLp/ida0tJGYZ3uwTWWIS
         PBd1rNmP6H5cg==
Message-ID: <09113712aa83d9010ec3963368bce840dfb762db.camel@kernel.org>
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 22 May 2023 09:49:00 -0400
In-Reply-To: <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
         <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
         <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
         <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
         <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2023-05-21 at 20:56 -0700, dai.ngo@oracle.com wrote:
> On 5/21/23 7:56 PM, dai.ngo@oracle.com wrote:
> >=20
> > On 5/21/23 4:08 PM, Jeff Layton wrote:
> > > On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
> > > > If the GETATTR request on a file that has write delegation in effec=
t
> > > > and the request attributes include the change info and size attribu=
te
> > > > then the write delegation is recalled and NFS4ERR_DELAY is returned
> > > > for the GETATTR.
> > > >=20
> > > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > > ---
> > > > =A0 fs/nfsd/nfs4xdr.c | 45 ++++++++++++++++++++++++++++++++++++++++=
+++++
> > > > =A0 1 file changed, 45 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > > > index 76db2fe29624..e069b970f136 100644
> > > > --- a/fs/nfsd/nfs4xdr.c
> > > > +++ b/fs/nfsd/nfs4xdr.c
> > > > @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr,=
=20
> > > > u32 bmval0, u32 bmval1, u32 bmval2)
> > > > =A0=A0=A0=A0=A0 return nfserr_resource;
> > > > =A0 }
> > > > =A0 +static struct file_lock *
> > > > +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
> > > > +{
> > > > +=A0=A0=A0 struct file_lock_context *ctx;
> > > > +=A0=A0=A0 struct file_lock *fl;
> > > > +
> > > > +=A0=A0=A0 ctx =3D locks_inode_context(inode);
> > > > +=A0=A0=A0 if (!ctx)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return NULL;
> > > > +=A0=A0=A0 spin_lock(&ctx->flc_lock);
> > > > +=A0=A0=A0 if (!list_empty(&ctx->flc_lease)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 fl =3D list_first_entry(&ctx->flc_lease,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct f=
ile_lock, fl_list);
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (fl->fl_type =3D=3D F_WRLCK) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&ctx->flc_lock);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return fl;
> > > > +=A0=A0=A0=A0=A0=A0=A0 }

One more issue here too. FL_LAYOUT file_locks live on this list too.
They shouldn't conflict with leases or delegations, so you probably just
want to skip them.

Longer term, I wonder if we ought to add a new list in the
file_lock_context for layouts? There's no reason to keep them all on the
same list.

> > > > +=A0=A0=A0 }
> > > > +=A0=A0=A0 spin_unlock(&ctx->flc_lock);
> > > > +=A0=A0=A0 return NULL;
> > > > +}
> > > > +
> > > > +static __be32
> > > > +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode=
=20
> > > > *inode)
> > > > +{
> > > > +=A0=A0=A0 __be32 status;
> > > > +=A0=A0=A0 struct file_lock *fl;
> > > > +=A0=A0=A0 struct nfs4_delegation *dp;
> > > > +
> > > > +=A0=A0=A0 fl =3D nfs4_wrdeleg_filelock(rqstp, inode);
> > > > +=A0=A0=A0 if (!fl)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > +=A0=A0=A0 dp =3D fl->fl_owner;
> > > > +=A0=A0=A0 if (dp->dl_recall.cb_clp =3D=3D *(rqstp->rq_lease_breake=
r))
> > > > +=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > > +=A0=A0=A0 refcount_inc(&dp->dl_stid.sc_count);
> > > Another question: Why are you taking a reference here at all?
> >=20
> > This is same as in nfsd_break_one_deleg and revoke_delegation.
> > I think it is to prevent the delegation to be freed while delegation
> > is being recalled.
> >=20
> > > =A0 AFAICT,
> > > you don't even look at the delegation again after that point, so it's
> > > not clear to me who's responsible for putting that reference.
> >=20
> > In v2, the sc_count is decrement by nfs4_put_stid. I forgot to do that
> > in V4. I'll add it back in v5.
>=20
> Actually the refcount is decremented after the CB_RECALL is done
> by nfs4_put_stid in nfsd4_cb_recall_release. So we don't have to
> decrement it here. This is to prevent the delegation to be free
> while the recall is being sent.
>=20

That's the put for the increment in nfsd_break_one_deleg.

You don't need to take an extra reference to a delegation to call
nfsd_open_break_lease. You might not even know which delegation is being
broken. There could even be more than one, after all.

I think that extra refcount_inc is likely to cause a leak.
--=20
Jeff Layton <jlayton@kernel.org>
