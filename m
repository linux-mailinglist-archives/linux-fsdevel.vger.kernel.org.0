Return-Path: <linux-fsdevel+bounces-29275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0CF977769
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 05:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D91C2447E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 03:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9B6F315;
	Fri, 13 Sep 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ktc0h/d2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B513D882;
	Fri, 13 Sep 2024 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198519; cv=none; b=EKK042UVDP1wWOwyT9Nld4mG+1dNmk5+duZyKzY8R1xu9XyW+WcajVio4EykYhGWahszEYXo7ecgUeKUVaJPRCHxjKdxpdUboV+bi2MNneUnVi8YheaBB7etoJR9I2bIM0j/KNY/MtpOpuMVv5V/sDWAqyvS26o+wjatfodvnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198519; c=relaxed/simple;
	bh=UcXzGLFGnaw/tGTsOLq+PsYah85pOdzTLcUIRcm2FNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c32OAGFxZoMu8KQAY0UetIPt+YIXECDE8Fy/C/IWjtNwoaIgblnlqHBxsXGmbOTb4N2cumUd7J5d7wh/8WyS5TDalFHbO5K0hUW9y2U2SQXttneqhne2xlFnKp/zGa3OdZgb3ihlR7kjgcpLuSHx8lGTER10oZ7gbU9wImaDWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ktc0h/d2; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726198508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CaH9uISZWQ5XuSjgSdzz/6snX0bQtLXyo2HqABBtYXk=;
	b=ktc0h/d2ZNG687cU7Dne9/Rl1vLFS7yzUberjo/dbRa1bA+0WSV022tLE0bygnUvwpIuKLuPEd/K6hNFjsAdKVXbokZZipF0i+pEpNL4tXd9BmiObGJpDucxw2C3r+5egQ9P2qxjL/vKSW33pwe2nIncqi9XKocwl+A+WdFyeNI=
Received: from 30.221.145.1(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WEtHkSG_1726198506)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 11:35:07 +0800
Message-ID: <ce7a056d-e4f1-4606-b119-f8e21bbfff55@linux.alibaba.com>
Date: Fri, 13 Sep 2024 11:35:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Dave Chinner <david@fromorbit.com>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <19ffac65-8e1f-431e-a6bd-f942a4b908fe@linux.alibaba.com>
 <CAJnrk1bcN4k8Ou6xp20Zd5W3k349T3S=QGmxAVmAkF5=B5bq3w@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1bcN4k8Ou6xp20Zd5W3k349T3S=QGmxAVmAkF5=B5bq3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/13/24 7:18 AM, Joanne Koong wrote:
> On Wed, Sep 11, 2024 at 2:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
>>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>>> IIUC, there are two sources that may cause deadlock:
>>>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>>>> requests, which in turn triggers direct memory reclaim, and FUSE
>>>> writeback then - deadlock here
>>>
>>> Yep, see the folio_wait_writeback() call deep in the guts of direct
>>> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
>>> happens to be triggered by the writeback in question, then that's a
>>> deadlock.
>>
>> After diving deep into the direct reclaim code, there are some insights
>> may be helpful.
>>
>> Back to the time when the support for fuse writeback is introduced, i.e.
>> commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, the
>> direct reclaim indeed unconditionally waits for PG_writeback flag being
>> cleared.  At that time the direct reclaim is implemented in a two-stage
>> style, stage 1) pass over the LRU list to start parallel writeback
>> asynchronously, and stage 2) synchronously wait for completion of the
>> writeback previously started.
>>
>> This two-stage design and the unconditionally waiting for PG_writeback
>> flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
>> stall on writeback during memory compaction") since v3.5.
>>
>> Though the direct reclaim logic continues to evolve and the waiting is
>> added back, now the stall will happen only when the direct reclaim is
>> triggered from kswapd or memory cgroup.
>>
>> Specifically the stall will only happen in following certain conditions
>> (see shrink_folio_list() for details):
>> 1) kswapd
>> 2) or it's a user process under a non-root memory cgroup (actually
>> cgroup_v1) with GFP_IO permitted
>>
>> Thus the potential deadlock does not exist actually (if I'm not wrong) if:
>> 1) cgroup is not enabled
>> 2) or cgroup_v2 is actually used
>> 3) or (memory cgroup is enabled and is attached upon cgroup_v1) the fuse
>> server actually resides under the root cgroup
>> 4) or (the fuse server resides under a non-root memory cgroup_v1), but
>> the fuse server advertises itself as a PR_IO_FLUSHER[1]
>>
>>
>> Then we could considering adding a new feature bit indicating that any
>> one of the above condition is met and thus the fuse server is safe from
>> the potential deadlock inside direct reclaim.  When this feature bit is
>> set, the kernel side could bypass the temp page copying when doing
>> writeback.
>>
> 
> Hi Jingbo, thanks for sharing your analysis of this.
> 
> Having the temp page copying gated on the conditions you mentioned
> above seems a bit brittle to me. My understanding is that the mm code
> for when it decides to stall or not stall can change anytime in the
> future, in which case that seems like it could automatically break our
> precondition assumptions.

So this is why PR_IO_FLUSHER is introduced here, which is specifically
for user space components playing a role in IO stack, e.g. fuse daemon,
tcmu/nbd daemon, etc.  PR_IO_FLUSHER offers guarantee similar to
GFP_NOIO, but for user space components.  At least we can rely on the
assumption that mm would take PR_IO_FLUSHER into account.

The limitation of the PR_IO_FLUSHER approach is that, as pointed by
Miklos[1], there may be multiple components or services involved to
service the fuse requests, and the kernel side has no effective way to
check if all services in the whole chain have set PR_IO_FLUSHER.


> Additionally, if I'm understanding it
> correctly, we also would need to know if the writeback is being
> triggered from reclaim by kswapd - is there even a way in the kernel
> to check that?

Nope.  What I mean in the previous email is that, kswapd can get stalled
in direct reclaim, while the normal process, e.g. the fuse server, may
not get stalled in certain condition, e.g. explicitly advertising
PR_IO_FLUSHER.

> 
> I'm wondering if there's some way we could tell if a folio is under
> reclaim when we're writing it back. I'm not familiar yet with the
> reclaim code, but my initial thoughts were whether it'd be possible to
> purpose the PG_reclaim flag or perhaps if the folio is not on any lru
> list, as an indication that it's being reclaimed. We could then just
> use the temp page in those cases, and skip the temp page otherwise.

That is a good idea but I'm afraid it doesn't works.  Explained below.

> 
> Could you also point me to where in the reclaim code we end up
> invoking the writeback callback? I see pageout() calls ->writepage()
> but I'm not seeing where we invoke ->writepages().

Yes, the direct reclaim would end up calling ->writepage() to writeback
the dirty page.  ->writepages() is only called in normal writeback
routine, e.g. when triggered from balance_dirty_page().

Also FYI FUSE has removed ->writepage() since commit e1c420a ("fuse:
Remove fuse_writepage"), and now it relies on ->migrate_folio(), i.e.
memory compacting and the normal writeback routine (triggered from
balance_dirty_page()) in low memory.

Thus I'm afraid the approach of doing temp page copying only for
writeback from direct reclaim code actually doesn't work.  That's
because when doing the direct reclaim, the process not only waits for
the writeback completion submitted from direct reclaim (e.g. marked with
PG_reclaim, by ->writepage), but may also waits for that submitted from
the normal writeback routine (without PG_reclaim marked, by
->writepages). See commit c3b94f4 ("memcg: further prevent OOM with too
many dirty pages").



[1]
https://lore.kernel.org/all/CAJfpegvYpWuTbKOm1hoySHZocY+ki07EzcXBUX8kZx92T8W6uQ@mail.gmail.com/

-- 
Thanks,
Jingbo

