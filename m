Return-Path: <linux-fsdevel+bounces-44717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3BEA6BC88
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 15:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E15D18943DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE42139CE3;
	Fri, 21 Mar 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtomZVYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671AE78F4F;
	Fri, 21 Mar 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565967; cv=none; b=oggcR3ozITnKIK7UsEMWxFKe7+g7tdVuvNIwoaWzi0GfwSPivl26jasmzmVY/cmAg4PQhgjuHGr63uBiFKy9uckN2g35HfXi9ATLbtDYrrfVb0bslWzjMTJ+HkWRWmVXMgJMvGL/X+R94V4BLD9pFvLj2ltYCq8LqV3Ovch6jxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565967; c=relaxed/simple;
	bh=Efp2oPA71k6HAIzm+TmV+Ye55dV032TIttlnUM1IzOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP4dZjge06WWZVIETqAXnWV1kh9tzKgjIBL6HpV0w4wCAMoKdy7qUC1EzZp729cT96zLBqw7kI+CiWR7K+o10SlhjsSbh9yYxAFCOLfMng5iP9dlWLWZdDC0AkF++08zSaXsTP4axRG4UqGaybzxu6GPk47qdFLLhSQfNP9OJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtomZVYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F51FC4CEE9;
	Fri, 21 Mar 2025 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742565966;
	bh=Efp2oPA71k6HAIzm+TmV+Ye55dV032TIttlnUM1IzOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TtomZVYeDy8wuAU9Z1FLMBCNPF80tqxAb9OYMid0PPJqMYM3GP6Y13h3xTFT3duda
	 EsZJtubJ4eo1f27/8eijbytMXypXK9OpAQvtR6SSvixcT5H5Vii2MhLoL5SLtzb/Lu
	 0s/caJoC/vby0Y1EP4mDAykVW2LxQXapv6BFXtpmQyPrxZgK6STqVkdLGCyTYHu8Vm
	 mCCFPWNOppzziuF3ByXKJs3Ie2dXyK1dl1rP19u8nYcVc1S745ZPh8fdb1rtan7e9q
	 Du4G1UQee+eAtGBrbvm+tFS9gYh0kewyZAIG31l16DPgHomybi/A7b0/1WpyBnZYBO
	 txFCMNNUxYjnQ==
Date: Fri, 21 Mar 2025 14:05:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, liam.howlett@oracle.com,
	alexandru.elisei@arm.com, peterx@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, m.szyprowski@samsung.com, iamjoonsoo.kim@lge.com,
	mina86@mina86.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, jack@suse.cz,
	hbathini@linux.ibm.com, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, aneesh.kumar@kernel.org, bhelgaas@google.com,
	sj@kernel.org, fvdl@google.com, ziy@nvidia.com, yuzhao@google.com,
	minchan@kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Minchan Kim <minchan@google.com>
Subject: Re: [RFC 3/3] mm: integrate GCMA with CMA using dt-bindings
Message-ID: <20250321-unhelpful-doze-791895ca5b01@spud>
References: <20250320173931.1583800-1-surenb@google.com>
 <20250320173931.1583800-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fM541kW8FgR5YYtY"
Content-Disposition: inline
In-Reply-To: <20250320173931.1583800-4-surenb@google.com>


--fM541kW8FgR5YYtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:39:31AM -0700, Suren Baghdasaryan wrote:
> This patch introduces a new "guarantee" property for shared-dma-pool.
> With this property, admin can create specific memory pool as
> GCMA-based CMA if they care about allocation success rate and latency.
> The downside of GCMA is that it can host only clean file-backed pages
> since it's using cleancache as its secondary user.
>=20
> Signed-off-by: Minchan Kim <minchan@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/powerpc/kernel/fadump.c |  2 +-
>  include/linux/cma.h          |  2 +-
>  kernel/dma/contiguous.c      | 11 ++++++++++-
>  mm/cma.c                     | 33 ++++++++++++++++++++++++++-------
>  mm/cma.h                     |  1 +
>  mm/cma_sysfs.c               | 10 ++++++++++
>  6 files changed, 49 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4b371c738213..4eb7be0cdcdb 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -111,7 +111,7 @@ void __init fadump_cma_init(void)
>  		return;
>  	}
> =20
> -	rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
> +	rc =3D cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma, =
false);
>  	if (rc) {
>  		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
>  		/*
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 62d9c1cf6326..3207db979e94 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -46,7 +46,7 @@ extern int __init cma_declare_contiguous_multi(phys_add=
r_t size,
>  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					const char *name,
> -					struct cma **res_cma);
> +					struct cma **res_cma, bool gcma);
>  extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsi=
gned int align,
>  			      bool no_warn);
>  extern bool cma_pages_valid(struct cma *cma, const struct page *pages, u=
nsigned long count);
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 055da410ac71..a68b3123438c 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -459,6 +459,7 @@ static int __init rmem_cma_setup(struct reserved_mem =
*rmem)
>  	unsigned long node =3D rmem->fdt_node;
>  	bool default_cma =3D of_get_flat_dt_prop(node, "linux,cma-default", NUL=
L);
>  	struct cma *cma;
> +	bool gcma;
>  	int err;
> =20
>  	if (size_cmdline !=3D -1 && default_cma) {
> @@ -476,7 +477,15 @@ static int __init rmem_cma_setup(struct reserved_mem=
 *rmem)
>  		return -EINVAL;
>  	}
> =20
> -	err =3D cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &c=
ma);
> +	gcma =3D !!of_get_flat_dt_prop(node, "guarantee", NULL);

When this (or if I guess) this goes !RFC, you will need to document this
new property that you're adding.

--fM541kW8FgR5YYtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ91yRgAKCRB4tDGHoIJi
0vghAQCIfI8+ZQNSSUJvyG5N5hCisJl/fWg9Vm7F5uQooGdzzwD/TYcjtjBBKsJv
aa6VSuGFaENELpO0FBTADe4awZ04uA0=
=vA0y
-----END PGP SIGNATURE-----

--fM541kW8FgR5YYtY--

