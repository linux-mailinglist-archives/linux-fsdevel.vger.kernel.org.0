Return-Path: <linux-fsdevel+bounces-6891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEA81DD71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 02:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D604E1F2136F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3D808;
	Mon, 25 Dec 2023 01:39:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344F63F;
	Mon, 25 Dec 2023 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Sz0rv1xKxz29gVZ;
	Mon, 25 Dec 2023 09:37:35 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id E02DE1400D5;
	Mon, 25 Dec 2023 09:38:52 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Dec 2023 09:38:52 +0800
Message-ID: <fb653ebf-0225-00b3-df05-6b685a727b41@huawei.com>
Date: Mon, 25 Dec 2023 09:38:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] ext4: fix WARNING in lock_two_nondirectories
To: Edward Adam Davis <eadavis@qq.com>,
	<syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com>
CC: <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>, yangerkun
	<yangerkun@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <000000000000e17185060c8caaad@google.com>
 <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2023/12/24 19:53, Edward Adam Davis wrote:
> If inode is the ext4 boot loader inode, then when it is a directory, the inode
> should also be set to bad inode.
>
> Reported-and-tested-by: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/ext4/inode.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 61277f7f8722..b311f610f008 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4944,8 +4944,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>   		inode->i_fop = &ext4_file_operations;
>   		ext4_set_aops(inode);
>   	} else if (S_ISDIR(inode->i_mode)) {
> -		inode->i_op = &ext4_dir_inode_operations;
> -		inode->i_fop = &ext4_dir_operations;
> +		if (ino == EXT4_BOOT_LOADER_INO)
> +			make_bad_inode(inode);
Marking the boot loader inode as a bad inode here is useless,
EXT4_IGET_BAD allows us to get a bad boot loader inode.
In my opinion, it doesn't make sense to call lock_two_nondirectories()
here to determine if the inode is a regular file or not, since the logic
for dealing with non-regular files comes after the locking, so calling
lock_two_inodes() directly here will suffice.

Merry Christmas!
Baokun
> +		else {
> +			inode->i_op = &ext4_dir_inode_operations;
> +			inode->i_fop = &ext4_dir_operations;
> +		}
>   	} else if (S_ISLNK(inode->i_mode)) {
>   		/* VFS does not allow setting these so must be corruption */
>   		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {



