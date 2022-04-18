Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C670505A30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 16:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbiDROms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbiDROmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:42:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC81122;
        Mon, 18 Apr 2022 06:27:12 -0700 (PDT)
Received: from kwepemi500003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Khnl82BBYz1GCPs;
        Mon, 18 Apr 2022 21:26:28 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500003.china.huawei.com (7.221.188.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 21:27:10 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 21:27:09 +0800
Subject: Re: [PATCH v2] fs-writeback: writeback_sb_inodes: Recalculate 'wrote'
 according skipped pages
To:     Hillf Danton <hdanton@sina.com>
CC:     <hch@lst.de>, <torvalds@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>
References: <20220418112745.1761-1-hdanton@sina.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <4df77267-09f0-c4be-116e-86e447cbd292@huawei.com>
Date:   Mon, 18 Apr 2022 21:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220418112745.1761-1-hdanton@sina.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

HI Hillf,
> On Mon, 18 Apr 2022 17:28:24 +0800 Zhihao Cheng wrote:
>> Commit 505a666ee3fc ("writeback: plug writeback in wb_writeback() and
>> writeback_inodes_wb()") has us holding a plug during wb_writeback, which
>> may cause a potential ABBA dead lock:
>>
>>      wb_writeback		fat_file_fsync
>> blk_start_plug(&plug)
>> for (;;) {
>>    iter i-1: some reqs have been added into plug->mq_list  // LOCK A
>>    iter i:
>>      progress = __writeback_inodes_wb(wb, work)
>>      . writeback_sb_inodes // fat's bdev
See comments " fat's bdev".
> 
> 	if (inode->i_state & I_SYNC) {
> 		/* Wait for I_SYNC. This function drops i_lock... */
> 		inode_sleep_on_writeback(inode);
> 		/* Inode may be gone, start again */
> 		spin_lock(&wb->list_lock);
> 		continue;
> 	}
> 	inode->i_state |= I_SYNC;
This inode is fat's bdev's inode.
> 
>>      .   __writeback_single_inode
>>      .   . generic_writepages
>>      .   .   __block_write_full_page
>>      .   .   . . 	    __generic_file_fsync
>>      .   .   . . 	      sync_inode_metadata
>>      .   .   . . 	        writeback_single_inode
> 
> 				if (inode->i_state & I_SYNC) {
This inode is fat's inode.
> 					/*
> 					 * Writeback is already running on the inode.  For WB_SYNC_NONE,
> 					 * that's enough and we can just return.  For WB_SYNC_ALL, we
> 					 * must wait for the existing writeback to complete, then do
> 					 * writeback again if there's anything left.
> 					 */
> 					if (wbc->sync_mode != WB_SYNC_ALL)
> 						goto out;
> 					__inode_wait_for_writeback(inode);
> 				}
> 				inode->i_state |= I_SYNC;
> 
>>      .   .   . . 		  __writeback_single_inode
>>      .   .   . . 		    fat_write_inode
>>      .   .   . . 		      __fat_write_inode
>>      .   .   . . 		        sync_dirty_buffer	// fat's bdev
>>      .   .   . . 			  lock_buffer(bh)	// LOCK B
>>      .   .   . . 			    submit_bh
>>      .   .   . . 			      blk_mq_get_tag	// LOCK A
>>      .   .   . trylock_buffer(bh)  // LOCK B
> 
> Given I_SYNC checked on both sides, the chance for ABBA deadlock is zero.
Above two inodes are not same.
