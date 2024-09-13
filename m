Return-Path: <linux-fsdevel+bounces-29338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05719784D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECFA281FB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F5535D4;
	Fri, 13 Sep 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYIsiGg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0B3C485;
	Fri, 13 Sep 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241199; cv=none; b=KtGQxC29cI2Bk84V+oS3Txxr/bSIIH0pJ9n2RfgcvOEm4GTIA5AqO7uQjik+Vu0yBRj4YQd7v4LkF1e1bwoRDuewT5yyYh8lNTydFplqZRIPVP0uElg6/4QbVGLZrzqkWVN3DGnmEhRo/l7A8IHOm7Eto8rGrKfgc2PjrYni29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241199; c=relaxed/simple;
	bh=ztIFbvcKHrPQ+NfdDu5k6kNg3CZWEYi5RfxBXDsqDZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HknUXWmcTVacbuDYRTfvVSM+2Zhj1b8ymVvoWPi5GJfCl0gWAU0mBLGuayGG1rxytksSrln4zdWjkKEJah7/EsFL3xPkERTnI8darglEf/S3jMen2nsWDmgDBrgE7SjU26IOzLadjlRLxAJQI+YtuuLcu9zchEGzSwYIVXQiaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYIsiGg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DC8C4CEC0;
	Fri, 13 Sep 2024 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726241198;
	bh=ztIFbvcKHrPQ+NfdDu5k6kNg3CZWEYi5RfxBXDsqDZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYIsiGg67ZSEYjI+/JpS8X4W0kcxPK+UzDAXAdG1PyIFs3rv2bEQPuAySqIBGc5Xv
	 p5zQiVmUqbRLyMQhk8u2Bg3NCQSYyiwpzHo8fnQoBM34PTLUJC0Gx6Sy5Z2hzqm9tj
	 iD4M7OLvOn/wM9WR66B/vcjCLdmOKn/onYUTW5yrNFYeNUyw78v6GCFu1EYnoH3aJk
	 te0ADuUj45E/VLOfSrJgqCuQPaiJ7sWZcMKLgMdfWGEqshfI7ZLMuockf6xIq9InNR
	 H5RPCmR5HVOAo9q3mCoBMXa5xfX+NPl4SgRRlDcVr5OcbDKBHSWvotFUKFDpmMof6w
	 To7i5QdUXP0qg==
Date: Fri, 13 Sep 2024 16:26:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	robh@kernel.org, krzk+dt@kernel.org, oleg@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, kees@kernel.org, Liam.Howlett@oracle.com,
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, shuah@kernel.org,
	brauner@kernel.org, samuel.holland@sifive.com, andy.chiu@sifive.com,
	jerry.shih@sifive.com, greentime.hu@sifive.com,
	charlie@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	xiao.w.wang@intel.com, ajones@ventanamicro.com, anup@brainfault.org,
	mchitale@ventanamicro.com, atishp@rivosinc.com, sameo@rivosinc.com,
	bjorn@rivosinc.com, alexghiti@rivosinc.com, david@redhat.com,
	libang.li@antgroup.com, jszhang@kernel.org, leobras@redhat.com,
	guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, costa.shul@redhat.com, bhe@redhat.com,
	zong.li@sifive.com, puranjay@kernel.org, namcaov@gmail.com,
	antonb@tenstorrent.com, sorear@fastmail.com,
	quic_bjorande@quicinc.com, ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk, quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com, yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn, sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com, schwab@suse.de, dawei.li@shingroup.cn,
	rppt@kernel.org, willy@infradead.org, usama.anjum@collabora.com,
	osalvador@suse.de, ryan.roberts@arm.com, andrii@kernel.org,
	alx@kernel.org, catalin.marinas@arm.com, revest@chromium.org,
	bgray@linux.ibm.com, deller@gmx.de, zev@bewilderbeest.net
Subject: Re: [PATCH v4 15/30] riscv/mm: Implement map_shadow_stack() syscall
Message-ID: <8904b159-7798-454e-a615-34566c088fda@sirena.org.uk>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-16-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EXdCC84RfjoEE1iq"
Content-Disposition: inline
In-Reply-To: <20240912231650.3740732-16-debug@rivosinc.com>
X-Cookie: In space, no one can hear you fart.


--EXdCC84RfjoEE1iq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 12, 2024 at 04:16:34PM -0700, Deepak Gupta wrote:

> This patch implements this syscall for riscv. riscv doesn't require token
> to be setup by kernel because user mode can do that by itself. However to
> provide compatibility and portability with other architectues, user mode
> can specify token set flag.

The arm64 series also adds SHADOW_STACK_SET_MARKER for a top of stack
marker, if this is only being done for compatibility it might be good to
pick that up as well.  I don't know what the thoughts are on using them
for RISC-V.  On arm64 the top of stack marker is just all bits 0.

--EXdCC84RfjoEE1iq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbkWZsACgkQJNaLcl1U
h9BxgAf+PzUH92Qd8Gx84qFgdXuCpqKnDddOVzhJ/1HXiYtm3Yst508zBxwr03E0
oP3VhAC469mn8uOctrOJqdGHEFcC2/i3SXoyOMIp2gE+YkhdZxatybrRoCF+oNAT
AW4y0dPMgjW0i9h1kbiw/MjiHQgVoxdgULs0eZOFLl2zr+QVAD6PYLIAh/3y/lzl
e4xv7Bdh51DfKjKr7WwnKYJRGG12WjMxyOjHmy37b09h7THnjSTrg+Y/B7uQ6IpD
xS8TYwFAAn9veTqu5LuGRrKm5zBfJ+xSs78Ee/F/MZ+JgzW4ZpDbmQxuBnk33TRe
bsixBm+3DOUSeFsCCg21dGBeFYR0JQ==
=Y+Cs
-----END PGP SIGNATURE-----

--EXdCC84RfjoEE1iq--

