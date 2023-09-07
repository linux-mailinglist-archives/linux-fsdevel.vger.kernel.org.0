Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB26796E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 02:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbjIGAxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIGAxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:53:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC51173B
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:53:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so3142425ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694048020; x=1694652820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKqMMT6dQVSur6i1BdUQMoWm/Up/vHd8uoxCxSDMWpo=;
        b=scWySYS5aP+KadUlneCBjnJfmF+JfziC3ruuqkSpD9wgzJEVeWLQ0pELFtW6zxdOOF
         NxFyHw1DMyA9jTpoT6SOsIOLv6FcyfdXXYln5qJoKpF800iUEM47YnYQOeqAV/exUMZ8
         4ub4U9PF2Vm17ks+Mm8XPr5sMqpBHDXTsS+/WhybPGvXdGMucXdwcZGeHzugSWctmrNS
         3zZfPlzOt5Mx3magRoZyFzuly6nKcTPPUX6u3yECyj50UJzsztKRqxGJFegKF91AzY8t
         Ev9Qp12VIL5iFwvIOYo2W2XvvUagGuMzyDs9ckt/QHSK4LIeG7YV7OtkBSwmCr9gxyJF
         yhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694048020; x=1694652820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKqMMT6dQVSur6i1BdUQMoWm/Up/vHd8uoxCxSDMWpo=;
        b=USbHHoVG6lCWlqDHtOo1Eq42x29uihy9BHRZ1p59F5kDcQKhwY89YjUqRBUQkOaCrp
         WoJbiM7nrhP34KEEWrt2tpS+BLAtUlRskPJIcZ7MsW8TCGtLGNJaC1LolZhEOHElEl1Z
         ktf9Fb+vpLtiD1bfisJRtMNhREggriP+bzbDqqs1C+TCxQDr2uVIapYLeBYfF8Em17LN
         oE5i2VxdG+lp8O/cEBoszEkZjNgDrdm0xcto48hTTXUOwehX/7MSgmoaSzJf280hCG7H
         3Ey3EDaQlOH1i5t8jCTk9jrdP4UDCBnt5VkTBaXD1iee+6AkdG25s0NjmFXX9m+3hHb5
         vwyw==
X-Gm-Message-State: AOJu0YzJQGo1gPMtenUXc6slujAEOht3da7N9lAnoKrgTrnJpfbZaUDt
        3s9qG1TWtGHk3GefojwYVqI=
X-Google-Smtp-Source: AGHT+IEPokvBthHtk0nd3O+Fvk4+fQuL6Be7sVEv5R3vcPOBliUL6a2wfNmmoDh9n6kdZJo8KvVA9Q==
X-Received: by 2002:a17:902:6b86:b0:1bc:25ed:374 with SMTP id p6-20020a1709026b8600b001bc25ed0374mr13486534plk.49.1694048019639;
        Wed, 06 Sep 2023 17:53:39 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902eb0600b001b7f40a8959sm11582737plb.76.2023.09.06.17.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 17:53:39 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 247178EC3A75; Thu,  7 Sep 2023 07:53:36 +0700 (WIB)
Date:   Thu, 7 Sep 2023 07:53:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPkfEFTsBOk3iVuQ@debian.me>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/2KGUKOHTI6vRFRa"
Content-Disposition: inline
In-Reply-To: <ZPkDLp0jyteubQhh@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--/2KGUKOHTI6vRFRa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 08:54:38AM +1000, Dave Chinner wrote:
> There's a bigger policy question around that.
>=20
> I think that if we are going to have filesystems be "community
> maintained" because they have no explicit maintainer, we need some
> kind of standard policy to be applied.
>=20
> I'd argue that the filesystem needs, at minimum, a working mkfs and
> fsck implementation, and that it is supported by fstests so anyone
> changing core infrastructure can simply run fstests against the
> filesystem to smoke test the infrastructure changes they are making.

OK.

>=20
> I'd suggest that syzbot coverage of such filesystems is not desired,
> because nobody is going to be fixing problems related to on-disk
> format verification. All we really care about is that a user can
> read and write to the filesystem without trashing anything.
>=20
> I'd also suggest that we mark filesystem support state via fstype
> flags rather than config options. That way we aren't reliant on
> distros setting config options correctly to include/indicate the
> state of the filesystem implementation. We could also use similar
> flags for indicating deprecation and obsolete state (i.e. pending
> removal) and have code in the high level mount path issue the
> relevant warnings.

Something like xfs v4 format?

>=20
> This method of marking would also allow us to document and implement
> a formal policy for removal of unmaintained and/or obsolete
> filesystems without having to be dependent on distros juggling
> config variables to allow users to continue using deprecated, broken
> and/or obsolete filesystem implementations right up to the point
> where they are removed from the kernel.
>=20
> And let's not forget: removing a filesystem from the kernel is not
> removing end user support for extracting data from old filesystems.
> We have VMs for that - we can run pretty much any kernel ever built
> inside a VM, so users that need to extract data from a really old
> filesystem we no longer support in a modern kernel can simply boot
> up an old distro that did support it and extract the data that way.
>=20
> We need to get away from the idea that we have to support old
> filesystems forever because someone, somewhere might have an old
> disk on the shelf with that filesystem on it and they might plug it
> in one day. If that day ever happens, they can go to the effort of
> booting an era-relevant distro in a VM to extract that data. It
> makes no sense to put an ongoing burden on current development to
> support this sort of rare, niche use case....

This reminds me of me going to a random internet cafe when kids played
popular online games (think of Point Blank), with the computers were
running Windows XP which was almost (and already) EOL, yet these
games still supported it (kudos to game developers).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/2KGUKOHTI6vRFRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPkfDwAKCRD2uYlJVVFO
o1GRAQD1RJ8B8zua+lCxAMfM8owJ9VCSK2cC6RHKeg81aZYkMAEArsRtLwk4rCtk
jFphuj8wxKERZHS5gt1y0glbUxW4sAc=
=zI1E
-----END PGP SIGNATURE-----

--/2KGUKOHTI6vRFRa--
