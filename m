Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B35AA7D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 08:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiIBGKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 02:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiIBGKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:10:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DCF1208C;
        Thu,  1 Sep 2022 23:10:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJnXc3GHmzl0wj;
        Fri,  2 Sep 2022 14:08:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD3SXM2nhFjYkwIAQ--.59249S3;
        Fri, 02 Sep 2022 14:09:59 +0800 (CST)
Subject: Re: [PATCH] fs: fix possible inconsistent mount device
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220813060848.1457301-1-yukuai1@huaweicloud.com>
 <YvdJMj5hNem2PMVh@infradead.org>
 <230cf303-b241-957d-f5aa-5d367eddeb3f@huaweicloud.com>
 <YvdPlDPX82NsC6/d@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <79effa0e-7ffe-4275-cf36-01fd3d0615b9@huaweicloud.com>
Date:   Fri, 2 Sep 2022 14:09:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YvdPlDPX82NsC6/d@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD3SXM2nhFjYkwIAQ--.59249S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw17JryUZrykCry5GF1UGFg_yoW3ArXE9a
        yfJ39rJ3ZrGF1F9w42kFsrtas7Jry7Zr1UAa1fXrZ7Was5ZrZ5uFWqk3yfZr4Syr98ur1Y
        9r4vqrZFqFZ3ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Christoph!

ÔÚ 2022/08/13 15:15, Christoph Hellwig Ð´µÀ:
> On Sat, Aug 13, 2022 at 03:09:58PM +0800, Yu Kuai wrote:
>> Thanks for your reply. Do you think it's better to remove the rename
>> support from dm? Or it's better to add such limit?
> 
> It will probably be hard to entirely remove it.  But documentation
> and a rate limited warning discouraging it seems like a good idea.
> .
> 

I just found that not just rename, mount concurrent with device
remove/create can trigger this problem as well:

t1:                       t2
// create dm-0 with name test1
// mount /dev/mapper/test1
mount_bdev
  blkdev_get_by_path
   lookup_bdev
                           // remove dm-0
                           // create dm-0 with different name test2
   blkdev_get_by_dev
   // succeed

Do you think it's ok to add such checking to prevent this problem?

Thanks,
Kuai

