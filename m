Return-Path: <linux-fsdevel+bounces-57699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB836B24AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CDA2A0121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D32EA48B;
	Wed, 13 Aug 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZfU1JX0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBA80B;
	Wed, 13 Aug 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091915; cv=none; b=JTyhUeMaCKzzaoEEdbmsIFxFVyK1S1pNbAD/Nd98yL3XrRIK1iguajZG9vmifqybBK4+81AJPRUiIL+QTwzYNYJvMm8Q5Pj1gXoYcSzaw15WqUKKfN54dg6kB1Cd5ICq/5n4mZRxySVsO0QK6CQeSzzc9z84RlbtjIoi5SQBwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091915; c=relaxed/simple;
	bh=LBaV36kinhS2YmnWCqdbe4NeUbgwg6zlvagH3E1PDKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ui6Shx5VJDN1niVr+/5Xanyg23qSHY570pKVBbmNBFyQwqDsq5k70BwRyz5Ytl4GPNwpQhU1MRV8Kf0AfAL7mWR1RGR7u0DG2Y4N2biaGlabX8Hpo7vI0mhplLb99X1AKvVmsQ+pkJxE1wOaaQ9kw0Ko+E/kqNcugZRKzoKk2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZfU1JX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D8FC4CEEB;
	Wed, 13 Aug 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755091914;
	bh=LBaV36kinhS2YmnWCqdbe4NeUbgwg6zlvagH3E1PDKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fZfU1JX0513KY6RQ5u4CA1XReF2EwtSPUl9mGOG2aKqICidDoOBi1VkOMqlX2VQkr
	 OmmEn6gT/3VhI+vewT9+KaGsxvhyTKuB6GzefoHfcuAiK17iXvoIQRNBWPfOXiCOOn
	 dxtEPT9Ia7jS+9wJ3RLJCLhWGqcDynOjlBif1A1V1LwSNnuo8T73ndSkvh3LJJv7Gy
	 jAmazTTM6rLVo2W2fVYwP4bDT6qaLVXrA2YKdmujGgIWGaWrby/410iyVA6db7J2/B
	 UnxdYeWn7Ec92oRndFFDFnF2fE0poDi8GSBkUJrMwP0kDKYGc+cudBBzKxPOS3P4sy
	 PCBNuNYmFdTpA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Vipin Sharma <vipinsh@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  x86@kernel.org,
  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <20250813124140.GA699432@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250813063407.GA3182745.vipinsh@google.com>
	<2025081310-custodian-ashamed-3104@gregkh> <mafs01ppfxwe8.fsf@kernel.org>
	<2025081351-tinsel-sprinkler-af77@gregkh>
	<20250813124140.GA699432@nvidia.com>
Date: Wed, 13 Aug 2025 15:31:44 +0200
Message-ID: <mafs0bjojwdof.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025, Jason Gunthorpe wrote:

> On Wed, Aug 13, 2025 at 02:14:23PM +0200, Greg KH wrote:
>> On Wed, Aug 13, 2025 at 02:02:07PM +0200, Pratyush Yadav wrote:
>> > On Wed, Aug 13 2025, Greg KH wrote:
>> > 
>> > > On Tue, Aug 12, 2025 at 11:34:37PM -0700, Vipin Sharma wrote:
>> > >> On 2025-08-07 01:44:35, Pasha Tatashin wrote:
>> > >> > From: Pratyush Yadav <ptyadav@amazon.de>
>> > >> > +static void memfd_luo_unpreserve_folios(const struct memfd_luo_preserved_folio *pfolios,
>> > >> > +					unsigned int nr_folios)
>> > >> > +{
>> > >> > +	unsigned int i;
>> > >> > +
>> > >> > +	for (i = 0; i < nr_folios; i++) {
>> > >> > +		const struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
>> > >> > +		struct folio *folio;
>> > >> > +
>> > >> > +		if (!pfolio->foliodesc)
>> > >> > +			continue;
>> > >> > +
>> > >> > +		folio = pfn_folio(PRESERVED_FOLIO_PFN(pfolio->foliodesc));
>> > >> > +
>> > >> > +		kho_unpreserve_folio(folio);
>> > >> 
>> > >> This one is missing WARN_ON_ONCE() similar to the one in
>> > >> memfd_luo_preserve_folios().
>> > >
>> > > So you really want to cause a machine to reboot and get a CVE issued for
>> > > this, if it could be triggered?  That's bold :)
>> > >
>> > > Please don't.  If that can happen, handle the issue and move on, don't
>> > > crash boxes.
>> > 
>> > Why would a WARN() crash the machine? That is what BUG() does, not
>> > WARN().
>> 
>> See 'panic_on_warn' which is enabled in a few billion Linux systems
>> these days :(
>
> This has been discussed so many times already:
>
> https://lwn.net/Articles/969923/
>
> When someone tried to formalize this "don't use WARN_ON" position 
> in the coding-style.rst it was NAK'd:
>
> https://lwn.net/ml/linux-kernel/10af93f8-83f2-48ce-9bc3-80fe4c60082c@redhat.com/
>
> Based on Linus's opposition to the idea:
>
> https://lore.kernel.org/all/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com/
>
> Use the warn ons. Make sure they can't be triggered by userspace. Use
> them to detect corruption/malfunction in the kernel.
>
> In this case if kho_unpreserve_folio() fails in this call chain it
> means some error unwind is wrongly happening out of sequence, and we
> are now forced to leak memory. Unwind is not something that userspace
> should be controlling, so of course we want a WARN_ON here.

Yep. And if we are saying WARN() should never be used then doesn't that
make panic_on_warn a no-op? What is even the point of that option then?

Here, we are unable to unpreserve a folio that we have preserved. This
isn't a normal error that we expect to happen. This should _not_ happen
unless something has gone horribly wrong.

For example, the calls to kho_preserve_folio() don't WARN(), since that
can fail for various reasons. They just return the error up the call
chain. As an analogy, allocating a page can fail, and it is quite
reasonable to expect the code to not throw out WARN()s for that. But if
for some reason you can't free a page that you allocated, this is very
unexpected and should WARN(). Of course, in Linux the page free APIs
don't even return a status, but I hope you get my point.

If I were a system administrator who sets panic_on_warn, I would _want_
the system to crash so no further damage happens and I can collect
logs/crash dumps to investigate later. Without the WARN(), I never get a
chance to debug and my system breaks silently. For all others, the
kernel goes on with some possibly corrupted/broken state.

-- 
Regards,
Pratyush Yadav

