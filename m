Return-Path: <linux-fsdevel+bounces-64403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E831BE5DAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 02:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A524E188EFAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0CA1758B;
	Fri, 17 Oct 2025 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iW/JzmG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DB01C27
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659407; cv=none; b=ZEBo4Ye5m6ySnW+lZGcoOfs0jFd73Ws6ImYk2QJbfGpbWPHoQqDe0ArCNZtNiUXERqQrnRiigz/vvfEYpDOKynYnnPH9YQifLDiKTYjrxJRS8OX77GWbx5l0O6svU6g3auSVw+EwsMvNu0NuSnhAL9dmZdMHWrVm2ncw3Z1z5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659407; c=relaxed/simple;
	bh=qOyq3XvdPnMOelhEti3hbfmMd30jN6UZ4BNIYau3WBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoehlJpEe3zxjVvNlWgxCMGD2aGG97IswSHPG+GVemv1q9VRv+l7qrLXR3BMjYwf8PKakDHnHdDL8A8HIDmn5KzENdURpUtAPn5A5Y6JUpsQSFHn2iM0NwYSXG6IVCUULJI37i5LkRnDhpKQijz4nVbr80xpw6x2wWFB7bWrK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iW/JzmG1; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760659396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=K+CWcfvgSuA48E/KgEp/MbUpq4QAmmar0XX3xw0rahM=;
	b=iW/JzmG1so5yKVKyToqu91dFaJK7DoLqIoxiGsgMsTBCEWHirGCewnRzWDw7SeeqGxKbnlZ8rFDWOKWqNJfAnYRQMWBFNcXu7Xs6qpl4pIhQ7F85el42nbbdr8eChAfk1TbIElMduR2norMwvA+zFR2ZZ2LAhR3lW0OuWvDoTaE=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqME2EE_1760659394 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 08:03:15 +0800
Message-ID: <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com>
Date: Fri, 17 Oct 2025 08:03:13 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1aB4BwDNwex1NimiQ_9duUQ93HMp+ATsqo4QcGStMbzWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/17 06:03, Joanne Koong wrote:
> On Wed, Oct 15, 2025 at 6:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>
>>>
>>> So I don't think this patch should have a fixes: tag for that commit.
>>> It seems to me like no one was hitting this path before with a
>>> non-block-aligned position and offset. Though now there will be a use
>>> case for it, which is fuse.
>>
>> To make it simplified, the issue is that:
>>    - Previously, before your fuse iomap read patchset (assuming Christian
>>      is already applied), there was no WARNING out of there;
>>
>>    - A new WARNING should be considered as a kernel regression.
> 
> No, the warning was always there. As shown in the syzbot report [1],
> the warning that triggers is this one in iomap_iter_advance()
> 
> int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> {
>          if (WARN_ON_ONCE(*count > iomap_length(iter)))
>                  return -EIO;
>          ...
> }
> 
> which was there even prior to the fuse iomap read patchset.
> 
> Erofs could still trigger this warning even without the fuse iomap
> read patchset changes. So I don't think this qualifies as a new
> warning that's caused by the fuse iomap read changes.

No, I'm pretty sure the current Linus upstream doesn't have this
issue, because:

  - I've checked it against v6.17 with the C repro and related
    Kconfig (with make olddefconfig revised);

  - IOMAP_INLINE is pretty common for directories and regular
    inodes, if it has such warning syzbot should be reported
    much earlier (d9dc477ff6a2 was commited at Feb 26, 2025;
    and b26816b4e320 was commited at Mar 19, 2025) in the dashboard
    (https://syzkaller.appspot.com/upstream/s/erofs) rather
    than triggered directly by your fuse read patchset.

Could you also check with v6.17 codebase?

Thanks,
Gao Xiang


