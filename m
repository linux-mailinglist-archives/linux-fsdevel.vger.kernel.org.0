Return-Path: <linux-fsdevel+bounces-14973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF18859F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A51AB2187A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F284A50;
	Thu, 21 Mar 2024 13:31:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A784038;
	Thu, 21 Mar 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027877; cv=none; b=mua96ZOJL4temxJrRCQt0fHdzlJe/KmoPGCJYqsg4wKaaQXCS03lvHqedq4RN+XHD+MyXUAivJqE0e4EBKbndQ4pWVytdKmu6pZzEvQJhPkSRGQl84ZeFmELgg67bysbfwa5L4MNw+WpiEsO2VlQsGAY58OAOJsj3l5XR3TzOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027877; c=relaxed/simple;
	bh=OhCMX+u/w5DafdAqpyRLtzB5VUIURs138ZjC93mxC5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RszH4FSc0nlzc+485TpjKUQkwEIm6KpUfvVNNuZvnlbBJrhRjGQY7zaxLH3pSeq07tOCkx0X1QqDWLfp4JZe0lW4uk14uGAmyViw/7aF/sU5wq/FJ2mROb8R463S6jwV+vsK6w2crsIcFlsxOEK/6PXmRBmqiZDunnY6xYI0NiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4V0mY50FP4zbdSr;
	Thu, 21 Mar 2024 21:30:17 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C73D140FEA;
	Thu, 21 Mar 2024 21:31:06 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:31:05 +0800
Message-ID: <c798ca36-397d-4406-900b-a2b02c0462b1@huawei.com>
Date: Thu, 21 Mar 2024 21:31:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fs: aio: more folio conversion
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
 <Zfwncw6NrQc6K6ki@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zfwncw6NrQc6K6ki@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/21 20:26, Matthew Wilcox wrote:
> On Thu, Mar 21, 2024 at 04:27:30PM +0800, Kefeng Wang wrote:
>> Convert to use folio throughout aio.
> 
> I see no problems here other than the one you mentioned and the minor
> optimisation I pointed out.  Thanks.

I send v2 to fix the folio check and use the helper, thanks for you review.

