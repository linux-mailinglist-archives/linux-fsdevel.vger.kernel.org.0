Return-Path: <linux-fsdevel+bounces-30131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD93986A4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 02:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AE0B23DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D34170A12;
	Thu, 26 Sep 2024 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VmZO4/xE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDC1E50D;
	Thu, 26 Sep 2024 00:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727311273; cv=none; b=cdw+j9u45HnmIshDCjKrPSFCeikAXSnQuS4yvKdBs+j5GsLxumz8tbRzyqHgqQxerdVOotsncLd2T7Eab9RH0+ccr8vnYod6schb/PexK74ZvHYqwau5lMFqGsTCvnU0/sSoChD3clNWwUWnQJEU+6mudNLltOkRTWsF9L2zWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727311273; c=relaxed/simple;
	bh=eru3Zk73fV56SpHLEVYT8mrN22oFvMt2bzPtiM7g9yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4SyN8ccru+2jpUKfqQOdYhbD39Pra7kg5KawytiTn+IAhSO8qKIEyl1TAMLLmY07T9a3N1Q0a7XjqymFI3nrN9pfR7iUpoydH9lE/vFvCEnT70ryyM2ICwt336ReyxLy7Wi19Tu9yeXrmkXmI7JxV8F71RdBty9GS5HTrOiLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VmZO4/xE; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727311261; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/ooxu0myL1NDq78z/zYkSZU901mlk9sLoZWXOrPAioo=;
	b=VmZO4/xEfm8up29YTn/nCSGZR2XK7QzO6EadJnhDRreAZee9ozQV2huu8jrTxSRPGi77RWtKVaIL8eJ97Vmc+2gBgxRQDTXevKH/lEsr2VFQJe/dCL4G5DvzmmILEeURXYZGqcq0qrfXUk/vAQ8G829DI59LWUnmEgG0/fgNl30=
Received: from 30.244.99.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFlGCJ7_1727311257)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 08:41:00 +0800
Message-ID: <be7a42b2-ae52-4d51-9b0c-ed0304db3bdf@linux.alibaba.com>
Date: Thu, 26 Sep 2024 08:40:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
To: Ariel Miculas <amiculas@cisco.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
 Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
 <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/26 05:45, Ariel Miculas wrote:
> On 24/09/26 12:35, Gao Xiang wrote:
>> Hi Ariel,
>>
>> On 2024/9/25 23:48, Ariel Miculas wrote:
>>

...

>>
>> And there are all thoughts for reference [2][3][4][5]:
>> [2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
>> [3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
>> [4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
>> [5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/
>>
>> Here still, I do really want to collaborate with you on your
>> reasonable use cases.  But if you really want to do your upstream
>> attempt without even any comparsion, please go ahead because I
>> believe I can only express my own opinion, but I really don't
>> decide if your work is acceptable for the kernel.
>>
> 
> Thanks for your thoughts on PuzzleFS, I would really like if we could
> centralize the discussions on the latest patch series I sent to the
> mailing lists back in May [1]. The reason I say this is because looking
> at that thread, it seems there is no feedback for PuzzleFS. The feedback
> exists, it's just scattered throughout different mediums. On top of
> this, I would also like to engage in the discussions with Dave Chinner,
> so I can better understand the limitations of PuzzleFS and the reasons
> for which it might be rejected in the Linux Kernel. I do appreciate your
> feedback and I need to take my time to respond to the technical issues
> that you brought up in the github issue.

In short, I really want to avoid open arbitary number files in the
page fault path regardless of the performance concerns, because
even there are many cases that mmap_lock is dropped, but IMHO there
is still cases that mmap_lock will be taken.

IOWs, I think it's controversal for a kernel fs to open random file
in the page fault context under mmap_lock in the begining.
Otherwise, it's pretty straight-forward to add some similiar feature
to EROFS.

> 
> However, even if it's not upstream, PuzzleFS does use the latest Rust
> filesystem abstractions and thus it stands as an example of how to use
> them. And this thread is not about PuzzleFS, but about the Rust
> filesystem abstractions and how one might start to use them. That's
> where I offered to help, since I already went through the process of
> having to use them.
> 
> [1] https://lore.kernel.org/all/20240516190345.957477-1-amiculas@cisco.com/
> 
>>>
>>> I'm happy to help you if you decide to go down this route.
>>
>> Again, the current VFS abstraction is totally incomplete and broken
>> [6].
> 
> If they're incomplete, we can work together to implement the missing
> functionalities. Furthermore, we can work to fix the broken stuff. I
> don't think these are good reasons to completely ignore the work that's
> already been done on this topic.

I've said, we don't miss any Rust VFS abstraction work, as long as
some work lands in the Linux kernel, we will switch to use them.

The reason we don't do that is again
  - I don't have time to work on this because my life is still limited
    for RFL in any way at least this year; I don't know if Yiyang has
    time to work on a complete ext2 and a Rust VFS abstraction.

  - We just would like to _use Rust_ for the core EROFS logic, instead
    of touching any VFS stuff.  I'm not sure why it's called "completely
    ignore the VFS abstraction", because there is absolutely no
    relationship between these two things.  Why we need to mix them up?

> 
> By the way, what is it that's actually broken? You've linked to an LWN
> article [2] (or at least I think your 6th link was supposed to link to
> "Rust for filesystems" instead of the "Committing to Rust in the kernel"
> one), but I'm interested in the specifics. What exactly doesn't work as
> expected from the filesystem abstractions?

For example, with my current Rust skill, I'm not sure why
fill_super for "T::SUPER_TYPE, sb::Type::BlockDev" must use
"new_sb.bdev().inode().mapper()".

It's unnecessary for a bdev-based fs to use bdev inode page
cache to read metadata;

Also it's unnecessary for a const fs type to be
sb::Type::BlockDev or sb::Type::Independent as

/// Determines how superblocks for this file system type are keyed.
+    const SUPER_TYPE: sb::Type = sb::Type::Independent;

because at least for the current EROFS use cases, we will
decide to use get_tree_bdev() or get_tree_nodev() according
to the mount source or mount options.

> 
> [2] https://lwn.net/Articles/978738/
> 
>>
>> I believe it should be driven by a full-featured read-write fs [7]
>> (even like a simple minix fs in pre-Linux 1.0 era) and EROFS will
> 
> I do find it weird that you want a full-featured read-write fs
> implemented in Rust, when erofs is a read-only filesystem.

I'm not sure why it's weird from the sane Rust VFS abstraction
perspective.

> 
>> use Rust in "fs/erofs" as the experiment, but I will definitely
>> polish the Rust version until it looks good before upstreaming.
> 
> I honestly don't see how it would look good if they're not using the
> existing filesystem abstractions. And I'm not convinced that Rust in the
> kernel would be useful in any way without the many subsystem
> abstractions which were implemented by the Rust for Linux team for the
> past few years.

So let's see the next version.

Thanks,
Gao Xiang

> 
> Cheers,
> Ariel
> 

