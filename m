Return-Path: <linux-fsdevel+bounces-57700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E44B24AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2E23B50FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1E2E92A6;
	Wed, 13 Aug 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm1jF1Lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178972E7F39;
	Wed, 13 Aug 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092234; cv=none; b=tec0FV44bwH2pzWF9ufBGdg/qlcKmg/e66HRlZ+/FdH6UzIiyiNGomXaI+R4k6xoOQeCf5bSmnPCdehyAwlJAeZyaAkf1HlCWdQbJJSQWQPMVGfdOoVR8gtjs2rK16/PzVUNz2aK/Zgoy213jyjVg8E3xAo25v4emaS9HlD5/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092234; c=relaxed/simple;
	bh=gKvz2MC5wozp0txCtJXl7kNfS6x4R8q1KKyu7d5k0DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QX9xxjBnI4ISrL0j3phNCi36A0vC6x/FrTFnCec4k8rzo5Zu6nfm7PqmSS/r1Kbjt3KHtdWnzaPz3ntli5sfz7HkyzFGcg6IDupkMWdoEE+f/jsdTJv9N1jHOPTrKsKfnGPf0x4iqopjA5W588i1jQmJmgyqlmA2k5AbvOoZQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm1jF1Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F89C4CEEB;
	Wed, 13 Aug 2025 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755092233;
	bh=gKvz2MC5wozp0txCtJXl7kNfS6x4R8q1KKyu7d5k0DY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Pm1jF1Ljm5T+6BOOZNpYAiyUBhA6jrJJ3DRvXghpATFhZq9GKA5j1j8Xl9om6Mvqd
	 pfb6YVvFxGbv9PYSjK3q5G96TXeo13NOsZZUcX4p7BOHPPWqewIaajNssSIIJq67Ir
	 xfAz6+V7B0aTsEcI3pSfGZBQt5DjXUcnHfEh22WdBQkwWMnVlBIrcbQjMhPFgaUYB6
	 +kXK07xwObo+yLiDzPd/6jG/pDA9bkPmsMRnuHEkIUSaR5V081dJnNqOCzoK22kD1K
	 S3FF/GtK8QX6tTieEmA3XosMZYGA78RfsgeODd3LX+itirXiSMrsG7A+4N9RcdACEg
	 oreSW4Z88W6PQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Vipin Sharma <vipinsh@google.com>,  Pasha Tatashin
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
In-Reply-To: <2025081334-rotten-visible-517a@gregkh>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250813063407.GA3182745.vipinsh@google.com>
	<2025081310-custodian-ashamed-3104@gregkh> <mafs01ppfxwe8.fsf@kernel.org>
	<2025081351-tinsel-sprinkler-af77@gregkh>
	<20250813124140.GA699432@nvidia.com>
	<2025081334-rotten-visible-517a@gregkh>
Date: Wed, 13 Aug 2025 15:37:03 +0200
Message-ID: <mafs07bz7wdfk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025, Greg KH wrote:

> On Wed, Aug 13, 2025 at 09:41:40AM -0300, Jason Gunthorpe wrote:
[...]
>> Use the warn ons. Make sure they can't be triggered by userspace. Use
>> them to detect corruption/malfunction in the kernel.
>> 
>> In this case if kho_unpreserve_folio() fails in this call chain it
>> means some error unwind is wrongly happening out of sequence, and we
>> are now forced to leak memory. Unwind is not something that userspace
>> should be controlling, so of course we want a WARN_ON here.
>
> "should be" is the key here.  And it's not obvious from this patch if
> that's true or not, which is why I mentioned it.
>
> I will keep bringing this up, given the HUGE number of CVEs I keep
> assigning each week for when userspace hits WARN_ON() calls until that
> flow starts to die out either because we don't keep adding new calls, OR
> we finally fix them all.  Both would be good...

Out of curiosity, why is hitting a WARN_ON() considered a vulnerability?
I'd guess one reason is overwhelming system console which can cause a
denial of service, but what about WARN_ON_ONCE() or WARN_RATELIMIT()?

-- 
Regards,
Pratyush Yadav

