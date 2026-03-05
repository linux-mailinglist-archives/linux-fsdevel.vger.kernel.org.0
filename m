Return-Path: <linux-fsdevel+bounces-79467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OJRB+lHqWm33gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 10:07:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A720E018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E0EC30E3F93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 09:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F537646C;
	Thu,  5 Mar 2026 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UBV9Wq7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EF346E56
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701398; cv=none; b=iCxRgTQVoh7YT97k/d/p0uuwthNhv5KIB2/eDsYZ5Okvoo+t42oCrEsExeqdjjPaWxJGrNgzBcRgGHhEDkL/wqEIePzf2bRhB+97oxop2NGp+8DSGzqCixt9o1+puUuZQp1jO9FiZtR4lCkZL1bopPpYJug0+XmA+jzBovF6d7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701398; c=relaxed/simple;
	bh=4j2H1vTStRkJsGqGfZjGs1SWh/WE1AFeFjGWmvXOPNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqEBg/JWvgeAY8JQlbrMypAu/paTvJjyfxFVbpvT8+Cjzh3LpzeeEqpKR8PUUcSdkcsnoi75xrpg49VGvJ/RK3pnOa1E4c7zUINQb0dXO7ZYZaaAWZ07DmNVdrnxAc6643LRazkar0/sjdqchkE4UnOrdIskSlWhP1NjI+73Z1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UBV9Wq7v; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b351e057so258485f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772701394; x=1773306194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=smWzxETQFde5edH1yawclh397DslBFPt7zhbpAy3Arg=;
        b=UBV9Wq7v3AQspgKns33Lytf5OoGZH79zkSSK8iyFiMv1v7jqRherpBFwwAaK9l8PUW
         fcTKw30xNCTKFf4V9AbE6fAPMRGr2kkX8VaauNVRrcpHGZokItj2Jn71j5HFoE/ZLNrw
         yB9yUVwg15Yqch0ouUC6OsrlgkalSQk4AVC9KujtwyNKRbDZ9e5Td811RQTcTznkAFMu
         9lomwHq3vX5b7oUZfDFrj8M9eLVrQTPWMW9fROOmeqeg1fL7Eo0qHp0YK8GsvxaqZK5O
         437/p1YpQyab+Nb3K5NzlTfSX6UB+d/YBkDExo0Kx6duXKfR+aD2jPqakNAvEsxtED1B
         pdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772701394; x=1773306194;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smWzxETQFde5edH1yawclh397DslBFPt7zhbpAy3Arg=;
        b=T/jm0HNt1jC3rs9E+JoMaa/+qSVvcteMMNZ0biEZkl2vPYvwRimRKlx4DnAl64DMA/
         cWq7LqB6WeodzhXXfoRrHZ2I9WD+djKIvoUBtWbu4Z4PC1Y5v8oIkd9YeQF8LceFCQS6
         vXVqh6DwuqNyI+t5hHcoilPzH6/ZdWxuongmzZqzREvQWtMNOJg8QvkA5BunK3NfBzRV
         sN76XYQFHA3qC2iOnnktVsZS0AxxHUHsNxeVgUrARnaPdJmHhTMuwqfsv62BiZGIWwkU
         bEKZNOgcS02gt4NiflCBwKaLcZ/SBsZz2RPvgS1kx60rp3syPS/pM9W4hjd/TXbYytjo
         yA0Q==
X-Gm-Message-State: AOJu0YxEynkWr0oN6uAoHzooNof73nxlBVd5ORULYVwhNLqkFUVH/NhO
	VAL4FasuMrpCC6nTW+MJhjcwBSz61BtdbgK2gvN0UOZhm1CN+FjUiiqzl4mGz/Sa57s=
X-Gm-Gg: ATEYQzxm7yuGB1XTyOlm1QvnX2pGrmecZzfKY47ccso5bqTkJvx3KZjyMYipoBcX8fH
	mmQdcwSKuyw9YmQd0ME+WFA0wFUID9DiswI9rgEA7rDS6IGcMWl5yRepaTjQtx4JDDGjrrKsSv+
	+XJhqQxZYBoXkk3x/O88aI4rgeaE0apqKccYQSXJXa0BB7QJjZBPqH8Odn8Eu0yY84N7MF9U8Gs
	UwvDmL/xuabcNdba8eIjrXdik91EDx2/P8pCS8Ym0aL67LSr19c/Qi+Ac4baEAqp6n48Jh1tST1
	di2FGveBq3Ke+zly3XRSePcBQq+iBkwnf1tjIlQ70hJ5SkoNZuFMoFan66VtGr9qGpArOYLCk8/
	yhrby6MDFXQaFL/VOhjDtfb94IytfySh7xIzoczq+RN3ufQELWtbz++VEnDaYCO0IJG7b7CVz7P
	h5Kqeub3f19M6dv0zXgv8LjSgLFKhgfGm/ShtrSDXmAi58Sd9nPYcJh77kcw==
X-Received: by 2002:a05:600c:1986:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-48519897935mr42870965e9.5.1772701393663;
        Thu, 05 Mar 2026 01:03:13 -0800 (PST)
Received: from ?IPV6:2001:1a48:8:903:1ed6:4f73:ce38:f9d4? ([2001:1a48:8:903:1ed6:4f73:ce38:f9d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fae4a68sm24849435e9.9.2026.03.05.01.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 01:03:13 -0800 (PST)
Message-ID: <8011ab29-de9b-4a9e-b437-a514f6e462a0@suse.com>
Date: Thu, 5 Mar 2026 10:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: filesystems: clarify KernelPageSize vs.
 MMUPageSize in smaps
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Usama Arif <usamaarif642@gmail.com>, Andi Kleen <ak@linux.intel.com>
References: <20260304155636.77433-1-david@kernel.org>
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <20260304155636.77433-1-david@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6E5A720E018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,kernel.org,linux.dev,lwn.net,linuxfoundation.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79467-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 16:56, David Hildenbrand (Arm) wrote:
> There was recently some confusion around THPs and the interaction with
> KernelPageSize / MMUPageSize. Historically, these entries always
> correspond to the smallest size we could encounter, not any current
> usage of transparent huge pages or larger sizes used by the MMU.
> 
> Ever since we added THP support many, many years ago, these entries
> would keep reporting the smallest (fallback) granularity in a VMA.
> 
> For this reason, they default to PAGE_SIZE for all VMAs except for
> VMAs where we have the guarantee that the system and the MMU will
> always use larger page sizes. hugetlb, for example, exposes a custom
> vm_ops->pagesize callback to handle that. Similarly, dax/device
> exposes a custom vm_ops->pagesize callback and provides similar
> guarantees.
> 
> Let's clarify the historical meaning of KernelPageSize / MMUPageSize,
> and point at "AnonHugePages", "ShmemPmdMapped" and "FilePmdMapped"
> regarding PMD entries.
> 
> While at it, document "FilePmdMapped", clarify what the "AnonHugePages"
> and "ShmemPmdMapped" entries really mean, and make it clear that there
> are no other entries for other THP/folio sizes or mappings.
> 
> Link: https://lore.kernel.org/all/20260225232708.87833-1-ak@linux.intel.com/
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks.


