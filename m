Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77747415FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 18:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF1QDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 12:03:35 -0400
Received: from 139-28-40-42.artus.net.pl ([139.28.40.42]:55712 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-OK-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S230425AbjF1QDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687968207;
        bh=H89eKS6J7cZfio0FgmlRYvKGVSwe9xd5Odkri+vpPGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyP55kt8ofkUXdl1DPqdFR5uUcrdGPGPqBg6DNO5nCYIONynedyZ22xjgXVLQ5/+D
         a3ee3jHoAXMS/E0e3/dz98Bo6ECuJZ1Ifzd41oyk1cUCn3uiMI3MYo2DXy1xQQ8Xs9
         lqZXB2Q9sNVNBsQLKUCD9W6tB8p36vhym2T4+NmC0Px2NrMSslOBkoaqsvlCt4yLVI
         ussGwLduyhfQ8ADtT3kfzFjEiBd+5dXsuCj3Kf1UDvqdtT8Pb/b4umk7Hcblelmk1T
         N8+Zf9eKNS8IbdmaqmrLvYU2zKuACUcCKf8Brl4RtzT7FcXJojbAO9UbzY4YAdeoMO
         J5JNFyoHklHQg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 767CB173C;
        Wed, 28 Jun 2023 18:03:27 +0200 (CEST)
Date:   Wed, 28 Jun 2023 18:03:26 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP RFC PATCH v3] inotify13: new test for fs/splice.c functions
 vs pipes vs inotify
Message-ID: <ychkzjlukpzb4h24dxtvesnvq3tgjrtqcfed6xlorzpy24xk43@zdips4bvrsii>
References: <ajkeyn2sy35h6ctfbupom4xg3ozoxxgsojdvu7vebac44zqped@ecnusnv6daxn>
 <f4mzakro6yp7dlq25h3mbm3ecbkuebwlengdln47y4w5wfqwo2@3hasgbhltgvg>
 <CAOQ4uxg4mGpqCMCnJcNSK9vQXU1hx8XPQDEcL0+3yM7AF9V9-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ui7ewvobyxz6sd5"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4mGpqCMCnJcNSK9vQXU1hx8XPQDEcL0+3yM7AF9V9-A@mail.gmail.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7ui7ewvobyxz6sd5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 08:30:15AM +0300, Amir Goldstein wrote:
> On Wed, Jun 28, 2023 at 3:21=E2=80=AFAM Ahelenia Ziemia=C5=84ska
> > diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/=
kernel/syscalls/inotify/inotify13.c
> > new file mode 100644
> > index 000000000..97f88053e
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> > @@ -0,0 +1,282 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*\
> > + * [Description]
> > + * Verify splice-family functions (and sendfile) generate IN_ACCESS
> > + * for what they read and IN_MODIFY for what they write.
> > + *
> > + * Regression test for 983652c69199 ("splice: report related fsnotify =
events") and
> > + * https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> The process of posting a test for the fix that was not yet merged
> is indeed a chicken and egg situation.
>=20
> What I usually do is post a draft test (like this) and link
> to the post of the LTP test (and maybe a branch on github)
> when posting the fix, to say how I tested the fix.
https://git.sr.ht/~nabijaczleweli/ltp/commit/v4 for now.

> I would then put it in my TODO to re-post the LTP
> test once the kernel fix has been merged.
Yep.

> > +static int compar(const void *l, const void *r)
> > +{
> > +       const struct inotify_event *lie =3D l;
> > +       const struct inotify_event *rie =3D r;
> > +
> > +       return lie->wd - rie->wd;
> > +}
> > +
> > +static void get_events(size_t evcnt, struct inotify_event evs[static e=
vcnt])
> > +{
> > +       struct inotify_event tail, *itr =3D evs;
> > +
> > +       for (size_t left =3D evcnt; left; --left)
> > +               SAFE_READ(true, inotify, itr++, sizeof(struct inotify_e=
vent));
> > +
> > +       TEST(read(inotify, &tail, sizeof(struct inotify_event)));
> > +       if (TST_RET !=3D -1)
> > +               tst_brk(TFAIL, ">%zu events", evcnt);
> > +       if (TST_ERR !=3D EAGAIN)
> > +               tst_brk(TFAIL | TTERRNO, "expected EAGAIN");
> > +
> > +       qsort(evs, evcnt, sizeof(struct inotify_event), compar);
> > +}
> > +
> > +static void expect_transfer(const char *name, size_t size)
> > +{
> > +       if (TST_RET =3D=3D -1)
> > +               tst_brk(TBROK | TERRNO, "%s", name);
> > +       if ((size_t)TST_RET !=3D size)
> > +               tst_brk(TBROK, "%s: %ld !=3D %zu", name, TST_RET, size);
> > +}
> > +
> > +static void expect_event(struct inotify_event *ev, int wd, uint32_t ma=
sk)
> > +{
> > +       if (ev->wd !=3D wd)
> > +               tst_brk(TFAIL, "expect event for wd %d got %d", wd, ev-=
>wd);
> > +       if (ev->mask !=3D mask)
> > +               tst_brk(TFAIL,
> > +                       "expect event with mask %" PRIu32 " got %" PRIu=
32 "",
> > +                       mask, ev->mask);
> > +}
> > +
> > +// write to file, rewind, transfer accd'g to f2p, read from pipe
> > +// expecting: IN_ACCESS memfd, IN_MODIFY pipes[0]
> > +static void file_to_pipe(const char *name, ssize_t (*f2p)(void))
> > +{
> > +       struct inotify_event events[2];
> > +       char buf[strlen(name)];
> > +
> > +       SAFE_WRITE(SAFE_WRITE_RETRY, memfd, name, strlen(name));
> > +       SAFE_LSEEK(memfd, 0, SEEK_SET);
> > +       watch_rw(memfd);
> > +       watch_rw(pipes[0]);
> > +       TEST(f2p());
> > +       expect_transfer(name, strlen(name));
> > +
> > +       get_events(ARRAY_SIZE(events), events);
> > +       expect_event(events + 0, 1, IN_ACCESS);
> > +       expect_event(events + 1, 2, IN_MODIFY);
> So what I meant to say is that if there are double events that
> usually get merged (unless reader was fast enough to read the
> first event), this is something that I could live with, but encoding
> an expectation for a double event, that's not at all what I meant.
>=20
> But anyway, I see that you've found a way to work around
> this problem, so at least the test can expect and get a single event.
I've tried (admittedly, not all that hard) to read a double out modify
event in this case with the v4 kernel patchset and haven't managed it.

> I think you are missing expect_no_more_events() here to
> verify that you won't get double events.
get_events() reads precisely N events, then tries to read another,
and fails if that succeeds.

Maybe a better name would be "get_events_exact()".

> See test inotify12 as an example for a test that encodes
> expect_events per test case and also verifies there are no
> unexpected extra events.
>=20
> That's also an example of a more generic test template,
> but your test cases are all a bit different from each other is
> subtle ways, so I trust you will find the best balance between
> putting generic parameterized code in the run_test() template
> and putting code in the test case subroutine.
Yes, that's indeed an optics issue: it looks like there's more, but
the only actually "common" bit of the test drivers is that they all
read events in the middle: the set-up before is different, and the
additional post-conditions are different.

We /could/ encode the expected events in the test array, but then
that would put the expected events away from the code that generates
them, which is more code, and more confusing for no good reason I
think.

--7ui7ewvobyxz6sd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmScWcsACgkQvP0LAY0m
WPF5eQ/+LoxhH0H8RkCh+velixumpSekw5xdU9bjN6xNL9Xj39OXfoVVSX3Uwndc
/20JuN5ozy2mMMdyDHfNv0OW5MDJQu//O3Wth5S0cQFE5kArkNOxp9K59ap9WXdw
oMbvCu2I11dmS5S9kEdUFnHfgt3gqb4BSv1eq8vXSOeP995j6jSlH2d6e1/fOw2T
QGX3X9pkyR6ZIEA59Wr8S44QoEu/hzQJAGQTHjNYh3AD5EbV78N9uW1kWn4sXAqQ
Bpd1Me/DErTbf/2MBvvLSNj56P3SUEmj9sy69Ub0KMIJ0nLVJ4xNhdwVe58oWtt9
OhMqJmxm+me5ze6stLM1rsD3Brhe9XhxMTSaE35xVpTu+qvy2/7j9OqikbsHFQzW
yh7pxcCe0atc2nMYMtsXnyWjpp0ojqtFrgUGUUcnihYJSof9fWTOYHICYVZFh75Q
e1OL+ZeZZbaaUHOritJuVodbYspEAmBsgCThe/cuZv65FHKjxkstlsFFuRGCjwnI
UlW+XVd06IjjtMdgQj8v5H+sCMPR6lirXtCyKFOMPnyhJjoKTTcZSzQEu5Q/I9cr
azHv8T8kfLZWceX8b3k80IW/+gZSQUCTucH+7preDq+XOE/bjvgbimSzL1nfF/Vg
r9+49pGt54dJKws9ulHmcjA5+CRNwz2p4/69kLKxlV2DplT6r/k=
=f6aD
-----END PGP SIGNATURE-----

--7ui7ewvobyxz6sd5--
