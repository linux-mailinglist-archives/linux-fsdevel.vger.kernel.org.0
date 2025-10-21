Return-Path: <linux-fsdevel+bounces-64802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D85BF4481
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 03:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567801891368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 01:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB62153D4;
	Tue, 21 Oct 2025 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fhItrZJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6315D1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010760; cv=none; b=rnym9/dpcfOo131oykXRSI6VkeL16qK6sOkJqMa2mZzcnRviQQLu21mgjkA74D2hWxmzuUbHLmWVWiQ9uLNfxe0uPCmmMb/NTkwry9ObMdXDHHmmwh73MkX4mKldqa6KbojckrtI5R/zNlLDl2zgVQSYU7K/wYo7TXQUF4YF7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010760; c=relaxed/simple;
	bh=4u7gdtoG2IrVUfi8pfiZFE8Gk8Q/8b96qQaBKTzJ/+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJDWNxpaj8pTGMtWo6+tl8DUi5v01EZLocC+1AhIsJFcdI2KQ5ztU+2UABxRq4wCVTtHeDCgml9SYe83Y5ahd8ZK5lWbLZxuB9tDwhLIo65Sa99YivoP2L5Q9F1nFCxVql4VDM0L4hYNEp/Dj2HJ/XIrIkjQwjDt2nBFJIzpWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fhItrZJ7; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761010755; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=q7UzR1BBYhoxLPyx/RabOsuWkqb8jHYGfFP7UQaos9Y=;
	b=fhItrZJ7U9GUSUzi/Hdcb7TQopEetGp5wu3LmdxLSDE2Q4AlPU4IjF4zePT67ny6B+NMbXV5lXFHQSnlh0VlK14hf/rQgcMpHISB/qDKERZWkTO6SJaBzu0rNES7DrH9+M2qoSUAxxScUEoKHFJQwQD2LRvyXs14O2ruXCpQo9Q=
Received: from 30.221.129.100(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wqh.rc1_1761010754 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 09:39:14 +0800
Message-ID: <7ccdda81-8a31-4a4e-9ec1-7797cc701936@linux.alibaba.com>
Date: Tue, 21 Oct 2025 09:39:12 +0800
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
 <9f800c6d-1dc5-42eb-9764-ea7b6830f701@linux.alibaba.com>
 <CAJnrk1Ydr2uHvjLy6dMGwZj40vYet6h+f=d0WAotoj9ZMSMB=A@mail.gmail.com>
 <b508ecfe-9bf3-440e-9b50-9624a60b36dd@linux.alibaba.com>
 <CAJnrk1aj30PebLo7q4BMDoTU5Pyn25U7dZRK6=MvJcFSfb-4XA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1aj30PebLo7q4BMDoTU5Pyn25U7dZRK6=MvJcFSfb-4XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/21 07:25, Joanne Koong wrote:
> On Fri, Oct 17, 2025 at 5:13 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/10/18 07:22, Joanne Koong wrote:
>>> On Fri, Oct 17, 2025 at 3:07 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>>>
>>>> On 2025/10/18 02:41, Joanne Koong wrote:

...

>>>>
>>>> Can you confirm this since I can't open the link below:
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>>>> branch: vfs-6.19.iomap
>>>>
>>>> [1/1] iomap: adjust read range correctly for non-block-aligned positions
>>>>          https://git.kernel.org/vfs/vfs/c/94b11133d6f6
>>>>
>>>
>>> I don't think the vfs-6.19.iomap branch is publicly available yet,
>>> which is why the link doesn't work.
>>>
>>>   From the merge timestamps in [1] and [2], the fix was applied to the
>>> branch 3 minutes before the fuse iomap changes were applied.
>>> Additionally, in the cover letter of the fuse iomap read patchset [3],
>>> it calls out that the patchset is rebased on top of that fix.
>>
>> Ok, make sense, thanks.
> 
> The vfs-6.19.iomap branch is now available. I just triple-checked and
> can confirm that commit 7aa6bc3e8766 ("iomap: adjust read range
> correctly for non-block-aligned positions") was merged into the tree
> prior to commit e0c95d2290c1 ("iomap: set accurate iter->pos when
> reading folio ranges").

Hi Joanne, thanks for the confirmation again,
sounds fine with me.

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
> 

