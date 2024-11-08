Return-Path: <linux-fsdevel+bounces-34088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE89C2541
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 20:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397C0B23DE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E951A9B20;
	Fri,  8 Nov 2024 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIAaBkgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9A1AA1DE
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092441; cv=none; b=ClKgq7IbzH8z35dbahjxBFcqvB+Tlu3leCtOjDgea8eswmz+dLguMncWuYdElJCqpU8trTE6FpyWzN/GlMCce74yhVaBa4/VbbxKHvipQMAhvX1lD8QPAkoqCQlg0V7yjQsRYyKOSZuIh+q0J76Eo1DHOpzLXp6USaKENLHPoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092441; c=relaxed/simple;
	bh=QCru+aHVwwXC94jTXaW93fHJFWCO0FMvE3AvZcc0SyE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KlBF1MEp5JLo3siommZy9Vs9Nw1I7/a0KjlPl0XRgJRFySaLStgxAYIugKmvAvP7p+WvDudk1WXqxoyXKjzvwaqbcy75U188VgRg0bUPfTkwb7Sz81j7UF/PuxS8rl59Oomfe1PdGPhTdkkrLKV3teOZyVlXmFVCLVc1Tz4Q0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIAaBkgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731092431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O0N0dqt2AOiHgJyVj6USAh4K7FpOzpZNcsmO3xiEHCk=;
	b=gIAaBkgXE+TJuBeL2C1VHiKgR+boXNRRXqqNSkoV9FtzWJjfKCby9ccJilXMEi8LFF1gWy
	pFba0Qx45oz8JkabGQPVIGt9LB7/QD6DW7y0INC6OEhYPPALq0c7WmJaw6gWWUWfU97uV7
	nvZ0zggVaK1R8jgmkBhgt5X5OE9BRTA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-Txg_j9zJPuyKY4eed45mKA-1; Fri, 08 Nov 2024 14:00:30 -0500
X-MC-Unique: Txg_j9zJPuyKY4eed45mKA-1
X-Mimecast-MFC-AGG-ID: Txg_j9zJPuyKY4eed45mKA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518ae047so18846575e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 11:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092429; x=1731697229;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0N0dqt2AOiHgJyVj6USAh4K7FpOzpZNcsmO3xiEHCk=;
        b=vRY4IIj9kNGAceAiUtTB5pcqsN00hQH9ac2nsrf+inFs77Xta0GSgTGSJaj68m9rrN
         mcNZd4ODqbueT2Af0uWebrIsCDR8Jf9/dZ3qX6FrOPp7Lfig5myBl/RvkjSTnKaWKfn5
         2pXHRGNIJ1IiIsMi+/AI3AmfPDzUga7FoNNiiEGOtNm3UvVy5OB77dUZwzDIUvJ+rzGH
         XEzBEl1XWwDMIX9asYRXqA5RkikwIPd8Q0Ue7SIXKLan4jNrpZREV9ff49OWoWGUpX30
         sGDu0U1YOBB0tL/h1W6oHXX7lCC13XvQuiP3Pon/k16mxB3ewsCRB9eZmgBs4OPKswK0
         +1+g==
X-Forwarded-Encrypted: i=1; AJvYcCXjJJOxfgo6vyorOTL0A7rBhgCzsALNXbFOB+j6DCEAVwdrNE/MGDJZitrUMA0/6xYWnekVW0oHF5YwOqF2@vger.kernel.org
X-Gm-Message-State: AOJu0YxWUqXFDrt601uxn8PXCmvbnAYc0JAmrT4ZokJdIabC2dyirmAV
	exj0OzTcRyo1/qIEMwBWiry6MvG37M18UvyzWqC0M2U5FM/BETDct5Pk+RtjJs/3UQeni71cJZF
	j4J89QN4DxlQkScc80KolojropB8cWbnMLFmUyv9VYxy8xDIPudqvfJMeqCQwwnI=
X-Received: by 2002:a05:6000:402c:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-381f0f40d9cmr3953642f8f.1.1731092429029;
        Fri, 08 Nov 2024 11:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8NXteKUBnfajTNiTy8pGXq2AJ7BRCVrspkKpZbYGMnfSQehiOah1tafen33BoWgw1mQ+Lzg==
X-Received: by 2002:a05:6000:402c:b0:374:c1ea:2d40 with SMTP id ffacd0b85a97d-381f0f40d9cmr3953606f8f.1.1731092428616;
        Fri, 08 Nov 2024 11:00:28 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5? (p200300d82f3acb003f4e68943a3b36b5.dip0.t-ipconnect.de. [2003:d8:2f3a:cb00:3f4e:6894:3a3b:36b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4f6sm5697729f8f.64.2024.11.08.11.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:00:27 -0800 (PST)
Message-ID: <4d2062bd-3cf3-4488-8dfc-b0aa672ee786@redhat.com>
Date: Fri, 8 Nov 2024 20:00:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in
 offline_pages() if migration fails
From: David Hildenbrand <david@redhat.com>
To: SeongJae Park <sj@kernel.org>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, shakeel.butt@linux.dev,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org,
 bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20241108173309.71619-1-sj@kernel.org>
 <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <04020bb7-5567-4b91-a424-62c46f136e2a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.24 19:56, David Hildenbrand wrote:
> On 08.11.24 18:33, SeongJae Park wrote:
>> + David Hildenbrand
>>
>> On Thu, 7 Nov 2024 15:56:12 -0800 Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>>> In offline_pages(), do_migrate_range() may potentially retry forever if
>>> the migration fails. Add a return value for do_migrate_range(), and
>>> allow offline_page() to try migrating pages 5 times before erroring
>>> out, similar to how migration failures in __alloc_contig_migrate_range()
>>> is handled.
>>
>> I'm curious if this could cause unexpected behavioral differences to memory
>> hotplugging users, and how '5' is chosen.  Could you please enlighten me?
>>
> 
> I'm wondering how much more often I'll have to nack such a patch. :)

A more recent discussion: 
https://lore.kernel.org/linux-mm/52161997-15aa-4093-a573-3bfd8da14ff1@fujitsu.com/T/#mdda39b2956a11c46f8da8796f9612ac007edbdab

Long story short: this is expected and documented

-- 
Cheers,

David / dhildenb


