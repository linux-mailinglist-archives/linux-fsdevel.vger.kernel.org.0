Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48423E4E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 01:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHFX7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 19:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHFX7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:59:45 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5779AC061574;
        Thu,  6 Aug 2020 16:59:45 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4BN57s5V1GzKmRH;
        Fri,  7 Aug 2020 01:59:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id Z5kYO4k7-bo7; Fri,  7 Aug 2020 01:59:32 +0200 (CEST)
Date:   Fri, 7 Aug 2020 09:59:20 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lokesh Gidra <lokeshgidra@google.com>, viro@zeniv.linux.org.uk,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        jmorris@namei.org, kaleshsingh@google.com, dancol@dancol.org,
        surenb@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nnk@google.com, jeffv@google.com,
        calin@google.com, kernel-team@android.com, yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
Message-ID: <20200806235920.vy6ngjb7h55hg5w4@yavin.dot.cyphar.com>
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200805034758.lrobunwdcqtknsvz@yavin.dot.cyphar.com>
 <20200805040806.GB1136@sol.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2o2yssul3qsbj6lg"
Content-Disposition: inline
In-Reply-To: <20200805040806.GB1136@sol.localdomain>
X-MBO-SPAM-Probability: 0
X-Rspamd-Score: -6.18 / 15.00 / 15.00
X-Rspamd-Queue-Id: 88FDD1832
X-Rspamd-UID: 6bf24b
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2o2yssul3qsbj6lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-04, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Aug 05, 2020 at 01:47:58PM +1000, Aleksa Sarai wrote:
> > On 2020-08-04, Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > when get_unused_fd_flags returns error, ctx will be freed by
> > > userfaultfd's release function, which is indirectly called by fput().
> > > Also, if anon_inode_getfile_secure() returns an error, then
> > > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > >=20
> > > Also, the O_CLOEXEC was inadvertently added to the call to
> > > get_unused_fd_flags() [1].
> >=20
> > I disagree that it is "wrong" to do O_CLOEXEC-by-default (after all,
> > it's trivial to disable O_CLOEXEC, but it's non-trivial to enable it on
> > an existing file descriptor because it's possible for another thread to
> > exec() before you set the flag). Several new syscalls and fd-returning
> > facilities are O_CLOEXEC-by-default now (the most obvious being pidfds
> > and seccomp notifier fds).
>=20
> Sure, O_CLOEXEC *should* be the default, but this is an existing syscall =
so it
> has to keep the existing behavior.

Ah, I missed that this was a UAPI breakage. :P

> > At the very least there should be a new flag added that sets O_CLOEXEC.
>=20
> There already is one (but these patches broke it).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2o2yssul3qsbj6lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXyyZVAAKCRCdlLljIbnQ
EqERAQCdc5vbuBbcH6ZvlJ76Nh76VRRomUWHHCrcOMRHSFrJ+gD/WfDZUXU8Mwa0
gAR9T/LNnZ0Yv7I1Q/ny7ZJjPIQswgU=
=y/ce
-----END PGP SIGNATURE-----

--2o2yssul3qsbj6lg--
