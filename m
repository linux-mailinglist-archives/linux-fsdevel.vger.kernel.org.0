Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36609726271
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbjFGOME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240468AbjFGOMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:12:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD9E8E
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 07:12:00 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qbq0Y1ShJz18Lvp;
        Wed,  7 Jun 2023 22:07:09 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 22:11:56 +0800
Subject: Re: [PATCH 1/4] ubifs: Convert from writepage to writepages
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Richard Weinberger <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <20230605165029.2908304-1-willy@infradead.org>
 <20230605165029.2908304-2-willy@infradead.org>
 <be9f30d1-d840-fb76-f185-5ebc70a7b72b@huawei.com>
Message-ID: <4f885387-ecaa-532c-97dc-14a2fff5c9c3@huawei.com>
Date:   Wed, 7 Jun 2023 22:11:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <be9f30d1-d840-fb76-f185-5ebc70a7b72b@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2023/6/6 22:37, Zhihao Cheng 写道:
> 在 2023/6/6 0:50, Matthew Wilcox (Oracle) 写道:
> Hi,
>> This is a simplistic conversion to separate out any effects of
>> no longer having a writepage method.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   fs/ubifs/file.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
>> index 979ab1d9d0c3..8bb4cb9d528f 100644
>> --- a/fs/ubifs/file.c
>> +++ b/fs/ubifs/file.c
>> @@ -1003,8 +1003,10 @@ static int do_writepage(struct page *page, int 
>> len)
>>    * on the page lock and it would not write the truncated inode node 
>> to the
>>    * journal before we have finished.
>>    */
>> -static int ubifs_writepage(struct page *page, struct 
>> writeback_control *wbc)
>> +static int ubifs_writepage(struct folio *folio, struct 
>> writeback_control *wbc,
>> +        void *data)
>>   {
>> +    struct page *page = &folio->page;
>>       struct inode *inode = page->mapping->host;
>>       struct ubifs_info *c = inode->i_sb->s_fs_info;
>>       struct ubifs_inode *ui = ubifs_inode(inode);
>> @@ -1076,6 +1078,12 @@ static int ubifs_writepage(struct page *page, 
>> struct writeback_control *wbc)
>>       return err;
>>   }
>> +static int ubifs_writepages(struct address_space *mapping,
>> +        struct writeback_control *wbc)
>> +{
>> +    return write_cache_pages(mapping, wbc, ubifs_writepage, NULL);
>> +}
>> +
> 
> There is a small difference.
> before patch applied:
> do_writepages -> write_cache_pages -> writepage_cb:
>   ubifs_writepage
>   mapping_set_error(mapping, ret)
> 
> So, we can get error returned from errseq_check_and_advance in syncfs 
> syscall if ubifs_writepage occurs EIO.
> 
> after patch applied:
> 
> do_writepages -> ubifs_writepages -> write_cache_pages -> 
> ubifs_writepage, mapping won't be set error if ubifs_writepage failed. 
> Unfortunately, ubifs is not a block filesystem, so 
> sync_filesystem->sync_blockdev_nowait will return 0. Finally, syncfs 
> syscall will return 0.
> 

I think we can add mapping_set_error in error branch of ubifs_writepage 
to solve it.

BTW, I notice that shrink_folio_list -> pageout will try to shrink page 
by writepage method, if we remove '->writepage', the dirty page won't be 
shrinked in that way?

> 
>>   /**
>>    * do_attr_changes - change inode attributes.
>>    * @inode: inode to change attributes for
>> @@ -1636,7 +1644,7 @@ static int ubifs_symlink_getattr(struct 
>> mnt_idmap *idmap,
>>   const struct address_space_operations ubifs_file_address_operations = {
>>       .read_folio     = ubifs_read_folio,
>> -    .writepage      = ubifs_writepage,
>> +    .writepages     = ubifs_writepages,
>>       .write_begin    = ubifs_write_begin,
>>       .write_end      = ubifs_write_end,
>>       .invalidate_folio = ubifs_invalidate_folio,
>>
> 
> 
> .

