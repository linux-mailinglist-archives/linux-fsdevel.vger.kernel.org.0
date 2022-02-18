Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C314BBDD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiBRQys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 11:54:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBRQyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:54:47 -0500
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F18217BCF9;
        Fri, 18 Feb 2022 08:54:29 -0800 (PST)
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1nL6WU-0005MC-L2; Fri, 18 Feb 2022 11:54:22 -0500
Message-ID: <76ab6eb2c848f6b33fe3cc910d754599e6b2d213.camel@surriel.com>
Subject: Re: [PATCH][RFC] ipc,fs: use rcu_work to free struct ipc_namespace
From:   Rik van Riel <riel@surriel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Chris Mason <clm@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 18 Feb 2022 11:54:21 -0500
In-Reply-To: <87iltcf996.fsf@email.froward.int.ebiederm.org>
References: <20220217153620.4607bc28@imladris.surriel.com>
         <87iltcf996.fsf@email.froward.int.ebiederm.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Nj4RU8Ef5+fKGiA/YAQB"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-Nj4RU8Ef5+fKGiA/YAQB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-02-18 at 10:08 -0600, Eric W. Biederman wrote:
>=20
> Maybe I am reading the lifetimes wrong but is there
> any chance the code can just do something like the diff below?
>=20
> AKA have a special version of kern_umount that does the call_rcu?
>=20
> Looking at rcu_reclaim_tiny I think this use of mnt_rcu is valid.
> AKA reusing the rcu_head in the rcu callback.
>=20
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 40b994a29e90..7d7aaef1592e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4395,6 +4395,22 @@ void kern_unmount(struct vfsmount *mnt)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(kern_unmount);
> =C2=A0
> +static void rcu_mntput(struct rcu_head *head)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mount *mnt =3D container_of(=
head, struct mount,
> mnt_rcu);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mntput(&mnt->mnt);
> +}
> +
> +void kern_rcu_unmount(struct vfsmount *mnt)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* release long term mount so mount=
 point can be released */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!IS_ERR_OR_NULL(mnt)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct mount *m =3D real_mount(mnt);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 m->mnt_ns =3D NULL;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 call_rcu(&m->mnt_rcu, rcu_mntput);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +}

OK, two comments here:

1) As Paul pointed out, we need to use call_rcu_work here,
   because rcu_mntput needs to run from a work item (or well,
   any process context) because of the rwlock.
2) No user of kern_unmount can use the vfsmount structure
   after kern_unmount returns. That means they could all use
   the RCU version, and no special version is needed.

Let me go test a patch that does that...

--=20
All Rights Reversed.

--=-Nj4RU8Ef5+fKGiA/YAQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmIPzz0ACgkQznnekoTE
3oPA5gf/RwIK7o5WwLOdv/NrgFKzTA7grHe3+UaXCdMPIbtPN02DVKRBChzt3tam
Bg4KlnXpdOuUSOtZlyWI7lBYJqPnuMBTOnAmRjLPtKfM33oF57x9SRa3gidIYB2o
GgulqLJbxDISofE3p8UQt6omATXVEclDiuFFX2Dq9Z0J0F+QypOH+HPmjHjxj4sp
9r4zcp2kLJJVucAcnCSdDwA/Aobg3asBeyqpYJaoKtQMMhZcQEMYYChpjkQ0kozc
MKri/ZwKBKALc7xfoQzEtmyXlS8zekZVnZGY9oXUZnGT6A9agYchgB261603Lzjn
2XILdfGnUu0sVGFdNjCbq8U0iUDczA==
=gYON
-----END PGP SIGNATURE-----

--=-Nj4RU8Ef5+fKGiA/YAQB--
