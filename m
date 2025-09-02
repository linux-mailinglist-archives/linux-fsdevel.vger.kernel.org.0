Return-Path: <linux-fsdevel+bounces-59980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29696B3FF52
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43659541A23
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A25304971;
	Tue,  2 Sep 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlfauluX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E1288C36;
	Tue,  2 Sep 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814351; cv=none; b=meNUXO2Ay5WSBnuLUx4vejvK6y03N+ll18IiWkAGDkwrYYvqEEhJLq68rlcgbGKyGJKtrs6dMJ47KYBPYp3yM7jOyb6WO6uyXrvfBwE7zxxpsM9DT2JeoZeD/epwcc4RdZ8OjNXQk3AdT7aEjY3n88ZohwfEAetUPh6iCvSa+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814351; c=relaxed/simple;
	bh=L1nH0nXQSTmGQMPXIz8uvF0lJhnD30PA+J/QkPBeCK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/twVAR2oOZfUfX8a0TG4AkciSZr2Itrzq0uot5Rzd3mbgA82mE+6mT7YOzFscy9wVuzIVqT7lsxKTqp49EE2IbzW/TIbqTL0sqNNkrPzVxf7xYCo+2r88Os8c9mRKa3MUGGBnL6ak0Gd0isQRyK3fLNNSBkvCUBLH4kYcGnO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlfauluX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C02EC4CEED;
	Tue,  2 Sep 2025 11:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756814351;
	bh=L1nH0nXQSTmGQMPXIz8uvF0lJhnD30PA+J/QkPBeCK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlfauluXXRsFwdzO38odnlUZfYgoe1CFxonN5cpywYXv/xECjHvycDgDUatmFw6ia
	 mUBDe5ELuiqS8LGCHYzjqgY9atl9gzcJssdfaXwr1lZtfNIX+aFH9UpdxKVWr2hY6o
	 VDLCD80ua4Jz6DivTFtnW+4o83n4pkdiuavOJlynXYAeyflZipfyz6W8Oc25vrDK06
	 V29Vfpbmwl5PHuDi2Rr+x1QhtvO48PuKGszUIh2E5zTCPTSEE1+2o43q4S0XKjtdNU
	 JBHIBh4AmLL5ANN4WvPQ4ZSZLskhnZK0dslMn8n6iV2b6JEvBe14AOjuZFUh5A59jT
	 OoRg1GK9oxOYA==
Date: Tue, 2 Sep 2025 14:58:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net,
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com,
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org,
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev,
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com,
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, saeedm@nvidia.com,
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com,
	witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
Message-ID: <aLbb9nOUnBo_ORT0@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-30-pasha.tatashin@soleen.com>
 <20250826162019.GD2130239@nvidia.com>
 <aLXIcUwt0HVzRpYW@kernel.org>
 <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bC96fxHBb78DvNhyfdjsDfPCLY5J5cN8W0hUDt9KAPBJQ@mail.gmail.com>

On Mon, Sep 01, 2025 at 04:54:15PM +0000, Pasha Tatashin wrote:
> On Mon, Sep 1, 2025 at 4:23 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Aug 26, 2025 at 01:20:19PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Aug 07, 2025 at 01:44:35AM +0000, Pasha Tatashin wrote:
> > >
> > > > +   /*
> > > > +    * Most of the space should be taken by preserved folios. So take its
> > > > +    * size, plus a page for other properties.
> > > > +    */
> > > > +   fdt = memfd_luo_create_fdt(PAGE_ALIGN(preserved_size) + PAGE_SIZE);
> > > > +   if (!fdt) {
> > > > +           err = -ENOMEM;
> > > > +           goto err_unpin;
> > > > +   }
> > >
> > > This doesn't seem to have any versioning scheme, it really should..
> > >
> > > > +   err = fdt_property_placeholder(fdt, "folios", preserved_size,
> > > > +                                  (void **)&preserved_folios);
> > > > +   if (err) {
> > > > +           pr_err("Failed to reserve folios property in FDT: %s\n",
> > > > +                  fdt_strerror(err));
> > > > +           err = -ENOMEM;
> > > > +           goto err_free_fdt;
> > > > +   }
> > >
> > > Yuk.
> > >
> > > This really wants some luo helper
> > >
> > > 'luo alloc array'
> > > 'luo restore array'
> > > 'luo free array'
> >
> > We can just add kho_{preserve,restore}_vmalloc(). I've drafted it here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=kho/vmalloc/v1
> 
> The patch looks okay to me, but it doesn't support holes in vmap
> areas. While that is likely acceptable for vmalloc, it could be a
> problem if we want to preserve memfd with holes and using vmap
> preservation as a method, which would require a different approach.
> Still, this would help with preserving memfd.

I can't say I understand what you mean by "holes in vmap areas". We anyway
get an array of folios in memfd_pin_folios() and at that point we know
exactly how many folios there is. So we can do something like

	preserved_folios = vmalloc_array(nr_folios, sizeof(*preserved_folios));
	memfd_luo_preserve_folios(preserved_folios, folios, nr_folios);
	kho_preserve_vmalloc(preserved_folios, &folios_info);

> However, I wonder if we should add a separate preservation library on
> top of the kho and not as part of kho (or at least keep them in a
> separate file from core logic). This would allow us to preserve more
> advanced data structures such as this and define preservation version
> control, similar to Jason's store_object/restore_object proposal.

kho_preserve_vmalloc() seems quite basic and I don't think it should be
separated from kho core. kho_array is already planned in a separate file :)
 
> > Will wait for kbuild and then send proper patches.
> >
> >
> > --
> > Sincerely yours,
> > Mike.
> 

-- 
Sincerely yours,
Mike.

