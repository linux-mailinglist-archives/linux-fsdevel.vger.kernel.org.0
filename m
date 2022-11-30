Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36C763D5D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 13:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiK3Mnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 07:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiK3Mno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:43:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CA4B753;
        Wed, 30 Nov 2022 04:43:43 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z17so11899292pff.1;
        Wed, 30 Nov 2022 04:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SYFP0szIO4uQWosjf/DBeQUEddgh/eJCRxGlHyoP1o=;
        b=lGFEahgyoDkFfO4MTJBxV+WDKKjYFLDSWD9cIm+boSkjj2uoMWRWiQcNtpl/TOm5rK
         sSHEv/glh5oOTksk41RVezXagw6jbuZ40TXl7NEnFNYManHa/w1R71xZZI36J4lX25UM
         cbcUfD4gneaUwM4QD+SBL6cBzhU+wznPmwiJK9DMF2KXg2dr+bRBElQibmy510sUXU9m
         PDGF6zV6GJt6ZojTKhrgyy9u/iQhayTWSqnd1UbNFjJ59iUnn8gey849SPnDD1NkqUem
         y+2zRdZvWk7CPIYegPztuRmyowZwiKIAvxOhInYXosz5F72MggNoCosSPckKf+1f0vF1
         S69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SYFP0szIO4uQWosjf/DBeQUEddgh/eJCRxGlHyoP1o=;
        b=x6FeW+M2RH1uyFt2ru45iPSctMNc2R3/x/JKx0QXAc7HUhsVS+RhlFg2BKJCALJHk0
         b4O+tearRIn3s+Ezl/HrIi0sZU/2KCqvyST6ZiSFgetElmvR6F1yZZCwMr2n+QzUumrI
         dEYuVpy0DxE9FAGD98MqiiWCYIvUNyYZs3tE9p6TKjUWrGIQB6DelMk1lck9AugA+lgT
         g7j0wDR7xH0Uu8Kk0mJmyk/lv0kWVMre14SSgzCwG9a57uBPQypAps9kPunBpZMSSDJO
         Wha0QcL2f5trkUklwhCg8bBiPT6O+kLVkOHEUtAAK3XGuLQFr+XfWixK31uin0bj8CFx
         i5XA==
X-Gm-Message-State: ANoB5pkfUwBPXuH1Bqk+YNNeundu6DJc03Z5Kj6bmo8iJaPHH97r/oe5
        833JW589frlhvvcNjLMffy4=
X-Google-Smtp-Source: AA0mqf6gJ2VDhQCzPJjGyRfnk3iFdVRCTTJb/bbVvhipQMA64yPolrxBfQn0+QAJf7edKJ9vxrG42g==
X-Received: by 2002:aa7:9416:0:b0:575:518e:dc11 with SMTP id x22-20020aa79416000000b00575518edc11mr11919945pfo.86.1669812223326;
        Wed, 30 Nov 2022 04:43:43 -0800 (PST)
Received: from debian.me (subs02-180-214-232-85.three.co.id. [180.214.232.85])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b00186b8752a78sm1374421pla.80.2022.11.30.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 04:43:42 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 492AB103FF3; Wed, 30 Nov 2022 19:43:39 +0700 (WIB)
Date:   Wed, 30 Nov 2022 19:43:39 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tao pilgrim <pilgrimtao@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, cgel.zte@gmail.com,
        ran.xiaokai@zte.com.cn, viro@zeniv.linux.org.uk,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        Liam.Howlett@oracle.com, chengzhihao1@huawei.com,
        haolee.swjtu@gmail.com, yuzhao@google.com, willy@infradead.org,
        vasily.averin@linux.dev, vbabka@suse.cz, surenb@google.com,
        sfr@canb.auug.org.au, mcgrof@kernel.org, sujiaxun@uniontech.com,
        feng.tang@intel.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chengkaitao@didiglobal.com
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Message-ID: <Y4dP+3VEYl/YUfK1@debian.me>
References: <20221130070158.44221-1-chengkaitao@didiglobal.com>
 <fd28321c-5f00-ba94-daed-2b8da2292c1f@gmail.com>
 <CAAWJmAYPUK+1GBS0R460pDvDKrLr9zs_X2LT2yQTP_85kND5Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U2At7WgeybTkF08j"
Content-Disposition: inline
In-Reply-To: <CAAWJmAYPUK+1GBS0R460pDvDKrLr9zs_X2LT2yQTP_85kND5Ew@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--U2At7WgeybTkF08j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 07:33:01PM +0800, Tao pilgrim wrote:
> On Wed, Nov 30, 2022 at 4:41 PM Bagas Sanjaya <bagasdotme@gmail.com> wrot=
e:
> >
> > On 11/30/22 14:01, chengkaitao wrote:
> > > From: chengkaitao <pilgrimtao@gmail.com>
> > >
> >
> > Yikes! Another patch from ZTE guys.
> >
> > I'm suspicious to patches sent from them due to bad reputation with
> > kernel development community. First, they sent all patches via
> > cgel.zte@gmail.com (listed in Cc) but Greg can't sure these are really
> > sent from them ([1] & [2]). Then they tried to workaround by sending
> > from their personal Gmail accounts, again with same response from him
> > [3]. And finally they sent spoofed emails (as he pointed out in [4]) -
> > they pretend to send from ZTE domain but actually sent from their
> > different domain (see raw message and look for X-Google-Original-From:
> > header.
>=20
> Hi Bagas Sanjaya,
>=20
> I'm not an employee of ZTE, just an ordinary developer. I really don't kn=
ow
> all the details about community and ZTE, The reason why I cc cgel.zte@gma=
il.com
> is because the output of the script <get_maintainer.pl> has the
> address <cgel.zte@gmail.com>.
>=20
> If there is any error in the format of the email, I will try my best
> to correct it.
>=20

OK, thanks for clarification. At first I thought you were ZTE guys.
Sorry for inconvenience.

Now I ask: why do your email seem spoofed (sending from your gmail
account but there is extra gmail-specific header that makes you like
"sending" from your corporate email address? Wouldn't it be nice (and
appropriate) if you can send and receive email with the latter address
instead?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U2At7WgeybTkF08j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4dP9QAKCRD2uYlJVVFO
o2fFAP9CcwtLbXBJc0AgmMHIUvGNiyhA9iDVaDQGg5tezc3siAD+MdwAl/MqnXUT
o9/M5ZNbB5lgA8Gdug0py/N/VDy0TQc=
=RwhN
-----END PGP SIGNATURE-----

--U2At7WgeybTkF08j--
