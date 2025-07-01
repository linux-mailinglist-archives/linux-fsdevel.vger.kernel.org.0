Return-Path: <linux-fsdevel+bounces-53492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA3AEF8A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64673163E64
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F882737FC;
	Tue,  1 Jul 2025 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdrzATyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BBA273D94
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373186; cv=none; b=hSiDjN+dd2ARf6Q1MkIFRPLVUZP4tcDvUcKEM7dwzjE2O8fkGAU9l3mE9cmN6tqQnbYxOys3SJRXcQg9dRQOtyIAOX7o+pNVEEUyh6aoDS33wxg9SlRBiGv+4lFcwlBapAZn9yvJ9XZVYTQuN+mLEtLqwEZNCAcnuZoTWO0FPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373186; c=relaxed/simple;
	bh=tYS24wJ/ZygJypnRqai0RUZfkPVzuZV7u2V1HBFArdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9qXQOw6t/qZ3iHtsBdISRzZKMZ9y5fXGD2Bp3Z+JbZBzoKKeSJmnVaU3dkSDc7sHMkdYV9+3tF9C8EqZq6HkADrahDFVGxGwIDnRJ0SIz9/Gp5nbOJapGpMBRlxAiEkpO2alWIpCwOXRQVgrqge3De84IcwXHPH6b3bCZTeSTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdrzATyv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751373180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OR91mEGkMa2yCFrvAiHztYA9Wztvn1Uq6wRsfBUeFUM=;
	b=UdrzATyvB7ckg4OZ5tby8Y6A1Jo2k0mqtg2sybWcx57z6OPyWRhVmIot1zY2rg3Mkm6FC5
	tzlRjg5DeXhY75rw0H7JcN7GKXaCeI+ilgfx5FrjvbClxF/AGNmfV5/xQoq7eT8MKYXQnM
	QSalyrSxoLS94iK0WiER3wkc6SnZEp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-3OHvN3m7N4eODPU4l7Sndw-1; Tue, 01 Jul 2025 08:32:59 -0400
X-MC-Unique: 3OHvN3m7N4eODPU4l7Sndw-1
X-Mimecast-MFC-AGG-ID: 3OHvN3m7N4eODPU4l7Sndw_1751373178
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3af3c860ed7so446802f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 05:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373178; x=1751977978;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OR91mEGkMa2yCFrvAiHztYA9Wztvn1Uq6wRsfBUeFUM=;
        b=WESQ75rNHWPdtzFLA3T+MXzGMQPCE92SS64FXVXhokZVpyqKxEBNTts1IiRmkxTTVa
         JBmjBkuz3n+iRxyseYNakIMpZElc+OqEG4IsBJPT4cc/W4Xz499C4h/2qCmq9Z8IE2fn
         eJdp5H5pbvqR/lnPI1zzIgYl6J4LmKj4AYHl4FMaXsFuUOuFS+L4Msq4UTa7qlb/Jg9/
         pxu2Tni2Z5GFgnFZJ2u2kV7kMVhTbKXl5tJMrMyNwDnmcUoYrTSlwV8T7zr/Ilc6U4h2
         tnh7zWjld62opXLalI35f+ZjUXy8lSq9L/rxUjUn+sLgUz7RtB3I82tnPSOQQK0ePmDQ
         w8RA==
X-Forwarded-Encrypted: i=1; AJvYcCX563UfD7PStSdWvrSAuXxSjCYlkIMfga1wNr0xqKkhqHXykbO8UnzoZMdQTy/xafFsHp9o3efcRaNGOpWn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0nRufL2XyZP/W8gL3lB/f7HN6/wf6VG5FgIvgKKCrvVUuw1H
	USErtpH/b0Iv2M9kjzkJ6vTzbxNh9ymUD+dPoKHRhL3ABtxSk3IyOn9vSg7Y+l1/M7AgIxV0Gjn
	PAAsTtQV4KNvNgNh3qb3UyVpaURiowJJS+4s9Ak48XJZKO68k4l6c7afNaRIhJfhBOjU=
X-Gm-Gg: ASbGncsGtbydoU+mrlYOrTiqIl1AdOaqCwGjvJGXV4vJJTgiNaoCd9fTFWVfu/jydId
	VQVQedqHiXVSN4PXFYDghxBhxXLgnPI9H6IuawYkTDTHCzXnor6wKVSwQSi/2Fec5oA11Dl9b0k
	lEO5aM25pSFAiB4bOwXNeaso9TnDg7Mq1QYdDv5HyTvpM0OrRCYLzwGUuBjywamcZgab5RKSnBQ
	hX/FysddQb9N5+oZv0ycZ71Xp/EO8hTbZS1NR+EMik2KrC9ieQP3D8tBum3RsTkvbBRkRlI+QIi
	gnil45wmk8v8u3gOMD4CIE45fw5lxdBWSDAXDBw4LthKGRZg2NcSnwjmtvQ/OARVOb16GdblSiv
	7DhjIMiiEFLEArcRtwh+1+hzMqbNaO84cQk7lya0Gos+mjuvIog==
X-Received: by 2002:a05:6000:290d:b0:3a4:e6d7:6160 with SMTP id ffacd0b85a97d-3a8f577fcbfmr16647744f8f.6.1751373178193;
        Tue, 01 Jul 2025 05:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC873mhnHelwGYjy/m3rNK9Ibu2sC1O12YJHOM/HlS1eRR+SrB1I6GI5EE27+IZq8Evrx0mQ==
X-Received: by 2002:a05:6000:290d:b0:3a4:e6d7:6160 with SMTP id ffacd0b85a97d-3a8f577fcbfmr16647677f8f.6.1751373177623;
        Tue, 01 Jul 2025 05:32:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5aesm12986831f8f.44.2025.07.01.05.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:32:57 -0700 (PDT)
Message-ID: <d9761308-8a8d-438a-b4c7-7ca3295fa0a4@redhat.com>
Date: Tue, 1 Jul 2025 14:32:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/29] mm/page_isolation: drop __folio_test_movable()
 check for large folios
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
 <20250630130011.330477-18-david@redhat.com>
 <58b36226-59ff-4d8b-a1f3-71170b42b795@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <58b36226-59ff-4d8b-a1f3-71170b42b795@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 13:03, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:58PM +0200, David Hildenbrand wrote:
>> Currently, we only support migration of individual movable_ops pages, so
>> we can not run into that.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Seems sensible, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Maybe worth adding a VM_WARN_ON_ONCE() just in case? Or do you think not worth it?

Not for now I think. Whoever wants to support compound pages has to 
fixup a bunch of other stuff first, before running into that one here.

So a full audit of all paths that handle page_has_movable_ops() is 
required either way.

-- 
Cheers,

David / dhildenb


