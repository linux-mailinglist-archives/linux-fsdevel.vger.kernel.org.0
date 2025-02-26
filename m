Return-Path: <linux-fsdevel+bounces-42663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EECA45898
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771C31885CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5858224235;
	Wed, 26 Feb 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="aWRf0kSG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89B1E1DEC;
	Wed, 26 Feb 2025 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559224; cv=none; b=pX+Z4XQnH9TBWXoSChLI5mEtG4RbDaNxsbvG8LuJR/EgP0AC3324Yu/4TiaQsZpL9TpV9f7hrwVp3hj1VQnOTClJHiAd/svqBaYHpM5o0niGwLQsiRICfwTs0D5zyhlt2VEsruhyQQFOUyY0PsQnBFz/5zv4buuw/iOzY1TPyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559224; c=relaxed/simple;
	bh=Td9kPv+4aEqMiRvo8WQdVA0t/ydWeEaHLWoB0s8TtIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bos2YejeAhYRM96hRScfzRFzgK8ZTmeQEjsjgT/kN9Dqg4RcuypQPJIOh1o9pQZJmrURw0lEdRpVXvD8WCP50P018vap5kYAsadJArkr8Xlg5OkXysx/uHrriVyFwFGggH/7ao5omsQMFBKb0rRMIDZ7rFW4H7vSS/z8nM9SCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=aWRf0kSG; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740559223; x=1772095223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lh1Ns51OurirFGbJo73DhgVZ1PCIKOIciohAAfR5Ylc=;
  b=aWRf0kSGnpEGu4t32qelUQtQNbYnCm32H+dvThMUwDBY+L1jAlVfQNSt
   9lFxuHl220cLybMoYUEsQL7UzWIucSmw1NaFyMdG+Ul9CEStZ7jGvOuqS
   8MRcJScF2EkIYSaMyyGBi5pdwhiBjwlrAnFpW0nxewxQCm07/aZ7W/YH3
   o=;
X-IronPort-AV: E=Sophos;i="6.13,316,1732579200"; 
   d="scan'208";a="26144342"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:37:51 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:52267]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.30.133:2525] with esmtp (Farcaster)
 id 287ec09d-dd1c-4342-a920-a9f616a17912; Wed, 26 Feb 2025 08:37:47 +0000 (UTC)
X-Farcaster-Flow-ID: 287ec09d-dd1c-4342-a920-a9f616a17912
Received: from EX19D030EUC003.ant.amazon.com (10.252.61.173) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:37:41 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D030EUC003.ant.amazon.com (10.252.61.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:37:41 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:37:40 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTPS id D3830805C1;
	Wed, 26 Feb 2025 08:37:36 +0000 (UTC)
Message-ID: <086e02c8-6408-4b15-9384-42313254f041@amazon.co.uk>
Date: Wed, 26 Feb 2025 08:37:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] KVM: Add capability to discover
 KVM_GMEM_NO_DIRECT_MAP support
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
 <20250221160728.1584559-5-roypat@amazon.co.uk>
 <ce3ce109-f38a-4053-808b-5cc75257f3f7@redhat.com>
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
In-Reply-To: <ce3ce109-f38a-4053-808b-5cc75257f3f7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Tue, 2025-02-25 at 16:55 +0000, David Hildenbrand wrote:
> On 21.02.25 17:07, Patrick Roy wrote:
>> Add a capability to let userspace discover whether guest_memfd supports
>> removing its folios from the direct map. Support depends on guest_memfd
>> itself being supported, but also on whether KVM can manipulate the
>> direct map at page granularity at all (possible most of the time, just
>> arm64 is a notable outlier where its impossible if the direct map has
>> been setup using hugepages, as arm64 cannot break these apart due to
>> break-before-make semantics).
>>
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>> ---
> 
> Not sure how KVM folks handle that, but I suspect we would just want to
> squash that into the previous commit,
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

Ah, yeah, I just had a look at the commit history in this file and
indeed these have seem to usually be squashed. Will do so too, thanks!

Best, 
Patrick

