Return-Path: <linux-fsdevel+bounces-60699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C071B50233
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D9A16A0FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782A341AB8;
	Tue,  9 Sep 2025 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kn2NOuvD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457A3594E;
	Tue,  9 Sep 2025 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434384; cv=none; b=hAQfA3/QeMSkHe4PsPiOr7rJQm5TOnAptWzrMFevIQejhcm3BMiVCiGJ97+ifIYVH4dalq7j45FBGLaV43x/f1y0PWpMGxbePwX643Pv3G7eBo4BKdUhQXyGtZtmu099jRhm0diyMxXxjp+B3IJJAZGB4r7TM82IGG6ezxrI4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434384; c=relaxed/simple;
	bh=zF+pibFWFF+py+h3GHMhUcPWe6XzCW0OIVU4fGG31Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+EgDsyR4okaBmi1Rwlupjc1P78VWUrZldbFv+p2v4kJvhS0cYjv4JEWubx2c14cW12hBVbFTluvlRpl5TioqlKJLkbaWbMxtwfNNUulflo8kYyeVIHRQWV3oZA3ndVGl0AZ5ksuhhIehaM4Ocbwb43MHGKsLmFK/uwz9sngFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kn2NOuvD reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5515540E01B0;
	Tue,  9 Sep 2025 16:12:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WjqufeJ0WJTY; Tue,  9 Sep 2025 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757434367; bh=R6cxdKUTP067b/7o2F/e5uNSuLE+BTpfOFxYXHQQkFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kn2NOuvDOy8qA+j1Q/vTeTO7R77GC4i0Ukib8EUb2wmZoacKVuBBgqRCERAj8gN1/
	 FwW2WldBidmRNCtsWqhq+CvnCI2cLrIO7UWHurN0/OXaD6hzSSvXfCUFIGs1RIcjl+
	 5mad77mhIhzMtq5UrrgkS7qjr2/GDoasLQWh7dEQpGqEL7Fxp2EFlkQl+dHajy7aS2
	 5lOGgUBONF990KX89fnDfXsWw/hElN8aCgpwPcvVqgroat89w5wRY9Gv6Dm1tlTDd9
	 H9Ksr0+DgAJnYgzGVtfNhP/kBI2RNSgMw+AKk//8qWBSaHmQAffltBeF+odAPo+kJ7
	 jU3zHrjjLdMIEyow9s2n2l/q41zJny82p86eLCx5GE8cKQN0h0b5i/WEii0qlyGXfv
	 /KeykfLmCCwujLO+DpxzXKK0JiXkC+qg0gISuHPC9UBPjwGkVDcqzx6zsGaVV3TMY7
	 lMqRzEIBcfSuIxhQVBSHvPLlieDwUX5iL8exZPvgW7MB5i7NvUdBzeGRNxf8Jx7Nn9
	 qOUogClBFvGfZc5NFWEt9ZcKijH1ADF+qOyi6i2V6LBmhVWnh+DsDkkMi+xzZFzOVs
	 bVSmHA1seIl+yQjLwjScUfNqOZsZ8+1LuMHP4rrbYssLcQoM/mUCN5ULCnjElcoVsO
	 cNSzloV0TZma0UIFT3fUEQKU=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2365440E0176;
	Tue,  9 Sep 2025 16:12:17 +0000 (UTC)
Date: Tue, 9 Sep 2025 18:12:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	PradeepVineshReddy Kodamati <PradeepVineshReddy.Kodamati@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/6] dax/hmem, e820, resource: Defer Soft Reserved
 registration until hmem is ready
Message-ID: <20250909161210.GBaMBR2rN8h6eT9JHe@fat_crate.local>
References: <20250822034202.26896-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822034202.26896-2-Smita.KoralahalliChannabasappa@amd.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 03:41:57AM +0000, Smita Koralahalli wrote:
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c3acbd26408b..aef1ff2cabda 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1153,7 +1153,7 @@ void __init e820__reserve_resources_late(void)
>  	res =3D e820_res;
>  	for (i =3D 0; i < e820_table->nr_entries; i++) {
>  		if (!res->parent && res->end)
> -			insert_resource_expand_to_fit(&iomem_resource, res);
> +			insert_resource_late(res);
>  		res++;
>  	}
>

Btw, this doesn't even build and cover letter doesn't say what it applies
ontop so I applied it on my pile of tip/master.

kernel/resource.c: In function =E2=80=98region_intersects_soft_reserve=E2=
=80=99:
kernel/resource.c:694:36: error: =E2=80=98soft_reserve_resource=E2=80=99 =
undeclared (first use in this function); did you mean =E2=80=98devm_relea=
se_resource=E2=80=99?
  694 |         ret =3D __region_intersects(&soft_reserve_resource, start=
, size, flags,
      |                                    ^~~~~~~~~~~~~~~~~~~~~
      |                                    devm_release_resource
kernel/resource.c:694:36: note: each undeclared identifier is reported on=
ly once for each function it appears in
make[3]: *** [scripts/Makefile.build:287: kernel/resource.o] Error 1
make[2]: *** [scripts/Makefile.build:556: kernel] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:2011: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Also, I'd do this resource insertion a bit differently:

insert_resource_expand_to_fit(struct resource *new)
{
	struct resource *root =3D &iomem_resource;

	if (new->desc =3D=3D IORES_DESC_SOFT_RESERVED)
		root =3D &soft_reserve_resource;

	return __insert_resource_expand_to_fit(root, new);
}

and rename the current insert_resource_expand_to_fit() to the __ variant.

It looks like you want to intercept all callers of
insert_resource_expand_to_fit() instead of defining a separate set which =
works
on the soft-reserve thing.

Oh well, the resource code is yucky already.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

