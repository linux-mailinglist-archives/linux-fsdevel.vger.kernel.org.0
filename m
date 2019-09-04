Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4FA7E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIDIqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 04:46:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfIDIqd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:46:33 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 104D88E9AD57C4C66251;
        Wed,  4 Sep 2019 16:46:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 16:46:20 +0800
Subject: Re: [PATCH] fuse: fix memleak in cuse_channel_open
To:     <mszeredi@suse.cz>, <ashish.samant@oracle.com>,
        <mszeredi@redhat.com>, <linux-fsdevel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>
References: <1565769549-127890-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <94639cb1-8d41-4039-d72c-efc29bd20c6c@huawei.com>
Date:   Wed, 4 Sep 2019 16:46:09 +0800
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

