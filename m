Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587F76AE53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 11:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjHAJiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjHAJhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:37:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96FF1BD9;
        Tue,  1 Aug 2023 02:35:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31297125334so3670523f8f.0;
        Tue, 01 Aug 2023 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690882558; x=1691487358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvT5J/1PJpb72S8f2nh5awbFCHxyuUpdf923ik/K8j4=;
        b=ExXgh7eFyYEhKQs65FHri/ViJcpb8MfKCX9kbY13ZsJxBfJuzrlXbGUOa6PJHRnfVL
         5KktONa25XH2j439bmJpT0Q4yTjYmX4D0DiBC4baDGrA30FHudWESCVxKcX9ypBipHeM
         SQep1J2NOOI4y6MR1DOFPz5PzuY+E3qQVzADtwAIobtemnENQgZGsUJnpi/joyh4WivY
         LIlCKOUJEek89CNVl+TOnj477K/qps7R9Z8rmn8+cL4kkeZWcXXI6KXXgTaf/3PYTlrh
         pg5N0MEigdMBUTHFqQA2OwiMPdbJ/RuZNlJ9em5VweXgkSGFnwmWM0zlA01zCeSuodhm
         IVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882558; x=1691487358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvT5J/1PJpb72S8f2nh5awbFCHxyuUpdf923ik/K8j4=;
        b=F92qiyd2ELRgN0C9Eqo0eeM6vKTrICn4XmoijAWyEoQuQNNBrYt5M0qDe75la1KrpA
         kGUaFyKXnMeBS1lV3K3tT3Jo44uDxScFIzOVipqL5bzkZjO4g1/Jvgm5r6PtBbvZGpBT
         rQo26uMD3DB1P3sgfZmENXsA0sCCUhHhfib6+4UOGxwd41+gKfs/G113vJrsZNwH63ev
         etI9JvaJJLGBA5Ud8DEMCN4EZUL95PeS8MEDpuwGTjbJai074sXn90UCiZUyHoD/YVFu
         cac4BZXifnjB5VxJHQtp4MZoxQ9D/ueu/xrQMI43orgJP4SxxC2GKnAkCKD5+TJP75Q0
         csHg==
X-Gm-Message-State: ABy/qLav90cpuWyUPIT+1eJucyRIfRKYtX/gjbqvvqQHsVAJC6bWGhG8
        ufcGc9httUC6C/E201vQshg=
X-Google-Smtp-Source: APBJJlFenT4lJzl0wyFu60kMYJMIoCsq+b5HauhGzk/5vhq31BmGRtO2EgfwE19ne+ER5DzuG/6KpA==
X-Received: by 2002:a5d:6b8c:0:b0:30a:c681:fd2e with SMTP id n12-20020a5d6b8c000000b0030ac681fd2emr1793379wrx.22.1690882557942;
        Tue, 01 Aug 2023 02:35:57 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d68d0000000b003140f47224csm15519172wrw.15.2023.08.01.02.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:35:57 -0700 (PDT)
Date:   Tue, 1 Aug 2023 11:35:55 +0200
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
Message-ID: <20230801093555.wwl27a7wjm2oinxx@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <CGME20230731213734eucas1p2728233a3b9ecd360bbd0cb77f8a44002@eucas1p2.samsung.com>
 <ZMgpck0rjqHR74sl@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltg4mtomzaz4i2ki"
Content-Disposition: inline
In-Reply-To: <ZMgpck0rjqHR74sl@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ltg4mtomzaz4i2ki
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 02:36:50PM -0700, Luis Chamberlain wrote:
> > Joel Granados (14):
> >   sysctl: Prefer ctl_table_header in proc_sysctl
> >   sysctl: Use ctl_table_header in list_for_each_table_entry
> >   sysctl: Add ctl_table_size to ctl_table_header
> >   sysctl: Add size argument to init_header
> >   sysctl: Add a size arg to __register_sysctl_table
> >   sysctl: Add size to register_sysctl
> >   sysctl: Add size arg to __register_sysctl_init
>=20
> This is looking great thanks, I've taken the first 7 patches above
> to sysctl-next to get more exposure / testing and since we're already
> on rc4.
Thx for the feedback.

>=20
> Since the below patches involve more networking I'll wait to get
> more feedback from networking folks before merging them.
Just FYI, these are all networking except for the last one. That one is
actually just in sysctl and will set everything up for removing the
sentinels.

>=20
> >   sysctl: Add size to register_net_sysctl function
> >   ax.25: Update to register_net_sysctl_sz
> >   netfilter: Update to register_net_sysctl_sz
> >   networking: Update to register_net_sysctl_sz
> >   vrf: Update to register_net_sysctl_sz
> >   sysctl: SIZE_MAX->ARRAY_SIZE in register_net_sysctl
> >   sysctl: Use ctl_table_size as stopping criteria for list macro
>=20
>   Luis

--=20

Joel Granados

--ltg4mtomzaz4i2ki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI0fkACgkQupfNUreW
QU/TKwv3ZwfCMFKh+tMOXHzAsW3p+jp8IR2frQvlCy8j4amsnTB8wJmsjkpeuJ3p
s6IFeYrPE0pDidKOwzYiA4JDZdYDgF1hevrQAuqDsLkKBHzW0Cr6dt21CIQx9uZR
RwhONU/JHoW6MKmO2PlcOiSQiRAhX/OvUhtCgQPTbff3fT6EAu9twn0vfWcyy+H0
mn6LM2go/DW2cgdm4oa1U+DqwpJiGCabLbQNfPa8Vx8g7CK2y2Azd5/obW6ryOxe
QDPdmQdVjytDnDHSW2AEYe2bDympPHaaoDU79e4FPVXC15+UAgF+/ExfDUVq6ek4
FG5Gjh7ev+i6vPYAUR4AuPtB3hwH+vDsSE6Vcd37iKn/mjg1fi0DHx7Wz1Be/n1o
8iSbL0N6an0fzzKlOdfwQs1bytw+ssWZtxLIQ3MUhHvwj882OXkYCBRW4Aycgop7
/H+zOm0K2Yluph2h+5qmhjkzUlTx2MNwfSs34wsvBNsbb1MGZQouIAAQowb+mTzS
31kDDA8=
=shIJ
-----END PGP SIGNATURE-----

--ltg4mtomzaz4i2ki--
