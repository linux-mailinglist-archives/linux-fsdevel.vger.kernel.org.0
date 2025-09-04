Return-Path: <linux-fsdevel+bounces-60270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001ECB43BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08A1A008F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D62FC88B;
	Thu,  4 Sep 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9MOrYmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8382F8BD0;
	Thu,  4 Sep 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989564; cv=none; b=pAclulHhoY2qsPUWjxs6rhMF0YoxH/Dmczmd5iL1G3iFxZlEj5U+rfq1Djbl/d16ChzrKqBpeLFNNLi4kBcJ2DkODNPL2vi3Ki37mJsUPJHRyZq6URq0Vctf4ACNCUTXeq7VZvGTrNLPwDlr3ZCFp/FIrv5gzgZtPW32hK0WhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989564; c=relaxed/simple;
	bh=/dOXK4oy7iAhoUGr2MmfjWE8hXk9Y8tyleU9g8YasAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlEvzWbD9LPCqClXvVdmyp7PLG2L+1ZOlJZoF0hoheVomli1glbe8dWWbtwpJrZ10wfR5gKld18RoGBp01zOSM1vFSYBmdJht1SAw7+Dh+XoNCDWj5O+MEiXCjU47/WmBRSyiP2edoK5ctPw3oYaXRyf9nzvpC0E2uZe5NOooqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9MOrYmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E171AC4CEF1;
	Thu,  4 Sep 2025 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756989563;
	bh=/dOXK4oy7iAhoUGr2MmfjWE8hXk9Y8tyleU9g8YasAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i9MOrYmHgSH7Y+7qHtX1Byvl1ufAKEXc1Ej/VzGCte2ENcbxl6Mjs/y7IuxfEcCQ3
	 lkRNGXjyWdOWAjOORBHFnPRA/tQO7cxQGyxoKmvFfmz4u8IXtmkl7ciAUTWgFT+GAP
	 myO6mgfBUImeuJUAz/Pp3nRZc3rbxvf5UZr3Y0Bck70j808roKhLMObuwp5KEXxApA
	 xpPMEoC4Z5WrmciOCLArypa7JShIxMw4iOYxs4tM20apqeuHeoOTbvLYZ/wTsANFrj
	 0RU+AInyj9lCuH+cdHwn1+LLbCI7dNSEn4Q4fm9jFierntGz1oHAM9EVt+WbDdjGQ+
	 uvggoCCmg/h4g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  dmatlack@google.com,
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
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
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
In-Reply-To: <aLiZbb_F5R2x9-y2@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com> <aLXIcUwt0HVzRpYW@kernel.org>
	<mafs0ldmyw1hp.fsf@kernel.org> <aLbYk30V2EEJJtAf@kernel.org>
	<mafs0qzwnvcwk.fsf@kernel.org> <aLiZbb_F5R2x9-y2@kernel.org>
Date: Thu, 04 Sep 2025 14:39:13 +0200
Message-ID: <mafs0ecsmv1ce.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Wed, Sep 03 2025, Mike Rapoport wrote:
> On Wed, Sep 03, 2025 at 04:17:15PM +0200, Pratyush Yadav wrote:
>> On Tue, Sep 02 2025, Mike Rapoport wrote:
>> >
>> > As for porting kho_preserve_vmalloc() to kho_array, I also feel that it
>> > would just make kho_preserve_vmalloc() more complex and I'd rather simplify
>> > it even more, e.g. with preallocating all the pages that preserve indices
>> > in advance.
[...]
>  
>> Beyond that, I think KHO array will actually make kho_preserve_vmalloc()
>> simpler since it won't have to deal with the linked list traversal
>> logic. It can just do ka_for_each() and just get all the pages.
>>
>> We can also convert the preservation bitmaps to use it so the linked list
>> logic is in one place, and others just build on top of it.
>
> I disagree. The boilerplate to initialize and iterate the kho_array will
> not make neither vmalloc nor bitmaps preservation simpler IMO.

I have done 80% of the work on this already, so let's do this: I will do
the rest of the 20% and publish the patches. Then you and Jason can have
a look and if you still think it's not worth it, I am fine shelving it
for now and revisiting later when there might be a stronger case.

>
> And for bitmaps Pasha and Jason M. are anyway working on a different data
> structure already, so if their proposal moves forward converting bitmap
> preservation to anything would be a wasted effort.

-- 
Regards,
Pratyush Yadav

