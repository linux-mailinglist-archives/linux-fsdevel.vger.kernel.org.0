Return-Path: <linux-fsdevel+bounces-29355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BAD9787F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D8BB233C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52F139590;
	Fri, 13 Sep 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xse7L38f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739712D773;
	Fri, 13 Sep 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252405; cv=none; b=FdH9GclVMw0UpU8Y650Pxv06GspkNBLhyhEuy32SL+5DBrj7tWhxx/0oFFPEqOwSHpR+jOEBR/BhybmMldwobvDRArzmcJ8TXxrWs2hX7o7j21nqBJnfv1ugjsna+nRDslqw3+jzufPewWbBiwqDilihPB3x2ezf5khUMYqI3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252405; c=relaxed/simple;
	bh=A1W9jCfny74eDZ2Sq3AsHaoLeaw3yFn1FM9duxuPzpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZpBf12XnyGY5gjW5UIt51wjLgyKCi9L4fobuRjIW3065jetV3iCeRrto7VDxn3XSMbGXY/HqtCvA0krG1aeg9YSnA8iKqLzu0teHYMYQfwgJ66beiiRhF+J21Bpym+DMCk4QMyI3K6KGFoqvmJDOskyXm5C6xDV9+8iRaGz7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xse7L38f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05299C4CEC0;
	Fri, 13 Sep 2024 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726252405;
	bh=A1W9jCfny74eDZ2Sq3AsHaoLeaw3yFn1FM9duxuPzpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xse7L38f6kbjvUpu6KuIcVvQkUwvvSdpQAM+baUWBOxKHwkNfN5n2a4WPozZqBe8H
	 wK0MzQxo8HaBbxuUeFJXh3/RW+hMjig/4aZGdSxtxD3LD8GbD3DRZcbszWLIfS3u+T
	 +C1yA4kCqVrgK0dsD4o3gsiA0TZa8JVM1HU/f8BtZlm8MQBlP8HkJcDN5H+1fbF5jI
	 ndbaCs1vA15EeSzoQc+9usB98O311e5c8s64OxS6Xxc1uJ16cXD1TaIJd3pdwK4a4D
	 07izK89AKA0KtL0Q249Alsfdaz8Zn0MATGInL83hMy59wNE/n9GB0mXHAaewkqPYn8
	 4wIslCdEw1Wyg==
Date: Fri, 13 Sep 2024 19:33:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@sifive.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh@kernel.org, krzk+dt@kernel.org,
	oleg@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
	alx@kernel.org, catalin.marinas@arm.com, broonie@kernel.org,
	revest@chromium.org, bgray@linux.ibm.com, deller@gmx.de,
	zev@bewilderbeest.net
Subject: Re: [PATCH v4 07/30] riscv: zicfilp / zicfiss in dt-bindings
 (extensions.yaml)
Message-ID: <20240913-woven-droplet-1f25d0d5a33b@spud>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-8-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wo0WH8RKXYiALMcP"
Content-Disposition: inline
In-Reply-To: <20240912231650.3740732-8-debug@rivosinc.com>


--Wo0WH8RKXYiALMcP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 04:16:26PM -0700, Deepak Gupta wrote:
> Make an entry for cfi extensions in extensions.yaml.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index a06dbc6b4928..b7c86fb91984 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -361,6 +361,18 @@ properties:
>              The standard Zicboz extension for cache-block zeroing as rat=
ified
>              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> =20
> +        - const: zicfilp
> +          description:
> +            The standard Zicfilp extension for enforcing forward edge co=
ntrol-flow
> +            integrity as ratified in commit 3f8e450 ("merge pull request=
 #227 from
> +            ved-rivos/0709") of riscv-cfi github repo.
> +
> +        - const: zicfiss
> +          description:
> +            The standard Zicfilp extension for enforcing forward edge co=
ntrol-flow
> +            integrity as ratified in commit 3f8e450 ("merge pull request=
 #227 from
> +            ved-rivos/0709") of riscv-cfi github repo.

Because both of these have a # in them you need to have a | after
description:. Please run dt_binding_check :)

> +
>          - const: zicntr
>            description:
>              The standard Zicntr extension for base counters and timers, =
as
> --=20
> 2.45.0
>=20

--Wo0WH8RKXYiALMcP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuSFYwAKCRB4tDGHoIJi
0vnMAP4jAcike3nNkua8hG9QWEW4+qazPoSFmDREmFEymZqK8wD/R5K+u0LGQlr6
Bci3roI9osxHgbbuooL8Ckvlomw/wAc=
=cQDJ
-----END PGP SIGNATURE-----

--Wo0WH8RKXYiALMcP--

