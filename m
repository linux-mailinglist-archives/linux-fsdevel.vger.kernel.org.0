Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A5774045D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjF0UN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0UN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:13:57 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70A5EEC;
        Tue, 27 Jun 2023 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687896832;
        bh=5fj+aKtR/0xTpDPBRehCGeZG80FPrHqm744L4NKx61Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAy6409UDeyTZbi1+PPdhH7Cbt6hIQBorjVwUIBb4A1l6DIzO0GAuNosPpBMsn3FE
         6SWFg+TAnExf0XqwbAXT0XPqfO/fqBDSMOKG0aRoXnarpspYAugUOPyezHCLkUCN/4
         er2IglrfluhQ8vCcL3uXsRq+xoUhqwOusfDZCU/YKF3jiwkV4m2m89scWVt5YllHyl
         7Vj2IPDDWk6hAbcALtoNtGaMNfmKo23OnkChLxYm6hSqblewSLzAuIhXFozU7aFABk
         /A8/4nCsn/MkWxBj1BDSk9peq9+QwUIprqThrJWnfk67yMuR7ixlOB0yjY760YlxW9
         xOeUtoNzCCEBA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 18901FD2;
        Tue, 27 Jun 2023 22:13:52 +0200 (CEST)
Date:   Tue, 27 Jun 2023 22:13:50 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
Subject: Re: [PATCH v3 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
Message-ID: <7mlwx7lqzzyrqwqu3kcgnhxgittvmz44d3dlcfaifpnljsuxa2@25c7ypaofxy5>
References: <CAOQ4uxh7i_s4R9pFJPENALdWGG5-dDhqPLEUXuJqSoHraktFiA@mail.gmail.com>
 <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
 <8827a512f0974b9f261887d344c3b1ffde7b21e5.1687884031.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxj3j7gMJSojkdfe+8fQrKtJtY7wBY1UOHtQUuQ_WMjObA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ce2iow2ofqkwpkza"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj3j7gMJSojkdfe+8fQrKtJtY7wBY1UOHtQUuQ_WMjObA@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ce2iow2ofqkwpkza
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 09:10:09PM +0300, Amir Goldstein wrote:
> On Tue, Jun 27, 2023 at 7:55=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > @@ -1209,18 +1204,20 @@ long do_splice(struct file *in, loff_t *off_in,=
 struct file *out,
> >
> >                 ret =3D splice_file_to_pipe(in, opipe, &offset, len, fl=
ags);
> >
> > -               if (ret > 0)
> > -                       fsnotify_access(in);
> > -
> >                 if (!off_in)
> >                         in->f_pos =3D offset;
> >                 else
> >                         *off_in =3D offset;
> > +       } else
> > +               return -EINVAL;
> >
> > -               return ret;
> > -       }
> > +       if (ret > 0)
> > +               fsnotify_modify(out);
> > +noaccessout:
> > +       if (ret > 0)
> > +               fsnotify_access(in);
> >
> As I wrote, I don't like this special case.
> I prefer that we generate double IN_MODIFY than
> having to maintain unreadable code.
>=20
> Let's see what Jan has to say about this.
Yes, in principle I definitely agree, but I don't know what the official
policy is on (effectively-)spurious/duplicate events; neither the kernel
documentation nor the manual speak to the reliability of the signal,
so I defaulted to the variant I thought to be correcter, if filthy.

--ce2iow2ofqkwpkza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbQvwACgkQvP0LAY0m
WPETrw/9HfNjWhc7Hwe9aHhIbg8/d9O+5ZBDJodQ93VLag+meztr2ukhARYpGkDE
Mwd4Vmrk8BzBx0Wq9tp/EL9zXOHmZmPdMPorLwZnDDXELb9KJ1lxBpi0/qa+Ui3O
vkSfzFeOSmQ9sxr5djYUHgzFzxSUMsWKw8Hwul6F78I/4DehePqHPQns2Wzv2YMn
jfW8s9Ffdr7fU4NPW2PrVS6eM0iaioU+51OovJdryLVqOy8q6wYKdmNEGqGkYhLs
JFYJpmLwk8PoW+aIUtBKqYQo+ppAiMVIKKieWGVz75/aelXuOBEmUiVRiHFswoR6
P81/WwKEcqNXtT1QzdF76jOvPv4RULJx7xFwIzIESK9KctHFrJu6kl82rwkzwu3m
D9//2+/rJjSGbyJ1V9bYpFVypf7EPTD60d3RfhMAc2x32OxUZutvCj10A5B2GqfC
7Y+brp48WK3gsivFcXTq07/085oDc9aiInUB92Uji8VjE6WViEEwedpoWofuaxSX
sbLgQStQ0qSpmvlE4wIPWvUqei1vknEmJ4JJ0GB5t8rmr2qb2/NthR5glcvO8HS4
YrmYiLzDIiN/BEjro4zJ/rFTXJ4hIHE1UlTwof3qG4frlR2tugP0lNDwj0AKkwdM
vTjiyjhQv5KAzIAfHUCjow7D52HbkapBgFevOv3o/0pBXfHnmEk=
=3G9b
-----END PGP SIGNATURE-----

--ce2iow2ofqkwpkza--
