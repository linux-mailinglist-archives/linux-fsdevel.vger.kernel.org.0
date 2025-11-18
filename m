Return-Path: <linux-fsdevel+bounces-68939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E0C691FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 23D7B2B19F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D56359FA5;
	Tue, 18 Nov 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdNW3Shx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05F3538BE;
	Tue, 18 Nov 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465475; cv=none; b=lAWPhakv28XwMolInznAre/X3RSxZKU/GtAcoB531fXsSkDXdA77C/DNbZz7K7+GryEJa8VwJkwKIdWHVYp/LShMv4Rhxaxn9veXIRQqLmFH71lEdlO9ImMGLEFGBOtKI2Dvo6jk8idZt1oqxuIJgUYcstJCzxhAW/TTAw1GTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465475; c=relaxed/simple;
	bh=TDbb2U/vh1bt7ZPBFidhpKgCXs1OsPq/ve44MJ2AfpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuV51jLoJNb4fII5mAJMEKA7pRrVPkssvkzhuQ7h/hxwPjB6yi9hZL+m6tK0cu3AjdRsIeE6+KxneOuJ3iG61fyGyC42lCAXxIMDpZd1Hcqc5jMR2YthQGJy28/QfZxt4fWkQ9uPL2ZLUGbKwBK/ctwZJ+w9ZhqO94MSi7zz1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdNW3Shx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F6BC2BCB1;
	Tue, 18 Nov 2025 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763465475;
	bh=TDbb2U/vh1bt7ZPBFidhpKgCXs1OsPq/ve44MJ2AfpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdNW3ShxByK3KPJ6f/r4xo57HHF29jYKzlWJMzAoEG5qhL4vUeTW7q0vODegzHk7x
	 Fcht3rxnbZ0AavV8SEB946ijmPMW63uMz1a6R3WkynBS68yVMJHaDkrh5Vi2CJxKij
	 mL9IWsuiO1hWsOgISGtBoNd7dui5+O7QMhgUupFQl+q75AQCLry25dVxM7lSoo5bCX
	 myydjdFJZlkHu8XkDHAhal5Sn5XDPCIw+PLb82EM6sTiT7UHDrQDrG8g3phkrgwzHz
	 JLOWWFQitPFaMb1HLyyXjecgPX26uBVyuXrodjRAsemgX7QeO14EYdKbQE9Bq8GUpJ
	 QFR4M+EFzMI8Q==
Date: Tue, 18 Nov 2025 13:30:47 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
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
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com,
	skhawaja@google.com, chrisl@kernel.org
Subject: Re: [PATCH v6 20/20] tests/liveupdate: Add in-kernel liveupdate test
Message-ID: <aRxY53gBbeH-6L0Y@kernel.org>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-21-pasha.tatashin@soleen.com>
 <aRsDb-4bXFQ9Zmtu@kernel.org>
 <CA+CK2bCfPeY558f499JHKN7aekDzsxQkZJ9Uz4e+saR0qtXyfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCfPeY558f499JHKN7aekDzsxQkZJ9Uz4e+saR0qtXyfg@mail.gmail.com>

On Mon, Nov 17, 2025 at 02:00:15PM -0500, Pasha Tatashin wrote:
> > >  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> > > index df337c9c4f21..9a531096bdb5 100644
> > > --- a/kernel/liveupdate/luo_file.c
> > > +++ b/kernel/liveupdate/luo_file.c
> > > @@ -834,6 +834,8 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> > >       INIT_LIST_HEAD(&fh->flb_list);
> > >       list_add_tail(&fh->list, &luo_file_handler_list);
> > >
> > > +     liveupdate_test_register(fh);
> > > +
> >
> > Why this cannot be called from the test?
> 
> Because test does not have access to all file_handlers that are being
> registered with LUO.

Unless I'm missing something, an FLB users registers a file handlers and
let's LUO know that it will need FLB. Why the test can't do the same?
 
> Pasha

-- 
Sincerely yours,
Mike.

