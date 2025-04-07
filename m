Return-Path: <linux-fsdevel+bounces-45891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B97A7E2B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4376C189BB8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80F51E1DF4;
	Mon,  7 Apr 2025 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHQgICTf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C821DED5F
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037219; cv=none; b=HcbP5MT58eII+dujKfaPKpJJk4zwGjXSYXCTJtm+vjpkg4V34mFJcxFMNaREFnrgG6YQoasChxmO0ZPWMdYvwluLEQ2pQ6eTTz5gYYiau7T3lkjnFC6gZjIjpGeTrxXs+ac5u5FelQ4PJ36MkHdMRswCNJeuHUite83fwvsgMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037219; c=relaxed/simple;
	bh=W2t77E0tmbGgfvb+IN2IWQmKxzIvGnpJmucLEFBRxzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tBv3UA53uUh/Mc3MkjPx53E5YYbr2D/Mm6TUd6ZtM6jTmtq5MZef/8aun9jDLoKoVOqb14m/SwvAWc/i8Alu7xdGKFjMcl9szJHVg/lZJG/UAaXjLyleHCRlpsVv/S5kMmj2TDJADJ2YGqaRmSFvqmwhQTVsKgL9NzEOFydzi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KHQgICTf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744037216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+JBzs/lfPTMTyDZad0L+1TztRElX/AUHjw0pErz4yOQ=;
	b=KHQgICTfBazRwxbYA1W+4N/rbjzsRLVsyI6+cXtd01mYIUceGynpo3lxojpxgnHyRXg6kw
	YA2UPEoBNWcLxhvDGNk7d2RDvyITUF/4z4ZeyoUq9GnD6lGsrwlXBdmr+e+XP2rnsGZ3rM
	P2/e5dcmtUCcfouKgV1CBT+gaDykNWo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-8Rx203h6P2e_PGyOXZ8dKw-1; Mon, 07 Apr 2025 10:46:53 -0400
X-MC-Unique: 8Rx203h6P2e_PGyOXZ8dKw-1
X-Mimecast-MFC-AGG-ID: 8Rx203h6P2e_PGyOXZ8dKw_1744037212
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf446681cso32287685e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Apr 2025 07:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037212; x=1744642012;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JBzs/lfPTMTyDZad0L+1TztRElX/AUHjw0pErz4yOQ=;
        b=mNzZj9FGGp5YCY2kqf9DRSDu245+u0HwKlQiaeK8rWiTpB0vu6ygGdz43KsFI0dcM3
         VOs4gIZmLmA8lv4QPcs7G1yV34Iprf3gV2b3xbx7CaFdK2mA7KNYFdlYkk5jQo+UnaWk
         xuJuFQdYlBiNBSTqBSS9fO6sqXNzw5LbcSlIYKCFz0nehnAQxkP0k81wb1ZJO/Nh5RA9
         WXWHrJF/LFlRewTBdtG2b+b6jRGLJ5V8wz2YkBxksUDbBjBmA6J8lqbdqLFhgUIEyQ3C
         8HLkksZ+hhGVkkuy+5ex522QfD2qJZMjwXZQcpIKEK/7nziZffJzXnraRAnh1kKzs/QZ
         6GUA==
X-Forwarded-Encrypted: i=1; AJvYcCVYkEcLThhWJ7zCTKgCS0fQMi3ULNjqZJyf23qQ96jnHILRWNuTTSb0U7Ragr2zcUtb0b3XMyUvpXUdlnts@vger.kernel.org
X-Gm-Message-State: AOJu0YzIB7SP4JQZsTPL91JmrtAB2heKvoZueJcXkz+YCQLnJHv+3TTF
	fy6CYvNMLSseQBVTvbly2bPChJOJrLWOf2t/nqeEBNuiDwNeSIN50wDtne5/DlAIbByHNb357s6
	WL0eA5Eyy9udNtcY5YpGjMo7+86rt5ArxxNdW6yqykfL0KAobdEVeXHgzSjQLrWA=
X-Gm-Gg: ASbGncuizfCo7/N4Syy7r1ttCcniUpNtQXO8grlNdbAF6rbOClR+fozzYgfSdrAOfLV
	lhUu7N3Tr1VEkmToQAfmYnP+osYD/pqosYK6d1BPSKhhstMlcdj8LJgSSvWJNAj87Of2otWRYaW
	vDTo9fW8uaWRs+uTke9oeZnF3Iwi6ZREkybi/jGrIYLsX1PsjAay+3CSfPg5FnrcDXDGimAid5+
	kB57BvC4z58wpUWshmKArFVjGn4WxNVx/+BWc43WOcvSIhrtUF90G4Frl5GpSwU/yHl49wVDX4C
	0w8ruy01tC32bpjeojVk+i8cJgVr0iNYllsTgUGLf+p5u2zBIF+yAZhSM6qKz1tUARhcJ52o66t
	5ESW2ONdCgAE+gNwlj04Z1r/H3lfcizr0WMoGSjCoisc=
X-Received: by 2002:a05:600c:4fcd:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43eda5d4356mr89961925e9.6.1744037211693;
        Mon, 07 Apr 2025 07:46:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkMDYiysHhg4FAH45/4sqicxO4DSMEK914rVRpEQcqCPyzF4nOkGiqDPxNFvJdev5DmLnpWQ==
X-Received: by 2002:a05:600c:4fcd:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43eda5d4356mr89961405e9.6.1744037211224;
        Mon, 07 Apr 2025 07:46:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:3c00:8b01:4fd9:b833:e1e9? (p200300cbc7383c008b014fd9b833e1e9.dip0.t-ipconnect.de. [2003:cb:c738:3c00:8b01:4fd9:b833:e1e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec36699e0sm132802575e9.35.2025.04.07.07.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 07:46:50 -0700 (PDT)
Message-ID: <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com>
Date: Mon, 7 Apr 2025 16:46:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nikita Kalyazin <kalyazin@amazon.com>, Ackerley Tng
 <ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>,
 Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org,
 pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, muchun.song@linux.dev, hughd@google.com,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com,
 jannh@google.com, ryan.roberts@arm.com, jthoughton@google.com,
 peterx@redhat.com, graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
 derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
 <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
 <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
 <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.25 16:24, Liam R. Howlett wrote:
> * Nikita Kalyazin <kalyazin@amazon.com> [250407 10:05]:
>>
> 
> ...
> 
>>>
>>> All of this is extremely confusing because the onus of figuring out what
>>> the final code will look like is put on the reviewer.  As it is, we have
>>> issues with people not doing enough review of the code (due to limited
>>> time).  One way to get reviews is to make the barrier of entry as low as
>>> possible.
>>>
>>> I spent Friday going down a rabbit hole of patches referring to each
>>> other as dependencies and I gave up.  It looks like I mistook one set of
>>> patches as required vs them requiring the same in-flight ones as your
>>> patches.
>>>
>>> I am struggling to see how we can adequately support all of you given
>>> the way the patches are sent out in batches with dependencies - it is
>>> just too time consuming to sort out.
>>
>> I'm happy to do whatever I can to make the review easier.  I suppose the
>> extreme case is to wait for the dependencies to get accepted, effectively
>> serialising submissions, but that slows the process down significantly.  For
>> example, I received very good feedback on v1 and v2 of this series and was
>> able to address it instead of waiting for the dependency.  Would including
>> the required patches directly in the series help?  My only concern is in
>> that case the same patch will be submitted multiple times (as a part of
>> every depending series), but if it's better, I'll be doing that instead.
> 
> Don't resend patches that someone else is upstreaming, that'll cause
> other problems.
> 
> Three methods come to mind:
> 
> 1. As you stated, wait for the dependencies to land.  This is will mean
> what you are working against is well tested and won't change (and you
> won't have to re-spin due to an unstable base).
> 
> 2. Combine them into a bigger patch set.  I can then pull one patch set
> and look at the parts of interest to the mm side.
> 
> 3. Provide a git repo with the necessary changes together.
> 
> I think 2 and 3 together should be used for the guest_memfd patches.
> Someone needs to be managing these to send upstream.  See the discussion
> in another patch set on guest_memfd here [1].

The issue is that most extensions are fairly independent from each 
other, except that they built up on Fuad's mmap support,

Sending all together as one thing might not be the best option.

Once basic mmap support is upstream, some of the extensions (e.g., 
directmap removal) can go in next.

So until that is upstream, I agree that tagging the stuff that builds up 
on that is the right thing to do, and providing git trees is another 
very good idea.

I'll prioritize getting Fuad's mmap stuff reviewed. (I keep saying that, 
I know)

-- 
Cheers,

David / dhildenb


