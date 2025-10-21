Return-Path: <linux-fsdevel+bounces-64907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A04BF65F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBBCF5016ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8433321CA;
	Tue, 21 Oct 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXnZMBZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8355244693
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048533; cv=none; b=fYGi/ryjdO0dse0giLyeTSLUbd2k9LsbhjqpXKnTsFvZzMG+tuLtT2scJX0upvQY/+Ix8FObzL1o4tp/UR0oyn+G17dgzsyeDqbS50yskwL/sxal0Jg9+qY8Ay/xh6sxWsFkqLTJYPMPJvnmS20LF6BuBJPlg0ne6zbg0LRATWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048533; c=relaxed/simple;
	bh=Se4jxx6lLa/LixzWounwQe2HQfxls1H1T66SY4jhs0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8ExBxiLRSSTEZ5OqjL3BDhcgaUamssVcXmgpqKCjd8E5PckjLJrRqmY/tvV6KuEYTwrbeLpG6+EU3OKiQOVGqsACTLU5yPJl/2MQP9h5lJSIzWVXBkzcS5mRFyglLqscXH+E0fWRniJAlgZzwE25VPeIugdt14+31EEplGyqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXnZMBZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761048530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jBk/hMZm1AU2HUgl06IU47txGUglYm8peBHpiuPlFXY=;
	b=OXnZMBZJt9g4EWkJzcAvBt7UH6GdmXl5l/g5fsI32aMhpYqDdQcUY4818J5PgCjvu3Fann
	O2vO1PlPjZ3IoUMgvFTblNb5psRO22bQ0KoTlA5G5jk8huwofpbN9XgConeGH0r7LPAdSk
	vZX3axvYNy9/7PcvLBKNIoCbg1PMelA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-cgo9HcWIP5S-1-IozEY3mQ-1; Tue, 21 Oct 2025 08:08:48 -0400
X-MC-Unique: cgo9HcWIP5S-1-IozEY3mQ-1
X-Mimecast-MFC-AGG-ID: cgo9HcWIP5S-1-IozEY3mQ_1761048527
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4283bf5b764so1751789f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048527; x=1761653327;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBk/hMZm1AU2HUgl06IU47txGUglYm8peBHpiuPlFXY=;
        b=EpnluPgMo7/euKBx6sbThIYQsUd9f22O1ooKEiqHJW0eHdryplAN1a1DV6KqpfpIp/
         M06SEeL9hdPVuqAYjeo+mzyTR1+dgbwGC7yl2MDs964NNQNCdG2e3z7bm44LObCOiun9
         +IfLBLj1AAqvemz8gHaVlZeBOCK5cYfOvOzxXKk6XLYpO08hIpMtFMPbnzmVcxtO1S4U
         fKSNOas13FGDIeayJh3/uNCRJgGYp3F4YNKIh6OchzxHUcS8AYn2Rpn81nAtWvb4Dy9l
         Jch9hcV4tgAzn7q+ne87DrKLzGty2jCZ0qOKKv4xpjCwLulWv1wWgUMvtMzLR3yFxHGC
         AKgg==
X-Forwarded-Encrypted: i=1; AJvYcCVp52LrfqrBxgtfPShYk6Ij8ChtKBPJOw3Rn1SOnnJfRfjZ47Vs+uBrlf0bd/SUgRFq+YgivXlUwNc7lOj1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzl04kllCTgI9oCqqflmlAfrM2+QbbP8FN9h+uKMcIHp+bVMrB
	6NpMjAUl7GApZPGRjYNZY4zRvcZ4RFLlgle3YCrEgsejB+bVR1XcZY7TzM8v9N2gwb5FpCEcflZ
	qHR0pIPu6mM+IhsXtMNwVDYyqeilDGp7ZkK19TF8+8KsMm2TjTVzMTZ5fAe8OOujRIC0=
X-Gm-Gg: ASbGnctmyTzazd4mApWavp3eQc8sBlblFC0MTcAqHKNTgIPgLjBy9qUF1d+deLqGIrc
	GdJMW8noeqg+qmGxgD2Gne0B3FD3yymu3I2xnOxQYfrEJUtnrDlkzCsLs/k5LXX6T9P2RDBHfMR
	SOLgAEaivOCuA/4EMOnTI/4nixV7vCuay9N+LB0HKJg2er12mBxNnnxg6prE5qT7L+cxcNHxgWc
	fBweYWVJPfiKJDYViRrfvcQzsHVg5REppHaNjhGLkR9XVzT2OFmUipCNjW4D12bRmT4RQEToX1G
	WUpWb1XMierWXdW/SEuYeQIyAog7J+IFcJW+ztPBqT7dTxg+CgRyUBbHFgU9ZQQyGMfO0pXOQfI
	XSiPhKOOKfcSSIGKTCTLu6OoBbwZjXVOJzXwaSR/DFCrGuqQdgh+xv+eep7GbXH82YfSaLruUYD
	wfX0YnFVXTUbSRXcPK3vBQW2dhOF4=
X-Received: by 2002:a05:6000:612:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42704d49a78mr9955321f8f.8.1761048527232;
        Tue, 21 Oct 2025 05:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ5mwIbXc0FupYjOjOI7qYovL003CpULMJ3bbgFzgJ3ZkyizTtVqUvrxQ5Ewt99StNhrhgpg==
X-Received: by 2002:a05:6000:612:b0:425:6866:ede8 with SMTP id ffacd0b85a97d-42704d49a78mr9955285f8f.8.1761048526794;
        Tue, 21 Oct 2025 05:08:46 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a1056sm19970736f8f.2.2025.10.21.05.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:08:46 -0700 (PDT)
Message-ID: <8379d8cb-aec5-44f7-a5f0-2356b8aaaf00@redhat.com>
Date: Tue, 21 Oct 2025 14:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memory: Do not populate page table entries beyond
 i_size.
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251021063509.1101728-1-kirill@shutemov.name>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021063509.1101728-1-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 08:35, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>

Subject: I'd drop the trailing "."

> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> Recent changes attempted to fault in full folio where possible. They did
> not respect i_size, which led to populating PTEs beyond i_size and
> breaking SIGBUS semantics.
> 
> Darrick reported generic/749 breakage because of this.
> 
> However, the problem existed before the recent changes. With huge=always
> tmpfs, any write to a file leads to PMD-size allocation. Following the
> fault-in of the folio will install PMD mapping regardless of i_size.

Right, there are some legacy oddities with shmem in that area (e.g., 
"within_size" vs. "always" THP allocation control).

Let me CC Hugh: the behavior for shmem seems to date back to 2016.

> 
> Fix filemap_map_pages() and finish_fault() to not install:
>    - PTEs beyond i_size;
>    - PMD mappings across i_size;

Makes sense to me.


[...]

> +++ b/mm/memory.c
> @@ -5480,6 +5480,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   	int type, nr_pages;
>   	unsigned long addr;
>   	bool needs_fallback = false;
> +	pgoff_t file_end = -1UL;
>   
>   fallback:
>   	addr = vmf->address;
> @@ -5501,8 +5502,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   			return ret;
>   	}
>   
> +	if (vma->vm_file) {
> +		struct inode *inode = vma->vm_file->f_mapping->host;

empty line pleae

> +		file_end = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	}
> +
>   	if (pmd_none(*vmf->pmd)) {
> -		if (folio_test_pmd_mappable(folio)) {
> +		if (folio_test_pmd_mappable(folio) &&
> +		    file_end >= folio_next_index(folio)) {
>   			ret = do_set_pmd(vmf, folio, page);
>   			if (ret != VM_FAULT_FALLBACK)
>   				return ret;
> @@ -5533,7 +5540,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   		if (unlikely(vma_off < idx ||
>   			    vma_off + (nr_pages - idx) > vma_pages(vma) ||
>   			    pte_off < idx ||
> -			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE)) {
> +			    pte_off + (nr_pages - idx)  > PTRS_PER_PTE ||

While at it you could fix the double space before the ">".

> +			    file_end < folio_next_index(folio))) {
>   			nr_pages = 1;
>   		} else {
>   			/* Now we can set mappings for the whole large folio. */

Nothing else jumped at me.

-- 
Cheers

David / dhildenb


