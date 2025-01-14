Return-Path: <linux-fsdevel+bounces-39158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED20A10BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD9C3A7937
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E11D5ACE;
	Tue, 14 Jan 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AKQJWj06"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19B1CC177;
	Tue, 14 Jan 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870888; cv=none; b=nawzlkhPP8p8AjnB8QCDt/JlWh2dLgsoAo1m/4v/AULG9SZbPc6ezA1V9awAtFgmur3s9uRsLXEhwOW5paXl4SFu3q8UuFm6YtAMlESHXrR4sWiaAm1fMXsvLaoOOHOhh/RjkxMnoqyT//5Z7LZCXTjr4yhLhXersgyez0kaS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870888; c=relaxed/simple;
	bh=JeaD79EKrK5fkxPfxIYERqMmSCsUY5LbK0RN0DfKvvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lNrYFLKoyUwUGZWvys39rKDQar5fDNwlIjAauhr8FYMh+99QuLHme1DRPwEpHDKHwAvWPUXYCaWkt/rb7nQzQJaLTlCY6NTLGkcdpJFnbVfQOvmxrRFQmCcnUUq0h9i1GAdBhJb35NnIUFQ43UCxqJBgWMcqsExrFoTMBFfvb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AKQJWj06; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736870887; x=1768406887;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=j1aI42Rnqis5pWbylE0MZCFhx/yfaAvLm9jT5d7y22A=;
  b=AKQJWj06WRVY+3YOCnZMfEWD7lAvEwDRu7lAI2CsjbNb73Yr1y7zI61l
   3tuDF8pAf4G88qjVxlbis/rANwq30u9TVYce8UO6G8CLC5BaQw3YxEdS1
   9ffE2j0u9qm1UIMJSGM0OmzyVNCNEoadgulkKPWNiD6VMViWObcARPUte
   I=;
X-IronPort-AV: E=Sophos;i="6.12,314,1728950400"; 
   d="scan'208";a="710795951"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:04 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:12488]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.19:2525] with esmtp (Farcaster)
 id 7a2330f1-d35b-41fd-9188-a6b659e1e747; Tue, 14 Jan 2025 16:08:03 +0000 (UTC)
X-Farcaster-Flow-ID: 7a2330f1-d35b-41fd-9188-a6b659e1e747
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 16:08:02 +0000
Received: from [192.168.8.40] (10.106.82.12) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Tue, 14 Jan 2025
 16:08:01 +0000
Message-ID: <9e008ea0-e715-4c04-842a-824ea37790a2@amazon.com>
Date: Tue, 14 Jan 2025 16:08:00 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 2/2] KVM: guest_memfd: use filemap_grab_folios in
 write
To: <michael.day@amd.com>, <willy@infradead.org>, <pbonzini@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <david@redhat.com>, <jthoughton@google.com>, <michael.roth@amd.com>,
	<ackerleytng@google.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>
References: <20250110154659.95464-1-kalyazin@amazon.com>
 <20250110154659.95464-3-kalyazin@amazon.com>
 <7cf9f0fd-279e-4e4d-99ac-966a752090a2@amd.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJj5ki9BQkDwmcAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOR1wD/UTcn4GbLC39QIwJuWXW0DeLoikxFBYkbhYyZ5CbtrtAA/2/rnR/zKZmyXqJ6
 ULlSE8eWA3ywAIOH8jIETF2fCaUCzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmPmSL0FCQPCZwACGwwACgkQr5LKIKmaZPNCxAEAxwnrmyqSC63nf6hoCFCfJYQapghC
 abLV0+PWemntlwEA/RYx8qCWD6zOEn4eYhQAucEwtg6h1PBbeGK94khVMooF
In-Reply-To: <7cf9f0fd-279e-4e4d-99ac-966a752090a2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D001EUB003.ant.amazon.com (10.252.51.38) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)

On 10/01/2025 21:08, Mike Day wrote:
> On 1/10/25 09:46, Nikita Kalyazin wrote:
>> The write syscall on guest_memfd makes use of filemap_grab_folios to
>> grab folios in batches.  This speeds up population by 8.3% due to the
>> reduction in locking and tree walking when adding folios to the
>> pagecache.
>>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   virt/kvm/guest_memfd.c | 176 +++++++++++++++++++++++++++++++++--------
>>   1 file changed, 143 insertions(+), 33 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index e80566ef56e9..ccfadc3a7389 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -102,17 +102,134 @@ static struct folio *kvm_gmem_get_folio(struct 
>> inode *inode, pgoff_t index)
>>       return filemap_grab_folio(inode->i_mapping, index);
>>   }
>>
>> +/*
>> + * Returns locked folios on success.  The caller is responsible for
>> + * setting the up-to-date flag before the memory is mapped into the 
>> guest.
>> + * There is no backing storage for the memory, so the folios will remain
>> + * up-to-date until they're removed.
>> + *
>> + * Ignore accessed, referenced, and dirty flags.  The memory is
>> + * unevictable and there is no storage to write back to.
>> + */
>> +static int kvm_gmem_get_folios(struct inode *inode, pgoff_t index,
>> +                            struct folio **folios, int num)
>> +{
>> +     return filemap_grab_folios(inode->i_mapping, index, folios, num);
>> +}
>> +
>>   #if defined(CONFIG_KVM_GENERIC_PRIVATE_MEM) && ! 
>> defined(CONFIG_KVM_AMD_SEV)
>> +static int kvm_kmem_gmem_write_inner(struct inode *inode, pgoff_t index,
>> +                                  const void __user *buf,
>> +                                     struct folio **folios, int num)
>> +{
>> +     int ret, i, num_grabbed, num_written;
>> +
>> +     num_grabbed = kvm_gmem_get_folios(inode, index, folios, num);
>> +     if (num_grabbed < 0)
>> +             return num_grabbed;
>> +
>> +     for (i = 0; i < num_grabbed; i++) {
>> +             struct folio *folio = folios[i];
>> +             void *vaddr;
>> +
>> +             if (folio_test_hwpoison(folio)) {
>> +                     folio_unlock(folio);
>> +                     folio_put(folio);
>> +                     ret = -EFAULT;
>> +                     break;
>> +             }
>> +
>> +             if (folio_test_uptodate(folio)) {
>> +                     folio_unlock(folio);
>> +                     folio_put(folio);
>> +                     ret = -ENOSPC;
>> +                     break;
>> +             }
>> +
>> +             folio_unlock(folio);
>> +
>> +             vaddr = kmap_local_folio(folio, 0);
>> +             ret = copy_from_user(vaddr, buf + (i << PAGE_SHIFT), 
>> PAGE_SIZE);
>> +             if (ret)
>> +                     ret = -EINVAL;
>> +             kunmap_local(vaddr);
>> +
>> +             if (ret) {
>> +                     folio_put(folio);
>> +                     break;
>> +             } else {
>> +                     kvm_gmem_mark_prepared(folio);
>> +                     folio_put(folio);
>> +             }
>> +     }
>> +
>> +     num_written = i;
>> +
>> +     for (i = num_written; i < num_grabbed; i++) {
>> +             folio_unlock(folios[i]);
>> +             folio_put(folios[i]);
>> +     }
>> +
>> +     return num_written ?: ret;
>> +}
>> +
>> +static struct folio *kvm_kmem_gmem_write_folio(struct inode *inode, 
>> pgoff_t index,
>> +                                            const char __user *buf)
>>
> 
> This could probably be rewritten as:
> 
>         struct folio *p_folio;
>         int ret;
> 
>         ret = kvm_kmem_gmem_write_inner(inode, index, buf, &p_folio, 1);
> 
>         if (ret == 1)
>                 return p_folio;
>         else
>                 return ERR_PTR(ret);
> 
> Would remove a few lines of duplicated code and use only one prototype.

Indeed!  Thanks for the suggestion, will apply in the next revision.

> 
> Mike
> 
> +{
>> +     struct folio *folio;
>> +     void *vaddr;
>> +     int ret = 0;
>> +
>> +     folio = kvm_gmem_get_folio(inode, index);
>> +     if (IS_ERR(folio))
>> +             return ERR_PTR(-EFAULT);
>> +
>> +     if (folio_test_hwpoison(folio)) {
>> +             ret = -EFAULT;
>> +             goto out_unlock_put;
>> +     }
>> +
>> +     if (folio_test_uptodate(folio)) {
>> +             ret = -ENOSPC;
>> +             goto out_unlock_put;
>> +     }
>> +
>> +     folio_unlock(folio);
>> +
>> +     vaddr = kmap_local_folio(folio, 0);
>> +     ret = copy_from_user(vaddr, buf, PAGE_SIZE);
>> +     if (ret)
>> +             ret = -EINVAL;
>> +     kunmap_local(vaddr);
>> +
>> +     if (ret) {
>> +             folio_put(folio);
>> +             kvm_gmem_mark_prepared(folio);
>> +             goto out_err;
>> +     }
>> +
>> +     folio_put(folio);
>> +
>> +     return folio;
>> +
>> +out_unlock_put:
>> +     folio_unlock(folio);
>> +     folio_put(folio);
>> +out_err:
>> +     return ERR_PTR(ret);
>> +}
>> +
>>   static ssize_t kvm_kmem_gmem_write(struct file *file, const char 
>> __user *buf,
>>                                  size_t count, loff_t *offset)
>>   {
>> +     struct inode *inode = file_inode(file);
>> +     int ret = 0, batch_size = FILEMAP_GET_FOLIOS_BATCH_SIZE;
>>       pgoff_t start, end, index;
>> -     ssize_t ret = 0;
>>
>>       if (!PAGE_ALIGNED(*offset) || !PAGE_ALIGNED(count))
>>               return -EINVAL;
>>
>> -     if (*offset + count > i_size_read(file_inode(file)))
>> +     if (*offset + count > i_size_read(inode))
>>               return -EINVAL;
>>
>>       if (!buf)
>> @@ -123,9 +240,8 @@ static ssize_t kvm_kmem_gmem_write(struct file 
>> *file, const char __user *buf,
>>
>>       filemap_invalidate_lock(file->f_mapping);
>>
>> -     for (index = start; index < end; ) {
>> -             struct folio *folio;
>> -             void *vaddr;
>> +     for (index = start; index + batch_size - 1 < end; ) {
>> +             struct folio *folios[FILEMAP_GET_FOLIOS_BATCH_SIZE] = 
>> { NULL };
>>               pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
>>
>>               if (signal_pending(current)) {
>> @@ -133,46 +249,40 @@ static ssize_t kvm_kmem_gmem_write(struct file 
>> *file, const char __user *buf,
>>                       goto out;
>>               }
>>
>> -             folio = kvm_gmem_get_folio(file_inode(file), index);
>> -             if (IS_ERR(folio)) {
>> -                     ret = -EFAULT;
>> +             ret = kvm_kmem_gmem_write_inner(inode, index, buf + 
>> buf_offset, folios, batch_size);
>> +             if (ret < 0)
>>                       goto out;
>> -             }
>>
>> -             if (folio_test_hwpoison(folio)) {
>> -                     folio_unlock(folio);
>> -                     folio_put(folio);
>> -                     ret = -EFAULT;
>> +             index += ret;
>> +             if (ret < batch_size)
>> +                     break;
>> +     }
>> +
>> +     for (; index < end; index++) {
>> +             struct folio *folio;
>> +             pgoff_t buf_offset = (index - start) << PAGE_SHIFT;
>> +
>> +             if (signal_pending(current)) {
>> +                     ret = -EINTR;
>>                       goto out;
>>               }
>>
>> -             if (folio_test_uptodate(folio)) {
>> -                     folio_unlock(folio);
>> -                     folio_put(folio);
>> -                     ret = -ENOSPC;
>> +             folio = kvm_kmem_gmem_write_folio(inode, index,
>> +                                               buf + buf_offset);
>> +             if (IS_ERR(folio)) {
>> +                     ret = PTR_ERR(folio);
>>                       goto out;
>>               }
>> -
>> -             folio_unlock(folio);
>> -
>> -             vaddr = kmap_local_folio(folio, 0);
>> -             ret = copy_from_user(vaddr, buf + buf_offset, PAGE_SIZE);
>> -             if (ret)
>> -                     ret = -EINVAL;
>> -             kunmap_local(vaddr);
>> -
>> -             kvm_gmem_mark_prepared(folio);
>> -             folio_put(folio);
>> -
>> -             index = folio_next_index(folio);
>> -             *offset += PAGE_SIZE;
>>       }
>>
>>   out:
>>       filemap_invalidate_unlock(file->f_mapping);
>> +     if (index > start) {
>> +             *offset += (index - start) << PAGE_SHIFT;
>> +             return (index - start) << PAGE_SHIFT;
>> +     }
>>
>> -     return ret && start == (*offset >> PAGE_SHIFT) ?
>> -             ret : *offset - (start << PAGE_SHIFT);
>> +     return ret;
>>   }
>>   #endif
>>


