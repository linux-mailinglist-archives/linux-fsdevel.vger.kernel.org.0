Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F89312246
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 08:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBGHrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 02:47:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11691 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGHry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:47:54 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYLlz6xqFzlH7w;
        Sun,  7 Feb 2021 15:45:03 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 7 Feb 2021
 15:46:44 +0800
Subject: Re: [f2fs-dev] [PATCH 3/6] fs-verity: add FS_IOC_READ_VERITY_METADATA
 ioctl
To:     Eric Biggers <ebiggers@kernel.org>, <linux-fscrypt@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-api@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-ext4@vger.kernel.org>, Victor Hsieh <victorhsieh@google.com>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-4-ebiggers@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <107cf2f2-a6fe-57c2-d17d-57679d7c612d@huawei.com>
Date:   Sun, 7 Feb 2021 15:46:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210115181819.34732-4-ebiggers@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On 2021/1/16 2:18, Eric Biggers wrote:
> +static int f2fs_ioc_read_verity_metadata(struct file *filp, unsigned long arg)
> +{
> +	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;

One case is after we update kernel image, f2fs module may no longer support
compress algorithm which current file was compressed with, to avoid triggering
IO with empty compress engine (struct f2fs_compress_ops pointer):

It needs to add f2fs_is_compress_backend_ready() check condition here?

Thanks,

> +
> +	return fsverity_ioctl_read_metadata(filp, (const void __user *)arg);
> +}
