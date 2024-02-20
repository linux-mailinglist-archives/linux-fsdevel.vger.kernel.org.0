Return-Path: <linux-fsdevel+bounces-12167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F8185C2B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 18:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B323BB231A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8177637;
	Tue, 20 Feb 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYrfJ38p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030076C98
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450281; cv=none; b=SR1dJQS9axQA+/E94Z/rZXFnNtlmeyO5D4pIQ6WWx/7atJz5HJnjop4SI6a6terFFm3KjvyjyHRJeGl2P+hNRRc2icKj+VA2Esac9Hrbyxzh30o3QbJe3iBUEPnN1NoA125QXbrasqJ41gICrP1p2JZnRqU3brxeOdJkalocQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450281; c=relaxed/simple;
	bh=7F/jCj8h5EOzHGJsyRDGblHmOYhK1WZea0S9nAohiSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZYEuzscTJdIoS4X0sN1xmGEdJfkiTVPS2MrXUE/UwrC1CprpyMCDfduJJtgFg2UEUC6nt6hQS1bwDgncNmeCg7D3fW+L62ToyymRciKBxI4vAug28p0bow/Jlcazyr3KbdiI3oCa0RglyS/Z78z6mfd9tKdG7Sbv50xCqEr8nkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYrfJ38p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1bv8xjCVWaGOIj6gJhQjR+pYZ2lorBhLUIDc2qwlh5U=;
	b=dYrfJ38pEY94Q7J4tA/KQpn2mr8D2gumdUUqNhijECT6NxQhNlA1ezikBUaVVe3KerLaEW
	+dxQyiljkvn9vA3k/5fY8rFW1d1808MEcihyq9SGSB4I5/ToEbAOZ+R8EIqGKsCY6Y42Ur
	3aVLzzSzZP2HDGk1rL5Mt9i8fIGcaqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-neJ3e3RrMLWDx9OyZQar4g-1; Tue, 20 Feb 2024 12:31:09 -0500
X-MC-Unique: neJ3e3RrMLWDx9OyZQar4g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d66d64ca0so474320f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:31:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450268; x=1709055068;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1bv8xjCVWaGOIj6gJhQjR+pYZ2lorBhLUIDc2qwlh5U=;
        b=qQb5d4wdnnqRgz0dipoqZEcybb+D3P41xE+atdK/dWuFo0lbxrDYKM9iXGFX3/JYuz
         vaj64Sq9rFMUOipsW9lGjKSwPQFmO6NenZZvhfMJnoF+mJkHbiNc3EAe9LxSYHmWBY93
         yJykT59yfrG07xrkQXF9FbzPvVaRQdBBmiCvj5VmioREyiZmM5J4lA5eiKsq7KfkcBJV
         qE1NiyLM4P3rOKeQzpv2ofpX/oZNwDT4w4Glwkmmi1mACBcGga5rGoDhSdRQoPOWT/Jt
         ecqfvJiOFSVmh9LhoFjKGSVJHt6M9XDkDRk0mC1X5G0Iei4kc9uI/+iLsf+IGthn9JgU
         8zKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfOwJwBJSvTxkhzxKUgK3VISJ4z8JQ4GYI7TaYD2vguMRPvqyzpP2tT0jTq9DiJF13uLQmjMzPlA1c5WLCNhU6b5W/wTb++5yS6kRk2w==
X-Gm-Message-State: AOJu0YylBEy8AWofliYgQHsd36hs0HuXB6aYlmhRxjTnp2bSmklsYt2l
	qYVUliy7U11o3R5q+XA6mauBwEBWIji5tr+IgZcUAC7Ww1zI4MsMMAmRsVhkba5pBf6sX4ctACf
	6QcQUiGkGhYJp1gJ1VgBwu1D+j4wNo0L4R5ONUI/JDpud1FTiwUWKUIH9i97K1dU=
X-Received: by 2002:a5d:648e:0:b0:33d:3bc2:7acc with SMTP id o14-20020a5d648e000000b0033d3bc27accmr6546967wri.11.1708450268310;
        Tue, 20 Feb 2024 09:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+pbi6x/dxZpQzRa62/j337TBISqOrd8nrJYMulRLgLDemyARYJC0MY4/35YRKl1MuxN3Qfg==
X-Received: by 2002:a5d:648e:0:b0:33d:3bc2:7acc with SMTP id o14-20020a5d648e000000b0033d3bc27accmr6546927wri.11.1708450267592;
        Tue, 20 Feb 2024 09:31:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb? (p200300cbc72abc009a2d8a48ef5196fb.dip0.t-ipconnect.de. [2003:cb:c72a:bc00:9a2d:8a48:ef51:96fb])
        by smtp.gmail.com with ESMTPSA id x6-20020adff0c6000000b0033cfc035940sm14071979wro.34.2024.02.20.09.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:31:07 -0800 (PST)
Message-ID: <bc7d1702-315f-4e10-899d-491a0cee8cee@redhat.com>
Date: Tue, 20 Feb 2024 18:31:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>, Liam.Howlett@oracle.com,
 corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
 brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
 mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
 peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
 <20231027033845.90608-11-zhangpeng.00@bytedance.com>
 <6058742c-26e5-4600-85ad-0a21d8fd2e42@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6058742c-26e5-4600-85ad-0a21d8fd2e42@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.24 18:24, David Hildenbrand wrote:
> On 27.10.23 05:38, Peng Zhang wrote:
>> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
>> directly replacing the entries of VMAs in the new maple tree can result
>> in better performance. __mt_dup() uses DFS pre-order to duplicate the
>> maple tree, so it is efficient.
>>
>> The average time complexity of __mt_dup() is O(n), where n is the number
>> of VMAs. The proof of the time complexity is provided in the commit log
>> that introduces __mt_dup(). After duplicating the maple tree, each element
>> is traversed and replaced (ignoring the cases of deletion, which are rare).
>> Since it is only a replacement operation for each element, this process is
>> also O(n).
>>
>> Analyzing the exact time complexity of the previous algorithm is
>> challenging because each insertion can involve appending to a node, pushing
>> data to adjacent nodes, or even splitting nodes. The frequency of each
>> action is difficult to calculate. The worst-case scenario for a single
>> insertion is when the tree undergoes splitting at every level. If we
>> consider each insertion as the worst-case scenario, we can determine that
>> the upper bound of the time complexity is O(n*log(n)), although this is a
>> loose upper bound. However, based on the test data, it appears that the
>> actual time complexity is likely to be O(n).
>>
>> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
>> fails, there will be a portion of VMAs that have not been duplicated in
>> the maple tree. To handle this, we mark the failure point with
>> XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
>> releasing VMAs that have not been duplicated after this point.
>>
>> There is a "spawn" in byte-unixbench[1], which can be used to test the
>> performance of fork(). I modified it slightly to make it work with
>> different number of VMAs.
>>
>> Below are the test results. The first row shows the number of VMAs.
>> The second and third rows show the number of fork() calls per ten seconds,
>> corresponding to next-20231006 and the this patchset, respectively. The
>> test results were obtained with CPU binding to avoid scheduler load
>> balancing that could cause unstable results. There are still some
>> fluctuations in the test results, but at least they are better than the
>> original performance.
>>
>> 21     121   221    421    821    1621   3221   6421   12821  25621  51221
>> 112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
>> 114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
>> 2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%
>>
>> [1] https://github.com/kdlucas/byte-unixbench/tree/master
>>
>> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
>> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
>>    include/linux/mm.h | 11 +++++++++++
>>    kernel/fork.c      | 40 +++++++++++++++++++++++++++++-----------
>>    mm/internal.h      | 11 -----------
>>    mm/memory.c        |  7 ++++++-
>>    mm/mmap.c          |  9 ++++++---
>>    5 files changed, 52 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 14d5aaff96d0..e9111ec5808c 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -996,6 +996,17 @@ static inline int vma_iter_bulk_alloc(struct vma_iterator *vmi,
>>    	return mas_expected_entries(&vmi->mas, count);
>>    }
>>    
>> +static inline int vma_iter_clear_gfp(struct vma_iterator *vmi,
>> +			unsigned long start, unsigned long end, gfp_t gfp)
>> +{
>> +	__mas_set_range(&vmi->mas, start, end - 1);
>> +	mas_store_gfp(&vmi->mas, NULL, gfp);
>> +	if (unlikely(mas_is_err(&vmi->mas)))
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>>    /* Free any unused preallocations */
>>    static inline void vma_iter_free(struct vma_iterator *vmi)
>>    {
>> diff --git a/kernel/fork.c b/kernel/fork.c
>> index 1e6c656e0857..1552ee66517b 100644
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>    	int retval;
>>    	unsigned long charge = 0;
>>    	LIST_HEAD(uf);
>> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>>    	VMA_ITERATOR(vmi, mm, 0);
>>    
>>    	uprobe_start_dup_mmap();
>> @@ -678,16 +677,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>>    		goto out;
>>    	khugepaged_fork(mm, oldmm);
>>    
>> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
>> -	if (retval)
>> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
>> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
>> +	if (unlikely(retval))
>>    		goto out;
>>    
>>    	mt_clear_in_rcu(vmi.mas.tree);
>> -	for_each_vma(old_vmi, mpnt) {
>> +	for_each_vma(vmi, mpnt) {
>>    		struct file *file;
>>    
>>    		vma_start_write(mpnt);
> 
> We used to call vma_start_write() on the *old* VMA, to prevent any kind of page faults in
> the old MM while we are duplicating PTEs (and COW-share pages).
> 
> See
> 
> commit fb49c455323ff8319a123dd312be9082c49a23a5
> Author: Suren Baghdasaryan <surenb@google.com>
> Date:   Sat Jul 8 12:12:12 2023 -0700
> 
>       fork: lock VMAs of the parent process when forking
>       
>       When forking a child process, the parent write-protects anonymous pages
>       and COW-shares them with the child being forked using copy_present_pte().
>       
>       We must not take any concurrent page faults on the source vma's as they
>       are being processed, as we expect both the vma and the pte's behind it
>       to be stable.  For example, the anon_vma_fork() expects the parents
>       vma->anon_vma to not change during the vma copy.
> 
> 
> Unless I am missing something, we now call vma_start_write() on the *new* VMA?
> 
> If that is the case, this is broken and needs fixing; likely, going over all
> VMAs in the old_mm and calling vma_start_write().
> 
> But maybe there is some magic going on that I am missing :)

... likely the magic is that the new tree links the same VMAs (we are 
not duplicating the VMAs before vm_area_dup()), so we are indeed locking 
the MM in the old_mm (that is temporarily linked into the new MM).

If that's the case, all good :)

-- 
Cheers,

David / dhildenb


