Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373653941E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 17:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbiEaPjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242627AbiEaPjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 11:39:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6CC8BD18;
        Tue, 31 May 2022 08:39:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24VFdFJH004068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654011558; bh=fTxdM4FSLoudm9qNGxkHMxJHzf43vLhFwNmW/rU7VTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KMkCQvG7tjlVWymzZpN13bzwSnBHf6sP9CXk0af4AXfcYb40gq0W3IadVs0L/CfZk
         2W4S3DE2bNZHFbaRO3Kmj9txctBWNYjtjPg2RGCvsLE0CGmjZ8f8RZdRkyAFVz3nZP
         nTFnKXlwqga67Yu6w0lk+LGYh3cVk/vD6Vdms22aJds9K0X2q64a0ONQBsgg00hwl2
         Jfr2UIk8D8Q2V494kj3hXJZlv7sTBHTc0kJeTt7WrUiO+ORAN0S+SwROLrssrtS/so
         anbbVYx6N5W0qTz+Pjwgf30dETyvvFJrIT/5lf5r6iUPvATZCJtAxkowqCZNFWr6fY
         mFjYMTQYQuXyA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36EBF15C3E1F; Tue, 31 May 2022 11:39:15 -0400 (EDT)
Date:   Tue, 31 May 2022 11:39:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        it+linux@molgen.mpg.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext4_writepages: jbd2_start: 5120 pages, ino 11; err -5
Message-ID: <YpY2o/GG8HWJHTdo@mit.edu>
References: <4e83fb26-4d4a-d482-640c-8104973b7ebf@molgen.mpg.de>
 <20220531103834.vhscyk3yzsocorco@quack3.lan>
 <3bfd0ad9-d378-9631-310f-0a1a80d8e482@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd0ad9-d378-9631-310f-0a1a80d8e482@molgen.mpg.de>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmmm..... I think this patch should fix your issues.

If the journal has been aborted (which happens as part of the
shutdown, we will never write out the commit block --- so it should be
fine to skip the writeback of any dirty inodes in data=ordered mode.

BTW, if you know that the file system is going to get nuked in this
way all the time, so you never care about file system after it is shut
down, you could mount the file system with the mount option
data=writeback.

       	      	      	    		- Ted


diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8ff4c6545a49..2e18211121f6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -542,7 +542,10 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	int ret;
+	journal_t *journal = EXT4_SB(jinode->i_vfs_inode->i_sb)->s_journal;
 
+	if (!journal || is_journal_aborted(journal))
+		return 0;
 	if (ext4_should_journal_data(jinode->i_vfs_inode))
 		ret = ext4_journalled_submit_inode_data_buffers(jinode);
 	else
@@ -554,7 +557,10 @@ static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
 static int ext4_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
 {
 	int ret = 0;
+	journal_t *journal = EXT4_SB(jinode->i_vfs_inode->i_sb)->s_journal;
 
+	if (!journal || is_journal_aborted(journal))
+		return 0;
 	if (!ext4_should_journal_data(jinode->i_vfs_inode))
 		ret = jbd2_journal_finish_inode_data_buffers(jinode);

