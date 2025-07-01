Return-Path: <linux-fsdevel+bounces-53487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B7AEF879
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940D3188304E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4827B27585F;
	Tue,  1 Jul 2025 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7L336aG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176792749FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372731; cv=none; b=Ifi9Z2dHSlVuU77WWOvde8e7EWU8o9MneDJu0xUNp2u7/aMCH6/9+y3g2JZtM0DB6f/EAEUbgm2+2bo07KX3hTh9/8nosaVOrdJPyMQ6knByVj8gRYP0NbXDh3gbCdionp0LFlEY6f8u/e1Rt8Q4uBu3H/VgTMaKZnOTp8kUVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372731; c=relaxed/simple;
	bh=z/CCrJhSfJ+0N7wRoqbjcqIKdxPJ8urhIm9XK/idS34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jk3MbbvUhxQLRmyB4dBOCwhU4FB0y3xNLBSGEwPXeRMoZfWdTHPtFd19Ma4LjnPaTg9KB40ivqpDRG7C1RlDugrRLe9raQiG6uH+r7bhDl5KjixWPk/3sESPUW0DH3rhQm+BS21avtl57NCzH/cDksp6r8k0vj1DoPq/UOxenbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7L336aG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751372728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tj8pB/rMHLZ+6PtFNz+xS6WiL3VVVwDceOqfATE3uy4=;
	b=L7L336aG3jcvnsPEILzPAkjcMGwURYyRoGMm0tVWWSdptOtjdhnq58rzT/XIeyA9U+PhVs
	77425gDj1bzBDDGgb96ZKOBKvlCI/ygTvlcE3+DEZKOFSNH5X0OUoFozOHXnYcgDtm+qEb
	xwcGvpQtz38xkQRbbgoJGhV9EaClvfY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-pdVHXCMGNCaWRf8XgIvgqQ-1; Tue, 01 Jul 2025 08:25:27 -0400
X-MC-Unique: pdVHXCMGNCaWRf8XgIvgqQ-1
X-Mimecast-MFC-AGG-ID: pdVHXCMGNCaWRf8XgIvgqQ_1751372727
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45359bfe631so26802625e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 05:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372726; x=1751977526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tj8pB/rMHLZ+6PtFNz+xS6WiL3VVVwDceOqfATE3uy4=;
        b=MOFv6iv9GXtD+iKNBdYSr+nBua4U3jt7qKAgflw51YUOojZqL8hQ1hu4vW0GTMfmwt
         pFsvhGtsOtZ1Bt/K4KsBYDeLd2yEooxa3/4VOL1AdQsfH1db69QcJObpr+KslHEL40DX
         5thQ4mc8g0UaFjFIaV/nDJ3P6Fu8iPiwBbwB9hnQUytw+iHvMlJ10TMpXU9w2p9lkpAb
         6R9QsAbpl4YeK/rINlcZGl4W+Mh2fzshpEzXjBT4HPMZmvXDZbEbgSyEVA99/8fRSCU6
         8x4QzSLdLl6Z6ybSu3mOM+b8bfoY5eAcHbijMQl3UxZQX1OriSDO0dW3ayw5+JDSNBAJ
         59Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVHTTkxNfugaH64+FTJmGTSmxKd4Gz6OwgsjzzLwL6dI0k8zZygPfbmG+/AArKinqH6sp7QLgVyRojLCCnN@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8wuHa1X74y3yxl12bVEDN8/p3mc6gyF4nDpY2Vwqix8sZST+
	rxwz96pX8FXbtZk+nKNwdzknnqeKSeiQsf8+d9MTUYTb7tqyZ3Vl6CYUOLpRsnZkTo3GxV1ZpZI
	NZ+bNapRbLuMhew923hf3ZYk5YxuHg7P6gWgMQBxTe9B0660mbTAMcw7gNAWGRS9G5w8=
X-Gm-Gg: ASbGncuBhCrotHd2hU4BykClCUBUOIe1dB/DaHvqQRtXXgqw1Q+90oVVTSR3mLl6IjI
	z5r03U4qvkv7EQC5qmMuerIkUbT2rnJzQux8QhS36pet1zvpMi+vD7vES1E0XnHhm/KVMiKL5h+
	8eSbedbfFpdlsqtaZ1g+9QboeGQsUqMpzpuz+fxxKBrkUdS3iEiARCAXp+oYRcQ+ltWJ7DgSyo9
	u++zAmvrG71FuRPeAnRKi0fYd2QwKcLp6Y7t8CsmKZaJqHOqfUvj1K4gjHU7iW4vG/DZTsEdsZs
	zK3geo+UB5oR4bmH3tHaswISqB3KzzcZZ59LvaZtvGCW9Q8rA0htpVgVE8w1mYEZsOACmH4aJ8h
	qhu+RmAEYt5V6MtFHLR8B+zpWmwUhtpypdqAt/AIKJPM65ovj1Q==
X-Received: by 2002:a05:600c:198a:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-4538ee7df15mr201513255e9.16.1751372726381;
        Tue, 01 Jul 2025 05:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtxNR73SFMqIoSFe5cIm5GNMerZkIb6R08bnmv81T1e6WZOFEwjwh+c20OjBL0zx8GNPpXsA==
X-Received: by 2002:a05:600c:198a:b0:442:ccf9:e6f2 with SMTP id 5b1f17b1804b1-4538ee7df15mr201512785e9.16.1751372725799;
        Tue, 01 Jul 2025 05:25:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a43325asm162371015e9.16.2025.07.01.05.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:25:25 -0700 (PDT)
Message-ID: <e29af2bf-34c7-4d26-a5d7-f061d2642bd5@redhat.com>
Date: Tue, 1 Jul 2025 14:25:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/29] mm/migrate: remove __ClearPageMovable()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
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
 <20250630130011.330477-15-david@redhat.com>
 <24d2b984-857d-4a11-b016-dc0227d81c88@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <24d2b984-857d-4a11-b016-dc0227d81c88@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 12:43, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:55PM +0200, David Hildenbrand wrote:
>> Unused, let's remove it.
>>
>> The Chinese docs in Documentation/translations/zh_CN/mm/page_migration.rst
>> still mention it, but that whole docs is destined to get outdated and
>> updated by somebody that actually speaks that language.
> 
> Yeah I've noticed these getting out of sync before, perhaps somebody fluent in
> Simplified Chinese can assist at some point :) mine is rather rusty...

I already saw doc updates for this. Obviously, I can't review them in 
any way, but people seem to be active updating them.

-- 
Cheers,

David / dhildenb


