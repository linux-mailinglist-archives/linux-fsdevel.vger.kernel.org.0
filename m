Return-Path: <linux-fsdevel+bounces-60368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B13B46080
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 19:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744B21BC033F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404C36CDF4;
	Fri,  5 Sep 2025 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlX8viSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CB3568EA;
	Fri,  5 Sep 2025 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094242; cv=none; b=SlFruBpjPAR6OE2E6eJd2AMQP+YOow9owedJuEB7nJ+R7Yr7DUWgKXIV8hcmzg+S90p/9Me+yBACOeSFwkTRVfay32/Kqc8SkvtFIcsBAKzVgGcFa9c58QEhGEOTVJuwwQbc2gWATFWJXryUz8H9cB0E1Mh8K/HGnBnTDS2dFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094242; c=relaxed/simple;
	bh=0R6uBNi0AxfzUpfBexoCE08XIxfXyiwY7sLKg5k0QaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/dutFdNK3E93c2mq6JN5dRyuhdaOvfyDXtigZLhD3+MS4hngxDKhPTewH/+DI2cIHd6DQ1WhccgEsAwE6LchCA2ao/B7w/X8YsISXXVLp/m/dDd0xLB/etIMXs1Bqdd/8rxz3/XVwGNb3ISLPZVwM0bhg3kY5JuXIgRQX1UnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlX8viSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5AC4CEF4;
	Fri,  5 Sep 2025 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094242;
	bh=0R6uBNi0AxfzUpfBexoCE08XIxfXyiwY7sLKg5k0QaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlX8viStcFxK79FfJuuymzNpbjrTTtyuePmbEcriYprpXNyHMPVynqL6XQhSJCXiW
	 4vhqgm49kw8WKmrk6DdElWfQmQfP7+Or1iQEMwjD0WJUicJccWcmFH4mUnXxjAlLqD
	 gsu66JjFHfS6Du7juXWBtoZ1G5Tq+zQfyT71Kg/oV0EpczIOFG6uL0+r+M/5kur/r9
	 X1eciZId07CH09tPojFm6OMji6KQ4FV8//PSWz+jVcNLPEjNbwbLGvQxBCwk57VDuQ
	 bru1m+TRFmp+EbI4MP1c3j3cR13WPotrZMNKrjvhdRmUeLkKk43RrCkFBh1B9Pt1uu
	 pSwr9Lo+72vIQ==
Date: Fri, 5 Sep 2025 18:43:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
	riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
	Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel-team@meta.com, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v5 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Message-ID: <c8249725-e91d-4c51-b9bb-40305e61e20d@sirena.org.uk>
References: <20250815135549.130506-1-usamaarif642@gmail.com>
 <20250815135549.130506-7-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wfr62XQcW9Sye/W3"
Content-Disposition: inline
In-Reply-To: <20250815135549.130506-7-usamaarif642@gmail.com>
X-Cookie: Yow!  I threw up on my window!


--wfr62XQcW9Sye/W3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 02:54:58PM +0100, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
> be made to disable all THPs and skip if it fails.

I don't think this is an issue in this patch but with it we're seeing
build failures in -next on arm64 with:

  make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc =
CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueabi=
hf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kci=
/linux -j98 kselftest-gen_tar

  ...

    CC       prctl_thp_disable
  prctl_thp_disable.c: In function =E2=80=98test_mmap_thp=E2=80=99:
  prctl_thp_disable.c:64:39: error: =E2=80=98MADV_COLLAPSE=E2=80=99 undecla=
red (first use in this function); did you mean =E2=80=98MADV_COLD=E2=80=99?
     64 |                 madvise(mem, pmdsize, MADV_COLLAPSE);
        |                                       ^~~~~~~~~~~~~
        |                                       MADV_COLD

since the headers_install copy of asm-generic/mman-common.h doesn't
appear to being picked up with the above build invocation (most others
are fine).  I'm not clear why, it looks like an appropriate -isystem
ends up getting passed to the compiler:

  aarch64-linux-gnu-gcc -Wall -O2 -I /linux/tools/testing/selftests/../../.=
=2E  -isystem /tmp/kci/linux/build/usr/include -isystem /linux/tools/testin=
g/selftests/../../../tools/include/uapi -U_FORTIFY_SOURCE -D_GNU_SOURCE=3D =
    prctl_thp_disable.c vm_util.c thp_settings.c -lrt -lpthread -lm -o /tmp=
/kci/linux/build/kselftest/mm/prctl_thp_disable

but the header there is getting ignored AFAICT.  Probably the problem is
fairly obvious and I'm just being slow - I'm not quite 100% at the
minute.

Thanks to Aishwarya for confirming which patch triggered the issue.

--wfr62XQcW9Sye/W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi7IVgACgkQJNaLcl1U
h9BkKAf+JqqrHvX7cSXvElB+KK5JJPomvr2GjT43I3RCnUxuhhf+HNozf1vZSVsh
8ouaFjM+bdFsoFZGH+lHQrwf1jASur/DGPQf77HWkWGyXoT9DU0TC4/aFBydTyHD
HOhxlD64/GHWMcf4EiYbqAQUVwWItGmpA7A02pWTHKMqP2mRlNfAIBnuGYhX+yng
T5icV/TPDU+vgWkkGTq5gNCWwwsD6aoxTE5mXDPkiGvQwJ5APXoYiAei4h7bj3Ob
aWBr719s4YylshIwSt4XX7WP6FYex3GtCSrOGUCFoV9JA18UBWbWKb/Kemgb/drt
Um6GBJNcKG8OSXdAFAeidRIrg5wqGg==
=7I+y
-----END PGP SIGNATURE-----

--wfr62XQcW9Sye/W3--

