Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54DE64E592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 02:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLPBQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 20:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLPBQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:16:35 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8AA3B9CF;
        Thu, 15 Dec 2022 17:16:33 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NYB430nwbz16Lcp;
        Fri, 16 Dec 2022 09:15:31 +0800 (CST)
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 09:16:30 +0800
Message-ID: <946950be-482c-ef9f-404c-2ce758ba175d@huawei.com>
Date:   Fri, 16 Dec 2022 09:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2 2/2] hfsplus: fix uninit-value in hfsplus_delete_cat()
To:     Viacheslav Dubeyko <slava@dubeyko.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>, <hannes@cmpxchg.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, <muchun.song@linux.dev>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
 <20221215081820.948990-3-chenxiaosong2@huawei.com>
 <6258B9FC-0A00-46BC-9C6C-720963D58A06@dubeyko.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <6258B9FC-0A00-46BC-9C6C-720963D58A06@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/12/16 3:03, Viacheslav Dubeyko 写道:
> 
> Maybe, I am missing something. But where in the second version of the patch
> initialization of subfolders?
> 

The first patch of the patchset factor out hfsplus_init_inode() from 
hfsplus_new_inode():

void hfsplus_init_inode(struct hfsplus_inode_info *hip)
{
         INIT_LIST_HEAD(&hip->open_dir_list);
         spin_lock_init(&hip->open_dir_lock);
         mutex_init(&hip->extents_lock);
         atomic_set(&hip->opencnt, 0);
         hip->extent_state = 0;
         hip->flags = 0;
         hip->userflags = 0;
         hip->subfolders = 0; /* I am here */
         memset(hip->first_extents, 0, sizeof(hfsplus_extent_rec));
         memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
         hip->alloc_blocks = 0;
         hip->first_blocks = 0;
         hip->cached_start = 0;
         hip->cached_blocks = 0;
         hip->phys_size = 0;
         hip->fs_blocks = 0;
         hip->rsrc_inode = NULL;
}
