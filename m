Return-Path: <linux-fsdevel+bounces-38552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BDA039DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 09:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633B67A1EB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC41DFE15;
	Tue,  7 Jan 2025 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuCLh9mb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1013B58D
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238903; cv=none; b=h5nZkNw2aL5OzhWUfhLu7T5s5iy8I7l8CBGm1IN6G/B6/u5d2BdUtZPijecAW5jgBzVh26GN59sVYiUkjTGsF1clbc8bm8y3FKfIPiUfc+hOcHvDfgVU2LUcjuxnAtLVFPsz6HF6nTK0A0k1yxLYlz+gVvhTQIU1d6B9zT29cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238903; c=relaxed/simple;
	bh=RhZYO5Oloh8PMUVt9jm9IzUrJkAXt3wSScw7ykdnsc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adVcegIjchjYk29D8vCmZu1byTO7uSeOI+j0a2z8CDuCbWytZpuZHofyMRc+nz0JCXCoUzGLcg69V+QBt6wxkSmP0NwS+8arbLN3zKAoqnff+xXFzm7TXBev1uoxiL4oiQEFSQeSm1CqZf397v7jj5bbmER1ehX1HAalCvB4/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SuCLh9mb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736238900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCbYbODhpQNeLRpCPiVykcdt6MhNYv7GJGIswMcGZCQ=;
	b=SuCLh9mb5gn/V4zaqq55hQHHVGe/JiTvwIDG6OEfFL2WW3NYfCBsmXYQbbfczwFmb6F56A
	x/BlLPNzNxd9b2OzjBGpTpq6EQqm/Cai13yJjwj9rOsnjv83W+vP0xcdiMj/5y1YJtD6Lt
	thHCsBakYCWB6msZ7uefIQ92zXZ7RDE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-pJteFg3EMTCC8mCM6AjMcQ-1; Tue, 07 Jan 2025 03:34:59 -0500
X-MC-Unique: pJteFg3EMTCC8mCM6AjMcQ-1
X-Mimecast-MFC-AGG-ID: pJteFg3EMTCC8mCM6AjMcQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e03f54d0so6727237f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 00:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736238898; x=1736843698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCbYbODhpQNeLRpCPiVykcdt6MhNYv7GJGIswMcGZCQ=;
        b=fLYa31AJ1NtfwrL6bzF2iZKHZAjFNw3wYeVCp5Ci79TVcUFSwIDRkAtuznPtqrGjjo
         PVUVmePoz2GNJ2dbDK2pDxLeJMYi2McIE2kQ4tZe8DEPAiaw1C433ZOzJ3SdrQZuA2Fy
         D7Zosk3C0svG/wm9QfsRAPJeZzNOeX9DzFNIKdBw06JtS01QDdA2t6HZXqkvMoZaQ21/
         45MfNwA6FyFLDCYFVHosWgSkym1p5o3b3we9n/nvreK/K7A2Q93bTlUSTAmm4vGrmJ98
         q4g19HPCMaTPMAI1oYL3dEHjXTJkrHlDaQmolz6V9E+3sVEz6/ivOh0AblIRZB6VFVR4
         N47A==
X-Forwarded-Encrypted: i=1; AJvYcCVOq0zI7fbb6Cs13gtkVLx8LsRtVuAIuumUO3ByEFVVPa+wH5MH26DHMLWPBfg5cA+8Z0QQ8WNfVSam+rJi@vger.kernel.org
X-Gm-Message-State: AOJu0YzpG9D6iusgULQzNqmx3hs/x0j8HbhcCR/gUp4P6XUH3OB6b2rB
	FDpmRdKy+nQihugBgMoB0JaFlDjwvAO9KOq7aj8vczLen36/gAw2bzBMdcySA+gEnK65VxhDYT9
	+Jn29SmG2b4rc6qYP9tU+Crug8LlEzJOLw29arU2q+2N26fsURO3spZJL+hDEmTM=
X-Gm-Gg: ASbGncuM/tzweWOTXPyAHAqGgkdj33MmswTq9Zu8Kuds7+QVMvho9nivcPvc++m12m2
	cDvehdAoklmMn4n1FTVX3S2e8HHGs2m9gQLmm5Z5FtLyYmqy5C7w3k/bkdsg4XHXsXyBJpEZJ4P
	frIR3jkQ21tSA/1dxCdd7haXSOID5aEcH819duwxm2QeVhjDUlv5u1qJgQcndytLINTfV/xRTzy
	zal015Fi5XrkIjbacASM+GNkwKR5zBRimzQgEZfTBSBqx8Z7+JbJawgUBaIiNIRGqo6TBmG/z12
	aeMIjZsGYTS+L5S2k1097dVvjQFTcfbUvCqFOMretfSyuDE6jKBA4oD1Njijt1UyZKXyr7ghmUz
	FJB4RY457
X-Received: by 2002:adf:b30b:0:b0:38a:673b:3738 with SMTP id ffacd0b85a97d-38a673b37a7mr11361372f8f.33.1736238897824;
        Tue, 07 Jan 2025 00:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2+LXIgSww26Bx+LyfV93heNDjTLdiMWLvVRn4LJJqUS4/qbRq3COHvRdxLaDyPZMAt96CsQ==
X-Received: by 2002:adf:b30b:0:b0:38a:673b:3738 with SMTP id ffacd0b85a97d-38a673b37a7mr11361342f8f.33.1736238897369;
        Tue, 07 Jan 2025 00:34:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3? (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828f8fsm49103562f8f.12.2025.01.07.00.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 00:34:56 -0800 (PST)
Message-ID: <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
Date: Tue, 7 Jan 2025 09:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.01.25 19:17, Shakeel Butt wrote:
> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>> In any case, having movable pages be turned unmovable due to persistent
>>> writaback is something that must be fixed, not worked around. Likely a
>>> good topic for LSF/MM.
>>
>> Yes, this seems a good cross fs-mm topic.
>>
>> So the issue discussed here is that movable pages used for fuse
>> page-cache cause a problems when memory needs to be compacted. The
>> problem is either that
>>
>>   - the page is skipped, leaving the physical memory block unmovable
>>
>>   - the compaction is blocked for an unbounded time
>>
>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>> worse, the same thing happens on readahead, since the new page can be
>> locked for an indeterminate amount of time, which can also block
>> compaction, right?

Yes, as memory hotplug + virtio-mem maintainer my bigger concern is 
these pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there 
*must not be unmovable pages ever*. Not triggered by an untrusted 
source, not triggered by an trusted source.

It's a violation of core-mm principles.

Even if we have a timeout of 60s, making things like alloc_contig_page() 
wait for that long on writeback is broken and needs to be fixed.

And the fix is not to skip these pages, that's a workaround.

I'm hoping I can find an easy way to trigger this also with NFS.

> 
> Yes locked pages are unmovable. How much of these locked pages/folios
> can be caused by untrusted fuse server?
 > >>
>> What about explicitly opting fuse cache pages out of compaction by
>> allocating them form ZONE_UNMOVABLE?
> 
> This can be done but it will change the memory condition of the
> users/workloads/systems where page cache is the majority of the memory
> (i.e. majority of memory will be unmovable) and when such systems are
> overcommitted, weird corner cases will arise (failing high order
> allocations, long term fragmentation etc). In addition the memory
> behind CXL will become unusable for fuse folios.

Yes.

> 
> IMHO the transient unmovable state of fuse folios due to writeback is
> not an issue if we can show that untrusted fuse server can not cause
> unlimited folios under writeback for arbitrary long time.

See above, I disagree.

-- 
Cheers,

David / dhildenb


