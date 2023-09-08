Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6F7986A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbjIHL7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbjIHL7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:59:30 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A019BC;
        Fri,  8 Sep 2023 04:59:25 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E07661C0019; Fri,  8 Sep 2023 13:59:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1694174362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgszQD84t0zWFYtdlm4co33mPCbsZOXmieVbxsc8Tu0=;
        b=KQJ4R4+KQNuGIamlwHNZfjp2dSVDBl+R6ONq5VGA9+welTSi2VRQYjEDUl8tW1XFSrGwTy
        c2Oh41Uvh6ViJZfc9q4RpM9Cj62ySxO78pNrhkQYp3/wUpIdBYEEzh+6x+UJ2FJfHBXwEq
        GekWoxjSfU/nA2a3b19axQx2jFgDC+E=
Date:   Fri, 8 Sep 2023 13:59:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] fix writing to the filesystem after unmount
Message-ID: <ZPsMmjFXGFmdRP+d@duo.ucw.cz>
References: <59b54cc3-b98b-aff9-14fc-dc25c61111c6@redhat.com>
 <20230906-launenhaft-kinder-118ea59706c8@brauner>
 <f5d63867-5b3e-294b-d1f5-a128817cfc7@redhat.com>
 <20230906-aufheben-hagel-9925501b7822@brauner>
 <60f244be-803b-fa70-665e-b5cba15212e@redhat.com>
 <20230906-aufkam-bareinlage-6e7d06d58e90@brauner>
 <818a3cc0-c17b-22c0-4413-252dfb579cca@redhat.com>
 <20230907094457.vcvmixi23dk3pzqe@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="VV/11Z1/4RYJMo7q"
Content-Disposition: inline
In-Reply-To: <20230907094457.vcvmixi23dk3pzqe@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--VV/11Z1/4RYJMo7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2023-09-07 11:44:57, Jan Kara wrote:
> On Wed 06-09-23 18:52:39, Mikulas Patocka wrote:
> > On Wed, 6 Sep 2023, Christian Brauner wrote:
> > > On Wed, Sep 06, 2023 at 06:01:06PM +0200, Mikulas Patocka wrote:
> > > > > > BTW. what do you think that unmount of a frozen filesystem shou=
ld properly=20
> > > > > > do? Fail with -EBUSY? Or, unfreeze the filesystem and unmount i=
t? Or=20
> > > > > > something else?
> > > > >=20
> > > > > In my opinion we should refuse to unmount frozen filesystems and =
log an
> > > > > error that the filesystem is frozen. Waiting forever isn't a good=
 idea
> > > > > in my opinion.
> > > >=20
> > > > But lvm may freeze filesystems anytime - so we'd get randomly retur=
ned=20
> > > > errors then.
> > >=20
> > > So? Or you might hang at anytime.
> >=20
> > lvm doesn't keep logical volumes suspended for a prolonged amount of ti=
me.=20
> > It will unfreeze them after it made updates to the dm table and to the=
=20
> > metadata. So, it won't hang forever.
> >=20
> > I think it's better to sleep for a short time in umount than to return =
an=20
> > error.
>=20
> I think we've got too deep down into "how to fix things" but I'm not 100%
> sure what the "bug" actually is. In the initial posting Mikulas writes "t=
he
> kernel writes to the filesystem after unmount successfully returned" - is
> that really such a big issue? Anybody else can open the device and write =
to
> it as well. Or even mount the device again. So userspace that relies on
> this is kind of flaky anyway (and always has been).

Umm. No? I admin my own systems; I'm responsible for my
userspace. Maybe I'm in single user mode.

Noone writes to my block devices without my permissions.

By mount, I give such permission to the kernel. By umount, I take
such permission away.

There's nothing flaky about that. Kernel is simply buggy. Fix it.

[Remember that "you should umount before disconnecting USB devices to
prevent data corruption"? How is that working with kernel writing to
devices after umount?]

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--VV/11Z1/4RYJMo7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZPsMmgAKCRAw5/Bqldv6
8jwpAKCloP9g2vbKKoXzhQ/ur0UU/OPQBQCfYxXaWEstMzVxbkv+WoWbEeYTPxE=
=jKlj
-----END PGP SIGNATURE-----

--VV/11Z1/4RYJMo7q--
