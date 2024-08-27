Return-Path: <linux-fsdevel+bounces-27273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8B95FFA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16899B21B09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235117C9B;
	Tue, 27 Aug 2024 03:07:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925B18030;
	Tue, 27 Aug 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728060; cv=none; b=kaRtkSjoIzTyLdt8xIQx/Vh+XcNqeOD1623T30IystpJpTyvEYVp880vEok78+QMMf+ZPp5p3ZhT44C6G2H+DCvcGUv+jPRBni6nM0MLLnXDy5CkuMRtdCwvzdA0bYuoWxXtUR6Vto3mx+fJIgYDkPOHEe1bGDZkNs6pR8o/Lsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728060; c=relaxed/simple;
	bh=CyZfbQmPhMQsZgkcv0sUPwAENxyiX4nXFW6VgAc4L2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nrqAEceH8bn0lQkoi4Qm9JcJBPgS3hqqXyRtoSXhr1fvpEFp2d9l9jQgeiekbQCch8EU27LIacpCDUW25IFd5PCFBHGPmewNL7uJRnMozdJME14w24vhk9a6CtaAmYV62yd10DmIbuOKuLXc3mNwefXri4IiLikOPF/iOPSgofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtCBJ4r0Kz16PTM;
	Tue, 27 Aug 2024 11:06:48 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FC3B140137;
	Tue, 27 Aug 2024 11:07:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 11:07:34 +0800
Message-ID: <e756e428-1300-45c8-84b7-178c14c9ff62@huawei.com>
Date: Tue, 27 Aug 2024 11:07:34 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <brauner@kernel.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
	<gnoack@google.com>, <mic@digikod.net>, <linux-fsdevel@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <Zs0_qeIPppYYLTac@casper.infradead.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <Zs0_qeIPppYYLTac@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 10:53, Matthew Wilcox wrote:
> On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
>> Many mainstream file systems already support the GETVERSION ioctl,
>> and their implementations are completely the same, essentially
>> just obtain the value of i_generation. We think this ioctl can be
>> implemented at the VFS layer, so the file systems do not need to
>> implement it individually.
> 
> ... then you should also remove the implementation from every
> filesystem, not just add it to the VFS.
> 

Yeah, this is just an RFC submission, mainly to see what everyone's 
opinions are. If this is ok, I will send the v2 that includes the 
removal of all file systems' implementations on IOC_GETVERSION.

Thanks,
Hongbo

> 

