Return-Path: <linux-fsdevel+bounces-28550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F096BBBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290341C21300
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97F1D799B;
	Wed,  4 Sep 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MenJUkoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83D1D2F73;
	Wed,  4 Sep 2024 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451946; cv=none; b=L8VeefT0EExoZwd9qLcWNSr7PCtBSoMonvhZXMxqqdNr4RQypzSYKzzF+81JYLlt+KEHl1kszIuLyVS/RgjjAVp04+zCVBDhJVcuN8VEZPv/aPtDT7rg7OcreEuUeNlzxhtkw4DFxrQ4Zfsu+YU2rHaCm3XT/YDsMRaMzrpruQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451946; c=relaxed/simple;
	bh=bhMwT3aNve1Sa2O5I5pi9juMgaZOG8OpMmVR6nCCi4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiggXLlQKoJpHop8ykp8Vv7xgP4eQE83L9mamVjvmKlYsXcynMINOVkQbdGBicibOIpvH7+3IjsOKmu+RfxHeSbWXvNE6bo5NW+7V3YUr58yw26SvewH4eGpO4JS7T0ugPhhIQgWEtD96Jcf43pSZlY1qREtS5shJUp7rq2Tu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MenJUkoG; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725451935; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v0DthQyFZgbl+wIxLBCPl1i9Aa9+jT9oqkUW1rb5jvU=;
	b=MenJUkoGUYNtqxLVaIvOMYlr7mauEZscrMwXKy6EuHqqH7E61xbyzakVct2L7dllolL67xIX/LtD4zSaln9/Odc77xQ2MZu9e1qqpiiFENdh6M1qTPlBiR5XHF0mlAmuk3m3itIjTtx54FTIguqW7ms6IITgqFl/OxGqC1+MhV4=
Received: from 30.221.147.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WEHimvR_1725451933)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 20:12:14 +0800
Message-ID: <8264705a-1dc0-45a7-92d9-7395e1aa99db@linux.alibaba.com>
Date: Wed, 4 Sep 2024 20:12:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] virtiofs: use GFP_NOFS when enqueuing request
 through kworker
To: Hou Tao <houtao@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal <vgoyal@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>,
 "Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Benjamin Coddington <bcodding@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 houtao1@huawei.com
References: <20240831093750.1593871-1-houtao@huaweicloud.com>
 <20240831093750.1593871-3-houtao@huaweicloud.com>
 <5769af42-e4dd-4535-9432-f149b8c17af5@linux.alibaba.com>
 <815f6c3d-bb8a-1a23-72dd-cd7b1f5f06d0@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <815f6c3d-bb8a-1a23-72dd-cd7b1f5f06d0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/24 11:53 AM, Hou Tao wrote:
> 
> 
> On 9/3/2024 5:34 PM, Jingbo Xu wrote:
>>
>> On 8/31/24 5:37 PM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> When invoking virtio_fs_enqueue_req() through kworker, both the
>>> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
>>> Considering the size of the sg array may be greater than PAGE_SIZE, use
>>> GFP_NOFS instead of GFP_ATOMIC to lower the possibility of memory
>>> allocation failure and to avoid unnecessarily depleting the atomic
>>> reserves. GFP_NOFS is not passed to virtio_fs_enqueue_req() directly,
>>> GFP_KERNEL and memalloc_nofs_{save|restore} helpers are used instead.
>>>
>>> It may seem OK to pass GFP_NOFS to virtio_fs_enqueue_req() as well when
>>> queuing the request for the first time, but this is not the case. The
>>> reason is that fuse_request_queue_background() may call
>>> ->queue_request_and_unlock() while holding fc->bg_lock, which is a
>>> spin-lock. Therefore, still use GFP_ATOMIC for it.
>> Actually, .wake_pending_and_unlock() is called under fiq->lock and
>> GFP_ATOMIC is requisite.
> 
> Er, but virtio_fs_wake_pending_and_unlock() unlocks fiq->lock before
> queuing the request.

Alright, I missed that :(


-- 
Thanks,
Jingbo

