Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B32C6D4E26
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDCQkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjDCQkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0A2211F;
        Mon,  3 Apr 2023 09:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A06621CB;
        Mon,  3 Apr 2023 16:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827FFC433D2;
        Mon,  3 Apr 2023 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680540011;
        bh=PhfDjVsfEzQnquigIw7DJA/C7W3AgNpsJY9zKrGFtjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLD99EshgZbD5KHBxOFY0mfvOJPbzPXn4q5hgRKUMbXs9mcjEirthBon8JHyhoVPm
         ai3JjXubsOX5EFagV8KJwwBeTbk+zBRQi1DY6o444D95LbHmbMl8S1dL97PACfy1+1
         EhztcX0lbXZvFCF1esnQX+WihdQIotmae4B7RfP9E2kPaF6uuV3SXEfoiydEkAZPM/
         MOVNxlq8soPYu4tjjogs6wctabO13jZw7Qw4aT/BjNKhNRyFlhWUBaqTZ4HGZiMZ0B
         bovrio8iEEMxD456XQPw+l/jl1apHQRnsn1FxIqMsQzIBnbYlbzNxO9GhHvF/2S19F
         rjTU891J8j/eg==
Date:   Mon, 3 Apr 2023 18:40:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/buffer: Remove redundant assignment to err
Message-ID: <20230403-oxymoron-unease-ca8a023e45c7@brauner>
References: <20230323023259.6924-1-jiapeng.chong@linux.alibaba.com>
 <20230403161043.tecfvgmhacs4j3qp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230403161043.tecfvgmhacs4j3qp@quack3>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 03, 2023 at 06:10:43PM +0200, Jan Kara wrote:
> On Thu 23-03-23 10:32:59, Jiapeng Chong wrote:
> > Variable 'err' set but not used.
> > 
> > fs/buffer.c:2613:2: warning: Value stored to 'err' is never read.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4589
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> I don't think the patch is quite correct (Christian, please drop it if I'm
> correct). See below:

Thank you for taking a look at this!

> 
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index d759b105c1e7..b3eb905f87d6 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2580,7 +2580,7 @@ int block_truncate_page(struct address_space *mapping,
> >  	struct inode *inode = mapping->host;
> >  	struct page *page;
> >  	struct buffer_head *bh;
> > -	int err;
> > +	int err = 0;
> >  
> >  	blocksize = i_blocksize(inode);
> >  	length = offset & (blocksize - 1);
> > @@ -2593,9 +2593,8 @@ int block_truncate_page(struct address_space *mapping,
> >  	iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
> >  	
> >  	page = grab_cache_page(mapping, index);
> > -	err = -ENOMEM;
> >  	if (!page)
> > -		goto out;
> > +		return -ENOMEM;
> >  
> >  	if (!page_has_buffers(page))
> >  		create_empty_buffers(page, blocksize, 0);
> > @@ -2609,7 +2608,6 @@ int block_truncate_page(struct address_space *mapping,
> >  		pos += blocksize;
> >  	}
> >  
> > -	err = 0;
> >  	if (!buffer_mapped(bh)) {
> >  		WARN_ON(bh->b_size != blocksize);
> >  		err = get_block(inode, iblock, bh, 0);
> > @@ -2633,12 +2631,11 @@ int block_truncate_page(struct address_space *mapping,
> >  
> >  	zero_user(page, offset, length);
> >  	mark_buffer_dirty(bh);
> > -	err = 0;
> 
> There is:
> 
>         if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh))
>                 err = -EIO;
> 
> above this assignment. So now we'll be returning -EIO if
> block_truncate_page() needs to read the block AFAICT. Did this pass fstests
> with some filesystem exercising this code (ext2 driver comes to mind)?

Hm, the code in current mainline is:

        if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
                err = bh_read(bh, 0);
                /* Uhhuh. Read error. Complain and punt. */
                if (err < 0)
                        goto unlock;
        }

Before e7ea1129afab ("fs/buffer: replace ll_rw_block()") that code really was

        if (!buffer_uptodate(bh) && !buffer_delay(bh) && !buffer_unwritten(bh)) {
                err = -EIO;
                ll_rw_block(REQ_OP_READ, 1, &bh);
                wait_on_buffer(bh);
                /* Uhhuh. Read error. Complain and punt. */
                if (!buffer_uptodate(bh))
                        goto unlock;
        }

which would've indeed caused this change to return -EIO.
Is this still an issue now? Sorry if I'm being dense here. 
