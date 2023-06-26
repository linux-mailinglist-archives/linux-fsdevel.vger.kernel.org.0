Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DC873DFE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjFZM6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZM6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:58:00 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40E45125;
        Mon, 26 Jun 2023 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687784276;
        bh=A/60Mehy2gEPdHOhKuvb29K5E/lHwYktVCiUO81YhVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTzf/tAqpNxj+m/LGdIioFeXMgVqZJt5PqcFowaip6qE56AjZmzNwx7fLtFHQvy9f
         5Om84sinbt4mZPHgy6coGdlGgupO64W6VLgoQ1kaYcadRlfw8GJi7dZM1dNFTDGCVC
         qBKLiB6hXx8+0tyNrIQLmtWR31mPFzLOeyTcXaUkFWumiDSXPOE0GbwhEHk0fjbbKI
         TSNAK9Heaqf0rzBHjoCWTZC8VcmR6tXx9PjHwW5j+HsjjJK+1vRFFMgxfQk5FURUbd
         cM1mciolye4Aam3k1WOipDJJe/kjD5BX/DvtfFApB+hmNebRsUsAjLuR8RVoEX72Jd
         8Ufe9xI9r71JA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6C49D131C;
        Mon, 26 Jun 2023 14:57:56 +0200 (CEST)
Date:   Mon, 26 Jun 2023 14:57:55 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
Message-ID: <vlzqpije6ltf2jga7btkccraxxnucxrcsqbskdnk6s2sarkitb@5huvtml62a5c>
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ekt4xsobei4itlj7"
Content-Disposition: inline
In-Reply-To: <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ekt4xsobei4itlj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 02:19:42PM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > splice(2) differentiates three different cases:
> >         if (ipipe && opipe) {
> > ...
> >         if (ipipe) {
> > ...
> >         if (opipe) {
> > ...
> >=20
> > IN_ACCESS will only be generated for non-pipe input
> > IN_MODIFY will only be generated for non-pipe output
> >
> > Similarly FAN_ACCESS_PERM fanotify permission events
> > will only be generated for non-pipe input.
Sorry, I must've misunderstood this as "splicing to a pipe generates
*ACCESS". Testing reveals this is not the case. So is it really true
that the only way to poll a pipe is a sleep()/read(O_NONBLOCK) loop?

--ekt4xsobei4itlj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZi1AACgkQvP0LAY0m
WPHojQ/8Dca03RA9GygaCJ8mDUbT+U/Gqnugp+zljoVBLoiichVLnHP+K80x4mpZ
IYARMuM4jpDGmaxr/W806OQRi/Sx63PiqDG0FrLGafyrJzUZrvaoYRZ3A7m/tRaV
hVpJeSOiaeJ4wJo9Z1J7RxCOS9JrrPF3gHdWPza9Hn80pJJDLKO1bPOgJC5vjwQO
ECrzB1IHa+hqTqrxcM+ZDI72VVvlhPkZnzmwkeHduGVRBJNquaZxTZf+BIfA4NLO
wFLFB+4VCP3ZLA2GePQMIEVbUyqI8ue7PG039Vs1UTl94aRE0liQcYqajEoeuliu
YPB8WrzYyNYMKpTTQgETnW8/iBiEJhl3sqNHJD3EBeCih/N8eZs/WRDYtUtj8lqz
cMiJTxmUDPxBUhnSpV+/pe7uz3A/QDNb+V/y13DIixxYy8YLjbdUzec4diGc1nmV
Oo6+w4fFwZz6zICyTqwwTOr245iITKSTgBGxyCUlm+7XwApJKygiC4XjeXec9x4X
QTnrUKBhfmD1eXXcm/FlpF7rLwUXmMjwHWAwWXZrpwozV4ghot6hCJsV8pSJ8ufE
p9jViAjpUm+ogkQif51mbmqWqYoTpzRur7TL71XeoxVAk7tlba+rlkyCxMNCHMa6
587F/RtRIvw1JzBxyRpF3vcWgGQpl9Pm8Udcd+Hjk9D76t4EQQY=
=ZCkQ
-----END PGP SIGNATURE-----

--ekt4xsobei4itlj7--
