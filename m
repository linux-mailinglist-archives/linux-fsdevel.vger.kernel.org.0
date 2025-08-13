Return-Path: <linux-fsdevel+bounces-57692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC36B249B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CA52A48E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB012E283B;
	Wed, 13 Aug 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYls+iQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4E32E1C69;
	Wed, 13 Aug 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089054; cv=none; b=qSJf2l7WCpDrKXTigH8Z/RAmZss9NF3Ox4Yp22x+osJyf3K980dgI4xtUJEotQddRA8djlmdvnSNvU6rNDxLUjtnL9QS68mv3CJGIVh6qGhRLf7rWvfca6CeT0gdsLDEkmbbEX8U4gifrpk5y+cwKtVfS5WCeWepFVV9ts6LEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089054; c=relaxed/simple;
	bh=DDRdKzPeZcrqxhyOyBHNrCzLGb9zvR9HWqXptkScBTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gdY/Ju0zfsrh2Yd55m05hZSeTy7kbBzTZrzacX9yq5obT5PchtZPudtFiJZgl4YUy1n5Ygd+Ai2PP8b73dCIDCzwkFYt2KYfr4qY67KieUaRLSf/gWvwvgDTPCicVP5kX422fEFgSmwb11DNpTd5o5JzUWggNZ1bqf6StSzsAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYls+iQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A6DC4CEEB;
	Wed, 13 Aug 2025 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755089053;
	bh=DDRdKzPeZcrqxhyOyBHNrCzLGb9zvR9HWqXptkScBTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gYls+iQY+eTb+KNGGeRqRwXWo8twVx/emg3S4y0UYygbM5zO9NqHkKOoMf8oqlqlP
	 i5BoF7JCGyiO+dNBV43VNf06FoblMmDnfeIMsiezUIzZfEQos0MK5yNU6enaGQAXPc
	 tCsL8SK1kvYsw8aimFXHiMMAwSGXX7LDT6+1+LkNShDaUxJ3nYokKDBO3d9YFW2t7o
	 c9QlpPdguBGmx0nGMIzgIleVjk+S5361TxR74ppc2b/6EXawl7CJnZvFXZFEEbfHCx
	 gh4FPANJ/YJ8GX/Ep0bKAQ87CTUUl2M23ZDqJXJIS3hCTlslAYG8KhB50nLC1O2H22
	 coJJM4BNYO67w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  jrhilke@google.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <CA+CK2bAP-PWkYtZbw8ofhTgDaW3qoQkNob30wWSjidxEUTV4pg@mail.gmail.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<CA+CK2bAP-PWkYtZbw8ofhTgDaW3qoQkNob30wWSjidxEUTV4pg@mail.gmail.com>
Date: Wed, 13 Aug 2025 14:44:03 +0200
Message-ID: <mafs0o6sjwfvw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08 2025, Pasha Tatashin wrote:

>> +static int memfd_luo_preserve_folios(struct memfd_luo_preserved_folio *pfolios,
>> +                                    struct folio **folios,
>> +                                    unsigned int nr_folios)
>> +{
>> +       unsigned int i;
>
> Should be 'long i'
>
> Otherwise in err_unpreserve we get into an infinite loop. Thank you
> Josh Hilke for noticing this.

Good catch! Will fix.
>
>> +       int err;
>> +
>> +       for (i = 0; i < nr_folios; i++) {
>> +               struct memfd_luo_preserved_folio *pfolio = &pfolios[i];
>> +               struct folio *folio = folios[i];
>> +               unsigned int flags = 0;
>> +               unsigned long pfn;
>> +
>> +               err = kho_preserve_folio(folio);
>> +               if (err)
>> +                       goto err_unpreserve;
>> +
>> +               pfn = folio_pfn(folio);
>> +               if (folio_test_dirty(folio))
>> +                       flags |= PRESERVED_FLAG_DIRTY;
>> +               if (folio_test_uptodate(folio))
>> +                       flags |= PRESERVED_FLAG_UPTODATE;
>> +
>> +               pfolio->foliodesc = PRESERVED_FOLIO_MKDESC(pfn, flags);
>> +               pfolio->index = folio->index;
>> +       }
>> +
>> +       return 0;
>> +
>> +err_unpreserve:
>> +       i--;
>> +       for (; i >= 0; i--)
>> +               WARN_ON_ONCE(kho_unpreserve_folio(folios[i]));
>> +       return err;
>> +}
>> +

-- 
Regards,
Pratyush Yadav

