Return-Path: <linux-fsdevel+bounces-35073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CD9D0BEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A483B24659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD071925A2;
	Mon, 18 Nov 2024 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCsI67N+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8F18C33B
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922717; cv=none; b=CjSpzDASk7dHv/86XDQXfYBvOntV0geC1aCLF6PPx9Bk2+vPB+eDyGUmd8TiuvR1Mv5OQBOvQs8QKCchjC89eYZQ4n7814tXgDpInylicCA9keWMmIgRCXgrGQ1T/GTtpTlSQukDWmEKJvsLvXERoto+/THdmOjdmK6hoIWxlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922717; c=relaxed/simple;
	bh=RCNvydKraMeZR7MoDtc89kltmwQsGZj67/ZYMQ/bOJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBJ+YtqbIvW6fKF8lB5auqGP51RF2xVC2yVOGbzZiyq5OAUNBDX9u8vOYUkkqtPLRDcIspN+qU91OQVxvSNJNW3iYXbuC09y5lQ6JlBNUllVD29MB30JryrmaK3rWIJ4iwqFcWcALDal56sGSPIKT/EU95FrqVEVj+f+4+Q+8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCsI67N+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731922714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+NTRjdfPcUO1aXo5xK1hvXQ8mkL4rX7RTb4WBxeB6gE=;
	b=UCsI67N+eRm5e0rgmbrGmfxMmZ8bzD773l/E7Ktq0WWUKgNmQlD2++j/aMXZjZKmgDzLms
	ULTLmXJG5LsFzl+vF8wmvArA4U5SFb42RBwHg81olEwgShT/cyexJaAekcc9Eu8xIaNu4m
	/pfF7OfnhMunmr+gEbK1koQNDHpEKPA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-Rcvc5UnXNA6rpx10H5k-Cw-1; Mon, 18 Nov 2024 04:38:32 -0500
X-MC-Unique: Rcvc5UnXNA6rpx10H5k-Cw-1
X-Mimecast-MFC-AGG-ID: Rcvc5UnXNA6rpx10H5k-Cw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so31935385e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 01:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922711; x=1732527511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NTRjdfPcUO1aXo5xK1hvXQ8mkL4rX7RTb4WBxeB6gE=;
        b=ZQ1GSmrPZ0ZpySACNjdwl2QbDkvIN3GgrlWVZDpBFTA1uss97VC50iwQ4ZBxtBu4//
         ix3LEupxqPdsm3ttLMtYeK5iW1zjwWM4iLQucs6bw5zWi61pN9a1TEiB0DXXKrw/UbSs
         V2NFSoNyZQ0ynDGTNWECOMi24pewp85BpEcG/6wGwkpTyUK0CPYpxPA0yoWLttIK/Ajr
         YcDSRNZwNkIQX01wGgHRIspfvnhPIVkZ6QCpMHai0KSkOd/menxnrG2T3eyGgiS2JbI5
         c5FkBdUSd6KKl5k3kfMb6CUV+m1q9VYXRCWgW+p63uPjN+xLtKEMpMdvIhdAeLrVJgaj
         bvNw==
X-Forwarded-Encrypted: i=1; AJvYcCVOLbVaI3tieRxgGHk0/58ccNnRAOaxGDopHP+9VPLNGKffp1U3oNJpDssEaL3qZmAo6PKP1DkyT93VcBil@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhtjq3k3Cbq928tl5F5lVNX/QxQIuvePkbNWQ9XVHeCUsmqHu
	g6ALHAY8BHVOIpWYToCexAFD9Oyov6BN/84dLkHX0uTgbdrXpGt/pGzHUWKZPcA54Fq3pX0547b
	HaBvgeHScbOh/QxVZZhwsHva/DvdHiVTcFWj6xWabc2P4YDzGMgF9UYqq9dMs/No=
X-Received: by 2002:a05:600c:4595:b0:431:b42a:2978 with SMTP id 5b1f17b1804b1-432df7411f8mr96600485e9.9.1731922711662;
        Mon, 18 Nov 2024 01:38:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNdX08kgrhCDdSpGLAntBtOpOc15TdOtLfjCc8MQDp2SzDpZ/XtyXBKhpLLWnL6Ein1okH4A==
X-Received: by 2002:a05:600c:4595:b0:431:b42a:2978 with SMTP id 5b1f17b1804b1-432df7411f8mr96600255e9.9.1731922711303;
        Mon, 18 Nov 2024 01:38:31 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2800absm151820395e9.25.2024.11.18.01.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 01:38:30 -0800 (PST)
Message-ID: <15f665b4-2d33-41ca-ac50-fafe24ade32f@redhat.com>
Date: Mon, 18 Nov 2024 10:38:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/2] KVM: guest_memfd: Convert .free_folio() to
 .release_folio()
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>, Mike Rapoport <rppt@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Matthew Wilcox <willy@infradead.org>,
 James Gowans <jgowans@amazon.com>, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
 <20241113-guestmem-library-v3-1-71fdee85676b@quicinc.com>
 <c650066d-18c8-4711-ae22-3c6c660c713e@redhat.com>
 <d2147b7c-bb2e-4434-aa10-40cacac43d4f@redhat.com>
 <20241115121119110-0800.eberman@hu-eberman-lv.qualcomm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241115121119110-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 21:13, Elliot Berman wrote:
> On Fri, Nov 15, 2024 at 11:58:59AM +0100, David Hildenbrand wrote:
>> On 15.11.24 11:58, David Hildenbrand wrote:
>>> On 13.11.24 23:34, Elliot Berman wrote:
>>>> When guest_memfd becomes a library, a callback will need to be made to
>>>> the owner (KVM SEV) to transition pages back to hypervisor-owned/shared
>>>> state. This is currently being done as part of .free_folio() address
>>>> space op, but this callback shouldn't assume that the mapping still
>>>> exists. guest_memfd library will need the mapping to still exist to look
>>>> up its operations table.
>>>
>>> I assume you mean, that the mapping is no longer set for the folio (it
>>> sure still exists, because we are getting a callback from it :) )?
>>>
>>> Staring at filemap_remove_folio(), this is exactly what happens:
>>>
>>> We remember folio->mapping, call __filemap_remove_folio(), and then call
>>> filemap_free_folio() where we zap folio->mapping via page_cache_delete().
>>>
>>> Maybe it's easier+cleaner to also forward the mapping to the
>>> free_folio() callback, just like we do with filemap_free_folio()? Would
>>> that help?
>>>
>>> CCing Willy if that would be reasonable extension of the free_folio
>>> callback.
>>>
> 
> I like this approach too. It would avoid the checks we have to do in the
> invalidate_folio() callback and is cleaner.

It really should be fairly simple


  Documentation/filesystems/locking.rst | 2 +-
  fs/nfs/dir.c                          | 9 +++++----
  fs/orangefs/inode.c                   | 3 ++-
  include/linux/fs.h                    | 2 +-
  mm/filemap.c                          | 2 +-
  mm/secretmem.c                        | 3 ++-
  virt/kvm/guest_memfd.c                | 3 ++-
  7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index f5e3676db954b..f1a20ad5edbee 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -258,7 +258,7 @@ prototypes::
  	sector_t (*bmap)(struct address_space *, sector_t);
  	void (*invalidate_folio) (struct folio *, size_t start, size_t len);
  	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *);
+	void (*free_folio)(struct address_space *, struct folio *);
  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
  	int (*migrate_folio)(struct address_space *, struct folio *dst,
  			struct folio *src, enum migrate_mode);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d84..f7da6d7496b06 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -218,7 +218,8 @@ static void nfs_readdir_folio_init_array(struct folio *folio, u64 last_cookie,
  /*
   * we are freeing strings created by nfs_add_to_readdir_array()
   */
-static void nfs_readdir_clear_array(struct folio *folio)
+static void nfs_readdir_clear_array(struct address_space *mapping,
+		struct folio *folio)
  {
  	struct nfs_cache_array *array;
  	unsigned int i;
@@ -233,7 +234,7 @@ static void nfs_readdir_clear_array(struct folio *folio)
  static void nfs_readdir_folio_reinit_array(struct folio *folio, u64 last_cookie,
  					   u64 change_attr)
  {
-	nfs_readdir_clear_array(folio);
+	nfs_readdir_clear_array(folio->mapping, folio);
  	nfs_readdir_folio_init_array(folio, last_cookie, change_attr);
  }
  
@@ -249,7 +250,7 @@ nfs_readdir_folio_array_alloc(u64 last_cookie, gfp_t gfp_flags)
  static void nfs_readdir_folio_array_free(struct folio *folio)
  {
  	if (folio) {
-		nfs_readdir_clear_array(folio);
+		nfs_readdir_clear_array(folio->mapping, folio);
  		folio_put(folio);
  	}
  }
@@ -391,7 +392,7 @@ static void nfs_readdir_folio_init_and_validate(struct folio *folio, u64 cookie,
  	if (folio_test_uptodate(folio)) {
  		if (nfs_readdir_folio_validate(folio, cookie, change_attr))
  			return;
-		nfs_readdir_clear_array(folio);
+		nfs_readdir_clear_array(folio->mapping, folio);
  	}
  	nfs_readdir_folio_init_array(folio, cookie, change_attr);
  	folio_mark_uptodate(folio);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aae6d2b8767df..d936694b8e91f 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -470,7 +470,8 @@ static bool orangefs_release_folio(struct folio *folio, gfp_t foo)
  	return !folio_test_private(folio);
  }
  
-static void orangefs_free_folio(struct folio *folio)
+static void orangefs_free_folio(struct address_space *mapping,
+		struct folio *folio)
  {
  	kfree(folio_detach_private(folio));
  }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c15..4dd4013541c1b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -417,7 +417,7 @@ struct address_space_operations {
  	sector_t (*bmap)(struct address_space *, sector_t);
  	void (*invalidate_folio) (struct folio *, size_t offset, size_t len);
  	bool (*release_folio)(struct folio *, gfp_t);
-	void (*free_folio)(struct folio *folio);
+	void (*free_folio)(struct address_space *, struct folio *folio);
  	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
  	/*
  	 * migrate the contents of a folio to the specified target. If
diff --git a/mm/filemap.c b/mm/filemap.c
index e582a1545d2ae..86f975ba80746 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -239,7 +239,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
  
  	free_folio = mapping->a_ops->free_folio;
  	if (free_folio)
-		free_folio(folio);
+		free_folio(mapping, folio);
  
  	if (folio_test_large(folio))
  		refs = folio_nr_pages(folio);
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 399552814fd0f..1d2ed3391734d 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -152,7 +152,8 @@ static int secretmem_migrate_folio(struct address_space *mapping,
  	return -EBUSY;
  }
  
-static void secretmem_free_folio(struct folio *folio)
+static void secretmem_free_folio(struct address_space *mapping,
+		struct folio *folio)
  {
  	set_direct_map_default_noflush(&folio->page);
  	folio_zero_segment(folio, 0, folio_size(folio));
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8f079a61a56db..573946c4fff51 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -353,7 +353,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
  }
  
  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_free_folio(struct folio *folio)
+static void kvm_gmem_free_folio(struct address_space *mapping,
+		struct folio *folio)
  {
  	struct page *page = folio_page(folio, 0);
  	kvm_pfn_t pfn = page_to_pfn(page);
-- 
2.47.0


-- 
Cheers,

David / dhildenb


