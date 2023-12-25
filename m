Return-Path: <linux-fsdevel+bounces-6898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF8481DDAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7574B1F21C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16CEC5;
	Mon, 25 Dec 2023 02:56:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BC804;
	Mon, 25 Dec 2023 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sz2bR4tfVzsS7B;
	Mon, 25 Dec 2023 10:56:03 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id CC1951800BB;
	Mon, 25 Dec 2023 10:56:26 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 10:56:26 +0800
Message-ID: <33830a07-ffa9-d5da-d082-be1037d53ad8@huawei.com>
Date: Mon, 25 Dec 2023 10:56:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>
CC: Al Viro <viro@zeniv.linux.org.uk>, Edward Adam Davis <eadavis@qq.com>,
	<syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, yangerkun <yangerkun@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
 <20231225020754.GE1674809@ZenIV>
 <a4d6ca25-cb8d-f3f9-ed4e-3a55378fdfde@huawei.com>
 <20231225024906.GD491196@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231225024906.GD491196@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/25 10:49, Theodore Ts'o wrote:
> On Mon, Dec 25, 2023 at 10:33:20AM +0800, Baokun Li wrote:
>> Since in the current logic we update the boot loader file via
>> swap_inode_boot_loader(), however the boot loader inode on disk
>> may be uninitialized and may be garbage data, so we allow to get a
>> bad boot loader inode and then initialize it and swap it with the boot
>> loader file to be set.
>> When reinitializing the bad boot loader inode, something like an
>> inode type conversion may occur.
> Yes, but the boot laoder inode is *either* all zeros, or a regular
> file.  If it's a directory, then it's a malicious syzbot trying to
> mess with our minds.
>
> Aside from the warning, it's pretty harmless, but it will very likely
> result in a corrupted file system --- but the file system was
> corrupted in the first place.  So who cares?
>
> Just check to make sure that i_mode is either 0, or regular file, and
> return EFSCORRUPTEd, and we're done.
>
>     	     		      	  	 	       - Ted
Yes, this seems to work, but for that matter, when i_mode is 0, we
still trigger the WARN_ON_ONCE in lock_two_nondirectories().

Merry Christmas!
-- 
With Best Regards,
Baokun Li
.

