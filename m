Return-Path: <linux-fsdevel+bounces-37785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F89F7A26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3898416EE60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA4223E6C;
	Thu, 19 Dec 2024 11:15:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8C223C7B;
	Thu, 19 Dec 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606928; cv=none; b=dJG4QLDkZivzrPlep7Yh+QMqDsNkgDKjVxZeJ2ipssWnSaJ48iZF4J9MPqzAg7wG6yR5xCDiUJQTb4Ybt7S2/fo0Lbs/glzXInhHkd9puoqGF2TtVfIy6EUDsJgh9HllsHiuicMoFM7IYYFyc1DaFX1QInRXg4/jklS+vvaaaDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606928; c=relaxed/simple;
	bh=5VZPTkXvtP9mboW6aOefRLAEFA01dufNNfD6ISGDIMM=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h27u+JsAWnPeMCnkmXwAL2j308MIhi/RaTkDwb4GTIVrEFO3NFWt8OGD1xClZK0BYSx4WQjN6bQcos3Fr+blNBUz+PKa7GmG4gRqyafhPqVjeldy/eHKoBuuAuoC/FVfF0V9O56BlcTPdih2IrrxliWA3++2S/I6QSFpj5ZRJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YDSbC6M4Kz21kWm;
	Thu, 19 Dec 2024 19:13:27 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 601141A0171;
	Thu, 19 Dec 2024 19:15:21 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 19:15:17 +0800
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: Joel Granados <j.granados@samsung.com>
References: <CGME20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd@eucas1p1.samsung.com>
 <20241010152215.3025842-1-yukaixiong@huawei.com>
 <ngknhtecptqk56gtiikvb5mdujhtxdyngzndiaz7ifslzrki7q@4wcykosdnsna>
 <79b33640-fc81-b4c1-4967-30189d9a4b23@huawei.com>
 <wk7dqsx42rxjt76dowrydumhinwwdltw7e5ptp7fh4rc4c4sji@jrtopui4fpwb>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <kees@kernel.org>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<joel.granados@kernel.org>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <69509584-92c2-6bcd-0aef-406af7606239@huawei.com>
Date: Thu, 19 Dec 2024 19:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <wk7dqsx42rxjt76dowrydumhinwwdltw7e5ptp7fh4rc4c4sji@jrtopui4fpwb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100006.china.huawei.com (7.185.36.169) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/10/24 16:59, Joel Granados wrote:
> On Thu, Oct 24, 2024 at 04:07:10PM +0800, yukaixiong wrote:
> ...
>>
>>>>    mm/swap.c                          |  16 ++-
>>>>    mm/swap.h                          |   1 +
>>>>    mm/util.c                          |  67 +++++++--
>>>>    mm/vmscan.c                        |  23 +++
>>>>    mm/vmstat.c                        |  44 +++++-
>>>>    net/sunrpc/auth.c                  |   2 +-
>>>>    security/min_addr.c                |  11 ++
>>>>    23 files changed, 330 insertions(+), 312 deletions(-)
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>> General comment for the patchset in general. I would consider making the
>>> new sysctl tables const. There is an effort for doing this and it has
>>> already lanted in linux-next. So if you base your patch from a recent
>>> next release, then it should just work. If you *do* decide to add a
>>> const qualifier, then note that you will create a dependency with the
>>> sysctl patchset currently in next and that will have to go in before.
>>>
>>> Best
>>>
>> Sorry,  I don't understand what is the meaning of "create a dependency
>> with the sysctl patchset".
> The patches in the sysctl subsys that allow you to qualify the ctl_table
> as const are not in mainline yet. They are in linux-next. This means
> that if these patches go into the next kernel release before the
> sysctl-next branch, it will have compilation errors. Therefore the
> sysctl-next branch needs to be pulled in to the new kernel release
> before this patchest. This also means that for this to build properly it
> has to be based on a linux-next release.
>
>> Do you just want me to change all "static struct ctl_table" type table
>> into "static const struct ctl_table" type in my patchset?
> You should const qualify them if the maintainer that is pulling in these
> patches is ok with it. You should *not* const qualify them if the
> maintainer prefers otherwise.
>
> Please get back to me if I did not address your questions.
>
> Best

Thank you! Now， I decide to const qualify them. Maybe, it will be better.


