Return-Path: <linux-fsdevel+bounces-6896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B481DD9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07F7281C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72DEA6;
	Mon, 25 Dec 2023 02:47:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294AE365;
	Mon, 25 Dec 2023 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sz2Ng2jmJz1wpDM;
	Mon, 25 Dec 2023 10:46:43 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F46B1A01A0;
	Mon, 25 Dec 2023 10:46:48 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 10:46:35 +0800
Message-ID: <36a7c036-c268-0627-cb2d-a737784da62e@huawei.com>
Date: Mon, 25 Dec 2023 10:46:35 +0800
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
CC: Edward Adam Davis <eadavis@qq.com>,
	<syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, yangerkun <yangerkun@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
 <20231225021136.GC491196@mit.edu>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231225021136.GC491196@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/25 10:11, Theodore Ts'o wrote:
> On Mon, Dec 25, 2023 at 09:38:51AM +0800, Baokun Li wrote:
>> Marking the boot loader inode as a bad inode here is useless,
>> EXT4_IGET_BAD allows us to get a bad boot loader inode.
>> In my opinion, it doesn't make sense to call lock_two_nondirectories()
>> here to determine if the inode is a regular file or not, since the logic
>> for dealing with non-regular files comes after the locking, so calling
>> lock_two_inodes() directly here will suffice.
> This is all very silly, and why I consider this sort of thing pure
> syzkaller noise.  It really doesn't protect against any real threat,
> and it encourages people to put all sorts of random crud in kernel
> code, all in the name of trying to shut up syzbot.
Indeed, the warning is meaningless, but it is undeniable that if the
user can easily trigger the warning, something is wrong with the code.
> If we *are* going to care about shutting up syzkaller, the right
> approach is to simply add a check in swap_inode_boot_loader() which
> causes it to call ext4_error() and declare the file system corrupted
> if the bootloader inode is not a regular file, and then return
> -EFSCORRUPTED.
>
> We don't need to add random hacks to ext4_iget(), or in other places...
>
>     	      	     	    	     - Ted
Without considering the case where the boot loader inode is
uninitialized, I think this is fine and the logic to determine if the boot
loader inode is initialized and to initialize it can be removed.

Merry Christmas!
-- 
With Best Regards,
Baokun Li
.

