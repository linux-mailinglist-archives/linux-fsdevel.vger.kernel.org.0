Return-Path: <linux-fsdevel+bounces-56833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8239B1C58B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 14:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D8718A7472
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 12:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926C279333;
	Wed,  6 Aug 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjiq6aMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DF221729;
	Wed,  6 Aug 2025 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481783; cv=none; b=hUlE5cBz//zRb5zq2ZA+cvNkI1ftKc5kI6F7VaSYLW5qd/IeIQ4ThplhX7ymToCzSGf5xkgBpSFl4eTJYcCQOT2rcQnWjb1okygHujiAs+Q7QW8vlygbgkQIfEHoRRyXulQJ+N6C6JFfnXNNYveJHdenlGT+6FLF0cu8K7RwxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481783; c=relaxed/simple;
	bh=iM3DL6rk0RbOHKY0NOC2WS44N14rliZCsKY1vAOE0s4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqdNiIjTyFgLPwAefJRTjfispK4zewykaRn8Bj3BXfdvPbNngb9naS3jKZ0qsUvD0zC1oDIKq6VsTj3j3spp+WPAr3QmBYQVft6nULAnrIseJGscMvSQIeyr+JCgejC3yFJ0nTPXoky5aiNADN0FsNXmsAwrDBFs1g45+q3tPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jjiq6aMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F95DC4CEEB;
	Wed,  6 Aug 2025 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754481783;
	bh=iM3DL6rk0RbOHKY0NOC2WS44N14rliZCsKY1vAOE0s4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jjiq6aMRhbWCv5v74m8F3r/WETA/ORQJKafiqRDXRe1OAI+ZWJJuCD1Rb6RuQ930+
	 cxGf4XAVSsFnHxzsV5imiaoQi0U6QxnVqa8b8jhLJGQVPqjYAJT4WtOESQLnTEBLcr
	 PdrWB5UTHuhRc/Pnc1xgTVONPRQamGcj5PEpEu4aaFvYE69JKzAXlBMhCIo9lhfz44
	 kEl96fvPjQh4UQOa0ISpr/HxTvDWPp2GXE9WRbQIt7uQJq4/rQk83yihh/4AsBrZd6
	 q/rJ9lbo1yIC2+m/EGCJJXcKVBbUNpsA8xDbuSon0D+0WkBHxTLxmAIQsrl9vAYYOR
	 Pcqs7riARcj7w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  Jason Gunthorpe <jgg@nvidia.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  jasonmiu@google.com,  graf@amazon.com,
  changyuanl@google.com,  rppt@kernel.org,  dmatlack@google.com,
  rientjes@google.com,  corbet@lwn.net,  rdunlap@infradead.org,
  ilpo.jarvinen@linux.intel.com,  kanie@linux.alibaba.com,
  ojeda@kernel.org,  aliceryhl@google.com,  masahiroy@kernel.org,
  akpm@linux-foundation.org,  tj@kernel.org,  yoann.congal@smile.fr,
  mmaurer@google.com,  roman.gushchin@linux.dev,  chenridong@huawei.com,
  axboe@kernel.dk,  mark.rutland@arm.com,  jannh@google.com,
  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  anna.schumaker@oracle.com,  song@kernel.org,  zhangguopeng@kylinos.cn,
  linux@weissschuh.net,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-mm@kvack.org,
  gregkh@linuxfoundation.org,  mingo@redhat.com,  bp@alien8.de,
  dave.hansen@linux.intel.com,  x86@kernel.org,  hpa@zytor.com,
  rafael@kernel.org,  dakr@kernel.org,  bartosz.golaszewski@linaro.org,
  cw00.choi@samsung.com,  myungjoo.ham@samsung.com,
  yesanishhere@gmail.com,  Jonathan.Cameron@huawei.com,
  quic_zijuhu@quicinc.com,  aleksander.lobakin@intel.com,
  ira.weiny@intel.com,  andriy.shevchenko@linux.intel.com,
  leon@kernel.org,  lukas@wunner.de,  bhelgaas@google.com,
  wagi@kernel.org,  djeffery@redhat.com,  stuart.w.hayes@gmail.com,
  lennart@poettering.net,  brauner@kernel.org,  linux-api@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  saeedm@nvidia.com,
  ajayachandra@nvidia.com,  parav@nvidia.com,  leonro@nvidia.com,
  witu@nvidia.com
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
In-Reply-To: <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
	<20250723144649.1696299-32-pasha.tatashin@soleen.com>
	<20250729161450.GM36037@nvidia.com> <877bzqkc38.ffs@tglx>
	<20250729222157.GT36037@nvidia.com>
	<20250729183548.49d6c2dc@gandalf.local.home>
	<mafs07bzqeg3x.fsf@kernel.org>
	<CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
Date: Wed, 06 Aug 2025 14:02:52 +0200
Message-ID: <mafs0ectod5eb.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Tue, Aug 05 2025, Pasha Tatashin wrote:

>> To add some context: one of the reasons to include it in the series as
>> an RFC at the end was to showcase the userspace side of the API and have
>> a way for people to see how it can be used. Seeing an API in action
>> provides useful context for reviewing patches.
>>
>> I think Pasha forgot to add the RFC tags when he created v2, since it is
>> only meant to be RFC right now and not proper patches.
>
> Correct, I accidently removed RFC from memfd patches in the version. I
> will include memfd preservation as RFCv1 in v3 submission.

I didn't mean this for the memfd patches, only for libluo.

I think the memfd patches are in decent shape. They aren't pristine, but
I do think they are good enough to land and be improved iteratively.

If you think otherwise, then what do you reckon needs to be done to make
them _not_ RFC?

-- 
Regards,
Pratyush Yadav

