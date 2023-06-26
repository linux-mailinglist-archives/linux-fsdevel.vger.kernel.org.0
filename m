Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559B73D57B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 03:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFZBMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Jun 2023 21:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFZBMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:12:14 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2400194;
        Sun, 25 Jun 2023 18:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687741930;
        bh=pqnPYGTfh1ZIMZQeiwgOUejdA3LSVPWbpNYvcMysFf8=;
        h=Date:From:To:Subject:From;
        b=iXxfdo8LgtiVhBj7vyKKmHRzb/590CG4zTFOGSqiTockvak6aMAkWhkHOhoKXoKcZ
         lzt13zDH66SgwQUNyi7DZLBK1yDoCGlKaBHxzmIfWmDEHRl2xM9GiSgFWeG25k/m5j
         7JbQLes6Kst46omDevVJ9Id7YVj59Q9WeydH6Bi7UYSHyUH7rgFry7AweJg5NS5CIv
         GlmHDe9UO+C6Q+RNJqSgdr5ZgukGNISPVMwxVzYlsdfbm1tk9+K5U9v0nIvxPe6qjT
         gv+bpHkoFdWmKdcPXfwFvDrsHAFFEiUEmJ7mwz+E4NTdZougael8cT1FbM6D2rOo9s
         Kr15xH3VfZ6Tw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 957CA12AE;
        Mon, 26 Jun 2023 03:12:10 +0200 (CEST)
Date:   Mon, 26 Jun 2023 03:12:09 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Pending splice(file -> FIFO) always blocks read(FIFO), regardless of
 O_NONBLOCK on read side?
Message-ID: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5sqj5xnglnda2l7b"
Content-Disposition: inline
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


--5sqj5xnglnda2l7b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi! (starting with get_maintainers.pl fs/splice.c,
     idk if that's right though)

Per fs/splice.c:
 * The traditional unix read/write is extended with a "splice()" operation
 * that transfers data buffers to or from a pipe buffer.
so I expect splice() to work just about the same as read()/write()
(and, to a large extent, it does so).

Thus, a refresher on pipe read() semantics
(quoting Issue 8 Draft 3; Linux when writing with write()):
60746  When attempting to read from an empty pipe or FIFO:
60747  =E2=80=A2 If no process has the pipe open for writing, read( ) shall=
 return 0 to indicate end-of-file.
60748  =E2=80=A2 If some process has the pipe open for writing and O_NONBLO=
CK is set, read( ) shall return
60749    =E2=88=921 and set errno to [EAGAIN].
60750  =E2=80=A2 If some process has the pipe open for writing and O_NONBLO=
CK is clear, read( ) shall
60751    block the calling thread until some data is written or the pipe is=
 closed by all processes that
60752    had the pipe open for writing.

However, I've observed that this is not the case when splicing from
something that sleeps on read to a pipe, and that in that case all
readers block, /including/ ones that are reading from fds with
O_NONBLOCK set!

As an example, consider these two programs:
-- >8 --
// wr.c
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
int main() {
  while (splice(0, 0, 1, 0, 128 * 1024 * 1024, 0) > 0)
    ;
  fprintf(stderr, "wr: %m\n");
}
-- >8 --

-- >8 --
// rd.c
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
int main() {
  fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);

  char buf[64 * 1024] =3D {};
  for (ssize_t rd;;) {
#if 1
    while ((rd =3D read(0, buf, sizeof(buf))) =3D=3D -1 && errno =3D=3D EIN=
TR)
      ;
#else
    while ((rd =3D splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) =3D=3D -1 &&
           errno =3D=3D EINTR)
      ;
#endif
    fprintf(stderr, "rd=3D%zd: %m\n", rd);
    write(1, buf, rd);

    errno =3D 0;
    sleep(1);
  }
}
-- >8 --

Thus:
-- >8 --
a$ make rd wr
a$ mkfifo fifo
a$ ./rd < fifo                           b$ echo qwe > fifo
rd=3D4: Success
qwe
rd=3D0: Success
rd=3D0: Success                            b$ sleep 2 > fifo
rd=3D-1: Resource temporarily unavailable
rd=3D-1: Resource temporarily unavailable
rd=3D0: Success
rd=3D0: Success                           =20
rd=3D-1: Resource temporarily unavailable  b$ /bin/cat > fifo
rd=3D-1: Resource temporarily unavailable
rd=3D4: Success                            abc
abc
rd=3D-1: Resource temporarily unavailable
rd=3D4: Success                            def
def
rd=3D0: Success                            ^D
rd=3D0: Success
rd=3D0: Success                            b$ ./wr > fifo
-- >8 --
and nothing. Until you actually type a line (or a few) into teletype b
so that the splice completes, at which point so does the read.

An even simpler case is=20
-- >8 --
$ ./wr | ./rd
abc
def
rd=3D8: Success
abc
def
ghi
jkl
rd=3D8: Success
ghi
jkl
^D
wr: Success
rd=3D-1: Resource temporarily unavailable
rd=3D0: Success
rd=3D0: Success
-- >8 --

splice flags don't do anything.
Tested on bookworm (6.1.27-1) and Linus' HEAD (v6.4-rc7-234-g547cc9be86f4).

You could say this is a "denial of service", since this is a valid
way of following pipes (and, sans SIGIO, the only portable one),
and this makes it so the reader is completely blocked,
and impervious to all deadly signals (incl. SIGKILL).
I've also observed strace hanging (but it responded to SIGKILL).


Rudimentary analysis shows that sys_splice() -> __do_splice() ->
do_splice() -> {!(ipipe && opipe) -> !(ipipe) -> (ipipe)}:
splice_file_to_pipe which then does
-- >8 --
	pipe_lock(opipe);
	ret =3D wait_for_space(opipe, flags);
	if (!ret)
		ret =3D do_splice_to(in, offset, opipe, len, flags);
	pipe_unlock(opipe);
-- >8 --
conversely:
-- >8 --
static ssize_t
pipe_read(struct kiocb *iocb, struct iov_iter *to)
{
        size_t total_len =3D iov_iter_count(to);
        struct file *filp =3D iocb->ki_filp;
        struct pipe_inode_info *pipe =3D filp->private_data;
        bool was_full, wake_next_reader =3D false;
        ssize_t ret;

        /* Null read succeeds. */
        if (unlikely(total_len =3D=3D 0))
                return 0;

        ret =3D 0;
        __pipe_lock(pipe);
-- >8 --
so, naturally(?), all non-empty reads wait for the splice to end.

To validate this, I've applied the following
(which I'm 100% sure is wrong and breaks unrelated stuff):
-- >8 --
diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..a76535839d32 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -240,6 +240,11 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	if (unlikely(total_len =3D=3D 0))
 		return 0;
=20
+	if ((filp->f_flags & O_NONBLOCK) || (iocb->ki_flags & IOCB_NOWAIT)) {
+		if (mutex_is_locked(&pipe->mutex))
+			return -EAGAIN;
+	}
+
 	ret =3D 0;
 	__pipe_lock(pipe);
-- >8 --
which does make the aforementioned cases less pathological
(naturally this now means it always EAGAINs even if there is data to be
 read since the splice() loop keeps it locked, but you get the picture).

--5sqj5xnglnda2l7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSY5ecACgkQvP0LAY0m
WPF4YQ/+OeAzvWkC1fUJcUjJPAtI4mP6QKzJivJOyURVReOi0ZE4tjTt8S1iAd6y
7/68LBFevNEwa+vf1hREBgGVEqJvxW7FN2+yreeSSo4SKul1XNW/U8oRM7V+5Jrh
YjOl2+9twVppr4eF+C0FqM06fiO/84CJMjZCoaylcxtLGwDyOSRgkLDd3JcHJEQc
YlkThlrLOJ+RPF0BL78AWpHjxAmpDTWynDrs9VvpUoYNSzt+cu8uuHYN75NG+SOh
rH+QOc4s10nMHnUGzm/Jjegnq5m/Ul/prWQJ2QDT6NQXrue0aKO1x5TIRmLuiP5B
Flh6C7YB2vLJOLIeXb/jzRH+7bsQMQFdzY3BwV24S5POy/feCtH3x/wySUPVioU3
SG43J/5hHDgSyY7R7zpSUQpTZ/eieNB4VTld+wy7nXsIpKLhkR4V/klUIgVdDSQI
fLpR5SkYIp+cWhPTEwGEKblwZtYFBxl8604P7/Aml+CCeFn50pPjaj9EDLIN/hBf
HVhl3Wh3w7xZlcnR2BB5Jh9Ia/ANPJnWvt2VPAxg5dmOe9ipFAcaRVrIciIVbJim
UZPr2hRf/gnnXhDibcixayOy/e4ZLh3e23xrgOTItwOTdKNoDV8yamw6m3ZK8zPE
+vnTZZ83i/fLOQr0DEXqeNk2YK+qBu258eoQ9l3Qmy2fU7dul3w=
=Z4Qg
-----END PGP SIGNATURE-----

--5sqj5xnglnda2l7b--
