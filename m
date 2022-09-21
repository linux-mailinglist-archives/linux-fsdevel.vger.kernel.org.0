Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18535BFF07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIUNhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiIUNhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:37:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997817285C;
        Wed, 21 Sep 2022 06:37:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4BAF321A0F;
        Wed, 21 Sep 2022 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663767436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ylSKvd0aYxKEDLTkKv0Q1hmaMWKUMWHX4BYfXBmAW4=;
        b=t5ICRRPW2WPstvfbXz8mvH/FyMnoYTudZqv2jCgW8JV6iEmQK5oapD4aUKNw7D0zrK3kKZ
        uc/nkpJGVWasO3Ta/hep8V6CC4jfYE2/AG0IAasaZCZE/m+jOBqhvMbnzO8tRvJe0DAbVF
        rTb61XIyrWbgyWlUqyL7+woH14UdXXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663767436;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ylSKvd0aYxKEDLTkKv0Q1hmaMWKUMWHX4BYfXBmAW4=;
        b=B6hH3EpXwyYL87Uq4xZjGNoLA4KhoaHFggxjIYWK9rIu6hKtOEt6liUjXx4P3byiqqxhEp
        2C8tFD9F/VJVUXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B30813A00;
        Wed, 21 Sep 2022 13:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wTtrDowTK2OpQAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Sep 2022 13:37:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BCAF9A0684; Wed, 21 Sep 2022 15:37:15 +0200 (CEST)
Date:   Wed, 21 Sep 2022 15:37:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     jack@suse.com, tytso@mit.edu, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH 1/3] quota: Check next/prev free block number after
 reading from quota file
Message-ID: <20220921133715.7tesk3qylombwmyk@quack3>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
 <20220820110514.881373-2-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820110514.881373-2-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 20-08-22 19:05:12, Zhihao Cheng wrote:
> Following process:
>  Init: v2_read_file_info: <3> dqi_free_blk 0 dqi_free_entry 5 dqi_blks 6
> 
>  Step 1. chown bin f_a -> dquot_acquire -> v2_write_dquot:
>   qtree_write_dquot
>    do_insert_tree
>     find_free_dqentry
>      get_free_dqblk
>       write_blk(info->dqi_blocks) // info->dqi_blocks = 6, failure. The
> 	   content in physical block (corresponding to blk 6) is random.
> 
>  Step 2. chown root f_a -> dquot_transfer -> dqput_all -> dqput ->
>          ext4_release_dquot -> v2_release_dquot -> qtree_delete_dquot:
>   dquot_release
>    remove_tree
>     free_dqentry
>      put_free_dqblk(6)
>       info->dqi_free_blk = blk    // info->dqi_free_blk = 6
> 
>  Step 3. drop cache (buffer head for block 6 is released)
> 
>  Step 4. chown bin f_b -> dquot_acquire -> commit_dqblk -> v2_write_dquot:
>   qtree_write_dquot
>    do_insert_tree
>     find_free_dqentry
>      get_free_dqblk
>       dh = (struct qt_disk_dqdbheader *)buf
>       blk = info->dqi_free_blk     // 6
>       ret = read_blk(info, blk, buf)  // The content of buf is random
>       info->dqi_free_blk = le32_to_cpu(dh->dqdh_next_free)  // random blk
> 
>  Step 5. chown bin f_c -> notify_change -> ext4_setattr -> dquot_transfer:
>   dquot = dqget -> acquire_dquot -> ext4_acquire_dquot -> dquot_acquire ->
>           commit_dqblk -> v2_write_dquot -> dq_insert_tree:
>    do_insert_tree
>     find_free_dqentry
>      get_free_dqblk
>       blk = info->dqi_free_blk    // If blk < 0 and blk is not an error
> 				     code, it will be returned as dquot
> 
>   transfer_to[USRQUOTA] = dquot  // A random negative value
>   __dquot_transfer(transfer_to)
>    dquot_add_inodes(transfer_to[cnt])
>     spin_lock(&dquot->dq_dqb_lock)  // page fault
> 
> , which will lead to kernel page fault:
>  Quota error (device sda): qtree_write_dquot: Error -8000 occurred
>  while creating quota
>  BUG: unable to handle page fault for address: ffffffffffffe120
>  #PF: supervisor write access in kernel mode
>  #PF: error_code(0x0002) - not-present page
>  Oops: 0002 [#1] PREEMPT SMP
>  CPU: 0 PID: 5974 Comm: chown Not tainted 6.0.0-rc1-00004
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:_raw_spin_lock+0x3a/0x90
>  Call Trace:
>   dquot_add_inodes+0x28/0x270
>   __dquot_transfer+0x377/0x840
>   dquot_transfer+0xde/0x540
>   ext4_setattr+0x405/0x14d0
>   notify_change+0x68e/0x9f0
>   chown_common+0x300/0x430
>   __x64_sys_fchownat+0x29/0x40
> 
> In order to avoid accessing invalid quota memory address, this patch adds
> block number checking of next/prev free block read from quota file.
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216372
> Fixes: 1da177e4c3f4152 ("Linux-2.6.12-rc2")

It's better to just have:

CC: stable@vger.kernel.org

here. Fixes tag pointing to kernel release is not very useful.

> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -71,6 +71,35 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>  	return ret;
>  }
>  
> +static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
> +{
> +	if (val >= max_val) {
> +		quota_error(sb, "Getting block too big (%u >= %u)",
> +			    val, max_val);
> +		return -EUCLEAN;
> +	}
> +
> +	return 0;
> +}

I'd already provide min_val and the string for the message here as well (as
you do in patch 2). It is less churn in the next patch and free blocks
checking actually needs that as well. See below.

> +
> +static int check_free_block(struct qtree_mem_dqinfo *info,
> +			    struct qt_disk_dqdbheader *dh)
> +{
> +	int err = 0;
> +	uint nextblk, prevblk;
> +
> +	nextblk = le32_to_cpu(dh->dqdh_next_free);
> +	err = do_check_range(info->dqi_sb, nextblk, info->dqi_blocks);
> +	if (err)
> +		return err;
> +	prevblk = le32_to_cpu(dh->dqdh_prev_free);
> +	err = do_check_range(info->dqi_sb, prevblk, info->dqi_blocks);
> +	if (err)
> +		return err;

The free block should actually be > QT_TREEOFF so I'd add the check to
do_check_range().

Also rather than having check_free_block(), I'd provide a helper function
like check_dquot_block_header() which will check only free blocks pointers
now and in later patches you can add other checks there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
