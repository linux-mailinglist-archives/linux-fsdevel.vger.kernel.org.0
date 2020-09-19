Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F447270EB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgISO4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgISO4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 10:56:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02892C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2020 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=muCeaXErgBPq8JfjyaQkOcFShJLp/WM6/g6JcY9o8j0=; b=sofiqr02xsgoK7+f69IYgl5cad
        0t74mGnWlGxwc2JLzb1ylB75lhOrHQ0Jqj0yZ01xM5QpCZZ9RQnvXy3XEPuizBuD6hoMDEAxy0mEF
        IVPSfoEh1rmyMxtM4EwzeabDiQnr8dcxs2ZrtVJ2/DCsUA7a+MGPq4tHUCI3cP3IvXX7M9lQo/3nH
        vQDMM0BQc4qjLv0MgJV3I+4OeXdUVu7/buw8tR1rQ+orSWLKZAETxPpcUj1fZwaziycOSGcR3zryi
        CC2PNUGO8yjdw2tGr2Ow+xuHgLI/SBcoJgE3mLsTTRlLeT1Fi7kB8/qA8oo8TYKTN0ePexI3PXlBe
        4CxvYlIA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJeHw-0007Eq-Kq; Sat, 19 Sep 2020 14:56:32 +0000
Date:   Sat, 19 Sep 2020 15:56:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        lihaotian9@huawei.com, lutianxiong@huawei.com, jack@suse.cz,
        linfeilong@huawei.com
Subject: Re: [PATCH RESEND] fs: fix race condition oops between destroy_inode
 and writeback_sb_inodes
Message-ID: <20200919145632.GM32101@casper.infradead.org>
References: <20200919093923.19016-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919093923.19016-1-luoshijie1@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 19, 2020 at 05:39:23AM -0400, Shijie Luo wrote:
> There is a race condition between destroy_inode and writeback_sb_inodes,
> thread-1                                    thread-2
> wb_workfn
>   writeback_inodes_wb
>     __writeback_inodes_wb
>       writeback_sb_inodes
>         wbc_attach_and_unlock_inode
> 					iget_locked
>                                           destroy_inode
>                                             inode_detach_wb
>                                               inode->i_wb = NULL;
> 
>         inode_to_wb_and_lock_list
>           locked_inode_to_wb_and_lock_list
>             wb_get
>               oops
> 
> so destroy inode after adding I_FREEING to inode state and the I_SYNC state
>  being cleared.
> 
> Reported-by: Tianxiong Lu <lutianxiong@huawei.com>
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
> ---
>  fs/inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 72c4c347afb7..b28a2a9e15d5 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1148,10 +1148,17 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  		struct inode *new = alloc_inode(sb);
>  
>  		if (new) {
> +			spin_lock(&new->i_lock);
>  			new->i_state = 0;
> +			spin_unlock(&new->i_lock);

This part is unnecessary.  We just allocated 'new' two lines above;
nobody else can see 'new' yet.  We make it visible with hlist_add_head_rcu()
which uses rcu_assign_pointer() whch contains a memory barrier, so it's
impossible for another CPU to see a stale i_state.

>  			inode = inode_insert5(new, hashval, test, set, data);
> -			if (unlikely(inode != new))
> +			if (unlikely(inode != new)) {
> +				spin_lock(&new->i_lock);
> +				new->i_state |= I_FREEING;
> +				spin_unlock(&new->i_lock);
> +				inode_wait_for_writeback(new);
>  				destroy_inode(new);

This doesn't make sense either.  If an inode is returned here which is not
'new', then adding 'new' to the hash failed, and new was never visible
to another CPU.

> @@ -1218,6 +1225,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
>  		 * allocated.
>  		 */
>  		spin_unlock(&inode_hash_lock);
> +
> +		spin_lock(&inode->i_lock);
> +		inode->i_state |= I_FREEING;
> +		spin_unlock(&inode->i_lock);
> +		inode_wait_for_writeback(inode);
>  		destroy_inode(inode);

Again, this doesn't make sense.  This is also a codepath which failed to
make 'inode' visible to any other thread.

I don't understand how this patch could fix anything.
