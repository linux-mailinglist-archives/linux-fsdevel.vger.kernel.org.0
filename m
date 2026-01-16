Return-Path: <linux-fsdevel+bounces-74036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92038D2A2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB3D0304ED94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06623375DC;
	Fri, 16 Jan 2026 02:32:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07462F60BC;
	Fri, 16 Jan 2026 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530770; cv=none; b=QCTl9sE7yQNmAsAsZeW6gKSyU0b6W/etBBwf3WQAygWm3yvjxwWIGcaJOwQFn8tesFWv07RYNEvRJtbLv0V8GgHlncjvUx+BK+dZJq+RnGFQklaq3CO0ZcyHLB52VSMrOhVeUWYu0L2KS7yUH6btI9TFKDSXv1IXxURrqWFAcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530770; c=relaxed/simple;
	bh=dxlsenTUJ8WmNDS2uXDQY1S8mvHcwzR8Tv/alf7nCVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCaRW/6uiR5+akpzoNnXy7IMQP4feFIrmyixRdw41P7gCTo8vztZKgrwWbmo8ngYGmyvHJUlh/5TaOilXJhRcLapYqW6HgdcrWCqb6KuB5N5p0Crmequ01/xz61UuKRAdfzQmiYXq/dWKvZjAw9/M9MfLqh2G6cvkoqJSoGyCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from [10.26.132.114] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [101.226.143.247])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d68114b;
	Fri, 16 Jan 2026 09:57:13 +0800 (GMT+08:00)
Message-ID: <fe42c7b8-5144-4aeb-9513-9f5aae751475@ustc.edu>
Date: Fri, 16 Jan 2026 09:57:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse/passthrough: simplify daemon crash recovery
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <aWkLBXv4AO5QMmPf@amir-ThinkPad-T480>
From: Chunsheng Luo <luochunsheng@ustc.edu>
In-Reply-To: <aWkLBXv4AO5QMmPf@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9bc4855d7a03a2kunma6263bd5242da8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThoZVhofTh0eTEhOTxoZT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKS0pVSUlNVUpPSFVJT0xZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+



On 1/15/26 11:43 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 03:20:29PM +0800, Chunsheng Luo wrote:
>> To simplify FUSE daemon crash recovery and reduce performance overhead,
>> passthrough backing_id information is not persisted. However, this
>> approach introduces two challenges after daemon restart:
>>
>> 1. Non-persistent backing_ids prevent proper resource cleanup, leading
>>     to resource leaks.
>> 2. New backing_ids allocated for the same FUSE file cause -EIO errors
>>     due to strict fuse_backing validation in
>>     fuse_inode_uncached_io_start(), even when accessing the same
>>     backing file. This persists until all previously opened files are
>>     closed.
>>
>> There are common scenarios where reusing the cached fuse_inode->fb is
>> safe:
>>
>> Scenario 1: The same backing file (with identical inode) is
>>              re-registered after recovery.
>> Scenario 2: In a read-only FUSE filesystem, the backing file may be
>>              cleaned up and re-downloaded (resulting in a different
>>              inode, but identical content).
> 
> That is just not acceptable by design, regardless of server restart.
> 
> fuse passthrough may be configured per individual file open, but
> all fd referring to the same fuse inode need to passthrough to the
> same backing inode.
> 
> If your server want to serve different fd of same fuse inode from
> different backing files (no matter if they claim to have the same content),
> server needs to do that with FOPEN_DIRECT_IO, it cannot do that with
> FOPEN_PASSTHROUGH.
> 
> Thanks,
> Amir.
> 

That's correct. A reference count for the backing files is certainly 
maintained before crash to prevent them from being garbage collected and 
to avoid different opens of the same fuse_inode from using different 
backing files. However, this count does not survive the crash recovery 
process. Consequently, the disk's garbage collection mechanism could 
subsequently delete these files.

In this situation, we should consider how to prevent these files from 
being mistakenly garbage collected after a crash recovery.

Thanks.
Chunsheng Luo

>>
>> Proposed Solution:
>>
>> 1. Enhance fuse_dev_ioctl_backing_close() to support closing all
>>     backing_ids at once, enabling comprehensive resource cleanup after
>>     restart.
>>
>> 2. Introduce the FOPEN_PASSTHROUGH_INODE_CACHE flag. When set during
>>     fuse_open(), the kernel prioritizes reusing the existing
>>     fuse_backing cached in fuse_inode, falling back to the
>>     backing_id-associated fb only if the cache is empty.
>>
>> I'd appreciate any feedback on whether there are better approaches or
>> potential improvements to this solution.
>>
>> Thanks.
>> ---
>> Chunsheng Luo (2):
>>    fuse: add close all in passthrough backing close for crash recovery
>>    fuse: Add new flag to reuse the backing file of fuse_inode
>>
>>   fs/fuse/backing.c         | 14 ++++++++++++++
>>   fs/fuse/dev.c             |  5 +++++
>>   fs/fuse/fuse_i.h          |  1 +
>>   fs/fuse/iomode.c          |  2 +-
>>   fs/fuse/passthrough.c     | 11 +++++++++++
>>   include/uapi/linux/fuse.h |  2 ++
>>   6 files changed, 34 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.43.0
>>
> 
> 


