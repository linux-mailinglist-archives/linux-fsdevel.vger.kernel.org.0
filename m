Return-Path: <linux-fsdevel+bounces-57059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D544AB1E7C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10470587999
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE69275878;
	Fri,  8 Aug 2025 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDdmB93f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B49223DD9;
	Fri,  8 Aug 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653943; cv=none; b=BeuX/Y2a6IhFwwJBH1ZjPAd4D7qiRHSnUycBtThvhli0Ewh/VBtzzYVTLeYG0NSd9O9BzTGBG0cfVzqLO/XpsUEPU8eKKsv6/67iMq9el90GooVCfNxlB457v9xQbGawLP1ju/wDVq42wp+5hSw/kjTXwpj6bxWsBi3g23dtgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653943; c=relaxed/simple;
	bh=xSEzUb8y2xqXpVXNL7u1aJemA6z6EHDR87sROVoHVGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4fwT2VtCxOR+eOqLCN41UkH9vXaeZvsNbZUeG4RNJoKtJuhGFXesmdyoVd+/F2ouwRMEn9gKWPSqCECULNmwu2H5/travcukERFRTMEns6Tvk5SPclWLGPibKJJd02QpF8e1hymX7eQztlPTxZLt0fNCNspnVzFwGSVRXaYVKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDdmB93f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977FC4CEF1;
	Fri,  8 Aug 2025 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653943;
	bh=xSEzUb8y2xqXpVXNL7u1aJemA6z6EHDR87sROVoHVGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uDdmB93f9xXYQw7pkccVTAZrASxgjPMDhOD4dK5a+xhpb/pMvvaduoXy2UTuDD4PR
	 bXX5SxJeAHbarWlsYjOOfSdbQsa2Kg4b0aEtjXzZJNmW2ocmkCY33jH3ChlAGzHSSu
	 U/cwCh0SZq0ZwcXNcEV5xM4/tMPsJRedE7liIKTRhR/8w4H2s7U0ZiG8y/hSAnn4W2
	 wAFDEllgM2zeloAVeBdqRvUewuE/hXeMPpG7vhtP0DsUJ+1d8jB4ago0TZ7Q/GJp2u
	 QgK18psr/pv4vsQbytQEYh4lAbzARwwolw9f5yGC6h89p1AtmQ0dGtKbWQb2WXd097
	 +/moD7XmsFvkg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  jasonmiu@google.com,
  graf@amazon.com,  changyuanl@google.com,  rppt@kernel.org,
  dmatlack@google.com,  rientjes@google.com,  corbet@lwn.net,
  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
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
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 01/30] kho: init new_physxa->phys_bits to fix lockdep
In-Reply-To: <mafs0o6sqavkx.fsf@kernel.org>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-2-pasha.tatashin@soleen.com>
	<mafs0o6sqavkx.fsf@kernel.org>
Date: Fri, 08 Aug 2025 13:52:12 +0200
Message-ID: <mafs0bjoqav4j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08 2025, Pratyush Yadav wrote:
[...]
>> @@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>>  				unsigned int order)
>>  {
>>  	struct kho_mem_phys_bits *bits;
>> -	struct kho_mem_phys *physxa;
>> +	struct kho_mem_phys *physxa, *new_physxa;
>>  	const unsigned long pfn_high = pfn >> order;
>>  
>>  	might_sleep();
>>  
>> -	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
>> -	if (IS_ERR(physxa))
>> -		return PTR_ERR(physxa);
>> +	physxa = xa_load(&track->orders, order);
>> +	if (!physxa) {
>> +		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
>> +		if (!new_physxa)
>> +			return -ENOMEM;
>> +
>> +		xa_init(&new_physxa->phys_bits);
>> +		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
>> +				    GFP_KERNEL);
>> +		if (xa_is_err(physxa)) {
>> +			int err = xa_err(physxa);
>> +
>> +			xa_destroy(&new_physxa->phys_bits);
>> +			kfree(new_physxa);
>> +
>> +			return err;
>> +		}
>> +		if (physxa) {
>> +			xa_destroy(&new_physxa->phys_bits);
>> +			kfree(new_physxa);
>> +		} else {
>> +			physxa = new_physxa;
>> +		}
>
> I suppose this could be simplified a bit to:
>
> 	err = xa_err(physxa);
>         if (err || physxa) {
>         	xa_destroy(&new_physxa->phys_bits);
>                 kfree(new_physxa);
>
> 		if (err)
>                 	return err;
> 	} else {
>         	physxa = new_physxa;
> 	}

My email client completely messed the whitespace up so this is a bit
unreadable. Here is what I meant:

	err = xa_err(physxa);
	if (err || physxa) {
		xa_destroy(&new_physxa->phys_bits);
		kfree(new_physxa);

		if (err)
			return err;
	} else {
		physxa = new_physxa;
	}

[...]

-- 
Regards,
Pratyush Yadav

