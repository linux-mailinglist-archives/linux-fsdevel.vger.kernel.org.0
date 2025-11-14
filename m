Return-Path: <linux-fsdevel+bounces-68523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4AC5DDDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 235B74FF688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6733358D0;
	Fri, 14 Nov 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M47A5hnB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF1328260
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132595; cv=none; b=ZCTCoGUW+zqBVSmHLlBTecNb5MIobnF0EtE9qwIzoKfzIv9w+P3oFIlXAyhP2ryR39Mq53IScTKBw+G0piDd2FWO4W0k9NwOvTR45C9/yqOhUodjTnuPFRFewoVp2gUeDP/lh8LeC2u3j1zfpyDgTU31bdynFQ+YcVLzUmDySLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132595; c=relaxed/simple;
	bh=WTL8RpRreoAdIZFnJfMU7kbqcRqRoBl6+KfDIAq64Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSUkCRivMzURtyApU42PCyI10wv9hCRV+bb2N0DeLc1DdoxGUxxUC47UYgNsC605DHvK9LX05Zpn1I1firzl1btS131JR3205+DtUlDiEzpCH2oSY+uQrRlKhxNcymXzxfYMVzwSMMsPjP1ubVl+O6NPlZhw3t9/LY/Q6KbOkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M47A5hnB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735ce67d1dso217278166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763132592; x=1763737392; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOYDk4ou20EqC7hKmauaNNsT/2lLPOblXJ8i+jliwUk=;
        b=M47A5hnBnKIYSMBXnKtc1gInY67EjuzXp6DALKv39TEywhBeus+cQ44zl+HD73bIEs
         9HwRXVm3KTRbawWfpD/U6MJjxlF/Pl70DGZF1XVVvZwcReSSqPOjFkxzJISrTXmVanGw
         jm0r23dtgj0Dx++MK66cgyGh/hfm3RvBx2kno9+mBb747wtZ+nyeKCy/1uJBAVRTWjX+
         7+Hge9KxZKxdg/9bjsikh5FmCxW1Mj4yItnUlMPqf96IV4DXtWhaW6Np1qVZMzXUkQYF
         Qws8znf4oy18WdZzwI9s/HWwHgl3Z4/xiIbarsIQIascg0A61TUhPlxgAHaPbn4ajsF0
         ZLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132592; x=1763737392;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYDk4ou20EqC7hKmauaNNsT/2lLPOblXJ8i+jliwUk=;
        b=G6Z/OS+u/kVnwKCeYuFiUXXz19lVX8TqtyvjWznviXxVJQ7EZWkX28/9qfc1tgGC+G
         He61c/KRxWhKsIv3wicPvhZR0sywI6x++Vt37PeGx/Vd4v9fRwwjsz8wNyQme3TGWbTZ
         JPasvHo/2pi/lZGQl4KmGQnekeWtjsRSD+LXqMx0zFwFJe+DrUuAPkPk/nK4rmsAi1fM
         svMA2kQFtALGXujM06DUgBx34ZydioVWqq7BZAqfp9Y18YVyxqSJcQ8OLCLCYwccBci6
         H1NfT9dZrwfiuEBvcQ56of1ksPw/dX8G73Egz963CWv5QJSQmnKikTzGKpNe8j2X2uVc
         rkqA==
X-Forwarded-Encrypted: i=1; AJvYcCWpJz3Z2SFOekO04M7OtMq9Bg/mBU/eOyL23+dJOSgCB7i4VG76n5MBOjZyaCXKDAQ50UszMBvKNwT/M3xu@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjFuQtMW1Gig0bJWaZZWjJ36lcBruxbUQSlPTpBq8KRkPqWva
	OiS6Ycl8nkBTUi9zI68G/7QjGuSYAOFFuvFWUYyDNuTRGGcpH/o7fMM/
X-Gm-Gg: ASbGncur06qwODVlBlz3EfZo5v/wt7fbxF9RbFtJ+6HZXQEDF/A4oUiB23QeSmoVaB6
	b+3RtYE7xRQVI8dvtyAiEYFjgVsTEUP8GT7e5uRridp/063kFIo/vLOADAEZao14F1xjLu7g5N8
	9PXuhIR8cNCkBMDfy7epujahK5tb1i+7qNNDmytwzPehDGB+Z5Pa7fNkOnaFLcB/fkmq2z5teZO
	ih9K7WvIz8xJGN6xbHrawkNvHcz2MJlMUZ2A6FzKgJCa/Q7UmTHuGA9IYGiHPcevTqJBllquui8
	0WhYa5C/I3aZhih3nUrcBqZx675Ln+JXu2gARihkNqYv4kO3PoqCiNZB34Gr30zgXQM581eO+9p
	y4uAwpLodkA+L9ILMY9Kkxba1/lBE3gM2eSGDMeb6voEtCk7VR3DMYT3YmVEx5HBrJnJD7AbSHR
	D3khxa1aHX9Q==
X-Google-Smtp-Source: AGHT+IGH0s9XHBLuAtaFLcMQ3m3V7Wq+tDkgRfw7zp8iVQdntkDjq9dsYOuRcRi5vUPJBoTSJooU+g==
X-Received: by 2002:a17:907:9622:b0:b73:7280:7821 with SMTP id a640c23a62f3a-b7372807e5emr181589666b.60.1763132591939;
        Fri, 14 Nov 2025 07:03:11 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad4635sm405154766b.26.2025.11.14.07.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Nov 2025 07:03:11 -0800 (PST)
Date: Fri, 14 Nov 2025 15:03:10 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, willy@infradead.org,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <20251114150310.eua55tcgxl4mgdnp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 14, 2025 at 09:49:34AM +0100, David Hildenbrand (Red Hat) wrote:
>On 14.11.25 08:57, Wei Yang wrote:
>> The primary goal of the folio_split_supported() function is to validate
>> whether a folio is suitable for splitting and to bail out early if it is
>> not.
>> 
>> Currently, some order-related checks are scattered throughout the
>> calling code rather than being centralized in folio_split_supported().
>> 
>> This commit moves all remaining order-related validation logic into
>> folio_split_supported(). This consolidation ensures that the function
>> serves its intended purpose as a single point of failure and improves
>> the clarity and maintainability of the surrounding code.
>
>Combining the EINVAL handling sounds reasonable.
>

You mean:

This commit combines the EINVAL handling logic into folio_split_supported().
This consolidation ... ?

>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>   include/linux/pagemap.h |  6 +++
>>   mm/huge_memory.c        | 88 +++++++++++++++++++++--------------------
>>   2 files changed, 51 insertions(+), 43 deletions(-)
>> 
>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
>> index 09b581c1d878..d8c8df629b90 100644
>> --- a/include/linux/pagemap.h
>> +++ b/include/linux/pagemap.h
>> @@ -516,6 +516,12 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
>>   	return mapping_max_folio_order(mapping) > 0;
>>   }
>> +static inline bool
>> +mapping_folio_order_supported(const struct address_space *mapping, unsigned int order)
>> +{
>> +	return (order >= mapping_min_folio_order(mapping) && order <= mapping_max_folio_order(mapping));
>> +}
>
>(unnecessary () and unnecessary long line)
>
>Style in the file seems to want:
>
>static inline bool mapping_folio_order_supported(const struct address_space *mapping,
>						 unsigned int order)
>{
>	return order >= mapping_min_folio_order(mapping) &&
>	       order <= mapping_max_folio_order(mapping);
>}
>

Adjusted.

>
>The mapping_max_folio_order() check is new now. What is the default value of that? Is it always initialized properly?
>

Not sure "is new now" means what?

Original check use mapping_large_folio_support() which calls
mapping_max_folio_order(). It looks not new to me.

If my understanding is correct, struct address_mapping is part of struct
inode, which is initialized by inode_init_once() which clears flags. So the
default value is 0.

>> +
>>   /* Return the maximum folio size for this pagecache mapping, in bytes. */
>>   static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>>   {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0184cd915f44..68faac843527 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3690,34 +3690,58 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>>   bool folio_split_supported(struct folio *folio, unsigned int new_order,
>>   		enum split_type split_type, bool warns)
>>   {
>> +	const int old_order = folio_order(folio);
>
>While at it, make it "unsigned int" like new_order.
>

Adjusted.

>> +
>> +	if (new_order >= old_order)
>> +		return -EINVAL;
>> +
>>   	if (folio_test_anon(folio)) {
>>   		/* order-1 is not supported for anonymous THP. */
>>   		VM_WARN_ONCE(warns && new_order == 1,
>>   				"Cannot split to order-1 folio");
>>   		if (new_order == 1)
>>   			return false;
>> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
>> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>> -		    !mapping_large_folio_support(folio->mapping)) {
>> -			/*
>> -			 * We can always split a folio down to a single page
>> -			 * (new_order == 0) uniformly.
>> -			 *
>> -			 * For any other scenario
>> -			 *   a) uniform split targeting a large folio
>> -			 *      (new_order > 0)
>> -			 *   b) any non-uniform split
>> -			 * we must confirm that the file system supports large
>> -			 * folios.
>> -			 *
>> -			 * Note that we might still have THPs in such
>> -			 * mappings, which is created from khugepaged when
>> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>> -			 * case, the mapping does not actually support large
>> -			 * folios properly.
>> -			 */
>> +	} else {
>> +		const struct address_space *mapping = NULL;
>> +
>> +		mapping = folio->mapping;
>
>const struct address_space *mapping = folio->mapping;
>

Adjusted.

>> +
>> +		/* Truncated ? */
>> +		/*
>> +		 * TODO: add support for large shmem folio in swap cache.
>> +		 * When shmem is in swap cache, mapping is NULL and
>> +		 * folio_test_swapcache() is true.
>> +		 */
>> +		if (!mapping)
>> +			return false;
>> +
>> +		/*
>> +		 * We have two types of split:
>> +		 *
>> +		 *   a) uniform split: split folio directly to new_order.
>> +		 *   b) non-uniform split: create after-split folios with
>> +		 *      orders from (old_order - 1) to new_order.
>> +		 *
>> +		 * For file system, we encodes it supported folio order in
>> +		 * mapping->flags, which could be checked by
>> +		 * mapping_folio_order_supported().
>> +		 *
>> +		 * With these knowledge, we can know whether folio support
>> +		 * split to new_order by:
>> +		 *
>> +		 *   1. check new_order is supported first
>> +		 *   2. check (old_order - 1) is supported if
>> +		 *      SPLIT_TYPE_NON_UNIFORM
>> +		 */
>> +		if (!mapping_folio_order_supported(mapping, new_order)) {
>> +			VM_WARN_ONCE(warns,
>> +				"Cannot split file folio to unsupported order: %d", new_order);
>
>Is that really worth a VM_WARN_ONCE? We didn't have that previously IIUC, we would only return
>-EINVAL.

Hmm.. it seems not necessary. Thanks

>
>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

