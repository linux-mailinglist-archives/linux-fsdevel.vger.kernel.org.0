Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16F96DDDF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDKOar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDKOab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:30:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673364C03;
        Tue, 11 Apr 2023 07:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C6CD61EE5;
        Tue, 11 Apr 2023 14:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD71C433EF;
        Tue, 11 Apr 2023 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223394;
        bh=eMsTdPtrAZCK/ZuGOrUmDsZyvC09ZW2leTic0Rb1os8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5lWRo64oTOXeUVOIQlL/OLGtPmeXzuwVpze4VWEx1YwZib2dkA1QwtwzKLWHYgK7
         7dSnojy/sazS+1QteaIol8Rn9sF6xMQm9g9P5AUKsoSI56JV/Hk+LOcnqR+UeWs4xf
         6aGxPImei6mZXxgZ14r5w47lq8VvUviuAZDvfCcMwvH9gRkwdewy2YbPnZ4LywL3CT
         LMkEhOUnruAmkKs+lh2XnfeQASuDAPnagdWkPTzi6IIDQHevjxiDjIlb+BMM3gNFmH
         LlKfeC0a6gSCY8hvjS8GiHgKStK02pxM7ygAI+IVakr4jJK0AOPI7bN2Oi8EPjSPyj
         0e9+41a3DQnEg==
Date:   Tue, 11 Apr 2023 07:29:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 1/8] ext2/dax: Fix ext2_setsize when len is page aligned
Message-ID: <20230411142954.GD360895@frogsfrogsfrogs>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <131a7e4a0e020a94c719994867484ba248316d13.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131a7e4a0e020a94c719994867484ba248316d13.1681188927.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:51:49AM +0530, Ritesh Harjani (IBM) wrote:
> PAGE_ALIGN(x) macro gives the next highest value which is multiple of
> pagesize. But if x is already page aligned then it simply returns x.
> So, if x passed is 0 in dax_zero_range() function, that means the
> length gets passed as 0 to ->iomap_begin().
> 
> In ext2 it then calls ext2_get_blocks -> max_blocks as 0 and hits bug_on
> here in ext2_get_blocks().
> 	BUG_ON(maxblocks == 0);
> 
> Instead we should be calling dax_truncate_page() here which takes
> care of it. i.e. it only calls dax_zero_range if the offset is not
> page/block aligned.
> 
> This can be easily triggered with following on fsdax mounted pmem
> device.
> 
> dd if=/dev/zero of=file count=1 bs=512
> truncate -s 0 file
> 
> [79.525838] EXT2-fs (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
> [79.529376] ext2 filesystem being mounted at /mnt1/test supports timestamps until 2038 (0x7fffffff)
> [93.793207] ------------[ cut here ]------------
> [93.795102] kernel BUG at fs/ext2/inode.c:637!
> [93.796904] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [93.798659] CPU: 0 PID: 1192 Comm: truncate Not tainted 6.3.0-rc2-xfstests-00056-g131086faa369 #139
> [93.806459] RIP: 0010:ext2_get_blocks.constprop.0+0x524/0x610
> <...>
> [93.835298] Call Trace:
> [93.836253]  <TASK>
> [93.837103]  ? lock_acquire+0xf8/0x110
> [93.838479]  ? d_lookup+0x69/0xd0
> [93.839779]  ext2_iomap_begin+0xa7/0x1c0
> [93.841154]  iomap_iter+0xc7/0x150
> [93.842425]  dax_zero_range+0x6e/0xa0
> [93.843813]  ext2_setsize+0x176/0x1b0
> [93.845164]  ext2_setattr+0x151/0x200
> [93.846467]  notify_change+0x341/0x4e0
> [93.847805]  ? lock_acquire+0xf8/0x110
> [93.849143]  ? do_truncate+0x74/0xe0
> [93.850452]  ? do_truncate+0x84/0xe0
> [93.851739]  do_truncate+0x84/0xe0
> [93.852974]  do_sys_ftruncate+0x2b4/0x2f0
> [93.854404]  do_syscall_64+0x3f/0x90
> [93.855789]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Would seem to make sense...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext2/inode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 26f135e7ffce..dc76147e7b07 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1259,9 +1259,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
>  	inode_dio_wait(inode);
>  
>  	if (IS_DAX(inode))
> -		error = dax_zero_range(inode, newsize,
> -				       PAGE_ALIGN(newsize) - newsize, NULL,
> -				       &ext2_iomap_ops);
> +		error = dax_truncate_page(inode, newsize, NULL,
> +					  &ext2_iomap_ops);
>  	else
>  		error = block_truncate_page(inode->i_mapping,
>  				newsize, ext2_get_block);
> -- 
> 2.39.2
> 
