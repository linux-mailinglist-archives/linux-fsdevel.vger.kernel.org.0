Return-Path: <linux-fsdevel+bounces-62609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509FB9ABCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480F37A3D34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F13112DD;
	Wed, 24 Sep 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Li7G/Rgg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B8224B1F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728348; cv=none; b=Ddtk9zUp/djv8GrugV843JcmhzeWHzY6d8/emBk/v+GfjZQhyiF75ho5+QNuQXN8e2KzcIFj9OtsL/3nudkaxTZhHMpODHhRt1XRwKnRED6S3M6RCLSMNPe/cwuJN6gMbsmx5GmQTHtsdUPR4iW+xjXlb3qv/AXlAUqZtE8gDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728348; c=relaxed/simple;
	bh=UsXqmKWvjG6h1YBmLwPbbkwWjuTwnzGRTj5iHBI5Ud0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCd+W/e4/NUnKCH1ldx9igluwW6lh+MYHaZPY8F2gujVswJJSQNxbDVz+TGphhDij/HBllCTu/zzylCecnBclMiiFYCyawT6WwFOv33mOkaaTEbC/Yq3RQlob1zUVIisNOggLOuxrFnrGSK48yy8YT6DRdy9nvN0k6Riq/MpsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Li7G/Rgg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I3hnbNQr+CMB/T5Lrt4+Z4OuC6HJ7S7MgiA4J3LQveE=;
	b=Li7G/RggJt17mc0PEbOTrxTRTuPHDXxNZEDwvnW6YLbO2+5it+pG9SV8Euo1HgojPh5Au8
	g6vCVZoeTgOXbjW2egPLShc3oDiUYrou0cX/DHJl4O2ODRrPl2OCprPd+B07GdGvsm3CUx
	EpZ8fGU01SbzT4Oc3CHZYF1DAaO1jLg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-c7-KANr6NsK9rOIU0lA34A-1; Wed, 24 Sep 2025 11:39:04 -0400
X-MC-Unique: c7-KANr6NsK9rOIU0lA34A-1
X-Mimecast-MFC-AGG-ID: c7-KANr6NsK9rOIU0lA34A_1758728343
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso6013f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 08:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728343; x=1759333143;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3hnbNQr+CMB/T5Lrt4+Z4OuC6HJ7S7MgiA4J3LQveE=;
        b=e1t4JqcPZjnB7V9fzX2MLv5+ssheI/CfEu+8VNjiskipihUMenqP7NoJlJdRd+lStH
         VQeBsOYiDnGkeCQtXOlMOmz0J0Ddi9oaDp3JIe6SIrJ5dOPuvunrn/kZJPrITeP5as3/
         xCktNgC6ZurhG1Uc2BOwVXyAwOATEOLVivW6g2vWdPAnxHgFRLC7GfZevLczGpatFLJq
         c9BKZRNGUCg2TPzmdnSuf16XcA1mjPNsoyFOGQVRpruzHXiqxwyu00YPgYJcsnx02GNA
         CU3WstkFSOWGa0J9/2ubqCSLvov742eBbzj4OVYGJd7AbyzlyBKVEJjSFIR1ABwYIrEO
         NA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQu6IeK0mEGJd44aqeAWxF3CavyKj/f3myl+HuACvgdVbfrunNhMTDLIQkjIBG6PzPNwn7FNcI1vsx04QR@vger.kernel.org
X-Gm-Message-State: AOJu0YwHz8G1VI3Hg2CKWUzzT42474gxy1g84clVEeXk5LKkgXvB9KoG
	YOIMbZfqhlXvHTxTRyg3Ab7SM9cDocAOogvkgL03YJmItbqe2hrpEhkYZWX8efvUAAUj8LQDzKe
	j3BksPRjNmaKQ9hJ3ckmPEdBtkIqilJrCB5WAoycbJ2uzdAEU78omEq9SQtbeiaJpKvU=
X-Gm-Gg: ASbGnctGNyieeHT9tg/aTJURvvARkeg+OH/fqmJNKRS9vWT8k5ql6BweEUTx653rYIw
	FV4C6XOIQwRMtj2N4W1DtoBWVB2Arf9No0MTuZUsC3FhA0wjZKSrfX8qahnJmN50OoOnrQw7bGL
	/Vn1EiMTxCsm61qNiX+AFVW3j2ra+8yqhqbqSqCeTNz0NF7QA2Gi+Rt24M5nzq1/Uf0rje7pACO
	1JHn8rMTW8dllR955gb15Sxkzg32z3n93Qfzn06bB3UBYzTRKjTShCIUJBHLskw4A+scvp8joy1
	3CM2hDMjB2i78lzvQfd8+MmmBta/PnHZ4O57vihyCEUCqzSGuhvTrNcdsHtx8oCjhSrcQm1LeFO
	Fnyq9CMbfRGx/ufEchud6rhbmWUFIlziyJ37C/RMtesiey4Kq65GA77IK3cwJQcncFA==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr389101f8f.32.1758728343195;
        Wed, 24 Sep 2025 08:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgd4QFIbHl+KGwltRD/ttCSG+TyRobItnmS8e1jCrWLoT42l4oEjJc1CeO+4N34B2hOAK5lg==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr389052f8f.32.1758728342727;
        Wed, 24 Sep 2025 08:39:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d68sm28588947f8f.10.2025.09.24.08.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:39:02 -0700 (PDT)
Message-ID: <be77e0e7-4cb6-4a10-86f2-50e8d001fd84@redhat.com>
Date: Wed, 24 Sep 2025 17:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
To: "Roy, Patrick" <roypat@amazon.co.uk>,
 "patrick.roy@campus.lmu.de" <patrick.roy@campus.lmu.de>
Cc: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "haoluo@google.com" <haoluo@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
 <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "maz@kernel.org" <maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "pfalcato@suse.de" <pfalcato@suse.de>, "rppt@kernel.org" <rppt@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "seanjc@google.com"
 <seanjc@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "song@kernel.org" <song@kernel.org>, "surenb@google.com"
 <surenb@google.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "will@kernel.org" <will@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
 <20250924152912.11563-1-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924152912.11563-1-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 17:29, Roy, Patrick wrote:
> _sigh_

Happens to the best of us :)

> 
> I tried to submit this iteration from a personal email, because amazon's mail
> server was scrambling the "From" header and I couldn't figure out why (and also
> because I am leaving Amazon next month and wanted replies to go into an inbox
> to which I'll continue to have access). And then after posting the first 4
> emails I hit "daily mail quota exceeded", and had to submit the rest of the
> patch series from the amazon email anyway. Sorry about the resulting mess (i
> think the threading got slightly messed up as a result of this). I'll something
> else out for the next iteration.

I had luck recovering from temporary mail server issues in the past by 
sending the remainder as "--in-reply-to=" with message-id of cover 
letter and using "--no-thread" IIRC.

-- 
Cheers

David / dhildenb


