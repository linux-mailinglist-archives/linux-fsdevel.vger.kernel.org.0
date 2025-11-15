Return-Path: <linux-fsdevel+bounces-68557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CEC5FEC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 03:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E0FE344830
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955B218845;
	Sat, 15 Nov 2025 02:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH0xZgcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEA35CBD3
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174526; cv=none; b=Yu/6TrpqVP1cS6cNqmDFBMDZxfw28utvWjUObciM5e9AVYryj7s0kzUJ+3FoYQx548A1lsKjVSsSaQepnZ4KyeEULzH/nmFctvabYPkelgUVS3aekgDMcRu/KEXbKawVfOL/DtNn/jY0ETdYaifes3No8+cCZIwKxsH1bYkyMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174526; c=relaxed/simple;
	bh=vp3/dk8WdSgohrbicic2X5weNAoy8sIAcUqWxAf6JJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Azovz596YKFqYnTJAbBkcwGgm4y4fEO2y1dCnBloi2lK7Tk7ZAo253tsy7PS81+47Ll5JYPgsGfM2URHHeZa+1lCWHog3F2XpkRot2kh4c9ECPBrKi/M7JkpYevX5OGNeYtVxv/9gzxLpILWc0v1gh69ra+iBbh9hIRaZM1nqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH0xZgcX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so4695158a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 18:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174523; x=1763779323; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qPMKhOUZaVUnn2C31CanvV6ROA+8+FTIUKMzyBfKTUQ=;
        b=KH0xZgcXda7GFBloAzBEqXtjTzf75GBzNzGHsXLdjzidu+EyVcTl+S8c1k0R3KE0/H
         Fj6WhTLjX6ikZ1JxVjoXTXXhmkTTrNl5VhPACrdc8xR9UXkkkTYX7lWpV3gSOZfDcvUs
         ujwE0iTe0b6rrPHcnyhiZoC2uBHDFOZaqBFuPGUHs2hgtguv6Lry4DwWGwqMENVcqKad
         jCN3oTHq4N/ShbpnCpwbhxplQ08zwPIP0MuP9p+JfT+iZRduA/+Ed0sWO2vRyUmUWd+u
         Z+Ii/CXkGAMqkTZbr8d/5S7wGU0wcCWSSQO8rdl1GNIPZWEIt3sezHLF2hAEHjIWH5f/
         p9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174523; x=1763779323;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPMKhOUZaVUnn2C31CanvV6ROA+8+FTIUKMzyBfKTUQ=;
        b=DXJsObX0T9s+lYhWCbMbUisTBEZbxKy9mzDYJvVt4FjzGhiXAidRXinmvPEaLg5WZF
         uGqW+Y4ba3a/1YAX6nt5AHURkb+X27UQKmAgJezDcqk2wvs2THyKFSiv7DCPRkmgqWIV
         bJykndUZZMCZI7+04NeDxUgnCBPzFz+cHd8L0FOaYwjlRgxKyvTuUOZ3mPhVBLCnl1uK
         kjeTFnkqwdXsgeE2nbYIK1Z/p9D+QiRZQCBMgzEE4g7NOEKb4YDzt+DIky5uc4KSIGF/
         TTHeszf+bSyVh+er0LSaHKxfZUYx7I8Ww7B8uVfuO0v4p34hn/wDheOhlMekjmL2WKav
         B/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ649WdbSReL04G8XJ51zX3Slo750Z/R5rxZq+bZNKLUgbE/n2jspQxQNt4aO3M2REjJ3YKyg0m9rpxhMX@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI2Fc0yZ1zZE9KINGKo9tLqO/pt2kp+6BFcb4ysgrXkyc5EtS
	p2JQ76Bh1A6IO5DdcvlA890TPmQhb5HtuAgXYTQVKtpAqkdKHu9Wk7vDKtpDVA==
X-Gm-Gg: ASbGncsAYuUTE/4V+bLR2NJPKxo2kP37TE043/v5old2WB+lhW+ENC159NIjrW3Arcn
	6kXFzvwzFJqsHmxXZJKFxAWgDNPkc/VTuJM624kk8nEQ5dDX2LXd//lTLbBx5mYghe5NKU4SrrU
	tjWh0wpEcTk/MI9B9bXgKqncjzzEuPcr5TN8rf28eG4tabTJYIEQixtf6ktdQjDT+yUOHwJg5dQ
	W4MRAgEHSXqrMBmgW3h64a93Au41R4E0Mjf3MLSdAUvR/fI3QBDGySWUXZaPoU7XVtEW3oONIs5
	JsW3d7cIQTH2RgENJUahDhe6jBq1UTqTT6wDhSeMsSgg9YBdYvuU7t+lu5yqsas6beZeoi9b6Lk
	Fp29JtTLAb/u5BiJEu9Wt8Asy/zbtL4oY0TxDWUy6x0up7h8dD1yyTYCfBygRfZqjOjW1YptFro
	vS2/V9i+6PK03ryQ==
X-Google-Smtp-Source: AGHT+IG0lwtyDR6cW/rRWitLb88FryxT0kFjAGRvlTdFqe0ZdPrZDl1uF/dPMJk2wneDffuOKwEbcA==
X-Received: by 2002:a17:907:d0d:b0:b73:43ee:a262 with SMTP id a640c23a62f3a-b736794c425mr586316766b.51.1763174522437;
        Fri, 14 Nov 2025 18:42:02 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa811e2sm516858666b.5.2025.11.14.18.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Nov 2025 18:42:01 -0800 (PST)
Date: Sat, 15 Nov 2025 02:42:01 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	willy@infradead.org, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251115024201.jb5qaenbmlmdfx2y@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <01FABE3A-AD4E-4A09-B971-C89503A848DF@nvidia.com>
 <20251114143015.k46icn247a4azp7s@master>
 <AE04E232-34A2-47A2-B202-3F1E32AFAC0C@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AE04E232-34A2-47A2-B202-3F1E32AFAC0C@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 14, 2025 at 03:53:42PM -0500, Zi Yan wrote:
>On 14 Nov 2025, at 9:30, Wei Yang wrote:
>
>> On Fri, Nov 14, 2025 at 07:43:38AM -0500, Zi Yan wrote:
>>> On 14 Nov 2025, at 3:49, David Hildenbrand (Red Hat) wrote:
>>>
>> [...]
>>>>> +
>>>>> +	if (new_order >= old_order)
>>>>> +		return -EINVAL;
>>>>> +
>>>>>   	if (folio_test_anon(folio)) {
>>>>>   		/* order-1 is not supported for anonymous THP. */
>>>>>   		VM_WARN_ONCE(warns && new_order == 1,
>>>>>   				"Cannot split to order-1 folio");
>>>>>   		if (new_order == 1)
>>>>>   			return false;
>>>>> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>>>>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>>> -		    !mapping_large_folio_support(folio->mapping)) {
>>>>> -			/*
>>>>> -			 * We can always split a folio down to a single page
>>>>> -			 * (new_order == 0) uniformly.
>>>>> -			 *
>>>>> -			 * For any other scenario
>>>>> -			 *   a) uniform split targeting a large folio
>>>>> -			 *      (new_order > 0)
>>>>> -			 *   b) any non-uniform split
>>>>> -			 * we must confirm that the file system supports large
>>>>> -			 * folios.
>>>>> -			 *
>>>>> -			 * Note that we might still have THPs in such
>>>>> -			 * mappings, which is created from khugepaged when
>>>>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>>>>> -			 * case, the mapping does not actually support large
>>>>> -			 * folios properly.
>>>>> -			 */
>>>>> +	} else {
>>>>> +		const struct address_space *mapping = NULL;
>>>>> +
>>>>> +		mapping = folio->mapping;
>>>>
>>>> const struct address_space *mapping = folio->mapping;
>>>>
>>>>> +
>>>>> +		/* Truncated ? */
>>>>> +		/*
>>>>> +		 * TODO: add support for large shmem folio in swap cache.
>>>>> +		 * When shmem is in swap cache, mapping is NULL and
>>>>> +		 * folio_test_swapcache() is true.
>>>>> +		 */
>>>>> +		if (!mapping)
>>>>> +			return false;
>>>>> +
>>>>> +		/*
>>>>> +		 * We have two types of split:
>>>>> +		 *
>>>>> +		 *   a) uniform split: split folio directly to new_order.
>>>>> +		 *   b) non-uniform split: create after-split folios with
>>>>> +		 *      orders from (old_order - 1) to new_order.
>>>>> +		 *
>>>>> +		 * For file system, we encodes it supported folio order in
>>>>> +		 * mapping->flags, which could be checked by
>>>>> +		 * mapping_folio_order_supported().
>>>>> +		 *
>>>>> +		 * With these knowledge, we can know whether folio support
>>>>> +		 * split to new_order by:
>>>>> +		 *
>>>>> +		 *   1. check new_order is supported first
>>>>> +		 *   2. check (old_order - 1) is supported if
>>>>> +		 *      SPLIT_TYPE_NON_UNIFORM
>>>>> +		 */
>>>>> +		if (!mapping_folio_order_supported(mapping, new_order)) {
>>>>> +			VM_WARN_ONCE(warns,
>>>>> +				"Cannot split file folio to unsupported order: %d", new_order);
>>>>
>>>> Is that really worth a VM_WARN_ONCE? We didn't have that previously IIUC, we would only return
>>>> -EINVAL.
>>>
>>
>> Sorry for introducing this unpleasant affair.
>>
>> Hope I can explain what I have done.
>>
>>> No, and it causes undesired warning when LBS folio is enabled. I explicitly
>>> removed this warning one month ago in the LBS related patch[1].
>>>
>>
>> Yes, I see you removal of a warning in [1].
>>
>> While in the discussion in [2], you mentioned:
>>
>>   Then, you might want to add a helper function mapping_folio_order_supported()
>>   instead and change the warning message below to "Cannot split file folio to
>>   unsupported order [%d, %d]", min_order, max_order (showing min/max order
>>   is optional since it kinda defeat the purpose of having the helper function).
>>   Of course, the comment needs to be changed.
>>
>> I thought you agree to print a warning message here. So I am confused.
>
>This is exactly my point. You need to know what you are doing. You should not
>write a patch because of what I said. And my above comment is to
>CONFIG_READ_ONLY_THP_FOR_FS part of code. It has nothing
>to do with the check pulled into folio_split_supported().
>

Yes, I thought they serve the same purpose(checking supported folio order), so
print the warning both.

If should not, I will remove it.

>>
>>> It is so frustrating to see this part of patch. Wei has RB in the aforementioned
>>> patch and still add this warning blindly. I am not sure if Wei understands
>>> what he is doing, since he threw the idea to me and I told him to just
>>> move the code without changing the logic, but he insisted doing it in his
>>> own way and failed[2]. This retry is still wrong.
>>>
>>
>> I think we are still discussing the problem and a patch maybe more convenient
>> to proceed. I didn't insist anything and actually I am looking forward your
>> option and always respect your insight. Never thought to offend you.
>
>Not offended.
>>
>> In discussion [2], you pointed out two concerns:
>>
>>   1) new_order < min_order is meaning less if min_order is 0
>>   2) how to do the check if new_order is 0 for non-uniform split
>>
>> For 1), you suggested to add mapping_folio_order_supported().
>> For 2), I come up an idea to check (old_order - 1) <= max_order. Originally,
>> we just check !max_order. I think this could cover it.
>>
>> So I gather them together here to see whether it is suitable.
>>
>> If I missed some part, hope you could let me know.
>
>Based on the discussion in [2], your patch mixes the checks for FS does not
>support large folio and FS supporting large folio has min_order requirement
>and I told you that it does not work well and suggested you to just move
>“if (new_order < min_order) {“ part into folio_split_supported() as an
>easy approach. Why not do that?
>

I may not follow you. Let me try to clear my mind.

My first approach is :

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dee416b3f6ed..ef05f246df73 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3704,8 +3704,8 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
 		if (new_order == 1)
 			return false;
 	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
+		unsigned int min_order = mapping_min_folio_order(folio->mapping);
+		if (new_order < min_order) {
 			/*
 			 * We can always split a folio down to a single page
 			 * (new_order == 0) uniformly.


Current patch does 3 major changes.

1)

Your comment to above change:

```
   This check is good for !CONFIG_READ_ONLY_THP_FOR_FS, but for
   CONFIG_READ_ONLY_THP_FOR_FS and !mapping_large_folio_support(), min_order is
   always 0.

   ...
   
   OK, basically the check should be:
   
     if (new_order < mapping_min_folio_order() || new_order > mapping_max_folio_order()).
   
   Then, you might want to add a helper function mapping_folio_order_supported().
```

So in this patch, I introduce mapping_folio_order_supported() and replace the
(new_order < min_order) check. Still use (new_order < min_order) looks not
correct. Or I misunderstand your suggestion?

2)

And then you mentioned this check is not enough:

```
    Hmm, but still how could the above check to trigger the warning when
    split_type == SPLIT_TYPE_NON_UNIFORM and new_order is 0? It will not
    trigger, since new_order (as 0) is supported by the mapping.
```

What come up my mind is to check with old_orer - 1 is also supported. So for
SPLIT_TYPE_NON_UNIFORM, the after-split folio range [min_order, old_order - 1]
are all checked.

3)

Also I remove the first "if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order)".

Because in original logic, when split_type == SPLIT_TYPE_UNIFORM && new_order
== 0, we should still check (new_order < min_order). If not we would miss
that.

But sounds I misunderstand you insight, I am sorry for that. If not too
bother, would you mind sharing it again?

>>
>>> Wei, please make sure you understand the code before sending any patch.
>>>
>>> [1] https://lore.kernel.org/linux-mm/20251017013630.139907-1-ziy@nvidia.com/
>>> [2] https://lore.kernel.org/linux-mm/20251114030301.hkestzrk534ik7q4@master/
>>>
>>> Best Regards,
>>> Yan, Zi
>>
>> -- 
>> Wei Yang
>> Help you, Help me
>
>
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

