Return-Path: <linux-fsdevel+bounces-26088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFF953CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 23:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB774B24B34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81B1537DA;
	Thu, 15 Aug 2024 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbntlZAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FF61494C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758091; cv=none; b=uHopagg21AsFIK1VbLhIByGWje3iIlDFp18cQh2J23y1l6gYxfM8DGQJ5p+lD+rtN3iSRU/EpMnJV2p4a8R0pyBoL2xpMfmSDmCs938BqvXj8+p9HYAr4dLMxEEZJMEEzQCxuRlV3KEZs1Qh8vQbrTHO8taOOcSjVeIXjcCwvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758091; c=relaxed/simple;
	bh=AN3nKp0u/wUIrYmQUvDr4r+SbNnpW51DD/sRfxfZWHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uTK9R5wEihIYWYwNbgjIQlVy12e8/D2h3d/UJS+m7O5MupRxITuQVD0watni30T5x3gkdsM04BUTi+6Ua9Z5gPDPr0wF3+2gSzV+EWdJXr+gDovzIiu9WDqGlId/+WQOrOXrmqStAQkAJPcwJY+7vuF9uBt8CtFGV89z1T9cMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbntlZAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723758088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JURWrCXIvW+9KwIAhhKh1yrmLu7AEBTXxn2VFlVxB2E=;
	b=cbntlZAAqKcCl6LGvsLQbI9oYZUavl8hlAFQxXnZs8s1mANqU2vv0zeFyY3vgKGGcgLbyr
	PvralE4SG7Tw6KFrKmHAv6okuaolblNen0CD8hqrutlOuVtxVEyMu7pW++Wa7X2giuO+ai
	eYD4UXj2pm3uyw4rSfEM/0YPavZd/3A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-UTcle9dGMl-iEek3SgdY4A-1; Thu, 15 Aug 2024 17:41:26 -0400
X-MC-Unique: UTcle9dGMl-iEek3SgdY4A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718a4d3a82so598087f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 14:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758085; x=1724362885;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JURWrCXIvW+9KwIAhhKh1yrmLu7AEBTXxn2VFlVxB2E=;
        b=aUqzUNBVz4tFTptVYBkgEwG0yJ6UHbjiVp9mBgJ+f75YGpkZkJQn6YKoptyveL02ZY
         plib+5br/S2+zwiT1AlF/5FVthrLQXMHcnFuGSqZFiad7ynCk5tZ0cvHe3PO5GPDtEa0
         YrtzwtZSaPik390LTS250abKQupJv5U5pluvUCGzmvcLRFW7eCatCAaZ+n7PMCn+VD9X
         0JIzs1sEDuXFBe+px9+Hc+HX4P8qw9ANnA7VANUACVvfCQVBeMg6d50mH/cIjIsYbuwS
         aHsGtwbCNqFfXrDdCAxWnMIT+YJcpywsOaDSkzw1gAhBlPhw+IxrLvBCNs2WuJfSln8V
         j5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXQPXUNF4L9Td77M/r9oZ+ReNLR250HXfAfSJ8Lf8geKAqpmGv/vt8QPM7Xj3f0ie8XF68djCAL79ACgh32fx93wb9eJQp6/sN5bET0Q==
X-Gm-Message-State: AOJu0Yz5y3ExDNiMYxLkJI+TYo3+mTA1E0cQhpc6L1JHS01HV/SoTJgw
	88P5ByOVEaEi5HqNATOzvPlZr/S3C/JBsrzMeWDv+FLWljsz/qp8OwhRn+Goko4jblcW5d56u5R
	MWvvcEE3ubck2AtNSch8VUUhipPgnIbptlVlKwPd5D+wtmdFeyHPtYv1MulCeVTE=
X-Received: by 2002:adf:fa50:0:b0:367:9881:7d5e with SMTP id ffacd0b85a97d-3719431e648mr347156f8f.8.1723758085482;
        Thu, 15 Aug 2024 14:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5OtX77dZx+5yj4Z/Gv2EIHNZ9s0B/bJudWMFSpBwkEzY9hefMYVIDxB4Z1RbpvGcZNHzncQ==
X-Received: by 2002:adf:fa50:0:b0:367:9881:7d5e with SMTP id ffacd0b85a97d-3719431e648mr347147f8f.8.1723758084978;
        Thu, 15 Aug 2024 14:41:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6d00:aebb:127d:2c1a:7f3a? (p200300cbc7176d00aebb127d2c1a7f3a.dip0.t-ipconnect.de. [2003:cb:c717:6d00:aebb:127d:2c1a:7f3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985ae26sm2354517f8f.55.2024.08.15.14.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:41:24 -0700 (PDT)
Message-ID: <7e7ee391-6f4d-4d36-ace5-4f8ca81479bc@redhat.com>
Date: Thu, 15 Aug 2024 23:41:23 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Merge PG_private_2 and PG_mappedtodisk
To: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <ZrzrIEDcJRFHOTNh@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZrzrIEDcJRFHOTNh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.24 19:36, Matthew Wilcox wrote:
> I believe these two flags have entirely disjoint uses and there will
> be no confusion in amalgamating them.
> 
> Anonymous memory (re)uses mappedtodisk for anon_exclusive.
> Anonymous memory does not use PG_private_2.

Also not when they are in the swapcache, right?

> 
> $ git grep -El '(folio.*mappedtodisk)|PageMappedToDisk'
> fs/buffer.c
> fs/ext4/readpage.c
> fs/f2fs/data.c
> fs/f2fs/file.c
> fs/fuse/dev.c
> fs/mpage.c
> fs/nilfs2/file.c
> fs/nilfs2/page.c
> include/trace/events/pagemap.h
> mm/memory.c
> mm/migrate.c
> mm/truncate.c
> 
> $ git grep -El '(folio.*private_2)|PagePrivate2'
> fs/btrfs/ctree.h
> fs/ceph/addr.c
> fs/netfs/buffered_read.c
> fs/netfs/fscache_io.c
> fs/netfs/io.c
> fs/nfs/file.c
> fs/nfs/fscache.h
> fs/nfs/write.c
> include/linux/netfs.h
> include/linux/pagemap.h
> mm/filemap.c
> mm/migrate.c
> 
> The one thing that's going to stand in the way of this is that various
> parts of the VFS treat private_2 as a "wait for this bit to be clear",
> due to its use in fscache (which is going away).
> 
> So my approach here is going to be:
> 
>   - Rename mappedtodisk to be PG_owner_priv_2 (add appropriate aliases)
>   - Switch btrfs to use owner_priv_2 instead of private_2
>   - Wait for the fscache use of private2 to finish its deprecation cycle
>   - Remove private_2 entirely
> 
> Sound good?

Yes, one step into the right direction.

-- 
Cheers,

David / dhildenb


