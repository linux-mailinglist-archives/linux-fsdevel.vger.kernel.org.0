Return-Path: <linux-fsdevel+bounces-42579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C62A4424E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D8F19E1121
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1695B26B2B0;
	Tue, 25 Feb 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="hIYTk2hM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7B2676C8;
	Tue, 25 Feb 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492765; cv=none; b=qVpADza0rSbZNo+oCiyS3SxEWm7BFguINSlwyybDjXAJpY/PbogaW8WZb9Z67oQMxWfPhRYt21KXtRNIob4mzK+BaEVPqmhCHluqAeV+gnIXS3ztweF2ZkZTT4hMLYmI83HKeHcvGlkwPxS4xuDAspJLa0lcQQkL/Cq6ilGLmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492765; c=relaxed/simple;
	bh=VKH1ouIyBgpV+yjjzpH1YAmVGB47UmPki1d/30Utxk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E/VhelkOWyTWc9L4yDJOPo5YHNvRCRj6RF/FqhSyZPJ0y7I3kkIC5CW267Ece9SffhXiOcJ5bCrNK/0VtxifeuhEmnN1HeCjPACCHymVqI70nLZ7JChW2sG7zzkw4l1+OM5DmPfmU3kXhxvgTnIf3Kb0SBLYl4wuiVIyYEO9gLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=hIYTk2hM; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740492764; x=1772028764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wCe9wqGieGFyiUCexYspDQYCKCk1CfumNTmeDIsPvqY=;
  b=hIYTk2hMUm5BIsJKCZdhucPQ7TRjAUJIW05dqhA7W6wxw2FgA+s1grGV
   DO1J58NycpW+tCR2VtjaCU1SH/mmNEkq0eh0Wd591J6WTYbIFbfRV+F2g
   H340M/nQgAqNwvFQqGOIS1iApTVKQKVov1pbjZPMSOFxTWYJbtg54LZFp
   g=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="274174113"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 14:12:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:33203]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 1760cb76-f2c7-41ad-bce5-bd5d082ea92a; Tue, 25 Feb 2025 14:12:37 +0000 (UTC)
X-Farcaster-Flow-ID: 1760cb76-f2c7-41ad-bce5-bd5d082ea92a
Received: from EX19D020UWA003.ant.amazon.com (10.13.138.254) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 14:12:37 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D020UWA003.ant.amazon.com (10.13.138.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 14:12:36 +0000
Received: from email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 14:12:36 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-f5cd2367.us-west-2.amazon.com (Postfix) with ESMTPS id 46E31C7D57;
	Tue, 25 Feb 2025 14:12:29 +0000 (UTC)
Message-ID: <9e60449b-0d2f-43ef-a0b0-3cc999fa9d99@amazon.co.uk>
Date: Tue, 25 Feb 2025 14:12:27 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] KVM: selftests: Add guest_memfd based
 vm_mem_backing_src_types
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: <pbonzini@redhat.com>, <corbet@lwn.net>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <song@kernel.org>, <jolsa@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<vbabka@suse.cz>, <jannh@google.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-9-roypat@amazon.co.uk>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <20250221160728.1584559-9-roypat@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2025-02-21 at 16:07 +0000, Patrick Roy wrote:

...

> @@ -985,10 +1013,13 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  	if (alignment > 1)
>  		region->mmap_size += alignment;
>  
> -	region->fd = -1;
> -	if (backing_src_is_shared(src_type))
> +	if (backing_src_is_guest_memfd(src_type))
> +		region->fd = guest_memfd;
> +	else if (backing_src_is_guest_memfd(src_type))

Argh, this is nonsense. Should be 

+	else if (backing_src_is_shared(src_type))

instead.

>  		region->fd = kvm_memfd_alloc(region->mmap_size,
>  					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
> +	else
> +		region->fd = -1;
>  
>  	region->mmap_start = mmap(NULL, region->mmap_size,
>  				  PROT_READ | PROT_WRITE,

...

