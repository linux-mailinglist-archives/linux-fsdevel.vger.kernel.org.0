Return-Path: <linux-fsdevel+bounces-31538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E6998489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D5DB235BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F8A1C330D;
	Thu, 10 Oct 2024 11:11:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7A1C2335;
	Thu, 10 Oct 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558676; cv=none; b=YhL8uvyDsYHm0xo/4mR3IRol2DpAPQEOXGQmixbjvLMiKYXyDybMYCje29EyPU7/jQ+XJnEbLdkKMRicfuZKyE83fyDm80XH8s5K8eQLjVgTfZ+2gR4tQPAa3S5kn1JlHqU3ZqszZ971m66HlJNIepogm/dFfOvTKp9dUmjK1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558676; c=relaxed/simple;
	bh=w3kn/IzcJO5vxvf8MulrNKhYqQMsaUw7FpLuX2ejyPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o0llgsAi2tg3tdds3aEKI8teM8SBO0+1BoUauHcyLAHrbrWrq5d/7RdCznRKn+EyYrC2jyh4nFgi8LXNQztuqkfclYOrueI8jIgl/jNNrJBzagrXfRHUEnQpTuCPikA2hH72m5Jdcb/MFURWmi7u9qC1bGExJbMb9EXl2INaRcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPRp76M00zfcmb;
	Thu, 10 Oct 2024 19:08:47 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D1C0180AB7;
	Thu, 10 Oct 2024 19:11:12 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:11:11 +0800
Message-ID: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
Date: Thu, 10 Oct 2024 19:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] cachefiles: Fix incorrect block calculations in
 __cachefiles_prepare_write()
To: David Howells <dhowells@redhat.com>
CC: <netfs@lists.linux.dev>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <20240821024301.1058918-2-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <302546.1728556499@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <302546.1728556499@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 18:34, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> In the __cachefiles_prepare_write function, DIO aligns blocks using
>> PAGE_SIZE as the unit. And currently cachefiles_add_cache() binds
>> cache->bsize with the requirement that it must not exceed PAGE_SIZE.
>> However, if cache->bsize is smaller than PAGE_SIZE, the calculated block
>> count will be incorrect in __cachefiles_prepare_write().
>>
>> Set the block size to cache->bsize to resolve this issue.
> 
> Have you tested this with 9p, afs, cifs, ceph and/or nfs?  This may cause an
> issue there as it assumed that the cache file will be padded out to
> PAGE_SIZE (see cachefiles_adjust_size()).
> 
> David
> 
> 

In my opinion, cachefiles_add_cache() will pass the corresponding size
to cache->bsize. For scenarios such as nfs/cifs, the corresponding bsize
is PAGE_SIZE aligned, which is fine. For scenarios where cache->bsize is
specified for non-PAGE_SIZE alignment (such as erofs on demand mode),
imposing PAGE_SIZE here can be problematic. So modify cache->bsize to be
more generic.

Thanks,
Zizhi Wo

