Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13677428E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjHHRqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHHRpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CA25B39;
        Tue,  8 Aug 2023 09:20:45 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so7603046a12.0;
        Tue, 08 Aug 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511612; x=1692116412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6AJ8lGHVDDQsKqJM0iYPvItsrgmxRvUz0TuV1LYvToc=;
        b=G2uAZfaBkX3WZX1VstQHOhw7BSSlCgaIsEn15RVi1yKZWV4GQndZNN/GK42artP169
         6jYKJqAHH3f/6GY1jUazkyFGh47WSSPd37BiM4GrqHXxFDWXb6RbOyIfSfKx/TPM018T
         TFBwVKYXLNgxNuwcTJlV16suSkSqYCWrceYUQyzDUowQYnrzByEdUaUUkLNyj2SW3ASF
         WtwE/V65PkpP3ZLVB+14WzBXp/6Y3JwS+aI+JXv3XdU5kdzM11vzxn8vcoaj9vZy96MM
         a9pNOiaU8Z9BvX4Pyii8B/IqrpjlnqkaXYDqkXg0n1ul2CmUXiqndlMvn0l/lmmqeX86
         gL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511612; x=1692116412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AJ8lGHVDDQsKqJM0iYPvItsrgmxRvUz0TuV1LYvToc=;
        b=N04GL/AxYqB0U2mH+bgI/PmskZkpoRoi3XAgDcLi74sGwgtuQ42jcxdFKXZAkFuxr/
         +mFFmNjJ/UWH5HpjR9YU1lb/A3JWnI9ZWR6b2V1cg4mp3YbzMWU7pSBc9sk8RwZqbY9q
         00gvKZx6O8QTIoaZIx5qCWOKgu227cHAzdPeE/xZinnJ4eF9QG2RsBzyT6FDIl0Soi/k
         cqQHEd3sZN7wNIJ6WE34vRBE9SAMZK0yz2uGg2BHmCdsfO/kjjxEeUNimp3eIlCuLzoe
         MxEnEjOrfjTOzG/WeiuHiq7tOzFMRATEueCE6qEx4NYUMd5y9jjAnEQvDlv0x2ygtO3T
         /hXw==
X-Gm-Message-State: AOJu0YzQVnh3dkHYWQF1oX42oCMqhzuMKAPm0+Xzt1ICfddj2VGgoUdI
        s2mn3flqG1LPRqjMYWUaldQoCxzqZSIXGDe9
X-Google-Smtp-Source: AGHT+IGyY/nE6OduNoYHb4FqsV699UqfKW2Yxv9xMsVScJIAlzhtYn4/SNWKfl3pUi+89xLrn9sXVw==
X-Received: by 2002:a05:6512:3c9f:b0:4f9:5196:5ed0 with SMTP id h31-20020a0565123c9f00b004f951965ed0mr10717440lfv.7.1691504654613;
        Tue, 08 Aug 2023 07:24:14 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id b23-20020ac247f7000000b004fcdf99be86sm1873028lfp.239.2023.08.08.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 07:24:13 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:24:11 +0200
From:   Joel Granados <joel.granados@gmail.com>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 11/14] networking: Update to register_net_sysctl_sz
Message-ID: <20230808142411.h55rzvczm5nff4m2@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-12-j.granados@samsung.com>
 <CGME20230808112110eucas1p1332795fa88d771ac3f05825f33052cf9@eucas1p1.samsung.com>
 <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="krgknuiaaxdgkah7"
Content-Disposition: inline
In-Reply-To: <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--krgknuiaaxdgkah7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 01:20:36PM +0200, Przemek Kitszel wrote:
> On 7/31/23 09:17, Joel Granados wrote:
> > Move from register_net_sysctl to register_net_sysctl_sz for all the
> > networking related files. Do this while making sure to mirror the NULL
> > assignments with a table_size of zero for the unprivileged users.
> >=20
=2E..
> >   	const char *dev_name_source;
> >   	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
> >   	char *p_name;
> > +	size_t neigh_vars_size;
> >   	t =3D kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT=
);
> >   	if (!t)
> > @@ -3790,11 +3791,13 @@ int neigh_sysctl_register(struct net_device *de=
v, struct neigh_parms *p,
> >   		t->neigh_vars[i].extra2 =3D p;
> >   	}
> > +	neigh_vars_size =3D ARRAY_SIZE(t->neigh_vars);
> >   	if (dev) {
> >   		dev_name_source =3D dev->name;
> >   		/* Terminate the table early */
> >   		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
> >   		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
> > +		neigh_vars_size =3D NEIGH_VAR_BASE_REACHABLE_TIME_MS;
>=20
> %NEIGH_VAR_BASE_REACHABLE_TIME_MS is last usable index here, and since th=
ose
> are 0 based, size is one more, %NEIGH_VAR_GC_INTERVAL.
> (spelling it "NEIGH_VAR_BASE_REACHABLE_TIME_MS+1" would be perhaps better=
?)
This is a very good catch. Thx for this!! I'll correct here and double
check all the other places where I'm trying to replace the memset with a
enumeration element. Just to make sure that I don't have an "off by one"
like the one here.

>=20
> >   	} else {
> >   		struct neigh_table *tbl =3D p->tbl;
> >   		dev_name_source =3D "default";
> > @@ -3841,8 +3844,9 @@ int neigh_sysctl_register(struct net_device *dev,=
 struct neigh_parms *p,
> >   	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
> >   		p_name, dev_name_source);
> > -	t->sysctl_header =3D
> > -		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars);
> > +	t->sysctl_header =3D register_net_sysctl_sz(neigh_parms_net(p),
> > +						  neigh_path, t->neigh_vars,
> > +						  neigh_vars_size);
> >   	if (!t->sysctl_header)
> >   		goto free;
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 782273bb93c2..03f1edb948d7 100644

=2E..

> >   {
> >   	struct ctl_table *table;
> > +	size_t table_size =3D ARRAY_SIZE(xfrm_table);
> >   	__xfrm_sysctl_init(net);
> > @@ -56,10 +57,13 @@ int __net_init xfrm_sysctl_init(struct net *net)
> >   	table[3].data =3D &net->xfrm.sysctl_acq_expires;
> >   	/* Don't export sysctls to unprivileged users */
> > -	if (net->user_ns !=3D &init_user_ns)
> > +	if (net->user_ns !=3D &init_user_ns) {
> >   		table[0].procname =3D NULL;
>=20
> do we still have to set procname to NULL, even if passed size is 0?
> (same thing for all earlier occurences)
Yes, we still need to set the procname to NULL in this patchest!. We are
introducing the ARRAY_SIZE but not actually using it (not yet). Keeping
the "procname =3D=3D NULL" stopping criteria allows us to keep the current
behavior while we introduce the size in the background. We will start
using the patchset in the upcoming patchsets.

>=20
> > +		table_size =3D 0;
> > +	}
> > -	net->xfrm.sysctl_hdr =3D register_net_sysctl(net, "net/core", table);
> > +	net->xfrm.sysctl_hdr =3D register_net_sysctl_sz(net, "net/core", tabl=
e,
> > +						      table_size);
> >   	if (!net->xfrm.sysctl_hdr)
> >   		goto out_register;
> >   	return 0;
>=20
> overall this patch looks sane, and whole series looks very promissing,
> thanks

Thx for the feedback

Best

--=20

Joel Granados

--krgknuiaaxdgkah7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSUAgACgkQupfNUreW
QU9yfwv/QSy3sOdREttyAVWSpEcvXkTsB8QEvSPniFewWKTfaNBN1Ojv0D3lbcnM
VfJTMgzzk9lFZdAfjjLQKskpPo05llLtUXAA/CMAjA8B0SvOc1w6ihdXD8iZV2Eb
apRGmyjL50d3XtUcj8JmiyR5Jj0hejawBJ6mBCjadYhYfWu37XhyEmd1PJD+w0gd
GkXv/XqdSDM0n0+WyCo5Kyc20hKfpHFrggxa57kT86r4pnK3C4vmMyW2BH28iv0o
7Ad3Ia8rg8xESDXOS0M2NwU74ArYP0D1rB3J5fWRZFTVpcZmPaV385SIJp8KgAVO
VoRlIVKz5vZDYYwgCu0kEqjTUbr6G59AcXQBsKXwiuY/3BUPZnQWg/9XqwpLHwRD
yQhDcnINrqJWzBpIz16bQeD2YFL4pnCW/LmhorI53z+d95zdYklDHYspaWaYBYHn
nMpsgkDOQeWqZ2JCjlv26yFeQsj4jiqriLL5lGs+NoP6poCX6i3W5wfFpH4DaASH
sbL6j7xk
=9RjB
-----END PGP SIGNATURE-----

--krgknuiaaxdgkah7--
