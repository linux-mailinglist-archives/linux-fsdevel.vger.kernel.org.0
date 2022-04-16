Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B850354D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 10:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiDPIoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Apr 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiDPIoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:44:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600B9D0C0;
        Sat, 16 Apr 2022 01:41:39 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgRSY6TfbzFpkC;
        Sat, 16 Apr 2022 16:39:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 16:41:37 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 16:41:36 +0800
Subject: Re: [PATCH] fs-writeback: Flush plug before next iteration in
 wb_writeback()
To:     Christoph Hellwig <hch@lst.de>
CC:     <viro@zeniv.linux.org.uk>, <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20220415013735.1610091-1-chengzhihao1@huawei.com>
 <20220415063920.GB24262@lst.de>
 <cf500f73-6c89-0d48-c658-4185fbf54b2c@huawei.com>
 <20220416054214.GA7386@lst.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <71acc295-3a5b-176d-a58e-2aa3ba7627d6@huawei.com>
Date:   Sat, 16 Apr 2022 16:41:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220416054214.GA7386@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2022/4/16 13:42, Christoph Hellwig Ð´µÀ:
>> I think the root cause is fsync gets buffer head's lock without locking
>> corresponding page, fixing 'progess' and flushing plug are both
>> workarounds.
> 
> So let's fix that.
> 

I think adding page lock before locking buffer head is a little 
difficult and risky:
1. There are too many places getting buffer head before submitting bio, 
and not all filesystems behave same in readpage/writepage/write_inode. 
For example, ntfs_read_block() has locked page before locking buffer 
head and then submitting bh, ext4(no journal) and fat may lock buffer 
head without locking page while writing inode. It's a huge work to check 
all places.
2. Import page lock before locking buffer head may bring new unknown 
problem(other deadlocks about page ?). Taking page lock before locking 
buffer head(in all processes which can be concurrent with wb_writeback) 
is a dangerous thing.

So, how about applying the safe and simple method(flush plug) for the 
time being?
PS: Maybe someday buffer head is removed from all filesystems, then we 
can remove this superfluous blk_flush_plug.
