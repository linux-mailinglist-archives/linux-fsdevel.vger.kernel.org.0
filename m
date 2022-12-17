Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AF64F6FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 03:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLQCUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 21:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiLQCUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:20:45 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4D2DEE;
        Fri, 16 Dec 2022 18:20:42 -0800 (PST)
Received: from kwepemm600015.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NYqRX0pdvzRq6D;
        Sat, 17 Dec 2022 10:19:36 +0800 (CST)
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 10:20:40 +0800
Message-ID: <ec9d07ba-431f-55eb-f3a8-b92f15193548@huawei.com>
Date:   Sat, 17 Dec 2022 10:20:39 +0800
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
 <946950be-482c-ef9f-404c-2ce758ba175d@huawei.com>
 <6B5CECB6-C620-479A-A8EC-817CCCD9ECBB@dubeyko.com>
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
In-Reply-To: <6B5CECB6-C620-479A-A8EC-817CCCD9ECBB@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

在 2022/12/17 2:09, Viacheslav Dubeyko 写道>
> So, where is here hip->subfolders = 0; /* I am here */? Sorry, maybe I missed some email.
> 

1/2 patch do not show more detail about 'hip->subfolders ', you can 
apply the patchset to baseline and use '--unified' option to 'git show' 
more detail:

```shell
git am '1/2 of the patchset' # to baseline
git show 'commit of 1/2 patch' --unified=16 # specify 16 lines of 
context instead of the default 3 lines
```

then you can see more detail as follows:

```shell
...
-struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
-                               umode_t mode)
+void hfsplus_init_inode(struct hfsplus_inode_info *hip)
  {
-       struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
-       struct inode *inode = new_inode(sb);
-       struct hfsplus_inode_info *hip;
-
-       if (!inode)
-               return NULL;
-
-       inode->i_ino = sbi->next_cnid++;
-       inode_init_owner(&init_user_ns, inode, dir, mode);
-       set_nlink(inode, 1);
-       inode->i_mtime = inode->i_atime = inode->i_ctime = 
current_time(inode);
-
-       hip = HFSPLUS_I(inode);
         INIT_LIST_HEAD(&hip->open_dir_list);
         spin_lock_init(&hip->open_dir_lock);
         mutex_init(&hip->extents_lock);
         atomic_set(&hip->opencnt, 0);
         hip->extent_state = 0;
         hip->flags = 0;
         hip->userflags = 0;
         hip->subfolders = 0; /********* I am here *****************/
         memset(hip->first_extents, 0, sizeof(hfsplus_extent_rec));
         memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
         hip->alloc_blocks = 0;
         hip->first_blocks = 0;
         hip->cached_start = 0;
         hip->cached_blocks = 0;
         hip->phys_size = 0;
         hip->fs_blocks = 0;
         hip->rsrc_inode = NULL;
+}
+
+struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
+                               umode_t mode)
+{
+       struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+       struct inode *inode = new_inode(sb);
+       struct hfsplus_inode_info *hip;
+
+       if (!inode)
+               return NULL;
+
+       inode->i_ino = sbi->next_cnid++;
+       inode_init_owner(&init_user_ns, inode, dir, mode);
+       set_nlink(inode, 1);
+       inode->i_mtime = inode->i_atime = inode->i_ctime = 
current_time(inode);
+
+       hip = HFSPLUS_I(inode);
+       hfsplus_init_inode(hip);
         if (S_ISDIR(inode->i_mode)) {
                 inode->i_size = 2;
                 sbi->folder_count++;
                 inode->i_op = &hfsplus_dir_inode_operations;
...
```
