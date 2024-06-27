Return-Path: <linux-fsdevel+bounces-22591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C0B919D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 04:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9DE28545E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE61D299;
	Thu, 27 Jun 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SxMSejH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BD8814;
	Thu, 27 Jun 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454134; cv=none; b=hJdP6R9OjIKBsBEjtWG/hsplZ1ti+kIgakYyGOnsfCsyrLWfdaK5PqHxfF08h3i1NzQ1AWh30oYCU1LaRYtkGNbRujkbti/+bbErTtApYbY/bJDTSrG9294SUo7XjB8PqEhCT6KfG7i7lygYmmxT+T9K3XsnUmmd/grSoR3jqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454134; c=relaxed/simple;
	bh=dAqmXPYuYZURr6lFVWrgQKZT5EGJrDh8dph/LMsXHk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU9ugDSKEZhIRVc4AFxRFADsDwe6Z66XArr7XR1JUDlIpYFHDye3T46TkIGbkteF4sLyauy+bRWsHVrFJ4XTGekbUVKE0gDtsuEaiPpou1DS2I8prcUQmD9v9aitt7P3dJrSSv9dUhoYsNbnV3QntPBVSQG7P8tkL7m4axh/kEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SxMSejH1; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719454123; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CMxvaX6g7HGFwrCzrjHt2gTPICeAo4dsZn/PpwJIyuc=;
	b=SxMSejH1jaKDOKLrQDGL7K/IFQ13NxeuCTZAE4FqlDBpCnHq5ZDbV4p9RYXgFN/Q/M8LaCjPqt2AdH8YQmbk7gpTTFBj4aluOsrpzWppNjz7aZd5EPGSxCeGmpsPYI5U7fTnYc7NdJ6l8mF30sQN0Bthz6p6dTkCFNHEyT7w3Qo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W9L3mkX_1719454121;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9L3mkX_1719454121)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 10:08:42 +0800
Message-ID: <d97a1e87-9571-453e-909c-4de17d1d67db@linux.alibaba.com>
Date: Thu, 27 Jun 2024 10:08:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Baokun Li <libaokun@huaweicloud.com>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
 <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
 <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/27 09:49, Baokun Li wrote:
> On 2024/6/26 11:28, Gao Xiang wrote:
>>
>>
>> On 2024/6/26 11:04, Baokun Li wrote:
>>> A gentle ping.
>>
>> Since it's been long time, I guess you could just resend
>> a new patchset with collected new tags instead of just
>> ping for the next round review?
>>
>> Thanks,
>> Gao Xiang
> 
> Okay, if there's still no feedback this week, I'll resend this patch series.
> 
> Since both patch sets under review are now 5 patches and have similar
> titles, it would be more confusing if they both had RESEND. So when I
> resend it I will merge the two patch sets into one patch series.

Sounds fine, I think you could rearrange the RESEND patchset with
the following order
cachefiles: some bugfixes for withdraw and xattr
cachefiles: some bugfixes for clean object/send req/poll

Jingbo currently is working on the internal stuff, I will try to
review myself for this work too.

Thanks,
Gao Xiaang

> 

