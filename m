Return-Path: <linux-fsdevel+bounces-31551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B1998585
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26EEB2455F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BA1C3F37;
	Thu, 10 Oct 2024 12:04:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E21BFDEE;
	Thu, 10 Oct 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561883; cv=none; b=DiLtqXyeUhq0QQNqpmX34iweRTsxQWlRMIC8jGOaB1yu9f463NI6EWH05bL4MKF/1FNQJc1/IiBQe4yihkTFgwq4tkfmCL0WHLnhHTJlFtIslgsidMa1Xw8Um991s9Lbf7eyjZ79gMGftHd0PiSiNUzdS8VJdATuqndcNrxVTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561883; c=relaxed/simple;
	bh=+ti7+iaC+/ZMJzcBHYfFME65mceK17aAsNlzVfLqVJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QSiyJKucJySYZQ1FuARFIjgNbRSIWBuDFAwGLvA/qATHU43WSjKoCb8oz9Hua9bFUj7kYsUDanZEFuz5vrJ4T8z06DKNehztgEzFoMZfyMgLybuVDHDVCBV5aBGcpendJSRKXSm6XlKJnNPoTKlXjQp8cMRQzfb8PfetNgz+OYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XPT1k6m81zCt9w;
	Thu, 10 Oct 2024 20:03:54 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id D06BF18010F;
	Thu, 10 Oct 2024 20:04:32 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 20:04:31 +0800
Message-ID: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
Date: Thu, 10 Oct 2024 20:04:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in
 object->file
To: David Howells <dhowells@redhat.com>
CC: <netfs@lists.linux.dev>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <20240821024301.1058918-8-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <303977.1728559565@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <303977.1728559565@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 19:26, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> +	spin_lock(&object->lock);
>>   	if (object->file) {
>>   		fput(object->file);
>>   		object->file = NULL;
>>   	}
>> +	spin_unlock(&object->lock);
> 
> I would suggest stashing the file pointer in a local var and then doing the
> fput() outside of the locks.
> 
> David
> 
> 

If fput() is executed outside the lock, I am currently unsure how to
guarantee that file in __cachefiles_write() does not trigger null
pointer dereference...

Thanks,
Zizhi Wo

