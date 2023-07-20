Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F675AC25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGTKiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjGTKiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3E29D;
        Thu, 20 Jul 2023 03:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E8D261A04;
        Thu, 20 Jul 2023 10:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98820C433B9;
        Thu, 20 Jul 2023 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689849491;
        bh=Gkd68WMza9f17f7qnkNq9T0apBZbyj3cvsPRtSHBDdU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jAEDLxnI0u+GCrK/vKS5F6VM+YUgUBl68XVTVI8bomzxQHR6iWsZkH59kPvAF0Aep
         1TdurKLRIn/fSfVKaHgw8apzl1tYYzM57dNEwcm8wOFD0786MzxSkQiz6mfZrNnC/9
         hxY57dfntL2bnVaLjDD9QlrE0+XJVBHJ9SEpOIwb5fi4UnVnGA9nVA4Y8jvjpu+gsc
         Rxh7jfyvBa95EZMO+6LY2565NNUwjuzmiiqMCawQz9zZLJhESB2eeKSnRYD/CfWyRG
         anjnObUQo6/C/D1p6osN+r7bTwnnpyJSWB9QevWgo6oCDhQ1jPEgPXdBM5lRG5vMEy
         JQ44HJ65CU56w==
Message-ID: <765cc37a8a46ab750bd6d67b1dc9ffd557923bde.camel@kernel.org>
Subject: Re: [PATCH] nfsd: inherit required unset default acls from
 effective set
From:   Jeff Layton <jlayton@kernel.org>
To:     Andreas =?ISO-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ondrej Valousek <ondrej.valousek@diasemi.com>,
        Andreas Gruenbacher <agruen@redhat.com>
Date:   Thu, 20 Jul 2023 06:38:09 -0400
In-Reply-To: <CAHpGcMLshi34rjcb4ygu3CTz8Vmf_Cb7pJym25qK8vz8+gLDvw@mail.gmail.com>
References: <20230719-nfsd-acl-v1-1-eb0faf3d2917@kernel.org>
         <CAHpGcMLJ6Auk_i4AsWe3R1rvSVr8BgqtZwyFzKCJjGKtWBWi6w@mail.gmail.com>
         <CAHpGcMLshi34rjcb4ygu3CTz8Vmf_Cb7pJym25qK8vz8+gLDvw@mail.gmail.com>
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

On Thu, 2023-07-20 at 10:43 +0200, Andreas Gr=FCnbacher wrote:
> Am Mi., 19. Juli 2023 um 23:22 Uhr schrieb Andreas Gr=FCnbacher
> <andreas.gruenbacher@gmail.com>:
> >=20
> > Hi Jeff,
> >=20
> > this patch seems useful, thanks.
> >=20
> > Am Mi., 19. Juli 2023 um 19:56 Uhr schrieb Jeff Layton <jlayton@kernel.=
org>:
> > > A well-formed NFSv4 ACL will always contain OWNER@/GROUP@/EVERYONE@
> > > ACEs, but there is no requirement for inheritable entries for those
> > > entities. POSIX ACLs must always have owner/group/other entries, even=
 for a
> > > default ACL.
> >=20
> > NFSv4 ACLs actually don't *need* to have OWNER@/GROUP@/EVERYONE@
> > entries; that's merely a result of translating POSIX ACLs (or file
> > modes) to NFSv4 ACLs.
> >=20

RFC 8881, section 6.4 says:

"The server that supports both mode and ACL must take care to
synchronize the MODE4_*USR, MODE4_*GRP, and MODE4_*OTH bits with the
ACEs that have respective who fields of "OWNER@", "GROUP@", and
"EVERYONE@". This way, the client can see if semantically equivalent
access permissions exist whether the client asks for the owner,
owner_group, and mode attributes or for just the ACL."

...so technically you're correct for a generic NFS server, but in the
Linux nfsd case, we have to have them.

> > > nfsd builds the default ACL from inheritable ACEs, but the current co=
de
> > > just leaves any unspecified ACEs zeroed out. The result is that addin=
g a
> > > default user or group ACE to an inode can leave it with unwanted deny
> > > entries.
> > >=20
> > > For instance, a newly created directory with no acl will look somethi=
ng
> > > like this:
> > >=20
> > >         # NFSv4 translation by server
> > >         A::OWNER@:rwaDxtTcCy
> > >         A::GROUP@:rxtcy
> > >         A::EVERYONE@:rxtcy
> > >=20
> > >         # POSIX ACL of underlying file
> > >         user::rwx
> > >         group::r-x
> > >         other::r-x
> > >=20
> > > ...if I then add new v4 ACE:
> > >=20
> > >         nfs4_setfacl -a A:fd:1000:rwx /mnt/local/test
> > >=20
> > > ...I end up with a result like this today:
> > >=20
> > >         user::rwx
> > >         user:1000:rwx
> > >         group::r-x
> > >         mask::rwx
> > >         other::r-x
> > >         default:user::---
> > >         default:user:1000:rwx
> > >         default:group::---
> > >         default:mask::rwx
> > >         default:other::---
> > >=20
> > >         A::OWNER@:rwaDxtTcCy
> > >         A::1000:rwaDxtcy
> > >         A::GROUP@:rxtcy
> > >         A::EVERYONE@:rxtcy
> > >         D:fdi:OWNER@:rwaDx
> > >         A:fdi:OWNER@:tTcCy
> > >         A:fdi:1000:rwaDxtcy
> > >         A:fdi:GROUP@:tcy
> > >         A:fdi:EVERYONE@:tcy
> > >=20
> > > ...which is not at all expected. Adding a single inheritable allow AC=
E
> > > should not result in everyone else losing access.
> > >=20
> > > The setfacl command solves a silimar issue by copying owner/group/oth=
er
> > > entries from the effective ACL when none of them are set:
> > >=20
> > >     "If a Default ACL entry is created, and the  Default  ACL  contai=
ns  no
> > >      owner,  owning group,  or  others  entry,  a  copy of the ACL ow=
ner,
> > >      owning group, or others entry is added to the Default ACL.
> > >=20
> > > Having nfsd do the same provides a more sane result (with no deny ACE=
s
> > > in the resulting set):
> > >=20
> > >         user::rwx
> > >         user:1000:rwx
> > >         group::r-x
> > >         mask::rwx
> > >         other::r-x
> > >         default:user::rwx
> > >         default:user:1000:rwx
> > >         default:group::r-x
> > >         default:mask::rwx
> > >         default:other::r-x
> > >=20
> > >         A::OWNER@:rwaDxtTcCy
> > >         A::1000:rwaDxtcy
> > >         A::GROUP@:rxtcy
> > >         A::EVERYONE@:rxtcy
> > >         A:fdi:OWNER@:rwaDxtTcCy
> > >         A:fdi:1000:rwaDxtcy
> > >         A:fdi:GROUP@:rxtcy
> > >         A:fdi:EVERYONE@:rxtcy
> >=20
> > This resulting NFSv4 ACL is still rather dull; we end up with an
> > inherit-only entry for each effective entry. Those could all be
> > combined, resulting in:
> >=20
> >          A:fd:OWNER@:rwaDxtTcCy
> >          A:fd:1000:rwaDxtcy
> >          A:fd:GROUP@:rxtcy
> >          A:fd:EVERYONE@:rxtcy
> >=20
> > This will be the common case, so maybe matching entry pairs can either
> > be recombined or not generated in the first place as a further
> > improvement.
> >=20

To be clear, this patch fixes the NFSv4->POSIX ACL translation. The
problem you're describing above is more with the POSIX->NFSv4
translation. I don't think we can make the resulting POSIX ACLs more
concise.


> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2136452
> > > Reported-by: Ondrej Valousek <ondrej.valousek@diasemi.com>
> > > Suggested-by: Andreas Gruenbacher <agruen@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/nfsd/nfs4acl.c | 32 +++++++++++++++++++++++++++++---
> > >  1 file changed, 29 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> > > index 518203821790..64e45551d1b6 100644
> > > --- a/fs/nfsd/nfs4acl.c
> > > +++ b/fs/nfsd/nfs4acl.c
> > > @@ -441,7 +441,8 @@ struct posix_ace_state_array {
> > >   * calculated so far: */
> > >=20
> > >  struct posix_acl_state {
> > > -       int empty;
> > > +       bool empty;
> > > +       unsigned char valid;
> >=20
> > Hmm, "valid" is a bitmask here but it only matters whether it is zero.
> > Shouldn't a bool be good enough? Also, this variable indicates whether
> > special "who" values are present (and which), so the name "valid"
> > probably isn't the best choice.
> >=20

Yep, a bool would be fine. This patch went through a bunch of different
revisions and in one, I needed know which individual fields were set. I
kept that here since the storage requirements are still the same, and it
might be more useful for debugging purposes in the future.

> > >         struct posix_ace_state owner;
> > >         struct posix_ace_state group;
> > >         struct posix_ace_state other;
> > > @@ -457,7 +458,7 @@ init_state(struct posix_acl_state *state, int cnt=
)
> > >         int alloc;
> > >=20
> > >         memset(state, 0, sizeof(struct posix_acl_state));
> > > -       state->empty =3D 1;
> > > +       state->empty =3D true;
> > >         /*
> > >          * In the worst case, each individual acl could be for a dist=
inct
> > >          * named user or group, but we don't know which, so we alloca=
te
> > > @@ -624,7 +625,7 @@ static void process_one_v4_ace(struct posix_acl_s=
tate *state,
> > >         u32 mask =3D ace->access_mask;
> > >         int i;
> > >=20
> > > -       state->empty =3D 0;
> > > +       state->empty =3D false;
> > >=20
> > >         switch (ace2type(ace)) {
> > >         case ACL_USER_OBJ:
> > > @@ -633,6 +634,7 @@ static void process_one_v4_ace(struct posix_acl_s=
tate *state,
> > >                 } else {
> > >                         deny_bits(&state->owner, mask);
> > >                 }
> > > +               state->valid |=3D ACL_USER_OBJ;
> > >                 break;
> > >         case ACL_USER:
> > >                 i =3D find_uid(state, ace->who_uid);
> > > @@ -655,6 +657,7 @@ static void process_one_v4_ace(struct posix_acl_s=
tate *state,
> > >                         deny_bits_array(state->users, mask);
> > >                         deny_bits_array(state->groups, mask);
> > >                 }
> > > +               state->valid |=3D ACL_GROUP_OBJ;
> > >                 break;
> > >         case ACL_GROUP:
> > >                 i =3D find_gid(state, ace->who_gid);
> > > @@ -686,6 +689,7 @@ static void process_one_v4_ace(struct posix_acl_s=
tate *state,
> > >                         deny_bits_array(state->users, mask);
> > >                         deny_bits_array(state->groups, mask);
> > >                 }
> > > +               state->valid |=3D ACL_OTHER;
> > >         }
> > >  }
> > >=20
> > > @@ -726,6 +730,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_a=
cl *acl,
> > >                 if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
> > >                         process_one_v4_ace(&effective_acl_state, ace)=
;
> > >         }
> > > +
> > > +       /*
> > > +        * At this point, the default ACL may have zeroed-out entries=
 for owner,
> > > +        * group and other. That usually results in a non-sensical re=
sulting ACL
> > > +        * that denies all access except to any ACE that was explicit=
ly added.
> > > +        *
> > > +        * The setfacl command solves a similar problem with this log=
ic:
> > > +        *
> > > +        * "If  a  Default  ACL  entry is created, and the Default AC=
L contains
> > > +        *  no owner, owning group, or others entry,  a  copy of  the=
  ACL
> > > +        *  owner, owning group, or others entry is added to the Defa=
ult ACL."
> > > +        *
> > > +        * If none of the requisite ACEs were set, and some explicit =
user or group
> > > +        * ACEs were, copy the requisite entries from the effective s=
et.
> > > +        */
> > > +       if (!default_acl_state.valid &&
> > > +           (default_acl_state.users->n || default_acl_state.groups->=
n)) {
> > > +               default_acl_state.owner =3D effective_acl_state.owner=
;
> > > +               default_acl_state.group =3D effective_acl_state.group=
;
> > > +               default_acl_state.other =3D effective_acl_state.other=
;
> > > +       }
> > > +
>=20
> The other thing I'm wondering about is whether it would make more
> sense to fake up for missing entries individually as setfacl does:
>=20
> http://git.savannah.nongnu.org/cgit/acl.git/tree/tools/do_set.c#n368
>=20

Oh, I was going by the description in the manpage which seemed to
indicate that if any of those had been set in the effective ACL that we
wouldn't try to fake up anything. I actually had an earlier version that
did what you suggest here. I can change it if you think that's more
correct. It might be good to revise that description in the setfacl
manpage since it's a little unclear.

> > >         *pacl =3D posix_state_to_acl(&effective_acl_state, flags);
> > >         if (IS_ERR(*pacl)) {
> > >                 ret =3D PTR_ERR(*pacl);
> > >=20
> > > ---
> > > base-commit: 9d985ab8ed33176c3c0380b7de589ea2ae51a48d
> > > change-id: 20230719-nfsd-acl-5ab61537e4e6
> > >=20
> > > Best regards,
> > > --
> > > Jeff Layton <jlayton@kernel.org>
>=20
> Thanks,
> Andreas

--=20
Jeff Layton <jlayton@kernel.org>
