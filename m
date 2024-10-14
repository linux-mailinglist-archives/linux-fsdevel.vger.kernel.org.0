Return-Path: <linux-fsdevel+bounces-31827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4699BD82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 03:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE88C1C220A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 01:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131681C687;
	Mon, 14 Oct 2024 01:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e3BLsqXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64A1798F;
	Mon, 14 Oct 2024 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871063; cv=none; b=mSTWyI/+OBAXWIXTygk4N/1EhbCp0I74fXk37XyQ8/GeRJCsh9lKp5eRFgt1hJ99NdUmb7mBWkhIBmuEHSn+nHFIA089S2Zf4jW3Uu1K5a29hy2LtkJjKDPqRFk7hn49H64jRKTsm9ePYpE+mygr8VT88Pl6f4cnqbeqMntxTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871063; c=relaxed/simple;
	bh=c2wYXI+jDcaDBFpMbaIHBWS+bCrbzw4WB11W/yRfVLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfdaEkZGilynf55E2wVacfWXthG/vlBZLdGJHDaDI7U8dSUUP5/5sVPux69X7HM0vB8vY1+euOk70hyP1aF+Dga9If68u84EfuZeuM6ShaGf6o7h0H6E2hJlTB4XLGFtTSQ18MVbp++aHuXWRMHd1izgUMFV9U022cAdl6QM1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e3BLsqXM; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728871052; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=W8tNzM53Kt8CDHhPxH0LAsSMfRySOHRvcZfwHtEtNwA=;
	b=e3BLsqXMDqjyucT4NhJUYUG8ndEUJ8GfE93pKklgVwQQGwYJptkJQvlmrVonhLs5hFNL+JgU49ZzUm2jy3f7OQZXlyQOdb0RO9twH+kliuyRqruThjNDUXxOt6GxeAJseOofSsCpbu09mcNkZeV5sGBuGtjwC3Z/x69E8qcITdQ=
Received: from 30.221.145.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WH.5pR-_1728871050 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 09:57:31 +0800
Message-ID: <c51fb230-247f-4879-9653-8946e683e1d9@linux.alibaba.com>
Date: Mon, 14 Oct 2024 09:57:30 +0800
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
 <ce7a056d-e4f1-4606-b119-f8e21bbfff55@linux.alibaba.com>
 <CAJnrk1beWkzsF6uQtkaLoTxNTNR5K4iODb+b6-tMWrN8MXGD4A@mail.gmail.com>
 <CAJnrk1ZjBGzxDnj+PXFNTgqgXgpBoxi3sx2aOBOLaLA2yzX9pA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZjBGzxDnj+PXFNTgqgXgpBoxi3sx2aOBOLaLA2yzX9pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/12/24 7:08 AM, Joanne Koong wrote:
> On Fri, Sep 13, 2024 at 1:55 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Thu, Sep 12, 2024 at 8:35 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>
>>> On 9/13/24 7:18 AM, Joanne Koong wrote:
>>>> On Wed, Sep 11, 2024 at 2:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> On 6/4/24 3:27 PM, Miklos Szeredi wrote:
>>>>>> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>
>>>>>>> IIUC, there are two sources that may cause deadlock:
>>>>>>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>>>>>>> requests, which in turn triggers direct memory reclaim, and FUSE
>>>>>>> writeback then - deadlock here
>>>>>>
>>>>>> Yep, see the folio_wait_writeback() call deep in the guts of direct
>>>>>> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
>>>>>> happens to be triggered by the writeback in question, then that's a
>>>>>> deadlock.
>>>>>
>>>>> After diving deep into the direct reclaim code, there are some insights
>>>>> may be helpful.
>>>>>
>>>>> Back to the time when the support for fuse writeback is introduced, i.e.
>>>>> commit 3be5a52b30aa ("fuse: support writable mmap") since v2.6.26, the
>>>>> direct reclaim indeed unconditionally waits for PG_writeback flag being
>>>>> cleared.  At that time the direct reclaim is implemented in a two-stage
>>>>> style, stage 1) pass over the LRU list to start parallel writeback
>>>>> asynchronously, and stage 2) synchronously wait for completion of the
>>>>> writeback previously started.
>>>>>
>>>>> This two-stage design and the unconditionally waiting for PG_writeback
>>>>> flag being cleared is removed by commit 41ac199 ("mm: vmscan: do not
>>>>> stall on writeback during memory compaction") since v3.5.
>>>>>
>>>>> Though the direct reclaim logic continues to evolve and the waiting is
>>>>> added back, now the stall will happen only when the direct reclaim is
>>>>> triggered from kswapd or memory cgroup.
>>>>>
>>>>> Specifically the stall will only happen in following certain conditions
>>>>> (see shrink_folio_list() for details):
>>>>> 1) kswapd
>>>>> 2) or it's a user process under a non-root memory cgroup (actually
>>>>> cgroup_v1) with GFP_IO permitted
>>>>>
>>>>> Thus the potential deadlock does not exist actually (if I'm not wrong) if:
>>>>> 1) cgroup is not enabled
>>>>> 2) or cgroup_v2 is actually used
>>>>> 3) or (memory cgroup is enabled and is attached upon cgroup_v1) the fuse
>>>>> server actually resides under the root cgroup
>>>>> 4) or (the fuse server resides under a non-root memory cgroup_v1), but
>>>>> the fuse server advertises itself as a PR_IO_FLUSHER[1]
>>>>>
>>>>>
>>>>> Then we could considering adding a new feature bit indicating that any
>>>>> one of the above condition is met and thus the fuse server is safe from
>>>>> the potential deadlock inside direct reclaim.  When this feature bit is
>>>>> set, the kernel side could bypass the temp page copying when doing
>>>>> writeback.
>>>>>
>>>>
>>>> Hi Jingbo, thanks for sharing your analysis of this.
>>>>
>>>> Having the temp page copying gated on the conditions you mentioned
>>>> above seems a bit brittle to me. My understanding is that the mm code
>>>> for when it decides to stall or not stall can change anytime in the
>>>> future, in which case that seems like it could automatically break our
>>>> precondition assumptions.
>>>
>>> So this is why PR_IO_FLUSHER is introduced here, which is specifically
>>> for user space components playing a role in IO stack, e.g. fuse daemon,
>>> tcmu/nbd daemon, etc.  PR_IO_FLUSHER offers guarantee similar to
>>> GFP_NOIO, but for user space components.  At least we can rely on the
>>> assumption that mm would take PR_IO_FLUSHER into account.
>>>
>>> The limitation of the PR_IO_FLUSHER approach is that, as pointed by
>>> Miklos[1], there may be multiple components or services involved to
>>> service the fuse requests, and the kernel side has no effective way to
>>> check if all services in the whole chain have set PR_IO_FLUSHER.
>>>
>>
>> Right, so doesn't that still bring us back to the original problem
>> where if we gate this on any of the one conditions being enough to
>> bypass needing the temp page, if the conditions change anytime in the
>> future in the mm code, then this would automatically open up the
>> potential deadlock in fuse as a byproduct? That seems a bit brittle to
>> me to have this dependency.
>>
> 
> Hi Jingbo,
> 
> I had some talks with Josef about this during/after LPC and he came up
> with the idea of adding a flag to the 'struct
> address_space_operations' to indicate that a folio under writeback
> should be skipped during reclaim if it gets to that 3rd case of the
> legacy cgroupv1 encountering a folio that has been marked for reclaim.
> imo this seems like the most elegant solution and allows us to remove
> the temporary folio and rb tree entirely. I sent out a patch for this
> https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelkoong@gmail.com/
> that I cc'ed you on, the benchmarks show roughly a 20% improvement in
> throughput for 4k block size writes and a 40% improvement for 1M block
> size writes. I'm curious to see if this speeds up writeback for you as
> well on the workloads you're running.
> 

Yeah I just saw your post this morning.  It would be best if the mm
folks are happy with the modification to the memory reclaiming code.

I haven't tested your patch yet, I will test it later.  But at least my
previous test of dropping the temp page copying shows ~100% 1M write
bandwidth improvement (4GB/s->9GB/s), though it was tested upon Bernd's
passthrough_hp [1] which bypasses all buffer copying (i.e. the daemon
replies immediately without copying the data buffer).

[1] https://github.com/libfuse/libfuse/pull/807

-- 
Thanks,
Jingbo

