Return-Path: <linux-fsdevel+bounces-22991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E4924D46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86F6B219EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0C1854;
	Wed,  3 Jul 2024 01:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2TFbOrU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F62114
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971343; cv=none; b=OowSkfcJrBxF1+9I3Y8QPCuuSt+ab7FWxIb7x+rbwi9m8F/w9B+/Cym8sPiuLa1fAw5b12pEmpJBPfKNu93/cA5+9U9QGYJzfZ4NlYHAj/UcelGJuGXSQiBGOWXfQRzEhK1pAGR13Aw9PVCHhJgQsmflxSSNb1oUp+zv418MIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971343; c=relaxed/simple;
	bh=eBSR84mx0zTAmdW/wspiIXwCsn78vu3ay6NNkknXDaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OmDiusSmiLxbOceINw01RDW10HUkv8vmLG8DelpYPDESdkMonxgMUz9q//rkR3ibGOFBAxGKTroff4HaGJKCFK7vzbuh8xOm79nuGpyPVxZF73uonpOWARUtda/zBDpyaPX7egBS5NQcZzUKLCdblvZSdPZ/rFiXNiOEYKSjkDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2TFbOrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719971339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ogdbjOBZKJbri5gNt6Af1R6E7FF9agqqEAx2iKJCFOI=;
	b=E2TFbOrUkC/1L+jhYIxLW49+fLe7ZwuZL/xTozDh7JS080L6l56Lgbz9xW6rddr8c4F2wG
	crURNoGGsB7ra+y5vKr6ftNQOGSnfAuX7MmW4v0/vB+qsMeHecvE0Teny8ZGEanlZ9gt2y
	w/KTAuqhrvGXNrWq7WQmkbm5ulOKxs8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-PJGke4QRNS-9GFEihn33LQ-1; Tue, 02 Jul 2024 21:48:58 -0400
X-MC-Unique: PJGke4QRNS-9GFEihn33LQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f9ae0b12f3so27246875ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 18:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719971337; x=1720576137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogdbjOBZKJbri5gNt6Af1R6E7FF9agqqEAx2iKJCFOI=;
        b=d3Hxi2oH9mAK0LfbgbTxelbsx89d08xF+phXj++nZHZL6BgqPf1U0aWF0B3xb3PiSn
         C1AmiV+NA9izm6joWwDEucDpBx+WK2i0EcWiDsjt+9ThoRCv3RJ7gm7Eqg3HFNvwl3q4
         kCmJwHA6o1PDRIS8HDLzlzGXHVq1bJ/Usr/U8ADq1TuyKW/OQygBt5J0UjW1hEUZpCLw
         URAUwk8rU8oeg2jv9entvUUQylc2ZvKi1Xdg1LByW/KAfmWa/1VeMgQDXLCJhekGa6WU
         WZN2tLRC29vVbozu3UvsPVWHv8nSqtGAwnmaVc/YrjN3JKyUQaQ06+eayQ+zeNX+ptgQ
         zYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZvxAmkFbUd6CRywvFH+8ISrvBl+i2SVlzWry/C2pyNy22rw6SrUBJNI+ZsYiSYTnQ1MfoUkx9bL5D1mN2pYl51HoFDZHcTqlQycQ6Mg==
X-Gm-Message-State: AOJu0YxNPJkplqIfeZRH3qNiWSxQ/ywYhV7gEKQs0t3OGOHGUfMRDR1x
	KyY5BGC3fy10qqVtTNQCBx1TqaeD/B+AbsxQqqnSvNmbVmG7wjyAPNXJrE2cWsK7KRF+jeD+sOb
	xH4vUWhnlJgji9yEJdwZqbdVlqrDhPy5y3AW5HIUa75an/LDKNbV7b+w7Hin7LT8HJOX4r7E=
X-Received: by 2002:a17:902:e80f:b0:1f5:e635:2212 with SMTP id d9443c01a7336-1fadbb5930dmr63647975ad.0.1719971337238;
        Tue, 02 Jul 2024 18:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp3A8wFgu5w7U5E83vBos4Xlq5C0VkgT7tB7No/t1kzYYmuL80D7Rou5L2gdRNnUa6WkdMmg==
X-Received: by 2002:a17:902:e80f:b0:1f5:e635:2212 with SMTP id d9443c01a7336-1fadbb5930dmr63647895ad.0.1719971336874;
        Tue, 02 Jul 2024 18:48:56 -0700 (PDT)
Received: from ?IPV6:2403:580f:7fe0:0:ae49:39b9:2ee8:2187? (2403-580f-7fe0-0-ae49-39b9-2ee8-2187.ip6.aussiebb.net. [2403:580f:7fe0:0:ae49:39b9:2ee8:2187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1538e49sm91107705ad.145.2024.07.02.18.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 18:48:56 -0700 (PDT)
Message-ID: <e2a34e4d-b529-4ee6-b921-f54c3935f253@redhat.com>
Date: Wed, 3 Jul 2024 09:48:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker
 list
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>
References: <20240702170757.232130-1-bfoster@redhat.com>
Content-Language: en-US
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20240702170757.232130-1-bfoster@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/24 01:07, Brian Foster wrote:
> The nr_dentry_negative counter is intended to only account negative
> dentries that are present on the superblock LRU. Therefore, the LRU
> add, remove and isolate helpers modify the counter based on whether
> the dentry is negative, but the shrinker list related helpers do not
> modify the counter, and the paths that change a dentry between
> positive and negative only do so if DCACHE_LRU_LIST is set.
>
> The problem with this is that a dentry on a shrinker list still has
> DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> shrink related list. Therefore if a relevant operation (i.e. unlink)
> occurs while a dentry is present on a shrinker list, and the
> associated codepath only checks for DCACHE_LRU_LIST, then it is
> technically possible to modify the negative dentry count for a
> dentry that is off the LRU. Since the shrinker list related helpers
> do not modify the negative dentry count (because non-LRU dentries
> should not be included in the count) when the dentry is ultimately
> removed from the shrinker list, this can cause the negative dentry
> count to become permanently inaccurate.
>
> This problem can be reproduced via a heavy file create/unlink vs.
> drop_caches workload. On an 80xcpu system, I start 80 tasks each
> running a 1k file create/delete loop, and one task spinning on
> drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> negative dentry count increases from somewhere in the range of 5-10
> entries to several hundred (and increasingly grows beyond
> nr_dentry_unused).
>
> Tweak the logic in the paths that turn a dentry negative or positive
> to filter out the case where the dentry is present on a shrink
> related list. This allows the above workload to maintain an accurate
> negative dentry count.
>
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>   fs/dcache.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 407095188f83..5305b95b3030 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>   	flags &= ~DCACHE_ENTRY_TYPE;
>   	WRITE_ONCE(dentry->d_flags, flags);
>   	dentry->d_inode = NULL;
> -	if (flags & DCACHE_LRU_LIST)
> +	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>   		this_cpu_inc(nr_dentry_negative);
>   }
>   
> @@ -1846,7 +1846,8 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
>   	/*
>   	 * Decrement negative dentry count if it was in the LRU list.
>   	 */
> -	if (dentry->d_flags & DCACHE_LRU_LIST)
> +	if ((dentry->d_flags &
> +	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
>   		this_cpu_dec(nr_dentry_negative);
>   	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
>   	raw_write_seqcount_begin(&dentry->d_seq);


Acked-by: Ian Kent <ikent@redhat.com>


Christian, just thought I'd call your attention to this since it's a bit 
urgent for us to get reviews

and hopefully merged into the VFS tree.


Ian


