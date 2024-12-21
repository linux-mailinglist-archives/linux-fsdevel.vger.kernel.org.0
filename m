Return-Path: <linux-fsdevel+bounces-37996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E352C9F9DF3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 03:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534FA16B20A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 02:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFF80604;
	Sat, 21 Dec 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uhu1gA+c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676875C8F7
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734748145; cv=none; b=ETW3D7OxZQPl/GccIL5aHSCCS6iF39Jvv3PVoFkK1pEHK24x+jQeqrB+jev9TUfMKam533h5FTtN4/U28+0S+7BZfmVDSGFtabYlOb6/TSAhHnoYXvjiX2SZjyPzH50551P/f1g/rAFuuW0WPSkgaM6eAQDYufhGGACepqJ9lVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734748145; c=relaxed/simple;
	bh=xiQ2LHBlfQMnJUVgKdErA+bEKGpyoxqk0oiDEpuU4dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBqgLs9u1+OqnsIJlBr6MgDg7A7OqTMmgY2/xtA/b0qXvAkv6IJlFVUYqWgNigCLBYTswA3XovAfyqRbXWHTTqYwJmrlAQZ0+Zo2NEK0byLk1olA5kS69MSMgF49twYJtRMTpi7IJ9DMJ1NzcfB/X3gX42Nsog5RVfhxUyw0jJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uhu1gA+c; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734748140; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ufc1sYm3ZX2Mnt1hd5KSbUc+31XEX5/Da2G91Gd6wuE=;
	b=uhu1gA+c4WBWTuZKmx4EIZSUXO2NkkmA5Bf2UaHtkWFZ0S1+khD44K8o5SEokmlRFVX+dcwDfFNTM8zBCxO0UFkbDP4hOHa6Pp90C67XZoiSxhGWJ4L/yJeuK++CSonMsegx3sc8j2gMle4zt5qRwZtQS/SCIRbJTdp4z2xOgGg=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLv7aNo_1734748137 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 21 Dec 2024 10:28:58 +0800
Message-ID: <c163c6ab-6121-427c-ab06-58db2eea671b@linux.alibaba.com>
Date: Sat, 21 Dec 2024 10:28:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>,
 David Hildenbrand <david@redhat.com>
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
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/24 2:01 AM, Shakeel Butt wrote:
> On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
>>>> I'm wondering if there would be a way to just "cancel" the writeback and
>>>> mark the folio dirty again. That way it could be migrated, but not
>>>> reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
>>>> thing.
>>>>
>>>
>>> That is what I basically meant with short timeouts. Obviously it is not
>>> that simple to cancel the request and to retry - it would add in quite
>>> some complexity, if all the issues that arise can be solved at all.
>>
>> At least it would keep that out of core-mm.
>>
>> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should try to
>> improve such scenarios, not acknowledge and integrate them, then work around
>> using timeouts that must be manually configured, and ca likely no be default
>> enabled because it could hurt reasonable use cases :(
> 
> Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
> parts. First is reclaim and second is compaction/migration. For reclaim,
> it is a must have as explained by Jingbo in [1] i.e. due to potential
> self deadlock by fuse server. If I understand you correctly, the main
> concern you have is its usage in the second case.
> 
> The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
> to avoid untrusted fuse server causing pain to unrelated jobs on the
> machine (fuse folks please correct me if I am wrong here).

Right, IIUC direct MIGRATE_SYNC migration won't be triggered on the
memory allocation path, i.e. the fuse server itself won't stumble into
MIGRATE_SYNC migration.

-- 
Thanks,
Jingbo

