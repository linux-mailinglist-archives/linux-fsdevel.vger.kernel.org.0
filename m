Return-Path: <linux-fsdevel+bounces-51317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF56AD5518
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E7D3ABA08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20F1281351;
	Wed, 11 Jun 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jTOyg9qS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87827280313;
	Wed, 11 Jun 2025 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643784; cv=none; b=IjuROPf6qB2s+pTXdM3xfKsquYNhSJ/dJ2bTaj2wjx6hEKqm6CQGkoKVr25tD0n/0O0PatubrxN6hCFXSqKLFMNn3Pj8kewl9yiP9JWVNRpNv1klM2Fa8MI9Zd0iZp8jor4ELMxw2lf5gYJb3gjDNLUhUdsN9vvPl0JlDwAIN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643784; c=relaxed/simple;
	bh=8edYvABXWEyW4QyjYA/sihNI6vUS+2Ib7tvaC/2Cqqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E6CXoKTAIS/g7uy7b8kb53GgKRyzq0giLtSUjgdGa79u2NSufqygZeJWKCfAHKL8ayJR/v1eXRYOuO2J+BSrOC5aGM9WITOx2qwllWI7xgcJG9VcQv+AALGC7Q9tK5GcqAqQbMqqKEwd3ou7YWL5iBeH/qc7GkHdyIqLk8FPx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jTOyg9qS; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749643782; x=1781179782;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=8uWizOJisq3qvf+JalT9q9Tn4t52oR3ukVog/80wa+A=;
  b=jTOyg9qS2Iip1E313QaNcMjgTVGriJoa+MPma+NObGnfyxMDfn2svhYO
   MmUmgzKtSFhQogJT69bW4nPrg9gKpJMvkeB8EOmS7Fo7gXVxqxoYHga0R
   cG+rbjEob4rTIDYEFNrc4U8iOysxQNgTN7c7e6rBcIl3nuMIi57raBk3N
   aug0ljnSdCOxL40TwU3a7IxOVKPwJAH1CTYdg6Mv5G6mjWBDNCLlJmo/F
   hQVzHnzfez2Np6oaAU9Dbf05X4VMIp8WxUN4C5zohptrlyBDztkyTUagg
   DHj3D9xvd/5TeW80PaZinQVZJapJxMrhi9NX3j1fiQGHIUmcuA+cYGnyT
   w==;
X-IronPort-AV: E=Sophos;i="6.16,227,1744070400"; 
   d="scan'208";a="210305053"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:09:39 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:27053]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.130:2525] with esmtp (Farcaster)
 id 7a036aa7-dc10-479b-80c2-2a7384eb7725; Wed, 11 Jun 2025 12:09:38 +0000 (UTC)
X-Farcaster-Flow-ID: 7a036aa7-dc10-479b-80c2-2a7384eb7725
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 12:09:38 +0000
Received: from [192.168.1.170] (10.106.82.32) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 11 Jun 2025
 12:09:36 +0000
Message-ID: <dd851cab-eb22-40ae-b926-6f0eb1567299@amazon.com>
Date: Wed, 11 Jun 2025 13:09:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 4/6] KVM: guest_memfd: add support for userfaultfd
 minor
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
 <20250404154352.23078-5-kalyazin@amazon.com> <aEiwvi-oqfTiyP3s@x1.local>
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
In-Reply-To: <aEiwvi-oqfTiyP3s@x1.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D001EUA002.ant.amazon.com (10.252.50.215) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 10/06/2025 23:25, Peter Xu wrote:
> On Fri, Apr 04, 2025 at 03:43:50PM +0000, Nikita Kalyazin wrote:
>> Add support for sending a pagefault event if userfaultfd is registered.
>> Only page minor event is currently supported.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   virt/kvm/guest_memfd.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index fbf89e643add..096d89e7282d 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -4,6 +4,9 @@
>>   #include <linux/kvm_host.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/anon_inodes.h>
>> +#ifdef CONFIG_KVM_PRIVATE_MEM
>> +#include <linux/userfaultfd_k.h>
>> +#endif /* CONFIG_KVM_PRIVATE_MEM */
>>
>>   #include "kvm_mm.h"
>>
>> @@ -380,6 +383,13 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>>                kvm_gmem_mark_prepared(folio);
>>        }
>>
>> +     if (userfaultfd_minor(vmf->vma) &&
>> +         !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
>> +             folio_unlock(folio);
>> +             filemap_invalidate_unlock_shared(inode->i_mapping);
>> +             return handle_userfault(vmf, VM_UFFD_MINOR);
>> +     }
>> +
> 
> Hmm, does guest-memfd (when with your current approach) at least needs to
> define the new can_userfault() hook?
> 
> Meanwhile, we have some hard-coded lines so far, like:
> 
> mfill_atomic():
>          if (!vma_is_shmem(dst_vma) &&
>              uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>                  goto out_unlock;
> 
> I thought it would fail guest-memfd already on a CONTINUE request, and it
> doesn't seem to be touched yet in this series.
> 
> I'm not yet sure how the test worked out without hitting things like it.
> Highly likely I missed something.  Some explanations would be welcomed..

Yes, I realised that I'd failed to post this part soon after I sent the 
series, but I refrained from sending a new version because the upstream 
consensus was to review/merge the mmap support in guest_memfd [1] before 
continuing to build on top of it.  This is the missed part I planned to 
include in the next version.  Sorry for the confusion.

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 64551e8a55fb..080437fa7eab 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -221,8 +221,10 @@ static inline bool vma_can_userfault(struct 
vm_area_struct *vma,
  	if (vm_flags & VM_DROPPABLE)
  		return false;

-	if (!vma->vm_ops->can_userfault ||
-	    !vma->vm_ops->can_userfault(vma, VM_UFFD_MINOR))
+	if ((vm_flags & VM_UFFD_MINOR) &&
+	     (!vma->vm_ops ||
+	      !vma->vm_ops->can_userfault ||
+	      !vma->vm_ops->can_userfault(vma, VM_UFFD_MINOR)))
  		return false;

  	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0aa82c968e16..638360a78561 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -788,7 +788,9 @@ static __always_inline ssize_t mfill_atomic(struct 
userfaultfd_ctx *ctx,
  		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
  					     src_start, len, flags);

-	can_userfault = dst_vma->vm_ops->can_userfault &&
+	can_userfault =
+	    dst_vma->vm_ops &&
+	    dst_vma->vm_ops->can_userfault &&
  	    dst_vma->vm_ops->can_userfault(dst_vma, __VM_UFFD_FLAGS);

  	if (!vma_is_anonymous(dst_vma) && !can_userfault)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 91ee5dd91c31..202b12dc4b6f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -420,8 +420,15 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
  	return ret;
  }

+static bool kvm_gmem_can_userfault(struct vm_area_struct *vma,
+				   unsigned long vm_flags)
+{
+	return vm_flags & VM_UFFD_MINOR;
+}
+
  static const struct vm_operations_struct kvm_gmem_vm_ops = {
-	.fault = kvm_gmem_fault,
+	.fault         = kvm_gmem_fault,
+	.can_userfault = kvm_gmem_can_userfault,
  };

  static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)


[1] https://lore.kernel.org/kvm/20250605153800.557144-1-tabba@google.com/

> 
> Thanks,
> 
>>        vmf->page = folio_file_page(folio, vmf->pgoff);
>>
>>   out_folio:
>> --
>> 2.47.1
>>
> 
> --
> Peter Xu
> 


