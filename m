Return-Path: <linux-fsdevel+bounces-12019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C885A4B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 14:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FF21C23A37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 13:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8FB37702;
	Mon, 19 Feb 2024 13:34:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EC37163;
	Mon, 19 Feb 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349673; cv=none; b=AJQsDYV3JCA+HtRFRWKAimttDqBvdE8UE/1SKOAGV2/NmfFLiHbrJY5Qr31MM4M12bUZ6vAYufC3OGZV7FaOrTmtpx4PXWZKHMJoC6Wd/iycfoaNfsz1MYDYN87cg3R7SSYJGN6W+UCv5avdxbH+bpc/XVKVOBi1ZA03SkPO6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349673; c=relaxed/simple;
	bh=jvjjFHFfxSy6PwSy6ZuC3dVfl4dpSnVEAwHLIFXHG+I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hrgf8dwPG3vn6KM4C7s3EVIDasbedDgKWFvPegMr7lIxFRL5+svtYKM4nz0kPAwVHe9cUmaEnMsL59NAoWhjLvtFFd4PFzww7AThuLJxIJ/VkzilGYNxqlwJrfn6sOdv3DDXldFoRSiS2BmTR4HH9LNzDmBlBui92ZJBKnjOEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tdk3j1gyTz1X2kj;
	Mon, 19 Feb 2024 21:32:17 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id BBF181400CB;
	Mon, 19 Feb 2024 21:34:24 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 21:34:23 +0800
Subject: Re: [PATCH RFC 2/2] fs,drivers: remove bdev_inode() usage outside of
 block layer and drivers
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong"
	<djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>
References: <20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org>
 <20240129-vfs-bdev-file-bd_inode-v1-2-42eb9eea96cf@kernel.org>
 <20240129143709.GA568@lst.de>
 <20240129-lobpreisen-arterien-e300ee15dba8@brauner>
 <20240129153637.GA2280@lst.de>
From: Yu Kuai <yukuai3@huawei.com>
Message-ID: <3aa4113a-d396-0e85-0f25-adae6a2e8506@huawei.com>
Date: Mon, 19 Feb 2024 21:34:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240129153637.GA2280@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Hi,

ÔÚ 2024/01/29 23:36, Christoph Hellwig Ð´µÀ:
> On Mon, Jan 29, 2024 at 04:29:32PM +0100, Christian Brauner wrote:
>> On Mon, Jan 29, 2024 at 03:37:09PM +0100, Christoph Hellwig wrote:
>>> Most of these really should be using proper high level APIs.  The
>>> last round of work on this is here:
>>>
>>> https://lore.kernel.org/linux-nilfs/4b11a311-c121-1f44-0ccf-a3966a396994@huaweicloud.com/
>>
>> Are you saying that I should just drop this patch here?
> 
> I think we need to order the work:
> 
>   - get your use struct file as bdev handle series in
>   - rebase the above series on top of that, including some bigger changes
>     like block2mtd which can then use normal file read/write APIs

I'm working on that now, mostly convert to use bdev_file, and file_inode
or f_mapingo
>   - rebase what is left of this series on top of that, and hopefully not
>     much of this patch and a lot less of patch 1 will be left at that
>     point.
> 
> .
> 

