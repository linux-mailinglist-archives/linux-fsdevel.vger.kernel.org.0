Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B8BADC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 08:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393080AbfIWG0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 02:26:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWG0p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:26:45 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5298B51A67B9CB383767;
        Mon, 23 Sep 2019 14:26:43 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 14:26:40 +0800
Subject: Re: [PATCH] fuse: fix memleak in cuse_channel_open
To:     <mszeredi@redhat.com>, <ashish.samant@oracle.com>,
        <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>
References: <1565769549-127890-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <ac291692-c851-1c39-8ce3-cbf91327e8a4@huawei.com>
Date:   Mon, 23 Sep 2019 14:26:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1565769549-127890-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping

On 2019/8/14 15:59, zhengbin wrote:
> If cuse_send_init fails, need to fuse_conn_put cc->fc.
>
> cuse_channel_open->fuse_conn_init->refcount_set(&fc->count, 1)
>                  ->fuse_dev_alloc->fuse_conn_get
>                  ->fuse_dev_free->fuse_conn_put
>
> Fixes: cc080e9e9be1 ("fuse: introduce per-instance fuse_dev structure")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/fuse/cuse.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index bab7a0d..f3b7208 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -519,6 +519,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
>  	rc = cuse_send_init(cc);
>  	if (rc) {
>  		fuse_dev_free(fud);
> +		fuse_conn_put(&cc->fc);
>  		return rc;
>  	}
>  	file->private_data = fud;
> --
> 2.7.4
>
>
> .
>

