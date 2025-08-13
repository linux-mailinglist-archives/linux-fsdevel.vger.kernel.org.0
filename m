Return-Path: <linux-fsdevel+bounces-57691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB096B249AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C1B566E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AB2E1C64;
	Wed, 13 Aug 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abcQxx+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB22D738C;
	Wed, 13 Aug 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088977; cv=none; b=Y8YfEmzyszTcdLePjQPEVi8UcszIe/AbaRQlcXzS6rMycl+QQKJ6HJAhUYolqsehkUFcdZRkNuiA+3Vwps7aK6+xGfiBgyUWsMGc/rcBQ8qMfBU1CgDlFp9EWy84oKHiLL3gmmzY09+5YNAPop4mGU3HLC+XBaFyx4A08/G9jMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088977; c=relaxed/simple;
	bh=LDj2QuAauZIfATyz/j1HGW1zmOPF+xKh5rLzTFxXMTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wl6ueUF+iwS8r6OF2pwMy/W+fPa4TXknQb954LWAbtDeE8/gzJOLi1tvudM27lQb7CyeXHZtPNFBXpm7w9MSfZZAjfGUc/fmKNMiuxFzqnHNVQ1J2PeBuQuXMGOsKfIGpJ2FB7DGXbNjwr55s7mGkI+3noXzWiMWDCLsWmIuqNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abcQxx+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B89C4CEEB;
	Wed, 13 Aug 2025 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088977;
	bh=LDj2QuAauZIfATyz/j1HGW1zmOPF+xKh5rLzTFxXMTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=abcQxx+2rtJfHkVvpjEviY5OyOiZUaFIpnFBGZHCKkIxAIF1d61SW9piap09pmUm0
	 186Dc2YxQSCoIRn+xcQHv+CoEnq/0krk+ci4a+VQSRrAkNeFrCwMdyTumguGilaKvk
	 weRcPWRNVzDxYkl2M1qZ3jNA6bHY1yHD5w22GQL78BS5PP3UlJJbYaxmu6dH3dFFie
	 Zhrn738C6i3hm6OUaurtWBNHHy0wlzf9wInTPabX2fwQblkyBUq0bf2nEzhdcJGPmu
	 O9NpQhVkb76Vjp8vRuKGBejjHufDaD5xh2BiRDsXZ/pwilC6xh/BNfAjYrYxCmJXKY
	 tSNtMwX7h5QJw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Vipin Sharma <vipinsh@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
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
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 26/30] mm: shmem: use SHMEM_F_* flags instead of VM_*
 flags
In-Reply-To: <20250811231107.GA2328988.vipinsh@google.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-27-pasha.tatashin@soleen.com>
	<20250811231107.GA2328988.vipinsh@google.com>
Date: Wed, 13 Aug 2025 14:42:47 +0200
Message-ID: <mafs0sehvwfy0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025, Vipin Sharma wrote:

> On 2025-08-07 01:44:32, Pasha Tatashin wrote:
>> From: Pratyush Yadav <ptyadav@amazon.de>
>> @@ -3123,7 +3123,9 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
>>  	spin_lock_init(&info->lock);
>>  	atomic_set(&info->stop_eviction, 0);
>>  	info->seals = F_SEAL_SEAL;
>> -	info->flags = flags & VM_NORESERVE;
>> +	info->flags = 0;
>
> This is not needed as the 'info' is being set to 0 just above
> spin_lock_init.
>
>> +	if (flags & VM_NORESERVE)
>> +		info->flags |= SHMEM_F_NORESERVE;
>
> As info->flags will be 0, this can be just direct assignment '='.

I think it is a bit more readable this way.

Anyway, I don't have a strong opinion, so if you insist, I'll change
this.

>
>>  	info->i_crtime = inode_get_mtime(inode);
>>  	info->fsflags = (dir == NULL) ? 0 :
>>  		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
>> @@ -5862,8 +5864,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>>  /* common code */
>>  
>>  static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>> -			loff_t size, unsigned long flags, unsigned int i_flags)
>> +				       loff_t size, unsigned long vm_flags,
>> +				       unsigned int i_flags)
>
> Nit: Might be just my editor, but this alignment seems off.

Looks fine for me:
https://gist.github.com/prati0100/a06229ca99cac5aae795fb962bb24ac5

Checkpatch also doesn't complain. Can you double-check? And if it still
looks off, can you describe what's wrong?

>
>>  {
>> +	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
>>  	struct inode *inode;
>>  	struct file *res;
>>  
>> @@ -5880,7 +5884,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
>> -				S_IFREG | S_IRWXUGO, 0, flags);
>> +				S_IFREG | S_IRWXUGO, 0, vm_flags);
>>  	if (IS_ERR(inode)) {
>>  		shmem_unacct_size(flags, size);
>>  		return ERR_CAST(inode);
>> -- 
>> 2.50.1.565.gc32cd1483b-goog
>> 

-- 
Regards,
Pratyush Yadav

