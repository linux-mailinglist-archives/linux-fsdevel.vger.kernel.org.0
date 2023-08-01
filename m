Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912076B031
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 12:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjHAKBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 06:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjHAKBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:01:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD3E10B;
        Tue,  1 Aug 2023 03:01:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so4085166e87.0;
        Tue, 01 Aug 2023 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690884073; x=1691488873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8Rmj6mejjDyMq10/c5ElVqxfT4Jc8y7fVBUerEHAFQ=;
        b=JYH38BiZyDWL0KXmQnng4sthQhdeV3NJBHfNi+ky1KBbpG9nVv/fbbULdTOLHrIkRc
         m+cW5Nuo1qJ+ZY/CEFkGrU+LjmOwtRZV5FZbO5P7+OM1zKnHgMDf1oBLHOA+NceI85gx
         JkZ47KaVpN9ZBvR6FoyVYB0FbHi8KbwxzoilvQtwUB2ij/UJya1TAMXC2C3UOm6p174z
         S6sbKiiIslls7win2DAPno+jCbJ72BXV6csVG9rjzIDvaWKjNZk+kKpKl91dwFSz63UN
         EHa/G4niaq852Xz2iz+Bde3Ap6qEvx6ZrdIxP94qmNM5EajZm2Xvu5/MSgK9i/6QI6uE
         Ds1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884073; x=1691488873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8Rmj6mejjDyMq10/c5ElVqxfT4Jc8y7fVBUerEHAFQ=;
        b=CdHKzyr2VzVLhc7SPWGBJa1FWqybGvl39lgy5Gn32IbW3E3V7WahP7CvU/mGNrAgRH
         /zVebl7ORKLpT/E4hwLfshilFZF15Wf3qv9/aO2K5zIm16Dqr/QxFap515HmhqHC69dl
         wwRl6WL09m8hfUIgEh9Q8Tbq9Nt7DYiMd/F64twVmFlKBGzSEv6ci5aP9t9+ipuDA1wG
         lq3Q2u0sLgZOWuqYfKQIGMvxxAZZyj2/uuMRpnhu6aVrqlJ6//w8GqOqFB5/FyCBaqIW
         75naEhj5fge+XXQCDBTBWQsEv5Qlw+b+enKGViUFA7sHz/ihTljGgaNkQqdMi/J/xkKW
         T+Xg==
X-Gm-Message-State: ABy/qLY7lpyexsBxLukK2X/8TawyNI2SaX2lzgD0M7bqTWinYT0qUstt
        1RbJpCc54BBGCi86e4EJECA=
X-Google-Smtp-Source: APBJJlGhgKLwVApJiPoxJUiIuyS5KDw4uVrCOBzzVEwDynYHPSZXT5p7yB71zUjSFqNFlY26YLaTpA==
X-Received: by 2002:ac2:43b7:0:b0:4fd:fef7:95ae with SMTP id t23-20020ac243b7000000b004fdfef795aemr1664853lfl.9.1690884071826;
        Tue, 01 Aug 2023 03:01:11 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004fe09920fe5sm2512701lfk.47.2023.08.01.03.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:01:11 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:01:09 +0200
From:   Joel Granados <joel.granados@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v2 00/14] sysctl: Add a size argument to register
 functions in sysctl
Message-ID: <20230801100109.ospf2gwsdewhhwzn@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <CGME20230731205134eucas1p1403a137418fcdaaaf78890de88d4a958@eucas1p1.samsung.com>
 <ZMgeoDT0t3NeALM0@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g6vdqxyc5hdpujuz"
Content-Disposition: inline
In-Reply-To: <ZMgeoDT0t3NeALM0@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--g6vdqxyc5hdpujuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 01:50:40PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 31, 2023 at 09:17:14AM +0200, Joel Granados wrote:
> > Why?
>=20
> It would be easier to read if the what went before the why.
haha. I totally misunderstood you in
lore.kernel.org/all/ZMFizKFkVxUFtSqa@bombadil.infradead.org I thought
you meant to put the why first. I'll switch it back to having the what
first for V3

>=20
> > This is a preparation patch set that will make it easier for us to apply
> > subsequent patches that will remove the sentinel element (last empty el=
ement)
> > in the ctl_table arrays.
> >=20
> > In itself, it does not remove any sentinels but it is needed to bring a=
ll the
> > advantages of the removal to fruition which is to help reduce the overa=
ll build
> > time size of the kernel and run time memory bloat by about ~64 bytes per
> > sentinel.
>=20
> s/sentinel/declared ctl array
>=20
> Because the you're suggesting we want to remove the sentinel but we
> want to help the patch reviewer know that a sentil is required per
> declared ctl array.
Ack

>=20
> You can also mention here briefly that this helps ensure that future move=
s of
> sysctl arrays out from kernel/sysctl.c to their own subsystem won't
> penalize in enlarging the kernel build size or run time memory consumptio=
n.
I worked it in

Thx for the review
>=20
> Thanks for spinning this up again!
>=20
>   Luis

--=20

Joel Granados

--g6vdqxyc5hdpujuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI1+QACgkQupfNUreW
QU/tvQv8DSOiRBrGHskMVKuasQMrQO4cj/zOagQExBMcJnGj7M+jr4pvCvBo1Rce
fRZBBVfKDjeV4svmqKus54sNM27JPAJALJlnePPgsBqhuOeL6kKLSsCDyDv6bKOS
e0J6ZLE6EAqudCJqsxjGkPNEalpooX1Ip9OQqdPQxyfoSdDZQcKucP/rPx+Q4yzy
lKv9SqcK/1j7q8fMkiucrjwQF2woB16q6iXZmokZTt7vTX0rSfKFJ8isQOgimpll
Xv+hxQaRZEueIIc45dAL7MRYn/zukf8rExbIRNXCtUCsyfJxcdo6V0ubKfMAj/u3
X2J5FIUpf1ua/QX0idONlXIXU1kOWnFapnBPprKBKuBhO6xwSnrQhxgt7aKbbDGl
dBwWRbN59m3q7jrz17McOb+LjfA5ZMcs3K58bfg0PnrugQZA537GFL19es1dAssc
fy06XeNWXeUhvCjgQW53D2twqvhAhY4WU1D4sbV+8xwQihB416Zkc+ReqQs2cS6Y
zhTPrhl+
=F1x8
-----END PGP SIGNATURE-----

--g6vdqxyc5hdpujuz--
