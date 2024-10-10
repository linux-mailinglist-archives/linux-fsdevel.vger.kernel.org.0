Return-Path: <linux-fsdevel+bounces-31554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F85E9985B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CF82832FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0021C3F37;
	Thu, 10 Oct 2024 12:17:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C961BD00C;
	Thu, 10 Oct 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562653; cv=none; b=i8B4o8DCjJSLm1G/lCpu95nH2mG6mDbqqjNu4K4haDuDx+IxMapi1OZZnEUh5lsxeFJXuie7lJhznMqXg3/RO1OXqU6MbWv9YU11QIzDP32gm5u4yBU4pcDNt0d1qB5xs9Ivka4Tg6Eq/tOI9Uxe/aWnBFJ/nX/4iNHlPXrfSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562653; c=relaxed/simple;
	bh=VsRAS0pMW9QEFEGhtZrE8/hrQkXl1KS0owvA6HihTWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s5umSyjSUfuGMwq7hQiGzoWrrc7aQwhUuwpJ3N7fKamWXCh7DLyt6CihbUrKpmFMVU5bKsM0t/9w5RtM33VCgJ4HHvaWutFPEoEu3PjAWkvNZICW2zN0vVdVKyPrb3uZ9LtTWRgkUBA5VNcKctlgvVgWGduSqM44wfq4ynGHVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XPTH452PPzpWjL;
	Thu, 10 Oct 2024 20:15:28 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 4619C18007C;
	Thu, 10 Oct 2024 20:17:28 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 20:17:27 +0800
Message-ID: <32717f03-634a-4f39-9f46-e73cca8da46d@huawei.com>
Date: Thu, 10 Oct 2024 20:17:26 +0800
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
References: <e94a52d9-ded4-4a22-90d5-18cb7665607b@huawei.com>
 <20240821024301.1058918-2-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <302546.1728556499@warthog.procyon.org.uk>
 <304311.1728560215@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <304311.1728560215@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 19:36, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> For scenarios such as nfs/cifs, the corresponding bsize is PAGE_SIZE aligned
> 
> cache->bsize is a property of the cache device, not the network filesystems
> that might be making use of it (and it might be shared between multiple
> volumes from multiple network filesystems, all of which could, in theory, have
> different 'block sizes', inasmuch as network filesystems have block sizes).
> 
> David
> 
> 

Then I was wrong. Thank you for pointing it out. I'll be thinking about
new solutions for non-PAGE_SIZE scenarios.

Thanks,
Zizhi Wo

