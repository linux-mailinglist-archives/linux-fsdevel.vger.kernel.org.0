Return-Path: <linux-fsdevel+bounces-51316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE6AD5510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC5F7AC5BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB527FD48;
	Wed, 11 Jun 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ryRoA/4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36943246798;
	Wed, 11 Jun 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643781; cv=none; b=hzdtv81DBURJPlSYmrNhFtwBhk/t+k0NgrTVgol/ip/FKuLd+o3S7l00Y5OqudrHn6jorMO7/UX1OrOYotqtimRo1uwG3t2Lq9rkHDd0j6ag4Lx1HzLVco4Bxvw5LWP4ojRj2vmQz80ahMR7Fh9B+p3zj0j12x6HHU3L8gwSTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643781; c=relaxed/simple;
	bh=lk0PED5pXGrSgc6fTcC4zqze0TtP8mCx/ibnLORlYDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iCaDSZc/B60YpAw44bWC4vFWrPn3M2vHpxbB6Ueri9QvuzTTMGTcbuWQWqNbI98vFtVXGBZ7lNtXEXSsRxqQ1L7zNiL8A6pCeVROk+DDH+YwwakkU95GK8FMeQ4O5BR3R0b064yT2ECJEyfAlmcf69PD15qnABipkGadTVM11Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ryRoA/4t; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749643780; x=1781179780;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=4usJcNNcgjXBZCgJObiiAHubx2WJa1Zhq0ik5FOjS0s=;
  b=ryRoA/4tpiUnA2ZytpcIt/WXR4MczuKac8jmajB9raN+avnuHRCjdBin
   MNEBKCP6TjUorpW5Ehieapb/pCnmh6k3SV/UJahZ7ZsyYeGr7rYBwIJpL
   UB1f3DrTAgBNPbETDe/zC/I72L5rvp8cmdVuFQBBMpenS4tzM5ttFqfn3
   zVRoGoWJ99vR+FjgjKzrjXdHKqey9I5vkuHtNVnidYeyOn1+DoAAaaV+C
   7czfsoSwsqDBMdoAQWIFtZ2Lb2Qq+o+VRIJWKxuZB6qqLA9DHUTjHak2j
   tn+7Cfj+l6sMh5uEstgxh6Iit/Norbbiap5buTJK6gPe7jPRaRcI8x1vG
   g==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="754132407"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:09:37 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:12650]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.229:2525] with esmtp (Farcaster)
 id b0e5603a-39dc-44ec-9237-eee7d8ad4ba0; Wed, 11 Jun 2025 12:09:35 +0000 (UTC)
X-Farcaster-Flow-ID: b0e5603a-39dc-44ec-9237-eee7d8ad4ba0
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 12:09:35 +0000
Received: from [192.168.1.170] (10.106.82.32) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 11 Jun 2025
 12:09:33 +0000
Message-ID: <36d96316-fd9b-4755-bb35-d1a2cea7bb7e@amazon.com>
Date: Wed, 11 Jun 2025 13:09:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 1/6] mm: userfaultfd: generic continue for non
 hugetlbfs
To: Peter Xu <peterx@redhat.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <jannh@google.com>,
	<ryan.roberts@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-2-kalyazin@amazon.com> <aEiwHjl4tsUt98sh@x1.local>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <aEiwHjl4tsUt98sh@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D001EUA002.ant.amazon.com (10.252.50.215) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 10/06/2025 23:22, Peter Xu wrote:
> On Fri, Apr 04, 2025 at 03:43:47PM +0000, Nikita Kalyazin wrote:
>> Remove shmem-specific code from UFFDIO_CONTINUE implementation for
>> non-huge pages by calling vm_ops->fault().  A new VMF flag,
>> FAULT_FLAG_USERFAULT_CONTINUE, is introduced to avoid recursive call to
>> handle_userfault().
> 
> It's not clear yet on why this is needed to be generalized out of the blue.
> 
> Some mentioning of guest_memfd use case might help for other reviewers, or
> some mention of the need to introduce userfaultfd support in kernel
> modules.

Hi Peter,

Sounds fair, thank you.

>>
>> Suggested-by: James Houghton <jthoughton@google.com>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   include/linux/mm_types.h |  4 ++++
>>   mm/hugetlb.c             |  2 +-
>>   mm/shmem.c               |  9 ++++++---
>>   mm/userfaultfd.c         | 37 +++++++++++++++++++++++++++----------
>>   4 files changed, 38 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 0234f14f2aa6..2f26ee9742bf 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1429,6 +1429,9 @@ enum tlb_flush_reason {
>>    * @FAULT_FLAG_ORIG_PTE_VALID: whether the fault has vmf->orig_pte cached.
>>    *                        We should only access orig_pte if this flag set.
>>    * @FAULT_FLAG_VMA_LOCK: The fault is handled under VMA lock.
>> + * @FAULT_FLAG_USERFAULT_CONTINUE: The fault handler must not call userfaultfd
>> + *                                 minor handler as it is being called by the
>> + *                                 userfaultfd code itself.
> 
> We probably shouldn't leak the "CONTINUE" concept to mm core if possible,
> as it's not easy to follow when without userfault minor context.  It might
> be better to use generic terms like NO_USERFAULT.

Yes, I agree, can name it more generically.

> Said that, I wonder if we'll need to add a vm_ops anyway in the latter
> patch, whether we can also avoid reusing fault() but instead resolve the
> page faults using the vm_ops hook too.  That might be helpful because then
> we can avoid this new FAULT_FLAG_* that is totally not useful to
> non-userfault users, meanwhile we also don't need to hand-cook the vm_fault
> struct below just to suite the current fault() interfacing.

I'm not sure I fully understand that.  Calling fault() op helps us reuse 
the FS specifics when resolving the fault.  I get that the new op can 
imply the userfault flag so the flag doesn't need to be exposed to mm, 
but doing so will bring duplication of the logic within FSes between 
this new op and the fault(), unless we attempt to factor common parts 
out.  For example, for shmem_get_folio_gfp(), we would still need to 
find a way to suppress the call to handle_userfault() when 
shmem_get_folio_gfp() is called from the new op.  Is that what you're 
proposing?

> 
> Thanks,
> 
> --
> Peter Xu
> 


