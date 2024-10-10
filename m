Return-Path: <linux-fsdevel+bounces-31549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE52998553
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93C11C213E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922FD1C3315;
	Thu, 10 Oct 2024 11:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F901C2454;
	Thu, 10 Oct 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560856; cv=none; b=S7M4mluDmir4MSeBaB78HDjnNTd1CF/HIzPyVVrwtLU+lQ00GXuAmReYDCYDDcXKKQxdmcyAcyiUfjLyypV5UsAy6aSs1GW8ET2SIvBVx7Z4bhZY1zxg/VxQHgXDA/hJJQyEcT/zwylW1RvtzKuNxfC956LsJnp7AakiU3EjAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560856; c=relaxed/simple;
	bh=nhY+3d7RGBjqO61vM1Gmf89cUgL0SF7x1G+0ivnWjWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j9UohtrqjGJgR1Wm5Q5XiXkWOoWBmemmqjANSjl7RIbFNFg+uZZRX2RIKj/kUN4+GjNDm6IGlij1a4BVHp+U6XbLKJdaP1ttcQgtcVpGLBLGNCWDqNGOy98XpHW9y7CEPDqyEBP2czq5PRvgRO3zD1EnPhMnAE7dyrpnhtuYUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPScn6jgHz10N2b;
	Thu, 10 Oct 2024 19:45:45 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id DFE8618010F;
	Thu, 10 Oct 2024 19:47:30 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 19:47:29 +0800
Message-ID: <df196eaa-e017-4f2e-a443-0431873a5d71@huawei.com>
Date: Thu, 10 Oct 2024 19:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] cachefiles: Modify inappropriate error return value
 in cachefiles_daemon_secctx()
To: David Howells <dhowells@redhat.com>
CC: <netfs@lists.linux.dev>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <20240821024301.1058918-7-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <304108.1728559896@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <304108.1728559896@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 19:31, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> In cachefiles_daemon_secctx(), if it is detected that secctx has been
>> written to the cache, the error code returned is -EINVAL, which is
>> inappropriate and does not distinguish the situation well.
> 
> I disagree: it is an invalid parameter, not an already extant file, and a
> message is logged for clarification.  I'd prefer to avoid filesystem errors as
> we are also doing filesystem operations.
> 
> David
> 
> 

Alright, what I originally intended was to differentiate the error codes
between cases where no arguments are specified and where cache->secctx
already exists.

Thanks,
Zizhi Wo

