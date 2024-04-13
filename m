Return-Path: <linux-fsdevel+bounces-16858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BA8A3C17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CBB28395E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593E3C46B;
	Sat, 13 Apr 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDqSIGaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5814265;
	Sat, 13 Apr 2024 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713002473; cv=none; b=RzeQnn6FjQtFSU+jdvm46tbjKFp1Ba/D0LnTQghZhv4xKQLe8hecRcW6jVxL4aVmiP4xqXOr6s//H1OUy1smE5A15DI8hR5It7KmcO4UL+4M6GwL1aMoCEwxpgJU1+LtC6jjhAHuF7aaytdIrJ0CgUuQ10bGMmFTQh0idEt+gnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713002473; c=relaxed/simple;
	bh=M8jzyVtgD1C3f4LkPu9lLRDNvCWXKSwAyeVD4GJA+0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYvnvJsD8Rja6zEy7+N50yUo6eagubt3vkR82JQPgdF/1/oDBp+CvmgvVLfh/yTKhoGXW5MTEfAspIEWzsI6d8qNE0vCIHD/QW3od54/94479jLZTRs5ZJiB99q/g8kCO+hBcbDE9X+Igr4+FtMpAbv++EJ1NIVHE8ujxpD62Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDqSIGaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A686C4AF0D;
	Sat, 13 Apr 2024 10:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713002472;
	bh=M8jzyVtgD1C3f4LkPu9lLRDNvCWXKSwAyeVD4GJA+0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MDqSIGawNAVQorIkIpn+/2QhThS0S2hvseA7ElQRoNzI1lAODuWbvWRePH/moP0K1
	 aYo/+4AtTxFNy+DPSPHzQZ766DHK4FdFXZ5eCUSPHcDDP8O8rwk/5fengDxFj3MoTI
	 q84dAWhts56Mfjc+Cs3A1sFeehJCoacYnCC0ENjh+ORBGNf5j+YaEBbi1BuAMux+F1
	 aeQPz1J2wKKcMyByrAZnqq63Io9lHLK4KB0K05DbiaZEy4h06qQcR2X2XaTadH1wbj
	 SwKRKpp0hFKEB3VYwHgsWeVmlS/ocbVedTHtqzeDP9fDplNt3L22AhAnlux5nEhTUI
	 rhMGZNAgrHBcg==
Date: Sat, 13 Apr 2024 11:01:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240413-ranging-uselessly-4b1de2210593@spud>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240412154342.GA1310856@mit.edu>
 <87a5lyecuw.fsf@all.your.base.are.belong.to.us>
 <20240413043542.GE187181@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FJpzzv1jTl7B+Rbm"
Content-Disposition: inline
In-Reply-To: <20240413043542.GE187181@mit.edu>


--FJpzzv1jTl7B+Rbm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:35:42AM -0400, Theodore Ts'o wrote:
> On Fri, Apr 12, 2024 at 06:59:19PM +0200, Bj=F6rn T=F6pel wrote:
> >=20
> >   $ pipx install tuxrun
> >=20
> > if you're on Debian.
> >=20
> > Then you can get the splat by running:
> >=20
> >   $ tuxrun  --runtime docker --device qemu-riscv32 --kernel https://sto=
rage.tuxsuite.com/public/linaro/lkft/builds/2esMBaAMQJpcmczj0aL94fp4QnP/Ima=
ge.gz --parameters SKIPFILE=3Dskipfile-lkft.yaml --parameters SHARD_NUMBER=
=3D10 --parameters SHARD_INDEX=3D1 --image docker.io/linaro/tuxrun-dispatch=
er:v0.66.1 --tests ltp-controllers
>=20
> Yeah, what I was hoping for was a shell script or a .c file hich was
> the reproducer, because that way I can run the test in my test infrastruc=
ture [1]
>=20
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-x=
fstests.md
>=20
> I'm sure there are plenty of nice things about tuxrun, but with
> kvm-xfstests I can easily get a shell so I can run the test sccript by
> hand, perhaps with strace so I can see what is going on.  Or I attach
> gdb to the kernel via "gdb /path/to/vmlinux" and "target remote
> localhost:7499".
>=20
> I'm guessing that "ltp-controllers" means that the test might be from
> the Linux Test Project?  If so, that's great because I've added ltp
> support to my test infrastructure (which also supports blktests,
> phoronix test suite, and can be run on gce and on android devices in
> addition to qemu, and on the arm64, i386, and x86_64 architectures).
>=20
> > Build with "make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu-", and =
make
> > sure to have the riscv64 cross-compilation support (yes, same toolchain
> > for rv32!).
> >=20
> > It's when the rootfs is mounted, and the kernel is looking an init.
>=20
> Hmm, so this happening as soon as the VM starts, before actually
> starting to run any tests?  Is it possible for you to send me the
> rootfs as a downloading image, as opposed to my trying to paw through
> the docker image?
>=20
> > I'll keep debugging -- it was more if anyone had seen it before. I'll
> > try to reproduce on some other 32b platform as well.
>=20
> Well, it's not happening on my rootfs on i386 using my test infrastructur=
e:
>=20
> % cd /usr/projects/linux/ext4
> % git checkout v6.8
> % install-kconfig --arch i386
> % kbuild --arch i386
> % kvm-xfstests shell
>     ...
> root@kvm-xfstests:~# cd ltp
> root@kvm-xfstests:~# ./runltp
>=20
> (I don't have ltp support fully automated the way I can run blktests
> using "kvm-xfstests --blktests" or run xfstests via "gce-xfstests -c
> ext4/all -g auto".  The main missing is teaching ltp to create an
> junit xml results file so that the test results can be summarized and
> so the test results can be more easily summarized and compared against
> past runs on different kernel versions.)
>=20
> Anyway, if you can send me your rootfs, I can try to take a look at it.

I think this should be the rootfs here:
https://drive.google.com/file/d/1HIo8EkAKY0xpTIIlwd9fXjRzmIdD7BUA/view?usp=
=3Dsharing

I also attempted to bisect this and ended up at a slightly different
commit to Bjorn: 8c9440fea774 ("Merge tag 'vfs-6.8.mount' of git://git.kern=
el.org/pub/scm/linux/kernel/git/vfs/vfs")
That's a merge of 3f6984e7301f & 5bd3cf8cbc8a, both of which booted for
me. I also tried to bisect in reverse to find the fix a la syzbot, since it
is not broken in 6.9, but that's pretty error prone and I ended up down
branches based on 6.7 and was not able to find the fix.

--FJpzzv1jTl7B+Rbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhpX4wAKCRB4tDGHoIJi
0tRqAQCXXbOrWb84G1BMCnEc/q7K6gnaG6NpDOGxRUtn77Aj9wD/Z8HV03soxS6w
zP3EBHNHEyYrQfbMFW54iQq7kSvAjgk=
=6oYE
-----END PGP SIGNATURE-----

--FJpzzv1jTl7B+Rbm--

