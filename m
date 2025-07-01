Return-Path: <linux-fsdevel+bounces-53577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E7AF03E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 21:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96511882536
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB73283121;
	Tue,  1 Jul 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMMs7P47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141B2727E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398491; cv=none; b=claGxRqkDQczkGdcBO/qtqptr5w6CF6bzzRb/eioMp3iWjsA0Pybw69Oko0aPKlq65kr9Z2DGV0g/R7rTtxKz+d7SSDDaVNIsvuWqwLJVpYs8SMjCyv1xns3WwHoahS3cBbylbdZg1Wze76T17hNWVWKm+a8tAQ4Za/WTbYI6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398491; c=relaxed/simple;
	bh=IfIn2pV/T5GS2KsTCh7WHgYSdR9NjRHjEuLtW5Bc96A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiYq9Uy72Ku/95N/SWj65Ah5zvLOsKU7cU/O6KpNw9E+lQMXVXTDlVGIiMvTtese4er42kaOQCNKS+uSihtY304h3pPtt+/mOjoZVsMX+oaz+yExaydJAQGjZ+3xsh3WGaKyjrHux7ssKhSKKeMsx3N6EGHvfbY5Vr+A5TaIdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMMs7P47; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751398488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gw1ZFU7fseKrRoTgl7UAAoDGCdFd91K7Vdf4y+yHx50=;
	b=fMMs7P47Kf+15xnAbaFPRW79Dkjfiz/TqMXDJqJ+oD1qitaega8a81aiotapjiEF6HN+0B
	s4i7JcQ777y65VOoj2xGz58bM40fsx3zNtUhDpW4pcgPWiCdzBxZew8dOD2g6gWxksiyN3
	E/5b4IvNXtyGtjRibx3o9Spr8aqH9BY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-qsy0_ZhTN--d4qnrHozE0A-1; Tue, 01 Jul 2025 15:34:46 -0400
X-MC-Unique: qsy0_ZhTN--d4qnrHozE0A-1
X-Mimecast-MFC-AGG-ID: qsy0_ZhTN--d4qnrHozE0A_1751398486
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-453691d0a1dso21222425e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 12:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398485; x=1752003285;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gw1ZFU7fseKrRoTgl7UAAoDGCdFd91K7Vdf4y+yHx50=;
        b=szexyxLql7u+DOjYaP17/1getOQP12KinWxKZqoXXRfqGZHlnIY2OrOZYwPtyfPKDO
         TgUAoEARUsHuCyIp4vWRAKjr9UoB+0l3HAzPquNs1TqEYLkaJwHGfpTvv5VT6qx02xnn
         ABhCbvGq/McNpPEh+9028ieU5nL3Om5TTR0qxoyNxn301Z/c2zvb26FKz+loy4azZx5i
         eqWoeJL+vz4h5eSYymPR7rpMAt5Y51NFjNRoVyzFoDN0Zwb+lcbUwQFcqvpgoiHZEKcO
         NfS02hDZqRqGQNoIp9itv8O0Ex/YeVrGgyHS2BcjlNsOU5kdLSV2Y5lRf6tFxPk8I9pB
         Y2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV6fSYTDor//ErT0/JvRsAsHPqhSs5MP1QSqmBqy2PXFSgdL6+H2k8/Vhdwd5lA975iVkjR6B58l3Shc5I3@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrtNLwnkHJZ1Wzu/E4uO9x1uZWGdiMFW32VyJOUme87d9fpfn
	8JlkOOeK3d14818577791vfVtdWFVa93juOJUkY5xGHs6iIuyzmeGTucA5QV4CrbHRC32vONmcY
	DVsZNGOr3pKqYcPUcVBWA7oaZbtePIWNh2eTlEKCGuP/M9m1Kc4MPr2Z7+7v6SfeY1wg=
X-Gm-Gg: ASbGnctsy+gJs2wgY/tXWzF1x5jKjRZk6ypPJ9Dsq7mpDaz1Swt/QWTQWPLg1rjtdWg
	6Nu/gia520ZpvQxotpsO7LQKngqQ2fbyci5wj4d0gIw3nG2U1wQS3fQcED4EyXAeDsqWwqoWYdi
	q7ugcXUpdb7GAcuwVf/QLGmKqCiBdkGg3cxibcXX4ZAiNbAHDm6CSXwv2S76nNRC8NZXg8RDKND
	L0PjL46drZWwpURKBfci+p0s09gHROXUIKg9BycYJTD7EDPjQcNSL7mGJs4F+mWrblRXfm3vfuv
	Z2OTyxi/05HmCDcYJMRGEWIxQg4kC7Mlj9h6558RoOKePtJehpdpenn/5Vnwan9/3UZzMLxWm31
	VRwwupKJfCYsx2eB40q2XQl38C4NzpjELx8cTSIK5stPc49dtxg==
X-Received: by 2002:a05:600c:1549:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454a36d8d1amr4351425e9.3.1751398485596;
        Tue, 01 Jul 2025 12:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhEuTg4M0PQbefUA1jZ0F5TAuHLHbTJ/BFBL6Gk20G74uE8iX4U0pj6is7luyXAnqTfNAkbQ==
X-Received: by 2002:a05:600c:1549:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454a36d8d1amr4351025e9.3.1751398485099;
        Tue, 01 Jul 2025 12:34:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c57d7sm215278035e9.40.2025.07.01.12.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 12:34:44 -0700 (PDT)
Message-ID: <ac8f80bb-3aec-491c-a39c-3aecb6e219b2@redhat.com>
Date: Tue, 1 Jul 2025 21:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 23/29] mm/page-alloc: remove PageMappingFlags()
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
 <20250630130011.330477-24-david@redhat.com>
 <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8ff24777-988a-4d1d-be97-e7184abfa998@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 15:02, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 03:00:04PM +0200, David Hildenbrand wrote:
>> We can now simply check for PageAnon() and remove PageMappingFlags().
>>
>> ... and while at it, use the folio instead and operate on
>> folio->mapping.
> 
> Probably worth mentioning to be super crystal clear that this is because
> now it's either an anon folio or a KSM folio, both of which set the
> FOLIO_MAPPING_ANON flag.

"As PageMappingFlags() now only indicates anon (incl. ksm) folios, we 
can now simply check for PageAnon() and remove PageMappingFlags()."


> 
> I wonder if there's other places that could be fixed up similarly that do
> folio_test_anon() || folio_test_ksm() or equivalent?

I think you spotted the one in patch #25 :)

I looked for others while crafting this patch, but there might be more 
hiding that I didn't catch.

> 
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb


