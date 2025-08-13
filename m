Return-Path: <linux-fsdevel+bounces-57648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1EB2424A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 09:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD17173FE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9103D2D6E59;
	Wed, 13 Aug 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NocSEfYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1A1E7C1C;
	Wed, 13 Aug 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068998; cv=none; b=Tj1BXlIcG/hf4BVXYgeM5zSyxDrIaRuoax0zfVJkg2g6SAtVmyXLhcY/Cv4bKoY0yb0OkEY4Pih1Uu2r4mCA53cOHosTzv1z7pSNZo4VYaXhotkyJPr/j3SqClf50oFxz/8VRF69E0gQFOmoQN4MLkmW9dgrZ8b15wDcg9DnhX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068998; c=relaxed/simple;
	bh=qYxBarsfIxoqtVOdgyZu0XSkWfI2wWyZlaofZIWXx50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caIPPPPCqirBX9piD6ZjZYTWZJG2cpxb0oxBHzIQXLeoiQxSWFGXc8svuUfusMkbY6lqXJxlC8gbdOkdu+BZpm3sGb8iUWnKVSPEUUirnifE43/n9UB7dw8WfXvchxUzFxs7cY1tyscQoTOaasL4K4WInH/RGVJE2TSFyrhX5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NocSEfYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA26AC4CEEB;
	Wed, 13 Aug 2025 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755068998;
	bh=qYxBarsfIxoqtVOdgyZu0XSkWfI2wWyZlaofZIWXx50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NocSEfYLe30ZRY2fHD2eMr9WqjHVuC9F/px//tLPS15SsrzoG9iv1HwM8iQDKE67S
	 ZqIZrwB6jm/9KKfam0/4WZbDHX0t5+hxCiBriTSU8w8f0hqWmVGvbCFp0w4JQSDEvS
	 7dYDYI0kpYCmumRuzXCuANSWpidAV9iKz8KGjkmU=
Date: Wed, 13 Aug 2025 09:09:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com,
	leonro@nvidia.com, witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <2025081310-custodian-ashamed-3104@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250813063407.GA3182745.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813063407.GA3182745.vipinsh@google.com>

On Tue, Aug 12, 2025 at 11:34:37PM -0700, Vipin Sharma wrote:
> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> > +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
> > +					unsigned int nr_folios)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < nr_folios; i++) {
> > +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
> > +		struct folio *folio;
> > +
> > +		if (!pfolio->foliodesc)
> > +			continue;
> > +
> > +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
> > +
> > +		kho_unpreserve_folio(folio);
> 
> This one is missing WARN_ON_ONCE() similar to the one in
> memfd_luo_preserve_folios().

So you really want to cause a machine to reboot and get a CVE issued for
this, if it could be triggered?  That's bold :)

Please don't.  If that can happen, handle the issue and move on, don't
crash boxes.

thanks,

greg k-h

