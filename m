Return-Path: <linux-fsdevel+bounces-74400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F36D3A0A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 732703000EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E9338581;
	Mon, 19 Jan 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bGk+rTua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F97DD515;
	Mon, 19 Jan 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809209; cv=none; b=fmht+4BbhrCihpuZniBxL2BAfMSG1hJ3wRqKdjeuV2+4kqebEgxZC9Val0RfJ/d6H2FWK2Nj8du/pHLNs3TtoEegCskX7RVYX+61l7IwiJJX9+UIxoiDmA4pBf+voRZmK9s/jMTAu/aecBS3W1EsBjIs/woi2JEc3wRYVj0XWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809209; c=relaxed/simple;
	bh=u7zW4Qk72jgK77RUtsWgrC07qdm+zCmrTB8huwWbzQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riuMHsrpyIOcjPArDVdt7nLdO7uuK1VSUBZC42ff1vDn9+4er7LXciv0jSpVPnZ8Tr2I2eSRrWXEeRFWs6o1rq72+61O7VSkhTXoI0o2RkuT6wgPgCThoa+nDMkkXKoQpFKkMx/vV4m4xGSfHJ0bqTHKKhhQMwc4e84Ojr0WEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bGk+rTua; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768809203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IbSnMD/TThQCoomf8m9kea1ykOemfT3BZ0iVD9EEtDE=;
	b=bGk+rTua3tKdtPpewN0enCinH6L3vHehvjoaVsVoIP9V9X0BU6sC4QBbr3GcE0YKAKN4+HTNvVfKKnzzT5ahpUow6bcXLbrgJS/ZNMHj9bY4AXao30Pahs3P9BoQJok0WcghPo0hk/VQeMCXmEx5SeOP1HaNnw76efVcGHbMT7M=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxJtR-9_1768809202 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 15:53:22 +0800
Message-ID: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
Date: Mon, 19 Jan 2026 15:53:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
To: Christoph Hellwig <hch@lst.de>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-6-lihongbo22@huawei.com>
 <20260116154623.GC21174@lst.de>
 <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com>
 <20260119072932.GB2562@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119072932.GB2562@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/19 15:29, Christoph Hellwig wrote:
> On Sat, Jan 17, 2026 at 12:21:16AM +0800, Gao Xiang wrote:
>> Hi Christoph,
>>
>> On 2026/1/16 23:46, Christoph Hellwig wrote:
>>> I don't really understand the fingerprint idea.  Files with the
>>> same content will point to the same physical disk blocks, so that
>>> should be a much better indicator than a finger print?  Also how does
>>
>> Page cache sharing should apply to different EROFS
>> filesystem images on the same machine too, so the
>> physical disk block number idea cannot be applied
>> to this.
> 
> Oh.  That's kinda unexpected and adds another twist to the whole scheme.
> So in that case the on-disk data actually is duplicated in each image
> and then de-duplicated in memory only?  Ewwww...

On-disk deduplication is decoupled from this feature:

- EROFS can share the same blocks in blobs (multiple
devices) among different images, so that on-disk data
can be shared by refering the same blobs;

- On-disk data won't be deduplicated in image if reflink
is enabled for backing fses, userspace mounters can
trigger background GCs to deduplicate the identical
blocks.

I just tried to say EROFS doesn't limit what's
the real meaning of `fingerprint` (they can be serialized
integer numbers for example defined by a specific image
publisher, or a specific secure hash.  Currently,
"mkfs.erofs" will generate sha256 for each files), but
left them to the image builders:


1) if `fingerprint` is distributed as on-disk part of
signed images, as I said, it could be shared within a
trusted domain_id (usually the same image builder) --
that is the top priority thing using dmverity;

Or

2) If `fingerprint` is not distributed in the image
or images are untrusted (e.g. unknown signatures),
image fetchers can scan each inode in the golden
images to generate an extra minimal EROFS
metadata-only image with local calculated
`fingerprint` too, which is much similar to the
current ostree way (parse remote files and calculate
digests).

Thanks,
Gao Xiang

