Return-Path: <linux-fsdevel+bounces-33035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC119B225A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 03:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C791C20885
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 02:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EB174EF0;
	Mon, 28 Oct 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pYihQtH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED070156C7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730080987; cv=none; b=ftzuvJUsU6ySHIcyfPh1hPrXLoHl1Us7B/kV1AxkdM4q9zfhFxMVh6VFcM4ucBzxCSDAt6NRSTWzd76u3Z5iiHyOFb0Nw+YyuzBlCqq80y/VGzS0Gk88L+PA/oI8ZXpCulGxE/LBpSIyQ9iO3fNApMXe45ILsL4wUgdOGt6OILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730080987; c=relaxed/simple;
	bh=+zyjdRwAvecSiKdrJ0ZMt9AYSDretuQ7Ua9aJWJojdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwLLHiZb7146qbxanoIjs1E1aRoBd9iP5PIfpb2/DeQTbQZCvhPw63R6r7G33fClpVDj6N2D/b8R2FkM8Ed2AUKMLaAdBKefuLdTeo/tbOBTttMZS4OfVzLGf3Jne4WmBUs2euVDUmc31mAykzdeHeBwWBVx0oEyAyPhG2PIP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pYihQtH+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730080975; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZQhBE1x/c/IpY8NyI+VMhcf5t90yL12OZvVcd60U6Vw=;
	b=pYihQtH+4pfL/4hIHLqdk/nzd08oFSh0eWcga2pXRL4b3Ce36V1mHHhLT0d035Ket/ixRUUpXJ7jVZi5niA9cq9qtzW0Ny9yJ069T+z9WHmwp9K+dnsX3uek7Vo5P/6XVYlOa8Ojdy2UfSCOwmdV6V1vTdF+HrDt2zDK+Ogx5+Q=
Received: from 30.221.148.132(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHywiIb_1730080973 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 10:02:54 +0800
Message-ID: <aad84cef-9e13-45f3-b21a-bd059dfa350a@linux.alibaba.com>
Date: Mon, 28 Oct 2024 10:02:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7>
 <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
 <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
 <CAJnrk1YFPZ8=7s4m-CP02_416syO+zDLjNSBrYteUqm8ovoHSQ@mail.gmail.com>
 <3e4ff496-f2ed-42ef-9f1a-405f32aa1c8c@linux.alibaba.com>
 <CAJnrk1aDRQPZCWaR9C1-aMg=2b3uHk-Nv6kVqXx6__dp5Kqxxw@mail.gmail.com>
 <CAJfpegvyD35YX27msBE+si2kmYrqBYW7SJgOW5ewUBKNzDB1Gg@mail.gmail.com>
 <CAJnrk1ZC9fW3y8sc2nyRUzPwwjQhnQuJzCS4+L9Chq49+Ob7Fg@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1ZC9fW3y8sc2nyRUzPwwjQhnQuJzCS4+L9Chq49+Ob7Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/26/24 2:19 AM, Joanne Koong wrote:
> On Fri, Oct 25, 2024 at 11:02 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Fri, 25 Oct 2024 at 19:36, Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>>> That's a great point. It seems like we can just skip waiting on
>>> writeback to finish for fuse folios in sync(2) altogether then. I'll
>>> look into what's the best way to do this.
>>
>> I just tested this, and it turns out this doesn't quite work the way
>> I'd expected.  I can trigger sync(2) being blocked by a suspended fuse
>> server:
>>
>> task:kworker/u16:3   state:D stack:0     pid:172   tgid:172   ppid:2
>>    flags:0x00004000
>> Workqueue: writeback wb_workfn (flush-0:30)
>> Call Trace:
>>  __schedule+0x40b/0xad0
>>  schedule+0x36/0x120
>>  inode_sleep_on_writeback+0x9d/0xb0
>>  wb_writeback+0x104/0x3d0
>>  wb_workfn+0x325/0x490
>>  process_one_work+0x1d8/0x520
>>  worker_thread+0x1af/0x390
>>  kthread+0xcc/0x100
>>  ret_from_fork+0x2d/0x50
>>  ret_from_fork_asm+0x1a/0x30
>>
>> task:dd              state:S stack:0     pid:1364  tgid:1364
>> ppid:1336   flags:0x00000002
>> Call Trace:
>>  __schedule+0x40b/0xad0
>>  schedule+0x36/0x120
>>  request_wait_answer+0x16b/0x200
>>  __fuse_simple_request+0xd6/0x290
>>  fuse_flush_times+0x119/0x140
>>  fuse_write_inode+0x6d/0xc0
>>  __writeback_single_inode+0x36d/0x480
>>  writeback_single_inode+0xa8/0x170
>>  write_inode_now+0x75/0xa0
>>  fuse_flush+0x85/0x1c0
>>  filp_flush+0x2c/0x70
>>  __x64_sys_close+0x2e/0x80
>>  do_syscall_64+0x64/0x140
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> task:sync            state:D stack:0     pid:1365  tgid:1365
>> ppid:1336   flags:0x00004002
>> Call Trace:
>>  __schedule+0x40b/0xad0
>>  schedule+0x36/0x120
>>  wb_wait_for_completion+0x56/0x80
>>  sync_inodes_sb+0xc5/0x450
>>  iterate_supers+0x69/0xd0
>>  ksys_sync+0x40/0xa0
>>  __do_sys_sync+0xa/0x20
>>  do_syscall_64+0x64/0x140
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
> 
> Thanks for the trace. If i'm understanding it correctly, this only
> blocks temporarily until the writeback wb_workfn is rescheduled?
> 
>> Maybe I'm too paranoid about this, and in practice we can just let
>> sync(2) block in any case.  But I want to understand this better
> 
> in the case of a malicious fuse server, it could block sync(2) forever
> so I think this means we have to skip the wait for fuse folios
> altogether.

Right. In summary we need to skip waiting on the completion for the
writeback in case of a malicious fuse server could block sync(2)
forever, and meanwhile the change won't break the backward compatibility
as the current fuse implementation also doesn't wait for the data
actually being written back and persistent on the backstore in sync(2).


-- 
Thanks,
Jingbo

