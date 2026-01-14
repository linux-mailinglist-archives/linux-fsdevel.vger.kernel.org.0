Return-Path: <linux-fsdevel+bounces-73657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F0D1E098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF68D301E6E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695C38A2AE;
	Wed, 14 Jan 2026 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D7v1wxvu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42137F8B1;
	Wed, 14 Jan 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386521; cv=none; b=WQfPRMwaProJ3h49qzyENjRYUBn7P6vACvlQgi5BHkAQ17acckhPIGSYZ890xpy8ENemzgMnWBhm59XzpH7/1rGLtJjv9SE6jD9+XRn7jisJwfzoAddRyjpHO3Ptft/1k6Kp+8+jfHIiIubBk1+N9EaJ3G4YnHzao+V/lnqa0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386521; c=relaxed/simple;
	bh=tpgVmkRqeiZa63Yu6N8ip9DWGbygd9O3goVNYqy37mY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FhBuFY1PEUSRWuGLlc55jEVHK5373Y6yjBBmzD96AwlcpjdbNMkaxHHvGHTeESFjkFXma3ZXd5pAtS1O3vIzRpEKISdURlAa/y/5/x2g/cAktJnJw83IiKYR9akHwdVo7nVE4tldcwoOMSbfjyYnysOpi4tHTIhp30lR2YKJ2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D7v1wxvu; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768386516; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=X3FIs7A5RvlrrKt9IluVyHYBz5NPE45rqc71MrXC4A0=;
	b=D7v1wxvuczsnUpX2x9Sl6mwWlm5tFEQtjvZmUO3HJyA9dBJAo3BLR7iURSNDvsuWdWdJ9OOi2NeFyuTAZF27H2vP7+O8Dcvq0v2OJ8kgRnMBSgUr+bFANJ57bkj5p0KEyeu067O9L7ATJeB8d6Dn62Ji3p+uwLqDgEOlRoB8SYs=
Received: from 30.221.131.219(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx26mdT_1768386514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 18:28:35 +0800
Message-ID: <0f33bd17-7a03-4c06-a492-e514935faed6@linux.alibaba.com>
Date: Wed, 14 Jan 2026 18:28:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 00/10] erofs: Introduce page cache sharing feature
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christian Brauner <brauner@kernel.org>
Cc: chao@kernel.org, djwong@kernel.org, amir73il@gmail.com, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Hongbo Li <lihongbo22@huawei.com>
References: <20260109102856.598531-1-lihongbo22@huawei.com>
 <20260112-begreifbar-hasten-da396ac2759b@brauner>
 <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
In-Reply-To: <d6ea54ae-39cf-4842-a808-4741d9c28ddd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2026/1/12 22:40, Gao Xiang wrote:
> Hi Christian,
> 
> On 2026/1/12 17:14, Christian Brauner wrote:
>> On Fri, Jan 09, 2026 at 10:28:46AM +0000, Hongbo Li wrote:
>>> Enabling page cahe sharing in container scenarios has become increasingly
>>> crucial, as it can significantly reduce memory usage. In previous efforts,
>>> Hongzhen has done substantial work to push this feature into the EROFS
>>> mainline. Due to other commitments, he hasn't been able to continue his
>>> work recently, and I'm very pleased to build upon his work and continue
>>> to refine this implementation.
>>
>> I can't vouch for implementation details but I like the idea so +1 from me.
> 
> Thanks, I think it should be fine.
> Let me finalize the review this week.

I wonder if it's possible that you could merge v14
PATCH 1 and 2 now to the vfs-iomap branch (both
patches are reviewed or acked):
https://lore.kernel.org/linux-fsdevel/20260109102856.598531-2-lihongbo22@huawei.com
https://lore.kernel.org/linux-fsdevel/20260109102856.598531-3-lihongbo22@huawei.com

since these two patches are almost independent to the
main feature and can be merged independently as I said
in the previous cycle.

Merging those patches into a vfs branch also avoids
other iomap conflicts.

For the other patches (since PATCH 3), how about going
through erofs tree (I will merge your iomap branch),
since it seems at least it will cause several conflicts
with my other ongoing work, does it sound good to you?

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang


