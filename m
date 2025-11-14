Return-Path: <linux-fsdevel+bounces-68433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0522C5C17E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3BF64F2509
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F03016E3;
	Fri, 14 Nov 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV9NQ2cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8D301491
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763110181; cv=none; b=Zz/GsPU0cHDXqo5PVIG5q/Oo3GkorJpylWGssOPpKhIE+oPRHe6obshsxg6vwG3CAsFc7v4Kkbd0P94rhEYVEZAgzKtynTB5c9zBXvWeUSbNu2Y/lKptbqjJBpUyxQOFUNZLm2PAZM/8WSEfuKpNozpBY/70DpIvxoVQdBMztF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763110181; c=relaxed/simple;
	bh=2VjlPjr4YgqvCmkWdEAljVv3hnLPGuBJoJEbxeGw5+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MO9YqkP7Ub0yTZJHLhYGiJljcsabv3tnIgl0eXtP2uV3rSDcOY5spGxlJmbc7gZIwYxCmLoxlFHhumJ3+5ZO2sBvs5BpLpVuzg80cTR3IZFG1JCsHNcnYJ2UjlhCy2paVCRiBpJuwYHHPS7HJq8bXrYqHVCzAIvLj9pQUSSiumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV9NQ2cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F606C4CEF5;
	Fri, 14 Nov 2025 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763110180;
	bh=2VjlPjr4YgqvCmkWdEAljVv3hnLPGuBJoJEbxeGw5+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PV9NQ2cEFX90//6qK37YDIkkXBgQAEEJbQMTojQ0TzNFMTVGbtV7SzaKE4Q2tJc8j
	 AlAIsfNfeku+vvPh2SqSDyZ+qP0EBByvPRHDrlyCJxAAEdA/RP2JCTO1xrYrUNIZ1t
	 0KlSWSrOAkUGXOR9rlWOz0PgYi9Rpb+mHYvKbMB+r9RWyaI22UZvoeqQWWAfJSaYs7
	 yniXIb8YVCoE914w4nWE6MagSt+ySOBnoFCkKhH4Pq1P68p+sWV9WcJI5zD2Snq7DW
	 i+kvJbfBXbQd0FO+MHJt+OLFBwZKOvb8jhYEHoSk2y+VfXCa86omdWjOB621C+CDdI
	 FgxcqMUOUG+fg==
Message-ID: <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
Date: Fri, 14 Nov 2025 09:49:34 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
To: Wei Yang <richard.weiyang@gmail.com>, willy@infradead.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251114075703.10434-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.25 08:57, Wei Yang wrote:
> The primary goal of the folio_split_supported() function is to validate
> whether a folio is suitable for splitting and to bail out early if it is
> not.
> 
> Currently, some order-related checks are scattered throughout the
> calling code rather than being centralized in folio_split_supported().
> 
> This commit moves all remaining order-related validation logic into
> folio_split_supported(). This consolidation ensures that the function
> serves its intended purpose as a single point of failure and improves
> the clarity and maintainability of the surrounding code.

Combining the EINVAL handling sounds reasonable.

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>   include/linux/pagemap.h |  6 +++
>   mm/huge_memory.c        | 88 +++++++++++++++++++++--------------------
>   2 files changed, 51 insertions(+), 43 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 09b581c1d878..d8c8df629b90 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -516,6 +516,12 @@ static inline bool mapping_large_folio_support(const struct address_space *mappi
>   	return mapping_max_folio_order(mapping) > 0;
>   }
>   
> +static inline bool
> +mapping_folio_order_supported(const struct address_space *mapping, unsigned int order)
> +{
> +	return (order >= mapping_min_folio_order(mapping) && order <= mapping_max_folio_order(mapping));
> +}

(unnecessary () and unnecessary long line)

Style in the file seems to want:

static inline bool mapping_folio_order_supported(const struct address_space *mapping,
						 unsigned int order)
{
	return order >= mapping_min_folio_order(mapping) &&
	       order <= mapping_max_folio_order(mapping);
}


The mapping_max_folio_order() check is new now. What is the default value of that? Is it always initialized properly?

> +
>   /* Return the maximum folio size for this pagecache mapping, in bytes. */
>   static inline size_t mapping_max_folio_size(const struct address_space *mapping)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0184cd915f44..68faac843527 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3690,34 +3690,58 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>   bool folio_split_supported(struct folio *folio, unsigned int new_order,
>   		enum split_type split_type, bool warns)
>   {
> +	const int old_order = folio_order(folio);

While at it, make it "unsigned int" like new_order.

> +
> +	if (new_order >= old_order)
> +		return -EINVAL;
> +
>   	if (folio_test_anon(folio)) {
>   		/* order-1 is not supported for anonymous THP. */
>   		VM_WARN_ONCE(warns && new_order == 1,
>   				"Cannot split to order-1 folio");
>   		if (new_order == 1)
>   			return false;
> -	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
> -		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> -		    !mapping_large_folio_support(folio->mapping)) {
> -			/*
> -			 * We can always split a folio down to a single page
> -			 * (new_order == 0) uniformly.
> -			 *
> -			 * For any other scenario
> -			 *   a) uniform split targeting a large folio
> -			 *      (new_order > 0)
> -			 *   b) any non-uniform split
> -			 * we must confirm that the file system supports large
> -			 * folios.
> -			 *
> -			 * Note that we might still have THPs in such
> -			 * mappings, which is created from khugepaged when
> -			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
> -			 * case, the mapping does not actually support large
> -			 * folios properly.
> -			 */
> +	} else {
> +		const struct address_space *mapping = NULL;
> +
> +		mapping = folio->mapping;

const struct address_space *mapping = folio->mapping;

> +
> +		/* Truncated ? */
> +		/*
> +		 * TODO: add support for large shmem folio in swap cache.
> +		 * When shmem is in swap cache, mapping is NULL and
> +		 * folio_test_swapcache() is true.
> +		 */
> +		if (!mapping)
> +			return false;
> +
> +		/*
> +		 * We have two types of split:
> +		 *
> +		 *   a) uniform split: split folio directly to new_order.
> +		 *   b) non-uniform split: create after-split folios with
> +		 *      orders from (old_order - 1) to new_order.
> +		 *
> +		 * For file system, we encodes it supported folio order in
> +		 * mapping->flags, which could be checked by
> +		 * mapping_folio_order_supported().
> +		 *
> +		 * With these knowledge, we can know whether folio support
> +		 * split to new_order by:
> +		 *
> +		 *   1. check new_order is supported first
> +		 *   2. check (old_order - 1) is supported if
> +		 *      SPLIT_TYPE_NON_UNIFORM
> +		 */
> +		if (!mapping_folio_order_supported(mapping, new_order)) {
> +			VM_WARN_ONCE(warns,
> +				"Cannot split file folio to unsupported order: %d", new_order);

Is that really worth a VM_WARN_ONCE? We didn't have that previously IIUC, we would only return
-EINVAL.




-- 
Cheers

David

