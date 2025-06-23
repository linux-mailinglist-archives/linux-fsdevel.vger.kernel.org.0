Return-Path: <linux-fsdevel+bounces-52622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A7AE48DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219274457D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4C276049;
	Mon, 23 Jun 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzPo0Ke6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22138566A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692804; cv=none; b=ZRN/KI/aEhdt07sm2bFS/RV2HcYjnfcIi7bmyqdk5PVniydY/zmZWuZrgIEkuLbmGBsf0yeTuBnr8bKI3nnAT0NhvJSLLUxeiU20Lxms6tOYBe14EVVu8m30h258xkiCkW2FLWxkQ5gGMFJuXRF80PG2dJMKHM3Gce676ZAAYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692804; c=relaxed/simple;
	bh=pVYWUUtxxjRs+wa8zf1bcU9rpSdWdx+QpbNmNwl8dnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cgSwuUaPyg0EovHydTM2Ue5EZftZmTKknbtTM51iR13PF57nHFQWVvgmgOarx91kx8mrFs3kqvIoHf0lOsiA7zsUnWZzl+xtppbo5U6hVx/3r8Zu7tTDc9Au5YaXTDgGv3l1ZNEBpCesz7UNqh4OmTADmyLjCP+HwtTWhLKAySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzPo0Ke6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750692802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VMFE5XFmCnZwpDxXjyOQUDgj/ACDl6iF3epiv58I+/k=;
	b=LzPo0Ke6Z7zJIzVrWZBbAaU4hoo52mcrLnXV582z0iTQVJildFqoMFEyZe5mQsj/UnsM/e
	bimbbIpO0CAn8HBvN7WBBlx8m/SO0LSD0+5pYwgpAMumqD/1B+axH4nLp+8NMWel1xNZQG
	LCMbTV3rWKeZ0gW74ZqSGnQsxlUjAZY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Re6ovBJ-Px6IhlvvBj1Edw-1; Mon, 23 Jun 2025 11:33:20 -0400
X-MC-Unique: Re6ovBJ-Px6IhlvvBj1Edw-1
X-Mimecast-MFC-AGG-ID: Re6ovBJ-Px6IhlvvBj1Edw_1750692799
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so1645771f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692799; x=1751297599;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMFE5XFmCnZwpDxXjyOQUDgj/ACDl6iF3epiv58I+/k=;
        b=K5Ze69tNxFhEfKL5MIGT8Wvdk62Z6PvxAjJhGqMQO0tOoWmpbtDUnhnNXI3jqaPF/0
         UhZWwaDVoLg3TcGpvLWtH3kor+SUx7oqBewm0wxFIUtqz3+BeFJpZekQ+E3SEBnQqG/w
         77ntjOWmuaCu8QLR55KbL/bMWVUkpMnrYhIdF3y4yMv7CpvA+8u7kFPh+FpDGGMTip0D
         EedBu/rHhTK6o6o1drMv2YWt6KjQMjXowlI6LkUibkVeHoYEyF75IrqBrFpX5l/DWXfO
         QedrqknH2y0WIRfFnPu20TgmhDcKFm6wgcoPtSQ/k3RsDcYOMY6TsZEbOFRzI6nmQA47
         3i5g==
X-Forwarded-Encrypted: i=1; AJvYcCVtwUaQk1cK2NOIiNnREYQ4HMVyoPRNrzequ39uWg1PJUURgn4b6dpU3kC0Kwil/YNg31V7KL4sj8ydNDTk@vger.kernel.org
X-Gm-Message-State: AOJu0YxBv9gw6qaPyn+KZdpRof8gQUvFPFDLVelrYaUIGf6ZPc1KIVVe
	FdoZv+H7UtBzkvgdnsCRFdXtqj0rxajWQ5HJnVFPx6nI+rsK6oPzBpqmqGQ7F7M+ohMS6ZaahPL
	hgmMM2gA+buZulNX8+9mRzR03Iu4/u11C9lvCmRefQxM23dHmTmV92wdo5JvlDW5lBDY=
X-Gm-Gg: ASbGncvSMAXx8KYSuS1lkQiMb8tSuPMrtkwbEy8wViB3GJuGbcKSIBKqJuXlhTCv/GE
	wRjpAkJB11BEUyWK7VZGIssSyR/CBeZ9ZZENynczCJelsuJnoz+tsZfvxtDjf+fr9tsF61PLKib
	ZQgT+8D7f1MIYFsvH3klgN+irzXJVB1bX+4RU/anGTQ3fKFtw04I4QfNN74oOzlPBpaom8w1wWX
	zWTZkHhgxtWUChLqNKNB5jC1RqM7ULuKy6hKfpW1ISBdZf0YbJps7t0/mjVOKU4JPrZIaLY9vy2
	ow4U1jkQPv+IpVp1SlqCPsIjDyPsLOZdwrbJiaMQubVVH9C3w0tbgUGYHM1eMUNoFmhVBwzbbma
	eyCMf4tB4wKLpV56Rf7Zyg/79Hcqzn7ybfQcjE2t6AWEqKhNZ7A==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a6d130453amr12674301f8f.36.1750692799192;
        Mon, 23 Jun 2025 08:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE85hMTnbdKxy1bT4Kk698V7XUcW8rVuxvFEPAA18LssuPVWWrj7O2eHAW4gMzCB9Bjo1Zu+g==
X-Received: by 2002:a05:6000:387:b0:3a4:edf5:b952 with SMTP id ffacd0b85a97d-3a6d130453amr12674261f8f.36.1750692798755;
        Mon, 23 Jun 2025 08:33:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f18152sm9522292f8f.27.2025.06.23.08.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:33:18 -0700 (PDT)
Message-ID: <bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
Date: Mon, 23 Jun 2025 17:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
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
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com>
 <9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
 <aFMH0TmoPylhkSjZ@casper.infradead.org>
 <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 20:48, Zi Yan wrote:
> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
> 
>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>
>>>> ... and start moving back to per-page things that will absolutely not be
>>>> folio things in the future. Add documentation and a comment that the
>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>>>
>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>>>> it gracefully (relevant with further changes), and convert a
>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>>
>>> The reason is that there is no upstream code, which use movable_ops for
>>> folios? Is there any fundamental reason preventing movable_ops from
>>> being used on folios?
>>
>> folios either belong to a filesystem or they are anonymous memory, and
>> so either the filesystem knows how to migrate them (through its a_ops)
>> or the migration code knows how to handle anon folios directly.

Right, migration of folios will be handled by migration core.

> 
> for device private pages, to support migrating >0 order anon or fs folios
> to device, how should we represent them for devices? if you think folio is
> only for anon and fs.

I assume they are proper folios, so yes. Just like they are handled 
today (-> folios)

I was asking a related question at LSF/MM in Alistair's session: are we 
sure these things will be folios even before they are assigned to a 
filesystem? I recall the answer was "yes".

So we don't (and will not) support movable_ops for folios.

-- 
Cheers,

David / dhildenb


