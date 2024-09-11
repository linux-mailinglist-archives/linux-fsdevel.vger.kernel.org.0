Return-Path: <linux-fsdevel+bounces-29083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D08974E97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 11:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B751F22135
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 09:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56A18592A;
	Wed, 11 Sep 2024 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uK60i7nN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17417C21B;
	Wed, 11 Sep 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047173; cv=none; b=Yd9rZNEpqUGvr1TmwBOeuKRRK6FSrSW+LR8vnLZQd8TgPGtoGJqdvT2qNFwkKZpeGkcxqE/G4DdKu6YVXrSHrXJQ531113WYvWqqSH5p7v9ktmCevByWm7b193yBTiRY7XE5E4AI3jq1SEDpDoFUU/B9PifKC4oFzRjjlLSknsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047173; c=relaxed/simple;
	bh=bZ0GiGRefmi0Uyt4MyuRgUCJ9BimgVExP7271wvtOOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzkHcq+7Kmx8JNAcSt/YZ9002Z31MNCIJDE/WrEP3gSAFG4ySXRdDx0qvBACOsLdornp3rw9AJx/cN8yNqVXD6vT4oLLcJfeMh9jr+CMtLIQqE2M1tZ5+o7FKFJjfJd7annPsrzznp6wJ2fye5H/Qlru1/MkxOj04x8FYPrEqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uK60i7nN; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726047167; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YkVOUfuexb9zXWhceRcyWqd+dl3lU8/cr/JNYHTEx/Q=;
	b=uK60i7nNRO9MbneOiglLLexDze0ZhlfLcsF6SdYZo5q4Kdf9AwOY9h+sZcuHf/UX335CY8GGCyyEV5CJzJajg5LES++b/roRPnYGhUmOJ3MNXxtMffFTT4N87XmrgtHLVFmFt1RFoNOThzI/sqtlyK72U6oxBmZ3IwVW8HVifuY=
Received: from 30.221.145.65(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WEnSDCq_1726047165)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 17:32:46 +0800
Message-ID: <19ffac65-8e1f-431e-a6bd-f942a4b908fe@linux.alibaba.com>
Date: Wed, 11 Sep 2024 17:32:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>,
 Dave Chinner <david@fromorbit.com>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 6/4/24 3:27 PM, Miklos Szeredi wrote:
> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> IIUC, there are two sources that may cause deadlock:
>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>> requests, which in turn triggers direct memory reclaim, and FUSE
>> writeback then - deadlock here
> 
> Yep, see the folio_wait_writeback() call deep in the guts of direct
> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
> happens to be triggered by the writeback in question, then that's a
> deadlock.

After diving deep into the direct reclaim code, there are some insights
may be helpful.

Back to the time when the support for fuse writeback is introduced, i.e.
commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, the
direct reclaim indeed unconditionally waits for PG_writeback flag being
cleared.  At that time the direct reclaim is implemented in a two-stage
style, stage 1) pass over the LRU list to start parallel writeback
asynchronously, and stage 2) synchronously wait for completion of the
writeback previously started.

This two-stage design and the unconditionally waiting for PG_writeback
flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
stall on writeback during memory compaction") since v3.5.

Though the direct reclaim logic continues to evolve and the waiting is
added back, now the stall will happen only when the direct reclaim is
triggered from kswapd or memory cgroup.

Specifically the stall will only happen in following certain conditions
(see shrink_folio_list() for details):
1) kswapd
2) or it's a user process under a non-root memory cgroup (actually
cgroup_v1) with GFP_IO permitted

Thus the potential deadlock does not exist actually (if I'm not wrong) if:
1) cgroup is not enabled
2) or cgroup_v2 is actually used
3) or (memory cgroup is enabled and is attached upon cgroup_v1) the fuse
server actually resides under the root cgroup
4) or (the fuse server resides under a non-root memory cgroup_v1), but
the fuse server advertises itself as a PR_IO_FLUSHER[1]


Then we could considering adding a new feature bit indicating that any
one of the above condition is met and thus the fuse server is safe from
the potential deadlock inside direct reclaim.  When this feature bit is
set, the kernel side could bypass the temp page copying when doing
writeback.


As for the condition 4 (PR_IO_FLUSHER), there was a concern from
Miklos[2].  I think the new feature bit could be disabled by default,
and enabled only when the fuse server itself guarantees that it is in a
safe distribution condition.  Even when it's enabled either by a mistake
or a malicious fuse server, and thus causes a deadlock, maybe the
sysadmin could still abort the connection through the abort sysctl knob?


Just some insights and brainstorm here.


[1] https://lore.kernel.org/all/Zl4%2FOAsMiqB4LO0e@dread.disaster.area/
[2]
https://lore.kernel.org/all/CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx92T8W6uQ@mail.gmail.com/



-- 
Thanks,
Jingbo

