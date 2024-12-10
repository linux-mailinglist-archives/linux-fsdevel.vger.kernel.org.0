Return-Path: <linux-fsdevel+bounces-36876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A39EA435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A76A288D77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCBE5588B;
	Tue, 10 Dec 2024 01:21:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE50282ED;
	Tue, 10 Dec 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793695; cv=none; b=KZ/V04jTo/EBmUlPghiVzgqY58ZnGNgnRVnUAs0Db1eMWQVX6sUUWaJmV2oIyzjhbtDgz0A0APiebhNKdKO8xeA9t98PEL7K3nfq/v5QlEA1HzzCVAq/MJKqWDhRT5qIY3PTjfFr5P/F2g63PKBQgdK57NWTAloKJWm03GOrqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793695; c=relaxed/simple;
	bh=vdUjpPTqmXd/8HheJXGR4qcMtnPpsYqOA5AoCiHq//A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQfsMa8MdVAylFGzowWdBn2sn7zvEJA82TkWTkVWwzcAOYUwJd18GOBvG7Q7n/T88jP0oVKMariU+cfKi6P1IYm8hymWSlXNybhvNfywUYjfoh7uSxBXf5+oCkVjzCLtTxkd5nhsYNkFifXM/g5FzslUFVkKwqu3UAri+xBcQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Y6gqY21kkz1T6kl;
	Tue, 10 Dec 2024 09:19:05 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id D1B3C14010C;
	Tue, 10 Dec 2024 09:21:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 09:21:28 +0800
Message-ID: <1457e171-17d0-7e1c-1526-10643ca76399@huawei.com>
Date: Tue, 10 Dec 2024 09:21:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/2] userfaultfd: handle few NULL check inline
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <Liam.Howlett@oracle.com>,
	<lokeshgidra@google.com>, <rppt@kernel.org>, <aarcange@redhat.com>,
	<Jason@zx2c4.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
 <f7f1b152-3f25-4df3-9589-2fceb6d18613@lucifer.local>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <f7f1b152-3f25-4df3-9589-2fceb6d18613@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/12/9 21:42, Lorenzo Stoakes wrote:
> On Mon, Dec 09, 2024 at 09:25:47PM +0800, Jinjie Ruan wrote:
>> Handle dup_userfaultfd() and anon_vma_fork() NULL check inline to
>> save some function call overhead. The Unixbench single core process
>> create has 1% improve with these patches.
>>
>> Jinjie Ruan (2):
>>   userfaultfd: handle dup_userfaultfd() NULL check inline
>>   mm, rmap: handle anon_vma_fork() NULL check inline
>>
>>  fs/userfaultfd.c              |  5 +----
>>  include/linux/rmap.h          | 12 +++++++++++-
>>  include/linux/userfaultfd_k.h | 11 ++++++++++-
>>  mm/rmap.c                     |  6 +-----
>>  4 files changed, 23 insertions(+), 11 deletions(-)
>>
>> --
>> 2.34.1
>>
> 
> Coincidentally I've just diagosed a rather nasty bug in this code [0], so
> could we hold off on this change for just a little bit until we can get a
> fix out for this please?
> 
> I'd rather not complicate anything until we're sure we won't need to change
> this.

Sure, fix the bugs is a more urgent problem.

Thanks!

> 
> Thanks!
> 
> 
> [0]:https://lore.kernel.org/linux-mm/aa2c1930-becc-4bc5-adfb-96e88290acc7@lucifer.local/
> 

