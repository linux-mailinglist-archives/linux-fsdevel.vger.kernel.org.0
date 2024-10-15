Return-Path: <linux-fsdevel+bounces-31959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B799E43B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D3AB22C46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0961E7669;
	Tue, 15 Oct 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IxAhr+1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620451E378F;
	Tue, 15 Oct 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988748; cv=none; b=kH6nzPbvpBie65EnQuNu6BTXGOt6jpN6cZSERe8JBpOwl/OOxynXaLluK0Ql3fl5KvS98WhqirPpvmizwi87Cgqg/gON1jzTrxtCuv2x70pdaBFMNuuZyCptzixeo5qTrqGQ+xArYuzvBA5/I5wk5yN8xz4QTBoEv/s5yDpYILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988748; c=relaxed/simple;
	bh=UoMHr3WzhbxE3hx8+va/FD/uR7PV83fez2EgfQRf5xs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PaUCaYqMMYb1pbc03eRg/D3kGd89v+vBjhnueVpO7tcMvi7p8cYYO8rzHK2FSGvu9OS2v+sE0I5Qj54b5cltrM9qeElm7WQ+3JEe0PWHQrlVo4Mnz4QuvcnYkUoTj6ANdbOMfJNXGfl7aMhHAIyy2Kh2O79IpMtuxGUmT2S8ExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IxAhr+1Y; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728988744; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=v+dwRPCTeAm3f9Cj5qx8sZFX+iLjtJLr7D++fvDIKQk=;
	b=IxAhr+1YHE6bz8sED4xf/WFdHBcOjsSeNYFm4ZXik2Gtm7WwVXK8DjjNakRu/EqqN2XW2kHomLcO5j6jRLQipFVYjogNpZ/c7O6zZ3OUElHBn8s6oP1qVWCbXUszs7D9mAN5o8M/VzxhSFvD+xQt9sGwQscbjqvIWYQoeNyLlc8=
Received: from 30.221.130.176(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHDPpua_1728988742 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 18:39:03 +0800
Message-ID: <62f54645-53cc-46d3-aaab-8583ed7f1a68@linux.alibaba.com>
Date: Tue, 15 Oct 2024 18:39:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>,
 brauner@kernel.org, chao@kernel.org, dhavale@google.com, djwong@kernel.org,
 huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, xiang@kernel.org
References: <670e2fe1.050a0220.d5849.0004.GAE@google.com>
 <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
In-Reply-To: <5f85c28d-5d06-4639-9453-41c38854173e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/15 17:10, Gao Xiang wrote:
> Hi,
> 
> On 2024/10/15 17:03, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    d61a00525464 Add linux-next specific files for 20241011
>> git tree:       linux-next

..

>>
>> commit 56bd565ea59192bbc7d5bbcea155e861a20393f4
>> Author: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Date:   Thu Oct 10 09:04:20 2024 +0000
>>
>>      erofs: get rid of kaddr in `struct z_erofs_maprecorder`
> 
> I will look into that, but it seems it's just a trivial cleanup,
> not quite sure what happens here...

It seems that it's only caused by an outdated version in
next-20241011, which doesn't impact to upstream or the
latest -next:
https://lore.kernel.org/r/670e399e.050a0220.d9b66.014e.GAE@google.com
https://lore.kernel.org/r/670e3f3f.050a0220.f16b.000b.GAE@google.com

so

#syz set subsystems: erofs

#syz invalid

