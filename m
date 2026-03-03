Return-Path: <linux-fsdevel+bounces-79236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCbWC+zupmlKaQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:23:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CF1F163B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE65430D45C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D9C3D3D04;
	Tue,  3 Mar 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rXEMHuAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77133F368;
	Tue,  3 Mar 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547410; cv=none; b=bwL0tmUSTToBl9yAIkz8GW+c2lJdjuOhUl/3R/Pbs6vlKGqHDQZEC+ZkmUNbTJx8orqn8Vsmwckm0WYqP7mLaeN8N2xiiogNBbr0+TPeVpzE5u5Hf2SXfnmdzRotO07KskBpirV2BEZtRmi8OvXX34PG/BV9sBqEUVW07gtHUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547410; c=relaxed/simple;
	bh=ApAB8lq/CJr0t8QJgTWRvFPhbvSG8uxfkxPtTkxzua8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=doZKB53a/4kyVuB+uQpFrpZteLTB2qjVdjDA4cD9nS/Xuu51qf+m7GqV7ooDs0zVcgLFPcRvHup/ZWBvkfb9ZTVwwAa4s4E1AF5HhLTI4WVh4i1L93WOOqs8EuAYCzB2xC5G9pDs+jd0jz5Qf6K3K1R1DxPHp36YaUFDEFSm3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rXEMHuAj; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772547405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=npi6ZTogrvn9jOfVsJYDqbJ9HJZdPvs+NRTzxelLi7A=;
	b=rXEMHuAj+ffujMupEsKWbEYSFC40cbhNgHi4bWUgU9nVNqCchlt3b1gIT5VqywQsoGJeq6hZYSttHP0kqRDact1y3JvxaRoWUkxAJvi1nwvxR27fPwqYnXMFOMBmCl7FfTcm4Gcn9CcuASMIrUQzf6S6+ltEE1/Bg3/w5ufoLBA=
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0X-A0vf6_1772547404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 22:16:44 +0800
Message-ID: <2d59cd68-5013-4c4e-8088-7357cf314b14@linux.alibaba.com>
Date: Tue, 3 Mar 2026 22:16:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: move page cache invalidation after AIO to workqueue
To: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng Ding <cding@ddn.com>
References: <20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com>
 <8e322296-52c7-4826-adb3-7fb476cdf35b@linux.alibaba.com>
 <e548152e-a831-4b5a-bc18-52fdb7dc1d7f@bsbernd.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <e548152e-a831-4b5a-bc18-52fdb7dc1d7f@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C0CF1F163B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79236-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action



On 3/3/26 8:37 PM, Bernd Schubert wrote:
> 
> 
> On 3/3/26 13:03, Jingbo Xu wrote:
>>
>>
>> On 3/3/26 6:23 PM, Bernd Schubert wrote:
>>> From: Cheng Ding <cding@ddn.com>
>>>
>>> Invalidating the page cache in fuse_aio_complete() causes deadlock.
>>> Call Trace:
>>>  <TASK>
>>>  __schedule+0x27c/0x6b0
>>>  schedule+0x33/0x110
>>>  io_schedule+0x46/0x80
>>>  folio_wait_bit_common+0x136/0x330
>>>  __folio_lock+0x17/0x30
>>>  invalidate_inode_pages2_range+0x1d2/0x4f0
>>>  fuse_aio_complete+0x258/0x270 [fuse]
>>>  fuse_aio_complete_req+0x87/0xd0 [fuse]
>>>  fuse_request_end+0x18e/0x200 [fuse]
>>>  fuse_uring_req_end+0x87/0xd0 [fuse]
>>>  fuse_uring_cmd+0x241/0xf20 [fuse]
>>>  io_uring_cmd+0x9f/0x140
>>>  io_issue_sqe+0x193/0x410
>>>  io_submit_sqes+0x128/0x3e0
>>>  __do_sys_io_uring_enter+0x2ea/0x490
>>>  __x64_sys_io_uring_enter+0x22/0x40
>>>
>>> Move the invalidate_inode_pages2_range() call to a workqueue worker
>>> to avoid this issue. This approach is similar to
>>> iomap_dio_bio_end_io().
>>>
>>> (Minor edit by Bernd to avoid a merge conflict in Miklos' for-next
>>> branch). The commit is based on that branch with the addition of
>>> https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)
>>
>> I think it would be better to completely drop my previous patch and
>> rework on the bare ground, as the patch
>> (https://lore.kernel.org/r/20260111073701.6071-1-jefflexu@linux.alibaba.com)
>> is only in Miklos's branch, not merged to the master yet.
>>
>>
>> After reverting my previous patch, I think it would be cleaner by:
>>
>>
>> "The page cache invalidation for FOPEN_DIRECT_IO write in
>> fuse_direct_io() is moved to fuse_direct_write_iter() (with any progress
>> in write), to keep consistent with generic_file_direct_write().  This
>> covers the scenarios of both synchronous FOPEN_DIRECT_IO write
>> (regardless FUSE_ASYNC_DIO) and asynchronous FOPEN_DIRECT_IO write
>> without FUSE_ASYNC_DIO.
>>
>> After that, only asynchronous direct write (for both FOPEN_DIRECT_IO and
>> non-FOPEN_DIRECT_IO) with FUSE_ASYNC_DIO is left."
> 
> I think your suggestion moves into this direction
> 
> https://lore.kernel.org/all/20230918150313.3845114-1-bschubert@ddn.com/
> 

Yes it's similar in some way, but it's still simple enough as the short
term fix.

-- 
Thanks,
Jingbo


