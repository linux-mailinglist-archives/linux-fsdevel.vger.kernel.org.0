Return-Path: <linux-fsdevel+bounces-30028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F159850FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 04:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757B01C2347A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946A148857;
	Wed, 25 Sep 2024 02:33:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE4148827;
	Wed, 25 Sep 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727231588; cv=none; b=CmGEplKcDzgHQcF8K+gsbX4/Ullgzh/lSMqtT6NZgowoluLTNlDGK0kYizYwA7FgF/YBWiOLQ6zFe92T+2FQBlOkJToNaC7lBy6jGCTZUoFni7NHGoX37Jtwi0SA5PU3uiaMEl7X/24QMHpII9ULtp7lowjAj6B0PycCzRBCVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727231588; c=relaxed/simple;
	bh=9XQtUOB6cMWE2DOXtzux3+RG/MlNQPSP3VK2sXFiRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KiSn8kPda5eg6+mu3Vn428Bi2alhus9iQchRSt6fWinqS5w9BMqQF2/+EOgQ5bw8t0Ft8kZ5lnzTQy1UfDpAhErQCZ6RgCrfwmUqYZ2q9+XiiqWrv5DSCo23KXKYeMMgWXrDdIMDC1JCL9nKn+gMlFY4e6D8VIAYYdlU6afnQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XD13s6FRNz1xwp0;
	Wed, 25 Sep 2024 10:32:57 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 527D81A016C;
	Wed, 25 Sep 2024 10:32:56 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 10:32:56 +0800
Message-ID: <39fa2184-e5f4-4709-961c-292917e358e9@huawei.com>
Date: Wed, 25 Sep 2024 10:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: ext4: support relative path for `journal_path` in
 mount option.
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <brauner@kernel.org>,
	<jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <chris.zjh@huawei.com>
References: <20240925015624.3817878-1-lihongbo22@huawei.com>
 <20240925020913.GH3550746@ZenIV>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240925020913.GH3550746@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/25 10:09, Al Viro wrote:
> On Wed, Sep 25, 2024 at 09:56:24AM +0800, Hongbo Li wrote:
>> @@ -156,6 +156,9 @@ int fs_lookup_param(struct fs_context *fc,
>>   		f = getname_kernel(param->string);
>>   		if (IS_ERR(f))
>>   			return PTR_ERR(f);
>> +		/* for relative path */
>> +		if (f->name[0] != '/')
>> +			param->dirfd = AT_FDCWD;
> 
> Will need to dig around for some context, but this bit definitely makes
> no sense - dirfd is completely ignored for absolute pathnames, so making
> that store conditional is pointless.
> 

Only do it for relative path. As mentioned in [1], if the "journal_path" 
is treated as FSCONFIG_SET_PATH may be better, but mount(8) is passing a 
string (which uses FSCONFIG_SET_STRING for "journal_path"). For the 
relative path case, the dirfd should be assigned.

[1] 
https://lore.kernel.org/all/20240527-mahlen-packung-3fe035ab390d@brauner/

Thanks,
Hongbo

> 

