Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A246B08C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbfILGRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 02:17:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfILGRm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:17:42 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F5231408ADFCDD35F6B;
        Thu, 12 Sep 2019 14:17:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 12 Sep
 2019 14:17:33 +0800
Subject: Re: [PATCH 3/3] f2fs: fix inode rwsem regression
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        <linux-fsdevel@vger.kernel.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <hch@infradead.org>, <andres@anarazel.de>, <david@fromorbit.com>,
        <riteshh@linux.ibm.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        "Goldwyn Rodrigues" <rgoldwyn@suse.com>
References: <20190911093926.pfkkx25mffzeuo32@alap3.anarazel.de>
 <20190911164517.16130-1-rgoldwyn@suse.de>
 <20190911164517.16130-4-rgoldwyn@suse.de>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <77bec57d-2bd1-db40-917e-7dccb58cb3b7@huawei.com>
Date:   Thu, 12 Sep 2019 14:17:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190911164517.16130-4-rgoldwyn@suse.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/12 0:45, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is similar to 942491c9e6d6 ("xfs: fix AIM7 regression")
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our read/write methods to just do the
> trylock for the RWF_NOWAIT case.
> 
> We don't need a check for IOCB_NOWAIT and !direct-IO because it
> is checked in generic_write_checks().
> 
> Fixes: b91050a80cec ("f2fs: add nowait aio support")
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/f2fs/file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3e58a6f697dd..c6f3ef815c05 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3134,16 +3134,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		goto out;
>  	}
>  
> -	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}

We have removed above redundant check, could you rebase to dev-test branch of
Jaegeuk's git tree?

Otherwise it looks good to me.

Thanks,

> -
> -	if (!inode_trylock(inode)) {
> -		if (iocb->ki_flags & IOCB_NOWAIT) {
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode)) {
>  			ret = -EAGAIN;
>  			goto out;
>  		}
> +	} else {
>  		inode_lock(inode);
>  	}
>  
> 
