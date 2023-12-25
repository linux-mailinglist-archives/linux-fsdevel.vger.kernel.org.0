Return-Path: <linux-fsdevel+bounces-6895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E76A81DD9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 03:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F981F21C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986ADED5;
	Mon, 25 Dec 2023 02:33:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAA808;
	Mon, 25 Dec 2023 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Sz24571ttzvSYc;
	Mon, 25 Dec 2023 10:32:21 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D31B18005E;
	Mon, 25 Dec 2023 10:33:21 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 10:33:20 +0800
Message-ID: <a4d6ca25-cb8d-f3f9-ed4e-3a55378fdfde@huawei.com>
Date: Mon, 25 Dec 2023 10:33:20 +0800
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
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Edward Adam Davis <eadavis@qq.com>,
	<syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>, yangerkun
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
 <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
 <20231225020754.GE1674809@ZenIV>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20231225020754.GE1674809@ZenIV>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/25 10:07, Al Viro wrote:
> On Mon, Dec 25, 2023 at 09:38:51AM +0800, Baokun Li wrote:
>
>> In my opinion, it doesn't make sense to call lock_two_nondirectories()
>> here to determine if the inode is a regular file or not, since the logic
>> for dealing with non-regular files comes after the locking, so calling
>> lock_two_inodes() directly here will suffice.
> No.  First of all, lock_two_inodes() is a mistake that is going to be
> removed in the coming cycle.
Okay, I didn't know about this.
> What's more, why the hell do you need to lock *anything* to check the
> inode type?  Inode type never changes, period.
>
> Just take that check prior to lock_two_nondirectories() and be done with
> that.
Since in the current logic we update the boot loader file via
swap_inode_boot_loader(), however the boot loader inode on disk
may be uninitialized and may be garbage data, so we allow to get a
bad boot loader inode and then initialize it and swap it with the boot
loader file to be set.
When reinitializing the bad boot loader inode, something like an
inode type conversion may occur.

Cheers,
Baokun

