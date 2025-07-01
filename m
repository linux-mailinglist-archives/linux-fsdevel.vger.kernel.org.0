Return-Path: <linux-fsdevel+bounces-53488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0611AEF888
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B8C1882702
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E9273D9D;
	Tue,  1 Jul 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZwujR4n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCB273D60
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372837; cv=none; b=kJ+SkleGlEjEUqHCnk9MT5b+4Jweq0MKHdAntlvPs0hOAvW+pB2eeW1d3G44v5goa1njlCbeWwbi2zskHkUQdioybFbZEUIrRB1y7Zbtyez13zyTKzeIlGi28n/gz2hZateVQHJs7m+y3AOiV3zFfFwSiJfNL791puSpJWTUzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372837; c=relaxed/simple;
	bh=j8plwK2r2sG78eupDPTV2+LjtVXteF6QvQSBw1+y/1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShgEdQX/5Ngq2G4hBmVvW92tDels2CG4GidOL+Hg1wb6/YsvpDdXm8l5Huw0MkzapJ1+4R+IKjZ8M8P2Nxl7dK7JnyX+CI0VuY5H+YFtenTjUWpw72gB8L11Nk51U/FW191zSCDUrgsJM4huUF18H/lKMtBJ3dxoAoSrEkWU5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bZwujR4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751372834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FEHfRalLuIEVVtsEsS9C6ifi6aMXwZRzg5zr/B5tJXU=;
	b=bZwujR4nGDTROJ+A44j/vKfT2fGw+bK0Llvb4Obsl93vIqY7EQISzJsDeodQ1AIgyT6mlc
	9tVzB5X8dOFoRZA8El1qmE2SVockiNi/cdNOcs6SNmce3+z2w6uI6oFJaL/GonFtSBtjbj
	/EwKbBnw6VR5jy9zkjOmGb/1Jv726Zs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-qrBK446mPAOsDNlHeBUhbw-1; Tue, 01 Jul 2025 08:27:11 -0400
X-MC-Unique: qrBK446mPAOsDNlHeBUhbw-1
X-Mimecast-MFC-AGG-ID: qrBK446mPAOsDNlHeBUhbw_1751372830
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso26761765e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 05:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751372830; x=1751977630;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEHfRalLuIEVVtsEsS9C6ifi6aMXwZRzg5zr/B5tJXU=;
        b=UrDsLqQVS3AKOr0XHbK2/Vs/wySdit5INjnKM3lRGWxyoT7KgdvjVgv97pgYcO6pyr
         V5MnzL1WTy7ymgzWodPHCpEVmJ7dqQqzzQc+F/wkvS4GEkLQ+f3XW23AoeZZoXxnlLvJ
         YOlKKbau9tRGZripTlUJvC0KGAtmU98+zZIkb7wG+viRdDtogLE949RvFQQ4dv1hDWTF
         sqVN/pY3YWufexdpatoBvvMHTOT1QBL2wwp2C51g5RM+f22HccWKE/MsnVPO0bU9tvQt
         xkWmsqIsgtc5s2Fpor7xKKP1zsplI2rRsDtre4zWMpF8OH7NISBNLUaFh2WBoFvhyjvD
         B99w==
X-Forwarded-Encrypted: i=1; AJvYcCXkthZWxtxbydMZ/Xfb2isEvOr/6lC/ektsjnE5v/aTqAyN2jHC1bCPqtiO3JNqDQHtkhzC0HvK6nUvg5hR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1U1sG1OaYQBH/kLnqHWAnVGD9iW7dmqv/nLReBDJIXe1lYMbK
	QsJW/f83T3WPNuv11i3g8UmFzULW0L22qCULgr+nzhqjKBewjwCRP2HSZZW1lSQaF+vqd5m7P+r
	4vZkXld8lTiuKxwYM611cOkkvS7BGol/YDhVc91Qr1MkC7fx/76VmNj75xZI1GhRjzvo=
X-Gm-Gg: ASbGnctkNmhnCchuspItvK2Twi3CXUdr08fjHJPbm1rgjtnTU8+HAuT3Si4qBQnzj0h
	2XDxFbmiuIGwBXNwUct9JvZCRf/bvv2EIZUJIooqarqT4pV+zj5SHnnFyNpzm5YLecsUHP6yEiC
	PJi6NnfaqXQOZALeq15tj5AdA56mpmIM+qvXhchpIDgiRrChc2V8SXMo1LznAusarmNryQSvKtY
	XvJc/zVsgeCW7Y8R+Rhq3dDJ4ZvGaF03uTkiPKOb7Fs/eaLMEs8qJExwwmt49IT2fNfVxzWybJl
	bBJnc1D/be6gubXT+wESIL9OzugfXgUeODJnXjs8VTvW+MVSm/fXOMM8TWR4zSR7PKWN7JHsiKL
	nxwQqsH9JS/C2I04vF7GLnp6fhT2sQYCwDluatNzwjvDg0cyKug==
X-Received: by 2002:a05:600c:4fce:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-45390259d15mr148237445e9.6.1751372830021;
        Tue, 01 Jul 2025 05:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJU2Sf5R53h48rrobFaZHNRWjQKFRP9ItDNhMojifotwoNth3ly8lc9eWoZidBApRccIuBQ==
X-Received: by 2002:a05:600c:4fce:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-45390259d15mr148236605e9.6.1751372829433;
        Tue, 01 Jul 2025 05:27:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:7500:202e:b0f1:76d6:f9af? (p200300d82f187500202eb0f176d6f9af.dip0.t-ipconnect.de. [2003:d8:2f18:7500:202e:b0f1:76d6:f9af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a421434sm166408505e9.37.2025.07.01.05.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:27:08 -0700 (PDT)
Message-ID: <04e99b47-055f-4555-be11-76afb2065b0c@redhat.com>
Date: Tue, 1 Jul 2025 14:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/29] mm/migration: remove PageMovable()
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
 <20250630130011.330477-16-david@redhat.com>
 <38e19e3a-e46b-4a50-8a34-dc04fc4a3c3c@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <38e19e3a-e46b-4a50-8a34-dc04fc4a3c3c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.25 12:50, Lorenzo Stoakes wrote:
> On Mon, Jun 30, 2025 at 02:59:56PM +0200, David Hildenbrand wrote:
>> As __ClearPageMovable() is gone that would have only made
>> PageMovable()==false but still __PageMovable()==true, now
>> PageMovable() == __PageMovable().
> 
> I think this could be rephrased to be clearer, something like:
> 
> 	Previously, if __ClearPageMovable() were invoked on a page, this would
> 	cause __PageMovable() to return false, but due to the continued
> 	existance of page movable ops, PageMovable() would have returned true.
> 

"existence", yes will use that, thanks!

-- 
Cheers,

David / dhildenb


