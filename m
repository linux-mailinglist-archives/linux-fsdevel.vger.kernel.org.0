Return-Path: <linux-fsdevel+bounces-64555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09374BEBE20
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 00:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964941AA584E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106972BD02A;
	Fri, 17 Oct 2025 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tTHdM0DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088825F984
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738865; cv=none; b=L/QzMYhwUco4p0Bdq0TK9rnomTTCkxAkjY7bBns6WdWthEbnLeZ8OOmGghihBxE6sCt3Sue5hqCB9fcTwz0gTONjXNHz0n7mfaI2a+C2CxdzofAdjvrXFihyM/S4glLEi/bapbkLUefcfg2ie+QsnalycImEv61TUel62waFxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738865; c=relaxed/simple;
	bh=eqpJsitnRdx6aHva3Dc7wIOb+y6HI3iRsyO4IhbTutY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOtP8KM9LJvNrq+AJc5/MpDUpw8bKR0gHX5VSQE4s9ITC79AfA2pRUNZc4uRk5bhv4fc6OdLUDUYRAebBe0IfsObTG8DkcBW6I9//2Szq9EC8BdheKXOyjPkxWCUYkJwRL0d8Q+jyKmyXJL9GZkwYo6IsMbSSkaxprfUkScvC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tTHdM0DL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760738854; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZDWp9OTlHYqMcHwYcfdrsc43HFGTcdchKzDpk+oEDpo=;
	b=tTHdM0DLwFjyJKljvPTWDciuWAEhpuhaN/4/HBZLt32cu6FmiNiT7bJ5uxLGes5gsUwgJBQCtVf3TZPGyyL6HMPccJHPNH077OZIBredHuJNJ9I9wTfA62PzBa+Ks/6RarQnm6Lvla8ItJifcgRnMR00PXRl25zVQ7BWThzYkbI=
Received: from 30.180.79.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqQWfgH_1760738852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Oct 2025 06:07:33 +0800
Message-ID: <9f800c6d-1dc5-42eb-9764-ea7b6830f701@linux.alibaba.com>
Date: Sat, 18 Oct 2025 06:07:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
 djwong@kernel.org, bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com>
 <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com>
 <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com>
 <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com>
 <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com>
 <CAJnrk1aB4BwDNwex1NimiQ_9duUQ93HMp+ATsqo4QcGStMbzWQ@mail.gmail.com>
 <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com>
 <CAJnrk1Z-0YY35wR97uvTRaOuAzsq8NgUXRxa7h00OwYVpuVS8w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1Z-0YY35wR97uvTRaOuAzsq8NgUXRxa7h00OwYVpuVS8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/18 02:41, Joanne Koong wrote:
> On Thu, Oct 16, 2025 at 5:03 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/10/17 06:03, Joanne Koong wrote:
>>> On Wed, Oct 15, 2025 at 6:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> ...
>>
>>>>
>>>>>
>>>>> So I don't think this patch should have a fixes: tag for that commit.
>>>>> It seems to me like no one was hitting this path before with a
>>>>> non-block-aligned position and offset. Though now there will be a use
>>>>> case for it, which is fuse.
>>>>
>>>> To make it simplified, the issue is that:
>>>>     - Previously, before your fuse iomap read patchset (assuming Christian
>>>>       is already applied), there was no WARNING out of there;
>>>>
>>>>     - A new WARNING should be considered as a kernel regression.
>>>
>>> No, the warning was always there. As shown in the syzbot report [1],
>>> the warning that triggers is this one in iomap_iter_advance()
>>>
>>> int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
>>> {
>>>           if (WARN_ON_ONCE(*count > iomap_length(iter)))
>>>                   return -EIO;
>>>           ...
>>> }
>>>
>>> which was there even prior to the fuse iomap read patchset.
>>>
>>> Erofs could still trigger this warning even without the fuse iomap
>>> read patchset changes. So I don't think this qualifies as a new
>>> warning that's caused by the fuse iomap read changes.
>>
>> No, I'm pretty sure the current Linus upstream doesn't have this
>> issue, because:
>>
>>    - I've checked it against v6.17 with the C repro and related
>>      Kconfig (with make olddefconfig revised);
>>
>>    - IOMAP_INLINE is pretty common for directories and regular
>>      inodes, if it has such warning syzbot should be reported
>>      much earlier (d9dc477ff6a2 was commited at Feb 26, 2025;
>>      and b26816b4e320 was commited at Mar 19, 2025) in the dashboard
>>      (https://syzkaller.appspot.com/upstream/s/erofs) rather
>>      than triggered directly by your fuse read patchset.
>>
>> Could you also check with v6.17 codebase?
> 
> I think we are talking about two different things. By "this issue"
> what you're talking about is the syzbot read example program that
> triggers the warning on erofs, but by "this issue", what I was talking
> about is the iomap_iter_advance() warning being triggerable
> generically without the fuse read patchset, not just by erofs.

Ah, yes.  Sorry the subjects of those two patches are similar,
I got them mixed up.  I thought you resent the previous patch
in this patchset.

> 
> If we're talking about the syzbot erofs warning being triggered, then
> this patch is irrelevant to be talking about, because it is this other
> patch [1] that fixes that issue. That patch got merged in before any
> of the fuse iomap read changes. There is no regression to erofs.

Can you confirm this since I can't open the link below:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/1] iomap: adjust read range correctly for non-block-aligned positions
       https://git.kernel.org/vfs/vfs/c/94b11133d6f6

As you said, if this commit is prior to the iomap read patchset, that
would be fine.  Otherwise it would be better to add a fixes tag to
that commit to point out this patch should be ported together to avoid
the new warning.

Thanks,
Gao Xiang


> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelkoong@gmail.com/
> 
>>
>> Thanks,
>> Gao Xiang
>>


