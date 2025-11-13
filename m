Return-Path: <linux-fsdevel+bounces-68340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779A4C5928B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C074A23A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE136656B;
	Thu, 13 Nov 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKpbgHVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725542BEC43;
	Thu, 13 Nov 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053202; cv=none; b=MOLfMiT2caJbS9f7jZpngBFbl7g94Ru5WvKRLwOql8J6CodN5fJurXJeuBxezSJ3H8t6RGp6gFzY0BFvnVpdFC5pm9oDtmzifvHkOGDn0K42P8TGGtONxP2P4+uThmuFCvwDZvCrzW0UrNkF08WNzPuhgyPp9zCVRL9BdQGcubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053202; c=relaxed/simple;
	bh=OBpr4OfEynmd3QPtz7HpqQa1JuoHzfmsOcTyDkjnDvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9Ov5qE+FPKQaax6Jx7AhaAuMcfk/2+2wr2criXPHMccPQQCkfimg+aIPN9+TjbWWL1ZVKK5uH77X3c+Q0d4QYx3lgOrOdI0XTWHe4NC9Jm5j4TeF/CXb/BPYgHKslciWyu0m1H9hlY/Vv2GQ3F6j22gL62pNLYMkvTUSDSeJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKpbgHVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7DAC4CEF5;
	Thu, 13 Nov 2025 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053202;
	bh=OBpr4OfEynmd3QPtz7HpqQa1JuoHzfmsOcTyDkjnDvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GKpbgHVAB96CTF2QAU6gGXB9xyAtOYn7EP9js0Mycon0OeXhF2jqHHtX89c5XmG3n
	 aI+GsuLi5aWWIqQuOeufUD4aA/2oqU4CL3hOKgWLJISLTlCDKD2fvEzTYvo+4axv1Y
	 RMC80Z36Upuv7S76Aj7akkAJYpehDBHHl02KtLD9+owbFDV5HjZtX2uU4oNhmImcTZ
	 TB6NozxahkQlkcbHdVJIiuprn3ewx0G92tYj/3ivDFDMjJkdV5nEmpt/dhUVJduyaG
	 M6PpSxx1REjCjMlgwB+uTMHEl+k2ror8Zzap/3OLPhR5zcZpm4wrMVCWSYXfzyE61t
	 +lyMXl3tACR7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org,  jasonmiu@google.com,  graf@amazon.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com,
  hughd@google.com,  skhawaja@google.com,  chrisl@kernel.org
Subject: Re: [PATCH v5 18/22] docs: add documentation for memfd preservation
 via LUO
In-Reply-To: <CA+CK2bBmSD_YftJ-9w1zidLz2=a4NynnLz_gLPsScF145bu5dQ@mail.gmail.com>
	(Pasha Tatashin's message of "Thu, 13 Nov 2025 11:55:25 -0500")
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
	<20251107210526.257742-19-pasha.tatashin@soleen.com>
	<CA+CK2bBmSD_YftJ-9w1zidLz2=a4NynnLz_gLPsScF145bu5dQ@mail.gmail.com>
Date: Thu, 13 Nov 2025 17:59:51 +0100
Message-ID: <mafs01pm1amwo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025, Pasha Tatashin wrote:

>> +Limitations
>> +===========
>> +
>> +The current implementation has the following limitations:
>> +
>> +Size
>> +  Currently the size of the file is limited by the size of the FDT. The FDT can
>> +  be at of most ``MAX_PAGE_ORDER`` order. By default this is 4 MiB with 4K
>> +  pages. Each page in the file is tracked using 16 bytes. This limits the
>> +  maximum size of the file to 1 GiB.
>
> The above should be removed, as we are using KHO vmalloc that resolves
> this limitation. Pratyush, I suggest for v6 let's move memfd
> documnetation right into the code: memfd_luo.c and
> liveupdate/abi/memfd.h, and source it from there.

ACK. I think the section on behavior in different phases is also out of
date now, and the serialization format too. The format is more
accurately defined in include/linux/liveupdate/abi/memfd.h. So this
documentation needs an overhaul.

I don't mind moving it to the code and including it in the HTML docs via
kernel-doc. Will do that for the next revision.

>
> Keeping documentation with the code helps reduce code/doc divergence.
>
> Pasha

-- 
Regards,
Pratyush Yadav

