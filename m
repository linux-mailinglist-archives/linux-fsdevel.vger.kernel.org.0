Return-Path: <linux-fsdevel+bounces-62690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB4B9D73F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 07:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9304B4A74E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 05:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109142E8B82;
	Thu, 25 Sep 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVj3KhY5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1B2E88B7;
	Thu, 25 Sep 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778004; cv=none; b=rNgv/2TEBVxdHq2+xFNxPxvLWwG17HTiJUmLZhA5OuCeIsY3uA+JK/8qh6/ZddhOFIaXKD1sYqZCgt1CEwif/faM2XNVy5ARqIJHpfc2RpFbOAOPwlWZLBKxThpViHgFJQxuO/ja846m8vb/LuhVEYCWDkipkHvvJLMRbsu6GM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778004; c=relaxed/simple;
	bh=BNRQR3uWduxmA/6u9Cv6/W8BxTysuUBqfh49YF/xNYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+5zHwoE/SNcb5fwH18n0w57R0KRrTUxcammD/GF+KlfzhZjzSgP+cVxe0uMXW7rp0FUtabm9ahGCUf1ZgllX6yEBvIHpZyndHPUDvAx0JpNrdb+nmT7uhAld4/lsQ6BA9R0c4lP7vPciYpfnqB2LXpanFHNTq92AlH2hA9HY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVj3KhY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B14C4CEF4;
	Thu, 25 Sep 2025 05:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758778003;
	bh=BNRQR3uWduxmA/6u9Cv6/W8BxTysuUBqfh49YF/xNYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVj3KhY5wukwzEiBt8uWRSzv7shISP8AtittLXXWK4MgDs1TJQV8RwdkT/F3DdmvD
	 p37uB4YVV1XeafMxoX7wAOAFJALpFX87iX0K8Dfdo0+WW9Uz3lvbS7yMR/vH9CwOoV
	 TmR2TxqZAmxy4H6MB72wHQq5vcQnVyVWXR1J9UtdHiRspEh1H/OrGQRZomKHxMd0G0
	 DxlIfVQDgdSRNOXQ9awsF+cnsSF7ZDZeMDMRUrbCOg/ZlJzI9rAEnYK+54oXLzJH6y
	 U1lCFDlB9Qrb5OPL6EytR3BVESAQ/Z4IO7VXTW4XLxoOC6Zudnh2akPkyc77goW9By
	 D17otkxhDaI4Q==
Date: Thu, 25 Sep 2025 08:26:18 +0300
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
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
Message-ID: <aNTSelHwg7mvs1KI@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com>
 <20250814132233.GB802098@nvidia.com>
 <aJ756q-wWJV37fMm@kernel.org>
 <20250818135509.GK802098@nvidia.com>
 <CA+CK2bDc+-R=EuGM2pU=Phq8Ui-8xsDm0ppH6yjNR0U_o4TMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDc+-R=EuGM2pU=Phq8Ui-8xsDm0ppH6yjNR0U_o4TMHg@mail.gmail.com>

On Sun, Sep 21, 2025 at 06:20:50PM -0400, Pasha Tatashin wrote:
> On Mon, Aug 18, 2025 at 9:55 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Aug 15, 2025 at 12:12:10PM +0300, Mike Rapoport wrote:
> > > > Which is perhaps another comment, if this __get_free_pages() is going
> > > > to be a common pattern (and I guess it will be) then the API should be
> > > > streamlined alot more:
> > > >
> > > >  void *kho_alloc_preserved_memory(gfp, size);
> > > >  void kho_free_preserved_memory(void *);
> > >
> > > This looks backwards to me. KHO should not deal with memory allocation,
> > > it's responsibility to preserve/restore memory objects it supports.
> >
> > Then maybe those are luo_ helpers
> >
> > But having users open code __get_free_pages() and convert to/from
> > struct page, phys, etc is not a great idea.
> 
> I added:
> 
> void *luo_contig_alloc_preserve(size_t size);
> void luo_contig_free_unpreserve(void *mem, size_t size);

Why not add them to KHO?
 
> Allocate contiguous, zeroed, and preserved memory.
> 
> Pasha

-- 
Sincerely yours,
Mike.

