Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66D148C64E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiALOnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiALOnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:43:46 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD5C06173F;
        Wed, 12 Jan 2022 06:43:44 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JYr0Z2klrzQkBJ;
        Wed, 12 Jan 2022 15:43:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Date:   Thu, 13 Jan 2022 01:43:31 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ptikhomirov@virtuozzo.com, linux-api@vger.kernel.org
Subject: Re: [PATCH] fs/open: add new RESOLVE_EMPTY_PATH flag for openat2
Message-ID: <20220112144331.dpbhi7j2vwutrxyt@senku>
References: <1641978137-754828-1-git-send-email-andrey.zhadchenko@virtuozzo.com>
 <20220112143940.ugj27xzprmptqmr7@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="daan2c3ci5y43vdf"
Content-Disposition: inline
In-Reply-To: <20220112143940.ugj27xzprmptqmr7@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--daan2c3ci5y43vdf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-01-12, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Wed, Jan 12, 2022 at 12:02:17PM +0300, Andrey Zhadchenko wrote:
> > If you have an opened O_PATH file, currently there is no way to re-open
> > it with other flags with openat/openat2. As a workaround it is possible
> > to open it via /proc/self/fd/<X>, however
> > 1) You need to ensure that /proc exists
> > 2) You cannot use O_NOFOLLOW flag
> >=20
> > Both problems may look insignificant, but they are sensitive for CRIU.
>=20
> Not just CRIU. It's also an issue for systemd, LXD, and other users.
> (One old example is where we do need to sometimes stash an O_PATH fd to
> a /dev/pts/ptmx device and to actually perform an open on the device we
> reopen via /proc/<pid>/fd/<nr>.)
>=20
> > First of all, procfs may not be mounted in the namespace where we are
> > restoring the process. Secondly, if someone opens a file with O_NOFOLLOW
> > flag, it is exposed in /proc/pid/fdinfo/<X>. So CRIU must also open the
> > file with this flag during restore.
> >=20
> > This patch adds new constant RESOLVE_EMPTY_PATH for resolve field of
> > struct open_how and changes getname() call to getname_flags() to avoid
> > ENOENT for empty filenames.
>=20
> From my perspective this makes sense and is something that would be
> very useful instead of having to hack around this via procfs.
>=20
> However, e should consider adding RESOLVE_EMPTY_PATH since we already
> have AT_EMPTY_PATH. If we think this is workable we should try and reuse
> AT_EMPTY_PATH that keeps the api consistent with linkat(), readlinkat(),
> execveat(), statx(), open_tree(), mount_setattr() etc.
>=20
> If AT_EMPTY_PATH doesn't conflict with another O_* flag one could make
> openat() support it too?

I would much prefer O_EMPTYPATH, in fact I think this is what I called
it in my first draft ages ago. RESOLVE_ is meant to be related to
resolution restrictions, not changing the opening mode.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--daan2c3ci5y43vdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYd7pEAAKCRCdlLljIbnQ
EouuAP4p89bpTnWFaWkxx1czgnvMLFyP+P/bHn4wbU/g8zXN6gD/T6oxbfzsOoxL
EqGL/0X82IG7BbX95NRD+0FGwDHZBQw=
=hcM/
-----END PGP SIGNATURE-----

--daan2c3ci5y43vdf--
