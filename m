Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3177C41C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 01:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjHNX7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 19:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjHNX6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:58:39 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74E124;
        Mon, 14 Aug 2023 16:58:37 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RPrvX424qz9sSC;
        Tue, 15 Aug 2023 01:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692057512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFNmrJDz8TQ/FKyloniYJQAduWfeMEx12U9NOZfx3Ec=;
        b=SsAV21Eymk9wDD+NTR5KClddjZ2x7XBUiOYXrQDQN6S0AjNZmwH4zcifubmG0RIrBk5CsA
        lN/GnzWNshWG8b/q3ePdQi2NzOsWp6ywfQttGlHr29ph6PWfBLY1THera+wk6jkJ9v9CeF
        KHcbS+bWjw+MFgJTLIEOqSOqso3A9D76E789ZDpgkhdnYFk7qYVmzAwTO4wTWgUWR4+VjX
        LL9niOQDGqjaacsMeUx51owNa1K5AA+14CSKKapcpTRwIYc366GFEzhUDMblJkwp9OWKpC
        xtVrWGqet63zsATq/gdBXcsSDSgreBrNkSXpETOmCiUtpMUEp/vFd0BfSE8WKw==
Date:   Tue, 15 Aug 2023 09:58:21 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/3] fs: Allow user to lock mount attributes with
 mount_setattr
Message-ID: <20230814.234005-ex.alehouse.beloved.favors-mztNlauDk2zk@cyphar.com>
References: <20230810090044.1252084-1-sargun@sargun.me>
 <20230810090044.1252084-2-sargun@sargun.me>
 <20230811.020617-buttery.agate.grand.surgery-EoCrXfehGJ8@cyphar.com>
 <CAMp4zn-YfP1Bs_S4B55cbAtkbOg8Do1UK1tVe6K1a2-Bxprx-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bok4357k4bf6h43u"
Content-Disposition: inline
In-Reply-To: <CAMp4zn-YfP1Bs_S4B55cbAtkbOg8Do1UK1tVe6K1a2-Bxprx-Q@mail.gmail.com>
X-Rspamd-Queue-Id: 4RPrvX424qz9sSC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--bok4357k4bf6h43u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-08-14, Sargun Dhillon <sargun@sargun.me> wrote:
> On Sun, Aug 13, 2023 at 10:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> >
> > It just occurred to me that the whole MNT_LOCK_* machinery has the
> > unfortunate consequence of restricting the host root user from being
> > able to modify the locked flags. Since this change will let you do this
> > without creating a userns, do we want to make can_change_locked_flags()
> > do capable(CAP_SYS_MOUNT)?
> >
> Doesn't mount_setattr already require that the user has CAP_SYS_ADMIN
> in the mount's user namespace?
>=20
> I'm not sure how this lets us bypass that.
>=20
> Or are you saying we should check for
> CAP_SYS_MOUNT && CAP_SYS_ADMIN?

I was talking about the fact that can_change_locked_flags() doesn't have
an escape catch for capable(CAP_SYS_whatever). But as I mentioned in a
later mail, this might be safe but it would have other downsides.

> > > +             if ((new_mount_flags & kattr->attr_lock) !=3D kattr->at=
tr_lock) {
> > > +                     err =3D -EINVAL;
> > > +                     break;
> > > +             }
> >
> > Since the MNT_LOCK_* flags are invisible to userspace, it seems more
> > reasonable to have the attr_lock set be added to the existing set rather
> > than requiring userspace to pass the same set of flags.
> >
> IMHO, it's nice to be able to use the existing set of flags. I don't mind
> adding new flags though.

This was related to the later paragraph. I agree passing the existing
MOUNT_ATTR_* flags to attr_lock is preferable.

> > Actually, AFAICS this implementation breaks backwards compatibility
> > because with this change you now need to pass MNT_LOCK_* flags if
> > operating on a mount that has locks applied already. So existing
> > programs (which have .attr_lock=3D0) will start getting -EINVAL when
> > operating on mounts with locked flags (such as those locked in the
> > userns case). Or am I missing something?
> I don't think so, because if attr_lock is 0, then
> new_mount_flags & kattr->attr_lock is 0. kattr->attr_lock is only
> flags to *newly lock*, and doesn't inherit the set of current locks.

Ah, I misread this (I was confused why this check was needed which made
me think it must be checking something else, but looking at it again,
the check is actually making sure that if you lock a flag that the flag
is also set) -- in that case the behaviour is exactly what I was
describing. Oops!

> > In any case, the most reasonable behaviour would be to OR the requested
> > lock flags with the existing ones IMHO.
> >
> I can append this to the mount_attr_do_lock test in the next patch, and it
> lets me flip the NOSUID bit on and off without attr_lock being set, unless
> you're referring to something else.

The behaviour I was talking about was:

memset(&attr, 0, sizeof(attr));
attr.attr_set =3D attr.attr_lock =3D MOUNT_ATTR_NOSUID;
ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);

memset(&attr, 0, sizeof(attr));
attr.attr_set =3D attr.attr_lock =3D MOUNT_ATTR_NOEXEC;
ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0); // s=
hould work

/* mount should have MOUNT_ATTR_NOSUID|MOUNT_ATTR_NOEXEC now */

(Which is what the current implementation should do.)

> You shouldn't be able to attr_clr a locked attribute (even as
> CAP_SYS_ADMIN in the init_user_ns).

This is what I was referring to in the escape hatch bit above (whether
we should allow this).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--bok4357k4bf6h43u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZNq/mAAKCRAol/rSt+lE
by/gAQDd85F/zO8FlOcNeDJB3M+T2GLEptrAlE2Aqoeu06sTAAEAyiLHYJFUBMgP
mFNiIkveFIM9WpJBDzC/3tAzR8BTdwE=
=ab0g
-----END PGP SIGNATURE-----

--bok4357k4bf6h43u--
