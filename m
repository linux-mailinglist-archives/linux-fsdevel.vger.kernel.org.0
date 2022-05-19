Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4797C52D1CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 13:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiESLv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 07:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiESLvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 07:51:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F85EBD9
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 04:51:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A89521B5A;
        Thu, 19 May 2022 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652961111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wxASrdK8LXAqK1DNSX+HwfJMHKxUrxlsKmWwvDfFAw=;
        b=cMOIWpZPIWo58U/IyaBRoixuZeKpBPp5Wh9Zj6IR3aFhD0GPPiEBY6fSWBhZeHRtUd+s8M
        Dn/mEkyb8yXuxhHPhlIRsp3wMjWer0JH/rC5/RclSvLEE+GO7y/2g9sQ9C8psLk89qTOMR
        6l/yZs8jZmdSPxVpC/U3mY/jlruXCMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652961111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7wxASrdK8LXAqK1DNSX+HwfJMHKxUrxlsKmWwvDfFAw=;
        b=3+qrKHS8X4FDDmfoKNdJm2CJZUgvNtGURbhMyvQJ5j19qvzJvgZhMzQ5jKFaxjuSFiis03
        MmaMVsxjhSGWtdCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 383B82C141;
        Thu, 19 May 2022 11:51:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E65E6A062F; Thu, 19 May 2022 13:51:50 +0200 (CEST)
Date:   Thu, 19 May 2022 13:51:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jchao Sun <sunjunchao2870@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz
Subject: Re: [PATCH v4] writeback: Fix inode->i_io_list not be protected by
 inode->i_lock error
Message-ID: <20220519115150.chtd3zkhti44jssh@quack3.lan>
References: <20220511141518.1895-1-sunjunchao2870@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511141518.1895-1-sunjunchao2870@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 07:15:18, Jchao Sun wrote:
> Commit b35250c0816c ("writeback: Protect inode->i_io_list with
> inode->i_lock") made inode->i_io_list not only protected by
> wb->list_lock but also inode->i_lock, but inode_io_list_move_locked()
> was missed. Add lock there and also update comment describing
> things protected by inode->i_lock.

Please expand the changelog a bit to mention to important fix in
__mark_inode_dirty(). Like:

This also fixes a race where __mark_inode_dirty() could move inode under
flush worker's hands and thus sync(2) could miss writing some inodes.

> Fixes: b35250c0816c ("writeback: Protect inode->i_io_list with inode->i_lock")
> Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>

...

> @@ -1365,9 +1366,9 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		inode = wb_inode(delaying_queue->prev);
>  		if (inode_dirtied_after(inode, dirtied_before))
>  			break;
> +		spin_lock(&inode->i_lock);
>  		list_move(&inode->i_io_list, &tmp);
>  		moved++;
> -		spin_lock(&inode->i_lock);
>  		inode->i_state |= I_SYNC_QUEUED;
>  		spin_unlock(&inode->i_lock);
>  		if (sb_is_blkdev_sb(inode->i_sb))
> @@ -1383,6 +1384,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  		goto out;
>  	}
>  
> +	spin_lock(&inode->i_lock);

This is definitely wrong. 'inode' here is just something random left over
in the variable from the previous loop. As I wrote in my previous review, I
don't think taking 'i_lock' in the loop below is needed at all, although it
probably deserves a comment like:

	/*
	 * Although inode's i_io_list is moved from 'tmp' to
	 * 'dispatch_queue', we don't take inode->i_lock here because it is
	 * just a pointless overhead. Inode is already marked as
	 * I_SYNC_QUEUED so writeback list handling is fully under our
	 * control.
	 */

>  	/* Move inodes from one superblock together */
>  	while (!list_empty(&tmp)) {
>  		sb = wb_inode(tmp.prev)->i_sb;
> @@ -1392,6 +1394,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>  				list_move(&inode->i_io_list, dispatch_queue);
>  		}
>  	}
> +	spin_unlock(&inode->i_lock);
>  out:
>  	return moved;
>  }

...

> @@ -2402,6 +2406,11 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			inode->i_state &= ~I_DIRTY_TIME;
>  		inode->i_state |= flags;
>  

Perhaps add a comment here like:

	/*
	 * Grab inode's wb early because it requires dropping i_lock and we
	 * need to make sure following checks happen atomically with dirty
	 * list handling so that we don't move inodes under flush worker's
	 * hands.
	 */

> +		if (!was_dirty) {
> +			wb = locked_inode_to_wb_and_lock_list(inode);
> +			spin_lock(&inode->i_lock);
> +		}
> +
>  		/*
>  		 * If the inode is queued for writeback by flush worker, just
>  		 * update its dirty state. Once the flush worker is done with


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
