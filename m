Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C127A773F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjHHQtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjHHQss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:48:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC444447B;
        Tue,  8 Aug 2023 08:57:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe4762173bso9624702e87.3;
        Tue, 08 Aug 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510195; x=1692114995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKR/mQxiWCp6UmZoc/ZIdm/CvMRbYORnLL2Bmf5WunY=;
        b=iTep3vMy6Z8EHVl1pNEMn2tN+1w99+9Dgp6gAbfQO3hye73jDjBdCub0T2zqH9X7hD
         noYURqNZ/iggYzokFPQFPUCJ+YaRsqyljdSvL3znPKS9FmhZ4/OkbBbZv2jVRlYmiEP1
         vkTgmujWH7QdPoYhDSHUmN3kGqsy8spVGBdMriHHT+TIm6srxytss76c0BZzpd6eTVYo
         HChuERSTjv7yicIqn3TmG7rfgl/GFLAbQZagCVVkY4E6/7GnxAYyCw9v+QUTQVxJUtle
         NPW60gvllRzBqLHk9eOWD9RR52y7u8XOeCw6JWaKtqPMSAX5Yy2L1FzRT8dsoy+RWVd9
         s0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510195; x=1692114995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKR/mQxiWCp6UmZoc/ZIdm/CvMRbYORnLL2Bmf5WunY=;
        b=iz8fRiVPO5DYbcN1sqJmxrj6kfRfx2EHmXaZk4Hrzcy5rCVxguA5Bx7IlP+v2qP/br
         UfmQVQiAboVgOGnLH2A4L0Ex7e0slkv9IoPkfy0+EGjO162zMQbxk27vCnJ/m1klKU1R
         nAvREpSNg+FCVqeFJuOE8azncNSLAYzRxLdfjDkfzwRtjd6j7z3kSuQSA/KUYyWhhvVz
         uL3zS3pqakebLxYFkLq2eZ1Lrr8r9yp3BJroA0bXyMa6ixfXq8k3kTI1VScAKXJah9c0
         qzUu6qjMAeoYVfYCL74ggVClc1sAg/QdbENhzhW3cr93yoyim+BPjQgVwVcRi5Jw7CGs
         BOTA==
X-Gm-Message-State: AOJu0Yyrnnet/IFtl8CTde8u6iirhZCeAVTOI7MsdYEd/vO5nZ4rCEZO
        wkJmwng9pTni8IvLVu8t3YkLG43UTdFaW//T
X-Google-Smtp-Source: AGHT+IFnYhIzaS3Y+KcV0Lrw6qJXYUrYWCoAb9tRY2N+65/72vnKp1uSD5k97nShAi0GFBixW7Zi2Q==
X-Received: by 2002:a05:6512:3b0a:b0:4fe:3f2:2efc with SMTP id f10-20020a0565123b0a00b004fe03f22efcmr11495192lfv.0.1691508221319;
        Tue, 08 Aug 2023 08:23:41 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id a3-20020a056512020300b004fcdd81355csm1920516lfo.269.2023.08.08.08.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:23:40 -0700 (PDT)
Date:   Tue, 8 Aug 2023 17:23:38 +0200
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
Message-ID: <20230808152338.aoubpvauxpcuwfuz@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-12-j.granados@samsung.com>
 <CGME20230808112110eucas1p1332795fa88d771ac3f05825f33052cf9@eucas1p1.samsung.com>
 <22e0e672-f9f6-6afe-6ce6-63de264e7b6d@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry2jlv6i2gzplzus"
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


--ry2jlv6i2gzplzus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 01:20:36PM +0200, Przemek Kitszel wrote:
> On 7/31/23 09:17, Joel Granados wrote:
> > Move from register_net_sysctl to register_net_sysctl_sz for all the
> > networking related files. Do this while making sure to mirror the NULL
> > assignments with a table_size of zero for the unprivileged users.
> >=20
> > We need to move to the new function in preparation for when we change
> > SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
> > so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
> > hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
> > the relevant net sysctl registering functions to register_net_sysctl_sz
> > in subsequent commits.
> >=20
> > An additional size function was added to the following files in order to
> > calculate the size of an array that is defined in another file:
> >      include/net/ipv6.h
> >      net/ipv6/icmp.c
> >      net/ipv6/route.c

=2E..

> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 64e873f5895f..51c6cdae8723 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -6447,14 +6447,19 @@ struct ctl_table * __net_init ipv6_route_sysctl=
_init(struct net *net)
> >   		table[8].data =3D &net->ipv6.sysctl.ip6_rt_min_advmss;
> >   		table[9].data =3D &net->ipv6.sysctl.ip6_rt_gc_min_interval;
> >   		table[10].data =3D &net->ipv6.sysctl.skip_notify_on_dev_down;
> > -
> > -		/* Don't export sysctls to unprivileged users */
> > -		if (net->user_ns !=3D &init_user_ns)
> > -			table[1].procname =3D NULL;
Here I remove the setting of the procname to NULL for ipv6 sysctl
registers in route.c and I do not replace that assignment anywhere.
This means that we will export sysctls to unprivilged users for ipv6.
I'll correct this in V3.

> >   	}
> >   	return table;
> >   }
> > +
> > +size_t ipv6_route_sysctl_table_size(struct net *net)
> > +{
> > +	/* Don't export sysctls to unprivileged users */
> > +	if (net->user_ns !=3D &init_user_ns)
> > +		return 0;
> > +
> > +	return ARRAY_SIZE(ipv6_route_table_template);
> > +}
> >   #endif
> >   static int __net_init ip6_route_net_init(struct net *net)

--=20

Joel Granados

--ry2jlv6i2gzplzus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTSXfgACgkQupfNUreW
QU9uhwv/YNoyTbkHH/5RMLpQdKDepd7w6f8Rtax3cD35VYfVbj2aNFy9lcELq0sL
WWEkcnq1tZav3I+it4as5M7BUfGePS1Zj/D2OYSS7sR0ehwJMaO19qvfuGLiQLP9
XQe6cyy071sk9U5fxmpZkZgfKtldzchYMt1GluPzw0/a1CRkUlQqaDkHS0/hiOAn
JCY8mDLWC5DZwVZjz1Ai3UZ3lSIoxFqZbIk8IWpB6E6r9j+ulQUBw6CnYpSu8HMg
JNHA2wqyYaNLKxwQzSDhG3E0AaK59dPzneyrLVRnpJhc4yMFY+yDSPAzAZTgr1Ny
+/lASH2c7d0obmafitPwIOhxg7xPPnp+AYKDP65ZMGp0olUCNYKqUhF0Mc8sWq75
1kzOSul2jqUCTCkODYWut1aoqApizX5phuRCj/wCorVWBazLV7J9fDNopmAtmTYY
MKPmbbgWQdQHKDCEN7aSL5GGY51bp1dl4M0G+rkmW3RXRPl1OJLTsxP6Vk7ZizpE
4CYHvD9R
=8NUh
-----END PGP SIGNATURE-----

--ry2jlv6i2gzplzus--
