Return-Path: <linux-fsdevel+bounces-38094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 353889FBCED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7160B7A14E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7261B85FD;
	Tue, 24 Dec 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0aJs5Xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21111B413B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735039947; cv=none; b=iB+r+1MbKl9s9xMD3WxvhU2IG/k+PjvX2jiMIYsav83pU2++tM4sg5p+tZuy5zwQBgZA1H3K2cDfh3p3Im19wP36bu0KOJor/l/kUHagfUfzcg3tLy88pj++3/Ozjz7VJM9XF5BIt+o+7aFsz/ikDuEm0roilxnYnE2GTYr5jtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735039947; c=relaxed/simple;
	bh=mjn3z7X8qllPyMGyHB3MWTm4K2jwXWH9Qb8LYGIJfck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLWyC/TK0pptmYvtXkXOfcRobPvKAVe6uEiC/VCjqn0IIXXAwRtEXcHMwy4j13KuPS3rgEmMx0dYioBNp6O/ASdn1QkhoLPSO+waJKT7H4dp4QjRtdQOGUGLLwmftJBtYJlyFxMlYjcf8yYAHUSANVgjyImz0PGcORAOChaPxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0aJs5Xv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735039945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zq5CZhJaE3S+LPsDqonuc2z4gFeVzKhxUxClFg/4HOA=;
	b=M0aJs5XvyUANNloGXDyDFIkXGS7SCb/lKMzfmUSo25QkHH+O8m+ceHFwzjtQ6X3gFC4tqC
	PoeMK87Q7WkkR+6MEINTNE+jMN2RUJUUQGRDPio/gAfFKD4BplyhIAy1eSBi3JsBopIRwu
	OQSFhzUwtF0HfsiS5fqIXsK9cxFSNuE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651--D7eaVfBOsSLO6rmWlZXeA-1; Tue, 24 Dec 2024 06:32:23 -0500
X-MC-Unique: -D7eaVfBOsSLO6rmWlZXeA-1
X-Mimecast-MFC-AGG-ID: -D7eaVfBOsSLO6rmWlZXeA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436219070b4so25610965e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 03:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039942; x=1735644742;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zq5CZhJaE3S+LPsDqonuc2z4gFeVzKhxUxClFg/4HOA=;
        b=HJnyLzPBVyfMJnOcSAggYu0Rc3R/HCbAw4vXBZd8A+lFdBtx0zFDr7lWkYKFckkBe6
         CE/JAT+stQKNzcHu9Vfn1gl1Cbmgwll6ieTGuqZtDzjgdZu+/sVr0c50UQUuillD9efe
         MflwxravKG8qZPZ/LdoWRyWmEm3mm16LZRwa6ml87Eh3TQsy3WOH0jk+GtSNIxdWG6hz
         hGv6WJf31Kh/uSeJR2LGjn2sL2QkZZQtt4T9bf+Jj+d5JrooJLIbD7KIwQdz/6EHWEgU
         mMTfN/PRCN4JrBRbjAT6OqnWe74d82NQ/P8E9JYJ/Mfdci4m8eD0j8VZkZZ4DPGsgFK8
         G0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUMuoezmjZKncf+SEzKj38xcAStDo4M6taqV2fDhrniSozwYablk0CxYCcp62flN0f3LFLKxvqppCqYvqWB@vger.kernel.org
X-Gm-Message-State: AOJu0YxODJek/9VctXhE672cHidKQttnZQVCU3Gcw1ttpxg6RaHW5cXp
	MHuWnaEAzcMOaTgJMXctYBUVTFGHBVeLk1V8j9xzTALN8NXZPyax6MCuuSrKNB6XynQ/N4V2tye
	a2bOtVKI2CW9l7uommVDVa/fWNfViYy/T3ieeIsCGE/T9uKP/gLxuiIYoY1/lDGc=
X-Gm-Gg: ASbGncu7bUrv1y0Piqfln6fhj9+NOwMbXwEdeTtKdvU+TVnXaRBR7q2UobqH6lvrd+s
	lmLJlt3YpFGLjZdX89Vmba1iM9QrZTZfuF9GOHOtAgVGpFEdgtosUM4MHYUSr69HBYQFrxvq7xE
	lWYmGBZz5+hDnv8M8fBX5XLtNXiC/w7bN3cyb9z/OviFTXBNUlUzFsZye9+nRbKM2p/P0yr7zhV
	ygpGuMNHaTIhlaoXSi9b5p/IUuwA7FKLIx7Y2pGJMwXD1q23wEaFX+k9A3xyClpHjjeEyoXCtOF
	W4mZ15LGkbBcZjXCLQl+CT5kSHUbxgfhZZ/PagIaigV1DEG1i9EUP+vsy669W1iwlzPSEYCe4oj
	Ao2Xzi0RD
X-Received: by 2002:a05:600c:35cb:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-4366864379bmr136611225e9.14.1735039942670;
        Tue, 24 Dec 2024 03:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSfbu7IGGp08cMZa/I+c8o61Dv+XiLZTcJJ14S2wPqpkwqSb7pZ+PS3vRCTP+IRg8+Iy2bGg==
X-Received: by 2002:a05:600c:35cb:b0:436:1c04:aa9a with SMTP id 5b1f17b1804b1-4366864379bmr136611015e9.14.1735039942341;
        Tue, 24 Dec 2024 03:32:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:da00:e63f:f575:6b1a:df4e? (p200300cbc72ada00e63ff5756b1adf4e.dip0.t-ipconnect.de. [2003:cb:c72a:da00:e63f:f575:6b1a:df4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm197359065e9.41.2024.12.24.03.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:32:21 -0800 (PST)
Message-ID: <05d22a0e-013d-4c1e-bffa-820ad88983ef@redhat.com>
Date: Tue, 24 Dec 2024 12:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>,
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 linux-mm@kvack.org, kernel-team@meta.com,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <c163c6ab-6121-427c-ab06-58db2eea671b@linux.alibaba.com>
 <67fec986-6a5d-4b1e-a86f-7ecccb1bccf5@redhat.com>
 <df96d737-3e19-436d-a64a-420874647f48@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <df96d737-3e19-436d-a64a-420874647f48@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.12.24 03:47, Jingbo Xu wrote:
> 
> 
> On 12/22/24 12:23 AM, David Hildenbrand wrote:
>> On 21.12.24 03:28, Jingbo Xu wrote:
>>>
>>>
>>> On 12/21/24 2:01 AM, Shakeel Butt wrote:
>>>> On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
>>>>>>> I'm wondering if there would be a way to just "cancel" the
>>>>>>> writeback and
>>>>>>> mark the folio dirty again. That way it could be migrated, but not
>>>>>>> reclaimed. At least we could avoid the whole
>>>>>>> AS_WRITEBACK_INDETERMINATE
>>>>>>> thing.
>>>>>>>
>>>>>>
>>>>>> That is what I basically meant with short timeouts. Obviously it is
>>>>>> not
>>>>>> that simple to cancel the request and to retry - it would add in quite
>>>>>> some complexity, if all the issues that arise can be solved at all.
>>>>>
>>>>> At least it would keep that out of core-mm.
>>>>>
>>>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we
>>>>> should try to
>>>>> improve such scenarios, not acknowledge and integrate them, then
>>>>> work around
>>>>> using timeouts that must be manually configured, and ca likely no be
>>>>> default
>>>>> enabled because it could hurt reasonable use cases :(
>>>>
>>>> Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
>>>> parts. First is reclaim and second is compaction/migration. For reclaim,
>>>> it is a must have as explained by Jingbo in [1] i.e. due to potential
>>>> self deadlock by fuse server. If I understand you correctly, the main
>>>> concern you have is its usage in the second case.
>>>>
>>>> The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
>>>> to avoid untrusted fuse server causing pain to unrelated jobs on the
>>>> machine (fuse folks please correct me if I am wrong here).
>>>
>>> Right, IIUC direct MIGRATE_SYNC migration won't be triggered on the
>>> memory allocation path, i.e. the fuse server itself won't stumble into
>>> MIGRATE_SYNC migration.
>>>
>>
>> Maybe memory compaction (on higher-order allocations only) could trigger
>> it?
>>
>> gfp_compaction_allowed() checks __GFP_IO. GFP_KERNEL includes that.
>>
> 
> But that (memory compaction on memory allocation, which can be triggered
> in the fuse server process context) only triggers MIGRATE_SYNC_LIGHT,
> which won't wait for writeback.
> 

Ah, that makes sense.

> AFAICS, MIGRATE_SYNC can be triggered during cma allocation, memory
> offline, or node compaction manually through sysctl.

Right, non-proactive compaction always uses MIGRATE_SYNC_LIGHT, that 
won't wait.

-- 
Cheers,

David / dhildenb


