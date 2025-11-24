Return-Path: <linux-fsdevel+bounces-69692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A2C813B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998D94E50D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FB30DEDC;
	Mon, 24 Nov 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL1v2+Ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667C28725B;
	Mon, 24 Nov 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996814; cv=none; b=F46UkUhMurroF4IcFeXEoL6RqmpAWSKZwil1XNly0xfi8ghlgv2FSHvFLi8NYINlf91vjXRHLGEM+WN67+z2TruxByZb4sThJSg4iJLw3PGd4KD/MUEN3jW/HmiBj/27LcnI/tBG1V+2WuHGLz0bbIgU8S6lH+osQqVs7OrBRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996814; c=relaxed/simple;
	bh=hjVka/8UJVXnMcGE16R4he/m5Oo5PixYwejWPEsOQ1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTwWKA6gWG/++zdgJRXJxsN3lPtZiHnIfMD3A3VwdwC0MCRhu6PZHTW0rIPR99WkJ930Yx9ZtAf9VvQ5hzuVOUp1cxwJBM3E9SoTQvbBQDuJaac7uH/o0KZEFPE4JC0cFuSDdRTNCrHhcfcOIbaEa4qn70FSsXkPC3J7o4z3ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL1v2+Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91754C19421;
	Mon, 24 Nov 2025 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763996814;
	bh=hjVka/8UJVXnMcGE16R4he/m5Oo5PixYwejWPEsOQ1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cL1v2+Tszy/h+jhmobTHqTpgFHjagqVVaCUaz+wK13OfbBpa6MzGIDAh0nshBcutN
	 DrH2mDUz8PxmhHv5LoIvBZFwpOOKPBZRDC5Ky6KqbUTFP9BjytnUFoiHjShjtbeOdH
	 QhNyc2aLiQekqmQUuvjVnMXvaHFqDMo0Fnh05ZtXsbUoS83jn2aufdoRzu+nEo3ct1
	 rqvQAkV60dhx2utBqGybYIBcJnWOhYuTDU29Auvog8yWViX9GLTTDzxOv6yUVvFg36
	 WxW6JlNJKKhQqU+3Q3B46N1SNHKRH611QELwaMl2ZV8uKpDXXP3benVY5Qh1MCN2ud
	 qeRYO+2kGet2Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  dmatlack@google.com,
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
Subject: Re: [PATCH v6 12/20] mm: shmem: allow freezing inode mapping
In-Reply-To: <aRr0CQsV16usRW1J@kernel.org> (Mike Rapoport's message of "Mon,
	17 Nov 2025 12:08:09 +0200")
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
	<20251115233409.768044-13-pasha.tatashin@soleen.com>
	<aRr0CQsV16usRW1J@kernel.org>
Date: Mon, 24 Nov 2025 16:06:44 +0100
Message-ID: <mafs0a50bzczf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 17 2025, Mike Rapoport wrote:

> On Sat, Nov 15, 2025 at 06:33:58PM -0500, Pasha Tatashin wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>> 
>> To prepare a shmem inode for live update via the Live Update
>> Orchestrator (LUO), its index -> folio mappings must be serialized. Once
>> the mappings are serialized, they cannot change since it would cause the
>> serialized data to become inconsistent. This can be done by pinning the
>> folios to avoid migration, and by making sure no folios can be added to
>> or removed from the inode.
>> 
>> While mechanisms to pin folios already exist, the only way to stop
>> folios being added or removed are the grow and shrink file seals. But
>> file seals come with their own semantics, one of which is that they
>> can't be removed. This doesn't work with liveupdate since it can be
>> cancelled or error out, which would need the seals to be removed and the
>> file's normal functionality to be restored.
>> 
>> Introduce SHMEM_F_MAPPING_FROZEN to indicate this instead. It is
>> internal to shmem and is not directly exposed to userspace. It functions
>> similar to F_SEAL_GROW | F_SEAL_SHRINK, but additionally disallows hole
>> punching, and can be removed.
>> 
>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
[...]
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 1d5036dec08a..05c3db840257 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -1292,7 +1292,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
>>  		loff_t newsize = attr->ia_size;
>>  
>>  		/* protected by i_rwsem */
>> -		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>> +		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
>
> A corner case: if newsize == oldsize this will be a false positive

Good catch. Though I wonder why anyone would do a truncate with the same
size.

>
>> +		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
>>  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>>  			return -EPERM;
>>  
[...]

-- 
Regards,
Pratyush Yadav

