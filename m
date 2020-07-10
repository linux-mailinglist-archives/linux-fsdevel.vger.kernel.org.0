Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB14921AC5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 03:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgGJBFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 21:05:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbgGJBFb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:05:31 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CEECEF12BB245A9D0CA7;
        Fri, 10 Jul 2020 09:05:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 10 Jul
 2020 09:05:24 +0800
Subject: Re: [PATCH 5/5] f2fs: support direct I/O with fscrypt using
 blk-crypto
To:     Satya Tangirala <satyat@google.com>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>
CC:     Eric Biggers <ebiggers@google.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-6-satyat@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <560266ca-0164-c02e-18ea-55564683d13e@huawei.com>
Date:   Fri, 10 Jul 2020 09:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200709194751.2579207-6-satyat@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/7/10 3:47, Satya Tangirala wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up f2fs with fscrypt direct I/O support.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  fs/f2fs/f2fs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b35a50f4953c..6d662a37b445 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4082,7 +4082,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	int rw = iov_iter_rw(iter);
>  
> -	if (f2fs_post_read_required(inode))
> +	if (!fscrypt_dio_supported(iocb, iter))
> +		return true;
> +	if (fsverity_active(inode))

static inline bool f2fs_post_read_required(struct inode *inode)
{
	return f2fs_encrypted_file(inode) || fsverity_active(inode) ||
		f2fs_compressed_file(inode);
}

That's not correct, missed to check compression condition.

>  		return true;
>  	if (f2fs_is_multi_device(sbi))
>  		return true;
> 
