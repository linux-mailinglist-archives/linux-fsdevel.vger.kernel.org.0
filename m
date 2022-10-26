Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3B60DE36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 11:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiJZJgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiJZJgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:36:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15135B878A;
        Wed, 26 Oct 2022 02:36:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 741221F74A;
        Wed, 26 Oct 2022 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666777001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1v99YWH0XHMcdrpQFu88sFLBNQNqILQuj4bw48skxM=;
        b=j+9ymoZZlt/s0pA+aMmfJyty8OruhFPMRIfEL7TaQgCZV5IjWMxsVoOsa9DQuzVJwC1nFN
        R18ENIJrgNqRxtZTVWCL5ijwF1xeTOLN9Abr24aFye9FXmxuFnXJ8Ru0k62/Dr6ydsnnPG
        StWXDHicodoy5gsI5i+tbwjbsx1mAjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666777001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f1v99YWH0XHMcdrpQFu88sFLBNQNqILQuj4bw48skxM=;
        b=MF7czuHE+5lEqaPI8uwVHyvN7jZ2o361BVi8Njib9xDh6fBNsZ+0N47knx9Rdj5TydmTpT
        Ja0QGOKG1ms2MoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6736A13A6E;
        Wed, 26 Oct 2022 09:36:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u1QpGan/WGOCZQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 26 Oct 2022 09:36:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 028D5A06F9; Wed, 26 Oct 2022 11:36:40 +0200 (CEST)
Date:   Wed, 26 Oct 2022 11:36:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ext4: fix bug_on in __es_tree_search caused by
 bad quota inode
Message-ID: <20221026093640.ahtn235wdy3f4wte@quack3>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
 <20221026042310.3839669-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026042310.3839669-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-10-22 12:23:07, Baokun Li wrote:
> We got a issue as fllows:
> ==================================================================
>  kernel BUG at fs/ext4/extents_status.c:202!
>  invalid opcode: 0000 [#1] PREEMPT SMP
>  CPU: 1 PID: 810 Comm: mount Not tainted 6.1.0-rc1-next-g9631525255e3 #352
>  RIP: 0010:__es_tree_search.isra.0+0xb8/0xe0
>  RSP: 0018:ffffc90001227900 EFLAGS: 00010202
>  RAX: 0000000000000000 RBX: 0000000077512a0f RCX: 0000000000000000
>  RDX: 0000000000000002 RSI: 0000000000002a10 RDI: ffff8881004cd0c8
>  RBP: ffff888177512ac8 R08: 47ffffffffffffff R09: 0000000000000001
>  R10: 0000000000000001 R11: 00000000000679af R12: 0000000000002a10
>  R13: ffff888177512d88 R14: 0000000077512a10 R15: 0000000000000000
>  FS: 00007f4bd76dbc40(0000)GS:ffff88842fd00000(0000)knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005653bf993cf8 CR3: 000000017bfdf000 CR4: 00000000000006e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ext4_es_cache_extent+0xe2/0x210
>   ext4_cache_extents+0xd2/0x110
>   ext4_find_extent+0x5d5/0x8c0
>   ext4_ext_map_blocks+0x9c/0x1d30
>   ext4_map_blocks+0x431/0xa50
>   ext4_getblk+0x82/0x340
>   ext4_bread+0x14/0x110
>   ext4_quota_read+0xf0/0x180
>   v2_read_header+0x24/0x90
>   v2_check_quota_file+0x2f/0xa0
>   dquot_load_quota_sb+0x26c/0x760
>   dquot_load_quota_inode+0xa5/0x190
>   ext4_enable_quotas+0x14c/0x300
>   __ext4_fill_super+0x31cc/0x32c0
>   ext4_fill_super+0x115/0x2d0
>   get_tree_bdev+0x1d2/0x360
>   ext4_get_tree+0x19/0x30
>   vfs_get_tree+0x26/0xe0
>   path_mount+0x81d/0xfc0
>   do_mount+0x8d/0xc0
>   __x64_sys_mount+0xc0/0x160
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
> ==================================================================
> 
> Above issue may happen as follows:
> -------------------------------------
> ext4_fill_super
>  ext4_orphan_cleanup
>   ext4_enable_quotas
>    ext4_quota_enable
>     ext4_iget --> get error inode <5>
>      ext4_ext_check_inode --> Wrong imode makes it escape inspection
>      make_bad_inode(inode) --> EXT4_BOOT_LOADER_INO set imode
>     dquot_load_quota_inode
>      vfs_setup_quota_inode --> check pass
>      dquot_load_quota_sb
>       v2_check_quota_file
>        v2_read_header
>         ext4_quota_read
>          ext4_bread
>           ext4_getblk
>            ext4_map_blocks
>             ext4_ext_map_blocks
>              ext4_find_extent
>               ext4_cache_extents
>                ext4_es_cache_extent
>                 __es_tree_search.isra.0
>                  ext4_es_end --> Wrong extents trigger BUG_ON
> 
> In the above issue, s_usr_quota_inum is set to 5, but inode<5> contains
> incorrect imode and disordered extents. Because 5 is EXT4_BOOT_LOADER_INO,
> the ext4_ext_check_inode check in the ext4_iget function can be bypassed,
> finally, the extents that are not checked trigger the BUG_ON in the
> __es_tree_search function. To solve this issue, check whether the inode is
> bad_inode in vfs_setup_quota_inode().
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/quota/dquot.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 0427b44bfee5..f27faf5db554 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2324,6 +2324,8 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
>  	struct super_block *sb = inode->i_sb;
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  
> +	if (is_bad_inode(inode))
> +		return -EUCLEAN;
>  	if (!S_ISREG(inode->i_mode))
>  		return -EACCES;
>  	if (IS_RDONLY(inode))
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
