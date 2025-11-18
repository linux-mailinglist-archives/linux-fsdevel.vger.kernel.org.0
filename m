Return-Path: <linux-fsdevel+bounces-69002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40416C6B072
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4DB7D2B2FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83D349B10;
	Tue, 18 Nov 2025 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoZhDf71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CF2D9ED8;
	Tue, 18 Nov 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487807; cv=none; b=BgwXk+Aa472n0KHG5y3B3yYQKdeQoPZIcm5KPitJmlAoLGb2Jt7SXGlVXkgVWg0sc7/qXFV6YMESr5ZVm/BZh8dmhv80Bu4lvHBKNBe2QgBryYDL1607t6eWbpdXLBCHyMpc67TxgthNz775PoOq0uwnvmQSLOpWP0oANBVgFz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487807; c=relaxed/simple;
	bh=1palvEhA7lxPgWRw7JBg2nk+PwUYpMtYYMp2Y2Eh+EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzRnmsNe2+EG5/aPdvWTnnmDFd5Vq+7gJJdi06+JmqY4rKMSagS5w9avpc4ypo5yugZQSyc4F3qQbqfRQm8GSidbSRREYnfncrDNE6uLC1IUe6iW7i+tqAt8u3zynFKakemMNKadqIOrMvSHtKs4l/4saQEqgC2VnhNcJQimscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoZhDf71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95577C4CEF5;
	Tue, 18 Nov 2025 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763487807;
	bh=1palvEhA7lxPgWRw7JBg2nk+PwUYpMtYYMp2Y2Eh+EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RoZhDf71xqImZXulbvoIjZ7yAzxYD/AcTLI06tLkcrHJGhS3n1wuCOf9wx4CJeqaH
	 TcKaUflrQT4qrs3oIwoEEi619q9+Fi592cRC2H7+B2Yb6e3kiI9VcpxOawkpwyO3Yi
	 rbm4faU2dCL+7GC4WWBY8oG635z1gnunufw3vIiV0KuNvYm+cTKmQ9rhDHQgFR6dph
	 hdAL2UoAcdeSJmuaJqhSf898zpIbBTLwKGntsdMpz9Ugl4isTI1G9TJcUmowA2cd8U
	 zZPkIerB9kg8IBClw5+1dSHyURuVzrsqFmqfVuupgNrgHQBcyYcWg2FA+fH79majJ9
	 jDsELXhpb/0mw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  rppt@kernel.org,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  tglx@linutronix.de,  mingo@redhat.com,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v6 06/20] liveupdate: luo_file: implement file systems
 callbacks
In-Reply-To: <aRyvG308oNRVzuN7@google.com> (David Matlack's message of "Tue,
	18 Nov 2025 17:38:35 +0000")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-7-pasha.tatashin@soleen.com>
	<aRyvG308oNRVzuN7@google.com>
Date: Tue, 18 Nov 2025 18:43:12 +0100
Message-ID: <mafs05xb744pb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 18 2025, David Matlack wrote:

> On 2025-11-15 06:33 PM, Pasha Tatashin wrote:
>> This patch implements the core mechanism for managing preserved
>> files throughout the live update lifecycle. It provides the logic to
>> invoke the file handler callbacks (preserve, unpreserve, freeze,
>> unfreeze, retrieve, and finish) at the appropriate stages.
>> 
>> During the reboot phase, luo_file_freeze() serializes the final
>> metadata for each file (handler compatible string, token, and data
>> handle) into a memory region preserved by KHO. In the new kernel,
>> luo_file_deserialize() reconstructs the in-memory file list from this
>> data, preparing the session for retrieval.
>> 
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
>> +int liveupdate_register_file_handler(struct liveupdate_file_handler *h);
>
> Should there be a way to unregister a file handler?
>
> If VFIO is built as module then I think it  would need to be able to
> unregister its file handler when the module is unloaded to avoid leaking
> pointers to its text in LUO.

Good point. We also need when using FLB. You would first do
liveupdate_register_file_handler(), and then do
liveupdate_register_flb(). If the latter fails, you would want to
unregister the file handler too.

-- 
Regards,
Pratyush Yadav

