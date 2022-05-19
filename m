Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C996D52D26F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiESM1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 08:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiESM1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 08:27:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8D332;
        Thu, 19 May 2022 05:26:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B603221B17;
        Thu, 19 May 2022 12:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652963216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWAhMozh4lda3XwqJxH3kpZXIkN+fGF4wEXGmxEEOWw=;
        b=TxEb7vrsrwM50/I77QB8YeKiN7M8n8cABulTAjMa/D0tO7dae8Nm/hMjRQzO8MOA4jvKHe
        LW9rWEOobTPj53PmwiYDwTjtijDF6yu2B+CdHODXlUjS5Uow/zSj5qyzirmFyKmg74KYV1
        dNAn0xlOxTuskjs81VezC/EG/yqm7ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652963216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWAhMozh4lda3XwqJxH3kpZXIkN+fGF4wEXGmxEEOWw=;
        b=41bza39VkmZGvX1xUtaE5Af1lA3TMDkTp0+eiBy7U9aa4jdyjdQVQ9YDKWrOTecAB4TzBe
        tNudbkeF+bhOfoDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A292B2C141;
        Thu, 19 May 2022 12:26:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 30A42A062F; Thu, 19 May 2022 14:26:56 +0200 (CEST)
Date:   Thu, 19 May 2022 14:26:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, torvalds@linux-foundation.org,
        mingo@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 1/1] fs-writeback: =?utf-8?Q?writeback=5Fsb=5Finode?=
 =?utf-8?B?c++8mlJlY2FsY3VsYXRl?= 'wrote' according skipped pages
Message-ID: <20220519122656.uughxrtwl3hdnpx7@quack3.lan>
References: <20220510133805.1988292-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510133805.1988292-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-05-22 21:38:05, Zhihao Cheng wrote:
> Commit 505a666ee3fc ("writeback: plug writeback in wb_writeback() and
> writeback_inodes_wb()") has us holding a plug during wb_writeback, which
> may cause a potential ABBA dead lock:
> 
>     wb_writeback		fat_file_fsync
> blk_start_plug(&plug)
> for (;;) {
>   iter i-1: some reqs have been added into plug->mq_list  // LOCK A
>   iter i:
>     progress = __writeback_inodes_wb(wb, work)
>     . writeback_sb_inodes // fat's bdev
>     .   __writeback_single_inode
>     .   . generic_writepages
>     .   .   __block_write_full_page
>     .   .   . . 	    __generic_file_fsync
>     .   .   . . 	      sync_inode_metadata
>     .   .   . . 	        writeback_single_inode
>     .   .   . . 		  __writeback_single_inode
>     .   .   . . 		    fat_write_inode
>     .   .   . . 		      __fat_write_inode
>     .   .   . . 		        sync_dirty_buffer	// fat's bdev
>     .   .   . . 			  lock_buffer(bh)	// LOCK B
>     .   .   . . 			    submit_bh
>     .   .   . . 			      blk_mq_get_tag	// LOCK A
>     .   .   . trylock_buffer(bh)  // LOCK B
>     .   .   .   redirty_page_for_writepage
>     .   .   .     wbc->pages_skipped++
>     .   .   --wbc->nr_to_write
>     .   wrote += write_chunk - wbc.nr_to_write  // wrote > 0
>     .   requeue_inode
>     .     redirty_tail_locked
>     if (progress)    // progress > 0
>       continue;
>   iter i+1:
>       queue_io
>       // similar process with iter i, infinite for-loop !
> }
> blk_finish_plug(&plug)   // flush plug won't be called
> 
> Above process triggers a hungtask like:
> [  399.044861] INFO: task bb:2607 blocked for more than 30 seconds.
> [  399.046824]       Not tainted 5.18.0-rc1-00005-gefae4d9eb6a2-dirty
> [  399.051539] task:bb              state:D stack:    0 pid: 2607 ppid:
> 2426 flags:0x00004000
> [  399.051556] Call Trace:
> [  399.051570]  __schedule+0x480/0x1050
> [  399.051592]  schedule+0x92/0x1a0
> [  399.051602]  io_schedule+0x22/0x50
> [  399.051613]  blk_mq_get_tag+0x1d3/0x3c0
> [  399.051640]  __blk_mq_alloc_requests+0x21d/0x3f0
> [  399.051657]  blk_mq_submit_bio+0x68d/0xca0
> [  399.051674]  __submit_bio+0x1b5/0x2d0
> [  399.051708]  submit_bio_noacct+0x34e/0x720
> [  399.051718]  submit_bio+0x3b/0x150
> [  399.051725]  submit_bh_wbc+0x161/0x230
> [  399.051734]  __sync_dirty_buffer+0xd1/0x420
> [  399.051744]  sync_dirty_buffer+0x17/0x20
> [  399.051750]  __fat_write_inode+0x289/0x310
> [  399.051766]  fat_write_inode+0x2a/0xa0
> [  399.051783]  __writeback_single_inode+0x53c/0x6f0
> [  399.051795]  writeback_single_inode+0x145/0x200
> [  399.051803]  sync_inode_metadata+0x45/0x70
> [  399.051856]  __generic_file_fsync+0xa3/0x150
> [  399.051880]  fat_file_fsync+0x1d/0x80
> [  399.051895]  vfs_fsync_range+0x40/0xb0
> [  399.051929]  __x64_sys_fsync+0x18/0x30
> 
> In my test, 'need_resched()' (which is imported by 590dca3a71 "fs-writeback:
> unplug before cond_resched in writeback_sb_inodes") in function
> 'writeback_sb_inodes()' seldom comes true, unless cond_resched() is deleted
> from write_cache_pages().
> 
> Fix it by correcting wrote number according number of skipped pages
> in writeback_sb_inodes().
> 
> Goto Link to find a reproducer.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215837
> Cc: stable@vger.kernel.org # v4.3
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Indeed, subtle. The fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
