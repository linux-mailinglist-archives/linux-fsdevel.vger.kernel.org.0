Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984F55ED9E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiI1KKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI1KKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:10:48 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFCDE0ED;
        Wed, 28 Sep 2022 03:10:45 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6297461EA1929;
        Wed, 28 Sep 2022 12:10:43 +0200 (CEST)
Subject: Re: ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        it+linux@molgen.mpg.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
 <20220531103834.vhscyk3yzsocorco@quack3.lan>
 <3bfd0ad9-d378-9631-310f-0a1a80d8e482@molgen.mpg.de>
 <YpY2o/GG8HWJHTdo@mit.edu>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <302f2af1-eee8-95aa-91f5-55fe5cf8727f@molgen.mpg.de>
Date:   Wed, 28 Sep 2022 12:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YpY2o/GG8HWJHTdo@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/31/22 5:39 PM, Theodore Ts'o wrote:
> Hmmm..... I think this patch should fix your issues.

Thanks a lot. Unfortunately, it didn't, I still occasionally get

    [368259.560885] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 344 pages, ino 279244; err -5


D.


> 
> If the journal has been aborted (which happens as part of the
> shutdown, we will never write out the commit block --- so it should be
> fine to skip the writeback of any dirty inodes in data=ordered mode.
> 
> BTW, if you know that the file system is going to get nuked in this
> way all the time, so you never care about file system after it is shut
> down, you could mount the file system with the mount option
> data=writeback.
> 
>        	      	      	    		- Ted
> 
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8ff4c6545a49..2e18211121f6 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -542,7 +542,10 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  {
>  	int ret;
> +	journal_t *journal = EXT4_SB(jinode->i_vfs_inode->i_sb)->s_journal;
>  
> +	if (!journal || is_journal_aborted(journal))
> +		return 0;
>  	if (ext4_should_journal_data(jinode->i_vfs_inode))
>  		ret = ext4_journalled_submit_inode_data_buffers(jinode);
>  	else
> @@ -554,7 +557,10 @@ static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
>  static int ext4_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
>  {
>  	int ret = 0;
> +	journal_t *journal = EXT4_SB(jinode->i_vfs_inode->i_sb)->s_journal;
>  
> +	if (!journal || is_journal_aborted(journal))
> +		return 0;
>  	if (!ext4_should_journal_data(jinode->i_vfs_inode))
>  		ret = jbd2_journal_finish_inode_data_buffers(jinode);
> 


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
