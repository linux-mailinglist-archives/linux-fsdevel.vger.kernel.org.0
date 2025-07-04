Return-Path: <linux-fsdevel+bounces-53965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F7AF940B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 15:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FB63A803F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAD2FCFD1;
	Fri,  4 Jul 2025 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu135VJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C682FCFC4
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635362; cv=none; b=QYm0wHf8ahxCbCfMwv93wHAAeEfbt/7Mivr0OaSru4P+LcDOLgcnXYixTDtGDfA+Q4zqVLyk7PuMKGzUG/uEd88ZO5AhqVS+c6eTi1whYu/O1+LzxS4vfXHgCAz+Ww75UQPXWwFsKKsNstIAnfZwqXp7c3zsxc31xVX3KC6Rb04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635362; c=relaxed/simple;
	bh=NZwEDTKG16s4GLu3/3kVH1yKX1Wi2eX9GJGCc1Q3C0E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P/saVarVBDnkbUqAhVvFHORmfp9igV7DGmZGAapo5Ic5lrGbA8EfZFdvHnkjd7Yr8gTrOBvzfOlO60hp1CwzGyzkyvDu85RPPXaiS1TpLrveGCFpUusSnHg9w+aVytv8zEGACO+i+VpRbHjdZjTkbB/qfLBoR71JPMFgl/aq39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fu135VJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751635360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iS3p25tHU3RM4I/3CZVdnqBFJoVJz2HfsGdXG6RAfbg=;
	b=fu135VJ8cBm1lPRfgLKh3luJj1wqzmPmCb0DyOTheUuJqOWGOVBF/c2rQs1tkepTxkf/Cf
	9nIjPgNpHgKghi2TTXW4NHO/doDMOjDCbJxe8BgsMMgh6g91mejEq9+5Vzcpz1IRwf7tbw
	PnrNsw1BNwIx7juvmrcdOqi+jhCcQA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-vc-CYE-zMaeeB4ulTUp4ZQ-1; Fri, 04 Jul 2025 09:22:33 -0400
X-MC-Unique: vc-CYE-zMaeeB4ulTUp4ZQ-1
X-Mimecast-MFC-AGG-ID: vc-CYE-zMaeeB4ulTUp4ZQ_1751635353
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d5600a54so7710945e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751635351; x=1752240151;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iS3p25tHU3RM4I/3CZVdnqBFJoVJz2HfsGdXG6RAfbg=;
        b=cUNy8SBkbhhSJWz+rWCPBKiz8jI2ZCXseBgs9DL6CECLpbMUPFosNxn1384Uw+uXt2
         dr/Zy9Zmy3FHphgJex+VAZ8H4dl+BEiwSpCKCM+DEG6r+fgioD2hzP/M0VZ9Y57gkgZD
         YYOqcIvXr37RDElNC0Uik7zO1QIpUeWzb9xFfvnsx68Bdl2OeSKi74qYzlv7OPz74kfU
         DmNUncoIDgBUODIUdSgsZucjPerbTa7sciFV7VrqQJrpIMNdvPd/XYtwrt48HY0wOEqH
         Bimk/qbJgCKSf7X3EVXn/zgJ1LULm8jlESbtNJWwa+p06l9VrOZmYqukm2+KF4+qYqyo
         TflQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9QF7F5jKpY9NrSOZENuwzR8JOongTz6aNiI959C87cfpffACGgMyoEKh56xFHGIrVlUFpoGeyTdzORm87@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoENFc4FaKyiwwCRmwdVk6hBFjyyOnkOQ3V7Cvn3RrmRbJJFZ
	UMxF3V3do9Z5JVYdVWzyTTKcMLjEmLoNR/FzE421hFMzWb8GQMBTa6fSaP2HWLUgH7HnLErNRDL
	CPbxcGAVhmIZixK9xJDquuubucJ0LVptdxO812AqyrNDsVpKdYnFb+nu5bLC7TQY6TS4=
X-Gm-Gg: ASbGnct4MtWeXHxpHwMNbXDenx1f2xjFgogiPjGhpHgAF1R6zoKdGM8MmpKFOu/bp69
	ie/pSrPRbVBWn4KTQnU8Z4OBWELl3ZOHOsJv/mISxSNOrDTXoEEbgne3VosOm2N0d4UF7CzbpX0
	FbpgKjoHTZz2KVSy/K0CUaVdZGiMrw6z+tI1dNxU696RUClEfX6oZSCFkO1/h6A0ysR1ZhhQJxM
	eR+jbOKLbI8ZL1InGbqNi4+IiIWiBNzUEfjeR6/r3XChYf2IOrJS6k/HlxDRKexQvNOV0Bw6DEV
	JqQa7Qa4wLpma9uYCINP6tXOZfJmcBddoGz7ozIdAyWF0f29N13PlOonFUTjNMTLFR9P56yZMea
	SIknDH/dqqauImtfEuUhXGH7MS8oRWvDgv3jQwuJ2MJLf9VI=
X-Received: by 2002:adf:eb4d:0:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3b496619e79mr1937388f8f.58.1751635351405;
        Fri, 04 Jul 2025 06:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRARbbUWKXhwf/Qzsz+yNJbGOJQ/fx81Tbz4PDE6rtFVVnp8zr/goOYhsUspYRzJ16F+5PYA==
X-Received: by 2002:adf:eb4d:0:b0:3a4:f787:9b58 with SMTP id ffacd0b85a97d-3b496619e79mr1937351f8f.58.1751635350955;
        Fri, 04 Jul 2025 06:22:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bde954sm54847765e9.33.2025.07.04.06.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 06:22:30 -0700 (PDT)
Message-ID: <36a8f286-1b09-43bd-9efa-5831ef3f315b@redhat.com>
Date: Fri, 4 Jul 2025 15:22:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/14] fs/dax: use vmf_insert_folio_pmd() to insert
 the huge zero folio
From: David Hildenbrand <david@redhat.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, nvdimm@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>
References: <20250617154345.2494405-1-david@redhat.com>
 <20250617154345.2494405-8-david@redhat.com>
 <cneygxe547b73gcfyjqfgdv2scxjeluwj5cpcsws4gyhx7ejgr@nxkrhie7o2th>
 <74acb38f-da34-448d-9b73-37433a5e342c@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <74acb38f-da34-448d-9b73-37433a5e342c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.25 11:03, David Hildenbrand wrote:
> On 24.06.25 03:16, Alistair Popple wrote:
>> On Tue, Jun 17, 2025 at 05:43:38PM +0200, David Hildenbrand wrote:
>>> Let's convert to vmf_insert_folio_pmd().
>>>
>>> In the unlikely case there is already something mapped, we'll now still
>>> call trace_dax_pmd_load_hole() and return VM_FAULT_NOPAGE.
>>>
>>> That should probably be fine, no need to add special cases for that.
>>
>> I'm not sure about that. Consider dax_iomap_pmd_fault() -> dax_fault_iter() ->
>> dax_pmd_load_hole(). It calls split_huge_pmd() in response to VM_FAULT_FALLBACK
>> which will no longer happen, what makes that ok?
> 
> My reasoning was that this is the exact same behavior other
> vmf_insert_folio_pmd() users here would result in.
> 
> But let me dig into the details.

Okay, trying to figure out what to do here.

Assume dax_pmd_load_hole() is called and there is already something. We 
would have returned VM_FAULT_FALLBACK, now we would return VM_FAULT_NO_PAGE.

That obviously only happens when we have not a write fault (otherwise, 
the shared zeropage does not apply).

In dax_iomap_pmd_fault(), we would indeed split_huge_pmd(). In the DAX 
case (!anon vma), that would simply zap whatever is already mapped there.

I guess we would then return VM_FAULT_FALLBACK from huge_fault-> ... -> 
dax_iomap_fault() and core MM code would fallback to handle_pte_fault() 
etc. and ... load a single PTE mapping the shared zeropage.

BUT

why is this case handled differently than everything else?

E.g.,

(1) when we try inserting the shared zeropage through 
dax_load_hole()->vmf_insert_page_mkwrite() and there is already 
something ... we return VM_FAULT_NOPAGE.

(2) when we try inserting a PTE mapping an ordinary folio through 
dax_fault_iter()->vmf_insert_page_mkwrite() and there is already 
something ... we return VM_FAULT_NOPAGE.

(3) when we try inserting a PMD mapping an ordinary folio through 
dax_fault_iter()->vmf_insert_folio_pmd() and there is already something 
... we return VM_FAULT_NOPAGE.


So that makes me think ... the VM_FAULT_FALLBACK right now is probably 
... wrong? And probably cannot be triggered?

If there is already the huge zerofolio mapped, all good.

Anything else is really not expected I would assume?

-- 
Cheers,

David / dhildenb


