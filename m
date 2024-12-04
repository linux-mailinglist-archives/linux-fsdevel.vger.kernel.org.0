Return-Path: <linux-fsdevel+bounces-36487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B69E3F20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F86A2817A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C953210189;
	Wed,  4 Dec 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9iuDnc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498D20CCCC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327942; cv=none; b=H2LzdxROOiW81WSF51BiGySh/CRpBY46mOUOk1YaHdULP9HNi3WmHCKkCLbDsntqaImaMVB7BF9fKMbxpw+uutzpICPRqhRzLs3JaS6CzUIRPWFh8I8eY6X047zo7BDB9jom9Z/z/ZyqxTV7MO70SxBIof8838uPs2cNJahg9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327942; c=relaxed/simple;
	bh=MkIX+0Q7uVANQn1tUXSoOXDigaq3pzGNPuLxZollUPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fadCUDw4iloq1Oxj6ogdmpngAb9urK0MIvYizUrZYV66KYNyjA/2XQb6KTfB0LIWbug5hTD5MrwdtSBF/jC0NKOPBPfnmStCVnHGr+DYDqISLS5aYHTeBtFIx/+Vb9biNk+2Kp7fDmRDdgLzYHsLlVIq2WRGK7Yc8GcGXtYBCH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9iuDnc8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733327938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PKbyfYlEzsBujPEJXUvTgJm5gyk4gXBwn1S2KY6PxE0=;
	b=L9iuDnc8SdhvbPBYy/7F5qniOwSf7SbrFE0ZBFzdXaDToPjcmlOHVFme+asyEKjWziI05T
	T97sEsfQqNqqLcIN6wuL4Tkge7MHFIeuMMdaPsLMamlE0vCnZQPxi8YQnrNGOlTtI3RBfL
	NHE6DcGPMHyPCy8C/9xGO6U1BDXczZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WATwtdgNOEyNejTVLC8PNA-1; Wed, 04 Dec 2024 10:58:57 -0500
X-MC-Unique: WATwtdgNOEyNejTVLC8PNA-1
X-Mimecast-MFC-AGG-ID: WATwtdgNOEyNejTVLC8PNA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso57184045e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 07:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327936; x=1733932736;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PKbyfYlEzsBujPEJXUvTgJm5gyk4gXBwn1S2KY6PxE0=;
        b=SB58k3hrd6A9vsayOSYzg/l184GebtoJ+K2b9jljPdKMPSEXBecEjTB5TzC/vWhIFC
         TwU2E3cUQjbKmk98Gv9b+sqBDLbGUntKqVz3sSY0AVnbT0CD+gkIfY27iDz4h6QyOqpq
         FJAEhXTk9JhgTFRm3bABMNXY5aTUwCVRnTuRnNztO1xpsLZTcJmQmXGKMFsnfa7/Ta9u
         nV9TvTIiBwLgcB0XV2RhETfeW/zcZ0wO05V/BXr3y44antWxcwUW0sp5TezoZ/K/1L/d
         P0Fb+gdBhFWJJGbjQmReJjzxxuP7ENi8cQHYVBo0eTWDW+cNWk0hWf761cnbzOF1AyeP
         +qUA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzHP2TDuHw7fTkiQMuqf/HwgIf/rtLm77Abrd73sR1HH0mN4k0Z10yXqPLLW39ROWscfvB9Cm4kpV0kdI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2AaTzRChYVEx3MT/iHjw0M5izL8f1V+J0up+khk2Gz+4WfcAm
	cPdLuhGUUcInn075EL4lbwS2DFYOFy7vjf5Iyp8HW4J7G03DZ8N056VEDcpnEnHcy3Yh2xmlQnj
	xytU81xOyrViLqpxCB7x8b4e34u157jagYLiASi0DCyKCV0fNWLlWUadhKdSyJVB5a3WX1lAU2g
	==
X-Gm-Gg: ASbGncsSOvrAThdixNrjLzcP8DO4yW0eabQ001b1qnTNqAY3JBbY4WmT6zPAoEQECOp
	Mpiaw8acDwh+6+zftKZraL1kxZG5b7LrvUgzJFxa/IbhVNgx/vSITOZkVWt9nBTbVUUX8+GlCCW
	XvAdBwGqaMlpd4XTpJPqCMtR7YoTvKqGrVBs3etBzaYKBnSGS5bQ5IXgIZQNp8wVBHDD9heBMTH
	xdP52LvQ922De7zorrEn8mZsyl33K7NGGIfNCpvvv7WMwHKvLKEA+hEwU7Zm0ygQn4vdsWwBGaD
	0kD/Ni0WFzFtij+CmuuEDJAXdXQzt3ltvj1JhUCdobeMTEX/xn3LJKD3IQszcgEDNH4g1QdpRNO
	QLg==
X-Received: by 2002:a5d:6d0a:0:b0:385:df87:28de with SMTP id ffacd0b85a97d-385fd433607mr5947951f8f.56.1733327936064;
        Wed, 04 Dec 2024 07:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdOQUBULKzvFzkHWqPRGxc1LuUQ7T34ds9Ipq4JMMTeGrEwEobbTL5YAOMuZklHAw/mSdAhw==
X-Received: by 2002:a5d:6d0a:0:b0:385:df87:28de with SMTP id ffacd0b85a97d-385fd433607mr5947932f8f.56.1733327935659;
        Wed, 04 Dec 2024 07:58:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385faec0c9dsm6142889f8f.20.2024.12.04.07.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 07:58:54 -0800 (PST)
Message-ID: <cebb44b2-e258-43ff-80a5-6bd19c8edab8@redhat.com>
Date: Wed, 4 Dec 2024 16:58:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Removing page->index
To: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <Z09hOy-UY9KC8WMb@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z09hOy-UY9KC8WMb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 20:51, Matthew Wilcox wrote:
> I've pushed out a new tree to
> git://git.infradead.org/users/willy/pagecache.git shrunk-page
> aka
> http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/shrunk-page
> 
> The observant will notice that it doesn't actually shrink struct page
> yet.  However, we're getting close.  What it does do is rename
> page->index to page->__folio_index to prevent new users of page->index
> from showing up.

BTW, I was wondering how often we convert a page to a folio to then 
access folio->index / folio->mapping and not actually having a folio (in 
the future).

I suspect this will need quite some changes to get it right, and I would 
count that as "less obvious".

Calling PageAnon() on anything mapped into user space page tables might 
be one such case, for example.

> 
> There are (I believe) three build failures in that tree:
> 
>   - fb_defio
>   - fbtft
>   - s390's gmap (and vsie?  is that the same thing?)

Not completely (vsie (nested VMs) uses shadow gmap, ordinary VMs use 
ordinary gmap) , but they are very related (-> KVM implementation on s390x).

I know that Claudio is working on some changes, but not sure how that 
would affect gmap's usage of page->index.

s390x gmap is 64bit only, so we have to store stuff in 8byte. gmap page 
tables are

Maybew e could simply switch from page->index to page->private? But I 
lost track if that will also be gone in the near future :)

> 
> Other than that, allmodconfig builds on x86 and I'm convinced the build
> bots will tell me about anything else I missed.
> 
> Lorenzo is working on fb_defio and fbtft will come along for the ride
> (it's a debug printk, so could just be deleted).
> 
> s390 is complicated.  I'd really appreciate some help.
> 
> The next step is to feed most of the patches through the appropriate
> subsystems.  Some have already gone into various maintainer trees
> (thanks!)
> 
> 
> There are still many more steps to go after this; eliminating memcg_data
> is closest to complete, and after that will come (in some order)
> eliminating ->lru, ->mapping, ->refcount and ->mapcount. 

Will continue working on the latter ;)

-- 
Cheers,

David / dhildenb


