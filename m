Return-Path: <linux-fsdevel+bounces-30210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7D987CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 03:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0F7B21938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 01:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6E169AE4;
	Fri, 27 Sep 2024 01:52:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84714A4CC;
	Fri, 27 Sep 2024 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401931; cv=none; b=H38RMEcfT1RVpmTeRw8/HUtXHS782ISKqmC0klACVUfSU/0YijghlCZ4Zgv3hEmM+F/dcFyxSxOMCE7a94+VpfFurlvxs3rtXiVqNAffW501tnM7rFbDc8eAGK+Mq+mXcbbZIWbOecYDUQsyRnhvOkBqgiE0VaSNA5d//xpnENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401931; c=relaxed/simple;
	bh=NrM/MrKwFUWl8fIBs4f3+6v/J5BNyzEZY7/9Bq8CNhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WGpWozGlnlxfOsYJjRU88wIsDvf937lPSI5VzvKh6wmDe4zxSGFrnHA65IYAps8zKoJbzIdGauZ6fu+APCFMdSAEP3dmYkpAv4j154Jmz15QmTVzzRe1r1hNB71QABBdDfhmkZ39O2VMhQXX2u3yDVgD00HiZweACiCV/SeujCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XFD2S4fGbzySSS;
	Fri, 27 Sep 2024 09:50:56 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C36818010A;
	Fri, 27 Sep 2024 09:51:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.174) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Sep
 2024 09:51:58 +0800
Message-ID: <11e3133e-6069-477f-9c4a-3698bd6a18ec@huawei.com>
Date: Fri, 27 Sep 2024 09:51:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Eric Sandeen <sandeen@sandeen.net>
CC: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	<tytso@mit.edu>, <stable@vger.kernel.org>, Andreas Dilger
	<adilger.kernel@dilger.ca>, =?UTF-8?Q?St=C3=A9phane_Graber?=
	<stgraber@stgraber.org>, Christian Brauner <brauner@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-ext4@vger.kernel.org>, Wesley Hershberger
	<wesley.hershberger@canonical.com>, Yang Erkun <yangerkun@huawei.com>, Jan
 Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
 <20240925155706.zad2euxxuq7h6uja@quack3>
 <142a28f9-5954-47f6-9c0c-26f7c142dbc1@huawei.com>
 <ac29f2ba-7f77-4413-82b9-45f377f6c971@sandeen.net>
 <7521d6a5-eb58-4418-8c2a-a9950d8faf9c@sandeen.net>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <7521d6a5-eb58-4418-8c2a-a9950d8faf9c@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/9/27 0:29, Eric Sandeen wrote:
> On 9/26/24 11:04 AM, Eric Sandeen wrote:
>
>   
>> Can you explain what the 2 cases under
>>
>> /* Avoid allocating large 'groups' array if not needed */
>>
>> are doing? I *think* the first 'if' is trying not to over-allocate for the last
>> batch of block groups that get added during a resize. What is the "else if" case
>> doing?
> (or maybe I had that backwards)
>
> Incidentally, the offending commit that this fixes (665d3e0af4d35ac) got turned
> into CVE-2023-52622, so it's quite likely that distros have backported the broken
> commit as part of the CVE game.
The commit to fix CVE-2023-52622 is commit 5d1935ac02ca5a
("ext4: avoid online resizing failures due to oversized flex bg").
This commit does not address the off by one issue above.
>
> So the followup fix looks a bit urgent to me.
>
> -Eric
Okay, I'll send out the fix patch today.

Regards,
Baokun
.

