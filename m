Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0056C414338
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhIVIIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 04:08:04 -0400
Received: from n169-112.mail.139.com ([120.232.169.112]:32207 "EHLO
        n169-112.mail.139.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhIVIID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:08:03 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.255.10] (unknown[113.108.77.67])
        by rmsmtp-lg-appmail-19-12022 (RichMail) with SMTP id 2ef6614ae401290-6d069;
        Wed, 22 Sep 2021 16:06:26 +0800 (CST)
X-RM-TRANSID: 2ef6614ae401290-6d069
Message-ID: <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
Date:   Wed, 22 Sep 2021 16:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3] ovl: fix null pointer when filesystem doesn't support
 direct IO
To:     Huang Jianan <huangjianan@oppo.com>, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        chao@kernel.org
Cc:     guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
From:   Chengguang Xu <cgxu519@139.com>
In-Reply-To: <20210922072326.3538-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/9/22 15:23, Huang Jianan 写道:
> From: Huang Jianan <huangjianan@oppo.com>
>
> At present, overlayfs provides overlayfs inode to users. Overlayfs
> inode provides ovl_aops with noop_direct_IO to avoid open failure
> with O_DIRECT. But some compressed filesystems, such as erofs and
> squashfs, don't support direct_IO.
>
> Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
> will read file through this way. This will cause overlayfs to access
> a non-existent direct_IO function and cause panic due to null pointer:

I just looked around the code more closely, in open_with_fake_path(),

do_dentry_open() has already checked O_DIRECT open flag and 
a_ops->direct_IO of underlying real address_space.

Am I missing something?


Thanks,

Chengguang


>
> Kernel panic - not syncing: CFI failure (target: 0x0)
> CPU: 6 PID: 247 Comm: loop0
> Call Trace:
>   panic+0x188/0x45c
>   __cfi_slowpath+0x0/0x254
>   __cfi_slowpath+0x200/0x254
>   generic_file_read_iter+0x14c/0x150
>   vfs_iocb_iter_read+0xac/0x164
>   ovl_read_iter+0x13c/0x2fc
>   lo_rw_aio+0x2bc/0x458
>   loop_queue_work+0x4a4/0xbc0
>   kthread_worker_fn+0xf8/0x1d0
>   loop_kthread_worker_fn+0x24/0x38
>   kthread+0x29c/0x310
>   ret_from_fork+0x10/0x30
>
> The filesystem may only support direct_IO for some file types. For
> example, erofs supports direct_IO for uncompressed files. So return
> -EINVAL when the file doesn't support direct_IO to fix this problem.
>
> Fixes: 5b910bd615ba ("ovl: fix GPF in swapfile_activate of file from overlayfs over xfs")
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> ---
> change since v2:
>   - Return error in ovl_open directly. (Chengguang Xu)
>
> Change since v1:
>   - Return error to user rather than fall back to buffered io. (Chengguang Xu)
>
>   fs/overlayfs/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index d081faa55e83..a0c99ea35daf 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -157,6 +157,10 @@ static int ovl_open(struct inode *inode, struct file *file)
>   	if (IS_ERR(realfile))
>   		return PTR_ERR(realfile);
>   
> +	if ((f->f_flags & O_DIRECT) && (!realfile->f_mapping->a_ops ||
> +		!realfile->f_mapping->a_ops->direct_IO))
> +		return -EINVAL;
> +
>   	file->private_data = realfile;
>   
>   	return 0;

