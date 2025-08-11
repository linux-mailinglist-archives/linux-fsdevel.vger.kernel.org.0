Return-Path: <linux-fsdevel+bounces-57370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627BB20C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A66418868FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243F2DF3FD;
	Mon, 11 Aug 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9dsvyMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5602D322F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923285; cv=none; b=SWkiBcQ6L6hZkRLWvi7CiBo3uwBoXmXQog4d7OzIOEzRRCwJTR3aUK73SEryNky9ukdqsouO5fVFxbVjFx9/3nOCmvZ4RshNsrPVvWyoRl54PPtiTnKc4BGMIVhB3+FNw5DZW0VBWK7a0oOs/GVmKMo5P75bonYL4B98115L1xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923285; c=relaxed/simple;
	bh=kbpPvhNZz6SqWU9uqkbeGc4vIVmkx079K+FGeZ8lOws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8cP+eYwSN0deh8l9aM0CAD4hXiIOEVYIXqUDToT+7V3nI5HGOBJOah0V1kkpvdrTLy+x0lDE/jp4iFuyuTrxieMp75jNGIo+fD3yAXu51W/XEJb48f5GEUsoMldWwST63S601Q1qCxCk96tLNC58WnJ0/ZJoSnYxTa9o3ESRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9dsvyMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4gbggx2RPFlVO4t++KHmOzrhjwslbE7WXGI1AzTGhb4=;
	b=D9dsvyMoIb+EgxMYpQJOmz2oQ89Y/g7j7RMFVEJQesphL3IVSKVaQ0JB57E0dE7O/d5UHl
	bJDhKXs05zFu5jtp6C/MH61BgNnp+cO3ccz3+Bi6Ls9UZuAInrHCUw2x/rvsRQcOdW6aMZ
	D+YdWgYqnNy8tu0qVySfYvXTKtrI6CA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-gJUJ_gr-NKmjTnQVbNHLtQ-1; Mon, 11 Aug 2025 10:41:21 -0400
X-MC-Unique: gJUJ_gr-NKmjTnQVbNHLtQ-1
X-Mimecast-MFC-AGG-ID: gJUJ_gr-NKmjTnQVbNHLtQ_1754923281
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7891afb31so3318663f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 07:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923280; x=1755528080;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gbggx2RPFlVO4t++KHmOzrhjwslbE7WXGI1AzTGhb4=;
        b=lom185nxF8jHgb+qN2fDmaOab2JUJ/XbeEYJgrKLrs8MtKYH7A5kY3kT55tQZkw1gl
         cLh7aHDQ4XflAEdVYi1LaO4CnKNZXuOaPlHRFQBl1eJnwP479CLfVmMnVJ8Ti8s/ImPQ
         WH821cHwNJqWUlj3DnLjAI/t+jmCtDHUnXHGwdltzdZKgv08Jj2hvY9NCMOUpp3H/3eH
         2w2qeIB2e4bp/Sm1gtIzAufmAQ7/2/740ONOoCgx0XTNU2q6JgRlkxRvTLf+RNTdGsu2
         yCURTGG7pR/Y3kpdMNjb0caZ2LGCe1tiGC3PnVjE0VLFW39mZmc9m0ikcMJ6/ENyI2Z5
         C4xw==
X-Forwarded-Encrypted: i=1; AJvYcCVeMTekPYyAK7iGFy8Zt+valGtHD0CNH2U5qFZ5jZli5aosgEkTrc2DTZewU+iTNCx/tA3tHQehqsD7J+7s@vger.kernel.org
X-Gm-Message-State: AOJu0YytAEvIRuiHss5aTG3D/cUOOqSzNehnGkvoYRKMF41gPSnfeKVF
	5o/Dqb520g1w7ONlHb5kp+KssJNRpt5+1YlBVuGQdOlxqE19J2+NCNRB7qYmYGmyyQU4L8eRU0O
	yCBG374zzlg2+0BBmUMKzj1//n6v4RJWqR3iLC9FCgXYrhknyRFchdrvNyJhoJwn7AOs=
X-Gm-Gg: ASbGncuC1GKCsjZSlFAaKRnfNCeV9xjo2JNneu+VPuMHJZBJNHZOdQSI6Qyw8vQmE+V
	5L4j8mW8x4y7LW64nalA69YhWr82i7+QfhribkI8/tbgN9WIW2ly4eO73iEKpEOOp7Hvfo9vNRj
	SXX1iGUXQTGmCR3wZBpUCLlJoiOpek4dBRUADu3mzuQI9HF85E9RA0kbQXkxqx8Mi03O35RbHeO
	p9sXsibC57r769ZJrFbhL7Aa1CiUHPOtaBhvc1aeDyRjUpYvNppw3yuZNyWrGDzCRbndjSu8uAO
	6VGe8LaxNh/fCMYfG1223PU+AhyaN6ETAJrSbp5mm9H8J2/A/2rscEcke/IZtisVMAm1LrNa1M8
	gRMFe6liJlAneBO1AUlcZo+xvHYdzpBTJ09dCD2Ht+kgvN+LHLE65yIEwMgJzF3yRWYY=
X-Received: by 2002:a05:6000:2408:b0:3b8:d1d9:70ba with SMTP id ffacd0b85a97d-3b900b7517dmr9713479f8f.32.1754923280095;
        Mon, 11 Aug 2025 07:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNmqOKGQy8og6iuYjR3rW+/P+X+6GleHhPef0aGzUOgh7s7rRGq5mXZf9HiFNB9XK8mxgicg==
X-Received: by 2002:a05:6000:2408:b0:3b8:d1d9:70ba with SMTP id ffacd0b85a97d-3b900b7517dmr9713436f8f.32.1754923279410;
        Mon, 11 Aug 2025 07:41:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm41145907f8f.64.2025.08.11.07.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:41:18 -0700 (PDT)
Message-ID: <42956218-bda4-4089-8f43-f7352ee73b4f@redhat.com>
Date: Mon, 11 Aug 2025 16:41:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM
 guest-memfd
To: Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>
Cc: vbabka@suse.cz, willy@infradead.org, akpm@linux-foundation.org,
 shuah@kernel.org, pbonzini@redhat.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 tabba@google.com, vannapurve@google.com, chao.gao@intel.com,
 bharata@amd.com, nikunj@amd.com, michael.day@amd.com, shdhiman@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, jack@suse.cz, rppt@kernel.org, hch@infradead.org,
 cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, kent.overstreet@linux.dev, ying.huang@linux.alibaba.com,
 apopple@nvidia.com, chao.p.peng@intel.com, amit@infradead.org,
 ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com,
 gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com,
 papaluri@amd.com, yuzhao@google.com, suzuki.poulose@arm.com,
 quic_eberman@quicinc.com, aneeshkumar.kizhakeveetil@arm.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250811090605.16057-2-shivankg@amd.com>
 <aJn_ZvD2AfZBX4Ox@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aJn_ZvD2AfZBX4Ox@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 16:34, Sean Christopherson wrote:
> On Mon, Aug 11, 2025, Shivank Garg wrote:
>> This series introduces NUMA-aware memory placement support for KVM guests
>> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
>> that enabled host-mapping for guest_memfd memory [1].
> 
> Is this still actually an RFC?  If so, why?  If not, drop tag on the next version
> (if one is needed/sent).

There was the complaint that !RFC meant that it would be based on a 
consumable upstream branch.

I think once this series is rebase on top of kvm-next, we can finally 
drop the tag.

-- 
Cheers,

David / dhildenb


