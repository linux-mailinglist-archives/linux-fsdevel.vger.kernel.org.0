Return-Path: <linux-fsdevel+bounces-42671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6038A458B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB03016D07B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83222423C;
	Wed, 26 Feb 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="lsoVR3av"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2119992D;
	Wed, 26 Feb 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559479; cv=none; b=pAvPBAF/5z3rIaaO6ZV8PkeTEjWKWZd7X3/Xxi6uQG5kNRW04O9UP91SBlFmSfBntewKSQp8b82E6yW7djPIiWYAa5kCQTCyfFCe5x+Cr9FLsDqEPuKwDJd6tSH6tHymQYBneHJnp07aGvc1hwf01C2SlvJDNIh7A5GqPewFaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559479; c=relaxed/simple;
	bh=ah8Rud19XqBfAm7klnOLCY4UdWDQ4YKFCkcL12/9vAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wgt2eOlEjlQICRAYiY/rhEkcIavbpN6yAQC+iEgjBp+ytedvyipEWUXWZgp6ROKUc2rO7Lz3x48gdn04CE8WE2xG6Wz6ZAqLmuYCHoRRyrT61QqrqN058Caarq/yF9w6ogqVCfJvywGowKaLMILjsZM4ZC4x8PNr48EfGRBYbw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=lsoVR3av; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740559478; x=1772095478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=12yv0TKYhFE27VJGLR2M6EZlfXB9G3C2ZSi56M7sI+I=;
  b=lsoVR3avFHhlwKOR8SRBCH0epox0MPjq1b7mieS7FHTnRMsNx0ANddb6
   jS0LNG45ugwzy8qmw3TdmsaicghWN0nSVZEi8djJuGH0p6Efwd652MZGQ
   iXZffeMMA5jpfQEGBJ/LCHGV9/IQuGCBJ319+56k3Tn7FORti7SrroqXd
   M=;
X-IronPort-AV: E=Sophos;i="6.13,316,1732579200"; 
   d="scan'208";a="470078821"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:44:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:34974]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.176:2525] with esmtp (Farcaster)
 id dc3e5d47-4ff6-4e54-90f4-b1104b684e2a; Wed, 26 Feb 2025 08:44:30 +0000 (UTC)
X-Farcaster-Flow-ID: dc3e5d47-4ff6-4e54-90f4-b1104b684e2a
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:44:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:44:29 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:44:29 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTPS id 6C410406C3;
	Wed, 26 Feb 2025 08:44:24 +0000 (UTC)
Message-ID: <c48e7708-d100-4ecc-9944-e71f39d00ae6@amazon.co.uk>
Date: Wed, 26 Feb 2025 08:44:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] mm/secretmem: set AS_NO_DIRECT_MAP instead of
 special-casing
To: David Hildenbrand <david@redhat.com>, <rppt@kernel.org>,
	<seanjc@google.com>
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
 <20250221160728.1584559-3-roypat@amazon.co.uk>
 <d686092d-bc86-4a65-b580-04f0e42e96dc@redhat.com>
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
In-Reply-To: <d686092d-bc86-4a65-b580-04f0e42e96dc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Tue, 2025-02-25 at 16:52 +0000, David Hildenbrand wrote:> On 21.02.25 17:07, Patrick Roy wrote:
>> Make secretmem set AS_NO_DIRECT_MAP on its struct address_space, to drop
>> all the vma_is_secretmem()/secretmem_mapping() checks that are based on
>> checking explicitly for the secretmem ops structures.
>>
>> This drops a optimization in gup_fast_folio_allowed() where
>> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
>> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
>> by default"), so the secretmem check did not actually end up elided in
>> most cases anymore anyway.
>>
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>> ---
> 
> Ah, there it is. Can both patches somehow be squashed?

Yeah, I'm happy to squash them. I separated them out based on feedback
on the v2, but checking back I realized that I actually just
misunderstood/misremembered what you and Mike were telling me. Sorry
about that, they'll be squashed together in the next posting :)

> -- 
> Cheers,
> 
> David / dhildenb
> 

Best, 
Patrick

