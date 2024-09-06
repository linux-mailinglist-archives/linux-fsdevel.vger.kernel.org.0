Return-Path: <linux-fsdevel+bounces-28820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06A96E7C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 04:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C731B22C90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F9335BA;
	Fri,  6 Sep 2024 02:35:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886A182B3;
	Fri,  6 Sep 2024 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725590117; cv=none; b=mBdT4a9iojyV4aoTMLplwqnCKtk1ohE+R3gTr22gVSqryZQanJNlKo0ZzK6XTT636kY2Psw8N/6xEgptC9ArXrZRJVtM7IKd70kBPMi6lZLFgh6ca+uoMC2mAkVEYfslZzn1S5Bi1GWbRxdc1efuqmVCV4I7x6/TEExVpMnYOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725590117; c=relaxed/simple;
	bh=WhQeqFtAGTX6XYbCEXQ9ZmWwEhxISb8ziXHJQ0oDfDI=;
	h=Subject:References:CC:From:To:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z23a5oZw5yw94Bs4ksokfXcDl8RFKaRdswhgnULjC7vXUppsggfeIRGO14vda3uV3P0+te43405sNxjH3pFs9N4XEta0zx5FB7V6EmBq8QsvsnuCnMPWq/REn7YUX7NPtXhq6thhzfL8gb278jyWpFMCIIuasifaVUXWfRYTDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X0KvS2Qykz69Wr;
	Fri,  6 Sep 2024 10:30:12 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id A052E1800F2;
	Fri,  6 Sep 2024 10:35:11 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 10:35:09 +0800
Subject: Re: [PATCH v2 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
References: <CGME20240903033105eucas1p2b9d0b874da268fecb49905d90340de09@eucas1p2.samsung.com>
 <20240903033011.2870608-1-yukaixiong@huawei.com>
 <20240903203837.cbzs3ziuh6eq4kvo@joelS2.panther.com>
CC: <guohanjun@huawei.com>, <ysato@users.osdn.me>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<kees@kernel.org>, <willy@infradead.org>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>,
	<anna@kernel.org>, <chuck.lever@oracle.com>, <jlayton@kernel.org>,
	<neilb@suse.de>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
To:
	<"wangkefeng.wang@huawei.com liushixin2@huawei.com liuyongqiang13@huawei.com tongtiangen@huawei.com sunnanyong@huawei.com mawupeng1@huawei.com zuoze1@huawei.com zhangpeng362@huawei.com tujinjiang@huawei.com yaolulu5"@huawei.com>
Message-ID: <0a12953b-0d11-00d2-ef0e-454d0e3d98f3@huawei.com>
Date: Fri, 6 Sep 2024 10:35:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240903203837.cbzs3ziuh6eq4kvo@joelS2.panther.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100009.china.huawei.com (7.185.36.95) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/9/4 4:38, Joel Granados wrote:
> On Tue, Sep 03, 2024 at 11:29:56AM +0800, Kaixiong Yu wrote:
>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>> places where they actually belong, and do some related code clean-ups.
>> After this patch series, all sysctls in vm_table have been moved into its
>> own files, meanwhile, delete vm_table.
>>
>> All the modifications of this patch series base on
>> linux-next(tags/next-20240902). To test this patch series, the code was
>> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
>> x86_64 architectures. After this patch series is applied, all files
>> under /proc/sys/vm can be read or written normally.
> This move make a lot of sense. The question with these multi-subsystem
> patchsets is how do they go into mainline. For now I have added this to
> sysctl-testing to see if it needs more work. I can push this through the
> sysctl subsystem, but you need to get reviewed-by for all of the commits
> in different subsystems. I'm also fine with this going in through some
> other subsys if anyone wants to take it?
>
> Best
>

Thx，Joel!:-)

Hello，everyone!

This patch series has been reviewed by Kees, Jan Kara, Christian 
Brauner, and acked
by Anna Schumaker, Paul Moore. As Joel said, this patch series need to 
get reviewed-by
for all of the commits in different subsystems. I would appreciate it if 
you could review
this patch series as soon as possible !:-)

