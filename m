Return-Path: <linux-fsdevel+bounces-71016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE042CB02BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 15:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DECBA30F74CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32996263F5D;
	Tue,  9 Dec 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="c9gnRav4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8215B0EC;
	Tue,  9 Dec 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288843; cv=none; b=pYpEHCmrpAgsF6fStL8ohIKQSfX5/I8IK1/01+O5vrWIINFM4HuLzR3d83qUB43TZCRl7M21ZDL8uAsA2NiFFcx/W9SPQ57G9yINRd/7/Z2HrzLw6XInrFp6bOk1RnTd7jw+72pcqtOCUREAZf7hvq6984J70LuCSlwz8dfXsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288843; c=relaxed/simple;
	bh=7aJcdC7gJFpMHBsFFI7dYqx6C/DH+AdeopjEcNfJG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiDuOSJVDh5158hLLkeMGtcsnkA6MUPh2xjqF7/7qlZRuwJIEa7DYwYnT9ttKwfIBqINK2Tt7puKPN6cXZHVCxYcP9sAgSD8GgI7Iq5FTMEdjbJSB1IqPiHreLtn4ZhKLg36O0wx8NWnu089cLy35bN6GyzTbf/YAeqRD6lBfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=c9gnRav4; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202505; t=1765288835;
	bh=7aJcdC7gJFpMHBsFFI7dYqx6C/DH+AdeopjEcNfJG9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9gnRav46sO4Zvpjnq87F9oIWKtzB4WS0XYVeEy5gY0kDJyFM9a5alMgT0Bv0Elo6
	 85Ok+KUGWqvrR8FfWuntuf9SSGZEfXN12smBlLyiYYPJztMJgUMBG3vbiufVGyHE0K
	 5e6rpqoDY4PceOc7LiQ1BgUq0izp7uhNckUsSdUpl7AoSeogwFptl53y87UNSzlvlD
	 ecnhk0Ad3kFXcx188s+Cq1JPYBzDfLWsJPeD4bEWJUDsg6IWj02mytILBNNQR6qrZi
	 khRjrnHt/DoSEu75w4gb1FIShUjZsIdHdVoF6WKIM9NZXmbY7oVQFqNGaaK9nsmyIg
	 IENXkA84dLhRw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 8D684EE42;
	Tue,  9 Dec 2025 15:00:35 +0100 (CET)
Date: Tue, 9 Dec 2025 15:00:35 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tmpfs: enforce the immutable flag on open files
Message-ID: <mmfrclxjf2mmmohiwdbgqhyyrlab33tpnmtuzatk2xsuyiglrp@tarta.nabijaczleweli.xyz>
References: <toyfbuhwbqa4zfgnojghr4v7k2ra6uh3g3sikbuwata3iozi3m@tarta.nabijaczleweli.xyz>
 <be986c18-3db2-38a1-8401-f0035ab71e7a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odzmi4uh2rsyvvsv"
Content-Disposition: inline
In-Reply-To: <be986c18-3db2-38a1-8401-f0035ab71e7a@google.com>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--odzmi4uh2rsyvvsv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2025 at 08:14:44PM -0800, Hugh Dickins wrote:
> On Mon, 8 Dec 2025, Ahelenia Ziemia=C5=84ska wrote:
> > This useful behaviour is implemented for most filesystems,
> > and wants to be implemented for every filesystem, quoth ref:
> >   There is general agreement that we should standardize all file systems
> >   to prevent modifications even for files that were opened at the time
> >   the immutable flag is set.  Eventually, a change to enforce this at
> >   the VFS layer should be landing in mainline.
> >=20
> > References: commit 02b016ca7f99 ("ext4: enforce the immutable flag on
> >  open files")
> > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.=
xyz>
> Sorry: thanks, but no thanks.
>=20
> Supporting page_mkwrite() comes at a cost (an additional fault on first
> write to a folio in a shared mmap).  It's important for space allocation
> (and more) in the case of persistent writeback filesystems, but unwelcome
> overhead in the case of tmpfs (and ramfs and hugetlbfs - others?).

Yeah, from the way page_mkwrite() was implemented it looked like
enough of a pessimisation to be significant, and with how common
an operation this is, I kinda expected this result.

(I was also gonna post the same for ramfs,
 but it doesn't support FS_IOC_SETFLAGS attributes at all.)

> tmpfs has always preferred not to support page_mkwrite(), and just fail
> fstests generic/080: we shall not slow down to change that, without a
> much stronger justification than "useful behaviour" which we've got
> along well enough without.

How do we feel about just the VFS half of this,
i.e. open(WR)/chattr +i/write() =3D -EPERM?
That shouldn't have a performance impact.

(I'll admit that this is the behaviour I find to be useful,
 and I was surprised that the ext4 implementation also made mappings
 SIGBUS, but I implemented both out of an undue sense of completionism.)

> But it is interesting that tmpfs supports IMMUTABLE, and passes all
> the chattr fstests, without this patch.  Perhaps you should be adding
> a new fstest, for tmpfs to fail: I won't thank you for that, but it
> would be a fair response!

I rather think having IMMUTABLE but not atomically perfusing it
to file descriptions is worthy of a test failure.
The mmap behaviour, not so much.

> Hugh
>=20
> > ---
> > v1: https://lore.kernel.org/linux-fsdevel/znhu3eyffewvvhleewehuvod2wrf4=
tz6vxrouoakiarjtxt5uy@tarta.nabijaczleweli.xyz/t/#u
> >=20
> > shmem_page_mkwrite()'s return 0; falls straight into do_page_mkwrite()'s
> > 	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> > 		folio_lock(folio);
> > Given the unlikely, is it better to folio_lock(folio); return VM_FAULT_=
LOCKED; instead?
> >=20
> > /ext4# uname -a
> > Linux tarta 6.18.0-10912-g416f99c3b16f-dirty #1 SMP PREEMPT_DYNAMIC Sat=
 Dec  6 12:14:41 CET 2025 x86_64 GNU/Linux
> > /ext4# while sleep 1; do echo $$; done > file &
> > [1] 262
> > /ext4# chattr +i file
> > /ext4# sh: line 25: echo: write error: Operation not permitted
> > sh: line 25: echo: write error: Operation not permitted
> > sh: line 25: echo: write error: Operation not permitted
> > sh: line 25: echo: write error: Operation not permitted
> > fg
> > while sleep 1; do
> >     echo $$;
> > done > file
> > ^C
> > /ext4# mount -t tmpfs tmpfs /tmp
> > /ext4# cd /tmp
> > /tmp# while sleep 1; do echo $$; done > file &
> > [1] 284
> > /tmp# chattr +i file
> > /tmp# sh: line 35: echo: write error: Operation not permitted
> > sh: line 35: echo: write error: Operation not permitted
> > sh: line 35: echo: write error: Operation not permitted
> >=20
> > $ cat test.c
> > #include <unistd.h>
> > #include <fcntl.h>
> > #include <sys/ioctl.h>
> > #include <linux/fs.h>
> > #include <sys/mman.h>
> > int main(int, char **argv) {
> > 	int fd =3D open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0666);
> > 	ftruncate(fd, 1024 * 1024);
> > 	char *addr =3D mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE, MAP_SHA=
RED, fd, 0);
> > 	addr[0] =3D 0x69;
> > 	int attrs =3D FS_IMMUTABLE_FL;
> > 	ioctl(3, FS_IOC_SETFLAGS, &attrs);
> > 	addr[1024 * 1024 - 1] =3D 0x69;
> > }
> >=20
> > # strace ./test /tmp/file
> > execve("./test", ["./test", "/tmp/file"], 0x7ffc720bead8 /* 22 vars */)=
 =3D 0
> > ...
> > openat(AT_FDCWD, "/tmp/file", O_RDWR|O_CREAT|O_TRUNC, 0666) =3D 3
> > ftruncate(3, 1048576)                   =3D 0
> > mmap(NULL, 1048576, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D 0x7f09b=
bf2a000
> > ioctl(3, FS_IOC_SETFLAGS, [FS_IMMUTABLE_FL]) =3D 0
> > --- SIGBUS {si_signo=3DSIGBUS, si_code=3DBUS_ADRERR, si_addr=3D0x7f09bc=
029fff} ---
> > +++ killed by SIGBUS +++
> > Bus error
> > # tr -d \\0 < /tmp/file; echo
> > i
> >=20
> >  mm/shmem.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >=20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index d578d8e765d7..432935f79f35 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1294,6 +1294,14 @@ static int shmem_setattr(struct mnt_idmap *idmap,
> >  	bool update_mtime =3D false;
> >  	bool update_ctime =3D true;
> > =20
> > +	if (unlikely(IS_IMMUTABLE(inode)))
> > +		return -EPERM;
> > +
> > +	if (unlikely(IS_APPEND(inode) &&
> > +		     (attr->ia_valid & (ATTR_MODE | ATTR_UID |
> > +					ATTR_GID | ATTR_TIMES_SET))))
> > +		return -EPERM;
> > +
> >  	error =3D setattr_prepare(idmap, dentry, attr);
> >  	if (error)
> >  		return error;
> > @@ -2763,6 +2771,17 @@ static vm_fault_t shmem_fault(struct vm_fault *v=
mf)
> >  	return ret;
> >  }
> > =20
> > +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> > +{
> > +	struct file *file =3D vmf->vma->vm_file;
> > +
> > +	if (unlikely(IS_IMMUTABLE(file_inode(file))))
> > +		return VM_FAULT_SIGBUS;
> > +
> > +	file_update_time(file);
> > +	return 0;
> > +}
> > +
> >  unsigned long shmem_get_unmapped_area(struct file *file,
> >  				      unsigned long uaddr, unsigned long len,
> >  				      unsigned long pgoff, unsigned long flags)
> > @@ -3475,6 +3494,10 @@ static ssize_t shmem_file_write_iter(struct kioc=
b *iocb, struct iov_iter *from)
> >  	ret =3D generic_write_checks(iocb, from);
> >  	if (ret <=3D 0)
> >  		goto unlock;
> > +	if (unlikely(IS_IMMUTABLE(inode))) {
> > +		ret =3D -EPERM;
> > +		goto unlock;
> > +	}
> >  	ret =3D file_remove_privs(file);
> >  	if (ret)
> >  		goto unlock;
> > @@ -5286,6 +5309,7 @@ static const struct super_operations shmem_ops =
=3D {
> >  static const struct vm_operations_struct shmem_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> >  	.map_pages	=3D filemap_map_pages,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> >  	.get_policy     =3D shmem_get_policy,
> > @@ -5295,6 +5319,7 @@ static const struct vm_operations_struct shmem_vm=
_ops =3D {
> >  static const struct vm_operations_struct shmem_anon_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> >  	.map_pages	=3D filemap_map_pages,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> >  	.get_policy     =3D shmem_get_policy,
> > --=20
> > 2.39.5


--odzmi4uh2rsyvvsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmk4K4AACgkQvP0LAY0m
WPHX8w/+LF/sRkV9GkZuIiCTm3dARfQYYA5sEFRR/SAK44U4sWNpR5fS2NgVBvk+
wr+2CyVTTNHauBm0GpUuKKyYQtrhof8pQKYyC2i8Jz0Ty1azn/Dvm2Y9D3rVUa8B
Oo7w+7kQr1ON8MdTPiV0ekjO2ru/YqIUMvsaNSuxyqALjlZ+oDTlpOCGnj9fb2Jf
Nd83pErmVChI/cg7kACHXiJmrUNJd1QeNmkbu2uGnAKq5+n9kjsfKaYOCTiOr+ex
HAhCKk2yRvDaZ7vtSAlOUBB7ZD4dXFe187Vqms8Wyw3q21ztAvWCLwEPkzWYdnS7
6O5Y9IHmwmW3ESFVl0fJcaSb4nVL2LZTtNYUecB88lV+LiMaBOeeDA8yeqcinMnP
yYkgw8EfI5qYrdsDjYAXC0L8FY3IMXgWXIKpf8rhCMp0fDp5IwID6ujma0lu2TaU
eQgBTD/y8seAQykOJ/+ORoCR0zMVdeA4qeaJkwWANExCX+jjjucsUtoZ1ADu0mu4
4Ir8WdHqEQaxdo+rxdgD/M4kU5zBd9fBcI0+OhFywEHD5R4+Au2wKbwaKlYRleKG
Bq1U4Az183uceHRMeVEigRYfYmpCqSkhQTcrq+JfxkFbr72JSogt5CKcu21QQgXI
rWRQThCmT8heUpjiWNEI8B5eOL5TJkmeyPCaK2qU59E/K5oviXc=
=IeM0
-----END PGP SIGNATURE-----

--odzmi4uh2rsyvvsv--

