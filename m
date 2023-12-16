Return-Path: <linux-fsdevel+bounces-6306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88458157CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 06:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CCE1F25E86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 05:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945E314F64;
	Sat, 16 Dec 2023 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="WBSo1taz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8114A83;
	Sat, 16 Dec 2023 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702704967;
	bh=aXnoT232WwWHgfmnBEf5kRCch5zxKwiyDSBVAzHL3tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBSo1tazy/08XXU9lJ1fiU7CJGM+DZ0UVxTun5Dpr+Ab3nDFgCPq4qufHpayrfm5p
	 XVUYv5J5saPOR6MhCZ9KZcHyRCjfhgIxNm2cDErKX7ZqVbJCv/ger+lX7i+XdJwEMd
	 FYrwSmtSSqc/orcQeKS5b70NVtqAQ2o0Sii0mjO6eQmrCkL7RRWilXGKAU05siNV8e
	 Pn2N8aTCuTZ9GdA6+EPBZBzfGQX9G6IJ7ieFAJjUb34pv5at4qZoWKTDwPeqvj9JND
	 8dTBcA8NvL6Lv8pYnHdAV0DyRKY/kpzmCcSdcO8v7SDOz7Dvhk6bQoyvcGaiHUvdrR
	 fnOvKcbX60NDQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id AAD581393A;
	Sat, 16 Dec 2023 06:36:07 +0100 (CET)
Date: Sat, 16 Dec 2023 06:36:07 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RERESEND 10/11] splice: file->pipe: -EINVAL for
 non-regular files w/o FMODE_NOWAIT
Message-ID: <3fgbhh5bxahcutguae7suxf6y54sjnwxld5gwnuvmnqqksiw2w@tarta.nabijaczleweli.xyz>
References: <2cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <25974c79b84c0b3aad566ff7c33b082f90ac5f17e.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <107ff087-92de-4be5-a205-610376d41d72@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmqjzpmtgjj7keg7"
Content-Disposition: inline
In-Reply-To: <107ff087-92de-4be5-a205-610376d41d72@kernel.dk>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--rmqjzpmtgjj7keg7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 08:47:15AM -0700, Jens Axboe wrote:
> On 12/14/23 11:45 AM, Ahelenia Ziemia=C5=84ska wrote:
> > We request non-blocking I/O in the generic implementation, but some
> > files =E2=80=92 ttys =E2=80=92 only check O_NONBLOCK. Refuse them here,=
 lest we
> > risk sleeping with the pipe locked for indeterminate lengths of
> > time.
> A worthy goal here is ensuring that _everybody_ honors IOCB_NOWAIT,
> rather than just rely on O_NONBLOCK. This does involve converting to
> ->read_iter/->write_iter if the driver isn't already using it, but some
> of them already have that, yet don't check IOCB_NOWAIT or treat it the
> same as O_NONBLOCK.
This doesn't really mean much to me, sorry.

> Adding special checks like this is not a good idea, imho.
That's what Linus said I should do so that's what I did
  https://lore.kernel.org/linux-fsdevel/CAHk-=3DwimmqG_wvSRtMiKPeGGDL816n65=
u=3DMq2+H3-=3DuM2U6FmA@mail.gmail.com/

I can't fix the tty layer :/

> > This also masks inconsistent wake-ups (usually every second line)
> > when splicing from ttys in icanon mode.
> >=20
> > Regular files don't /have/ a distinct O_NONBLOCK mode,
> > because they always behave non-blockingly, and for them FMODE_NOWAIT is
> > used in the purest sense of
> >   /* File is capable of returning -EAGAIN if I/O will block */
> > which is not set by the vast majority of filesystems,
> > and it's not the semantic we want here.
>=20
> The main file systems do very much set it, like btrfs, ext4, and xfs. If
> you look at total_file_systems / ones_flagging_it the ratio may be high,
> but in terms of installed userbase, the majority definitely will have
> it. Also see comment on cover letter for addressing this IOCB_NOWAIT
> confusion.
Reassessing
[1] https://lore.kernel.org/linux-fsdevel/5osglsw36dla3mubtpsmdwdid4fsdacpl=
yd6acx2igo4atogdg@yur3idyim3cc/
I see FMODE_NOWAIT in
  blockdevs
  /dev/{null,zero,random,urandom}
  btrfs/ext4/f2fs/ocfs2/xfs
  eventfd
  pipes
  sockets
  tun/tap
which means that vfat/fuse/nfs/tmpfs/ramfs/procfs/sysfs don't.
(zfs also doesn't, but that's not for this list.)

I don't know if that's actually a "majority" in a meaningful sense,
I agree, but I think I primarily committed to this exclusion because
tmpfs/ramfs didn't.

I s'pose ramfs can already be tagged since it already returns
-EAGAIN when I/O would block (never).

tmpfs not being spliceable is also questionable.

But this'd also mean effectively deleting
  afs_file_splice_read
  ceph_splice_read
  coda_file_splice_read
  ecryptfs_splice_read_update_atime
  fuse_dev_splice_read
  nfs_file_splice_read
  orangefs_file_splice_read
  shmem_file_splice_read
  v9fs_file_splice_read
(not to mention the many others (adfs/affs/bfs/bcachefs/cramfs/erofs/fat/hf=
s*/hostfs/hpfs/jffs2/jfs/minix/nilfs/ntfs/omfs/reiserfs/isofs/sysv/ubifs/ud=
f/ufs/vboxsf/squashfs/romfs)
 which just use the filemap impl verbatim).

There's no point to restricting splice access on a per-filesystem level
(which this'd do), since to mount a malicious network filesystem you
need to be root.

A denial of service attack makes no sense if you're already root.

(Maybe except for fuse, which people typically run suid;
 that I could see potentially making sense to disable..)


I have indeed managed to confuse myself into the NOWAIT hole,
but this is actually about
"not letting unprivileged users escalate into
 hanging system daemons by writing to a pipe"
rather than
"if we ever hold the pipe lock for >2=C2=B5s we die instantly".

O_NONBLOCK filtered by FMODE_NOWAIT is used as a semantic proxy for
the 10 different types of files anyone can create that we know are safe.

Anyone can open a socket and not write to it, so we must refuse to
splice from a socket with no data in it.
But only root can mount filesystems, so a regular file is always safe.

And, actually defining a slightly-heuristic per-file policy in the syscall
itself is stupid, you've talked me out of this.
This check only actually applies to the generic copy_splice_read()
implementation, since the "real"/non-generic splices
(fiemap_splice_read/per-filesystem =E2=80=92
 all the others that this patchset touches)
are already known to be safe
(and aren't reads so FMODE_NOWAIT doesn't factor in at all).

I've dropped this patch and have instead added this to 01/11:
  diff --git a/fs/splice.c b/fs/splice.c
  index f8bfc9cf8cdc..6d369d7d56d5 100644
  --- a/fs/splice.c
  +++ b/fs/splice.c
  @@ -331,0 +332,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppo=
s,
  +	/*
  +	 * This generic implementation is only safe w.r.t. the pipe lock
  +	 * if the file actually respects IOCB_NOWAIT, which ttys don't.
  +	 */
  +	if (!(in->f_mode & FMODE_NOWAIT))
  +		return -EINVAL;

(Indeed, in many ways, Linus' post to which I reply in [1] pretty much
 says this explcitly. Actually he literally says this. I just don't
 realise and instead of adding the snippet to copy_splice_read(),
 which he already diffed and talks about, I copied it to the syscall.)

Now I just need to re-consider the prose in a way
that avoids this deeply embarrassing IOCB_NOWAIT/regular-file nonsense,
and this series ends up being just "fixing splice implementations"
without also special-casing the syscall itself.

Thanks for asking the right questions.
Sorry for longposting.

--rmqjzpmtgjj7keg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV9N0QACgkQvP0LAY0m
WPEFhQ/+JEJkg2UN2u3CMMALcIl2g06TTIJ+SBp+pL62UognmNXJuNR5k4dxnLEW
4R2QG+LOGCMzWkoEfjdv3l/Ga+4FBEX5OCdklB4DvYvQ+lMwLBOOo99ieOg3yJ7Z
LLp7iDZdFzB0Fvktrn+yAOAFrwlvNUYaVk4+19GQqo/Iho71OXnNE9YmyHGmEmm3
AQdH6mjT2fQ4yqNqfq250DTO0Cf95hMaKTd69/buTUJfMU++geAqBSG+PA8UBDmM
DUZKKBg0mcAnk3Y3aEC0uu4AhuuBkVi4sRQOmyB71qr7pH9S8tkOaj1xzUOWqX25
/bs45Yn4BwznhorDjpXd4e5VK7bIDwJxxBVxZF4CqacLf562jcFWosCjlKBW67pA
p0792IouTl81HmZi7ACYhuSwk81AodhNupPTdcIcP22EF0c01YueZJCPGwLedtkS
jlBehN79P9P+L26GDOI06VQEvJ4p7ZmhS/OB4EHPKQBZHyXlCUjUyNByeVa1s48K
pkoTRdqmyz0eUXKSiJl593mRGob4fvEGFL9G71/jgNfRS2ltWJfkMD9lyN4Ka9is
5s3KGhAjfH1uwSLeWgHt0EerUIXNyaMSiY6RON6tLj6eymX6K8sE8+itAO3gYnUj
dsY7S4pmG9NVL9Im08My/xAhZKf4ENcl1DBfxcCMSPO8zIEcmOM=
=FGvh
-----END PGP SIGNATURE-----

--rmqjzpmtgjj7keg7--

