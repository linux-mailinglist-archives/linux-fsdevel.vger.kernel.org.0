Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39C5A7E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 15:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiHaNLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiHaNLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:11:45 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4043DC1670;
        Wed, 31 Aug 2022 06:11:41 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MHkzg3p9pzHnY6;
        Wed, 31 Aug 2022 21:09:51 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 21:11:38 +0800
Subject: Re: [PATCH 02/14] fs/buffer: add some new buffer read helpers
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>, <tytso@mit.edu>,
        <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <viro@zeniv.linux.org.uk>, <rpeterso@redhat.com>,
        <agruenba@redhat.com>, <almaz.alexandrovich@paragon-software.com>,
        <mark@fasheh.com>, <dushistov@mail.ru>, <hch@infradead.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-3-yi.zhang@huawei.com>
 <20220831113029.fsywbjzk4qw24qdc@quack3>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <df2738e4-493f-0dfd-95c4-b5f763561c63@huawei.com>
Date:   Wed, 31 Aug 2022 21:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220831113029.fsywbjzk4qw24qdc@quack3>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the review and suggestions.

On 2022/8/31 19:30, Jan Kara wrote:
> On Wed 31-08-22 15:20:59, Zhang Yi wrote:
>> Current ll_rw_block() helper is fragile because it assumes that locked
>> buffer means it's under IO which is submitted by some other who hold
>> the lock, it skip buffer if it failed to get the lock, so it's only
>> safe on the readahead path. Unfortunately, now that most filesystems
>> still use this helper mistakenly on the sync metadata read path. There
>> is no guarantee that the one who hold the buffer lock always submit IO
>> (e.g. buffer_migrate_folio_norefs() after commit 88dbcbb3a484 ("blkdev:
>> avoid migration stalls for blkdev pages"), it could lead to false
>> positive -EIO when submitting reading IO.
>>
>> This patch add some friendly buffer read helpers to prepare replace
>> ll_rw_block() and similar calls. We can only call bh_readahead_[]
>> helpers for the readahead paths.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> This looks mostly good. Just a few small nits below.
> 
[..]
>> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
>> index c3863c417b00..8a01c07c0418 100644
>> --- a/include/linux/buffer_head.h
>> +++ b/include/linux/buffer_head.h
[..]
>> +static inline void bh_read_nowait(struct buffer_head *bh, blk_opf_t op_flags)
>> +{
>> +	lock_buffer(bh);
>> +	__bh_read(bh, op_flags, false);
>> +}
>> +
>> +static inline int bh_read(struct buffer_head *bh, blk_opf_t op_flags)
>> +{
>> +	lock_buffer(bh);
>> +	return __bh_read(bh, op_flags, true);
>> +}
> 
> I would use bh_uptodate_or_lock() helper in the above two functions to
> avoid locking the buffer in case it is already uptodate.
> 
Yes, it's a good point, it seems we could also remove "if (!buffer_uptodate(bh))"
before above two helpers in the latter patches, like in fs/jbd2/journal.c.

@@ -1893,15 +1893,14 @@ static int journal_get_superblock(journal_t *journal)
 {
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-	int err = -EIO;
+	int err;

 	bh = journal->j_sb_buffer;

 	J_ASSERT(bh != NULL);
- 	if (!buffer_uptodate(bh)) {
-		ll_rw_block(REQ_OP_READ, 1, &bh);
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh)) {
+	err = bh_read(bh, 0);
+	if (err) {
-			printk(KERN_ERR
-				"JBD2: IO error reading journal superblock\n");
-			goto out;
+		printk(KERN_ERR
+			"JBD2: IO error reading journal superblock\n");
+		goto out;
...

Thanks,
Yi.
