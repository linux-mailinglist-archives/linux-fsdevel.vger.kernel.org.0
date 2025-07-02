Return-Path: <linux-fsdevel+bounces-53672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93AAF5CED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7A71C25A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6E2D948A;
	Wed,  2 Jul 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn1K/m0P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04F2D9485
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469947; cv=none; b=tsdkyPYRu6XhPPbE87wS4RWz39ffCmTYHNC/uj2ow0A6AIWKoiczEPaMaO02RJiEaCGXbmWOycItaUE0nX+exOz8P3AsNnKWe5AcsIId+TJKdtIBTFRvB7IgdEkthpq3u8rC083Y+17iAXr7EshhuVIst2QLLgIRjQWM82ArDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469947; c=relaxed/simple;
	bh=ozAq4H7NKMi99W0DR+dgxSwDGggAfgQwOjbIsAOjbpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU769YsfJrBoXOYm3LeoIRQxTN2cUvBa1nqkXDZWDAmJbM2vHhZiXcnWhMEKfUcYWQw5ZqGKOVyNufgL83DyrS61rLkl7miHFL5MLBdJ1tP9MbQVqD0LDsQ4FrLLL9/XyV/apgqa+IHb5VwBpbv5NlYsp8SR4g3L8GqqIm9bGfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bn1K/m0P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751469944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1zZV1K34K5vsU5bBEYqLthbNyfG8BgJV/i5Welf7t/g=;
	b=Bn1K/m0PU2U3QSPaMiHDZ9IEss70sP4dyQo4AqGCa2DIdZPw/BydGbJ10nCodpn103KH03
	L5f6F+VWaJ2ilXVktUADQx9RXOuakOluJM7WppwrFEQnYdTwVstNENYyw+ylX4uDPjvTsx
	IhcWTw6S1PxNjCZwOVRx+RrtgmOkm4g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-FfSS5IKJOLu7Nfm5VElVPQ-1; Wed, 02 Jul 2025 11:25:43 -0400
X-MC-Unique: FfSS5IKJOLu7Nfm5VElVPQ-1
X-Mimecast-MFC-AGG-ID: FfSS5IKJOLu7Nfm5VElVPQ_1751469942
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so1850637f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 08:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751469942; x=1752074742;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1zZV1K34K5vsU5bBEYqLthbNyfG8BgJV/i5Welf7t/g=;
        b=Dpu94+Y6nEAnGAVO5VB8YJnWTCrHIOcFO/oU/DrmSAC7zYiQYLP5g64SiJaLf8PGe8
         UnUQJdkUQ8ELW4n8WbzFkH2zWmzQSySgq73tZdjP4zY7xqqOYpU5osjTvJvK7jS2zh0Y
         U8FG7bc1K7q/5U0StAaI/znzkixodv+NJ7RoWxEasdq+gKqCpMs81DSBZKOGLJ/PRDgy
         KItnwzGdlR8V62Ty7JSHbt3Fa5OvRaYfG1pTlgnIdnt6e2b7EtazDgYPzTNgi3/7sHkT
         zqk57r1J4NkDF49aO3sd2u8LqstVgRn5TJADMUigj+D+kQU+mnx4rgAQOBGFCE3pyX+Z
         fjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhTXyYJhsH+H7xvFO5CtlmMWPllPsmfFghseEk1KP/WjWCKSBAgiqjvTVufkl1PaBol/Q1w66RIV/4LLng@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wSfSHOieerT761GYYyCdFzA6zYkB0l38IcqOoVcecH4mPRJm
	2o6JdVSN16kJmK8rbPICC2nbo+ffYo/1wcxAYQXBrMxRNdWIAfsg/Y58lQ+VfWNOTtjSFmRnoCC
	GPcYJFhQLCFEu6L9uOvoiMMCIPAhMCswZ3x8RAtpb2D7ecxrSu7Y8l414eoKr0aWehvA=
X-Gm-Gg: ASbGncu5WD8u842YAIvJPuQnuagzeJB+Y2ux+apiXQKIGPUM1v8hzUC0mSRKa9feTcl
	OFiaj+kzxmOXrl3AnLbyxcoqLCdgoiiATbDqn/UbnrooaP8IYXipcm5+qDc+AD/qzltPUJa/JsR
	TYVzZ+hq2Hcoeqvcf7cyOynNlzE6zD9AaC2kkAq+Ty5NbEbewbObJ0qPq2hvXEdhYSkJ5sRBON5
	1Z7ie7S0iFm1BgC0RWg/Fx24U17EjqVFuqUziWzqeiCnxInKK9uf1ea4BHinJYLYmhvDFmBJ/Tk
	xLtfuJ89w/Pwt7QQ5LfXIbwb2Y/q/PwtqiEPBlC/L6yBycxZVVHypJ4=
X-Received: by 2002:a05:6000:40cc:b0:3a5:2f23:3780 with SMTP id ffacd0b85a97d-3b1ffcd6a02mr2834588f8f.18.1751469942203;
        Wed, 02 Jul 2025 08:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsUNCCRvW2G8ERz1v+CzxV36sRx/sOGiOA5hGIRC55Fq8/UJikBoj+bsw3If92RbCTbdxtOA==
X-Received: by 2002:a05:6000:40cc:b0:3a5:2f23:3780 with SMTP id ffacd0b85a97d-3b1ffcd6a02mr2834527f8f.18.1751469941626;
        Wed, 02 Jul 2025 08:25:41 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e52ad2sm16118859f8f.48.2025.07.02.08.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 08:25:41 -0700 (PDT)
Message-ID: <e76b6a9d-b887-4790-a2fd-032648be99ff@redhat.com>
Date: Wed, 2 Jul 2025 17:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to a
 page flag
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-21-david@redhat.com> <aGUd34v-4S7eXojo@hyeyoo>
 <a533ae7e-f993-4673-bb00-ec9d10c11c83@redhat.com> <aGUtxakO8p_94rTl@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGUtxakO8p_94rTl@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 15:01, Harry Yoo wrote:
> On Wed, Jul 02, 2025 at 02:01:33PM +0200, David Hildenbrand wrote:
>> On 02.07.25 13:54, Harry Yoo wrote:
>>> On Mon, Jun 30, 2025 at 03:00:01PM +0200, David Hildenbrand wrote:
>>>> Instead, let's use a page flag. As the page flag can result in
>>>> false-positives, glue it to the page types for which we
>>>> support/implement movable_ops page migration.
>>>>
>>>> The flag reused by PageMovableOps() might be sued by other pages, so
>>>> warning in case it is set in page_has_movable_ops() might result in
>>>> false-positive warnings.
>>>>
>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>
>>> LGTM,
>>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>>>
>>> With a question: is there any reason to change the page flag
>>> operations to use atomic bit ops?
>>
>> As we have the page lock in there, it's complicated. I thought about this
>> when writing that code, and was not able to convince myself that it is safe.
>>
>> But that was when I was prototyping and reshuffling patches, and we would
>> still have code that would clear the flag.
>   
>> Given that we only allow setting the flag, it might be okay to use the
>> non-atomic variant as long as there can be nobody racing with us when
>> modifying flags. Especially trying to lock the folio concurrently is the big
>> problem.
>>
>> In isolate_movable_ops_page(), there is a comment about checking the flag
>> before grabbing the page lock, so that should be handled.
> 
> Right.
> 
>> I'll have to check some other cases in balloon/zsmalloc code.
> 
> Okay, it's totally fine to go with atomic version and then
> switching back to non atomic ops when we're sure it's safe.
> 

I'll definitely do the following:

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8b23a74963feb..5f2b570735852 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1145,9 +1145,11 @@ PAGEFLAG(Isolated, isolated, PF_ANY);
   * the flag might be used in other context for other pages. Always use
   * page_has_movable_ops() instead.
   */
-PAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+TESTPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
+SETPAGEFLAG(MovableOps, movable_ops, PF_NO_TAIL);
  #else /* !CONFIG_MIGRATION */
-PAGEFLAG_FALSE(MovableOps, movable_ops);
+TESTPAGEFLAG_FALSE(MovableOps, movable_ops);
+SETPAGEFLAG_NOOP(MovableOps, movable_ops);
  #endif /* CONFIG_MIGRATION */
  
  /**

Because the flag must not get cleared.

There is no __SETPAGEFLAG_NOOP yet, unfortunately.
-- 
Cheers,

David / dhildenb


