Return-Path: <linux-fsdevel+bounces-64840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B96FBBF58BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BD364F8D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855232EBDFB;
	Tue, 21 Oct 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iix255DA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE728F948
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039484; cv=none; b=MmN6sngiZOuRaeleB8omgO4sPyIbMH7ywhIuxvkYeeIGFWc9kblp+lJZr1WKymRz1e+KImBaaghYwloj5+1U8N1Efzx/+hC2lphAyiGCdzRMxHuj772+MyqQMrKeJgwWxBNyKXA/NnXbgRrm0LOzNtHLYn6TMsS4TGTnKqqU9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039484; c=relaxed/simple;
	bh=zUZDzYUzg+3AsTA8LAr9g0v2trX8HOm/b8KrBIdgeds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmEjR8CG5OCCJdbYbQIq8HgRKTsK2kWDrDh5ig17c6iPOL4qLlrJULj5snjO4tuJ/nc3/ryudEUIQllBT5j1aedYtcxNdd2sMreDYGO6g2SH/kuW/uPEykUSvMJyVugLa5AZmsFXJAWgyLMYqfQpoumy0qQfpL6+S3J1c8XgIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iix255DA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q29DhQwTAK6dd4ZAsLxjzERt3jbFaX1obxxBjr33yAU=;
	b=iix255DAkt9Qhi/juZjA/HLtadKQr/yphHU8ziCXBzMSkl2njyZv91xraBq7pLTkzZhaln
	OS6dNaS51IRA6KTio82QK3xWqyPYeUNsU7s9L9oBDZDr/hfOhgXrhlEoAPa34PGfrlExY6
	rFJdDA1r/EUBB7WY2QACpSjE27EPO5I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-8UtB7wy5NZqtLSck7I02Hg-1; Tue, 21 Oct 2025 05:38:00 -0400
X-MC-Unique: 8UtB7wy5NZqtLSck7I02Hg-1
X-Mimecast-MFC-AGG-ID: 8UtB7wy5NZqtLSck7I02Hg_1761039479
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so6198983f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 02:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039479; x=1761644279;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q29DhQwTAK6dd4ZAsLxjzERt3jbFaX1obxxBjr33yAU=;
        b=jZ0uFp2pnel3b4UvaSwZJs2joP4a5mk6olf/S7mYsmBPvnq7sJmnjQIM2aRLJqM26D
         ech2aA74mX8iYQI8jecGIHTjuDRRqrZ+nk0xlY5qh6K2ZUlcJJmFyaXm6X7F34QSvpXI
         Xd9TYNEk63HoKH/L9bQrcdVgqV68AGOkDYHXSAjqbJbQFmWk2TlwDpgv1O4w/PM49IWZ
         tkX4LM3RDZcdXQfgCnZ0QDyNm+X14f7/jRZvBwZNsDocBfVTqqksgKNq++k8euKoX0qC
         gihUCneObqgvicWwB3ZJ1zXS9ALsSmQ5Pv9AZp6W/g//JUhsX0wDLonzwBONbYusmLZa
         0dZw==
X-Forwarded-Encrypted: i=1; AJvYcCWEJwOG5Kl3cyneTbZmOpxwEzFGh4ddGV9OczTXe/Pef6670/bKH6//Wv6e+3eJmWXXgMPRE+uO5Me1tmes@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKBsBZO6V1S0Gv2Ili4pUxo4kG53g7HoFLySrmZfcDwxy98c8
	qkFrRruG73yEJgLa9HrSoIU1QcVKMOxKQ9UrpfpLiQp89Kq4m+P6M2VYnvOuDO57xB3M5h/b+j0
	2cz1Ox1XBzVB8b03Lux9a94/2qYSoRb6RhdJV0h8dWAYfu6vaTNaMrP0jf8umVFWtTzc=
X-Gm-Gg: ASbGncsKqSvI7NbQB2UBdBTwS536IfEP4v8UDs9xcQ8OnH2ImehwaDhNDqUmK8wqoP9
	bknvoaeeLSf1lJWutRyz3aA8y2+hpB2EYQhyTS9hpO3SIPVFo4gU75Ts34z1Za3poFgWW/cImIi
	qzQUzU73Z8H7FRc7oyNtesuawpmW4MW3N1W8q/lzJFELcvbYMNwaJ3A3jmi6ULkeS+LZ5JYhtqG
	yZsgH2wf2VfkzijcycJMJJuLmyBmVAmAJ083lUwWZM+/XsdBXH+8I9Mk6u/Es7eW9lAu8nlfmWZ
	O6kqioe7mxrrag8/Zjhge0EYr7ZO5ws87qUR50al6cdu+OZYu9QEw1nPEp8A9i+LtGbUZy6aJo7
	kav9YuK7SvrLd4+jJf9ceFrBiDEO7F5fxke0jmr1VJwbIyyykmf0eab0fgzmewnMAeI0tS+aV3/
	jOxaZhLGBnone6TnzZ0MVWZOGphRA=
X-Received: by 2002:a5d:64c4:0:b0:40f:5eb7:f234 with SMTP id ffacd0b85a97d-42704d442f9mr12220842f8f.5.1761039479083;
        Tue, 21 Oct 2025 02:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKruvi/TAKluPv6cz2boZrb3dbhZ+r79GGju1INC+ReltJyDrEtS+cBV3xo2qL/hT92CNu2g==
X-Received: by 2002:a5d:64c4:0:b0:40f:5eb7:f234 with SMTP id ffacd0b85a97d-42704d442f9mr12220818f8f.5.1761039478657;
        Tue, 21 Oct 2025 02:37:58 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm19610031f8f.9.2025.10.21.02.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:37:58 -0700 (PDT)
Message-ID: <750cfcac-e048-4fee-bba9-6e84edb7bbe0@redhat.com>
Date: Tue, 21 Oct 2025 11:37:57 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, martin.petersen@oracle.com, jack@suse.com
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
 <aPZOO3dFv61blHBz@casper.infradead.org>
 <xc2orfhavfqaxrmxtsbf4kepglfujjodvhfzhzfawwaxlyrhlb@gammchkzoh2m>
 <5bd1d360-bee0-4fa2-80c8-476519e98b00@redhat.com>
 <aPc7HVRJYXA1hT8h@infradead.org>
 <rlu3rbmpktq5f3vgex3zlfjhivyohkhr5whpdmv3lscsgcjs7r@4zqutcey7kib>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <rlu3rbmpktq5f3vgex3zlfjhivyohkhr5whpdmv3lscsgcjs7r@4zqutcey7kib>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 11:22, Jan Kara wrote:
> On Tue 21-10-25 00:49:49, Christoph Hellwig wrote:
>> On Mon, Oct 20, 2025 at 09:00:50PM +0200, David Hildenbrand wrote:
>>> Just FYI, because it might be interesting in this context.
>>>
>>> For anonymous memory we have this working by only writing the folio out if
>>> it is completely unmapped and there are no unexpected folio references/pins
>>> (see pageout()), and only allowing to write to such a folio ("reuse") if
>>> SWP_STABLE_WRITES is not set (see do_swap_page()).
>>>
>>> So once we start writeback the folio has no writable page table mappings
>>> (unmapped) and no GUP pins. Consequently, when trying to write to it we can
>>> just fallback to creating a page copy without causing trouble with GUP pins.
>>
>> Yeah.  But anonymous is the easy case, the pain is direct I/O to file
>> mappings.  Mapping the right answer is to just fail pinning them and fall
>> back to (dontcache) buffered I/O.
> 
> I agree file mappings are more painful but we can also have interesting
> cases with anon pages:
> 
> P - anon page
> 
> Thread 1				Thread 2
> setup DIO read to P			setup DIO write from P

Ah, I was talking about the interaction between GUP and having 
BLK_FEAT_STABLE_WRITES set on the swap backend.

I guess what you mean here is: GUP from/to anon pages to/from a device 
that has BLK_FEAT_STABLE_WRITES?

So while we are writing to the device using the anon page as a source, 
the anon page will get modified.

I did not expect that to trigger checksum failures, but I can see the 
problem now.

-- 
Cheers

David / dhildenb


