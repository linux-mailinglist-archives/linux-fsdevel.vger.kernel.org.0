Return-Path: <linux-fsdevel+bounces-55555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58216B0BD2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E459C189BCCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7492280CD3;
	Mon, 21 Jul 2025 07:05:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB12822DFA6;
	Mon, 21 Jul 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081535; cv=none; b=ADhV7JLRM1kK7eZ/KoqnpHmO2ABodtQDRPlFcaRume+Lc7/gPscqloGHfSiaElDMmjPj792uYC0ppZBN5o4iJ54zIeciBHeeUfstTBUcuMKdnVnRK9yo5uVq3h0ddkILNawhiC1lipKv1nsAaVtn7eOtAlzHhosbRiwmQGyEOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081535; c=relaxed/simple;
	bh=gsXX+x0AhxqLNqqJn8QMIAlWBKl8aVEZcPd9LMjYaRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kQkLMcQi8JffrGfMnuP0B2NKbQQy5Fb6i9lZZCE5uhq2ln2NJjlG1NXkW8f6xlcfR0yu6x69adWJuatMPwRhroXNER5X+HHZwxty3rYeMidAV6G1PyQtILt1aMJaU1SSTfKZcG/j9R5ZNOBXWTxXrI1JAHWaODWJI+wNQ6aMd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4blrsX4q39zdbyW;
	Mon, 21 Jul 2025 15:01:20 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BB92180478;
	Mon, 21 Jul 2025 15:05:30 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Jul 2025 15:05:29 +0800
Message-ID: <076aefb1-ec3a-471b-b299-5fa9a2a9495d@huawei.com>
Date: Mon, 21 Jul 2025 15:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Add additional checks for block devices during mount
To: Christoph Hellwig <hch@lst.de>, Zizhi Wo <wozizhi@huaweicloud.com>
CC: kernel test robot <lkp@intel.com>, <viro@zeniv.linux.org.uk>,
	<jack@suse.com>, <brauner@kernel.org>, <axboe@kernel.dk>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250719024403.3452285-1-wozizhi@huawei.com>
 <202507192025.N75TF4Gp-lkp@intel.com>
 <b60e4ef2-0128-4e56-a15f-ea85194a3af0@huaweicloud.com>
 <20250721064712.GA28899@lst.de>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <20250721064712.GA28899@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2025/7/21 14:47, Christoph Hellwig 写道:
> On Mon, Jul 21, 2025 at 09:20:27AM +0800, Zizhi Wo wrote:
>> Sorry, disk_live() is only declared but not defined when CONFIG_BLOCK is
>> not set...
> 
> You can just add a if (IS_ENABLED(CONFIG_BLOCK)) check around it.

Yes, adding this judgment directly is also fine.

> 
> 
> But the layering here feels wrong.  sget_dev and it's helper operate
> purely on the dev_t.  Anything actually dealing with a block device /
> gendisk should be in the helpers that otherwise use it.
> 
> 

Do you mean performing the check outside of sget_dev()? That is, after
we obtain an existing superblock, we then check whether the block device
exists, and if it doesn't, we report the error in the outer layer (e.g.,
in get_tree_bdev_flags(), this function seems to be targeted at bdev
rather than just dev)?

Thanks,
Zizhi Wo

