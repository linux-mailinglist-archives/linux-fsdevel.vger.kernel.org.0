Return-Path: <linux-fsdevel+bounces-74415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079CD3A21D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 09:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2539C303B19E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4A33E346;
	Mon, 19 Jan 2026 08:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g94FOZmT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7249D531;
	Mon, 19 Jan 2026 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812785; cv=none; b=X0WNrMqEd2oTOQUxiP97KddsyH044BVgPLTvETBxuDYpk/RlAqmAOfXATGkvmmfDXS3x6Q70e11M2ByLim+rqIv/sCjenEGMNVQkhKa3iLAi18Av+OVPeCIIZpMF/D13D6TwkQxE7BIVYY2FZkoxn25prJtVhpMTrzJlgI/E/V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812785; c=relaxed/simple;
	bh=ArdSKLYGKKvopKikSdu6IRCj5novUtWQhW2Bszgsk50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeZB38WK29Juyrz4g4xSTfk6bjpykvRNZTIWZgCoFSFpBQSNs9Zfy3N7Er9Kx6+p55ItRg9f+LI0hXySGPilPAGWEFj5ECTv/7J/1+wZcodt9Pt6bXEmBR+al+PCzB7L4+YjaNzGxO+yv4kqhJAk2+yqW4PwUH/EjEPRbbHy6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g94FOZmT; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768812775; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pKXxPr9jjXttpRGeXJnXU+dWjjc24WVGOWOJDuRlICA=;
	b=g94FOZmT23y/NHuO6f3A0SGuzOff2kwaw5L22lORQ69zoJ7D4PT4Xgqu4hdBp/gTIgjptNzCtl+1B1LxI/Cv68+jmrQUoRuL1Vplt1ItwAF8QRAFoZ8N3/UpCSzO7ZuTugsLQHRwFqvkZMnVQYoT50J1lR6//b0HJDGs6han/mM=
Received: from 30.221.131.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxKR-IT_1768812774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 16:52:55 +0800
Message-ID: <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com>
Date: Mon, 19 Jan 2026 16:52:54 +0800
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
 <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com>
 <20260119083251.GA5257@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260119083251.GA5257@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/19 16:32, Christoph Hellwig wrote:
> On Mon, Jan 19, 2026 at 03:53:21PM +0800, Gao Xiang wrote:
>> I just tried to say EROFS doesn't limit what's
>> the real meaning of `fingerprint` (they can be serialized
>> integer numbers for example defined by a specific image
>> publisher, or a specific secure hash.  Currently,
>> "mkfs.erofs" will generate sha256 for each files), but
>> left them to the image builders:
> 
> To me this sounds pretty scary, as we have code in the kernel's trust
> domain that heavily depends on arbitrary userspace policy decisions.

For example, overlayfs metacopy can also points to
arbitary files, what's the difference between them?
https://docs.kernel.org/filesystems/overlayfs.html#metadata-only-copy-up

By using metacopy, overlayfs can access arbitary files
as long as the metacopy has the pointer, so it should
be a priviledged stuff, which is similar to this feature.

> 
> Similarly the sharing of blocks between different file system
> instances opens a lot of questions about trust boundaries and life
> time rules.  I don't really have good answers, but writing up the

Could you give more details about the these? Since you
raised the questions but I have no idea what the threats
really come from.

As for the lifetime: The blob itself are immutable files,
what the lifetime rules means?

And how do you define trust boundaries?  You mean users
have no right to access the data?

I think it's similar: for blockdevice-based filesystems,
you mount the filesystem with a given source, and it
should have permission to the mounter.

For multiple-blob EROFS filesystems, you mount the
filesystem with multiple data sources, and the blockdevices
and/or backed files should have permission to the
mounters too.

I don't quite get the point.

Thanks,
Gao Xiang

> lifetime and threat models would really help.


