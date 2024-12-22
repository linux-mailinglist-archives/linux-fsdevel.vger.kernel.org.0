Return-Path: <linux-fsdevel+bounces-38003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376C9FA37D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 03:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944BE166EE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2024 02:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC20FC08;
	Sun, 22 Dec 2024 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h0+tlxm9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439C847C
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734835671; cv=none; b=j4Fp+BxKWToANU5z1jIa07AL2WdI7A/tJVZJX1/WD1OwTTvemQzRehf0oJDaF481T7+MRm0RedQN5H1WD9RVqFI48GmfLkJtFMtvFuYPYR8ktc+aSPbwiOuA94B5MK5FVfxnMrSf0UWJw7ZPQiZdBXVyFgeMQfBP0FwztFfB8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734835671; c=relaxed/simple;
	bh=LvYmqomDFVg85hZI4ido1Nh6yaJX7scbQpvx79ZERAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jljMK40X25gk0VTvr0GoQbTFnnca5FDWi8HqGpcjVp8VwdjswX62VQypplEgJcYULazRJJwXNYAe0+jhWRK7e450gxZfW7BaK4pwRyx7otr+J9OnXwestDIsVLlesXPbwqy5c14nQqdvb3ykHPKbb1mXJ+uCUMOxlI4WklUUNEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h0+tlxm9; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734835661; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ztIIgXsGVtJzNjNG1ZvxiaISD/7oz9lzi8TKDCq5joA=;
	b=h0+tlxm9z2mrVEXBUm6DU8emvbOF0I/1v/H6CWS7xOJcPp/fKDwtZyG/9TGx2i6hr76+OlmeshQSL+1h7G2ukZxYDNOwy1S5A4l7t/fOVSO5A6faJsNK1YxYKnQnm4FA0xnMGSTJOWy95iljcRSVpZaTcYyunq3+GC051vlALbg=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLxdV9i_1734835658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Dec 2024 10:47:39 +0800
Message-ID: <df96d737-3e19-436d-a64a-420874647f48@linux.alibaba.com>
Date: Sun, 22 Dec 2024 10:47:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>,
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <67fec986-6a5d-4b1e-a86f-7ecccb1bccf5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/24 12:23 AM, David Hildenbrand wrote:
> On 21.12.24 03:28, Jingbo Xu wrote:
>>
>>
>> On 12/21/24 2:01 AM, Shakeel Butt wrote:
>>> On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
>>>>>> I'm wondering if there would be a way to just "cancel" the
>>>>>> writeback and
>>>>>> mark the folio dirty again. That way it could be migrated, but not
>>>>>> reclaimed. At least we could avoid the whole
>>>>>> AS_WRITEBACK_INDETERMINATE
>>>>>> thing.
>>>>>>
>>>>>
>>>>> That is what I basically meant with short timeouts. Obviously it is
>>>>> not
>>>>> that simple to cancel the request and to retry - it would add in quite
>>>>> some complexity, if all the issues that arise can be solved at all.
>>>>
>>>> At least it would keep that out of core-mm.
>>>>
>>>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we
>>>> should try to
>>>> improve such scenarios, not acknowledge and integrate them, then
>>>> work around
>>>> using timeouts that must be manually configured, and ca likely no be
>>>> default
>>>> enabled because it could hurt reasonable use cases :(
>>>
>>> Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
>>> parts. First is reclaim and second is compaction/migration. For reclaim,
>>> it is a must have as explained by Jingbo in [1] i.e. due to potential
>>> self deadlock by fuse server. If I understand you correctly, the main
>>> concern you have is its usage in the second case.
>>>
>>> The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
>>> to avoid untrusted fuse server causing pain to unrelated jobs on the
>>> machine (fuse folks please correct me if I am wrong here).
>>
>> Right, IIUC direct MIGRATE_SYNC migration won't be triggered on the
>> memory allocation path, i.e. the fuse server itself won't stumble into
>> MIGRATE_SYNC migration.
>>
> 
> Maybe memory compaction (on higher-order allocations only) could trigger
> it?
> 
> gfp_compaction_allowed() checks __GFP_IO. GFP_KERNEL includes that.
> 

But that (memory compaction on memory allocation, which can be triggered
in the fuse server process context) only triggers MIGRATE_SYNC_LIGHT,
which won't wait for writeback.

AFAICS, MIGRATE_SYNC can be triggered during cma allocation, memory
offline, or node compaction manually through sysctl.

-- 
Thanks,
Jingbo

