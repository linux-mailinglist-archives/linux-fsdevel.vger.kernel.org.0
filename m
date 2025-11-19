Return-Path: <linux-fsdevel+bounces-69065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CDC6DB7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 090D02DAB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307133F8C0;
	Wed, 19 Nov 2025 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DWtNCAFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007333E373;
	Wed, 19 Nov 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544514; cv=none; b=puP9nfh1G7amQUvWe6XrHr4c2uepsDD+R8pvaVjYd19H4UBqkguHGtYDkOG7S9MOpnmJVT7mKC+7VCYbSxCLijn4kx/MsNMCX3ZxPaXX2VRgRY0lycaqaYnEkHcvKAmLAGoDuLXfL4dNDw2+SLokLXzNS087pQnsPONsMMfgRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544514; c=relaxed/simple;
	bh=i7PaDhp9zpk6FHrWcAPRrYwPqEMYV2RtEz4/bN+Zcck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3KO3dPA1GX7a6a64C1bPHA6mzB13ragbYIMOXLNxRTWChqC6HUuDy1mCo+RYd0OWom097NGvuMOGfsQaYBQsb47yYino2+kzIZ1ig6YHl8CwIYOALFjk5XNKGjpZcO5jSvPx9NkKRwzcmjEqWTE2wIBRyKPVU4znKkU4O2EBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DWtNCAFd; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763544508; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i6/vAufc4D2l5WEhS+pcUMoKXwjumMPqeZkC60gdnbs=;
	b=DWtNCAFdW66htDQu+qsG42mffFI20CHXLcJE0RYTKoR74IomCRHvQdKP9ZvXn2DzNnk3klvpbAb80R3hu6qelcncg9FPVQJnrE3zQ3/IYR3Lx59jwH9xwNhRQvv2iTRTKDAYU7q+90Q9WUwqkytoJCnABDOq+/MGGHd3FB/dsSw=
Received: from 30.221.131.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsoC-64_1763544507 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 17:28:28 +0800
Message-ID: <2ec53eec-12c5-45f9-bd7d-03f98d03a384@linux.alibaba.com>
Date: Wed, 19 Nov 2025 17:28:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
 <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
 <20251119054946.GA20142@lst.de>
 <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
 <20251119091254.GA24902@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251119091254.GA24902@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/19 17:12, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 02:17:07PM +0800, Gao Xiang wrote:
>> Hongbo didn't Cc you on this thread (I think he just added
>> recipients according to MAINTAINERS), but I know you played
>> a key role in iomap development, so I think you should be
>> in the loop about the iomap change too.
>>
>> Could you give some comments (maybe review) on this patch
>> if possible?  My own opinion is that if the first two
>> patches can be applied in the next cycle (6.19) (I understand
>> it will be too late for the whole feature into 6.19) , it
>> would be very helpful to us so at least the vfs iomap branch
>> won't be coupled anymore if the first two patch can be landed
>> in advance.
> 
> The patch itself looks fine.  But as Darrick said we really need
> to get our house in order for the iomap branch so that it actually
> works this close to the merge window.

Sigh.. I'm sorry to hear about that.

Anyway, personally I think patch 1 makes no change to iomap logic
(so I think it definitely does no harm to iomap stability), but
opens a chance for iomap users to control iter->private and pass
fs-specific contexts from iomap_begin to end (and patch 2 uses
this to get rid of kmap_to_page()). So honestly I'm eager to get
patches 1 and 2 merged.

However, it's really up to the iomap maintainers. Yet, if delayed
to the next development cycle, it might still need to resolve
cross-branch conflicts, and it could still causes some churn,
anyway...

Thanks,
Gao Xiang


