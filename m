Return-Path: <linux-fsdevel+bounces-53311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A151FAED6E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BD81899ADD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 08:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D42376F2;
	Mon, 30 Jun 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtM3SejE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6331E2858
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271399; cv=none; b=DYA53QrOJ5xZaoHozrrIEvbJu/zL+Ircqk9YKhblCTyfBu2dACYtS3pZSmKdSppCu+nGbjwxRymdLaQOjGjcAOOqMN414GA2zVKEdMk17VDE4Jx2kWcoT93KizdapS7Fovz+W7fvwR4AIy9dLlemitF1ByEBXiSo8JYyWySgJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271399; c=relaxed/simple;
	bh=lndIK4MUo3un6mjaLebNKYXjJFS6m/SQ+ummaiD617Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDv0RQ5q62uLwocRfS0lnpxBwOZWv7EGWV4Nt+3HjSJdZ9WKqVrfj3/CkLZbIjy/R493sTT2Mm+k5b8KfhtdO/L6NPoUMOuTGv33OqbmzkrdLGqOL+zULvsxhb8eQq67tUVLJ9H0rzLMPYUxF0OBddBhxfOkyi3L7lsZ+yLTm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtM3SejE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751271395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6VPcb/KjKOGdw4gPzPctO4cFLASxj6NEbu79fmEsFHY=;
	b=ZtM3SejEYG78ZUfPFIIHo9N39i46PCEBp40OQTRKhzt7uA2AoT3QGBJs2CFgqq7xl3HU8W
	fhMEmoYb5qvnDiVBYCLvY0E/1ZgQRHCF5f+O5/U1DHI7NR+0safMmyMu6kE/2fA5G+Q0nP
	a8T3fhmB6dVuHqFUv8GE+vc2nZAL+hw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-UDWqhM_oNTywQcy7esKaXw-1; Mon, 30 Jun 2025 04:16:33 -0400
X-MC-Unique: UDWqhM_oNTywQcy7esKaXw-1
X-Mimecast-MFC-AGG-ID: UDWqhM_oNTywQcy7esKaXw_1751271393
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450df53d461so15294165e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 01:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751271393; x=1751876193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VPcb/KjKOGdw4gPzPctO4cFLASxj6NEbu79fmEsFHY=;
        b=lyAvVTefcc9dHZZeaSvXXp+2xR5wod8+7tLXaBX0s2L2nCL5jQLjAEenMe5GVhwPeT
         DJXMBlRu3VWIpCvFTh/uOPLus97gw1m1IhhgD7NSyiwTsV6Yo7RvmE8LlE3JI4PHMPd7
         uJe/Jwc5QbfwKhLJxteHZI7+qqJ2+9T5tpXPO9icCZcVrIRAAMc+LxCGo7UZjzdqh5aR
         XFLJ3ILF+tSU7ZXPw5tSdstpHeUe7UfmkUhGPubIN7uuawo2G6WJx5cRqBHOpB7bWlmr
         tgU9bbNXrJh5oia8jjm3v1ylLST7l50OE3gQRX5PQEoryynsEs7w9HHgibeDTb1LRNRz
         Ss0w==
X-Forwarded-Encrypted: i=1; AJvYcCX8SWt1ZnoLpxZw9yUIw9lfiv14qiogQz5cJcPn3dhMQOrRqNPXxrN/XUCRG1cV06uVBcvZ2opklp9e8Kz3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Lo90iawVPMKAHjifEuQ43IkuxL39eDCD8lvCynf5pMq5fCR3
	+B7cd9KglkBtJrhXNlCFBG3d6UCohu3TrvzKiPPyVgaeQy2FXz6vGhpuoI+M8qvhwjkuDmQfLMC
	SDXxcRRaH02JQaO5btK0feCmwL5McTGY6v+Q6E4cjlhzaiFbMvUpXi0CH6+wjglrMdbw=
X-Gm-Gg: ASbGncs2Ci7xWYi4o7hazZ9YrVqtbzSzoD1Uu7FTrtXaSlGObQ5cE9D8LqtYyvlQ3Vc
	Zud4C3RMXRYXxdX23TyE93PDKTvMDYSxJ5qN2JQBvV2B/8POCMTE3m6gdZuAu2vovYZVlMwkFes
	Z437+UEY38e4pbSL2+Ny48zTl9qzWUDuGmAmjWItCVlqSzBvF3kRB8rfZHZhUyVQF8uyV3CAIzy
	7m4CtpTZhxMDjF6lA1v9sGxwQT8ia6lI7mYgf+6sseZucblLpG4P+koJk8ln8ftUEPxOAGIsRcS
	lUhtYYWNdz6bU+/Wq8da5xA/0T3Dkt77Ft2wJ6Q+fU2XYtGzHqBJDkkhj/IKTE0iN8pyF8Lza+W
	WSukBcXtWEKZi7CFzV9h268IHD25XiD566mqX+/TzM5iYwa4sDg==
X-Received: by 2002:a05:600c:1ca1:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4538ee70c4amr100852595e9.20.1751271392592;
        Mon, 30 Jun 2025 01:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQl/WnpHN3yTrdW2FOwkHhUK3NtUpbFqlzDb3P/Ebo20sSqdyuNoSbnHSjaaA1DLihH3PoRg==
X-Received: by 2002:a05:600c:1ca1:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-4538ee70c4amr100852195e9.20.1751271391970;
        Mon, 30 Jun 2025 01:16:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e598ddsm9681774f8f.78.2025.06.30.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:16:29 -0700 (PDT)
Message-ID: <1fee1926-638b-4852-b98f-a0423a94b7f8@redhat.com>
Date: Mon, 30 Jun 2025 10:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
To: Harry Yoo <harry.yoo@oracle.com>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
 Qi Zheng <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-8-david@redhat.com> <aGJE3r5uSzRj8BsR@hyeyoo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aGJE3r5uSzRj8BsR@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.06.25 10:04, Harry Yoo wrote:
> On Wed, Jun 18, 2025 at 07:39:50PM +0200, David Hildenbrand wrote:
>> ... and start moving back to per-page things that will absolutely not be
>> folio things in the future. Add documentation and a comment that the
>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>
>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>> it gracefully (relevant with further changes), and convert a
>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Haha yeah, back to pages after folio conversion :P
> But makes sense.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Side question: In the future, maybe we will be unable to tell whether
> a page is compound or not, without first inspecting page->memdesc?
> (e.g., struct slab could have an order and a pointer to the head page...
> just imagining).

Right, it's not really clear what we would do in the future, but for 
anything that allocates a memdesc, that is possible.

We wouldn't even need the "head" + "tail" bit indication.

For things without an allocated memdesc (e.g., PageOffline), maybe 
compound pages will simply not apply.

Likely, the concept of compound pages as we knew it will go away.

-- 
Cheers,

David / dhildenb


