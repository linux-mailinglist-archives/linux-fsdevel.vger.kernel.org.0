Return-Path: <linux-fsdevel+bounces-20395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B08D2BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F61F23A1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9F15B11E;
	Wed, 29 May 2024 04:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g/x/3/ID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1E13D899
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957364; cv=none; b=MaVJnMjzTKoJxxwVivVbQCIF5EcDt5HtAQ/IN0yhSSuN05jG5765HtP8pcwkPUQzT11Dx+E3UtdE3M+gFaruz4GWUHA4fAibzZ2PQqlJrDAAMECd3boqHM8/GZQcNEOpQh5S1si0tr13NoK3pIYMIDyiUn+QSS9mibNjEfKzWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957364; c=relaxed/simple;
	bh=5KTfUHI0jDcwa34YJd3Ur7D8+vfTOuG6wlcWa9tNFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kw1+oZJq6VffXMmF/YMtpzQZvBXJAmdH1QC4ZTNeGIr9WPBUOt4KeTfh67odRHQrzlljZ7aRqLzEihBR44IW4AtcSX/L/8av7tnWfX3Q3xzunDaNy8lYYTPSCLzOe9rozseV1ZrR5RGITEU1Y+lv8BEVXFD1Ydolkt5I8IYX7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=g/x/3/ID; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1716957358;
	bh=FwLxyjdpQGT0Jy+ZsUM+Aj6l1hXJ7c+T8bFBkmWjYhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/x/3/IDvLEvTYZCVLShVod/Eut8uVJruE3cSl2Rla087pG8Sv8ixQWWVktq8KAxr
	 +pPj7hfNhE3abo11qdGGiD4SVfGxw5vLDbvyfsPmEMqhmWG6wOw/BAR60C38HXkSEg
	 DMeIIfRXtaazcBeXyTvpEj+tH7mjBGbP4mGf5+9k0twMG0yFS0L5/LHl786n8A7QCG
	 oG4RqQctAuBq6ymb0roKJYdX5Os3JCp+L+86mfh2i/NWLwS/7uSPzJosgrzIcJb7H6
	 9WGRwxIVa2lJrBfu7jWmn6WVOlLthScmeR40RAQ305s5Uj2giyRgUHGKlF/NRjlKCX
	 Vl7ZffbbNZiLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpxQk68vrz4wqK;
	Wed, 29 May 2024 14:35:58 +1000 (AEST)
Date: Wed, 29 May 2024 14:35:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240529143558.4e1fc740@canb.auug.org.au>
In-Reply-To: <20240528091629.3b8de7e0@canb.auug.org.au>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
	<20240520132326.52392f8d@canb.auug.org.au>
	<ZkvCyB1-WpxH7512@casper.infradead.org>
	<20240528091629.3b8de7e0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W+6VDACPlRiJlp2vAc1E+cp";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W+6VDACPlRiJlp2vAc1E+cp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 28 May 2024 09:16:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 20 May 2024 22:38:16 +0100 Matthew Wilcox <willy@infradead.org> w=
rote:
> >
> > As I understand the structure of linux-next right now, you merge one
> > tree after another in some order which isn't relevant to me, so I have =
no
> > idea what it is.  What we're asking for is that we end up with a branch
> > in your tree called fs-next that is:
> >=20
> >  - Linus's tree as of that day
> >  - plus the vfs trees
> >  - plus xfs, btrfs, ext4, nfs, cifs, ...
> >=20
> > but not, eg, graphics, i2c, tip, networking, etc
> >=20
> > How we get that branch is really up to you; if you want to start by
> > merging all the filesystem trees, tag that, then continue merging all t=
he
> > other trees, that would work.  If you want to merge all the filesystem
> > trees to fs-next, then merge the fs-next tree at some point in your list
> > of trees, that would work too.
> >=20
> > Also, I don't think we care if it's a branch or a tag.  Just something
> > we can call fs-next to all test against and submit patches against.
> > The important thing is that we get your resolution of any conflicts.
> >=20
> > There was debate about whether we wanted to include mm-stable in this
> > tree, and I think that debate will continue, but I don't think it'll be
> > a big difference to you whether we ask you to include it or not? =20
>=20
> OK, I can see how to do that.  I will start on it tomorrow.  The plan
> is that you will end up with a branch (fs-next) in the linux-next tree
> that will be a merge of the above trees each day and I will merge it
> into the -next tree as well.

OK, this is what I have done today:

I have created 2 new branches local to linux-next - fs-current and fs-next.

fs-current is based on Linus' tree of the day and contains the
following trees (name, contacts, URL, branch):

fscrypt-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mi=
t.edu>, Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fs=
crypt/linux.git	for-current
fsverity-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@m=
it.edu>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-current
btrfs-fixes	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/lin=
ux/kernel/git/kdave/linux.git	next-fixes
vfs-fixes	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/li=
nux/kernel/git/viro/vfs.git	fixes
erofs-fixes	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux=
/kernel/git/xiang/erofs.git	fixes
nfsd-fixes	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/sc=
m/linux/kernel/git/cel/linux	nfsd-fixes
v9fs-fixes	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub/=
scm/linux/kernel/git/ericvh/v9fs.git	fixes/next
overlayfs-fixes	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73i=
l@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.gi=
t	ovl-fixes


The fs-next tree is based on fs-current and contains these trees:

bcachefs	Kent Overstreet <kent.overstreet@linux.dev>	https://evilpiepirate.=
org/git/bcachefs.git	for-next
pidfd	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub/scm/l=
inux/kernel/git/brauner/linux.git	for-next
fscrypt	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>, =
Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fscrypt/li=
nux.git	for-next
afs	David Howells <dhowells@redhat.com>	git://git.kernel.org/pub/scm/linux/=
kernel/git/dhowells/linux-fs.git	afs-next
btrfs	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/linux/ker=
nel/git/kdave/linux.git	for-next
ceph	Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>	gi=
t://github.com/ceph/ceph-client.git	master
cifs	Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>	g=
it://git.samba.org/sfrench/cifs-2.6.git	for-next
configfs	Christoph Hellwig <hch@lst.de>	git://git.infradead.org/users/hch/c=
onfigfs.git	for-next
erofs	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux/kerne=
l/git/xiang/erofs.git	dev
exfat	Namjae Jeon <linkinjeon@kernel.org>	git://git.kernel.org/pub/scm/linu=
x/kernel/git/linkinjeon/exfat.git	dev
exportfs	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/=
linux/kernel/git/cel/linux	exportfs-next
ext3	Jan Kara <jack@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/=
jack/linux-fs.git	for_next
ext4	Theodore Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/linux/kerne=
l/git/tytso/ext4.git	dev
f2fs	Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/linux/ke=
rnel/git/jaegeuk/f2fs.git	dev
fsverity	Eric Biggers <ebiggers@kernel.org>, Theodore Y. Ts'o <tytso@mit.ed=
u>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-next
fuse	Miklos Szeredi <miklos@szeredi.hu>	git://git.kernel.org/pub/scm/linux/=
kernel/git/mszeredi/fuse.git	for-next
gfs2	Steven Whitehouse <swhiteho@redhat.com>, Bob Peterson <rpeterso@redhat=
.com>	git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git	for=
-next
jfs	Dave Kleikamp <dave.kleikamp@oracle.com>	git://github.com/kleikamp/linu=
x-shaggy.git	jfs-next
ksmbd	Steve French <smfrench@gmail.com>	https://github.com/smfrench/smb3-ke=
rnel.git	ksmbd-for-next
nfs	Trond Myklebust <trondmy@gmail.com>	git://git.linux-nfs.org/projects/tr=
ondmy/nfs-2.6.git	linux-next
nfs-anna	Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.c=
om>, NFS Mailing List <linux-nfs@vger.kernel.org>	git://git.linux-nfs.org/p=
rojects/anna/linux-nfs.git	linux-next
nfsd	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linu=
x/kernel/git/cel/linux	nfsd-next
ntfs3	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>	https:/=
/github.com/Paragon-Software-Group/linux-ntfs3.git	master
orangefs	Mike Marshall <hubcap@omnibond.com>	git://git.kernel.org/pub/scm/l=
inux/kernel/git/hubcap/linux	for-next
overlayfs	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmai=
l.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git	over=
layfs-next
ubifs	Richard Weinberger <richard@nod.at>	git://git.kernel.org/pub/scm/linu=
x/kernel/git/rw/ubifs.git	next
v9fs	Dominique Martinet <asmadeus@codewreck.org>	git://github.com/martinetd=
/linux	9p-next
v9fs-ericvh	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub=
/scm/linux/kernel/git/ericvh/v9fs.git	ericvh/for-next
xfs	Darrick J. Wong <djwong@kernel.org>, David Chinner <david@fromorbit.com=
>, <linux-xfs@vger.kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linu=
x.git	for-next
zonefs	Damien Le Moal <Damien.LeMoal@wdc.com>	git://git.kernel.org/pub/scm/=
linux/kernel/git/dlemoal/zonefs.git	for-next
iomap	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs/x=
fs/xfs-linux.git	iomap-for-next
djw-vfs	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs=
/xfs/xfs-linux.git	vfs-for-next
file-locks	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/li=
nux/kernel/git/jlayton/linux.git	locks-next
iversion	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/linu=
x/kernel/git/jlayton/linux.git	iversion-next
vfs-brauner	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub=
/scm/linux/kernel/git/vfs/vfs.git	vfs.all
vfs	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/linux/ke=
rnel/git/viro/vfs.git	for-next


Please let me know if you want them reordered or some removed/added.

Both these branches will be exported with the linux-next tree each day.

--=20
Cheers,
Stephen Rothwell

--Sig_/W+6VDACPlRiJlp2vAc1E+cp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmZWsK4ACgkQAVBC80lX
0GzNDwf/XLRKgeDO1tyeiNrcwQrsMuPNJPLJNNhB5D5088qQY5qV0ZZeQ+xDBimX
jMSyYVVl2yMH8QmGKTUeShwnOUHEK04RRXD7P2U0THYEO7Ong6JvfGID5K3R+nct
Uj9xO4a+9dS0ZOn0iMthP1q0sFbKKYBpUegaXJdtrNfoxkJxJUPghFIz5H06GE4x
quMbCCY9vZOZvG7wPtZoh2TY59Zb6qH5ZAGuouN3+XyOqdItyhUGpxBZxxVhVl7V
cPb22KPLrGATnu6ovm9d1ys6zgKpptqgc3NLefqVklcZXVcx5BtYK+BHC6hPAWCU
AxG8+7vldh08xVe66ZdtJgOIyrfgtw==
=+pA9
-----END PGP SIGNATURE-----

--Sig_/W+6VDACPlRiJlp2vAc1E+cp--

