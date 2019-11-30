Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812D510DCCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 07:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfK3Gnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 01:43:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfK3Gnf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:43:35 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45F41ED1FE56AA51DDDA;
        Sat, 30 Nov 2019 14:43:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 30 Nov
 2019 14:43:28 +0800
Subject: Re: [PATCH] f2fs: Fix direct IO handling
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1a2c49aa-6f12-04d1-129d-c05da3c70f4d@huawei.com>
Date:   Sat, 30 Nov 2019 14:43:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/11/27 7:44, Jaegeuk Kim wrote:
> On 11/26, Damien Le Moal wrote:
>> f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
>> flag for a kiocb structure. However, the file system direct IO handler
>> function f2fs_direct_IO() may have decided that a direct IO has to be
>> exececuted as a buffered IO using the function f2fs_force_buffered_io().
>> This is the case for instance for volumes including zoned block device
>> and for unaligned write IOs with LFS mode enabled.
>>
>> These 2 different methods of identifying direct IOs can result in
>> inconsistencies generating stale data access for direct reads after a
>> direct IO write that is treated as a buffered write. Fix this
>> inconsistency by combining the IOCB_DIRECT flag test with the result
>> of f2fs_force_buffered_io().
>>
>> Reported-by: Javier Gonzalez <javier@javigon.com>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  fs/f2fs/data.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 5755e897a5f0..8ac2d3b70022 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  	int flag;
>>  	int err = 0;
>>  	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>> +	bool do_direct_io = direct_io &&
>> +		!f2fs_force_buffered_io(inode, iocb, from);
>>  
>>  	/* convert inline data for Direct I/O*/
>>  	if (direct_io) {
>> @@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>  			return err;
>>  	}
>>  
>> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
>> +	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
> 
> It seems f2fs_force_buffered_io() includes allow_outplace_dio().
> 
> How about this?
> ---
>  fs/f2fs/data.c | 13 -------------
>  fs/f2fs/file.c | 35 +++++++++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a034cd0ce021..fc40a72f7827 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1180,19 +1180,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>  	int err = 0;
>  	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
>  
> -	/* convert inline data for Direct I/O*/
> -	if (direct_io) {
> -		err = f2fs_convert_inline_inode(inode);
> -		if (err)
> -			return err;
> -	}
> -
> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
> -		return 0;
> -
> -	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> -		return 0;
> -
>  	map.m_lblk = F2FS_BLK_ALIGN(iocb->ki_pos);
>  	map.m_len = F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
>  	if (map.m_len > map.m_lblk)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c0560d62dbee..6b32ac6c3382 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3386,18 +3386,33 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  				ret = -EAGAIN;
>  				goto out;
>  			}
> -		} else {
> -			preallocated = true;
> -			target_size = iocb->ki_pos + iov_iter_count(from);
> +			goto write;
> +		}
>  
> -			err = f2fs_preallocate_blocks(iocb, from);
> -			if (err) {
> -				clear_inode_flag(inode, FI_NO_PREALLOC);
> -				inode_unlock(inode);
> -				ret = err;
> -				goto out;
> -			}
> +		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> +			goto write;
> +
> +		if (iocb->ki_flags & IOCB_DIRECT) {
> +			/* convert inline data for Direct I/O*/

Minor thing.

I/O */

> +			err = f2fs_convert_inline_inode(inode);
> +			if (err)
> +				goto out_err;
> +
> +			if (!f2fs_force_buffered_io(inode, iocb, from))
> +				goto write;

We can call f2fs_convert_inline_inode() here to avoid unneeded inline
conversion.

Thanks,

> +		}
> +		preallocated = true;
> +		target_size = iocb->ki_pos + iov_iter_count(from);
> +
> +		err = f2fs_preallocate_blocks(iocb, from);
> +		if (err) {
> +out_err:
> +			clear_inode_flag(inode, FI_NO_PREALLOC);
> +			inode_unlock(inode);
> +			ret = err;
> +			goto out;
>  		}
> +write:
>  		ret = __generic_file_write_iter(iocb, from);
>  		clear_inode_flag(inode, FI_NO_PREALLOC);
>  
> 
