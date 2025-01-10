Return-Path: <linux-fsdevel+bounces-38894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603DA09809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0835116B7FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8C2135B0;
	Fri, 10 Jan 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FURdZqFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A21C5F2A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528487; cv=none; b=Kh7jzYtXw9jtxkq8Jlv4gKU25Y+ZNydxiPg7z+dA0Syc+fd50ZYT0yOtVLaOBudgHyQmDujgBCC2YcKZwqxNUlH7bW9fxg9kVIeq8+bpwcd5AYc6kAihO1OEkXwI2UqoZA4FrWZCIvu1FVlK85MPwcOeAqD/SaLHHWpMc9f2yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528487; c=relaxed/simple;
	bh=/dMv4pheAhb7jXK1MakBSN+VWFXvQyNlREXjbWiGE1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI8uaqffE+dVrslUGab/X3YrZRASWZoLHLST5HAFBxFo5R2xo9/1v0UsiSMjnS1z02mV4fI/PuqoFt7B7FR/Eu+u+PN29xbDqO08K4YivP+Cm51CrULueYHgdwVNEwp3xieW6jjq4C6ETtFEo+P/22Izo3dafpUCXscwF7AVobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FURdZqFP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736528484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0LIQvjZkAL7Wt8C3nYk4hBMuLkgvDn6/5Yva870loKg=;
	b=FURdZqFPbXGzO2g18Nph3vKV43oaLuy6TSmk5b4GG3WxOVl4b1nM9C+RnTTxwgYqAXCCgw
	mjILPE0Jl5S++/d8I3GSzrYy230LGjwLh0WQ/PcnGohusFdlZxXyoKmouJyRZIPVT3wKO+
	S+RzMXv3qQQa8o5YoHti4gIThe7Ing0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-qIK_Kd8HOzCadXS0Dvklig-1; Fri, 10 Jan 2025 12:01:23 -0500
X-MC-Unique: qIK_Kd8HOzCadXS0Dvklig-1
X-Mimecast-MFC-AGG-ID: qIK_Kd8HOzCadXS0Dvklig
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862b364578so1579934f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 09:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736528482; x=1737133282;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0LIQvjZkAL7Wt8C3nYk4hBMuLkgvDn6/5Yva870loKg=;
        b=USF0hfS4fVZ53Wn0bYzgFB1cdoALvfy1ykbGocAhF7wwj5Oyj96iqJQvpZ/0jVlYol
         +uX9PR+q/3Xcob6wC4AC7h6mce7Armtwyn8idqAX/DHxekrWnK/YpognDEyD4rcvC+tS
         jev+FqdoCmHWcG9HOL7Zw/HqgpstM55otMFME6uVKl8FP5u7eQpQSIr1BrBzkKQMbaaj
         vuPFrByMhrKQepdtP5YL9ZIey0a8tN5av3UIYMISsG5bFY1hBFYbWRYhN3jsXNy8NGK8
         PLfuYznF8lL7+/FAtRhBaHxtreiRFAEcNrxy2aDbR7ul0PjR+gxjvkVoJTKQ0T/RE0j8
         hxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZeFu7Xvm18y5prKSDa+zHIy8ISrbPSiY9BHO6L+sPOuHpI5plw0HiUUBg0n53YQZ5oWI+F9XWpnPoe+6s@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwdSgtrm64MKjAkYl/bwymtfFVv2kb/LwIVvuEryNrDswVqyE
	2ZiLmV24QWBeybzMZ3d8UCv028sF/GLNdu1Aej3WwdflvFKECfSFKY0WDZVjqGlKUzM21hoB55c
	BHFbon3L/Pm6yXDNoEJ47jIIcCZQpzy+qwHeU/TEIfml8R6TJO7mnw2KrdiF4nH0=
X-Gm-Gg: ASbGnctHdOUyMjwAnQea5+ZOo9qy4u6kLzDBjwCDUjKwhXeD7kveHhO5z9oc+FWx7VE
	w0tzfIQUwfIGsBAuR4lS5cedv2YiXLJq9Kxu0pNOsomjS7ze1Kj//1Jtetvq+hDjuxdgjWTUc6m
	BJ/A+TJuiAGyG8S6nnYLO48Nb7G82znUkbDwjbj6xlqksmymuBDhcqT3z/jxk5Ja/P9m2tnu3bQ
	nN6352ZlF30qL0u1py39EF2VgdaOu8s0q5CgX6X/Uzf8wJg3dVT3GiQ9hWYQPsP0+GX0/FNzttI
	FBd8hW+keHZRnspQSJmB8xG5wd3NilhuLFu8q2BStDdtlqZ/lFUjYSHMkVkqtaV3gX3vpYritf2
	7rbAvO1rJ
X-Received: by 2002:a5d:6d85:0:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-38a8b0faa98mr6654850f8f.29.1736528482219;
        Fri, 10 Jan 2025 09:01:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdUHSaAEEOurkYMiztz2DaNvoKRIUTS2uxzxL487jn0Y0S3oNMFfvhgvRLJ0MNK9wrAAsSew==
X-Received: by 2002:a5d:6d85:0:b0:385:f349:ffe5 with SMTP id ffacd0b85a97d-38a8b0faa98mr6654655f8f.29.1736528480305;
        Fri, 10 Jan 2025 09:01:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddc5f5sm91661065e9.18.2025.01.10.09.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 09:01:19 -0800 (PST)
Message-ID: <5608af05-0b7a-4e11-b381-8b57b701e316@redhat.com>
Date: Fri, 10 Jan 2025 18:01:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] mm: filemap: add filemap_grab_folios
To: Nikita Kalyazin <kalyazin@amazon.com>, willy@infradead.org,
 pbonzini@redhat.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: michael.day@amd.com, jthoughton@google.com, michael.roth@amd.com,
 ackerleytng@google.com, graf@amazon.de, jgowans@amazon.com,
 roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
 xmarcalx@amazon.com
References: <20250110154659.95464-1-kalyazin@amazon.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110154659.95464-1-kalyazin@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 16:46, Nikita Kalyazin wrote:
> Based on David's suggestion for speeding up guest_memfd memory
> population [1] made at the guest_memfd upstream call on 5 Dec 2024 [2],
> this adds `filemap_grab_folios` that grabs multiple folios at a time.
> 

Hi,

> Motivation
> 
> When profiling guest_memfd population and comparing the results with
> population of anonymous memory via UFFDIO_COPY, I observed that the
> former was up to 20% slower, mainly due to adding newly allocated pages
> to the pagecache.  As far as I can see, the two main contributors to it
> are pagecache locking and tree traversals needed for every folio.  The
> RFC attempts to partially mitigate those by adding multiple folios at a
> time to the pagecache.
> 
> Testing
> 
> With the change applied, I was able to observe a 10.3% (708 to 635 ms)
> speedup in a selftest that populated 3GiB guest_memfd and a 9.5% (990 to
> 904 ms) speedup when restoring a 3GiB guest_memfd VM snapshot using a
> custom Firecracker version, both on Intel Ice Lake.

Does that mean that it's still 10% slower (based on the 20% above), or 
were the 20% from a different micro-benchmark?

> 
> Limitations
> 
> While `filemap_grab_folios` handles THP/large folios internally and
> deals with reclaim artifacts in the pagecache (shadows), for simplicity
> reasons, the RFC does not support those as it demonstrates the
> optimisation applied to guest_memfd, which only uses small folios and
> does not support reclaim at the moment.

It might be worth pointing out that, while support for larger folios is 
in the works, there will be scenarios where small folios are unavoidable 
in the future (mixture of shared and private memory).

How hard would it be to just naturally support large folios as well?

We do have memfd_pin_folios() that can deal with that and provides a 
slightly similar interface (struct folio **folios).

For reference, the interface is:

long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
		      struct folio **folios, unsigned int max_folios,
		      pgoff_t *offset)

Maybe what you propose could even be used to further improve 
memfd_pin_folios() internally? However, it must do this FOLL_PIN thingy, 
so it must process each and every folio it processed.


-- 
Cheers,

David / dhildenb


