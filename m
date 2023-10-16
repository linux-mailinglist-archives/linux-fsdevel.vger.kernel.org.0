Return-Path: <linux-fsdevel+bounces-496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6227CB4B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39311B20FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7134CFB;
	Mon, 16 Oct 2023 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Ez7/hijK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F92381A4;
	Mon, 16 Oct 2023 20:35:37 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61876D9;
	Mon, 16 Oct 2023 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488528;
	bh=hE6P+UeSTjBDi8P6I4RDjWfKNFfmgZelAHcwkGv1j+w=;
	h=Date:From:Cc:Subject:From;
	b=Ez7/hijKau5Lfmad7NlihjquU9cwrP/ej/6VcMJq2WKr3BF7vOHThZrRf+f4ze2fE
	 0UJxRSd3M3xfSEEFT1sNJ81b1VeXwXk3W7iaB57CKI+9k2XvDHD+yhfsJIxqUPMYk8
	 X2MPSEPebSOnE4OPysXFmnNTHPORUAWvXghxmidVE3DyXB6+Q8dTi0+xw6qNjAXEB5
	 QXmz+uaXnJ6bqOXXW4dfwoufuHdIJGbf76wsZ6I7ECUE+HOHbjpduO7yRlZa5yjANm
	 +Tqu13HfPBZLLGiZfdcQebVeCj2G6yg/DLgXMZLjIt+PsxkKiBrs0qhHbYYBCKkmvF
	 +lqeTQoelE1lQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 66926FC72;
	Mon, 16 Oct 2023 22:35:28 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:28 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foudation.org>, Boris Pismenny <borisp@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	David Ahern <dsahern@kernel.org>, David Howells <dhowells@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jan Karcher <jaka@linux.ibm.com>, John Fastabend <john.fastabend@gmail.com>, 
	Karsten Graul <kgraul@linux.ibm.com>, Kirill Tkhai <tkhai@ya.ru>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Li kunyu <kunyu@nfschina.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Pengcheng Yang <yangpc@wangsu.com>, Shigeru Yoshida <syoshida@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Xu Panda <xu.panda@zte.com.cn>, 
	Zhang Zhengming <zhang.zhengming@h3c.com>
Subject: [PATCH 00/11] splice(file<>pipe) I/O on file as-if O_NONBLOCK
Message-ID: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqm5boxqnux3b3rj"
Content-Disposition: inline
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--pqm5boxqnux3b3rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

As it stands, splice(file -> pipe):
1. locks the pipe,
2. does a read from the file,
3. unlocks the pipe.

For reading from regular files and blcokdevs this makes no difference.
But if the file is a tty or a socket, for example, this means that until
data appears, which it may never do, every process trying to read from
or open the pipe enters an uninterruptible sleep,
and will only exit it if the splicing process is killed.

This trivially denies service to:
* any hypothetical pipe-based log collexion system
* all nullmailer installations
* me, personally, when I'm pasting stuff into qemu -serial chardev:pipe

This follows:
1. https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2e=
kkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
2. a security@ thread rooted in
   <irrrblivicfc7o3lfq7yjm2lrxq35iyya4gyozlohw24gdzyg7@azmluufpdfvu>
3. https://nabijaczleweli.xyz/content/blogn_t/011-linux-splice-exclusion.ht=
ml

Patches were posted and then discarded on principle or funxionality,
all in all terminating in Linus posting
> But it is possible that we need to just bite the bullet and say
> "copy_splice_read() needs to use a non-blocking kiocb for the IO".

This does that, effectively making splice(file -> pipe)
request (and require) O_NONBLOCK on reads fron the file:
this doesn't affect splicing from regular files and blockdevs,
since they're always non-blocking
(and requesting the stronger "no kernel sleep" IOCB_NOWAIT is non-sensical),
but always returns -EINVAL for ttys.
Sockets behave as expected from O_NONBLOCK reads:
splice if there's data available else -EAGAIN.

This should all pretty much behave as-expected.

Mostly a re-based version of the summary diff from
<gnj4drf7llod4voaaasoh5jdlq545gduishrbc3ql3665pw7qy@ytd5ykxc4gsr>.

Bisexion yields commit 8924feff66f35fe22ce77aafe3f21eb8e5cff881
("splice: lift pipe_lock out of splice_to_pipe()") as first bad.


The patchset is made quite wide due to the many implementations
of the splice_read callback, and was based entirely on results from
  $ git grep '\.splice_read.*=3D' | cut -d=3D -f2 |
      tr -s ',;[:space:]' '\n' | sort -u

I'm assuming this is exhaustive, but it's 27 distinct implementations.
Of these, I've classified these as trivial delegating wrappers:
  nfs_file_splice_read               filemap_splice_read
  afs_file_splice_read               filemap_splice_read
  ceph_splice_read                   filemap_splice_read
  ecryptfs_splice_read_update_atime  filemap_splice_read
  ext4_file_splice_read              filemap_splice_read
  f2fs_file_splice_read              filemap_splice_read
  ntfs_file_splice_read              filemap_splice_read
  ocfs2_file_splice_read             filemap_splice_read
  orangefs_file_splice_read          filemap_splice_read
  v9fs_file_splice_read              filemap_splice_read
  xfs_file_splice_read               filemap_splice_read
  zonefs_file_splice_read            filemap_splice_read
  sock_splice_read                   copy_splice_read or a socket-specific =
one
  coda_file_splice_read              vfs_splice_read
  ovl_splice_read                    vfs_splice_read


filemap_splice_read() is used for regular files and blockdevs,
and thus needs no changes, and is thus unchanged.

vfs_splice_read() delegates to copy_splice_read() or f_op->splice_read().


The rest are fixed, in patch order:
01. copy_splice_read() by simply doing the I/O with IOCB_NOWAIT;
    diff from Linus:
      https://lore.kernel.org/lkml/5osglsw36dla3mubtpsmdwdid4fsdacplyd6acx2=
igo4atogdg@yur3idyim3cc/t/#ee67de5a9ec18886c434113637d7eff6cd7acac4b
02. unix_stream_splice_read() by unconditionally passing MSG_DONTWAIT
03. fuse_dev_splice_read() by behaving as-if O_NONBLOCK
04. tracing_buffers_splice_read() by behaving as-if O_NONBLOCK
    (this also removes the retry loop)
05. relay_file_splice_read() by behaving as-if SPLICE_F_NONBLOCK
    (this just means EAGAINing unconditionally for an empty transfer)
06. smc_splice_read() by unconditionally passing MSG_DONTWAIT
07. kcm_splice_read() by unconditionally passing MSG_DONTWAIT
08. tls_sw_splice_read() by behaving as-if SPLICE_F_NONBLOCK
09. tcp_splice_read() by behaving as-if O_NONBLOCK
    (this also removes the retry loop)

10. EINVALs on files that neither have FMODE_NOWAIT nor are S_ISREG

    We don't want this to be just FMODE_NOWAIT since most regular files
    don't have it set and that's not the right semantic anyway,
    as noted at the top of this mail,

    But this allows blockdevs "by accident", effectively,
    since they have FMODE_NOWAIT (at least the ones I tried),
    even though they're just like regular files:
    handled by filemap_splice_read(),
    thus not dispatched with IOCB_NOWAIT. since always non-blocking.

    Should this be a check for FMODE_NOWAIT && (S_ISREG || S_ISBLK)?
    Should it remain FMODE_NOWAIT && S_ISREG?
    Is there an even better way of spelling this?


In net/kcm, this also fixes kcm_splice_read() passing SPLICE_F_*-style
flags to skb_recv_datagram(), which takes MSG_*-style flags.
I don't think they did anything anyway? But.



I would of course be remiss to not analyse splice(pipe -> file) as well:
  gfs2_file_splice_write  iter_file_splice_write
  ovl_splice_write        iter_file_splice_write
  splice_write_null       splice_from_pipe(pipe_to_null), does nothing

fuse_dev_splice_write() locks, copies the iovs, unlocks, does I/O,
                        locks, frees the pipe's iovs, unlocks
port_fops_splice_write() locks, steals or copies pages, unlocks, does I/O


11. splice_to_socket():
    has sock_sendmsg() inside the pipe lock;
    filling the socket buffer sleeps in splice with the pipe locked,
    and this is trivial to trigger with
      ./af_unix_ptf ./splicing-cat < fifo &
      cat > fifo &
      cp 64k fifo a couple times
    patch does unconditional MSG_DONTWAIT, tests sensibly


iter_file_splice_write():
  has vfs_iter_write() inside the pipe lock,
  but appears to be attached to regular files and blockdevs,
  but also random_fops & urandom_fops (looks like not an issue)
  and tty_fops & console_fops
  (this only means non-pty ttys so no issue with a full buffer?
   idk if there's a situation where a tty or the discipline can block forev=
er
   or if it's guaranteed forward progress, however slow?
   still kinda ass to have the pipe lock hard-held for, say,
   (64*1024)/(300/8)s=3D30min if the pipe has 64k in the buffer?
   this predixion aligns precisely with what I measured:
    1# stty 300 < /dev/ttyS0
    1# ./splicing-cat < fifo > /dev/ttyS0

    2$ cat > fifo    # and typing works
    3$ cp 64k fifo   # uninterrupitbly sleeps in write(4, "SzmprOmdIIkciMwb=
pxhsEyFVORaPGbRQ"..., 66560
    1: now sleeping in splice
    2: typing more into the cat uninterruptibly sleeps in write
    4$ : > /tmp/fifo # uninterruptibly hangs in open

   similarly, "cp 10k fifo" uninterruptibly sleeps in close,
   with the same effects on other (potential) writers,
   and woke up after around five minutes, which matches my maths

   so presumably something should be done about this as well?
   just idk what)

So. AFAIK, just iter_file_splice_write() on ttys remains.


This needs a man-pages patch as well,
but I'd go rabid if I were to write it rn.


For the samples above, af_unix_ptf.c:
-- >8 --
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>

int main(int argc, char ** argv) {
  int fds[2];
  if(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, fds))
    abort();

  if(!vfork()) {
    dup2(fds[1], 1);
    _exit(execvp(argv[1], argv + 1));
  }
  dup2(fds[0], 0);
  for(;;) {
    char buf[16];
    int r =3D read(0, buf, 16);
    fprintf(stderr, "read %d\n", r);
    sleep(10);
  }
}
-- >8 --

splicing-cat.c:
-- >8 --
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
int main() {
  int lasterr =3D -1;
  unsigned ctr =3D 0;
  for(;;) {
    errno =3D 0;
    ssize_t ret =3D splice(0, 0, 1, 0, 128 * 1024 * 1024, 0);
    if(ret >=3D 0 || errno !=3D lasterr) {
      fprintf(stderr, "\n\t%m" + (lasterr =3D=3D -1));
      lasterr =3D errno;
      ctr =3D 0;
    }
    if(ret =3D=3D -1) {
      ++ctr;
      fprintf(stderr, "\r%u", ctr);
    } else
      fprintf(stderr, "\r%zu", ret);
    if(!ret)
      break;
  }
  fprintf(stderr, "\n");
}
-- >8 --

Ahelenia Ziemia=C5=84ska (11):
  splice: copy_splice_read: do the I/O with IOCB_NOWAIT
  af_unix: unix_stream_splice_read: always request MSG_DONTWAIT
  fuse: fuse_dev_splice_read: use nonblocking I/O
  tracing: tracing_buffers_splice_read: behave as-if non-blocking I/O
  relayfs: relay_file_splice_read: always return -EAGAIN for no data
  net/smc: smc_splice_read: always request MSG_DONTWAIT
  kcm: kcm_splice_read: always request MSG_DONTWAIT
  tls/sw: tls_sw_splice_read: always request non-blocking I/O
  net/tcp: tcp_splice_read: always do non-blocking reads
  splice: file->pipe: -EINVAL for non-regular files w/o FMODE_NOWAIT
  splice: splice_to_socket: always request MSG_DONTWAIT

 fs/fuse/dev.c        | 10 ++++++----
 fs/splice.c          |  7 ++++---
 kernel/relay.c       |  3 +--
 kernel/trace/trace.c | 32 ++++----------------------------
 net/ipv4/tcp.c       | 30 +++---------------------------
 net/kcm/kcmsock.c    |  2 +-
 net/smc/af_smc.c     |  6 +-----
 net/tls/tls_sw.c     |  5 ++---
 net/unix/af_unix.c   |  5 +----
 9 files changed, 23 insertions(+), 77 deletions(-)


base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
--
2.39.2

--pqm5boxqnux3b3rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtno0ACgkQvP0LAY0m
WPGuvA/8CDMCC3Jqrxzh67RnsX6AnDvMlmOFnNMSx1ufj+0S7i5vzt4MtSXpzAOo
zHshxG2VAylYZYhG0ifhkUpRWvwKLmxjhfz9F1mGVWa0xJsXYQX221huSygD4L49
bgYsH+XOzXfScqDRwJoXTgCXfhM8cXts2fCRYs6MS26wIY/qdqXm1NaqaNtASATv
eT0Iktoc4TkrvqbLYsvCOhpwXLU3xcdYQxj3w2nVfrzGDkeZmGNJmzz8kjCjxfvD
sAbrnnYQwZG8FpKceXBNqrtKosvonPqydFKdbA9+OJnEzma7l3NzeQ/BoUKUX9vj
rTFNZsh7jPe5fMboaL5LkMCrs4UgIXTJ04dZfgSXML4YiRs/kqbycu8jL2IyylIV
xOhjaD6/YOzfgCRkY/E/4QsVN5LkPkNnCuzleBr7OyZJxmKg39hmd69Rm8tR+bTV
cmPHxfXi2/faJ+4BW5jIsMkZwqwzJXDze9Ulr8+ZfefPSGxA5z06N2y/E/sFLWte
9PrrHPZC3A0V3oDQCm0BK1d3armLoUR7eyjVqmo+52AQue3F1rsgZHapTvtHZuAp
FsLnyjWv+JvP3smu3iA3ZnW8f8PXepWGNcPZ3zDQJGEFfUOXRsVgFOTS7/0oYyrx
YMd0ql5nhNwc+g3jsGFt1rlJK/P1FcQh0DO+XBeaYfcOLDGd6RA=
=49HP
-----END PGP SIGNATURE-----

--pqm5boxqnux3b3rj--

