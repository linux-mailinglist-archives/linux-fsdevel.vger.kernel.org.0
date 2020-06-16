Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D52C1FAF0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgFPLYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 07:24:20 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgFPLYU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:24:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B0195D2BEC9DA731698C;
        Tue, 16 Jun 2020 19:24:16 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 19:24:07 +0800
Subject: Re: [PATCH v6] block: Fix use-after-free in blkdev_get()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Hulk Robot <hulkci@huawei.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20200616034002.2473743-1-yanaijie@huawei.com>
 <20200616102048.GL4282@kadam>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <3d0d8b5e-2adc-dc53-0bd2-7e28a58931f8@huawei.com>
Date:   Tue, 16 Jun 2020 19:24:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200616102048.GL4282@kadam>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan£¬

ÔÚ 2020/6/16 18:20, Dan Carpenter Ð´µÀ:
> On Tue, Jun 16, 2020 at 11:40:02AM +0800, Jason Yan wrote:
>>
>> Fixes: e525fd89d380 ("block: make blkdev_get/put() handle exclusive access")
> 
> I still don't understand how this is the correct fixes tag...  :/
> 
> git show e525fd89d380:fs/block_dev.c | cat -n
>    1208  int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
>    1209  {
>    1210          struct block_device *whole = NULL;
>    1211          int res;
>    1212
>    1213          WARN_ON_ONCE((mode & FMODE_EXCL) && !holder);
>    1214
>    1215          if ((mode & FMODE_EXCL) && holder) {
>    1216                  whole = bd_start_claiming(bdev, holder);
>    1217                  if (IS_ERR(whole)) {
>    1218                          bdput(bdev);
>    1219                          return PTR_ERR(whole);
>    1220                  }
>    1221          }
>    1222
>    1223          res = __blkdev_get(bdev, mode, 0);
>    1224
>    1225          if (whole) {
>    1226                  if (res == 0)
>                              ^^^^^^^^
> 
>    1227                          bd_finish_claiming(bdev, whole, holder);
>    1228                  else
>    1229                          bd_abort_claiming(whole, holder);
>                                                    ^^^^^^^^^^^^^
> If __blkdev_get() then this doesn't dereference "bdev" so it's not a
> use after free bug.
> 
>    1230          }
>    1231
>    1232          return res;
>    1233  }
> 
> So far as I can see the Fixes tag should be what I said earlier.
> 
> Fixes: 89e524c04fa9 ("loop: Fix mount(2) failure due to race with LOOP_SET_FD")
> 

I tried kernel before this commit and can still reproduce this issue.

After some digging, at last I found this one:
77ea887e433a "implement in-kernel gendisk events handling"

@@ -1158,9 +1159,10 @@ int blkdev_get(struct block_device *bdev, fmode_t 
mode, void *holder)

         if (whole) {
                 /* finish claiming */
+               mutex_lock(&bdev->bd_mutex);
                 spin_lock(&bdev_lock);

-               if (res == 0) {
+               if (!res) {
                         BUG_ON(!bd_may_claim(bdev, whole, holder));
                         /*
                          * Note that for a whole device bd_holders


This commit added accessing bdev->bd_mutex before checking res, which 
will cause use-after-free. So I think the fixes tag should be:

Fixes: 77ea887e433a ("implement in-kernel gendisk events handling")

> Otherwise the patch looks good to me.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
> .
> 

