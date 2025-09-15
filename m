Return-Path: <linux-fsdevel+bounces-61442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25901B582B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 19:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745071896CDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B922D28314A;
	Mon, 15 Sep 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECx+Kj5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8571632C8;
	Mon, 15 Sep 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757955842; cv=none; b=ZWWlOT/zNSmngrQd6yVLGCh/S8sA0wwRzg+r40Oi/lbsfVwhnQ0oTsKAEvUcyHN4RrbyArVDYAlYqWcBTh9GBlojFCTH7LJ5nFYaFHxDbQPAtrmy6qXWS7Vgc/lqAi99MyDMKOUxyGJSvU4DHmx12OMA+TYDKppcn47Sp/mT4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757955842; c=relaxed/simple;
	bh=181A4EhfptUEgvkmfyOG1EPOfLyDWETtVkYBcXrHa9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwPdCF6kqLH+le99mjpl1QmwiWPGq4Z/LCZ0BoBZqOtLpG/oxSm2LYV8ztBT4FGuAYIQBnr1M01ICRCb1mFFIyG07fOdyDi4Q4Eqtx44gWJ9ZeJNND47Bxxn2iLh2MkxWZfiSZ+4ee48k6WT1XuJMfoRBeduCuW+DFZXch22XW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECx+Kj5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0DC4CEF1;
	Mon, 15 Sep 2025 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757955840;
	bh=181A4EhfptUEgvkmfyOG1EPOfLyDWETtVkYBcXrHa9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECx+Kj5wt0FqonvHZaoVS7UFjqUwTm7Wn3cnoSf4DK1LNun8/l9DlZJwILZFIXfh+
	 3w72zJ+PJ69uWw4UjqiTh9EKRbyxq5hsK7Bdt47WA44OnfB2oakBECDKiAwoncE5DU
	 zUdEPIWGxdbwhHJzZHnmfApdsTz/VQ9TEm4BOwNSBTYt3eBmxO9aB0O1oHHNocczZ/
	 /7ayJCAboiKBVT9Sv59fgnd+DxCUl+K/8YfrDkrtA/9Q3CFfiuuplm88pDf5IpQZMD
	 BrTFlYLhObQ7aqM8UhzUPBsjj4CYlrh/EsdjQHZuQleXs83Y+22NrNXZYGFuAF0Pgt
	 +BBkvp8qVwh6g==
Date: Mon, 15 Sep 2025 18:03:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V12 3/5] riscv: Add RISC-V Svrsw60t59b extension support
Message-ID: <20250915-landowner-parsnip-d6778ee7208f@spud>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
 <20250915101343.1449546-4-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W4tzl3gVaVkMEf2q"
Content-Disposition: inline
In-Reply-To: <20250915101343.1449546-4-zhangchunyan@iscas.ac.cn>


--W4tzl3gVaVkMEf2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 06:13:41PM +0800, Chunyan Zhang wrote:
> The Svrsw60t59b extension allows to free the PTE reserved bits 60
> and 59 for software to use.
>=20
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig             | 14 ++++++++++++++
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpufeature.c |  1 +
>  3 files changed, 16 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 51dcd8eaa243..e1b6a95952c4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -862,6 +862,20 @@ config RISCV_ISA_ZICBOP
> =20
>  	  If you don't know what to do here, say Y.
> =20
> +config RISCV_ISA_SVRSW60T59B
> +	bool "Svrsw60t59b extension support for using PTE bits 60 and 59"
> +	depends on MMU && 64BIT
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	  Adds support to dynamically detect the presence of the Svrsw60t59b
> +	  extension and enable its usage.
> +
> +	  The Svrsw60t59b extension allows to free the PTE reserved bits 60
> +	  and 59 for software to use.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>  	def_bool y
>  	# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Daed44=
286efa8ae8717a77d94b51ac3614e2ca6dc
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index affd63e11b0a..f98fcb5c17d5 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -106,6 +106,7 @@
>  #define RISCV_ISA_EXT_ZAAMO		97
>  #define RISCV_ISA_EXT_ZALRSC		98
>  #define RISCV_ISA_EXT_ZICBOP		99
> +#define RISCV_ISA_EXT_SVRSW60T59B	100
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 743d53415572..2ba71d2d3fa3 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -539,6 +539,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA(svrsw60t59b, RISCV_ISA_EXT_SVRSW60T59B),
>  	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),

If this is not ACPI only, than you need to document this in the
extensions dt-binding.

--W4tzl3gVaVkMEf2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaMhG+QAKCRB4tDGHoIJi
0owvAP9m+kVfXRCCjk7NRGmDZkEWZQj0HAJD4FE/4xEk8z9WfAEAkX7zbB5CNqiz
ha+ygzCsG/SA9BdVUSZUo2x+PGGLIgo=
=YrBp
-----END PGP SIGNATURE-----

--W4tzl3gVaVkMEf2q--

