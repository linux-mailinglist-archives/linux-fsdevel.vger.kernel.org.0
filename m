Return-Path: <linux-fsdevel+bounces-43123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BACA4E592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F9218888B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D4C280A20;
	Tue,  4 Mar 2025 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddAqSdXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912027EC87
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103496; cv=none; b=g9Lv3WMtDv4y8ojoeQr4BeCdaBjCiSnlFLDGNbJiW6hw5Lnc47vo5elD0XFW8v1vuH1K4X/qyMAWJzh5YRN4pfduBJP4Jh7fpRnkSj6unMJtov8Sd0nZb3KAb6O/h/rFSE/VlppxPgb9UhwcP0Jpk8cQaBjkBc7n+7Ev+qGKYdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103496; c=relaxed/simple;
	bh=SO8mydmZaQBmGHqkXm7nBWI/I8sW6KvltUItc+vR0F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXJJ79x2Yzx9r+JvJuB5nmPpgsWIpQ1VULJXLWql28EEbwj9lttvjRkZ2zsMS/dPAN2WWcSNiAwLsNsLFdfhgBNriVKi7cBsSflPW5LXNmv5LTanvi6U1/T7yTtpRzRKSa+6vAxjZ4k5UpwU1RojiOimcjaoQNv7FejfxPrazO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddAqSdXQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sn11KJZxds0ej1UosF1rLJ47UkMAak3JuCgvKoEZngM=;
	b=ddAqSdXQ9DvdwIrMIcT2hzQQjS/dbmcizW86WupA2+SGp+aa0Q/PvTLx4rgIOT8JvwknQr
	h94fu5rXfb+DshVn1dswDZ2tZ6EoKVzObWj16LdhDU5vfwXVEjYHGVCqHqRKttp28w4ytq
	qKPjQowP8cVuXxth/fkVDIV8iKztMro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-xhDmqJLONbWwBfoJMRyUYg-1; Tue, 04 Mar 2025 10:51:21 -0500
X-MC-Unique: xhDmqJLONbWwBfoJMRyUYg-1
X-Mimecast-MFC-AGG-ID: xhDmqJLONbWwBfoJMRyUYg_1741103480
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390f365274dso1782039f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 07:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103480; x=1741708280;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sn11KJZxds0ej1UosF1rLJ47UkMAak3JuCgvKoEZngM=;
        b=s4d2asU+eCLkbH/48/7iX8xaK1gNP3q/gFylD8QegspeuqOhVBH3OIYCmAURZVDM7r
         PSXdChQjM++EiHg24Nqi93YfnI1nd+pbbwsjwqI2/WWjiQF5KqnsG86EpZmc6mWCWYR9
         h5w2bS1yIfGf1J0+LfW74zHjfdrPEtOWRuAHDO4e66jnW/P7kV5Fbe4MoSLToA1r22TF
         F2zKkB05AIpBucV9WO18Vs14EPBrHdFbPJncOBjpBsNAQSicIbOffEpIPiKgL8d7xWni
         zBmu4lctcTwEX4v1bwHqDr9+xJrotA8R3wmRa5FQ0XrG0zb/hATKnFPVxTxIstzU70/x
         orIg==
X-Forwarded-Encrypted: i=1; AJvYcCVU+4y4w1QdV+luREnP439d1eeBhfE/isaXtU/TJmMTF4KHasE4aI1ryfZtM+InEPIvipGpfKBVwlR565Ar@vger.kernel.org
X-Gm-Message-State: AOJu0YyepSnVqfoZkmV6LHm96/jIGnb+oW+bqXkrKwG81a88UxqWzby0
	lQFabeo2tJpTEyI/339IOS40psBWkq9nMX+xEI0zu/7SDcLYDXTilunrRI1tyIAJkkpNH6GA3xv
	9qxcx/e4gYKdA2U+zwsgQ0Q5n4eiezKeK4vfJgDY6khSdQGgDuo4UW33ZmqfU+OY=
X-Gm-Gg: ASbGncuRT+5nOG+J2I4Nj+NeU2naJ/xnZM6pxMC9lVUibyZZoosjkMcenrQavUy7m0e
	ffGMfASb6gLBxQZtjd3u2SiE1H4Fp1sHNLNt1xVN7RdqwMufrIvLrKbpapfcWTCzPpfPjNpleNJ
	c1WMRxqliI/Q4zLEv6jhalcW16G1rfq5yF2RM6KNT0kqn3q0/QTcX553qMZ51Lc82g1MSxGCe+g
	GYDiR4CvRaeaYnoAEOassEkfVuJunuGp3r80dTR2LUR2cQIbRdZq21JSAFvwzPtP6qk7v+vNEkA
	NAISgaKfsiHzHUtbsvbKfxuLjYMimqw/dwvnWYyYvenaj7EwehazfK4aZT1XbfQRuWEz8A6B5KX
	UEgxdqpbDQWH2HeLgjitDGH4xSOqMZP17Z/QitJjshoA=
X-Received: by 2002:a05:6000:144a:b0:391:bc8:564a with SMTP id ffacd0b85a97d-3911561aaeemr3168063f8f.22.1741103479800;
        Tue, 04 Mar 2025 07:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBKRpR1ew37y+xSwqdiAEEYgp9jcG+1wVSkkDjUC24e/FeWlE3M4RoXhNkgSdEbUx9SQm6QA==
X-Received: by 2002:a05:6000:144a:b0:391:bc8:564a with SMTP id ffacd0b85a97d-3911561aaeemr3168051f8f.22.1741103479428;
        Tue, 04 Mar 2025 07:51:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:1000:9e30:2a8a:cd3d:419c? (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc38986cbsm68968655e9.35.2025.03.04.07.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:51:18 -0800 (PST)
Message-ID: <9d04c204-cb9a-4109-977b-3d39b992c521@redhat.com>
Date: Tue, 4 Mar 2025 16:51:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] KVM: guest_memfd: Enforce NUMA mempolicy using
 shared policy
To: Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, shivankg@amd.com,
 akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, bharata@amd.com,
 nikunj@amd.com, michael.day@amd.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, tabba@google.com
References: <b494af0e-3441-48d4-abc8-df3d5c006935@suse.cz>
 <diqz8qplabre.fsf@ackerleytng-ctop.c.googlers.com>
 <Z8cci0nNtwja8gyR@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z8cci0nNtwja8gyR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.03.25 16:30, Sean Christopherson wrote:
> On Tue, Mar 04, 2025, Ackerley Tng wrote:
>> Vlastimil Babka <vbabka@suse.cz> writes:
>>>> struct shared_policy should be stored on the inode rather than the file,
>>>> since the memory policy is a property of the memory (struct inode),
>>>> rather than a property of how the memory is used for a given VM (struct
>>>> file).
>>>
>>> That makes sense. AFAICS shmem also uses inodes to store policy.
>>>
>>>> When the shared_policy is stored on the inode, intra-host migration [1]
>>>> will work correctly, since the while the inode will be transferred from
>>>> one VM (struct kvm) to another, the file (a VM's view/bindings of the
>>>> memory) will be recreated for the new VM.
>>>>
>>>> I'm thinking of having a patch like this [2] to introduce inodes.
>>>
>>> shmem has it easier by already having inodes
>>>
>>>> With this, we shouldn't need to pass file pointers instead of inode
>>>> pointers.
>>>
>>> Any downsides, besides more work needed? Or is it feasible to do it using
>>> files now and convert to inodes later?
>>>
>>> Feels like something that must have been discussed already, but I don't
>>> recall specifics.
>>
>> Here's where Sean described file vs inode: "The inode is effectively the
>> raw underlying physical storage, while the file is the VM's view of that
>> storage." [1].
>>
>> I guess you're right that for now there is little distinction between
>> file and inode and using file should be feasible, but I feel that this
>> dilutes the original intent.
> 
> Hmm, and using the file would be actively problematic at some point.  One could
> argue that NUMA policy is property of the VM accessing the memory, i.e. that two
> VMs mapping the same guest_memfd could want different policies.  But in practice,
> that would allow for conflicting requirements, e.g. different policies in each
> VM for the same chunk of memory, and would likely lead to surprising behavior due
> to having to manually do mbind() for every VM/file view.

I think that's the same behavior with shmem? I mean, if you have two 
people asking for different things for the same MAP_SHARE file range, 
surprises are unavoidable.

Or am I missing something?

-- 
Cheers,

David / dhildenb


