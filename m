Return-Path: <linux-fsdevel+bounces-61948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96567B8045D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 16:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AC87A965B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E6332A56;
	Wed, 17 Sep 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5HKCiYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67E32E73E
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120773; cv=none; b=hEQHPKt7wXA2N5l2NneIBZubv4QwPa/NwybalxcZE5jEOfMkIV7cRM5W9tKuOyj4iuaCvDMknCGeZyziLNkdxPPoc1Ojupfj+QMZcstHMFy/68Ka12Ax1dWmY1C04ZYCWieSCCTRT2tSaq5AhBiHoylfKBnLTZXvFpX7K3slWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120773; c=relaxed/simple;
	bh=5epPT/yF5ySKt5yJiiDB0pyPwiJwOtudKK0nsTblkcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8HlJuhhhlqTqTYBBatvzaWeN5ZdiW4vCr+wJb+mOUgn34A/ZOlNcRyXNDmYfgaZTws7GSSuRbkfA7YquF4i7zEioCjdSPA2o/C1hJBBOpnqY/axEYAe2w0gotro/4wzLhnKrSrCHAUe2Uyyu2rR9/ZSsMVXKVVdd1r5hQvFm7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5HKCiYJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758120769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gDs3CUgjimStalCZ6Y06kSWDcmRW5MkZeDVBa3itpks=;
	b=Y5HKCiYJkMelEBHm798LQBOLQFsyQ4blYDc14lDVhJ/bHYjdvQbuCv7/jO/47JDBWlsqO/
	tEGGpzgemCnl/U0UimZ7TU43h178Eiq8aSCF2Er8+oFp51VBlUkq3KaUuSXvDq0L3o+kTU
	Mj18HYK7ipfmA0ng1MjSJLfEzVKerwM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-R-SLsSkdOVKLJcU7JDTHpQ-1; Wed, 17 Sep 2025 10:52:48 -0400
X-MC-Unique: R-SLsSkdOVKLJcU7JDTHpQ-1
X-Mimecast-MFC-AGG-ID: R-SLsSkdOVKLJcU7JDTHpQ_1758120767
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ccd58af2bbso389267f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 07:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758120767; x=1758725567;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDs3CUgjimStalCZ6Y06kSWDcmRW5MkZeDVBa3itpks=;
        b=pmEhF3pHx45BSonU7WbpwwJpB+E3gqI4/olrZ+m0/DP7t2W4BH/0n2GqQz6/BKdxxZ
         df347a8xVXQhHCbLcXtwuFFhpINS39ZfKqjpWQyh6F4YwMhuusJIEm8abozR6khJaN1z
         L5uBl0m2VYlLklEnyVFC+GlS3QSiJleRuOk9qiIXyyJpLjkbPvjo1jN0FDfaUUTOmqR7
         cHN3uGSQdjPjcFmT0KGTpOAoVbEYL4UYKXGrjPSioFdqwj0pwf90hUfALFkDnE4dXXyO
         EVmDzuCD47PmxPPpF6GwinehFBJfuOf8Qh64LsnPGLDmLjatfq8nBKkUWsu0pZ3bHuu0
         AeHA==
X-Forwarded-Encrypted: i=1; AJvYcCU85Wkrhh7yLZtQH8L12CwztM8S/+sQuhWaH9VsQau3Kbknhjv1NuETP6o/Wmuobqj2xhdlNm/MQoe5Q5Ra@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun7l7a77buUiuc/6wYsAvA1PUpjlAIboe1GLU6cNg9NUZvcEq
	rW5fKJxHkr1fUxzmGntfJNBSsh4BXTLJnjg6yg0wVyYMU18Ppt1AXdbxdzP8bX76QKfDSuLzw62
	orCGMEhm8RLFFA31ueeVZahFQzdYJjj5KBlIJn+LZbb3Q6iTmiqdWGOgoy64OEEOgKeY=
X-Gm-Gg: ASbGncuItxFfTrqKqjm3YzAJA606l5IUTw3qG5wWJr4F2Ujt00JnAnriZTcp9j6Tl9/
	ZNqBFcl4wVaD46fho5M7RoSJsJgYJJK63h9HHZRBt5lnpiFdX/U38I6ibFK3RFX6VgXyugNaYwe
	vGek+fjBbLGYhVlMO+V7XBGzVWlIIKyZo1lyfhyeS2ieZRLG7UlKJI88fFiD4lAV9iGfHeFU7eA
	sXilcTxL5IfoBDjgXRr+3ZxInKaTSTdtsMZQn3CsjAEJH07i4gcbqy6dPS41/U4tpx8oEVyNDFd
	nMyLEnu7McOfSeS5MXWVwAnDDRHQ9FBrEu04a0hD+Kz0blAn1Kqx3mnYi0hLRXiBs0mLRx6CeIm
	/oCyuEkYvgRdBgAWgDd83BQBEoGlspaXWGEaO+4lMiToQfd0cHWSJ2QzsLLbnemWR
X-Received: by 2002:a5d:584d:0:b0:3ea:d634:1493 with SMTP id ffacd0b85a97d-3ec9d70e1aemr6331366f8f.3.1758120767167;
        Wed, 17 Sep 2025 07:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCVwA2whdJvJ6k0SNSXVgRVBCXXeS7K5H+4SZxMmaPtCI7Uv2obWcxbuvE8IbcU5jjC+Gugg==
X-Received: by 2002:a5d:584d:0:b0:3ea:d634:1493 with SMTP id ffacd0b85a97d-3ec9d70e1aemr6331269f8f.3.1758120766367;
        Wed, 17 Sep 2025 07:52:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613f3c69d5sm39701795e9.24.2025.09.17.07.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 07:52:45 -0700 (PDT)
Message-ID: <e30627e5-f30f-4494-934c-58e4a427a476@redhat.com>
Date: Wed, 17 Sep 2025 16:52:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] filemap: Pass address_space mapping to
 ->free_folio()
To: Hugh Dickins <hughd@google.com>, "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "Thomson, Jack" <jackabt@amazon.co.uk>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 Elliot Berman <quic_eberman@quicinc.com>,
 "willy@infradead.org" <willy@infradead.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "alex@ghiti.fr" <alex@ghiti.fr>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "svens@linux.ibm.com" <svens@linux.ibm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "trondmy@kernel.org" <trondmy@kernel.org>, "anna@kernel.org"
 <anna@kernel.org>, "hubcap@omnibond.com" <hubcap@omnibond.com>,
 "martin@omnibond.com" <martin@omnibond.com>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@fomichev.me"
 <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jannh@google.com"
 <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
 "axelrasmussen@google.com" <axelrasmussen@google.com>,
 "yuanchu@google.com" <yuanchu@google.com>,
 "weixugc@google.com" <weixugc@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 "shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "devel@lists.orangefs.org" <devel@lists.orangefs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20250912091708.17502-1-roypat@amazon.co.uk>
 <20250912091708.17502-2-roypat@amazon.co.uk>
 <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7c2677e1-daf7-3b49-0a04-1efdf451379a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.25 08:23, Hugh Dickins wrote:
> On Fri, 12 Sep 2025, Roy, Patrick wrote:
> 
>> From: Elliot Berman <quic_eberman@quicinc.com>
>>
>> When guest_memfd removes memory from the host kernel's direct map,
>> direct map entries must be restored before the memory is freed again. To
>> do so, ->free_folio() needs to know whether a gmem folio was direct map
>> removed in the first place though. While possible to keep track of this
>> information on each individual folio (e.g. via page flags), direct map
>> removal is an all-or-nothing property of the entire guest_memfd, so it
>> is less error prone to just check the flag stored in the gmem inode's
>> private data.  However, by the time ->free_folio() is called,
>> folio->mapping might be cleared. To still allow access to the address
>> space from which the folio was just removed, pass it in as an additional
>> argument to ->free_folio, as the mapping is well-known to all callers.
>>
>> Link: https://lore.kernel.org/all/15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com/
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> [patrick: rewrite shortlog for new usecase]
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>> ---
>>   Documentation/filesystems/locking.rst |  2 +-
>>   fs/nfs/dir.c                          | 11 ++++++-----
>>   fs/orangefs/inode.c                   |  3 ++-
>>   include/linux/fs.h                    |  2 +-
>>   mm/filemap.c                          |  9 +++++----
>>   mm/secretmem.c                        |  3 ++-
>>   mm/vmscan.c                           |  4 ++--
>>   virt/kvm/guest_memfd.c                |  3 ++-
>>   8 files changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index aa287ccdac2f..74c97287ec40 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -262,7 +262,7 @@ prototypes::
>>   	sector_t (*bmap)(struct address_space *, sector_t);
>>   	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
>>   	bool (*release_folio)(struct folio *, gfp_t);
>> -	void (*free_folio)(struct folio *);
>> +	void (*free_folio)(struct address_space *, struct folio *);
>>   	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>>   	int (*migrate_folio)(struct address_space *, struct folio *dst,
>>   			struct folio *src, enum migrate_mode);
> 
> Beware, that is against the intent of free_folio().
> 
> Since its 2.6.37 origin in 6072d13c4293 ("Call the filesystem back
> whenever a page is removed from the page cache"), freepage() or
> free_folio() has intentionally NOT taken a struct address_space *mapping,
> because that structure may already be freed by the time free_folio() is
> called, if the last folio holding it has now been freed.

Thanks for noticing that Hugh, very good point!

> 
> Maybe something has changed since then, or maybe it happens to be safe
> just in the context in which you want to use it; but it is against the
> principle of free_folio().  (Maybe an rcu_read_lock() could be added
> in __remove_mapping() to make it safe nowadays? maybe not welcome.)

Let me dig into the callers:


1) filemap_free_folio()

filemap_free_folio() looks up the callback through 
mapping->a_ops->free_folio. Nothing happens in-between that lookup and 
the callback so we should be good.


2) replace_page_cache_folio()

replace_page_cache_folio() similarly looks up the callback through
mapping->a_ops->free_folio. We do some operations afterwards, but 
essentially store the new folio in the page cache and remove the old one.

The only caller is fuse_try_move_folio(), and IIUC both folios are 
locked, preventing concurrent truncation and the mapping going away.


3) __remove_mapping()

__remove_mapping() also looks up the callback through 
mapping->a_ops->free_folio.

Before we call free_folio() we remove the folio from the pagecache 
(__filemap_remove_folio) to then drop locks and call free_folio().

We're only holding the folio lock at that point.

So yes I agree, truncate_inode_pages_final() could be racing with
__remove_mapping().c That's probably exactly what the docs describe 
regarding reclaim.


rcu_read_lock() should indeed work, or some other mechanism that keeps 
truncate_inode_pages_final() from succeeding in this racy situation.

Alternatively I guess we would have to use another callback.

-- 
Cheers

David / dhildenb


