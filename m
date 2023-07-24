Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53EB75F8FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGXNzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGXNzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732932129;
        Mon, 24 Jul 2023 06:54:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04467611DE;
        Mon, 24 Jul 2023 13:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5EFC433C8;
        Mon, 24 Jul 2023 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690206864;
        bh=G9YIu7rwZl2i8OKdrEM+0p3qMlbKOdR2B4+B4YnzfsA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oTA9fnX9QjdujdfnRoozuDirGYtE6ngY24fiK6KoEeJ52ri06KKVboGez/oEi6rgg
         tYhzIwtGGWWqW+ZwG6oBu7JJwfcZcdXxranKRoj7xeh+DSvK2RXk9t2kXUmcuHAh5G
         khzcsFaecumEQBw9Z6rSOTUoZYKWNu0SLWZE4AK0rvG2Hu9pDGy/3n7LdvmtX2qPgV
         JNWFd2Kk0uS/u10kwP+yf6o3PEb9LbDp+vxg7uEFL5p1aKwWMY1CoNmiZOAmAJfNKE
         txrj+lVS07OWAhUg8jNWYbsY+YEK3JG/g4QjYBgwZFlTWNOmSHGxT+eldf65/V1M4H
         PmBAg5JhfPYlg==
Message-ID: <8903ae45c4802af9a56590460d2e1180b0f041f9.camel@kernel.org>
Subject: Re: [PATCH v2] nfsd: inherit required unset default acls from
 effective set
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>
Date:   Mon, 24 Jul 2023 09:54:22 -0400
In-Reply-To: <ZL6AKlkloZQwlmPG@tissot.1015granger.net>
References: <20230724-nfsd-acl-v2-1-1cfaac973498@kernel.org>
         <ZL6AKlkloZQwlmPG@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-07-24 at 09:44 -0400, Chuck Lever wrote:
> On Mon, Jul 24, 2023 at 08:13:05AM -0400, Jeff Layton wrote:
> > A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> > ACEs, but there is no requirement for inheritable entries for those
> > entities. POSIX ACLs must always have owner/group/other entries, even f=
or a
> > default ACL.
> >=20
> > nfsd builds the default ACL from inheritable ACEs, but the current code
> > just leaves any unspecified ACEs zeroed out. The result is that adding =
a
> > default user or group ACE to an inode can leave it with unwanted deny
> > entries.
> >=20
> > For instance, a newly created directory with no acl will look something
> > like this:
> >=20
> > 	# NFSv4 translation by server
> > 	A::OWNER@:rwaDxtTcCy
> > 	A::GROUP@:rxtcy
> > 	A::EVERYONE@:rxtcy
> >=20
> > 	# POSIX ACL of underlying file
> > 	user::rwx
> > 	group::r-x
> > 	other::r-x
> >=20
> > ...if I then add new v4 ACE:
> >=20
> > 	nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
> >=20
> > ...I end up with a result like this today:
> >=20
> > 	user::rwx
> > 	user:1000:rwx
> > 	group::r-x
> > 	mask::rwx
> > 	other::r-x
> > 	default:user::---
> > 	default:user:1000:rwx
> > 	default:group::---
> > 	default:mask::rwx
> > 	default:other::---
> >=20
> > 	A::OWNER@:rwaDxtTcCy
> > 	A::1000:rwaDxtcy
> > 	A::GROUP@:rxtcy
> > 	A::EVERYONE@:rxtcy
> > 	D:fdi:OWNER@:rwaDx
> > 	A:fdi:OWNER@:tTcCy
> > 	A:fdi:1000:rwaDxtcy
> > 	A:fdi:GROUP@:tcy
> > 	A:fdi:EVERYONE@:tcy
> >=20
> > ...which is not at all expected. Adding a single inheritable allow ACE
> > should not result in everyone else losing access.
> >=20
> > The setfacl command solves a silimar issue by copying owner/group/other
> > entries from the effective ACL when none of them are set:
> >=20
> >     "If a Default ACL entry is created, and the  Default  ACL  contains=
  no
> >      owner,  owning group,  or  others  entry,  a  copy of the ACL owne=
r,
> >      owning group, or others entry is added to the Default ACL.
> >=20
> > Having nfsd do the same provides a more sane result (with no deny ACEs
> > in the resulting set):
> >=20
> > 	user::rwx
> > 	user:1000:rwx
> > 	group::r-x
> > 	mask::rwx
> > 	other::r-x
> > 	default:user::rwx
> > 	default:user:1000:rwx
> > 	default:group::r-x
> > 	default:mask::rwx
> > 	default:other::r-x
> >=20
> > 	A::OWNER@:rwaDxtTcCy
> > 	A::1000:rwaDxtcy
> > 	A::GROUP@:rxtcy
> > 	A::EVERYONE@:rxtcy
> > 	A:fdi:OWNER@:rwaDxtTcCy
> > 	A:fdi:1000:rwaDxtcy
> > 	A:fdi:GROUP@:rxtcy
> > 	A:fdi:EVERYONE@:rxtcy
> >=20
> > Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2136452
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Changes in v2:
> > - always set missing ACEs whenever default ACL has any ACEs that are
> >   explicitly set. This better conforms to how setfacl works.
> > - drop now-unneeded "empty" boolean
> > - Link to v1: https://lore.kernel.org/r/20230719-nfsd-acl-v1-1-eb0faf3d=
2917@kernel.org
> > ---
> >  fs/nfsd/nfs4acl.c | 32 ++++++++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > index 518203821790..b931d4383517 100644
> > --- a/fs/nfsd/nfs4acl.c
> > +++ b/fs/nfsd/nfs4acl.c
> > @@ -441,7 +441,7 @@ struct posix_ace_state_array {
> >   * calculated so far: */
> > =20
> >  struct posix_acl_state {
> > -	int empty;
> > +	unsigned char valid;
> >  	struct posix_ace_state owner;
> >  	struct posix_ace_state group;
> >  	struct posix_ace_state other;
> > @@ -457,7 +457,6 @@ init_state(struct posix_acl_state *state, int cnt)
> >  	int alloc;
> > =20
> >  	memset(state, 0, sizeof(struct posix_acl_state));
> > -	state->empty =3D 1;
> >  	/*
> >  	 * In the worst case, each individual acl could be for a distinct
> >  	 * named user or group, but we don't know which, so we allocate
> > @@ -500,7 +499,7 @@ posix_state_to_acl(struct posix_acl_state *state, u=
nsigned int flags)
> >  	 * and effective cases: when there are no inheritable ACEs,
> >  	 * calls ->set_acl with a NULL ACL structure.
> >  	 */
> > -	if (state->empty && (flags & NFS4_ACL_TYPE_DEFAULT))
> > +	if (!state->valid && (flags & NFS4_ACL_TYPE_DEFAULT))
> >  		return NULL;
> > =20
> >  	/*
> > @@ -622,9 +621,10 @@ static void process_one_v4_ace(struct posix_acl_st=
ate *state,
> >  				struct nfs4_ace *ace)
> >  {
> >  	u32 mask =3D ace->access_mask;
> > +	short type =3D ace2type(ace);
> >  	int i;
> > =20
> > -	state->empty =3D 0;
> > +	state->valid |=3D type;
> > =20
> >  	switch (ace2type(ace)) {
>=20
> Mechanical issue: the patch adds @type, but uses it just once.
> The switch here also wants the value of ace2type(ace).
>=20
>=20

Doh! I had that fixed in one version of the patch, but had to rework the
branch and lost that delta. I can respin, or if you just want to fix
that in place, then that would be fine too.

> >  	case ACL_USER_OBJ:
> > @@ -726,6 +726,30 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl=
 *acl,
> >  		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
> >  			process_one_v4_ace(&effective_acl_state, ace);
> >  	}
> > +
> > +	/*
> > +	 * At this point, the default ACL may have zeroed-out entries for own=
er,
> > +	 * group and other. That usually results in a non-sensical resulting =
ACL
> > +	 * that denies all access except to any ACE that was explicitly added=
.
> > +	 *
> > +	 * The setfacl command solves a similar problem with this logic:
> > +	 *
> > +	 * "If  a  Default  ACL  entry is created, and the Default ACL contai=
ns
> > +	 *  no owner, owning group, or others entry,  a  copy of  the  ACL
> > +	 *  owner, owning group, or others entry is added to the Default ACL.=
"
> > +	 *
> > +	 * Copy any missing ACEs from the effective set, if any ACEs were
> > +	 * explicitly set.
> > +	 */
> > +	if (default_acl_state.valid) {
> > +		if (!(default_acl_state.valid & ACL_USER_OBJ))
> > +			default_acl_state.owner =3D effective_acl_state.owner;
> > +		if (!(default_acl_state.valid & ACL_GROUP_OBJ))
> > +			default_acl_state.group =3D effective_acl_state.group;
> > +		if (!(default_acl_state.valid & ACL_OTHER))
> > +			default_acl_state.other =3D effective_acl_state.other;
> > +	}
> > +
> >  	*pacl =3D posix_state_to_acl(&effective_acl_state, flags);
> >  	if (IS_ERR(*pacl)) {
> >  		ret =3D PTR_ERR(*pacl);
> >=20
> > ---
> > base-commit: 7bfb36a2ee1d329a501ba4781db4145dc951c798
> > change-id: 20230719-nfsd-acl-5ab61537e4e6
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
