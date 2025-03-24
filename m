Return-Path: <linux-fsdevel+bounces-44891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F09A6E2C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 19:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3D9170223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97AA266F0C;
	Mon, 24 Mar 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIZvy1Vj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE64263C90
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842561; cv=none; b=lJAGN45qcek71oHaMzr7qAjXYnfnIMc5xbyGij9/JEUM0Lh62PUDUtivtjgI8x0F6to2P2c9ZzZyqBLhbFNlWWvooA/AFz3htgaXYBMwXNO+jIJRsue5dlJ3IWpDq+6nZnP+w8wrVr6aHoOBjBlOtkQ2gv0qL/UHIf3OhOnjoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842561; c=relaxed/simple;
	bh=L3uTXTJk7odzorAhFomR3zcvVjlXWkMwhXXYheMhPPA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YJR9J32uiy+YDobrEgNUUAbATnMvUI1/ZBD05fXmBsVfRrtlU5qehyGVSDrnNM2Eu4M1kTNeZRwe0E1CqxtcY9tzZA/pr2TmXDZdc4XCBYDrlrmb7koz52mzPBAa/FSgmF2Sq5jS2oE42iyXykUoCWEnsN0xNZmyA9loCMyajks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIZvy1Vj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742842558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGEvO5Sbach8z41JiTwS5hj1GlvRJwJQrtsu+oa2Eq0=;
	b=FIZvy1VjzlVJYO/LyOqkFLAtskfvfifEvtlzZpycat6wK1fnhHhUGWoILZJHaDLN7Xo3ea
	E2TGtbF14n936+8wQaO4JXQBNmDEUeznkeFxTR6reQpTQFMi7QVu+i9UzERPbaOeMdw1mg
	O92xEAMmUkpHchE1Tjf+3+UI2xGN8O8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-BHCP6YKtPmmSiRyNoXWB8A-1; Mon, 24 Mar 2025 14:55:56 -0400
X-MC-Unique: BHCP6YKtPmmSiRyNoXWB8A-1
X-Mimecast-MFC-AGG-ID: BHCP6YKtPmmSiRyNoXWB8A_1742842556
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e8f6443ed5so98223296d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 11:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842556; x=1743447356;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KGEvO5Sbach8z41JiTwS5hj1GlvRJwJQrtsu+oa2Eq0=;
        b=HZsMxtAGKfA93wkaTqa98V1u1HGO7V2QXjBe6oIsDutLW8yqdky8OA1qsRb+Mctp+H
         lwZ5takHhSTBG9L4EGijSO8dUZpXkbmoYk0wZZ5P91/05D8uGMhjN2CaNTM3uHNz4JZt
         knayUAF7IdqOFqH2Oy9oQ2jCgcrCBglVkHHAIVYazlKn7xGbGnEwXmFHOpswHHYSqtf2
         hkhNc9sCKwbxLxb9c5e4X7aIGwDGJv3Ely0b7uAJM7Hp++9IggMIwLjp3yXYjzQsdTuw
         L53Aq+qnWqghynr3U2PrHtBgO8s04boJSSoGmRacDO6byamHiafrhl7Xq4Y5ScqQ4CaW
         4eyA==
X-Gm-Message-State: AOJu0Yxb7RqWUHLGClzZle3WoimesxLUKhUzheF51uxsIs0QHCjpqi24
	3MiZytKPklsL0Znf34KE53u0QV7NpZKf1ASL2gJbwXBZ6bqfCgpDlkvG4hecPhL1UqFvbtq2cC2
	x2wNOQ+Ir5/uWi35M2JNH8nYEu7QBsMkA4R9SIsqDO/hYZudTI/d8B/Vcj4FoWRI=
X-Gm-Gg: ASbGncs2iCqkJQCSho+FuaFVmRTvKRhkMhrujip/PeS+l3IxVFDicJV/bI8qNY4Gdvy
	kIdOm/q80wzXohdqJSQqzheOwONUB9xLPOl0II03//sPfFPM96Lguu/JlbFBBqhjzHfvyP9cBCb
	2YdlGqB9PqFPautcuWqBIz6RJGl24r0lRT296O0z05ZHWOGqEZqu5A2n+arbvA1cBb0BB4QWgsx
	B5kHshJ8iL4mRhSoRbddDwwW7tQDeYsQ2K1s+K1QZBCbZW9BrxWcn3CxW2LEcCMRDVaiFG9mAOy
	5u7HCbmSgaG3
X-Received: by 2002:a05:6214:2027:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6eb3493113bmr263136416d6.8.1742842555832;
        Mon, 24 Mar 2025 11:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKT0AIGOD74uSCO7EpMRdLffUkeO90SPxsewBmpglboi/Ese+zvtNAM2TxfbNzdmxW7TizeQ==
X-Received: by 2002:a05:6214:2027:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6eb3493113bmr263136076d6.8.1742842555398;
        Mon, 24 Mar 2025 11:55:55 -0700 (PDT)
Received: from [172.22.33.10] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm47138366d6.116.2025.03.24.11.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:55:55 -0700 (PDT)
Message-ID: <f29c4706-1e04-49f0-9609-ff536088f9ce@redhat.com>
Date: Mon, 24 Mar 2025 19:55:54 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
From: David Hildenbrand <david@redhat.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Joanne Koong
 <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.01.25 17:10, David Hildenbrand wrote:
> Hi,
> 
> ___GFP_MOVABLE allocations are supposed to be movable -> migratable: the
> page allocator can place them on
> MIGRATE_CMA/ZONE_MOVABLE/MIGRATE_MOVABLE areas: areas where the
> expectation is that allocations can be migrated (somewhat reliably) to
> different memory areas on demand.
> 
> Mechanisms that turn such allocations unmigratable, such as long-term
> page pinning (FOLL_LONGTERM), migrate these allocations at least out of
> MIGRATE_CMA/ZONE_MOVABLE areas first.
> 
> Ideally, we'd only perform this migration if really required (e.g.,
> long-term pinning), and rather "fix" other cases to not turn allocations
> unmigratable.
> 
> However, we have some rather obscure cases that can turn migratable
> allocations effectively unmigratable for a long/indeterminate time,
> possibly controlled by unprivileged user space.
> 
> Possible effects include:
> * CMA allocations failing
> * Memory hotunplug not making progress
> * Memory compaction not working as expected
> 
> Some cases I can fix myself [1], others are harder to tackle.
> 
> As one example, in context of FUSE we recently discovered that folios
> that are under writeback cannot be migrated, and user space in control
> of when writeback will end. Something similar can happen ->readahead()
> where user space is in charge of supplying page content. Networking
> filesystems in general seem to be prone to this as well.
> 
> As another example, failing to split large folios can prevent migration
> if memory is fragmented. XFS (IOMAP in general) refuses to split folios
> that are dirty [3]. Splitting of folios and page migration have a lot in
> common.
> 
> This session is to collect cases that are known to be problematic, and
> to start discussing possible approaches to make some of these
> un-migratable allocations migratable, or alternative strategies to deal
> with this.
> 
> 
> [1] https://lkml.kernel.org/r/20250129115411.2077152-1-david@redhat.com
> [2]
> https://lkml.kernel.org/r/CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com
> [3]
> https://lkml.kernel.org/r/4febc035-a4ff-4afe-a9a0-d127826852a9@redhat.com
> 

Slides from today:

https://drive.google.com/file/d/1uX80M1x86Oz3DFoHif-JLx1rlC_Nh93R/view?usp=sharing

-- 
Cheers,

David / dhildenb


