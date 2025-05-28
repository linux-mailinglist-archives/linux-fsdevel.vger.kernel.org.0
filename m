Return-Path: <linux-fsdevel+bounces-49960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF535AC6495
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681469E3B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC031269D17;
	Wed, 28 May 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ey/HoVHv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B0268FFF;
	Wed, 28 May 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421340; cv=none; b=A8cVt5N6JAbMFRtmidgz/GGFwnJDS/o1c03dL94bvF97qDQUtZIoHibmNWJR1ozqpnfiOT6bkaRjBhikPIxdITHukwrn0ALCvLRiubqGNjwxlCbNCY+fIrs+apvy8NFS6lEz4ar2H2lxIT6THqFfki8uRKOsxQq2PSspHPNnrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421340; c=relaxed/simple;
	bh=rALpFPEiTVr308SndMzrfaKc23oNScVyKdtgmZ2jaZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Fa6UsnQz2k/gNaqX8SeUMFiYu+7ocH/By0SVdY7rBZoLTFuP58xkNkO7ALf9V/f7OGR7uC8qxDlFLL/WbFBQ0Cm5pKVytIVivd1OCcomUoO2A31aTBOedS+xqXWdHKQ2Vlc9v8uWz6TAKzSrtQYb8X8w+1NPvbiFnqSl4AzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ey/HoVHv; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748421328; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C1C3naz7hPNUvfz7qjQzQeD+k7g8b1WXlsA41wkU4Fg=;
	b=ey/HoVHvaDVT7sf8n102x9de18es3mQ+kRvKPbMNJcJS2Og1tVbh25/qmXLw25PqURFdFDQ6GcfMqllAoBLvQ16BAY1NZJ4Q6cMWNJ7T/sXtGVsZqIa7Y1L7KzP7YeGBDt42fxAgs/UhYa1nubbVFFzyFxEx6QPK4q7HGQSn+uQ=
Received: from 30.221.130.248(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WcCj5pL_1748421326 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 May 2025 16:35:27 +0800
Message-ID: <d0e08cbf-c6e4-4ecd-bcaf-40c426279c4f@linux.alibaba.com>
Date: Wed, 28 May 2025 16:35:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] cachefiles: Recovery concerns with on-demand loading
 after unexpected power loss
To: Zizhi Wo <wozizhi@huaweicloud.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org, brauner@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, wozizhi@huawei.com, libaokun1@huawei.com,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com
References: <20250528080759.105178-1-wozizhi@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250528080759.105178-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zizhi,

On 2025/5/28 16:07, Zizhi Wo wrote:
> Currently, in on-demand loading mode, cachefiles first calls
> cachefiles_create_tmpfile() to generate a tmpfile, and only during the exit
> process does it call cachefiles_commit_object->cachefiles_commit_tmpfile to
> create the actual dentry and making it visible to users.
> 
> If the cache write is interrupted unexpectedly (e.g., by system crash or
> power loss), during the next startup process, cachefiles_look_up_object()
> will determine that no corresponding dentry has been generated and will
> recreate the tmpfile and pull the complete data again!
> 
> The current implementation mechanism appears to provide per-file atomicity.
> For scenarios involving large image files (where significant amount of
> cache data needs to be written), this re-pulling process after an
> interruption seems considerable overhead?
> 
> In previous kernel versions, cache dentry were generated during the
> LOOK_UP_OBJECT process of the object state machine. Even if power was lost
> midway, the next startup process could continue pulling data based on the
> previously downloaded cache data on disk.
> 
> What would be the recommended way to handle this situation? Or am I
> thinking about this incorrectly? Would appreciate any feedback and guidance
> from the community.

As you can see, EROFS fscache feature was marked as deprecated
since per-content hooks already support the same use case.

the EROFS fscache support will be removed after I make
per-content hooks work in erofs-utils, which needs some time
because currently I don't have enough time to work on the
community stuff.

Thanks,
Gao Xiang

> 
> Thanks,
> Zizhi Wo


