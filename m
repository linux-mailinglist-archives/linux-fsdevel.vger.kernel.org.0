Return-Path: <linux-fsdevel+bounces-47789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8CAAA57AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768054C5EEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B9221F20;
	Wed, 30 Apr 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5SxxCSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D54220698
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050303; cv=none; b=nkN+coO8cLazDCRldrPN5QufQBdEmKqyEDrkmn2shp2d3xfrN7d0oUJUhO2XRNc0bOEYqO+qjOisc7bvmZaiOFJv/ribUnIeTBOScpv00fVw9hHSFtprQzUByLoTuwbENHpvCixmuElyftr7npOEpxloidaatQxDouVZ126BZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050303; c=relaxed/simple;
	bh=OSlLfiT7oPSVW0Vhu/WXB7k0cz6UDEiznLAGwSMZ3m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhSXwDNQEi7i6mRwQ0z+0Xsu7xlFslTnV1/UTwqzcn9F7/1Y5JF3SJihf9ZF7QGNeMIsvrDKe5djv8wP6zBMkBYdGE8b0GIdgqjo8cRnaLuu5ULurqZ3cXTOr6V5Qx+YzuMxjQKVEBg10HvPNXyGkParMato72mpIuGXmBWxbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5SxxCSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746050300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZAaCJDVeUqC/iRZsZzcfKKZg/z12nJeHt7AWXEHu+W8=;
	b=K5SxxCSg91mgDaA/l5FMOiWk9Jtp0Iuu4Hz/Xfcad5HmYh30n8t7gpdb8kHhkfeQRTjldn
	TUWZrxVvup1fIzb3Bh6eHsBcf86iim8usVDEkxH3oLN2g4MLxVEtXXL2eTGpzEM0jum2pu
	rEUu16z9RxrqoQgjGE/OCw0c04Ytj0I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_B_FlyXoOxGj6xMqjVfKlw-1; Wed, 30 Apr 2025 17:58:18 -0400
X-MC-Unique: _B_FlyXoOxGj6xMqjVfKlw-1
X-Mimecast-MFC-AGG-ID: _B_FlyXoOxGj6xMqjVfKlw_1746050296
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39126c3469fso71013f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746050296; x=1746655096;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAaCJDVeUqC/iRZsZzcfKKZg/z12nJeHt7AWXEHu+W8=;
        b=HS6gS3RZvmMfszjXwuXfw8dkJ3svbSSgPF19fLpr+a0cEtQB8rQH9pFPxVswzXNQRZ
         z5GvlNzk/mdH01JBmGdBrHw+TIWBPFbqz/8XbTHPsB7IJOaH6mwgty1w8Ish0+PT3UJn
         3m96ZBagjE2JtseGiMomS0Uo1mMZNLBp5Vx4lNHPd4shP2//ePcye/QNm0nJHywdKkkN
         q0fia7bOXJ3mZZVtEEso9UMqC8Cj5IAx4eUztorqVSJzT8wS+eaBw7v8d8Iu42U6bS4Y
         rp9sBdEWVR0vgsuPNSol/PikACVA3+DuY+f0jEVsl4lyvdaFk9TpyJZ5RMgqY45uIsh3
         2S2w==
X-Forwarded-Encrypted: i=1; AJvYcCWVjgoN2M1arrFjzaaQ4uRdd8i4nCngl8st30bykXZfpESsWkTNZScjyBvuB27HmK+lAUUNSlgXJu5U8Vf3@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHZsGPaelu/n4jt/I5nJs5rdvh6YseMtmOdnrHB1EJjopqTA9
	qyUs8DZ8G2E0OuEIqQ1+lCDqjn5JA7wJBZqwZPLVsp7kAgQh3sjw3r0DxVEWLd+zNZxhe3M3kIQ
	JFvuoWYw9nTlAvHv8NFf3EhSfvqgw5dMJOyy7mOg1JCTXW+Xzh9T26j/w4H9X3YU=
X-Gm-Gg: ASbGnctKQhQT4QO5nzCBBksLz37AeBdlf1VVl2hjOKmgz9QdbDizKgXjSE3j+FK6TIR
	8bX6fldn6uFhvTRL7ISTQgrz1lDbmhQxaFeagXuWSH5VR54KIBXAVCSE7yjaUAmNF1CZXBvZOnC
	m8yZq+pUH4roOHzssMXGP1ydLO+oIRVuSKrtHY7sRUCeCqFUhi7abfmofrmhs+ETeyxaNypB3+a
	cknz1hpwNACmncNLdQzEfDJC4kSEdr8F2X42Tp+z2Nm6g8+/SeGhXK1MQQj8K0S78ns90IqxTRb
	vmQ71+A0jL8+vEhYNFpYjWjURyJO2W1eCEepSVx62w==
X-Received: by 2002:a5d:64a5:0:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-3a094053655mr72094f8f.33.1746050296028;
        Wed, 30 Apr 2025 14:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIUfs9wV073mQDXRyQLoTF/v/RVuHpOr0Qx8MhdARsvRHVgQY3znuEKqA1Jf53XmKmX6ViRw==
X-Received: by 2002:a5d:64a5:0:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-3a094053655mr72076f8f.33.1746050295698;
        Wed, 30 Apr 2025 14:58:15 -0700 (PDT)
Received: from [192.168.3.141] (p4ff231f0.dip0.t-ipconnect.de. [79.242.49.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d264sm18470464f8f.95.2025.04.30.14.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:58:15 -0700 (PDT)
Message-ID: <7ab1743b-8826-44e8-ac11-283731ef51e1@redhat.com>
Date: Wed, 30 Apr 2025 23:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 21:54, Lorenzo Stoakes wrote:
> Provide a means by which drivers can specify which fields of those
> permitted to be changed should be altered to prior to mmap()'ing a
> range (which may either result from a merge or from mapping an entirely new
> VMA).
> 
> Doing so is substantially safer than the existing .mmap() calback which
> provides unrestricted access to the part-constructed VMA and permits
> drivers and file systems to do 'creative' things which makes it hard to
> reason about the state of the VMA after the function returns.
> 
> The existing .mmap() callback's freedom has caused a great deal of issues,
> especially in error handling, as unwinding the mmap() state has proven to
> be non-trivial and caused significant issues in the past, for instance
> those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
> error path behaviour").
> 
> It also necessitates a second attempt at merge once the .mmap() callback
> has completed, which has caused issues in the past, is awkward, adds
> overhead and is difficult to reason about.
> 
> The .mmap_proto() callback eliminates this requirement, as we can update
> fields prior to even attempting the first merge. It is safer, as we heavily
> restrict what can actually be modified, and being invoked very early in the
> mmap() process, error handling can be performed safely with very little
> unwinding of state required.
> 
> Update vma userland test stubs to account for changes.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


I really don't like the "proto" terminology. :)

[yes, David and his naming :P ]

No, the problem is that it is fairly unintuitive what is happening here.

Coming from a different direction, the callback is trigger after 
__mmap_prepare() ... could we call it "->mmap_prepare" or something like 
that? (mmap_setup, whatever)

Maybe mmap_setup and vma_setup_param? Just a thought ...


In general (although it's late in Germany), it does sound like an 
interesting approach.

How feasiable is it to remove ->mmap in the long run, and would we maybe 
need other callbacks to make that possible?


-- 
Cheers,

David / dhildenb


