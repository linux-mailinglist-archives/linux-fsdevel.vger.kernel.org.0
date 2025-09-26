Return-Path: <linux-fsdevel+bounces-62858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2677BA2CAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FDC6262D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8262877D3;
	Fri, 26 Sep 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6K6JIY9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7225263F32
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871890; cv=none; b=C8KmsCJn2WRTaC3yBdvsVX0eTvYUTzh+vt6n6cOQYckru3NALURcmNVrYHbHhgDT8phw7WgOmBeHLPerQXsEqzJa4bMyGzdS+/VMak5sGfO9CptVcs/g/mw+CU6tvNKNxVKlbBp7mOTroc8P96Am+Y2z+H2BiPl9JdSgw/clBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871890; c=relaxed/simple;
	bh=KufU9ZWO/kLUGrCXDHaZph7HljBItyQP4ERJy1huuTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=som4MErXeRWu5QH8Q0DIjGyYm/Z4+XO/dDeKBPGLdWE7aK39KafX68EMN7F4OexurX1WiWaUfKAiKCfnl0JYLYsXpdgeBUefDpSRxwvzLP0r4+Qd2eOr9vw5SQHMjD2vqHE0muSRm2adIJsz9OJZbYGq9fIOYL3I4YJrDi0DsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6K6JIY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758871887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
	b=C6K6JIY9uJPtNjlhYFiJW74bil6xsRncDiBoNbtCMf/1OS8SQMkPMfZzoXGDoMRrKx5RR3
	USu+P+thlLncZjbscdTukSFO1WYwCclQfJl8bJSpjHxwvkC9actWPNYx/af46x64IcFAVR
	bnjc4v0rWDgdLOnz3dkIu6m1FXwaTI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-y4Z8V6MZNDy3odC2lIDKOw-1; Fri, 26 Sep 2025 03:31:26 -0400
X-MC-Unique: y4Z8V6MZNDy3odC2lIDKOw-1
X-Mimecast-MFC-AGG-ID: y4Z8V6MZNDy3odC2lIDKOw_1758871885
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46da436df64so19390495e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871885; x=1759476685;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN4peVxWL0zSknKb/nxU8BZxb2xqfgd1C45ub1DITH8=;
        b=P1Fztz5KocdrerRKuEtoOJ80/WZ7YyNYLpP9/YLsMWTlchgwqCoAFA6ZBIDrVw8EU4
         CIguF5/6Kzupc8tSgv8I21b5KctNBjclsRNiliwtP8jWlDXyBKW/1CySOb37gtd/wf+v
         Y7WK6leW7qUKhAzYzjXp5ojC+mjQm19McIwtq01kJfbZscEhYpXvy6IcjTvnSIsxwGKU
         zCSBTcmV79XRnUAgtkqn2ujkKmesucuko2OSzwRx6lnH3qwbeChEoDML7LcTvsqSn25K
         qA4acCw39Xe45vt9Sgeywu2y6hlkxqdgzKG9vYxBUZ2QNml13Y0P9kU2xqkjIqa8mXxm
         G0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXl8zIjw1PLT3AaI2aPUvGLaIbYKOvaz9zNCIkd8XcmFM1Gx+1NCQDROyRP7HGkxnlUFzj4/nCqipn/ZjQt@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMzmkSRZYPPramp5oLLNU545OODbzYK1emjMFtMAbRkXEhnW/
	hpVihwf9SFz+VTaoF54YQWU9oO3lPvzrPYXVfxcyUMcgRJagmQWcNObQprrR0Mbx7ySP8Wk2Nhm
	fBz5EenWgFlxHuTrJBHC58adIdxR1OWjPs9d/cE/grb/E3zzWlKMRJW1zb6X+L1jXHkY=
X-Gm-Gg: ASbGncu32NgiRjKC7uEEwbxZ/btdLCGhFdprxNv8oVA834GIac6YUv8nSHToJ/DQbQ+
	4otz+tC61jnRTJE3oNXzMl+tY1Rk6EJ/7wZSf61IchSBHc+8W+53Lukd0qPG2+VN0gR65WYxjCp
	Cw5SPrJmaxG2hj8WO4ef0xL/+RUrv5WV6l2v1YxVYwhci/swdXfkmeH8czHvW0LVBS1dfOyMnI/
	rZjmOUm8700nBZXXaSWgJ6UM8QrEUtvcsG617r3W5T2qtqqqaQ2Bl6GlxkHBHKq4i3V/4TRHhOg
	MHlDHI7HX/HHBfkNwv1WbUrvx6TYqh9b7Pn1F4fpR02MpNRexQSRQc5Jus9z5gMHC89+/2duqHo
	ZIjr303ouXPWBlMPsoWNyUh61WYU4Qv0GLooqFZrFDaDFN1/i5e3KfYKi88+RlpdrfvfY
X-Received: by 2002:a05:600c:3ba9:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e329f9c61mr65568275e9.20.1758871884733;
        Fri, 26 Sep 2025 00:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdCFTWN0OMV/8re7i7X1C3LDq1oeLqj0b7w/lVtU1L4ASh3eR7s8IXfpyY0kZjgB5RF7jO9w==
X-Received: by 2002:a05:600c:3ba9:b0:45d:d2d2:f081 with SMTP id 5b1f17b1804b1-46e329f9c61mr65567615e9.20.1758871884155;
        Fri, 26 Sep 2025 00:31:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:c100:5d3c:50c0:398a:3ac9? (p200300d82f34c1005d3c50c0398a3ac9.dip0.t-ipconnect.de. [2003:d8:2f34:c100:5d3c:50c0:398a:3ac9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm105756545e9.20.2025.09.26.00.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 00:31:23 -0700 (PDT)
Message-ID: <95ace421-36d2-48af-b527-7e799722eb17@redhat.com>
Date: Fri, 26 Sep 2025 09:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
To: Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, pbonzini@redhat.com,
 shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org,
 viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org,
 chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com,
 kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
 <20250827175247.83322-10-shivankg@amd.com> <aNW1l-Wdk6wrigM8@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNW1l-Wdk6wrigM8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 23:35, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
>> Add tests for NUMA memory policy binding and NUMA aware allocation in
>> guest_memfd. This extends the existing selftests by adding proper
>> validation for:
>> - KVM GMEM set_policy and get_policy() vm_ops functionality using
>>    mbind() and get_mempolicy()
>> - NUMA policy application before and after memory allocation
>>
>> These tests help ensure NUMA support for guest_memfd works correctly.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>>   .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
>>   2 files changed, 122 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
>> index 90f03f00cb04..c46cef2a7cd7 100644
>> --- a/tools/testing/selftests/kvm/Makefile.kvm
>> +++ b/tools/testing/selftests/kvm/Makefile.kvm
>> @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>>   	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>>   
>>   LDLIBS += -ldl
>> +LDLIBS += -lnuma
> 
> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> trivial, but I'm a little wary of foisting that requirement on all KVM developers
> and build bots.
> 
> I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
> prevelant there.

We unconditionally use it in the mm tests for ksm and migration tests, 
so it's not particularly odd to require it here as well.

What we do with liburing in mm selftests is to detect presence at 
compile time and essentially make the tests behave differently based on 
availability (see check_config.sh).

-- 
Cheers

David / dhildenb


