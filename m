Return-Path: <linux-fsdevel+bounces-5436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D0C80BBB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3428EB20ACC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570CA14F88;
	Sun, 10 Dec 2023 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq7auFPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E2125B2;
	Sun, 10 Dec 2023 14:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C6C433C7;
	Sun, 10 Dec 2023 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702218371;
	bh=AltcgXfkx0PNaD9wf1JDyoUG7rn4S77782W4sTsGUNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vq7auFPJszjdbN+XSlFWTTSN8msZgwSHdmUs+/mxgnq/dPouFj+2DIVC+c4h6iVld
	 SGbt3aLb/7nystgPRKEf7NSSDX0ZqFqtKQr8PwXxuac5QCTzo6t869phO8kPgiNRFe
	 54YG+RXdLgh9DzMgc9ORuatGgcji9XMx8WlV6jp7ynFZlP+bW3C1n/kQN+LGdIUKdv
	 SZ5EadX1jb+gdpO9EAkrVwJAIKD9u6uLwSKC+3aOwG1CVtbnFxTxqbRvsCaGJlfeIE
	 vwGtv5UVMOKBXl6UyHsSQFzlfsZn55aePZLOb+WRCurO11dmN5ZDDuosmWf8s/ijB2
	 wlq2W1a0vjr2Q==
Date: Sun, 10 Dec 2023 14:23:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com,
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
	rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
	jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6H2z5ZEGXpRtGmb"
Content-Disposition: inline
In-Reply-To: <20231206103702.3873743-6-surenb@google.com>
X-Cookie: Monotheism is a gift from the gods.


--a6H2z5ZEGXpRtGmb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:36:59AM -0800, Suren Baghdasaryan wrote:
> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> into destination buffer while checking the contents of both after
> the move. After the operation the content of the destination buffer
> should match the original source buffer's content while the source
> buffer should be zeroed. Separate tests are designed for PMD aligned and
> unaligned cases because they utilize different code paths in the kernel.
>=20
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c     |  24 +++
>  tools/testing/selftests/mm/uffd-common.h     |   1 +
>  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>  3 files changed, 214 insertions(+)

This breaks the build in at least some configurations with separate
output directories like those used by KernelCI:

make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc CR=
OSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf=
- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kci/l=
inux -j10 kselftest-gen_tar

(full logs for both arm64 and x86_64 at):

   https://storage.kernelci.org/next/master/next-20231208/arm64/defconfig/g=
cc-10/logs/kselftest.log
   https://storage.kernelci.org/next/master/next-20231208/x86_64/x86_64_def=
config/clang-17/logs/kselftest.log

or tuxmake:

make --silent --keep-going --jobs=3D16 O=3D/home/broonie/.cache/tuxmake/bui=
lds/25/build INSTALL_PATH=3D/home/broonie/.cache/tuxmake/builds/25/build/ks=
elftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPI=
LE_COMPAT=3Darm-linux-gnueabihf- kselftest-install

The specific failure:

aarch64-linux-gnu-gcc -Wall -I /tmp/kci/linux/tools/testing/selftests/../..=
/..  -isystem /tmp/kci/linux/build/usr/include     uffd-stress.c vm_util.c =
uffd-common.c -lrt -lpthread -lm -o /tmp/kci/linux/build/kselftest/mm/uffd-=
stress
uffd-common.c: In function =E2=80=98move_page=E2=80=99:
uffd-common.c:636:21: error: storage size of =E2=80=98uffdio_move=E2=80=99 =
isn=E2=80=99t known
  636 |  struct uffdio_move uffdio_move;
      |                     ^~~~~~~~~~~
uffd-common.c:643:21: error: =E2=80=98UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES=E2=
=80=99 undeclared (first use in this function)
  643 |  uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
uffd-common.c:643:21: note: each undeclared identifier is reported only onc=
e for each function it appears in
uffd-common.c:645:17: error: =E2=80=98UFFDIO_MOVE=E2=80=99 undeclared (firs=
t use in this function); did you mean =E2=80=98UFFDIO_COPY=E2=80=99?
  645 |  if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
      |                 ^~~~~~~~~~~
      |                 UFFDIO_COPY
uffd-common.c:636:21: warning: unused variable =E2=80=98uffdio_move=E2=80=
=99 [-Wunused-variable]
  636 |  struct uffdio_move uffdio_move;
      |                     ^~~~~~~~~~~

--a6H2z5ZEGXpRtGmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV1yfMACgkQJNaLcl1U
h9BZ+gf/UkFwJK/bQHdsM2z3PX8a8hGKETQ2aXDe+QSyV8SLbiBkgQAZt5ZV2EpQ
upT7zDDXsAwZY3f1ovuYd7UNK8KqMjakLxGTaQtNcoEnnGv4d8FjCZYvVODQYTGM
CtvpWTI9IqsgU67qiPHecWVs+HDF6K0y+nLpXkvMwRFeOeMO0uE1IBIhIPrPRK/K
nwhuPLti4PfE/92SMVfCdXIqypM5ZfGkE+7gwege+/lqtGCKiJW8ylFpczBPNSCN
WCasm6E6IOvsnWFhSvGNx/tRZ5YYKpO4ndn9d0onO60JmvBg7PJ1bBmBo7G1gPGv
iUEnb2qdbO4CPRHkGKm03zAW5LfJ3g==
=e4gY
-----END PGP SIGNATURE-----

--a6H2z5ZEGXpRtGmb--

