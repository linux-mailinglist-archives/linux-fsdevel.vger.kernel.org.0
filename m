Return-Path: <linux-fsdevel+bounces-46992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7052A9730A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E224403C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859C296D3E;
	Tue, 22 Apr 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmOnqjPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7927C875
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340562; cv=none; b=KKv/VWXzYdco1j+CUa9K7A4AAj1gDa2epuz8yo7OE1jnLdnPYG5kkf4BVd3HxXbj7R0MUrpSD3uNEUZwRAfjRy0ewlzWjbS/+0BmjjNoCtCC7n3PngFfmEfUe4tnOtOsLhpWVXeX3LJoeQ1xH5WOPxe5pv2rxAzeRqFqpkpZMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340562; c=relaxed/simple;
	bh=1zm/ifLFoyueirmbO4F+dQ+4rpCflNI54FJ6BvufTFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRKM4K9wlM8ia7UKTbyTLhwdxV5rc74ZCifNcebJn4QqVycClSgciQCsFOSkSIar5nDIKxW93OzsUyuyv1O54mNecmmBCApaaPt3RJ+J/hCXL+bWgBabRi4KA4jGvX9Fg0NADSZ5ipQOBVJ4/8Wx2080NgfkNxqm5xhHX341tog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmOnqjPG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745340560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lHSkROXmhzxaxiTJB2Sts+hoXg6Enh4N97MVVPj8jow=;
	b=WmOnqjPGVzWbnJPowlkSPUgG6iyBsT77pl4jPU9QSdEHvrX2wSmvfejG11qdxsMvzm9tRL
	1mSmTcECkPRpQc+nt+84YfnGem+Gdy7KcqR+sDvVZ97mmF8LvzpPhEjQmLrNdg/vkbJmoC
	FpWbORfBy2vku7/bYfcj5/pnPqyMR0A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-LljaVU0xN7CdqBkXjdM4MQ-1; Tue, 22 Apr 2025 12:49:18 -0400
X-MC-Unique: LljaVU0xN7CdqBkXjdM4MQ-1
X-Mimecast-MFC-AGG-ID: LljaVU0xN7CdqBkXjdM4MQ_1745340557
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912b54611dso2710248f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745340557; x=1745945357;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lHSkROXmhzxaxiTJB2Sts+hoXg6Enh4N97MVVPj8jow=;
        b=UNHAGV1DYc/SVqGtRyx9B3BoFArlGChEOil9yGsRhMspmBCe2jUg/pFwKQqChIJgbG
         RTsY9H/LXNWMMJRSmGDdYH2My40VNUXYnI8U8GDo2w6QxK+/XW5VPPLLph1Rm38ZtG6u
         tbUN8oTNVjCeBhdzr2B6J2iPCR69EKvCwnebhRG81BpGS0iM46VwDSJwnXy+NCYDl4SZ
         2zpebnBq5qzW/4dT9pP8rhGYoSdjtkPXgcsee6Sm4GKrgrvg4ikHYjPbAQBWjCF7oFhc
         +GDf1iKYAiSt719YHAZCE+vWZlW3nH7hBu2/VUY1sNR10abg6prpiDnxeL/d97v0oJNj
         FezQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkI2iq5YBJ+w8tKMkOS5kf1pA0CDUQhlHLwe8068bm8MpQpjeYq1Oqh106pwdAv0Urya6f5s69CFOT5fAM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex+KQjpAOilcB6CP2OVx4YBvRYrOSbg7JV06N+Nyq2r6rDeIW
	HjWywnkaG9GO9Hsn7hTZz3246UWDKOxXDJJ0Xs++0Zjt89/ZA8Ky70VzVL57z8mS+jLAvfNm1go
	zwBaIpo7ymJWW3xvcWE187EBaCq4b8BkL7WGN8nsc7WF1TSdzpetLJGrlYuIoWKk=
X-Gm-Gg: ASbGnctxbX0Xe/BVP8+OUnkk8oBzOAsEo7aS6hsikqyuz924BSmDfNXUeVrwHsOR1TB
	EQ0e7cmiGgmlpOw7xopOJ37F923UwQWgTsKAFtt0BCyGoMkc86PILEjwhv+S9tdrgbD3FIaJ7Wk
	y7uqQL/Uo06IS+IjPSUThWUHpJyxnfs32Uf5EnKViOtu0QzwXSXfjqYk//NIITpFlKz3xocsFV8
	OsNhzKpnxR40EiknWBsLthSYao/Icx217SskyjSJ4wUkUf2LSRROYZ1gGCUbjxwCc7zaTXzKfuT
	UmSo1l6GVlfKmwoL/Ok328kjv71G0ehrn1EMoIkq
X-Received: by 2002:a05:6000:381:b0:38f:2413:2622 with SMTP id ffacd0b85a97d-39efbad7f42mr14397247f8f.47.1745340557513;
        Tue, 22 Apr 2025 09:49:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDoEgp+mnqvCe0AHRP0Rn4FhZOt0+ug+zdFUDxNDueLDOx4k3ra4nj9Co+7VRKKBDx5ofTWw==
X-Received: by 2002:a05:6000:381:b0:38f:2413:2622 with SMTP id ffacd0b85a97d-39efbad7f42mr14397208f8f.47.1745340557066;
        Tue, 22 Apr 2025 09:49:17 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c62cd.dip0.t-ipconnect.de. [91.12.98.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4330bfsm15769041f8f.23.2025.04.22.09.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:49:16 -0700 (PDT)
Message-ID: <1bee5078-5cc4-43b7-993c-f1e57a9bf534@redhat.com>
Date: Tue, 22 Apr 2025 18:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
To: Shivank Garg <shivankg@amd.com>, Paul Moore <paul@paul-moore.com>
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 ackerleytng@google.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz,
 bfoster@redhat.com, tabba@google.com, vannapurve@google.com,
 chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com,
 peterx@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com>
 <CAHC9VhRFBOC=cZB+Dm00cshwBSBaK6amv+=XFLPF0Bub0gHN+Q@mail.gmail.com>
 <b98f7b78-1834-4fa0-b79c-d5ac562e4809@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b98f7b78-1834-4fa0-b79c-d5ac562e4809@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.04.25 08:07, Shivank Garg wrote:
> Hi Paul,
> 
> On 4/10/2025 1:49 AM, Paul Moore wrote:
>> On Tue, Apr 8, 2025 at 7:25 AM Shivank Garg <shivankg@amd.com> wrote:
>>>
>>> KVM guest_memfd is implementing its own inodes to store metadata for
>>> backing memory using a custom filesystem. This requires the ability to
>>> initialize anonymous inode using security_inode_init_security_anon().
>>>
>>> As guest_memfd currently resides in the KVM module, we need to export this
>>> symbol for use outside the core kernel. In the future, guest_memfd might be
>>> moved to core-mm, at which point the symbols no longer would have to be
>>> exported. When/if that happens is still unclear.
>>
>> Can you help me understand the timing just a bit more ... do you
>> expect the move to the core MM code to happen during the lifetime of
>> this patchset, or is it just some hand-wavy "future date"?  No worries
>> either way, just trying to understand things a bit better.
> 
> I am not sure about it, any ideas David?

Sorry for the late reply.

Hand-wavy future date after this series. Elliot was working on this, but 
IIRC he now has a new job and might no longer be able to work on this.

Ackerley+Patrick started looking into this, and will likely require it 
for other guest_memfd features (hugetlb support, directmap removal).

-- 
Cheers,

David / dhildenb


