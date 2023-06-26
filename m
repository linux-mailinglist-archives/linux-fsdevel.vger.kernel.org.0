Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3F73DE52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 13:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFZL7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFZL7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:59:15 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FF71B7;
        Mon, 26 Jun 2023 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687780749;
        bh=4+z7ZIoyhovoKpw400Rj+g0SxUL0TZKEfQaco6Uy+Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EC3hBj+VIbQUxleZu5Afv7t6LJKnTnwaUIQ8gtjw5GZYAdPoT6qcmdOXInhUoddOO
         1SovPdtabzbpSbnXQpiBhiRKN+5dDU4HobVBLXGTjfjSWvxCRmUuMNWcSfs+x0+Hqy
         wLvSSOaUwqhsYPOleOZluxQ2XukUcmKYC95m2jN4LLMRMt7G599jouUr6Weuklpp88
         bArSc6V2VS6iTF2he/KGCW8ZeWGSS9UJioEsiIg9lKvcNyqV2pRZ+xZGXGNM1QXyxd
         vkIC+eSrP4YOig0Omj37F4hdtxeuoLISV4ERa4xtYnSvYPouDcCNV6ySmUHd2EkaFw
         q1F0B0dLACo6g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 1034F1642;
        Mon, 26 Jun 2023 13:59:09 +0200 (CEST)
Date:   Mon, 26 Jun 2023 13:59:07 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zy4pzrdco23rr33p"
Content-Disposition: inline
In-Reply-To: <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
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


--zy4pzrdco23rr33p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 11:32:16AM +0200, Christian Brauner wrote:
> On Mon, Jun 26, 2023 at 03:12:09AM +0200, Ahelenia Ziemia=C5=84ska wrote:
> > Hi! (starting with get_maintainers.pl fs/splice.c,
> >      idk if that's right though)
> >=20
> > Per fs/splice.c:
> >  * The traditional unix read/write is extended with a "splice()" operat=
ion
> >  * that transfers data buffers to or from a pipe buffer.
> > so I expect splice() to work just about the same as read()/write()
> > (and, to a large extent, it does so).
> >=20
> > Thus, a refresher on pipe read() semantics
> > (quoting Issue 8 Draft 3; Linux when writing with write()):
> > 60746  When attempting to read from an empty pipe or FIFO:
> > 60747  =E2=80=A2 If no process has the pipe open for writing, read( ) s=
hall return 0 to indicate end-of-file.
> > 60748  =E2=80=A2 If some process has the pipe open for writing and O_NO=
NBLOCK is set, read( ) shall return
> > 60749    =E2=88=921 and set errno to [EAGAIN].
> > 60750  =E2=80=A2 If some process has the pipe open for writing and O_NO=
NBLOCK is clear, read( ) shall
> > 60751    block the calling thread until some data is written or the pip=
e is closed by all processes that
> > 60752    had the pipe open for writing.
> >=20
> > However, I've observed that this is not the case when splicing from
> > something that sleeps on read to a pipe, and that in that case all
> > readers block, /including/ ones that are reading from fds with
> > O_NONBLOCK set!
> >=20
> > As an example, consider these two programs:
> > -- >8 --
> > // wr.c
> > #define _GNU_SOURCE
> > #include <fcntl.h>
> > #include <stdio.h>
> > int main() {
> >   while (splice(0, 0, 1, 0, 128 * 1024 * 1024, 0) > 0)
> >     ;
> >   fprintf(stderr, "wr: %m\n");
> > }
> > -- >8 --
> >=20
> > -- >8 --
> > // rd.c
> > #define _GNU_SOURCE
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > int main() {
> >   fcntl(0, F_SETFL, fcntl(0, F_GETFL) | O_NONBLOCK);
> >=20
> >   char buf[64 * 1024] =3D {};
> >   for (ssize_t rd;;) {
> > #if 1
> >     while ((rd =3D read(0, buf, sizeof(buf))) =3D=3D -1 && errno =3D=3D=
 EINTR)
> >       ;
> > #else
> >     while ((rd =3D splice(0, 0, 1, 0, 128 * 1024 * 1024, 0)) =3D=3D -1 =
&&
> >            errno =3D=3D EINTR)
> >       ;
> > #endif
> >     fprintf(stderr, "rd=3D%zd: %m\n", rd);
> >     write(1, buf, rd);
> >=20
> >     errno =3D 0;
> >     sleep(1);
> >   }
> > }
> > -- >8 --
> >=20
> > Thus:
> > -- >8 --
> > a$ make rd wr
> > a$ mkfifo fifo
> > a$ ./rd < fifo                           b$ echo qwe > fifo
> > rd=3D4: Success
> > qwe
> > rd=3D0: Success
> > rd=3D0: Success                            b$ sleep 2 > fifo
> > rd=3D-1: Resource temporarily unavailable
> > rd=3D-1: Resource temporarily unavailable
> > rd=3D0: Success
> > rd=3D0: Success                           =20
> > rd=3D-1: Resource temporarily unavailable  b$ /bin/cat > fifo
> > rd=3D-1: Resource temporarily unavailable
> > rd=3D4: Success                            abc
> > abc
> > rd=3D-1: Resource temporarily unavailable
> > rd=3D4: Success                            def
> > def
> > rd=3D0: Success                            ^D
> > rd=3D0: Success
> > rd=3D0: Success                            b$ ./wr > fifo
> > -- >8 --
> > and nothing. Until you actually type a line (or a few) into teletype b
> > so that the splice completes, at which point so does the read.
> >=20
> > An even simpler case is=20
> > -- >8 --
> > $ ./wr | ./rd
> > abc
> > def
> > rd=3D8: Success
> > abc
> > def
> > ghi
> > jkl
> > rd=3D8: Success
> > ghi
> > jkl
> > ^D
> > wr: Success
> > rd=3D-1: Resource temporarily unavailable
> > rd=3D0: Success
> > rd=3D0: Success
> > -- >8 --
> >=20
> > splice flags don't do anything.
> > Tested on bookworm (6.1.27-1) and Linus' HEAD (v6.4-rc7-234-g547cc9be86=
f4).
> >=20
> > You could say this is a "denial of service", since this is a valid
> > way of following pipes (and, sans SIGIO, the only portable one),
> splice() may block for any of the two file descriptors if they don't
> have O_NONBLOCK set even if SPLICE_F_NONBLOCK is raised.
>=20
> SPLICE_F_NONBLOCK in splice_file_to_pipe() is only relevant if the pipe
> is full. If the pipe isn't full then the write is attempted. That of
> course involves reading the data to splice from the source file. If the
> source file isn't O_NONBLOCK that read may block holding pipe_lock().
>=20
> If you raise O_NONBLOCK on the source fd in wr.c then your problems go
> away. This is pretty long-standing behavior.
I don't see how this is relevant here. Whether the writer splice blocks
=E2=80=92 or how it behaves at all =E2=80=92 doesn't matter.

The /reader/ demands non-blocking reads. Just by running a splice()
we've managed to permanently hang the reader in a way that's fully
impervious to everything.

Actually, hold that: in testing this on an actual program that relies on
this (nullmailer), I've found that trying to /open the FIFO/ also hangs
forever, in that same signal-impervious state.

To wit:
  $ ps 3766
    PID TTY      STAT   TIME COMMAND
   3766 ?        Ss     0:01 /usr/sbin/nullmailer-send
  $ ls -l /proc/3766/fd
  total 0
  lr-x------ 1 mail mail 64 Jun 14 15:03 0 -> /dev/null
  lrwx------ 1 mail mail 64 Jun 14 15:03 1 -> 'socket:[81721760]'
  lrwx------ 1 mail mail 64 Jun 14 15:03 2 -> 'socket:[81721760]'
  lr-x------ 1 mail mail 64 Apr 28 15:38 3 -> 'pipe:[81721763]'
  l-wx------ 1 mail mail 64 Jun 14 15:03 4 -> 'pipe:[81721763]'
  lr-x------ 1 mail mail 64 Jun 14 15:03 5 -> /var/spool/nullmailer/trigger
  lrwx------ 1 mail mail 64 Jun 14 15:03 9 -> /dev/null
  # cat /proc/3766/fdinfo/5
  pos:    0
  flags:  0104000
  mnt_id: 64
  ino:    393969
  # < /proc/3766/fdinfo/5 fdinfo
  O_RDONLY        O_NONBLOCK O_LARGEFILE
  # strace -yp 3766 &
  strace: Process 3766 attached
  $ strace out/cmd/cat > /var/spool/nullmailer/trigger
  [cat] (normal libc setup)
  [cat] splice(0, NULL, 1, NULL, 134217728, SPLICE_F_MOVE|SPLICE_F_MOREa
  [cat] ) =3D 2
  [cat] splice(0, NULL, 1, NULL, 134217728, SPLICE_F_MOVE|SPLICE_F_MORE
  [nullmailer] pselect6(6, [5</var/spool/nullmailer/trigger>], NULL, NULL, =
{tv_sec=3D86397, tv_nsec=3D624894145}, NULL) =3D 1 (in [5], left {tv_sec=3D=
86394, tv_nsec=3D841299215})
  [nullmailer] write(1<socket:[81721760]>, "Trigger pulled.\n", 16) =3D 16
  [nullmailer] read(5</var/spool/nullmailer/trigger>,
and
  $ strace -y sh -c 'echo zupa > /var/spool/nullmailer/trigger'
  (...whatever shell setup)
  rt_sigaction(SIGTERM, {sa_handler=3DSIG_DFL, sa_mask=3D~[RTMIN RT_1], sa_=
flags=3DSA_RESTORER, sa_restorer=3D0xf7d21bb0}, NULL, 8) =3D 0
  openat(AT_FDCWD, "/var/spool/nullmailer/trigger", O_WRONLY|O_CREAT|O_TRUN=
C, 0666

This is a "you've lost" situation to me. This system will /never/
send mail now, and any mailer program will also hang forever
(again, to wit:
   # echo zupa | strace -yfo /tmp/ss mail root
 does hang forever and /tmp/ss ends in
   16915 close(6</var/spool/nullmailer/queue>) =3D 0
   16915 unlink("/var/spool/nullmailer/tmp/16915") =3D 0
   16915 openat(AT_FDCWD, "/var/spool/nullmailer/trigger", O_WRONLY|O_NONBL=
OCK
 )
which means that, on this system, I will never get events from smartd
or ZED, so fuck me if I wanted to get "scrub errored" or "disk
will die soon" notifications (in pre-2.0.0 ZED this would also have
 broken autoreplace=3Don since it waited synchronously),
or from other monitoring, so again fuck me if I wanted to get
overheating/packet drops/whatever notifications,
or again fuck me if I wanted to get cron mail.
In many ways I've brought the system down (or will have done in like a
day once some mails go out) by sending a mail weird.


Naturally systemd stopping nullmailer failed after a few minutes with
  =C3=97 nullmailer.service - Nullmailer relay-only MTA
       Loaded: loaded (/lib/systemd/system/nullmailer.service; enabled; pre=
set: enabled)
       Active: failed (Result: timeout) since Mon 2023-06-26 13:10:02 CEST;=
 6min ago
     Duration: 1month 4w 10h 55min 29.666s
         Docs: man:nullmailer(7)
     Main PID: 3766
        Tasks: 1 (limit: 4673)
       Memory: 3.1M
          CPU: 1min 26.893s
       CGroup: /system.slice/nullmailer.service
               =E2=94=94=E2=94=803766 /usr/sbin/nullmailer-send
 =20
  Jun 26 13:05:32 szarotka systemd[1]: nullmailer.service: State 'stop-sigt=
erm' timed out. Killing.
  Jun 26 13:05:32 szarotka systemd[1]: nullmailer.service: Killing process =
3766 (nullmailer-send) with signal SIGKILL.
  Jun 26 13:07:02 szarotka systemd[1]: nullmailer.service: Processes still =
around after SIGKILL. Ignoring.
  Jun 26 13:08:32 szarotka systemd[1]: nullmailer.service: State 'final-sig=
term' timed out. Killing.
  Jun 26 13:08:32 szarotka systemd[1]: nullmailer.service: Killing process =
3766 (nullmailer-send) with signal SIGKILL.
  Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Processes still =
around after final SIGKILL. Entering failed mode.
  Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Failed with resu=
lt 'timeout'.
  Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Unit process 376=
6 (nullmailer-send) remains running after unit s>
  Jun 26 13:10:02 szarotka systemd[1]: Stopped nullmailer.service - Nullmai=
ler relay-only MTA.
  Jun 26 13:10:02 szarotka systemd[1]: nullmailer.service: Consumed 1min 26=
=2E893s CPU time.

But not to fret! Maybe we can still kill it with the cgroup! No:
  # strace -y sh -c 'echo 1 > /sys/fs/cgroup/system.slice/nullmailer.servic=
e/cgroup.kill'
  ...
  dup2(3</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>, 1) =
=3D 1</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>
  close(3</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>) =3D 0
  write(1</sys/fs/cgroup/system.slice/nullmailer.service/cgroup.kill>, "1\n=
", 2) =3D 2
  ...
This completes, sure, but doesn't do anything at all
(admittedly, I'm not a cgroup expert, but it did work on other,
 non-poisoned, cgroups, so I'd expect it to work).

Opening the FIFO with O_NONBLOCK also hangs, obviously.
Killing the splicer restores order, as expected.

> Splice would have to be
> refactored to not rely on pipe_lock(). That's likely major work with a
> good portion of regressions if the past is any indication.
That's likely; however, it =E2=80=92 or an equivalent solution =E2=80=92 wo=
uld
probably be a good idea to do, on balance of all my points above,
I think.

> If you need that ability to fully async read from a pipe with splice
> rn then io_uring will at least allow you to punt that read into an async
> worker thread afaict.
I need my system to not be hanged by any user with a magic syscall.
I think you've confused the splice bit as being contentious =E2=80=92 I don=
't
care, and couldn't care less about how this is triggered =E2=80=92 the issu=
e is
that a splice fully excludes /ALL OTHER/ operations on a pipe,
and zombifies all processes that try.

Consider the case where messages arrive at a collection pipe
(this is well-specified and well-used with O_DIRECT and <=3DPIPE_MAX,
 I don't have a demo off-hand),
or, hell, even a case where logs do:
giving any user with append capability effectively exclusive control
for as long as they want is, well, suboptimal;
you could analyse this as a stronger variant of
  https://lore.kernel.org/linux-fsdevel/fa6de786ee1241c6ba54c3cce0b980aa@Ac=
uMS.aculab.com/t/#e74be7131861099a7f3d82d51dfc96645d26e9a94
and indeed, my original use-case was this broke tail -f,
but you know how it be.

--zy4pzrdco23rr33p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSZfYkACgkQvP0LAY0m
WPFOFQ//UMb0K6WagxO5Slf6UHxsoLlORv50BHV31biJ4IIAPkhx1TUfREU2Z5yo
WApksyydzWymYwep5y3UzqeNEC9ZsRocXHyr9bsGZtBAXjSbV0PRuyKEe3CgXpL2
12NnDsN9YLvGl3beLX+BHkpgLRrfGJzY6xTuTwDFsrLqLJ6Ip2uHarIxHjhUWJBY
bUJ711wkUmdr/Ss1alXDsE1Wlry1g8lGzYSZvS6EJhhjwtnQTnNxmzt0d+HUL02N
JddZ0yXA2Sg/IiqvQQkWud+OU5lIXoyVhtZKkx4U3tdiprlaiKz+TnSbEfjfKNnU
XVadvfklQL5K6lvr3ckkNPeav02xehmRaoN9f9xpKi1YcuWBeptiRQaSqgq8rFpf
uPzzeS1W+OR7NLfJTmqQH4ivdEGx+upYO8IYqo/Bg4LafUgAr+FeJ1XkrPLFteNl
2ERgBFWukDLWu9FuApCyRV5s8eYsZIcpeMinm87vKuXKdyyWRrrw+XWkhdsS21ow
Js5FzjnohYQjoPUpwQh4uKZrJ7gm7P6Z4fQvkiI7hN/nfQU70ZO/wmmalcrIqu5H
W/NKLXh5EhM1qxzefBt7wcTkKi/QUt+CBx+298nDGLHWufYSlF40sPX3lpwCgFlz
8iGPLKFI3tZWwGHB9vJXrGwUmdCdKqwjIfSqiGxghi/kunRRdzI=
=XpH2
-----END PGP SIGNATURE-----

--zy4pzrdco23rr33p--
