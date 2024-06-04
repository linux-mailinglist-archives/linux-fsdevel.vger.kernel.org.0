Return-Path: <linux-fsdevel+bounces-20878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B88FA7F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 03:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4FA1F271CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96513D882;
	Tue,  4 Jun 2024 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KYk0RwQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CD137924;
	Tue,  4 Jun 2024 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466229; cv=none; b=Y9iQS8Wmt8Hl1lXHvDFOz1j9BIyO7C79hZgtENJPMW54swk2zNNiBVm9NLTNk/Ylz8HprMmV1Io0qaoL1ovtmaZbArououWEGYN8uCOsD2EQZK8P49+d6iosdlO0p2+VxP8TLFGBl4M7Aq1kzVaoncj/guw4W9rBW2Q7Ah44uZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466229; c=relaxed/simple;
	bh=vAHxqC5p21VJM3W0tqZX2heKAMVPYr0MbjkwYfHJtjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH+Wh2kvKEB/GTnnza880hSjdDk3mnopl278DiLM6OsNti6k33d8BeDFwOTFoiFTFE4bPYHnL8+qUG2NW/HJTucZNYt8uhXyosBqXd0vq0Lrb+tRk7HMH/E9wOhc+wyN2fBuZKhpDGKJZqN5/lsgimo5EJwOVPp93C8a/ugmaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KYk0RwQB; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717466223; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Qe5hOBNaCqLZm/rRI4XccAdFKiV/c/Rsd9mYPA/Q9+4=;
	b=KYk0RwQBbcDcuNn16o9LuVna9X2GOCX0hAmMEqkXATC1hUwWV+ErGwPBOKzmfnEdZhsuEsywBx6sXkr5kFA+sg4eyH0St+eEgNjzinQnRJPBQQnMVX3SgLFuoHT2Smq3wIKU7y/Y5aVSVmVsl8HeFjuJTo5jZ+5kDueEo3IKt/Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7p7gKf_1717466222;
Received: from 30.221.146.134(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7p7gKf_1717466222)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 09:57:03 +0800
Message-ID: <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
Date: Tue, 4 Jun 2024 09:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bernd and Miklos,

On 6/3/24 11:19 PM, Miklos Szeredi wrote:
> On Mon, 3 Jun 2024 at 16:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 6/3/24 08:17, Jingbo Xu wrote:
>>> Hi, Miklos,
>>>
>>> We spotted a performance bottleneck for FUSE writeback in which the
>>> writeback kworker has consumed nearly 100% CPU, among which 40% CPU is
>>> used for copy_page().
>>>
>>> fuse_writepages_fill
>>>   alloc tmp_page
>>>   copy_highpage
>>>
>>> This is because of FUSE writeback design (see commit 3be5a52b30aa
>>> ("fuse: support writable mmap")), which newly allocates a temp page for
>>> each dirty page to be written back, copy content of dirty page to temp
>>> page, and then write back the temp page instead.  This special design is
>>> intentional to avoid potential deadlocked due to buggy or even malicious
>>> fuse user daemon.
>>
>> I also noticed that and I admin that I don't understand it yet. The commit says
>>
>> <quote>
>>     The basic problem is that there can be no guarantee about the time in which
>>     the userspace filesystem will complete a write.  It may be buggy or even
>>     malicious, and fail to complete WRITE requests.  We don't want unrelated parts
>>     of the system to grind to a halt in such cases.
>> </quote>
>>
>>
>> Timing - NFS/cifs/etc have the same issue? Even a local file system has no guarantees
>> how fast storage is?
> 
> I don't have the details but it boils down to the fact that the
> allocation context provided by GFP_NOFS (PF_MEMALLOC_NOFS) cannot be
> used by the unprivileged userspace server (and even if it could,
> there's no guarantee, that it would).
> 
> When this mechanism was introduced, the deadlock was a real
> possibility.  I'm not sure that it can still happen, but proving that
> it cannot might be difficult.

IIUC, there are two sources that may cause deadlock:
1) the fuse server needs memory allocation when processing FUSE_WRITE
requests, which in turn triggers direct memory reclaim, and FUSE
writeback then - deadlock here
2) a process that trigfgers direct memory reclaim or calls sync(2) may
hang there forever, if the fuse server is buggyly or malicious and thus
hang there when processing FUSE_WRITE requests

Thus the temp page design was introduced to avoid the above potential
issues.

I think case 1 may be fixed (if any), but I don't know how case 2 can be
avoided as any one could run a fuse server in unprivileged mode.  Or if
case 2 really matters?  Please correct me if I miss something.

-- 
Thanks,
Jingbo

