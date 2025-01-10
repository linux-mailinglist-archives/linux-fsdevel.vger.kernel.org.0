Return-Path: <linux-fsdevel+bounces-38910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F59BA09C59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D584188DE82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D1219A78;
	Fri, 10 Jan 2025 20:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGKozuo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B521A43D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540416; cv=none; b=mGaIR/pkSl01gvtJN94LDn3K76xTdOW2fRNSiA4+Z6ndc65pH5QtWuFtdzSxJkfYtd/s+JvpsR94f1kSQOsEpIxCIACMQbi4ibIuhYgrqmQ0YUuG67wYdEvRkUmLtmhmHM6F8Se3h+Jdj9GWe+s06/TbwCQmTY6d5KYyOJqVris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540416; c=relaxed/simple;
	bh=/yZz8KSgIuQ4P/TxIEVI40M+YrVJUKJYn4TPwP+GtHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egrlNIM/Uot/sBo6o+qS5sF7QVfVLGNS+z/G45f9CKz/iXIlmZBBwXq3ZxBFGyx9WaB2VrgYBz7RrBHA/L7X+AnMPBWxW9W5mk0BHIgyRCYh9Rq+sttnfLGsJZZKyEfRVo1SjPnsSmKtjYwecGEMYYqcGXGUxklw6zNuENQeuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGKozuo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736540413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nY8yoRck5g6DPpzhnQTcfFLR2hyIlNxN+mvjOdLSm5A=;
	b=gGKozuo5wt7fxvN5y+4MMILRcxsGWjUoCV6WPd+Qz247/qqfTM294OIKJUKyi3rsI40oJE
	91Ck6qm+xQYItsfyM3hJ2BM7Dc29up22D6YsTqPyLPaTAYIdJ6OfW4HBy40j+JMpl1btKD
	OJSsa9qOZzxlhxkNU2mg5C+mRo39cm0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-EFCNAKmXN2uzy_XjDn7iKQ-1; Fri, 10 Jan 2025 15:20:12 -0500
X-MC-Unique: EFCNAKmXN2uzy_XjDn7iKQ-1
X-Mimecast-MFC-AGG-ID: EFCNAKmXN2uzy_XjDn7iKQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so1266743f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 12:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540411; x=1737145211;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nY8yoRck5g6DPpzhnQTcfFLR2hyIlNxN+mvjOdLSm5A=;
        b=K4q8D9C8TWS4iAD2fCsh2o2g+Cdk2dIv260yDA5B5XjZU/+ay7Bb9Olkr9SChJWaWt
         2Wib2GlyZ1FsxI9k+zCJFR4TjN/V9+VSGi7Pryw7UGJ+UucGsuZGn1I6w1imUTMsBQhI
         2bE0TLsYJe+X+NEOy5ab46mxKs0/xy0Mk2yXuEY6sRracYseQINXRJALUGrZBix89w8L
         V46qLC3JYZOPeKr/xXV/m1SMSq6Br2/VjoNmaa0ZYwlVcjSFYzRDDQqxCy6yQXVmWcbc
         IMdIkfYV8mrl7woTROJ/uORWcnKT5t/g1wd3h+alfub5PFjpTr0Ot9p8yUUpAKAG9IDT
         CWqA==
X-Forwarded-Encrypted: i=1; AJvYcCUruvWBsnn1GRyXy0p7ne51GuBsQLXu2TCmdM7e+Tw5BaFPkw3DehTtYarYB+HwWOiGE/CREgZ5PZzParoc@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUp/tNeYj3vgoK+vw/SI8K7NqwLVXBZioliVNWKF2QOjgGjDN
	0nC5Gcp1C8m0qScKpNIc+oqZNzjENCyynGRzrUR1fn11ocmq03fUPWf82jVU7cxCWSiqSwrvtX5
	0Dm58sQeO/1F7BiThDpavFAlUDwsSsNvSfwg2c0KJO47WQ+DuOpAOxIyIeGJLa5E=
X-Gm-Gg: ASbGncvI2uWwIrumfsaBsI7kGugc5DDD0zJ4YIJvqQJw+8/BXX5R6ilU1JHIw+jb1KD
	bUMLtOZ1h8tMbEEiGO5a766WuHouqIwpMqxvaulTesOnwj8aYT6Fo75Jx6FZN83ZR6F0eHwgS/i
	txpzJdgjjJlqCgxZsekJmLfhcqhiF6SW8uh9FNR2y4Kr8NEOC0Lzh1j5L5/LsWBy/tcL6VJfeMc
	9DIDqSFQUgYtTBthi8djowdUfUJcgkmIQj0WDuztN9YdilSDQ9goFzRHaMMxEW3yk7ZHVwG1gFy
	HBfcK4vxMA8sATuM4waZXCo//orBZsmvrnTBqd1hZFrD9irhulsGeCDDPXjxLzeWhrobK+EgHav
	Ob8cKp4jE
X-Received: by 2002:a5d:47a6:0:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38a872f6a32mr10746687f8f.3.1736540411374;
        Fri, 10 Jan 2025 12:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJXQ6ttKbq3BVH3dMF1Wa+7en+jILXFE2hWmXl0H1iOQAgAB5aAgWt9KiDfBo9SCB6gVZbMQ==
X-Received: by 2002:a5d:47a6:0:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-38a872f6a32mr10746659f8f.3.1736540411010;
        Fri, 10 Jan 2025 12:20:11 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d012sm5360241f8f.8.2025.01.10.12.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 12:20:09 -0800 (PST)
Message-ID: <e4150b98-99ed-45fc-8485-5ad044f10d84@redhat.com>
Date: Fri, 10 Jan 2025 21:20:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Miklos Szeredi <miklos@szeredi.hu>
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
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com>
 <153c5a4f08daf60e1bbbdde02975392dc608cfdf.camel@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <153c5a4f08daf60e1bbbdde02975392dc608cfdf.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 21:16, Jeff Layton wrote:
> On Tue, 2025-01-07 at 09:34 +0100, David Hildenbrand wrote:
>> On 06.01.25 19:17, Shakeel Butt wrote:
>>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>>> In any case, having movable pages be turned unmovable due to persistent
>>>>> writaback is something that must be fixed, not worked around. Likely a
>>>>> good topic for LSF/MM.
>>>>
>>>> Yes, this seems a good cross fs-mm topic.
>>>>
>>>> So the issue discussed here is that movable pages used for fuse
>>>> page-cache cause a problems when memory needs to be compacted. The
>>>> problem is either that
>>>>
>>>>    - the page is skipped, leaving the physical memory block unmovable
>>>>
>>>>    - the compaction is blocked for an unbounded time
>>>>
>>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>>> worse, the same thing happens on readahead, since the new page can be
>>>> locked for an indeterminate amount of time, which can also block
>>>> compaction, right?
>>
>> Yes, as memory hotplug + virtio-mem maintainer my bigger concern is
>> these pages residing in ZONE_MOVABLE / MIGRATE_CMA areas where there
>> *must not be unmovable pages ever*. Not triggered by an untrusted
>> source, not triggered by an trusted source.
>>
>> It's a violation of core-mm principles.
>>
>> Even if we have a timeout of 60s, making things like alloc_contig_page()
>> wait for that long on writeback is broken and needs to be fixed.
>>
>> And the fix is not to skip these pages, that's a workaround.
>>
>> I'm hoping I can find an easy way to trigger this also with NFS.
>>
> 
> I imagine that you can just open a file and start writing to it, pull
> the plug on the NFS server, and then issue a fsync or something to
> ensure some writeback occurs.

Yes, that's the plan, thanks!

> 
> Any dirty pagecache folios should be stuck in writeback at that point.
> The NFS client is also very patient about waiting for the server to
> come back, so it should stay that way indefinitely.

Yes, however the default timeout for UDP is fairly small (for TCP 
certainly much longer). So one thing I'd like to understand what that 
"cancel writeback -> redirty folio" on timeout does, and when it 
actually triggers with TCP vs UDP timeouts.

-- 
Cheers,

David / dhildenb


