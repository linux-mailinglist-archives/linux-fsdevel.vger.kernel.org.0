Return-Path: <linux-fsdevel+bounces-53430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1434AEF09D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F7E3A11F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A8269CE5;
	Tue,  1 Jul 2025 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDdzgHnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DD269AFD
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357535; cv=none; b=jE35rtBsNENO0j9l37ll3O7LqIPe5go3RT7HqxB7Ms7U1yEsGRG5kFdRob61zA/m4dn1KnMGF1cDsLeRjkYqPXDkX06PqXPTJrOfGjdqzwWe9CbDDUgn7+PksMB0bs/Wtn2RpcAnsggY8veDzNilgBMX5BlE9S36OaMnyMSWc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357535; c=relaxed/simple;
	bh=yUjs3NOjuhn6AHevTobhSBg7O8IgpKcVFKAos0UsDnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccw0IS+G/fK8kwZACWFgncGDjjQQofglOdt+9mDyxQ6xzk66Ry9EGwfBcsxGSvcyOxEcOrgwPxZFXbcLTZBlV0lgn1cOUmTQN1XdN/mma2RcCvOz6rhllb8B9WcJ4pDIRfIF8oKw5UgzpGK9vutoh+WLmEhgltxqWZ36Qmi3mBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eDdzgHnC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751357532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUVH4Y+OJJh1QuOp42YVy3obAL+tMMI3FUFoTmbRvmc=;
	b=eDdzgHnCGS3S5B3r2yDIE2zsmc8b7L0BHUYbycxk1TorBIu9M+M0v9y/1DIDfVnU3etaoO
	E9Wt4nPF9KYeLMxyPE3Z8StLGiSh/XS+MvF6JQq79qZHPl9avpev005nUOCDL5gzQdJabz
	0w5Hlfl3JLTtoEIkRBQxa5T2pA+PrSM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-P_S0hsDKPkm1nPW1HeaW_A-1; Tue, 01 Jul 2025 04:12:11 -0400
X-MC-Unique: P_S0hsDKPkm1nPW1HeaW_A-1
X-Mimecast-MFC-AGG-ID: P_S0hsDKPkm1nPW1HeaW_A_1751357530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3414559f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 01:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357530; x=1751962330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XUVH4Y+OJJh1QuOp42YVy3obAL+tMMI3FUFoTmbRvmc=;
        b=s19NeHE8xZMKijiENdzsiRndtprw6O37oXb1V0d5x7HEZwnJIhz2ro32ecdyRBZQem
         qHo084qU0Gr5Ep3nflxkYvpusyeBlF/fhR/GvFEO+ydEMZ0GZFo/vMWye9CW2+8vxNxn
         ht5s7Jv825fsbp8HfLHTQC9xk4FTzYZzH/Bn9MB/A7JmDos5oSCC9ZensuJVlCXBpkMV
         grJy4vXYcPMoCPor1bNQrzRAsg4IAu5A0FK+/VLnMFJbmySBz5uu6kdKqpHz4MgHGkO2
         FNe6x7arx7EVZDWk6BYATBh0hNKGiQw4E2qQNUQIHqIacEYSLSx91+gs0+snipM3eHeC
         /+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXWNmGF6BbZycrZaXGImt3aORf2zdYF6Ls1UnU9rmRjxblozibqb1sBAYskH1A7MTBYQSlfDH1RAMDOefat@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZsokuA78y0sZpBPk6zDDTlxBvXmU7IXFDRFaS1XI8BoXYszd
	8w8gumHFV7dc1XVyyx162E8RSZJyhqqTAkokRqWkcxmJjxhLL8dspcdWGps/GNmXniUIXHXagw5
	u6uPql06dqvKR5NH5SDoY13yL2iABsaiiGPnKsCy+bOC/hxbHCDIwjuhdWtDHwKJa92I=
X-Gm-Gg: ASbGnctXAVXvG/Pcatn3nTX00e0UvjGLMGiDmjl22KAiMep9UI0VBlAH8guHYP9Dhjv
	C5NCsgYW2q79gd7IkNG9W8aBHsSQQMzDWttbEkVG5KRmytSh/YwhqGaW+qQ7ACMjL1GybX+pJ5n
	hqewBzTa605vzrmy1Yqh9OwlScwos108H3JwK1rSnNokulAAYGUvD+IzpJCxrF+OIO57iWpwrH1
	FhlshD22zylK4Z4yjRsgPOny42maRT3Ge9lv1Z2ro/ByJxq2wun3pnxWUuMMZa7Za+rnhsCOERc
	lXcHCVImTZTsOkArPffulKVd9Mh5MyKgNMW9enNOhJ25Ixr55bZPPi9syq8tJWePnIjzhovXsMM
	6dNP+bLtG91YfAxao4iArFimDMel2tvnFpKVsPLdIYP2RFQVtsg==
X-Received: by 2002:a05:6000:104e:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a917bc827cmr11229465f8f.44.1751357529772;
        Tue, 01 Jul 2025 01:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsHgnnUEFpXSYw4p3OElnQrmUS9uew02TXhj0OkRpaoY11Ud7n6qleNpZ0nt8POoq3yWyxJA==
X-Received: by 2002:a05:6000:104e:b0:3a4:f513:7f03 with SMTP id ffacd0b85a97d-3a917bc827cmr11229429f8f.44.1751357529270;
        Tue, 01 Jul 2025 01:12:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fab15sm12666380f8f.33.2025.07.01.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:12:08 -0700 (PDT)
Message-ID: <1618bfb3-fbc2-46c4-954b-f042803cace2@redhat.com>
Date: Tue, 1 Jul 2025 10:12:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/29] mm/balloon_compaction: make PageOffline sticky
 until the page is freed
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
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
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-6-david@redhat.com>
 <6a6cde69-23de-4727-abd7-bae4c0918643@lucifer.local>
 <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <595C96DA-C652-455F-91DB-F7893B95124B@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 18:14, Zi Yan wrote:
> On 30 Jun 2025, at 12:01, Lorenzo Stoakes wrote:
> 
>> On Mon, Jun 30, 2025 at 02:59:46PM +0200, David Hildenbrand wrote:
>>> Let the page freeing code handle clearing the page type.
>>
>> Why is this advantageous? We want to keep the page marked offline for longer?
>>
>>>
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> On assumption this UINT_MAX stuff is sane :)) I mean this is straightforward I
>> guess:
> 
> This is how page type is cleared.
> See: https://elixir.bootlin.com/linux/v6.15.4/source/include/linux/page-flags.h#L1013.
> 
> I agree with you that patch 4 should have a comment in free_pages_prepare()
> about what the code is for and why UINT_MAX is used.

I can add a comment

/* Reset the page_type -> _mapcount to -1 */

To patch #4.

-- 
Cheers,

David / dhildenb


