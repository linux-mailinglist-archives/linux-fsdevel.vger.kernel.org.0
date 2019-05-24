Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6275528F78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbfEXDL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 23:11:59 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:19540 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387559AbfEXDL7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 23:11:59 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1335AA015B;
        Fri, 24 May 2019 05:11:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id SZgroZg2fFsB; Fri, 24 May 2019 05:11:27 +0200 (CEST)
Date:   Fri, 24 May 2019 13:11:09 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v8 01/10] namei: obey trailing magic-link DAC
 permissions
Message-ID: <20190524031109.v24r6typyug2rlto@yavin>
References: <20190520133305.11925-1-cyphar@cyphar.com>
 <20190520133305.11925-2-cyphar@cyphar.com>
 <CALCETrVCwe49q5mu=f6jTYNSgosQSjjY5chukMPo6eZtQGqo5g@mail.gmail.com>
 <20190523020009.mi25uziu2b3whf4l@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6xfnzimry42j3mt"
Content-Disposition: inline
In-Reply-To: <20190523020009.mi25uziu2b3whf4l@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--r6xfnzimry42j3mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-23, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-05-22, Andy Lutomirski <luto@kernel.org> wrote:
> > What are actual examples of uses for this exception?  Breaking
> > selftests is not, in and of itself, a huge problem.
>=20
> Not as far as I know. All of the re-opening users I know of do re-opens
> of O_PATH or are re-opening with the same (or fewer) privileges. I also
> ran this for a few days on my laptop without this exception, and didn't
> have any visible issues.

I have modified the patch to WARN_ON(may_open_magiclink() =3D=3D -EACCES).

So far (in the past day on my openSUSE machines) I have only seen two
programs which have hit this case: kbd[1]'s "loadkeys" and "kbd_mode"
binaries. In addition to there not being any user-visible errors -- they
actually handle permission errors gracefully!

  static int
  open_a_console(const char *fnam)
  {
  	int fd;

  	/*
  	 * For ioctl purposes we only need some fd and permissions
  	 * do not matter. But setfont:activatemap() does a write.
  	 */
  	fd =3D open(fnam, O_RDWR);
  	if (fd < 0)
  		fd =3D open(fnam, O_WRONLY);
  	if (fd < 0)
  		fd =3D open(fnam, O_RDONLY);
  	if (fd < 0)
  		return -1;
  	return fd;
  }

The above gets called with "/proc/self/fd/0" as an argument (as well as
other console candidates like "/dev/console"). And setfont:activatemap()
actually does handle read-only fds:

  static void
  send_escseq(int fd, const char *seq, int n)
  {
  	if (write(fd, seq, n) !=3D n) /* maybe fd is read-only */
  		printf("%s", seq);
  }

  void activatemap(int fd)
  {
  	send_escseq(fd, "\033(K", 3);
  }

So, thus far, not only have I not seen anything go wrong -- the only
program which actually hits this case handles the error gracefully.
Obviously we got lucky here, but the lack of any users of this
mis-feature leads me to have some hope that we can block it without
anyone noticing.

But I emphatically do not want to break userspace here (except for
attackers, obviously).

[1]: http://git.altlinux.org/people/legion/packages/kbd.git

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--r6xfnzimry42j3mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlznYMwACgkQSnvnv3De
m5/UlRAAovI52jrpVsYCg4NsE4FyF6D0yGqaH+nTC1yXRTFIQOX0gWiYDa0U/BAQ
cJNYiSNBV8HHy4s0N5h1MFu6FDKmWhNS5a8A58HUMXlJQ/6/RpT2NnleB6MBfi02
E91mqGiVxU4wEthnb44GhUhTmbSoo4JwrdI7AfhvOiKTEziXcf7HcF2VUMMySdD+
WTC48upAO2G2oYUowAWydF4//I6y7LL4mFPO0RhWCxUqFQmapC3ujka1xvkE46zQ
4R8ZIlKhnBk3SuE5B77urbIAr4gnQt7U6dZVvQACl/bpBBR8UPkj19okJ4yfjr77
x2q5Wq8MJB4sYTcjeAml1GNV3f+3v39OwDxiP9HF/j0oergsbKO/Lx0+B3S63TEk
Hz3KhZRfC8/YpeTTGy60l/3Wqb+kONRvl8J1H47C/JS26MVQUs9nym/Iq6PX+cRf
V2usCjxwVE1vrZAbpxUMAuifgTmkjf3n2NAURpFTKMX/druhDFxol6ZsuB4/0Ti4
EseHO5B2wVxkydDzR/9cmj6y29HUge+Y3fAeKa3zvtShYwhKqHg4DYx8CsoFVBfK
ACLPMT6ymdJ/uz/xBy6wzT88vmDJZ4XC/vlAeAUTXZdd//s2CUu3fSaJs1FfKHr/
marW2Z16cmWWkyzZiWZlekLhKRxG3BmpD7bI5Wcxw2YKwPYl8IQ=
=eLDb
-----END PGP SIGNATURE-----

--r6xfnzimry42j3mt--
