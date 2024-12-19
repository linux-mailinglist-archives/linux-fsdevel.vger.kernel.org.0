Return-Path: <linux-fsdevel+bounces-37828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9987C9F801F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EEA7A10C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEF22655F;
	Thu, 19 Dec 2024 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+S4mtwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D517223E64
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626505; cv=none; b=CoW99RLpk7IqX7tMwgsrw4DbPC30AzyrdRbLAlXUw1h0Cbu0JakNXEhUL6HwepDE5clpRQpL33hBFKJFwk+NLgsOZgjlMk8Z2rQlB2XQih4fcFLpb8yjLC0TvFWuCuBCNY4AZ6r4uxemTkZebV+vKquR/qrXWkIOuc65ddRNAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626505; c=relaxed/simple;
	bh=cf+a1Rt73p7YQydRlINlvJbbN8v7JtPRHCByptR6HEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxLqMxIVch9zs9PEhlYszGT91yImevpravFdB1yk7pZNtx6CZ9wygHf/DEHTjGz3r4kR6UlJ0xjty7jQolIsKLvNyCYsNLz5cZNdInO29A4dbrbsvDnGJ9FJociXz88vAn8VRfJcjSXn9wo81Rha4O2poIOtliGwc9fb/Vy/3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+S4mtwk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734626503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CVWlXXlPVkHCzJUoxmgh5eR5fLD2kKdCctYVI8Jy3mQ=;
	b=i+S4mtwkJIDOCVekXMEmVCGfKJEiFcIKY0Dwz4FHdm4FkQisSqdaXmYkjHiE847/VmZEaN
	R499JfpOQXc1jjeTGJLQlm+SROhp5fpb/kVmDqmtVPNc/EfXgq/ptLu4V2cwzzPcMgvLNT
	Kg/C9O7IAh/2i3RL44HSOYKKQQkd24U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-aJjYkdgXOxWDUAtT8Y3imQ-1; Thu, 19 Dec 2024 11:41:41 -0500
X-MC-Unique: aJjYkdgXOxWDUAtT8Y3imQ-1
X-Mimecast-MFC-AGG-ID: aJjYkdgXOxWDUAtT8Y3imQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so9503435e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 08:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734626500; x=1735231300;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CVWlXXlPVkHCzJUoxmgh5eR5fLD2kKdCctYVI8Jy3mQ=;
        b=CcGlZG1OeEHUj8TJUGEo8DwE10wS6Vj/W63rGxyisgRZTKoUkixiX9YCQ9yKjfj/y0
         rYqxczu4Hqx8aQe3CTQly5Eq58ZiejUv0DzXpVfPQnCEj/URoWuVK3xT+0gKNVcDfzyM
         ACkPkkr3qrzwUjLTmgm9vjS7HufaCv4PdIMRSlAQ2Yu+KiI7+MLrHVVq8uo6ELlBiiI5
         pVhkqcdqmCURxLBofKyt+4mZ62fqfF0Qgj0Eh7z84IrSSvhKLJb3sn4eixDvGaXiQITm
         fr3uFW7e8mp8aZRAdkD/I4MLZbjR78pa77x7Qc8qbnSl9Jbmr3hhTY9vkxnyeZXPSO4J
         D7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVpmnvTsRovUD/nFmgTD1wi1mQGS9p6MinP2kF7O3T4rzC90vGhks7t6O+PJrx6VGz0yTGkQnNtsHby2lD6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe5nBsgkNXIpIDCivoPwfqgJDa+SxlsY4ecBgD3pcjVKs7/n6
	ErQKAXgXrkv3AfO0HHSCoqmYCRrEqeHDIWbE+0ZjwvW3gdjm6Uy+L/Hg3rPeLFgXpsFk5ktHv8E
	KkpB+2M3aSSXiHTbFDNT06ClJ6FOkgVKb2L/bIWlnVs6D8NJkSm762yt5Dj/cJzY=
X-Gm-Gg: ASbGncuIiZsf/dh/c7lX+dgJCxukugzSSY2ShsdsPaTc1LBndosYQz4I1ej2Ag5oHCb
	UNcvmW3pExTsSf1Sb0OLnsqack3eEFS6+jiczxBFxAfl/5TNd4MbHtpoWn0oa63P7x7iPYhUw82
	ACN+ovt1xG7sH2rrgTwdjnqTBtg3yrrI2ELd794IbbysH6l0UlTWBPv/bpobbPsgdyz4Bh2cY2T
	Tem9jB1bb65Wn5XEyjmoTV+Cxv0cFKzgoWXeCGbpbzG+Zxy/HFlgjPaq9zy8jzWlxmmcFrsBaKR
	LJwGevJkKpG4+xP2+yDWe0NaPMUewHBhhScD/hFkDdXdMGXOUg1tPDHDN6CWQRNJ0pkQjumGDpK
	XiR2sVg==
X-Received: by 2002:a05:6000:78e:b0:386:37af:dd9a with SMTP id ffacd0b85a97d-388e4d65c40mr6941545f8f.35.1734626499803;
        Thu, 19 Dec 2024 08:41:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEImuaXnN5GKNWor4LBqAQk1fbLsk5kjjAQ4NTlU0sIVKPdvJaT8V2iBmwRZ8z23rTeolMrCg==
X-Received: by 2002:a05:6000:78e:b0:386:37af:dd9a with SMTP id ffacd0b85a97d-388e4d65c40mr6941520f8f.35.1734626499467;
        Thu, 19 Dec 2024 08:41:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686? (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de. [2003:cb:c749:6600:b73a:466c:e610:686])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm1916215f8f.15.2024.12.19.08.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:41:38 -0800 (PST)
Message-ID: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
Date: Thu, 19 Dec 2024 17:41:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 jefflexu@linux.alibaba.com, josef@toxicpanda.com,
 bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.12.24 17:40, Shakeel Butt wrote:
> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> [...]
>>>
>>> If you check the code just above this patch, this
>>> mapping_writeback_indeterminate() check only happen for pages under
>>> writeback which is a temp state. Anyways, fuse folios should not be
>>> unmovable for their lifetime but only while under writeback which is
>>> same for all fs.
>>
>> But there, writeback is expected to be a temporary thing, not possibly:
>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
>>
>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
>> guarantees, and unfortunately, it sounds like this is the case here, unless
>> I am missing something important.
>>
> 
> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> the confusion. The writeback state is not indefinite. A proper fuse fs,
> like anyother fs, should handle writeback pages appropriately. These
> additional checks and skips are for (I think) untrusted fuse servers.

Can unprivileged user space provoke this case?

-- 
Cheers,

David / dhildenb


