Return-Path: <linux-fsdevel+bounces-40039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6699FA1B5DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 13:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0378B3AF4ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B68F21C171;
	Fri, 24 Jan 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4uDDOIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96236219A8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737721545; cv=none; b=RwshOtHahXP4YeFj01LO2THnN/ONFsAtjGQgI/HU5lvSo/hneFevwVl92rZwbg3PF2dTkFhQlI6yRbr8f5F568qJHt8qCyMnPfxewAi9gLY5A/1WJ0M9cN7ajq+cc4oYghihCnp3lQ/85wHdkyuV0NDnOt/dLLXxrVGcve4QjI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737721545; c=relaxed/simple;
	bh=tSOdjQvnkKE2SiQJZJfv3ifHLujN7Z4RP2yxJ639uyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgx/kpl3+oujtp7mqEUzLxO8EDosNUiSAzMRx7RDfBtgIBp095m49vVP/FS7/2oiUOwqbT91jW0RrsyZTEb+mhAFPpY2GKO/Nz4JMdkvL9nH1WKGEWbB3CVnJYUjFAaeFM3knT2iuf/Hy/QvmkEFf5EWlAm4+CCVNHxp62nsgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4uDDOIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737721542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zjUPnPqwQtsn38P8oDRLLvhyfJeSAlU+KVCPgSa/BXk=;
	b=H4uDDOIw4WH9dGKf6aYJ0HewCl7PJ7n9+ShEitAx8MJnUFfg65UhK8mlcty6Cki9xeVRTN
	7NetTJMKuVokaRj7C7I6N5r1apIAyhcfN7I2uCFzpUZduNRctKOnjmgt3lJFNXZENA27gV
	/qqWVGzcPcwcoIVXaa3INVUBN08MiYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-fkTZiTPbPiWuI5vUM6kQaQ-1; Fri, 24 Jan 2025 07:25:41 -0500
X-MC-Unique: fkTZiTPbPiWuI5vUM6kQaQ-1
X-Mimecast-MFC-AGG-ID: fkTZiTPbPiWuI5vUM6kQaQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38bf4913669so1102726f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 04:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737721540; x=1738326340;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zjUPnPqwQtsn38P8oDRLLvhyfJeSAlU+KVCPgSa/BXk=;
        b=VZosQ1Vbynql6t05qoxbBSk2tYQgDN9HA6iMj9DjDQSJyl49tLpZ5P/yA+w8XoONyK
         ZuEJflw9epPMxNCzxn5i0tzgxsaVqdwi1KhVN0ECe6stdKQFNbPw8vY/hQ3vUmV2wEVp
         nuL72h6jlMuZe10one/UneMeObxhSKtOp/jX7vzMSaAyV/0c6YBmHdHoBEs6sZymn2wj
         uRPB1jxnGBY10k9pq3zQZGLAwfLI7BgIeLh5WUtT+TnWo1t43DkvXzMIXN7FGYT/GAyx
         SOk7SEHnA0zL58/AUaHh2T9GDnX94+4tmv1QqX9iEjqw9JlAglsAuJxxCCb+NKb2WHs0
         d96Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ57x19uMiCfoplN4HvWrNkGxJo0OSTcNUM+wh/FLePaFCh93ew2MohUMyN/WbqKyWK5g/155tCrS1Us8Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+sk6bINm9CDAU/91J6lLuA0LWNpYoinLTwWRdudxCRG/aXG9
	sRMNEv2eSDK+K+9k6LtRrXEyAceRSgO3UPAdj30dE60t8ajDAq7toFJYZjs7iCzdUJIMOAKWcgy
	VpXle8X3N86TzY+VdDLuT4OO6NBe9cWhtxwO0Cm9dxdkwaVJyrLsVs8GNZru0fg0=
X-Gm-Gg: ASbGncuPEgCfyzUFClojdeHIM00sYbf6T1Hf07fBkjmiCeIZPo+b+EUBZNfOd1+szyp
	gLySy+9ziEC1LwqlHKpF1RhX0M5nr9zRj0ZgZIXJwzIpAGKcVs3n5ZYmcjn02rPwx6Pyje0byli
	GOEOkEidFqETE2AtX/LsxSUJz36mbkPqtOt961L0mVRJdbFiSE0Vicro7JQDE8CP9L0y9+yZS2c
	h+58CZXwW4CfBzQaQNw9gmu/iDGnRm9hGnmLKG2XGKCE0EFbA3VYo7YpIVHP5Wkpm5NNCrDUkSA
	lCCgaE4kExOkjPZJ2zBrp2vGesbD
X-Received: by 2002:a05:6000:188d:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38bf565727amr29297207f8f.2.1737721540013;
        Fri, 24 Jan 2025 04:25:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8cpglXZKq/2pbfqaHxhlHxtSAPhi4uAk4FUS+ZghTNLKfixVg5FVB5lY0jdkfhN7pNKl72g==
X-Received: by 2002:a05:6000:188d:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38bf565727amr29297180f8f.2.1737721539639;
        Fri, 24 Jan 2025 04:25:39 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188fd0sm2597829f8f.58.2025.01.24.04.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 04:25:39 -0800 (PST)
Message-ID: <950a1ca6-0bf2-4aef-a6d4-b2a427c4ca54@redhat.com>
Date: Fri, 24 Jan 2025 13:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com>
 <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com>
 <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com>
 <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm>
 <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
 <CAJnrk1ae=ZFrc_5+m10Tde0TkcWU=cJK-ppy+-ss0Dn2bch2Tg@mail.gmail.com>
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
In-Reply-To: <CAJnrk1ae=ZFrc_5+m10Tde0TkcWU=cJK-ppy+-ss0Dn2bch2Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.01.25 21:51, Joanne Koong wrote:
> On Tue, Jan 14, 2025 at 2:07 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Tue, 14 Jan 2025 at 10:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>>
>>> On 1/14/25 10:40, Miklos Szeredi wrote:
>>>> On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>
>>>>> Maybe an explicit callback from the migration code to the filesystem
>>>>> would work. I.e. move the complexity of dealing with migration for
>>>>> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
>>>>> not sure how this would actually look, as I'm unfamiliar with the
>>>>> details of page migration, but I guess it shouldn't be too difficult
>>>>> to implement for fuse at least.
>>>>
>>>> Thinking a bit...
>>>>
>>>> 1) reading pages
>>>>
>>>> Pages are allocated (PG_locked set, PG_uptodate cleared) and passed to
>>>> ->readpages(), which may make the pages uptodate asynchronously.  If a
>>>> page is unlocked but not set uptodate, then caller is supposed to
>>>> retry the reading, at least that's how I interpret
>>>> filemap_get_pages().   This means that it's fine to migrate the page
>>>> before it's actually filled with data, since the caller will retry.
>>>>
>>>> It also means that it would be sufficient to allocate the page itself
>>>> just before filling it in, if there was a mechanism to keep track of
>>>> these "not yet filled" pages.  But that probably off topic.
>>>
>>> With /dev/fuse buffer copies should be easy - just allocate the page
>>> on buffer copy, control is in libfuse.
>>
>> I think the issue is with generic page cache code, which currently
>> relies on the PG_locked flag on the allocated but not yet filled page.
>>    If the generic code would be able to keep track of "under
>> construction" ranges without relying on an allocated page, then the
>> filesystem could allocate the page just before copying the data,
>> insert the page into the cache mark the relevant portion of the file
>> uptodate.
>>
>>> With splice you really need
>>> a page state.
>>
>> It's not possible to splice a not-uptodate page.
>>
>>> I wrote this before already - what is the advantage of a tmp page copy
>>> over /dev/fuse buffer copy? I.e. I wonder if we need splice at all here.
>>
>> Splice seems a dead end, but we probably need to continue supporting
>> it for a while for backward compatibility.
> 
> For the splice case, could we do something like this or is this too invasive?:
> * in mm, add a flag that marks a page as either being in migration or
> temporarily blocking migration
> * in splice, when we have to access the page in the pipe buffer, check
> if that flag is set and wait for the migration to complete before
> proceeding
> * in splice, set that flag while it's accessing the page, which will
> only temporarily block migration (eg for the duration of the memcpy)
 > > I guess this is basically what the page lock is for, but with less 
overhead?

Yes, the folio lock kind-of behaves that way.

One problem might be, that while the page is spliced that there is a 
raised refcount on the page: migration cannot make progress if there are 
unknown references.

-- 
Cheers,

David / dhildenb


