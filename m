Return-Path: <linux-fsdevel+bounces-22935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B85B923CF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 13:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A08288EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA2F15B14C;
	Tue,  2 Jul 2024 11:55:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7215B12A;
	Tue,  2 Jul 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921335; cv=none; b=BKYyjMNDP4attL0lXmOUyhlQvqwSIZ0r/XeZ4TKPzsCUEhWaB7dNrfk12DhXCd/eX0EIk1Uj0NGu4fIK82uokf6BWTMxwHa+X+AYhxmu8zyxM2aQn7DZ55mFIaKpkfVF9nmJRVMroIO+zIZglGVZ8fC+8Ly9VwpojQl8FjXY0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921335; c=relaxed/simple;
	bh=OHscLV2BTLtiC2p82LrkzFzfznTmK19Zg5uCDN4aAvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M8T+HV4QJMeOr7qn6j6XcVf5wqm9oP+PoMYAHF1BzeMmufhIa7uOP+PteRVV/+TrcJkr8KS0itA5+BTUbK3ubLv/9we4uSPKkUsCwXKgiQDVZD+5GXuW6GLWyuKwbLIJ0cPPtw83upETw0NA1rC1Z58tdWypjSFDq7OLGeuq35Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WD1Yt3YpmznX51;
	Tue,  2 Jul 2024 19:55:14 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E5277140414;
	Tue,  2 Jul 2024 19:55:29 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 19:55:29 +0800
Message-ID: <1eca1fcd-5479-47b2-b7ba-eb4027135af2@huawei.com>
Date: Tue, 2 Jul 2024 19:55:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
To: Steven Rostedt <rostedt@goodmis.org>
CC: <muchun.song@linux.dev>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
 <20240612011156.2891254-3-lihongbo22@huawei.com>
 <20240701194906.3a9b6765@gandalf.local.home>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240701194906.3a9b6765@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/2 7:49, Steven Rostedt wrote:
> On Wed, 12 Jun 2024 09:11:56 +0800
> Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>> @@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
>>   	if (error)
>>   		return error;
>>   
>> +	trace_hugetlbfs_setattr(inode, dentry->d_name.len, dentry->d_name.name,
>> +			attr->ia_valid, attr->ia_mode,
>> +			from_kuid(&init_user_ns, attr->ia_uid),
>> +			from_kgid(&init_user_ns, attr->ia_gid),
>> +			inode->i_size, attr->ia_size);
>> +
> 
> That's a lot of parameters to pass to a tracepoint. Why not just pass the
> dentry and attr and do the above in the TP_fast_assign() logic? That would
> put less pressure on the icache for the code part.

Thanks for reviewing!

Some logic such as kuid_t --> uid_t might be reasonable obtained in 
filesystem layer. Passing the dentry and attr will let trace know the 
meaning of structure, perhaps tracepoint should not be aware of the
members of these structures as much as possible.

Thanks,
Hongbo

> 
> -- Steve
> 

