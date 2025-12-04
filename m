Return-Path: <linux-fsdevel+bounces-70691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 742D0CA42F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 16:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DF8630131F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C49D2EB5D4;
	Thu,  4 Dec 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcOcWV52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143F2E88B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861214; cv=none; b=IuvpzLnYjqet2cgP4Yumc+Gbo3OT8V7pAIJpCzmg+P/rnM66Lx1tvXcjHQ7QP0tQOlfivEsWkpUMei1ZTJzyKaCldWPQXWdyu8Gd/e8pksEWeG7xcrYdT4y6h5hejlxin8MLcVTykmuoH2J9Q2kolLmNVs9H1r6v+XmqNzS8Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861214; c=relaxed/simple;
	bh=m/wLKHoVzGZ2B1jeGzqGbXZcnZnUzvyiWWNYwRJaOes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck2RYwCizVZXxrZm5l8bWwrN5ZZV0W3QKGx3SqN87KpNBtyVarc58aAVRbni3H9YREjJC+tejy6+2YK2UPObnedDdN8b3kJOVqrZqnwAskbTiJL0zxsRUdpDw6Ve1qYBTVsl5ATL9QOKpP6Q056v34i8HPVj4DFDnGInyNePezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcOcWV52; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so91558966b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 07:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764861208; x=1765466008; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=984Ihpo1W0CqlWCA8Wm5WPWQwhBS6unw3a7F3fFjLYc=;
        b=lcOcWV52DUHIseFtDF/OV+mLJAV68VIiPIQ/G3/gFausoPaQiba9QQvEK0Zt9apOCn
         R9xrxQPB6FlsHV3OjIYalVQAJT1B2s8iD9hVwDGnfIfnuqDkxYBSYAZa77OcGQeoYPVW
         8LjQSCyEOEDJnky6IYedBUcUNctGPrAfCqGlvD4LOg/LXefXXAdLSQy4/blDySCUlgLw
         LFWnBK50OTwRwW0KHurihymhHj9uVmlEUIy9AyHSPCc7xDyIleSTQIib1Zaa01bR7vvz
         LIOB32kXsaS/VEA3HTS5AKcT9mD3iWMSegqPhdEGi/5/cTtheMiBm+lpu2AyTANqh5I3
         q+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764861208; x=1765466008;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=984Ihpo1W0CqlWCA8Wm5WPWQwhBS6unw3a7F3fFjLYc=;
        b=rIc+sTPEhrZg6/moE9fLXlaWlJkat/CyZ4TIO7LZpA/h63Lxjn9sIJ9WsFD+aWWSIT
         wd4ybtvPpW+GcpdLCxHaA+do2tXozCe4zuUy9lvVbtKg9UIve8SWZB8EKxtmtFh++slS
         /jAnje/eFmuKBLWbR7SAGk8DFoo+YEUnR9pHZN32AjIN2wWnD4cIkLXR0xJ7Y0dYO5BU
         8PEa9ff3QyyrKfheJtbGb8VuxR+N5GD7Fnle/fof88Oc+9Xx4Z7As2aRQjCQecikBsFg
         QRuhzWRN35H2jcORJ07jRiMP3ESNv0wn/9ZkY6wVbSrNZ+Rj/0OirU276dndrt7MG6OG
         aM2A==
X-Forwarded-Encrypted: i=1; AJvYcCUnzO/wlhk0kUBp549XcZMVEOuie0Gx9suyBb5HCvZoJoo89Kkqv3Xymn1tVroRS0H2LmQXU1NzTclRc5cz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgc5ZLCyG2ShdVs4qpHugpqgxSrahdlZWOEEN7PnMW4wA2X1wO
	sSW/aey9zB4Ay66f7InPyvbGhfC4BxHpqmJ1SWW//jXXMtQQ1S8hiwGm
X-Gm-Gg: ASbGncsUN5MdbK+I1xZai8NPWqzsP48gR4Htpp6Ur2PmBTmS+VpSkqlTsbN5WAGb4kd
	4SgIF6TMBrXbS1Ee+4ofqHY/lbaHpx+00Ysx9xDkIhnMMAgsaXfj1zROnL9ijs0NSfBhuaA8VMS
	PMUYOSfEdItPzXw2XBeo4Dvz/m6AfrDom8buf3yMYwY9fLuEQs79XbYwnfc5p+3rkI/0XpSNZBb
	oUqXPy91X2KRej3O5/dT+uvvKqTXsQGNkvZazWjawj9JAykdabeEy+4mDoLs1FI2eoGpfcnMOhp
	7woFWteJExuktXuNPlgb6t0E+Ks84nD2LyO6hVZO/F6SQjdzl/1cDl6fm8af+04F6B9c7y9wjjQ
	NMSD6/pBxLOIK454lHfVnzTypwKiKdBY/xOPnWzLjgLjqEgDrb+hbe3DrYRHtD8Z1C3XiDz0qmF
	2h2bRB3VK52Q==
X-Google-Smtp-Source: AGHT+IF4Ki2Iy7tePrIXhfaDw2LqZEVcYwE61ERa0Sy2WkINJH+QQ5f9M4Zh+9BccRgTWkgnfoannw==
X-Received: by 2002:a17:907:7b87:b0:b76:74b6:da78 with SMTP id a640c23a62f3a-b79ec6743f4mr347255466b.35.1764861207867;
        Thu, 04 Dec 2025 07:13:27 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a7951sm155535366b.49.2025.12.04.07.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Dec 2025 07:13:27 -0800 (PST)
Date: Thu, 4 Dec 2025 15:13:26 +0000
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
Message-ID: <20251204151326.63twqgfwzxbco362@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <20251114150310.eua55tcgxl4mgdnp@master>
 <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Nov 14, 2025 at 08:36:20PM +0100, David Hildenbrand (Red Hat) wrote:
>On 14.11.25 16:03, Wei Yang wrote:
>> On Fri, Nov 14, 2025 at 09:49:34AM +0100, David Hildenbrand (Red Hat) wrote:
>> > On 14.11.25 08:57, Wei Yang wrote:
>> > > The primary goal of the folio_split_supported() function is to validate
>> > > whether a folio is suitable for splitting and to bail out early if it is
>> > > not.
>> > > 
>> > > Currently, some order-related checks are scattered throughout the
>> > > calling code rather than being centralized in folio_split_supported().
>> > > 
>> > > This commit moves all remaining order-related validation logic into
>> > > folio_split_supported(). This consolidation ensures that the function
>> > > serves its intended purpose as a single point of failure and improves
>> > > the clarity and maintainability of the surrounding code.
>> > 
>> > Combining the EINVAL handling sounds reasonable.
>> > 
>> 
>> You mean:
>> 
>> This commit combines the EINVAL handling logic into folio_split_supported().
>> This consolidation ... ?
>
>It was not a suggestion to change, it was rather only a comment from my side
>:)
>
>[...]
>
>> > 
>> > The mapping_max_folio_order() check is new now. What is the default value of that? Is it always initialized properly?
>> > 
>> 
>> Not sure "is new now" means what?
>> 
>> Original check use mapping_large_folio_support() which calls
>> mapping_max_folio_order(). It looks not new to me.
>
>Right, but we did not actually care about the exact value.
>
>IOW, we didn't check for order <= mapping_max_folio_order() before.
>
>SO I'm just curious if that is universally fine.
>

Hi, David

I just happened to come across some code that might address your question
here.

Take a look at the function __filemap_get_folio(). It uses
mapping_max_folio_order() and mapping_min_folio_order() to determine the
appropriate folio order for page cache allocation.

Just want to share what I found.

>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

