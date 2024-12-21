Return-Path: <linux-fsdevel+bounces-38000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B19FA19A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 17:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D2B188E51D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC8154BE4;
	Sat, 21 Dec 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Haojpt0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E51C32
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734798199; cv=none; b=TLVqbKZ5vMrOcNzTn5ZLymjI7/An5Txnwe0Avbyy02jCumXSpL/a4nAPYgjcrr42BuBlxkto+Qnletfd+Rd9QEC7Z77+828JKJKJjz+wy8wewvLa1LhBaHdG+FkFStpGbeWboJAW3wctOF7iBy9sm3rV7r1EvJU1Prsix2XLCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734798199; c=relaxed/simple;
	bh=a2abPPwGvpqX2Tu22KhDi6V10l4IwjexWLD8rDble/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUWSFHEGPEHqyTc+9d2TrQep9FcV+iJq9gubpoEOQn/4U3+rMqh3MTzkTbrHWU6JyIuVjeZJm1t/MH8FGO5HivFwTyjc9wT/Won33nEVfxtlArZ0fvS/kF1/mEfUwePjcI6R50H6Hcf6peEoBHZj8enUoLO6NnBrv4gStzqC7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Haojpt0+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734798196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OyA/4MkklvOkQsa6hBsrldWiTQNtCVN07PxXz/z1/Ro=;
	b=Haojpt0+7FedkXVWxgvZLDoevRL2H90C2dOKAKkBb2firotCqdhhsdwaU1LCioOLXBGeFD
	JwgetmPAVFY784bj9Cdx8gxeAoquvwpmKrZ8bQHU5H7QOV96RILnFZsAAAxi0o2YRh5/5r
	IRg2iep+AHn8ljFKaQAqxRuNOUqvtcs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-8j_kd3qaNG-KdMB3Yh9CnA-1; Sat, 21 Dec 2024 11:23:14 -0500
X-MC-Unique: 8j_kd3qaNG-KdMB3Yh9CnA-1
X-Mimecast-MFC-AGG-ID: 8j_kd3qaNG-KdMB3Yh9CnA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso21566715e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 08:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734798194; x=1735402994;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OyA/4MkklvOkQsa6hBsrldWiTQNtCVN07PxXz/z1/Ro=;
        b=Wn4H5MOSODpui2MECG7EACw7lb0gN9C9HuA68QaXhLgOV96JyPLr8J3lTNTxNCZv2L
         61/i/J76lfCJzffvUHYgkA2sYRVL5DQ+ILjsM7N97TjVVrdms8BwlWwK84W5yNZErHJh
         5oKfTjEWREUdZjdpNZeF4kzg2ejVoMbFJmvl70eLZtcCfH/3fEQgL5NBonjCosPQhBUp
         bB9rPTsoMSbfbSPO3JVqHzpA/vb+hAYgMWRfqAukS4k2ty3WYlj5ZYKOtUJ13Y7YL6Kl
         os3Q3aWXotfk8xLbaXHEgcU6C9dcMPU/Cftwy8/c4hAPLz9cHPbkQRb+py8sEiP9RCVP
         XGKg==
X-Forwarded-Encrypted: i=1; AJvYcCVIJMeo05sKA8Oxzl2AX4Zyu3qyQV8fxtKWiazGLPEZ0DC0YAid0z+tpekYAqPcmnJfSd+G9EjMOsbuvdLW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nh0ldFKIFv8MMfJKil+Zt/aMc/AbWLfMY5/Ws0xejvDfkbJy
	cvkqoVXYbCmAkkSoALDFRot5XGSZBhsA79zFZQEOt/do6Z9I06cNEiQE9FbQclv5+6Tptxd7ttl
	kUnaOr1sOIWR89SEKafptEvQGkJ8lRR02hEWJeg2O4TgCz4zMcqCixJ3TawCV3k0=
X-Gm-Gg: ASbGncthM4ckqiMrM9vGLWhETm5i56B7059ocBgmL9jpqJZ5zmT5xOBLMnhcMAf6N9J
	a7xkeRzkKHYAlD1DaV/byFmm/vbuOXYlq9iA9LbZOhAviaAFRjSbJB/gbtsRohDSufgvuIpGo14
	CIlWP3Pe/MLiFJPdPUDvJ3ANEUq1kmyF/JhE0P2QFpHVmoAHRULdzBfRdhFj35HsTw1bAQ4A1Ui
	fI4XVxWr6+wyI/hCeiFVQhvo3q+TZG1tvJvyCGBIjBK5qYar7ZHZ8RMD0WfrA5mWiDvGSVwML2V
	vURCSojyAlL6AilDNzjgLgrEZLI/jFuPAqvBhM6lbNfNZBZO089gePcF5HFcKLA+ODv4I0Rvfsz
	TJtBil3zo
X-Received: by 2002:a5d:6da3:0:b0:386:32ea:e70d with SMTP id ffacd0b85a97d-38a223fd30dmr4868133f8f.50.1734798193741;
        Sat, 21 Dec 2024 08:23:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG98ZQgx6Xc851KJcM+qaC+Qh+kNdEwRZVkn/B0ViKWg9G0l3WAdGBa54UOAqvG8GzJsY7Vzg==
X-Received: by 2002:a5d:6da3:0:b0:386:32ea:e70d with SMTP id ffacd0b85a97d-38a223fd30dmr4868100f8f.50.1734798193207;
        Sat, 21 Dec 2024 08:23:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:d000:4622:73e7:6184:8f0d? (p200300cbc70ed000462273e761848f0d.dip0.t-ipconnect.de. [2003:cb:c70e:d000:4622:73e7:6184:8f0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828e3fsm6928799f8f.5.2024.12.21.08.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 08:23:12 -0800 (PST)
Message-ID: <67fec986-6a5d-4b1e-a86f-7ecccb1bccf5@redhat.com>
Date: Sat, 21 Dec 2024 17:23:10 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c163c6ab-6121-427c-ab06-58db2eea671b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.12.24 03:28, Jingbo Xu wrote:
> 
> 
> On 12/21/24 2:01 AM, Shakeel Butt wrote:
>> On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
>>>>> I'm wondering if there would be a way to just "cancel" the writeback and
>>>>> mark the folio dirty again. That way it could be migrated, but not
>>>>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>>>>> thing.
>>>>>
>>>>
>>>> That is what I basically meant with short timeouts. Obviously it is not
>>>> that simple to cancel the request and to retry - it would add in quite
>>>> some complexity, if all the issues that arise can be solved at all.
>>>
>>> At least it would keep that out of core-mm.
>>>
>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should try to
>>> improve such scenarios, not acknowledge and integrate them, then work around
>>> using timeouts that must be manually configured, and ca likely no be default
>>> enabled because it could hurt reasonable use cases :(
>>
>> Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
>> parts. First is reclaim and second is compaction/migration. For reclaim,
>> it is a must have as explained by Jingbo in [1] i.e. due to potential
>> self deadlock by fuse server. If I understand you correctly, the main
>> concern you have is its usage in the second case.
>>
>> The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
>> to avoid untrusted fuse server causing pain to unrelated jobs on the
>> machine (fuse folks please correct me if I am wrong here).
> 
> Right, IIUC direct MIGRATE_SYNC migration won't be triggered on the
> memory allocation path, i.e. the fuse server itself won't stumble into
> MIGRATE_SYNC migration.
> 

Maybe memory compaction (on higher-order allocations only) could trigger it?

gfp_compaction_allowed() checks __GFP_IO. GFP_KERNEL includes that.

-- 
Cheers,

David / dhildenb


