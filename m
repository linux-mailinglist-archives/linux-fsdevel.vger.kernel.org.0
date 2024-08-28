Return-Path: <linux-fsdevel+bounces-27585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA409628F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66BA1F24A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E06187878;
	Wed, 28 Aug 2024 13:42:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BF187859;
	Wed, 28 Aug 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852546; cv=none; b=TO9iUS+D4gfqqIYh+H5wdVmgYM9f0/q/gig0OOUdnAeRTbDKRMsacBl/fsfBK4JLealhIfAFvGDqtGLHJj6j5BW10Eq1VEA+9zamE/DqNWQgZ+AVqy5gaAZ7vG3vuN91whPTwvRXrCMgsxxeG3rWNfMM+fyiHNfQLridADUN2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852546; c=relaxed/simple;
	bh=FkxFFVdwX1/bT3jf5ugN2YTPZ65TkfFpCS/ghepAw8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OO145qDdyD0dou5FuOcrGhNUfphNz1+AmYSoZFGRwCols+Zj+6z+at+EWpNfuv5Q4DigqGl+1mqtRVzg90z2PCI+h6dmJyETfia6kIjT/2fuee1MLt4Gkn8uKhSRiUc6DCuy33ttRA16lgOU2MpeBG2Da8erFUZyzYYZAOgFFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wv5Db5c8FzyRBl;
	Wed, 28 Aug 2024 21:41:51 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D35180105;
	Wed, 28 Aug 2024 21:42:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 21:42:21 +0800
Message-ID: <a64ff81d-3b3d-44e8-9a1d-0d226dca2c8a@huawei.com>
Date: Wed, 28 Aug 2024 21:42:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module
 exits
To: Christian Brauner <brauner@kernel.org>
CC: <dhowells@redhat.com>, <jlayton@kernel.org>, <netfs@lists.linux.dev>,
	<jefflexu@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <houtao1@huawei.com>, <yukuai3@huawei.com>,
	<wozizhi@huawei.com>, <stable@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Baokun Li <libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
 <20240828-fuhren-platzen-fc6210881103@brauner>
 <b003bb7c-7af0-484f-a6d9-da15b09e3a96@huaweicloud.com>
 <20240828-federn-testreihe-97c4f6ec5772@brauner>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240828-federn-testreihe-97c4f6ec5772@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/8/28 21:37, Christian Brauner wrote:
>> Hi Christian,
>>
>>
>> Thank you for applying this patch!
>>
>> I just realized that the parentheses are in the wrong place here,
>> could you please help me correct them?
>>>> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
>> ^^ remove_proc_subtree() instead
> Sure, done.
>
Thanks a lot!


Cheers,
Baokun



